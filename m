Return-Path: <linux-kernel+bounces-148620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1448A852D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A885283658
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419E1140397;
	Wed, 17 Apr 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD0fiL0X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F713F451;
	Wed, 17 Apr 2024 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361627; cv=none; b=GIBIJNmiat3aUACh/BIsSFhGty2SwETZQjD6Zk8I3iQ3SIjq/iu8XVElONWMkZdeBGRyln38Tn7fGlr8mK1M4w40AK71i7S0EzuyWxSib+SVcghKp7sBY5uyjfnPNEACKCPdvr4wrjsd1/mBrGwUOwuxWYn8Qxy4z6zi/A+4TA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361627; c=relaxed/simple;
	bh=DUxy/imxBqBdg5Gh+AUaXN8SG6ZWyJhrBrb/iBQMZTQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Qpnlc/rrNCWzP/eF8RnwyOskHIcVz5LsB9HeIJ2lawJwMOr3myD2qZSfZjllgKcZ3MraUPIlyIs+grz1ATnjdhYjWHf7DdQnyZCi5W4pmcv/opL/zzvMDqPzamxnpwgxW92uap0GooZaxmNMVz49zdPj/emugxgO2lhjab3cnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD0fiL0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E54EC072AA;
	Wed, 17 Apr 2024 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713361626;
	bh=DUxy/imxBqBdg5Gh+AUaXN8SG6ZWyJhrBrb/iBQMZTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XD0fiL0XH29HnulrmqFq6SVORlyGrEz/tTMwd+xV6QuU3Ee/LBgDmXvaAo90Aljrr
	 r0oLGrfUAGII7kW5VrRQJH+T2iZMLARbz/p5Lgvqs7A11VS2ClCKlPmB8HPcBE+06D
	 amz20Qoa2QHYRVGvWrm/ywKSYkGvZIIrK9LK8PhXeq6sJy1KNXEo7bbaLso+mNZ+OX
	 2z7y69RQtjRwJKdDJelgyzXx/MY/pz5/KD1HRtR+U9T6hSjkzc/fa/TUeHoTOFHm7X
	 dXj8RAXPPRFRH4VvJ9m/BC6kM8+BaiygE3e3bDTkqYxyXqUJPu0jh0mQo9jTgWeaBk
	 ivVQd3hCZEZ8A==
Date: Wed, 17 Apr 2024 22:47:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Francis Laniel <flaniel@linux.microsoft.com>
Subject: Re: [PATCH for-next v2] tracing/kprobes: Add symbol counting check
 when module loads
Message-Id: <20240417224703.c011b4ebbef9e8375450dd39@kernel.org>
In-Reply-To: <20240416004726.792b8158@rorschach.local.home>
References: <171317402290.228024.13465974857683559752.stgit@devnote2>
	<20240416004726.792b8158@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 00:47:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 15 Apr 2024 18:40:23 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Check the number of probe target symbols in the target module when
> > the module is loaded. If the probe is not on the unique name symbols
> > in the module, it will be rejected at that point.
> > 
> > Note that the symbol which has a unique name in the target module,
> > it will be accepted even if there are same-name symbols in the
> > kernel or other modules,
> 
> This says what it does, but doesn't explain why it is doing it.
> What's the purpose of this patch?

Thank you for pointing it out, I just reused the description which I
sent last year. It needs to be updated.

-----
Currently, kprobe event checks whether the target symbol name is
unique, so that it does not put a probe on unexpected place. But this
skips the check if the target is on a module. This fixes the issue
by checking the symbol is unique in the target module if the target
is on a module.
-----

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


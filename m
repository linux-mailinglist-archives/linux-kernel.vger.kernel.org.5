Return-Path: <linux-kernel+bounces-60070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D32184FF7A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F85B2991A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061A22619;
	Fri,  9 Feb 2024 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jZZYKmSZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACBA14F6C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516806; cv=none; b=RjBhd+X5/RdYO5qRN3jtsMTZ0NS1I0atMzURgXn2R3Csi3Fg8nTgcArXASW4HSCUGoZwSsvT4yWrpblgvI/t4xo9FNuQReh/zPZxsxh2XXk7calXBZz8tPoSbdm4p+ZaULOZ+4oP+T+yX6ruyHPFVDWzOIQuneZFdn4ny4TCHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516806; c=relaxed/simple;
	bh=xDYbd+DGzLF4NRgDCcI5oy/Gg3q6BXcvRGOTITka09Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s/NvDt/YnETVp98LfHCIyyrbZrlycrMkzwzrWB39eQMsCcDSv7A8i/4xyBCfWI6T5UBzASUBf3u3YB60tHIM7npo9A3Wl+C6IVKc3/CRvTCRj00tc0Fsz45qJhUtb1sx7vAiBVt0YJlY8mRP519vOsl+jlC1QaUGw3inWBiigyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jZZYKmSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3EFC433C7;
	Fri,  9 Feb 2024 22:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707516805;
	bh=xDYbd+DGzLF4NRgDCcI5oy/Gg3q6BXcvRGOTITka09Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jZZYKmSZwEVkeSNrzlDR/rmu9PIg6eib8zzw63E+9YVy0+ptXVUMMNZgN29G3b3tJ
	 dtdMHi8RdCi30sdnA3CJ4rie0jgstN9FqPdcn1oHtARMbtbOMa34GCjjLB6WVKn1mE
	 SXc0T/75Fv/GWI74oE7HEcx5Ll1zfrfnw2+lwMbo=
Date: Fri, 9 Feb 2024 14:13:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, fuyuanli <fuyuanli@didiglobal.com>
Subject: Re: [PATCH] kernel/hung_task.c: export
 sysctl_hung_task_timeout_secs
Message-Id: <20240209141324.28cae36fe14c909058c1fed7@linux-foundation.org>
In-Reply-To: <20240209070935.1529844-1-kent.overstreet@linux.dev>
References: <20240209070935.1529844-1-kent.overstreet@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 02:09:35 -0500 Kent Overstreet <kent.overstreet@linux.dev> wrote:

> needed for thread_with_file; also rare but not unheard of to need this
> in module code, when blocking on user input.

I see no bcachefs code in linux-next which uses this.  All I have to go
with is the above explanation-free assertion.  IOW this patch is
unreviewable.

> one workaround used by some code is wait_event_interruptible()

examples?

> - but that can be buggy if the outer context isn't expecting unwinding.

More explanation of this?

> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -43,6 +43,7 @@ static int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
>   * Zero means infinite timeout - no checking done:
>   */
>  unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
> +EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);

It seems strange that a module wouild want this.  Makes one wonder what
the heck is going on in there.



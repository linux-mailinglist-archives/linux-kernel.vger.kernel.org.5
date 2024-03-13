Return-Path: <linux-kernel+bounces-102291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F217787B03B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DEC1C268D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F64657CE;
	Wed, 13 Mar 2024 17:43:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D356440;
	Wed, 13 Mar 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351823; cv=none; b=tc3NGzYjA2dtHPEdjI9WEazkMujE1SXTGsTYu1/zzJn52MJPdlC7H2IhowxXCywJvgGEHlBtnSxNGIort7p/IGk5qNMXhUyr38GuX2ofHhvoLQNn8qu7W7Vmygk97EF3xHSZic+aYn/DSO4OtyWVKzxcTNlnu6kSZR+9kwJnVnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351823; c=relaxed/simple;
	bh=lEfOSkBx/BgBbYhtTXBfO/JgZ5df4DjqaraiwmcYBiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSkbY++hg93qpvY0r5yIQINEkvJ8PUBB/VU450GcJYuU7JmCNamTmIIDvuwPcqFr5MyBfrJvR0XwN9MZff9n/PFEEO+N9NngA1XR28TY2bJ44uro0I6bDe2N/rAF0nhD0E6XZCdoUdwKSLxOhMRYmzWorQnPxNqXihMdO9E2Imc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D370C433C7;
	Wed, 13 Mar 2024 17:43:41 +0000 (UTC)
Date: Wed, 13 Mar 2024 13:45:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kernel test robot <lkp@intel.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] tracing: Use strcmp() in __assign_str() WARN_ON() check
Message-ID: <20240313134550.68a11319@gandalf.local.home>
In-Reply-To: <20240313165903.GA3021536@dev-arch.thelio-3990X>
References: <20240312113002.00031668@gandalf.local.home>
	<20240313165903.GA3021536@dev-arch.thelio-3990X>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 09:59:03 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202402292111.KIdExylU-lkp@intel.com/
> > Fixes: 433e1d88a3be ("tracing: Add warning if string in __assign_str() does not match __string()")  
> 
> Is this change destined for 6.9 or 6.10? I applied it to current
> trace/core (eb1533d156d3) along with 51270d573a8d but the warning is
> still present. I even tried
> 
>     __builtin_choose_expr(__is_constexpr((src)),
>                          strcmp((src), __data_offsets.dst##_ptr_),
>                          (src) != __data_offsets.dst##_ptr_));
> 
> but not even that silenced the warning. I think we will still need a
> diag directive to fully silence this warning.

Yes, you said that the warning is still there, but the bug it shows should
not be.

I believe that's because clang still evaluates the (src) != ... even when
the source is a contast and it warns about it. But if src is a constant, we
do not want to do the !=, we want to do the slower strcmp().

Let me test to make sure that when src is a string "like this" that it does
the strcmp(). Otherwise, we may have to always do the strcmp(), which I
really would like to avoid.

BTW, I triggered another bug with strcmp():

  https://lore.kernel.org/all/20240313093454.3909afe7@gandalf.local.home/

-- Steve


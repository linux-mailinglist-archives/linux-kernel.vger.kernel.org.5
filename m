Return-Path: <linux-kernel+bounces-85851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0A986BC3B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B681F21D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEE071EA1;
	Wed, 28 Feb 2024 23:33:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376DC13D2FA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163185; cv=none; b=pJol25tyqo8vsqhgUFpQVnA5xhkNZ+sJXi8XKEpP4mpqX6HPr4gyoeyBKh0XnhT90F9NLGS/CKxK/ie37iPF9j6NIzxyRkxs90iVqMFJgXLl94OqnxZMhaZmw0HUxWV+wiUhDUQTy72PIY5pmZMMrukoBws4PK8woR+jo+yaIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163185; c=relaxed/simple;
	bh=fmyNSUcPVp9b3i6F509Z6PDdFlXhI3KhBOJlRENZKog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ro1c/ZLA0xJBFh/e3epcSw+w/zod9746dnmcjn2LkrlioiS7fR93w70axE1tBd52RmRxs7lRAJ2GNYbjb7Yia0oddhsGVcauCmHE8+YDMww2VQ17Y5mPoQOwP2D+F7WWkLTJH7tXHBuQIUtH6oTib9gvFZsxxyIQx9dPp6sDO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A27C433F1;
	Wed, 28 Feb 2024 23:33:03 +0000 (UTC)
Date: Wed, 28 Feb 2024 18:35:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Vince Weaver <vincent.weaver@maine.edu>, Dave Jones
 <dsj@fb.com>, Jann Horn <jannh@google.com>, Miroslav Benes
 <mbenes@suse.cz>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>, Nilay Vaish
 <nilayvaish@google.com>
Subject: Re: [PATCH v2 06/11] x86/unwind/orc: Convert global variables to
 static
Message-ID: <20240228183507.78c5f130@gandalf.local.home>
In-Reply-To: <43ae310bf7822b9862e571f36ae3474cfde8f301.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
	<43ae310bf7822b9862e571f36ae3474cfde8f301.1587808742.git.jpoimboe@redhat.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2020 05:03:05 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> These variables aren't used outside of unwind_orc.c, make them static.
> 
> Also annotate some of them with '__ro_after_init', as applicable.

So it appears that crash uses "lookup_num_blocks" to be able to do
back-traces with the ORC unwinder. But because it's now static, crash can no
longer do that.

Is it possible to make lookup_num_blocks global again?

/* Not static so that the crash utility can access it */
unsigned int lookup_num_blocks __ro_after_init;

-- Steve

> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  arch/x86/kernel/unwind_orc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index e9cc182aa97e..64889da666f4 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -15,12 +15,12 @@ extern int __stop_orc_unwind_ip[];
>  extern struct orc_entry __start_orc_unwind[];
>  extern struct orc_entry __stop_orc_unwind[];
>  
> -static DEFINE_MUTEX(sort_mutex);
> -int *cur_orc_ip_table = __start_orc_unwind_ip;
> -struct orc_entry *cur_orc_table = __start_orc_unwind;
> +static bool orc_init __ro_after_init;
> +static unsigned int lookup_num_blocks __ro_after_init;
>  
> -unsigned int lookup_num_blocks;
> -bool orc_init;
> +static DEFINE_MUTEX(sort_mutex);
> +static int *cur_orc_ip_table = __start_orc_unwind_ip;
> +static struct orc_entry *cur_orc_table = __start_orc_unwind;
>  
>  static inline unsigned long orc_ip(const int *ip)
>  {



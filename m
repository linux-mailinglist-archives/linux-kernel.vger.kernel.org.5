Return-Path: <linux-kernel+bounces-3244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF068169CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B16283849
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0411C9B;
	Mon, 18 Dec 2023 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA220P5B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620F1170B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8166AC433C8;
	Mon, 18 Dec 2023 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702891501;
	bh=cO07dxNW1PUmAXiXVsm47VunUdfatHSRsSDDVCHJ6wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rA220P5BlJTSEX3Psx00JnQIFYvldI3rP2MKQwj21FcBWOwzOLIW6Rv6Vg0pJT6jt
	 b8SoUrqgHea+y4/ntqMhux0XUjNt+1ZS/8HEXaZtJuGXyXSuYp3iAQ1phrJb0pkDXH
	 pU7Z/4Ig7WdUHybk8YRHNlYX5m5o8Od8Xwm76FQHaKzSGrCHKDCnJi3NtRj6KDzB+l
	 gi+nKIj1KDBVS10wDuBD5rBzHdB//2G7UHy79v3n5OvKrnoHNFF84FI267k2wkQbWO
	 mXEdBvJZM/22gvePtaqVkv8XzX065dNGMImdmlTMHD73Kek70k+6x/Py3+7mj3aesj
	 1enb0BCuJctdQ==
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu
Cc: luming.yu@gmail.com, ke.zhao@shingroup.cn, dawei.li@shingroup.cn,
	shenghui.qu@shingroup.cn, Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [PATCH v1 2/2] powerpc/debug: hook to user return notifier
 infrastructure
In-Reply-To: <B375A36C9C4D73FF+20231218031338.2084-1-luming.yu@shingroup.cn>
References: <B375A36C9C4D73FF+20231218031338.2084-1-luming.yu@shingroup.cn>
Date: Mon, 18 Dec 2023 14:54:53 +0530
Message-ID: <8734vzsw0q.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luming Yu <luming.yu@shingroup.cn> writes:

> Before we have powerpc to use the generic entry infrastructure,
> the call to fire user return notifier is made temporarily in powerpc
> entry code.
>

It is still not clear what will be registered as user return notifier.
Can you summarize that here?

>
> Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> ---
>  arch/powerpc/kernel/interrupt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index c4f6d3c69ba9..7fe704946e96 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -19,6 +19,7 @@
>  #include <asm/time.h>
>  #include <asm/tm.h>
>  #include <asm/unistd.h>
> +#include <asm/entry-common.h>
>  
>  #if defined(CONFIG_PPC_ADV_DEBUG_REGS) && defined(CONFIG_PPC32)
>  unsigned long global_dbcr0[NR_CPUS];
> @@ -245,6 +246,8 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
>  	/* Restore user access locks last */
>  	kuap_user_restore(regs);
>  
> +	arch_exit_to_user_mode_prepare(regs, ti_flags);
> +
>

That will run the notifier with user AMR/IAMR values. 

>  	return ret;
>  }
>  
> -- 
> 2.42.0.windows.2


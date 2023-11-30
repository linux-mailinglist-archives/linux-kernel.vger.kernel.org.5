Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6590D7FFB39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376385AbjK3TZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376372AbjK3TZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:25:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38BD48;
        Thu, 30 Nov 2023 11:25:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-33318b866a0so1148419f8f.3;
        Thu, 30 Nov 2023 11:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701372348; x=1701977148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10qZWkdRxInBxqMWCHUd/fv2xFmke4NCj5l1NxkbtEs=;
        b=WW+AHOq6o2PegiMI/kmyoE1H2fgfnFeIkVv5lnDqVHw3NYo5rGpK+uvS014J0FTdsp
         BHIvDV43Pag+V2L3FkPD7oVEajp7LjJgk3D3LDgXh1LV09xCdRTOUWC17nK+a+cKit8n
         I9RGeXPHUmzRIQhYyJyS9J+u5jPgM8FJaig5j5Sp1scIpSfRhyoUp0zvmLwV8B37KaSN
         gKczwLcN/BeWs/RktuyHR6quYc8ltXJ3bQdSBQdDtW3Trmh1vUDWiYx31jo1ol9ElIxE
         OK8o2XE8t7i2t6NlrLkjk4L4cmzLGbAzhsFDGi/Aa0QEPnOwxFnDZgGwej4kjHddaG72
         V5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701372348; x=1701977148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10qZWkdRxInBxqMWCHUd/fv2xFmke4NCj5l1NxkbtEs=;
        b=qqQ4sMWTxrVwGinsbX14pyZ4BpaCwFMfAbgpBrZZV6A6fa2OyUGqI/paffqda6pnRS
         5NWHKTbjmc/rLVQjEvwbqY8+ma9QUZwWzztB8BVWWybH2UVQp/3KU44hwQjYluEVFuBM
         XQTA1ooUeoi/Jjs2GqT38gPRU8eagzIiBVLf26z4CEDe3yznkbL67/jrklkhKzJymWCs
         U4CRciqe3u2PB+2l5M8/SjmaefJhD/NrCom2RDvI2docfHixtVotNsFzpRzkufDsvQMJ
         95wwLVhcOnudO7qeeR2yrMTOIW3l72cSMPIjG0DWy1SsSnU9kgWUfYccoKM0nJOdmIj0
         kNBA==
X-Gm-Message-State: AOJu0YyF2dSQ8ZuADkqccqg96IPYCzwcc+7xyVCymWU4sLGrh3fdQBnm
        C9YgVtQvu2lRX2LOzs4Vamc=
X-Google-Smtp-Source: AGHT+IEH/ASMOK9ojYkCxLJwyFhlciYNcpI0mOvc0B8iSEhUCqo8N/OtyviEdQtKY/v5ofK5Et/XGg==
X-Received: by 2002:a05:6000:b82:b0:333:2fd2:4afd with SMTP id dl2-20020a0560000b8200b003332fd24afdmr13204wrb.121.1701372347885;
        Thu, 30 Nov 2023 11:25:47 -0800 (PST)
Received: from gmail.com (1F2EF126.nat.pool.telekom.hu. [31.46.241.38])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d584f000000b003331c7b409asm2301846wrf.78.2023.11.30.11.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:25:47 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 30 Nov 2023 20:25:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86: stop shipping a.out.h uapi headers
Message-ID: <ZWjhuePji8CpFDbv@gmail.com>
References: <20231123180246.750674-1-dimitri.ledkov@canonical.com>
 <20231123180246.750674-5-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123180246.750674-5-dimitri.ledkov@canonical.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dimitri John Ledkov <dimitri.ledkov@canonical.com> wrote:

> Stop shipping a.out.h uapi headers, unused.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  arch/x86/include/uapi/asm/a.out.h | 21 ---------------------
>  1 file changed, 21 deletions(-)
>  delete mode 100644 arch/x86/include/uapi/asm/a.out.h
> 
> diff --git a/arch/x86/include/uapi/asm/a.out.h b/arch/x86/include/uapi/asm/a.out.h
> deleted file mode 100644
> index 094c49d8ea..0000000000
> --- a/arch/x86/include/uapi/asm/a.out.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef _ASM_X86_A_OUT_H
> -#define _ASM_X86_A_OUT_H
> -
> -struct exec
> -{
> -	unsigned int a_info;	/* Use macros N_MAGIC, etc for access */
> -	unsigned a_text;	/* length of text, in bytes */
> -	unsigned a_data;	/* length of data, in bytes */
> -	unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
> -	unsigned a_syms;	/* length of symbol table data in file, in bytes */
> -	unsigned a_entry;	/* start address */
> -	unsigned a_trsize;	/* length of relocation info for text, in bytes */
> -	unsigned a_drsize;	/* length of relocation info for data, in bytes */
> -};
> -
> -#define N_TRSIZE(a)	((a).a_trsize)
> -#define N_DRSIZE(a)	((a).a_drsize)
> -#define N_SYMSIZE(a)	((a).a_syms)
> -
> -#endif /* _ASM_X86_A_OUT_H */

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

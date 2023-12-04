Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2990802A77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 04:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjLDDBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 22:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 22:01:47 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A992E5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 19:01:52 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce403523e5so162597b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 19:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701658912; x=1702263712; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=CQYiiiRLontcDI44whmeD/LoEJVxuqfkBiryqv/zBTg=;
        b=q3DwEmB4PoXI90W8n4dpmreCIn3QymFrI+vnck8BQ4dZsXgYzdXpJMmLdCZsaQ6W/D
         cCuK7B29+4/j/SkY/E+9CTj9nzcV0g2DJ5jYfDlkyQ+Ovvj1Am9zG3tQH0rtpapkcr1h
         jAwkf0pAEEkKC8bGb4InCLPTPtxTR1y+i7Uc/7KHnIieKwTm64vsRpjyd3APhjoiBaBO
         ULZjb7JIafyeidTMh58sJPA/6HZysYsXrcLxEPfmTZpWPDzC7cgpN60Zn/w/U9YJQf3Z
         ktGaDBSOto0r54hhNHk1gVGqZgPEcQcsRm/RNwTMI6xA6LplPnjn9zVvxD5/pB65rjb3
         9eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701658912; x=1702263712;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQYiiiRLontcDI44whmeD/LoEJVxuqfkBiryqv/zBTg=;
        b=fbxfFpPkIueJxoOz7lnXKyzgaEQGuP7SMIgsmLoSP+xTHqTgcusiDjkgBYr35gAI58
         ZvF9/v/h3mnK+dqC2gSUUgX/39+od3V3KaDeaxSgjvZRjdNF7nei/T6DuJPjl7LiVCxN
         RLpYLJtXzqMmDTnTRX16OkQc/dtD91QPALwOrRvh2baDyiMLcF2yZIMn3+6sP4vBw2kt
         9Gf5Tbhq+XN8qqk5j6p5ytE8NCsmMtpeLuVOpWtfpgxE4uOhCIWHTzMaWjxOQl6ZjFP+
         OS6iwyhq7qgoH7pubU21zz3AmtQvjt0uxeluIl6gn+Hfa7gxQnIlf/m8XNUd0t77w3Jk
         HmYw==
X-Gm-Message-State: AOJu0Ywz6PcWyOSdmtQXYt4Z3Om8Q23J89PIXBb8BostKHQq6B81ZSRJ
        YCJPLrYHENwyUUBH0Ceqc4vFFA==
X-Google-Smtp-Source: AGHT+IHFLJUBmtnWAvysao8TWHQlyk2Cfpox9jD8bkyNgUP4wKyxIxGZHkfjhvm//XUEUavLfPd53A==
X-Received: by 2002:a05:6a20:748f:b0:18c:8fef:22cc with SMTP id p15-20020a056a20748f00b0018c8fef22ccmr1035248pzd.24.1701658911982;
        Sun, 03 Dec 2023 19:01:51 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:979a:226c:de55:73de])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78818000000b006cd88728572sm6562301pfo.211.2023.12.03.19.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 19:01:51 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-13-201c483bd775@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From:   Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 13/39] arm64/mm: Map pages for guarded control stack
In-reply-to: <20231122-arm64-gcs-v7-13-201c483bd775@kernel.org>
Date:   Mon, 04 Dec 2023 00:01:49 -0300
Message-ID: <87a5qqisbm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Mark Brown <broonie@kernel.org> writes:

> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index 645fe60d000f..605d4e6edc1d 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -79,9 +79,20 @@ arch_initcall(adjust_protection_map);
>  
>  pgprot_t vm_get_page_prot(unsigned long vm_flags)
>  {
> -	pteval_t prot = pgprot_val(protection_map[vm_flags &
> +	pteval_t prot;
> +
> +	/* If this is a GCS then only interpret VM_WRITE. */
> +	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
> +		if (vm_flags & VM_WRITE)
> +			prot = _PAGE_GCS;
> +		else
> +			prot = _PAGE_GCS_RO;
> +	} else {
> +		prot = pgprot_val(protection_map[vm_flags &
>  				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
> +	}
>  
> +	/* VM_ARM64_BTI on a GCS is rejected in arch_valdiate_flags() */

s/valdiate/validate/

>  	if (vm_flags & VM_ARM64_BTI)
>  		prot |= PTE_GP;


-- 
Thiago

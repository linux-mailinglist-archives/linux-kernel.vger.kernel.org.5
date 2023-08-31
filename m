Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7832178F462
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbjHaVLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjHaVLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:11:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F8FF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:11:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso9215885ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693516293; x=1694121093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7dUKYliv44b3AsUkrxKZU9Dl2smVtemNsJiOsG2xZs=;
        b=B1P7Ex3lPUAwB/AG1XXtWedECXnaLpgHLal2yGnhmqxSK6aiznZfEp9RFO8Ff5kW4w
         jFSMekUYtBsD/AZtzgE6HPkEfmuuK5CloaTxkWRyDPT+bItuaBYa6leNjwy/5ScedxU3
         xoQ+w5Nz1FY4uLTHZ3XHE0n3uitgsLroVX55I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516293; x=1694121093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7dUKYliv44b3AsUkrxKZU9Dl2smVtemNsJiOsG2xZs=;
        b=Qxx7mQj5V48/695z9ytlLwsO6JqWH3QhuGXd6S9QGkWNuRP8l7KBniu+3Enkowv3pO
         1Sershv2bLrRoZxhSf837geTvfL0EG3U/VH+Hyi/+MzKKfvenIMVXzMxsJ/m6+2uGJ/r
         Q5tnbz9sw25qA4oVIiZgMlKljneLgoCCpEhZRka5LEafky5Ro6cLMqH1B9GJWx+H938f
         /2aB0n1TBZcDGJW10G438W9DNydxQFQePcx1Gdo73th4nylbNg/yn6++d4ZMJUPgQhsA
         QMwUjsgQ7aBOXcRTT+KDCqQFXST5CHQw5sKFbPT9zSh2ZNQfUhbdUWvfWjVF1ePPfIzI
         RKEg==
X-Gm-Message-State: AOJu0YwucnTZs/+cPAFXiDw4DIAchdzmhrf509ZVZkqCfvnWoPlW8jLS
        jXUPIeWeoYztCA1Xk2iFoEPFkg==
X-Google-Smtp-Source: AGHT+IGFhve9DdqY/FIGfRfdxXwMmLQMfU4H71C+b6tM33APIuAtiILWfwhdOy2FlXpJItVTQWPMTQ==
X-Received: by 2002:a17:903:446:b0:1c0:6dcd:4540 with SMTP id iw6-20020a170903044600b001c06dcd4540mr779696plb.32.1693516293522;
        Thu, 31 Aug 2023 14:11:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jg7-20020a17090326c700b001bbb1eec92esm1649265plb.281.2023.08.31.14.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:11:33 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:11:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] x86/audit: fix -Wmissing-variable-declarations warning
 for ia32_xyz_class
Message-ID: <202308311409.F4EC8BC674@keescook>
References: <20230829-missingvardecl-audit-v1-1-34efeb7f3539@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829-missingvardecl-audit-v1-1-34efeb7f3539@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:33:16PM +0000, Justin Stitt wrote:
> When building x86 defconfig with Clang-18 I get the following warnings:
> | arch/x86/ia32/audit.c:6:10: warning: no previous extern declaration for non-static variable 'ia32_dir_class' [-Wmissing-variable-declarations]
> |     6 | unsigned ia32_dir_class[] = {
> | arch/x86/ia32/audit.c:11:10: warning: no previous extern declaration for non-static variable 'ia32_chattr_class' [-Wmissing-variable-declarations]
> |    11 | unsigned ia32_chattr_class[] = {
> | arch/x86/ia32/audit.c:16:10: warning: no previous extern declaration for non-static variable 'ia32_write_class' [-Wmissing-variable-declarations]
> |    16 | unsigned ia32_write_class[] = {
> | arch/x86/ia32/audit.c:21:10: warning: no previous extern declaration for non-static variable 'ia32_read_class' [-Wmissing-variable-declarations]
> |    21 | unsigned ia32_read_class[] = {
> | arch/x86/ia32/audit.c:26:10: warning: no previous extern declaration for non-static variable 'ia32_signal_class' [-Wmissing-variable-declarations]
> |    26 | unsigned ia32_signal_class[] = {
> 
> These warnings occur due to their respective extern declarations being
> scoped inside of audit_classes_init as well as only being enabled with
> `CONFIG_IA32_EMULATION=y`:
> | static int __init audit_classes_init(void)
> | {
> | #ifdef CONFIG_IA32_EMULATION
> | 	extern __u32 ia32_dir_class[];
> | 	extern __u32 ia32_write_class[];
> | 	extern __u32 ia32_read_class[];
> | 	extern __u32 ia32_chattr_class[];
> | 	audit_register_class(AUDIT_CLASS_WRITE_32, ia32_write_class);
> | 	audit_register_class(AUDIT_CLASS_READ_32, ia32_read_class);
> | 	audit_register_class(AUDIT_CLASS_DIR_WRITE_32, ia32_dir_class);
> | 	audit_register_class(AUDIT_CLASS_CHATTR_32, ia32_chattr_class);
> | #endif
> | 	audit_register_class(AUDIT_CLASS_WRITE, write_class);
> | 	audit_register_class(AUDIT_CLASS_READ, read_class);
> | 	audit_register_class(AUDIT_CLASS_DIR_WRITE, dir_class);
> | 	audit_register_class(AUDIT_CLASS_CHATTR, chattr_class);
> | 	return 0;
> | }
> 
> Lift the extern declarations to their own header and resolve scoping
> issues (and thus fix the warnings).
> 
> Moreover, change __u32 to unsigned so that we match the definitions:
> | unsigned ia32_dir_class[] = {
> | #include <asm-generic/audit_dir_write.h>
> | ~0U
> | };
> |
> | unsigned ia32_chattr_class[] = {
> | #include <asm-generic/audit_change_attr.h>
> | ~0U
> | };
> | ...

I would expect checkpatch to warn about bare "unsigned", which is frown
on these days. :) I think __u32 should be fine here...? (Why is it __u32
instead of u32, btw?)

But otherwise, yes, looks good.

-Kees

-- 
Kees Cook

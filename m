Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8206C7B0961
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjI0Pwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjI0Pw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:52:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A718A5C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:42:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso874677966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695829335; x=1696434135; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJX6uCAXlp8YiM1mzBPWE9EjoeKjHDxFPb16xjkTeog=;
        b=cUjZXIRxlhtznyDonZLSGZt1auu34ENgNaschCAaOMCKn3W18JgMpGvoFRSGILJP5j
         eAzxyZQQ3kR13RCl/4uREa0WWzinngzFCVRCy16jJzA3RT1zCQALYmi502bElgSuKRG2
         Mm7UzcGQhwjUsfrPUcRuksrvOn/6RJEq5iNz9U83Vfe8Cq0OtRHm3yiN4umDEkE+Zmva
         uDgubAO+j7XMTnAuwnwfChW1s/OMgf9SgwCPWKtcbhJftdxuIxpmvP7EwQRAdIq7jdso
         +y4uAmUhj6X29MXI7c2S9dk/9gyCjzYmpOwdCQK4aBK+5MxYJQK6PiC4+71rdldjsuxT
         VpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829335; x=1696434135;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJX6uCAXlp8YiM1mzBPWE9EjoeKjHDxFPb16xjkTeog=;
        b=k2Nif8gFt9pCr6dHJamHesk+wLiYEmcSUd7fn3vhfRxzG1DMuoJDlE483f3o0o3CHX
         7Z+tLLpTFuy3uOAJr6dztWJWUYiGuK8mr69KHS/RueOLXL5uePeD0atRACmiYsNnyPyM
         jexl0ZJkI/r8UhdFXt9QbSTihN+Z66CLZGXzUmhmpu5jaJRvlTe9Af9zI6hQxULApMGI
         oMHtgBMBc+BGoJneCyCBjb/Xls2DsQUtl4Rfa5UXIslMGKb4Z56poylbOz8aDVHwNXvo
         MZStG389YViUzOOart1yGfP8w2rjeg4rmpdEyUralQvJ8US62fTNYD20RPdxm7Ript7m
         YAnQ==
X-Gm-Message-State: AOJu0Yy2qQXLq1cEIqx7tH3fOHHRLIfpYZ0c3IzPNV3wIOXJP4PfE+9u
        6Ixt69fIAIAOGB8We3cJ9KYUS9w7AQ==
X-Google-Smtp-Source: AGHT+IG1SDKWtAg8FvUkCtnL5hXdKNWTHpnvqaVi3MgY9ufEQQZI+EToD2lcmH104cs4K+SPGGEIvg==
X-Received: by 2002:a17:907:788d:b0:9a5:a701:2b90 with SMTP id ku13-20020a170907788d00b009a5a7012b90mr2078170ejc.40.1695829334449;
        Wed, 27 Sep 2023 08:42:14 -0700 (PDT)
Received: from p183 ([46.53.250.251])
        by smtp.gmail.com with ESMTPSA id cb8-20020a170906a44800b00988dbbd1f7esm9411126ejb.213.2023.09.27.08.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:42:13 -0700 (PDT)
Date:   Wed, 27 Sep 2023 18:42:11 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: compile boot code with -std=gnu11 too
Message-ID: <2058761e-12a4-4b2f-9690-3c3c1c9902a5@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use -std=gnu11 for consistency with main kernel code.

It doesn't seem to change anything in vmlinux.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -43,7 +43,7 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
+REALMODE_CFLAGS	:= -std=gnu11 -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)

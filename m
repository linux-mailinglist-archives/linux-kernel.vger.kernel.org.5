Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2DE7EC9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjKORhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjKORhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:33 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACFF1BC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:29 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-779fb118fe4so433073785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069848; x=1700674648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsKN0vAWTPkRoeR+0eW+M/Vw4EKK+fkuLodskFQx/7g=;
        b=Wu+HWNRJP1QjHx24kqcqFNFJCVp93WItLBa+xA7hYcTXz5WmGggUg9mPoYBL8sjgXa
         a2t6J//qXG5k21HdhLWhjaguy7okJtzL061xu/u39SK9ID/kb9Vc1LiTuEgoTuMRYtcB
         mxRpotpf7Kb83TwMgjpJ9sx8UDhEWrZfxBB7kl+04JB4xc2WFCv5CsS/0Q8IFKp8h8sN
         EHQdHT6zU0plpk6Y2Vz2vE2A10IcqGAm+apYWgVUxjXZNDlzivpIN2HTC/5EF1EFR55R
         wo6dMSgQVLpfQWMaDSSyFX4R+dNuqNVZB86LCODvUcHNyPaY5XIehzlmjUZKIr9Nrj30
         xaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069848; x=1700674648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsKN0vAWTPkRoeR+0eW+M/Vw4EKK+fkuLodskFQx/7g=;
        b=m/eNDQWx/INaONHUHWYPkb84xWMdnJFIKrZ9cx+rQPWgnUHUxxY/bqXDH/EqY3EdPu
         +Nbx6EhhIghIahftoOcQglH4EGPBFAh+GPhCT/itCOLX13J6ze30au2YgvYWeF0cZiNq
         iZ3DY6YWaMMFSRvqJorzx+H/Chyy2pitO9bKa55jFLN4OJ74GwZAPyitGc+76dxAZOHC
         hjdebfvamXo4ffN749kxKuUTFVwEvTHsGnaUqeNR6SmvF0UPe327q9+3V0V3El0DvMGs
         nWaRd2do6NsGh1rbraW/TCpu8XAIdO7+Oc340FZOZRS1G9OaXKuBAIUcti0xKXVqXMpN
         jL4w==
X-Gm-Message-State: AOJu0YxJLxYNJDfdus2onDaWbSYeF6gHVJzNsreH9SmIsurspnBADYAp
        ZvRzL8NsjuigsrgRboks/cciKA3MNQ==
X-Google-Smtp-Source: AGHT+IGwig5qnejJPIdhkdSJOCxU62M+zRKtaqk3xMO3i4imN2kV5NiZ6RaML1EpS177QvcfBXiOcg==
X-Received: by 2002:a05:620a:6409:b0:779:d143:c1a7 with SMTP id pz9-20020a05620a640900b00779d143c1a7mr6814784qkn.26.1700069848097;
        Wed, 15 Nov 2023 09:37:28 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:27 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 03/14] x86/boot: Disable stack protector for early boot code
Date:   Wed, 15 Nov 2023 12:36:57 -0500
Message-ID: <20231115173708.108316-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit, this will prevent crashes when the canary access is changed
from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses from
the identity-mapped early boot code will target the wrong address with
zero-based percpu.  KASLR could then shift that address to an unmapped
page causing a crash on boot.

This early boot code runs well before userspace is active and does not
need stack protector enabled.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..aff619054e17 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -39,6 +39,8 @@ KMSAN_SANITIZE_nmi.o					:= n
 KCOV_INSTRUMENT_head$(BITS).o				:= n
 KCOV_INSTRUMENT_sev.o					:= n
 
+CFLAGS_head32.o := -fno-stack-protector
+CFLAGS_head64.o := -fno-stack-protector
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
-- 
2.41.0


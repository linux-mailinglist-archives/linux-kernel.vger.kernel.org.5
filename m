Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC3811996
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjLMQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjLMQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:34:41 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC918E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:34:47 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-59148c1ad35so896099eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702485286; x=1703090086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BedbEWmRacBYzD0wQWifX46MEGXhKaAmxHcLI5XJHA4=;
        b=bQa8b0ndvvAE4zbeUC+nlLxOl3Ya4GJyVz8Zvu+FAtALaSs0gJBXT+QueJH1nbgM0v
         x+KIstKcCjxF/rVbznV36Hfp0D6Ui7Rtp9eUwFPxQIFywpeZcWAQu7RKHKncvC0UoNno
         h3/YX5HQKPaA1JPqdxoK2fWzO7MF/veGug2QG5Ul0vLLMc3peRkJJfRD6d6pwiPowJU2
         TA4wvPkzTGJDoDxPsn32xCqjXHK71+FOIXfbUebK73JCGhO90lyAhvQH1odlEebfcDN8
         G2T1by1MRRifhmo2xhfiFI2L7mhqmkh1OFuHZZLmy7TVh/2ZSJLNE/A6EOr5+Gg7Q1IJ
         xBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485286; x=1703090086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BedbEWmRacBYzD0wQWifX46MEGXhKaAmxHcLI5XJHA4=;
        b=ZNSplnQX0cdfV5Q4ysjuIw26nOzhVr/MeKnN/mA88ol/9196h6QyRYebt6xsLaBBNr
         aTOnqYqAM6WWN2Tvpjl81kFfig5N2sVJt2r7aITS6dqafcAN0gGADK6nKfTjVRulZuaX
         kuVjbKljiLVNIDvGPPyOZano32tPNGLHdCyRqu5V/eOBiaRdmug6zfJ+yttPkMOXS09L
         mq7FzspAou960sshP3cf+vDeElFA4WcWQ5mtVxF3zpVJAd8eTrzDEkdALCSLtcF7YCzE
         R6VA4Ns4O5+p527ZACZWWtUvELwiy0+S6uGBbi97X+wEhJwbpPDw5PGR3gMJVXMeEkbo
         3lsA==
X-Gm-Message-State: AOJu0YyWhS5YhLffM6FOtZXqdT5w0AVJ8i04c9pARfugaReqb27//huz
        rwRZxh1CXUrXzC2WLIIgpg7rQDntBA==
X-Google-Smtp-Source: AGHT+IFrQQY30G9AcP5V0Yk+InY1bpqU1Yq3WEQT8iNi+l8l4I9n9Vdk7vm1B1EjjIz1LSXyaQtxvA==
X-Received: by 2002:a4a:e803:0:b0:591:54bc:43a0 with SMTP id b3-20020a4ae803000000b0059154bc43a0mr835052oob.2.1702485286514;
        Wed, 13 Dec 2023 08:34:46 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j11-20020a4ad2cb000000b005907ad9f302sm3104901oos.37.2023.12.13.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:34:46 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/3] Reject setting system segments from userspace
Date:   Wed, 13 Dec 2023 11:34:40 -0500
Message-ID: <20231213163443.70490-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Michal noted[1] that on systems that support UMIP, the instruction
decoder can be tricked into leaking the address of the TSS or LDT by
using ptrace to set the SS segment to a system segment index.  Prevent
this from happening by rejecting attempts to use a system segment in the
ptrace and sigreturn syscalls.

[1] https://lore.kernel.org/lkml/20231206004654.2986026-1-mhal@rbox.co/

Brian Gerst (3):
  x86: Move TSS and LDT to end of the GDT
  x86/ptrace: Reject system segements
  x86/sigreturn: Reject system segements

 arch/x86/include/asm/segment.h | 44 ++++++++++++++++++++++++----------
 arch/x86/kernel/ptrace.c       | 12 ++--------
 arch/x86/kernel/signal_32.c    |  4 ++++
 arch/x86/kernel/signal_64.c    |  4 ++++
 4 files changed, 42 insertions(+), 22 deletions(-)


base-commit: 3d626e0a7be7ddb635791fee18cb40631bc1d0b3
-- 
2.43.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0809D75CD66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjGUQKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGUQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:10:45 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B772A3592
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:40 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4039f7e1d3aso17432201cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955839; x=1690560639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=timtvy/ZgJHBSalkwoR7FMzJpYWzvYaEK+8pGoIzPrc=;
        b=OT/31xBDBJJm0IeZ+M3IDRbHd6zlPalkDJFVQTVxIyWSFPbFrRwPJRQZjHNpOMJcEl
         3KlBhybdSYkLgzvwduacu+Js3tBex4ABGpfhM1HCRJ6YtWwYls4Wc0DdTIt49g7QbVGE
         mqYp8FBO5/lHgdATYM4aUJjc0QrFf0IK70qdmTJc/JLztD4RkTJ3ZENZL/K88wu+Catk
         AIKf/uQ58vHfCfEh8EuOQxX2WCAemoe3c1HzlgqR3LA3hg0SbxRSNQC9mHF6Sm6ZoYbh
         knTpTAdylkbQNihmnGUwHakICuHnYNBhFJCW62SevQk8S73N2+qd6YuQa6lH8JAnZdr6
         Pozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955839; x=1690560639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=timtvy/ZgJHBSalkwoR7FMzJpYWzvYaEK+8pGoIzPrc=;
        b=E4DKLrkAHcWf5XDgsmPAaEsfJQy9Qn5/GyaivHxfbDlbxKTIxRtnTu817Dx+5kQxOs
         H4bpTLC8WjFwEEDCWO97KjkIx1eCCbb6p6991IwBjlNdHChphzey13u9XckupuLajtgr
         DPwk/adeYAD08ySQUfcaHiXcxWOF190mfDLNgI5Dwx8aD11aKdd91FXVVJzH1fkaaxAY
         lePf8tT7+iiyeNwrJ0EacncQmOCeY/dfGGt9//vOwOh/ntXqZ43y3Q+iGnQUfnOCY9yl
         aNjPWjFUTo8HcHR6/bAK2MhkRT6cNGfO/jOVa6fctkO6sSaR/ZiPvo1fIH4W+ubMtvHI
         XeEQ==
X-Gm-Message-State: ABy/qLbopXnuNJCdDD1maj/nHEff9Ai6uBHhA8YEj2/1Hz1G81Wm4jWP
        oNDDCndOsNMxcU8lNXhd/eegkncDyQ==
X-Google-Smtp-Source: APBJJlGy8/3aVI/ONBTT9VVt/QSoHj1WSpULXy7Lsmb/CmNv6GbYGW1+0ATdnSEMuC/tt7MUZLnJcw==
X-Received: by 2002:ac8:7fce:0:b0:405:438a:baef with SMTP id b14-20020ac87fce000000b00405438abaefmr500344qtk.51.1689955838950;
        Fri, 21 Jul 2023 09:10:38 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id c16-20020ac87d90000000b004054fbf9273sm311286qtd.80.2023.07.21.09.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:10:37 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 0/6] x86: Clean up fast syscall return validation
Date:   Fri, 21 Jul 2023 12:10:11 -0400
Message-ID: <20230721161018.50214-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
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

This patch set cleans up the tests done to determine if a fast syscall
return instruction can be used to return to userspace.  It converts the
code to C, and refactors existing code to be more readable.

v2:
 - Fix shift value for canonical RIP test and use
   __is_canonical_address()

Brian Gerst (6):
  x86/entry/64: Remove obsolete comment on tracing vs. SYSRET
  x86/entry/64: Convert SYSRET validation tests to C
  x86/entry/compat: Combine return value test from syscall handler
  x86/entry/32: Convert do_fast_syscall_32() to bool return type
  x86/entry/32: Remove SEP test for SYSEXIT
  x86/entry/32: Clean up syscall fast exit tests

 arch/x86/entry/common.c          | 99 +++++++++++++++++++++-----------
 arch/x86/entry/entry_32.S        |  2 +-
 arch/x86/entry/entry_64.S        | 68 +---------------------
 arch/x86/entry/entry_64_compat.S | 12 ++--
 arch/x86/include/asm/syscall.h   |  6 +-
 5 files changed, 77 insertions(+), 110 deletions(-)

-- 
2.41.0


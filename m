Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001387C607C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376551AbjJKWoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376394AbjJKWn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:43:57 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3BDA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:43:55 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3af609c3e74so185678b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064235; x=1697669035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nQtgf87q9wy+lFMtA87OIvwbhZSyFLG2WJPnwm1IO8=;
        b=XoHmDtQWVAEW9BY/ZjYI0bm/Gv7qZnGU1ykIv/gJ6xMCqJTUikEC8R/SEBWgLFfYqU
         yxKORaCn+2/I7TqgVE5nLun9BGQtWn1/fDkb6tkuJpyB7ZquaSoB/h5Z1DJokeXOGfk2
         Tbg4qm30JURnAqvQSY3FIv9R6EhikTcxZ5jBJSbWCa9eynB1PQpgRUJnvstpWOJhMvCP
         YdI12L3RUQNuJQ9QJXh1fr31ZqNa+aSd9cVxPcdxqE4ypf53Zje+T1IOYVSeKOLpZAgO
         bnowMNNHNdCO25dsS2VuioRGubUcDfDsM+rjjldoYWoqPULGjIkRTOGRQlzjy7q7UdtO
         VdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064235; x=1697669035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nQtgf87q9wy+lFMtA87OIvwbhZSyFLG2WJPnwm1IO8=;
        b=NGshTD5C9QICSon58p7lTuRgdtnQfPPcbuAuoMscA0KafRRM3k5uMSXj4lTlfYblZw
         XYPmciLa51XFPw/l6jBSbTMXMQYsFVRbbK7e2ZwbOpY7yKr0CYLToEoq2HPjjM0atfZj
         7lR+bWNWTOBeOWzYRLmpvQj7JFYTBnXcdPMwPslVgoebfpWAOw7MpqAJYCK/ZZywUqgb
         7a1hHmve6dapSiTK9QSrRzMMnuGNGvn1Lkt3RG/+/k0yxP5Q430uZ/nWPU0vdjI7WteZ
         qXbGTVkOE2vNcgfu/jeZkBn96gSy1tcCBn305Qw3L8kmunToiG7F0otQQ1m9O9uoqVSw
         h7/A==
X-Gm-Message-State: AOJu0YxzRzQDtwctGd3cVq+A0wN4eQCqGLl8jpPNn32hcN5kgfiSQjr4
        /r1DDFhvLVo0HO5QKGrgLqRR36bBBA==
X-Google-Smtp-Source: AGHT+IGy3DyeB+1WWq1CFNxCzUZHDw8UM/Rrnv/df20qW1FX4POgx4Cv748FNEk7FrlGmhaR2hDnEQ==
X-Received: by 2002:a05:6808:23c4:b0:3a7:5611:a53b with SMTP id bq4-20020a05680823c400b003a75611a53bmr31917381oib.0.1697064234667;
        Wed, 11 Oct 2023 15:43:54 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o10-20020a0cf4ca000000b0065b129ec0e8sm6132871qvm.57.2023.10.11.15.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:43:54 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 0/3] x86: Clean up fast syscall return validation
Date:   Wed, 11 Oct 2023 18:43:48 -0400
Message-ID: <20231011224351.130935-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set cleans up the tests done to determine if a fast syscall
return instruction can be used to return to userspace.  It converts the
code to C, and refactors existing code to be more readable.

v3:
 - Remove patches already applied to -tip.
 - Keep Xen alternatives on the asm side to skip testing the return
   value.
 - Add patch to simplify canonical-RIP test.

v2:
 - Fix shift value for canonical RIP test and use
   __is_canonical_address()

Brian Gerst (3):
  x86/entry/64: Convert SYSRET validation tests to C
  x86/entry/64: Use TASK_SIZE_MAX for canonical RIP test
  x86/entry/32: Clean up syscall fast exit tests

 arch/x86/entry/common.c        | 91 ++++++++++++++++++++++++----------
 arch/x86/entry/entry_64.S      | 53 +-------------------
 arch/x86/include/asm/syscall.h |  2 +-
 3 files changed, 67 insertions(+), 79 deletions(-)

-- 
2.41.0


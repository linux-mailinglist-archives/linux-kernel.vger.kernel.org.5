Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2094757E02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjGRNpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGRNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:44:58 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602AD1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:44:57 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5636ab8240cso2567126eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689687896; x=1692279896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNqrcefTGIxwq6WUc5Q+gfSwa7IlQJweTMgnmniqqFE=;
        b=Koy26GCejGQAfIzaqEa11hB0ewXfx03a10NzSX2RR2pNaVFziQMZLgnIHfFgJM6fjK
         naszPDhFJkp/FeI0Cik9m32MLPtUVSpahn5Rx0+J8OMROkky+HLsSpiOY2D7j+A9hXJJ
         HIAi+1we2JUilgoopmK9fac3mMPmjI+hJ9TU7h2XiR/4T1zS2j60Fcjo7CPyLFr1DhhA
         AKDGnRMOsb7FSNFo9J/ZnfjrwwfjsgXgAzs1m3uUuCcAZ/MXfZashEkt47f1NnBfaNdT
         fS1yvfk1BNWxqglYJljmkWYtm/3t5bKe5KcY7vBtEqMuJR/1pc/hLSNsVjVBA5kSpkB7
         hMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687896; x=1692279896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNqrcefTGIxwq6WUc5Q+gfSwa7IlQJweTMgnmniqqFE=;
        b=VztEeaUZIfbGekZPd7S6EU5Z7EY4DzsqsLVA1amN67mRsW9W6uHYA1nPnowVpUfCGl
         N/C/dW/ZqXVdyj+lg2rHjvzZfa84jInNwDP4AuGmUmXIOy+gT1bfq922sHhlMqpukmLY
         l5BSphM+RP4K8fCQKnKtycFrKNRO8aptVR+Umei4EYJEXhYhflOhHYn7sNECHPQ54Tc4
         /b29DihTLyaeoqwpE4tWXVoNBci9MYpeqjEUvCFHXdCEmFu61CITFOkgky4Y3yYepGL5
         HWAqXpGOv/LcFsmdotjOYQqQPf709AT2OMiCcIsSX0ysT/Rd+GG4ZL/pUFTTon5aYakk
         NY7A==
X-Gm-Message-State: ABy/qLaTND/5dDW0bQJ88GwrRaBQ/QwwIedlw3h4hWj10hrgOAZvJ5PX
        4p/2d93oHMA21BgeCKMZHwGO+E4LvQ==
X-Google-Smtp-Source: APBJJlFBDFSu2ijYBnRo4B/pD1gmfEQxbNlfcEXoehGoRgTekp+XivX6/MdM2Ulp8XkijcL7brWGqA==
X-Received: by 2002:a4a:2744:0:b0:566:fd3b:4329 with SMTP id w4-20020a4a2744000000b00566fd3b4329mr5432827oow.7.1689687895893;
        Tue, 18 Jul 2023 06:44:55 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id q7-20020a4aac47000000b005660ed0becesm726778oon.39.2023.07.18.06.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:44:54 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/6] x86: Clean up fast syscall return validation
Date:   Tue, 18 Jul 2023 09:44:40 -0400
Message-ID: <20230718134446.168654-1-brgerst@gmail.com>
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

Brian Gerst (6):
  x86/entry/64: Remove obsolete comment on tracing vs. SYSRET
  x86/entry/64: Convert SYSRET validation tests to C
  x86/entry/compat: Combine return value test from syscall handler
  x86/entry/32: Convert do_fast_syscall_32() to bool return type
  x86/entry/32: Remove SEP test for SYSEXIT
  x86/entry/32: Clean up syscall fast exit tests

 arch/x86/entry/common.c          | 109 +++++++++++++++++++++----------
 arch/x86/entry/entry_32.S        |   2 +-
 arch/x86/entry/entry_64.S        |  68 +------------------
 arch/x86/entry/entry_64_compat.S |  12 ++--
 arch/x86/include/asm/syscall.h   |   6 +-
 5 files changed, 87 insertions(+), 110 deletions(-)

-- 
2.41.0


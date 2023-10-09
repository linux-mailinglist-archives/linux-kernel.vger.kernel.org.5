Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC77BEE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378880AbjJIWoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjJIWn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:43:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731849F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:43:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59ee66806d7so76386447b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696891434; x=1697496234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DKAs9FiDWAh3UClUoSgrNgZ5MWCcyLnU7t6CMgdnzXQ=;
        b=lDZKkevmol2pCZr/NOIiqWqTwwEJMZT2szqyAVAo7kJdmOiFQUlIlRmz6vubU2M2+7
         N7VWj+WVL96gYmFpoeAWbjleeySLssS8xLaw7+Oko67rWXWUsgx/+SbX2R4BRUwIdvcC
         OQyJI+H4cE+Ri3MbyyNe4Wk+N9ttV8gSqibEueCpB4DBpWTwb+C15QrBlbH4OSoS2LWf
         xulIcvCFNYF7IfMePbp2WyUcydIZWaRdpYakeysmLIfXMUpg2+J+fEWXdF/zwXtq37bZ
         I4ihwAeeOsS2JRDnH9qM8nEzfScR3P2nfVKgEiEJQhCGk0ooXKsjO3ImDlzHqjQ5H4zX
         B2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696891434; x=1697496234;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKAs9FiDWAh3UClUoSgrNgZ5MWCcyLnU7t6CMgdnzXQ=;
        b=kkAbrAWr/dyjcoW3QxyvGC9kORL/ZDzJRi4dY+EZXUYn6DwzN72s513qX5gEz9maZn
         0xJyh3yEiu8+wccJwWfyqPVoUvjx8rR0x/JagDpsIMkhpndnWZYTOrVQWhOkvZCV1+GB
         sspLdYMRaAvy7061NIWWG7S2x6mBVUoczdd8AoVik0+SRJ8Z36cgW9VLLfqMY3HpN36m
         XT+k/z8uMkKLbSzMsC0n+9foTGr2AOO9kN2tYO4WNVD+7fdaCXVbYCghrVVVDOmlXD46
         ZN1kzqbTCHUVOv0fwhJ6EqAwmDukEnAC1NM6UkLkCos93ATI1wJ34GOlMt1R6EGEI3Av
         rOMQ==
X-Gm-Message-State: AOJu0Yw0kcOipXjccjPO7U2uy14wirj/V4ec2+MIeYqcSWwn9AvxBH5p
        HJIr9o1urW24mx5PzlLsdMQetG1+v7/g
X-Google-Smtp-Source: AGHT+IEMrJfWElg8wRCen2hl8qHXtRVcnGRgHiYLheyhGANlw4Y4TpDgh+2N3ec6R+mUm+N0GW1+0lib1b4w
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a81:aa4d:0:b0:592:83d2:1f86 with SMTP id
 z13-20020a81aa4d000000b0059283d21f86mr290212ywk.4.1696891434703; Mon, 09 Oct
 2023 15:43:54 -0700 (PDT)
Date:   Mon,  9 Oct 2023 22:42:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231009224347.2076221-1-mmaurer@google.com>
Subject: [PATCH] x86: Enable IBT in Rust if enabled in C
From:   Matthew Maurer <mmaurer@google.com>
To:     peterz@infradead.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Matthew Maurer <mmaurer@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These flags are not made conditional on compiler support because at the
moment exactly one version of rustc supported, and that one supports
these flags.

Building without these additional flags will manifest as objtool
printing a large number of errors about missing ENDBR and if CFI is
enabled (not currently possible) will result in incorrectly structured
function prefixes.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---

Split out the IBT additions as per
https://lkml.kernel.org/linux-fsdevel/CANiq72kK6ppBE7j=z7uua1cJMKaLoR5U3NUAZXT5MrNEs9ZhfQ@mail.gmail.com/

arch/x86/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5bfe5caaa444..941f7abf6dbf 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -81,6 +81,7 @@ ifeq ($(CONFIG_X86_KERNEL_IBT),y)
 #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104816
 #
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch -fno-jump-tables)
+KBUILD_RUSTFLAGS += -Zcf-protection=branch -Zno-jump-tables
 else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
-- 
2.42.0.609.gbb76f46606-goog


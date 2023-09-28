Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F267B26D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjI1Uuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1Uuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:50:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED11D19C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:50:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a23ad271d7so3767887b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695934248; x=1696539048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wFc5hTa80jKfBeJT8UIj3Z/mvzdtWsUzhjvdORiKXpw=;
        b=ngjN/beLi46M8TAkdt7/MULJHvyPvbBVjV5l4Qw2LDwxjC0lWtpzfQwvwnsNkxeIwQ
         hjFL8dqsw+G4LXCmqCUbnGLfAUY2nsemSpz5COqRfODCKJv6VJAW2gy0vDMCjqwxWudu
         1h2hZGSOvlSTPVzYXgnZw5vr6rx4TUlWx53pgmJufzGnOmLvqCRqCyeOOgIrf+PXILZP
         oslEQb/7QxKN2QYdgGFt1eH61wAkmr0kdKRUJVMozYu4xGDVmxwvFkaJ2STBeAN2d5Nr
         SPWynijTTnwJ0WLxDoan1Uawhlzdiwa6nHzSgvCeOI9bdPG5IjT4i5wDTpLYqLwQEuSs
         0clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934248; x=1696539048;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFc5hTa80jKfBeJT8UIj3Z/mvzdtWsUzhjvdORiKXpw=;
        b=qCQKjRHy51DVUVvyFDzO4WmrWAUZ1vpxxEQZ14UPp5R9DrvK4Lpq3bRT5wLdhY+9fp
         7JFTjrOZ51/63bZMDKHYZoXalkCrV35ROuiPXV5CGWcALJaoGmH0fIoCtDT0na09zCKx
         cQ6RLf4hFKPYz0VGrDqDsav5XddrU7sotJyGUscmQVmnKa7Kq2F2O7sTv3sa8ExDAyif
         lvQyt5ifvIUNQdZLdZBrhdu8iuNfQDQTDZkhEYgI9XbNBQH6RBqN2b7uYir+XAP80RkK
         fqAdkV1G1nhUTfJxo9bO3u/Go4SLjvWyC+Q62PAnLmE5OMttubOOAOXKBzOR49Fg5Hfq
         zd9A==
X-Gm-Message-State: AOJu0Yy22bMMMXiug1ujAjDdeXr989NWlViLvDE0Y1Pqi9RwmG76471v
        adfiVwDdiOe96V8R0R4S1mpBSibCJjGq
X-Google-Smtp-Source: AGHT+IGSIesuF/oQYcDiEFS8Z6olHEI/SbpQyEP97pTcBgWoZbxT3LRHe8/x0kNR0lo4+TX58UZEsclIhR7q
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:fc26:0:b0:d80:904d:c211 with SMTP id
 v38-20020a25fc26000000b00d80904dc211mr31278ybd.7.1695934248220; Thu, 28 Sep
 2023 13:50:48 -0700 (PDT)
Date:   Thu, 28 Sep 2023 20:49:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928205045.2375899-1-mmaurer@google.com>
Subject: [PATCH v2] rust: Use awk instead of recent xargs
From:   Matthew Maurer <mmaurer@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`awk` is already required by the kernel build, and the `xargs` feature
used in current Rust detection is not present in all `xargs` (notably,
toybox based xargs, used in the Android kernel build).

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---

I absorbed the grep and cut into the awk command as well, as Joe Perches
suggested.

rust/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 87958e864be0..c4e583e9e443 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -364,9 +364,7 @@ $(obj)/bindings/bindings_helpers_generated.rs: $(src)/helpers.c FORCE
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
 	$(NM) -p --defined-only $< \
-		| grep -E ' (T|R|D) ' | cut -d ' ' -f 3 \
-		| xargs -Isymbol \
-		echo 'EXPORT_SYMBOL_RUST_GPL(symbol);' > $@
+		| awk '/ (T|R|D) / {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' > $@
 
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
-- 
2.42.0.582.g8ccd20d70d-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2A57B265E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjI1UVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjI1UVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:21:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72DB193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:21:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8153284d6eso20688890276.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695932480; x=1696537280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ipDavCedwq6Qwq/TiHUC4NLLZIDW2X0yZpZjMZHB/g=;
        b=bIJtpw0WOpNxI5QBoySsoNrGmVdtE1KRof6kEg7U/9DYTI+QLAmjy7vEOxgC19VBvt
         FPREqHq8ISj6XoyqbuDIqhAolj4Ra0UUNrQMB4q84zSJ9uTEoPh0mZ7TAX9vuIxhElCq
         JtYhYSraHNdwTCQUTO/mbsH06+fC+2jN2RMUYy826EFwYIvTW27chjQlBGBMP0iGgKRx
         e65I5139AhFJrCIeOMei6VRz6dZOwUxHOMYiaXP7cXvFsAchTp6aqQgHlFdrchNrq74y
         y6XsDlE0wxkT2we+llnvGj1uwzoGC+d1/Bb75alcDGM1SN/DANf04S2x8/qjRwnwKm52
         2rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695932480; x=1696537280;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ipDavCedwq6Qwq/TiHUC4NLLZIDW2X0yZpZjMZHB/g=;
        b=nPVgBeD2lVt4WpJ4QJe9wFbKO7rks5Wi/Eu9L1WU844rjLqhR7KLuUMjhHUnWsOKrI
         dbDR085SsH5Fjo3u9Yq6mJpmayhAp/rM59B3zeHC8o6pjNQr0g1ZrDw5pCWP6mmaBmxF
         W0tprhH8KCeT9P5rTK/zZGP4Fbx++5fWZ4acpVOqyMrqVyq/cVTUld7aidELZMpi+SmG
         KebJrpudZEFEUa5Fkf99HOWCV6weHofx0W8MwsS4ZqqomHZQrwc/kmptMkWBKHUCOyZ0
         Trb7DBls9HVgj87ttqkkPyTmON4bgpyyHlatSv/PKtXJpsmEh9KS9+sOucdVP07zJXYR
         LR9g==
X-Gm-Message-State: AOJu0YwcABBfOl5/HwjsmXwzIrMFzz4dTawVFx9BkrWcWXHfozW7WMmJ
        ShjnO6acciA5/4TL+IJkvNvEEAX+XFBd
X-Google-Smtp-Source: AGHT+IFYtiYx15xYObmoTlgOVU2/XOffBiyVUWQr+LcserfmkkXC4p7++a40Ha6OwjAOzwL4EZkCBw+ZxCsf
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:181c:b0:d82:9342:8627 with SMTP
 id cf28-20020a056902181c00b00d8293428627mr34637ybb.6.1695932480072; Thu, 28
 Sep 2023 13:21:20 -0700 (PDT)
Date:   Thu, 28 Sep 2023 20:21:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928202116.2298150-1-mmaurer@google.com>
Subject: [PATCH] rust: Use awk instead of recent xargs
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
 rust/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 87958e864be0..0efc5b5cd611 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -365,8 +365,7 @@ quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
 	$(NM) -p --defined-only $< \
 		| grep -E ' (T|R|D) ' | cut -d ' ' -f 3 \
-		| xargs -Isymbol \
-		echo 'EXPORT_SYMBOL_RUST_GPL(symbol);' > $@
+		| awk 'NF {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$0}' > $@
 
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
-- 
2.42.0.582.g8ccd20d70d-goog


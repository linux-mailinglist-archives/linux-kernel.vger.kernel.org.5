Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF697EFD4C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbjKRC6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjKRC6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:58:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE4E1723
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:58:14 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b02ed0f886so36381797b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700276293; x=1700881093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nvk9Q6fDi4VYvpZBd2dg6YVoVQRX3tnrrY9vqXNqK/Y=;
        b=cFpJc1uGrK0L9IEqMQ1f7XN8NnqWZD/2zkqP2j9JqCDvFOlV5c90qC0MoFUkNlBATj
         /hMF2V4bt/rf45dVNejfFaVYgvo38gE882Zv6Pyqg0IMerwFg6bFBkh6aKJUNpSHgKMP
         qCSolDJ4azR4YU3wUTANt0khbIdLSMJgmhVUCVDGcGWWj5JCBCulIDcj+dYI5YeKz42U
         Ex2mse2bptK9oWhVPS+XF2g49ipbKQfqSezHOwdNa4ooDxNWq+68hTgAtPAT3apZE33g
         a1871CLMq7R9B1w+ApX3yO1BTw6xHUWTkOZNgsUuMRMGcw11fKFuAQpoDAFIbYjiYEb/
         fXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700276293; x=1700881093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nvk9Q6fDi4VYvpZBd2dg6YVoVQRX3tnrrY9vqXNqK/Y=;
        b=QVPSWDl1Q0tMeL0dVyLSwtgk5yvz1T7StUaXkafGp9sa0mmCaZIFgCxML45Wm4j1hv
         VPsxDzUO+BQTWvleYbhwG4AtzGDsBMFdu1gbMVMtuMdfrYnFC6EzocFoOGPtg8qkLeQL
         6l385ntqFMhF3ZAihDiURFQ1VpAa4AKeK6XkgDS53xIFw+c3vk/zTh37KzyUaNCs0MXN
         p+d7n8A34hDWhykK8mAenv0/EZNEUnHuaM8fnH6uAhuTaN/63lna+TBpsMTpIUE5Hl4G
         ghyuHjxM2i552Lmm2p3FtUfkwK3QULGseKVP6favMlTybnvwkbNhjEO/6I2niIwjD+JK
         ZIcQ==
X-Gm-Message-State: AOJu0YzVFXuLJIovuZwJ49dlHhepjXN64XhBvBd+0ioIs1EaxhYPlW+/
        4EOg6+/lop95BXzDlG39NloiHO5fdBT8
X-Google-Smtp-Source: AGHT+IGP3XlXj/5Dcw3hp9Px56ng9u8ZBGdlOpNsgMCWjyW3JuNS4KY9Ymdo28sfT5+B96al0+/x10TRijqM
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a81:d512:0:b0:5a8:d81f:f5e7 with SMTP id
 i18-20020a81d512000000b005a8d81ff5e7mr38384ywj.8.1700276293608; Fri, 17 Nov
 2023 18:58:13 -0800 (PST)
Date:   Sat, 18 Nov 2023 02:54:45 +0000
In-Reply-To: <20231118025748.2778044-1-mmaurer@google.com>
Mime-Version: 1.0
References: <20231118025748.2778044-1-mmaurer@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231118025748.2778044-5-mmaurer@google.com>
Subject: [PATCH v2 4/5] rust: Allow MODVERSIONS
From:   Matthew Maurer <mmaurer@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Laura Abbott <laura@labbott.name>,
        Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With variable length symbol names from extended modversions, we can
enable MODVERSIONS alongside RUST due to support for its longer symbol
names.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 init/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9ffb103fc927..6cac5b4db8f6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1885,7 +1885,6 @@ config RUST
 	bool "Rust support"
 	depends on HAVE_RUST
 	depends on RUST_IS_AVAILABLE
-	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
-- 
2.43.0.rc0.421.g78406f8d94-goog


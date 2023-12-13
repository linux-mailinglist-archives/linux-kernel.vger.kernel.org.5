Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EBC811F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjLMToZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjLMToW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:44:22 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AAFC9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:44:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d340a9cf07so88008207b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496667; x=1703101467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZ3eBLJoXN0Zb334Rc/oMDoovJgn3OQlnIJlBZWmysw=;
        b=jx3AMrlgOr+eD/lfzdIvqCV046Y6JH+gGEf6Vn29MLPFUx3JjnjEhV5tn/GWk0nd4+
         CjNohCdWyRwDnfXoCNc0KRt4yHu+vN8bVqDTEjIiYlcKHpawyST/lWJlGYMxbB8mDEX/
         QDAOBYourpvnBtVWQy0RIqhd9kVftn8KRR0g1f3mBPhyvCQINmQdDEXNncYI18KXa69S
         UkDqRfHMwSHwY5XD3uWntwBw4FM0YGZSdb+EgtBtM1WKgX7EeX8H942euN38tFFeoVv5
         ZDO2nSDVBNEkc3ZxpEVLtFOcPa4g5yQhgOQPfz/NzUvvoZxa98rPWadPDC8JvQlyRB2c
         PLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496667; x=1703101467;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZ3eBLJoXN0Zb334Rc/oMDoovJgn3OQlnIJlBZWmysw=;
        b=BGLQeLAn5+Yc5rp+HZIWRFnVuTAx2fG63hQLrWBlpQQlh1SDCY46to+nGssu0tNkHX
         nmod3MBIpEY1ThEX7QKnfxULdQuF8xsdo3brRcmIZ16kBdhUrDWts2cKTqqylU1cYO0z
         TgLA1hjDIp/J/87SkFD7b9+CgSPhUd4L3uogL1CnjR13sGdI4JG5ZropotzP9zpwCLVA
         d65OegSOoKX6cOEAGOOWbpyvJbeBQRJxXSs/C0Ck4BEyaiY3s6z4j3aLYwHwRhwTILIU
         fKB4caPX7i0hxNalQ+SPGlLTZmXfzqhHmNN1p/W5U//GnaGQjUnBVdMDNOLONMYBQLcT
         Mr7g==
X-Gm-Message-State: AOJu0YxkUbM/e+DuwPemagNUVSKGps84aYPHM4BgXyjPCB1hGGmTV4+F
        2/HJxVczeJfGtHPoDHPI7BtDpxYdZQ==
X-Google-Smtp-Source: AGHT+IHUpke9zQYYoRhy3jSBDvuiZMWqdS9EZXOxv1azcDgbxZdKFBM1RfilmtUnk9IB8wj22/cc+5W6EQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:9705:0:b0:db5:45eb:75b0 with SMTP id
 d5-20020a259705000000b00db545eb75b0mr69766ybo.6.1702496666790; Wed, 13 Dec
 2023 11:44:26 -0800 (PST)
Date:   Wed, 13 Dec 2023 19:44:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-1-rmoar@google.com>
Subject: [PATCH v5 1/6] kunit: move KUNIT_TABLE out of INIT_DATA
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, sadiyakazi@google.com
Cc:     keescook@chromium.org, arnd@arndb.de,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alter the linker section of KUNIT_TABLE to move it out of INIT_DATA and
into DATA_DATA.

Data for KUnit tests does not need to be in the init section.

In order to run tests again after boot the KUnit data cannot be labeled as
init data as the kernel could write over it.

Add a KUNIT_INIT_TABLE in the next patch for KUnit tests that test init
data/functions.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/asm-generic/vmlinux.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bae0fe4d499b..1107905d37fc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -370,7 +370,8 @@
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
-	TRACEPOINT_STR()
+	TRACEPOINT_STR()						\
+	KUNIT_TABLE()
 
 /*
  * Data section helpers
@@ -699,8 +700,7 @@
 	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
-	EARLY_LSM_TABLE()						\
-	KUNIT_TABLE()
+	EARLY_LSM_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\

base-commit: b285ba6f8cc1b2bfece0b4350fdb92c8780bc698
-- 
2.43.0.472.g3155946c3a-goog


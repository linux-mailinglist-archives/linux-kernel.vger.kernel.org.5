Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9112F810725
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377659AbjLMBCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjLMBCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:02:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C90A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:02:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbc1f00dc35so7150769276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702429328; x=1703034128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kZ407BZUjf1nTaNFv/lydV9QLh6SjAtGxOmdW2rHzpg=;
        b=i53XthTOpyTBdUW+WiFagcPjBQVVp1FQbf/Ac6dvZRCLoO214u+pR88jZvpPunzb/j
         6ogryEcMMLo7NnnI/1Hi2dwpnTTzvp133rdOtzdcAdJiUqwGH1BUc9pN7I1RGKl7JMEm
         fEjV79dNoj2OZObewmepN2iIyQ0aw/mAYBpkId06kaKdh1dvLaun0GmrS5D9pphhAyuy
         yyaBTcvenIIbm1DtdJM9nBFad3k7LfKK5+wL7Aip2tsviBQFOhaW/M3Hxir3f7XgmQIp
         A5iVEa1iap5Seut+NPBVGk3guo3ww84uO0kvk6cxn++AQPiUBoUET3QLaS6X438YJD87
         zPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429328; x=1703034128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZ407BZUjf1nTaNFv/lydV9QLh6SjAtGxOmdW2rHzpg=;
        b=hlT3hMctrgGjbOZG8KL47OMRQRpw8Mbz6G2DB23wkc7zBNY9OMwp7hjV/pCUxNmRST
         OcLLjCYua26clYQoxafJmHoN4A0klRNLll61XXn0Kkxg1a/yhw4+upSdU+dr5tFxY3HU
         OI1hu6++/Hj6kKRMPvnYLRm0KkQpTH9VLgX0Z6vZT33LDUxDb9VKC3OaaAVo1BroDJYv
         JtkF4empg52J+zlcfMNy9XPSBwloMrSNRwKb9Kh4QYLu0XN6RAFaVT+QBnhnm5ZLIHf4
         JoCxrfBkObJnWArddBo7ODatXLeD/T65YEdDI8qlJme22rUvULZ9vXoKZ7do6o4sKy+h
         rM+g==
X-Gm-Message-State: AOJu0YwdIeDe32fxavJlntL3rdLVbiBeaFBXxI9T6Ng2BkB+7+wDf4ej
        aNuLNuVqnfl+4pT7CACVoVOwOWkkUA==
X-Google-Smtp-Source: AGHT+IGqh6A2C4LBDSwxDzJVO+NoByY9A5DvrqbepeEPTSZPaqsmWW9SaiNRK2kz6afSq5yi/8IqEI4wGw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:343:b0:db5:f536:17d4 with SMTP id
 e3-20020a056902034300b00db5f53617d4mr46384ybs.11.1702429328425; Tue, 12 Dec
 2023 17:02:08 -0800 (PST)
Date:   Wed, 13 Dec 2023 01:01:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213010201.1802507-1-rmoar@google.com>
Subject: [PATCH v4 1/6] kunit: move KUNIT_TABLE out of INIT_DATA
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v3:
- No changes

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


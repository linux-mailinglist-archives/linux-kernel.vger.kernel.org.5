Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5202F7A5B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjISHig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjISHiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:38:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309DD13A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:38:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502e6d632b6so8257522e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695109087; x=1695713887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYhAeXJ6n0p1NLvV6l5GcJ19JSLs3+6aIPIDGI6CfRk=;
        b=Yps8gmkeTmp9JUZIsf1OHZOR5CVvG3FM9iwqX/oT2nQFL1/5tUX0m05MNvJox0Qzm1
         xbeRaRvq9pJeHQEOmQSt70InTnK20NjKouJmjluTYVXFV4988iHPky+1cBfL5i8OQxvB
         /8TkroWxHiRJgQdvaEGbVCZf+Y9GS6zI4irb0efd26czhZnJdMEVZ6TjY6ZqUouIskR8
         Tbyzbf45ACYDvxZNiJoo3+uv/y2blGxLbJ/PJ7U/QJYQ6Tw+PxrMjxB2QAHYyqyb5uqa
         83UF6b+8GqYDwJVQl8Kpstb/ljJN33a6QpWWM3FWcgbrnmOCvFhcGc+gg7FQnHfHMYhE
         DgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695109087; x=1695713887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYhAeXJ6n0p1NLvV6l5GcJ19JSLs3+6aIPIDGI6CfRk=;
        b=dtVa51RQuTYPNRnVe1rhzf1bwe3ftXQLiaQEFkw8qu9P2NAAFAQq8aVznMFdwiaeHE
         s6mskHd0H6/2nQf7tBCHHrPTMe0pgY9GA9K+YL5k6aMTAFD2dHN+u20ZiJVX9RITmb77
         dXtPVq1sFeJk9rKR4L8vwJwnlpIjI9ZdOgjMPAqBsGLC6ZCNJUHMoqnJVh6QCaFGdJ58
         QAT61A6dQk1MqmgAFYiO7DS1nxkJWy90OpRNmZMABMtJEDckfumMTKojIBb8PK+HyuOW
         z+S1U03oEWbfwIgGVbQBfzpgwgXHLvYvDXnjLS1Kar6B3Vq5vO0yv7nQMkjkFF84ZXta
         fdmQ==
X-Gm-Message-State: AOJu0Yy7VGpEkUWgRCtF1Lt8Jrm9nukt/p5wQWILj58WAyCSeaIKnxjx
        ecd1iEB2j+FTFhC42I96VbbCrw==
X-Google-Smtp-Source: AGHT+IEy4V776q3dOVrHfVXYIIbgCPjMiR68Dh28Ik0ewLQPT/Azb7+uWm//NNL3crh6azWctXVQ+w==
X-Received: by 2002:ac2:4285:0:b0:503:19d9:4b6f with SMTP id m5-20020ac24285000000b0050319d94b6fmr3374875lfh.0.1695109086944;
        Tue, 19 Sep 2023 00:38:06 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0052567e6586bsm7049439edr.38.2023.09.19.00.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:38:06 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char/mem: implement splice() for /dev/zero, /dev/full
Date:   Tue, 19 Sep 2023 09:37:42 +0200
Message-Id: <20230919073743.1066313-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows splicing zeroed pages into a pipe, and allows discarding
pages from a pipe by splicing them to /dev/zero.  Writing to /dev/zero
should have the same effect as writing to /dev/null, and a
"splice_write" implementation exists only for /dev/null.

(The /dev/zero splice_read implementation could be optimized by
pushing references to the global zero page to the pipe, but that's an
optimization for another day.)

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/char/mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 1052b0f2d4cf..263c19cd6fb9 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -640,6 +640,7 @@ static int open_port(struct inode *inode, struct file *filp)
 #define full_lseek      null_lseek
 #define write_zero	write_null
 #define write_iter_zero	write_iter_null
+#define splice_write_zero	splice_write_null
 #define open_mem	open_port
 
 static const struct file_operations __maybe_unused mem_fops = {
@@ -677,6 +678,8 @@ static const struct file_operations zero_fops = {
 	.read_iter	= read_iter_zero,
 	.read		= read_zero,
 	.write_iter	= write_iter_zero,
+	.splice_read	= copy_splice_read,
+	.splice_write	= splice_write_zero,
 	.mmap		= mmap_zero,
 	.get_unmapped_area = get_unmapped_area_zero,
 #ifndef CONFIG_MMU
@@ -688,6 +691,7 @@ static const struct file_operations full_fops = {
 	.llseek		= full_lseek,
 	.read_iter	= read_iter_zero,
 	.write		= write_full,
+	.splice_read	= copy_splice_read,
 };
 
 static const struct memdev {
-- 
2.39.2


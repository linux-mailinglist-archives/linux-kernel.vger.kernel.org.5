Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF7E7A2794
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbjIOUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbjIOUDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:03:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629882120
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:03:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf55a81eeaso20456315ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808211; x=1695413011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SosbTcKl/5I1PV+lrT9yDJJKNex4T51jnpPA720MDZU=;
        b=gsFImH+r6qpHa8+zQQueIhNnrEQEVEyc9VFY1BOVXHdgRbYXMffG38RWM2I1dbbeod
         hsO1T6Y5NU82OWCtB3D6eY4G8JQ/202RlnOtCm88worl6zVvjJPpNxkVdcAbTD9EaztD
         5cedbI9qOTxeNqrSQU8C8dFFwG4YO2tnvO7Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808211; x=1695413011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SosbTcKl/5I1PV+lrT9yDJJKNex4T51jnpPA720MDZU=;
        b=AGhSd11f4idtP/oqv3RoBP4Oj6n8xZh5tgbexWD9H6+cNNl9sPSHpPoSjO1lxq6Fi0
         Km28N26LLs64978loXrb3x2n0JAQ4Mok/stCtxF/kQAL7XtU4pYdJAwIlF+RxandMr5u
         uLyXARb+H2nMqh4VrgT8FAfEq/1afcM4Hl5eBUmvQKfMwxZVtLmKTuBmnFIVKJ3ZZ9XV
         dKyxQuGxuENJ3I+WvllT5apmfVBCd+F7nGr2L9pFlQKMzs+ERr9X+eGdep7kyrgHQjmd
         v0Kp/YotztRtEzjH17XB9n46YevreBEcYA9JsdknkM9lvlTOD2AebASHBlDCTTnygbvl
         qJpQ==
X-Gm-Message-State: AOJu0YxCww7Gtlb/p3W2UwwneSJzmYcs5NT/Ms/z6DuhWSkdnaCar35T
        sbRUzvLhurjRNtkAiWpguxFpOQ==
X-Google-Smtp-Source: AGHT+IEOQ2lcwtuhw63TPr12BTkAZ2vOLMAc0/d5J0bOWzH8ffo1YR777tngzNTZgKuRYw8HWobCKw==
X-Received: by 2002:a17:902:e5d2:b0:1c2:5db:7f16 with SMTP id u18-20020a170902e5d200b001c205db7f16mr2968709plf.67.1694808210853;
        Fri, 15 Sep 2023 13:03:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z14-20020a170902d54e00b001bd28b9c3ddsm3856917plf.299.2023.09.15.13.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:03:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Song Liu <song@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-raid@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] md/md-linear: Annotate struct linear_conf with __counted_by
Date:   Fri, 15 Sep 2023 13:03:28 -0700
Message-Id: <20230915200328.never.064-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3030; i=keescook@chromium.org;
 h=from:subject:message-id; bh=mHf9KJ3h9Dhk5paRlWrtgrLWQTsMLrfhnSPVfMSBb64=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLiQXfFuDkTYwAb1eIwKAUqGWKpMaXqd9cGQi
 R5dxa9UYAaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS4kAAKCRCJcvTf3G3A
 JsXqD/wKUnbZHahdgumMZjjArgJmZqnGpwPIzL69Kn3lUZnQrQMt0KfRSnb02kD5OXo3wi9ZEUP
 P3uqJLz4U7jqO1SZzIxMjmYvmepGzlUnahBVWXbXtLqiPQx9u4wdLNaIwSEW4P3WS4POsuFWxYB
 Mrm00qIj8a6q6L+9US0fRnFGnam7yYUyGDRoLMkzVuJvxSe0sh19+nzhn27QC/r4ju6pgMsM2o4
 ewYYPkzumFt/tguEdxFax1AGz3aPpee/LWIUcfYNAZ8oefAQeBDBM8fK3M06zvNPxqThyC5JpNr
 ZF15n2uj89sAv8ZsjayB1c0LwqG4giEz3UEdB0Qxle/Im7aEYQmEPApO6meGHwlmfKravrNj7IS
 8WlL+OBZM5Rby6CcdruSt/mmPOSMIslGI0c/OL+lCtgsBZcs1EfrVAonbI5vqNix3bA9Ojj6Ryb
 N6WVanstIBM6/XABftYGqZw50OF7zw5DBLLlS62L3kGdqCXYB8exgRBmmdINZ3mh/gdCixMmXB/
 pBbWqhBkitswbnGXCwM49Xfo53Bg/dgi9ycKh95Fz2c1hojweBdm5vbOuF4EvzumIeDv/xRGiC1
 GFGKEFccMyCtOyBHGZEyobz1DMg2AHQemK7clDpXKY/tkidK/YsKqf0iy8GJGuxNAmT8HkLMEba
 Lv/anPt ijBf0Fzw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct linear_conf.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/md-linear.c | 26 +++++++++++++-------------
 drivers/md/md-linear.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 71ac99646827..ae2826e9645b 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -69,6 +69,19 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
 	if (!conf)
 		return NULL;
 
+	/*
+	 * conf->raid_disks is copy of mddev->raid_disks. The reason to
+	 * keep a copy of mddev->raid_disks in struct linear_conf is,
+	 * mddev->raid_disks may not be consistent with pointers number of
+	 * conf->disks[] when it is updated in linear_add() and used to
+	 * iterate old conf->disks[] earray in linear_congested().
+	 * Here conf->raid_disks is always consitent with number of
+	 * pointers in conf->disks[] array, and mddev->private is updated
+	 * with rcu_assign_pointer() in linear_addr(), such race can be
+	 * avoided.
+	 */
+	conf->raid_disks = raid_disks;
+
 	cnt = 0;
 	conf->array_sectors = 0;
 
@@ -112,19 +125,6 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
 			conf->disks[i-1].end_sector +
 			conf->disks[i].rdev->sectors;
 
-	/*
-	 * conf->raid_disks is copy of mddev->raid_disks. The reason to
-	 * keep a copy of mddev->raid_disks in struct linear_conf is,
-	 * mddev->raid_disks may not be consistent with pointers number of
-	 * conf->disks[] when it is updated in linear_add() and used to
-	 * iterate old conf->disks[] earray in linear_congested().
-	 * Here conf->raid_disks is always consitent with number of
-	 * pointers in conf->disks[] array, and mddev->private is updated
-	 * with rcu_assign_pointer() in linear_addr(), such race can be
-	 * avoided.
-	 */
-	conf->raid_disks = raid_disks;
-
 	return conf;
 
 out:
diff --git a/drivers/md/md-linear.h b/drivers/md/md-linear.h
index 24e97db50ebb..5587eeedb882 100644
--- a/drivers/md/md-linear.h
+++ b/drivers/md/md-linear.h
@@ -12,6 +12,6 @@ struct linear_conf
 	struct rcu_head		rcu;
 	sector_t		array_sectors;
 	int			raid_disks; /* a copy of mddev->raid_disks */
-	struct dev_info		disks[];
+	struct dev_info		disks[] __counted_by(raid_disks);
 };
 #endif
-- 
2.34.1


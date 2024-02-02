Return-Path: <linux-kernel+bounces-49742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E409846EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B641C2162B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C113D4ED;
	Fri,  2 Feb 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ2nlHgO"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC060DF2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872975; cv=none; b=rZQVYfiVaqWH6WckNlxtNn0wILw2aoHjJ+dNEoMvAVNjEUTZuwwNIHdmEBdHT4gvhkcU0i2YHGqaAdCm1QrO686BAjlAB8vTnIwh1Tv8USwdtEfJMkDmY3NQ0m8v+xGASpTYlT0oh9X43qD9SdI59jFoaceazip9cTdtlsFzeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872975; c=relaxed/simple;
	bh=TYQNTRx55DVMs4WPsc37V4IUZn/xvqmnkRwnMVWYyjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BE1MWVkikMKxd0ML8EE+M1EQwtMVB0XTpn25r+3oQgobHHcQv+hqWhc+yW7JZtevk0H6hrp6lWGx5l2sWTcdA7762+JMO0GqV3N2lEEI8eU/+m7QscizBTvhuPzPO2zg6vWdfKZsQj2isd4n9g1AGCfF3Q7hIvue6OiBZecWygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ2nlHgO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d71cb97937so18536655ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 03:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706872973; x=1707477773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDv0UM+c6esZvNRhK5IQOpzsJDuTm6Hopa5EKVjce1o=;
        b=kQ2nlHgOq1cGLU6kvB8XX80oDHNJermN36qJrXqZpbSlSKIdZFhzW4i91BuWpMw9bp
         +D9W+zTIyedeeGhcmiBPgS6MtInNmLDoe4IJ4QstxBl5cVf7q+szpdrflnDvjPcXeEJq
         PMay3TdQqONFKcmaFwuNAGCmn9L0AdCXlFzt9QUsFlSd+v33sHABOMzSI2OBPIcrNJzP
         hmpY0yEi3TNbA/QYXWd+o4jXtjEPCo/Ym94Mzf+bgoTaSN5BGIgPwmCFdqcRVykMf24i
         rK6g+OIgbxdAML/bl2F+oNqqxNVLzFAPXXLH/8QUkn6VsRoh8b0WUb7TjVexDPUFdxXk
         LR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706872973; x=1707477773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDv0UM+c6esZvNRhK5IQOpzsJDuTm6Hopa5EKVjce1o=;
        b=jT2Gdj7lajJhw5EvTKWvqDCKmtasOHrXXRznQMQ4hzLIm4uSdB1V1igVZnDyeK5EQf
         1HgYldmHEzIiFf+xsz+F6OK2L+QMlI8XLe29G+cR2xbEWVKmy6eLLKtllShShDAx9tgD
         KY1AiTU1H4VlohmNhjp8cgeR8i960d5sXeUh7AFXikx7AzBBQR1baS7ei6XpBQd757af
         P03vFDqBPItYZ1Slbwaqbi2Aieq2Y5wI+5rI4wneVegBIIRX4670sSlA+hhHCIl58f21
         SLCBujy3aNVdWzlxbTlFmz0MyMWo+xVXu1LWC5a8TrvmOy0XMW+Ofaxgu4GubufY7vHu
         BFVw==
X-Gm-Message-State: AOJu0YznQ1jebeFebn66TJvlZ8XojJzUjc3S5z9lxC4lNTbeVPlm0hJv
	uhquvrPfTWo3SAhZMx6aDQ4qkZvFsB0iGSSg590RzAvPYLdl6Y34hoXoGweJ
X-Google-Smtp-Source: AGHT+IHbSvjkPvFNB/sCdH351XrytCdZsUAhhG/thXz9suC2cMVStXnKcOz3VvBRsI7ABfK5fyRCuA==
X-Received: by 2002:a17:903:32cc:b0:1d9:591b:227a with SMTP id i12-20020a17090332cc00b001d9591b227amr4449112plr.48.1706872972776;
        Fri, 02 Feb 2024 03:22:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWNdpf8NT3hm40JJqjKjyQEeRk0cVjnL04EPKtojBBO7tl9XT5x6cN7HvTduuYb9yEBppZQAaJ+yTSDRbXcwm21A4Av1I4JHCH5FrBFygQHtbEtlJAtIId2q2UopOeLNH6xYniOpo26dJQJjGSVGZJsfcRuZo3O16mCXiLFLWzqST3tnYaSyoAU
Received: from mi.mioffice.cn ([2408:8607:1b00:8:8eec:4bff:fe94:a95d])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d08b00b001d7134d149dsm1374865plv.256.2024.02.02.03.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:22:52 -0800 (PST)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>
Subject: [PATCH v2] f2fs: sysfs: support gc_io_aware
Date: Fri,  2 Feb 2024 19:22:25 +0800
Message-ID: <5a4cdc020f19e136e79f9d0b6ca2adf2879db888.1706859367.git.liujinbao1@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>

Currently, IO can only be ignored when GC_URGENT_HIGH is set,
and the default algorithm used for GC_URGENT_HIGH is greedy.
It gives a way to enable/disable IO aware feature for background
gc, so that we can tune background gc more precisely. e.g.
force to disable IO aware and choose more suitable algorithm
if there are large number of dirty segments.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.corp-partner.google.com>

changes of v2: Improve the patch according to Chao's suggestions

---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/gc.c                            | 3 ++-
 fs/f2fs/gc.h                            | 1 +
 fs/f2fs/sysfs.c                         | 9 +++++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 36c3cb547901..47f02fa471fe 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -16,6 +16,12 @@ Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
 Description:	Controls the default sleep time for gc_thread. Time
 		is in milliseconds.
 
+What:		/sys/fs/f2fs/<disk>/gc_io_aware
+Date:		January 2024
+Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
+Description:	It controls to enable/disable IO aware feature for background gc.
++		By default, the value is 1 which indicates IO aware is on.
+
 What:		/sys/fs/f2fs/<disk>/gc_idle
 Date:		July 2013
 Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 309da3d0faff..0b75d37acc63 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -109,7 +109,7 @@ static int gc_thread_func(void *data)
 			goto next;
 		}
 
-		if (!is_idle(sbi, GC_TIME)) {
+		if (gc_th->io_aware && !is_idle(sbi, GC_TIME)) {
 			increase_sleep_time(gc_th, &wait_ms);
 			f2fs_up_write(&sbi->gc_lock);
 			stat_io_skip_bggc_count(sbi);
@@ -182,6 +182,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
 	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
 	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
+	gc_th->io_aware = true;
 
 	gc_th->gc_wake = false;
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 28a00942802c..51d6ad26b76a 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -41,6 +41,7 @@ struct f2fs_gc_kthread {
 	unsigned int min_sleep_time;
 	unsigned int max_sleep_time;
 	unsigned int no_gc_sleep_time;
+	bool io_aware;
 
 	/* for changing gc mode */
 	bool gc_wake;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 417fae96890f..e8d5667cfddd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -516,6 +516,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_io_aware")) {
+		if (t > 1)
+			return -EINVAL;
+		*ui = t ? true : false;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "migration_granularity")) {
 		if (t == 0 || t > sbi->segs_per_sec)
 			return -EINVAL;
@@ -906,6 +913,7 @@ GC_THREAD_RW_ATTR(gc_urgent_sleep_time, urgent_sleep_time);
 GC_THREAD_RW_ATTR(gc_min_sleep_time, min_sleep_time);
 GC_THREAD_RW_ATTR(gc_max_sleep_time, max_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
+GC_THREAD_RW_ATTR(gc_io_aware, io_aware);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1061,6 +1069,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_min_sleep_time),
 	ATTR_LIST(gc_max_sleep_time),
 	ATTR_LIST(gc_no_gc_sleep_time),
+	ATTR_LIST(gc_io_aware),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.43.0



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905C7B245F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjI1RvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1RvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:51:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6836D19D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:51:19 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c4e30a3604so5307851a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695923478; x=1696528278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9faVLxD3M9q3YdOamD3SiBzoQp11HsxDk7q3mwipfgs=;
        b=dRrNNTlplQSBSqGzp3NyNv5n4iXFdcCdZpIjrbXR73QrA9Neb8I5T/+zjogL8Z3qRB
         XmheODOHxp30K2VEsyaYlATL4y8PITkOoiMVv7sfaeeQ7ORvSKYCWshlrqM6szXxDIm4
         sFhOxumyDfBXSHwEPxiATyZkiVAghcm1zY1quK23ioXDZ8gLddsM59DqMQ4kGHn/MOuY
         w03sdjtELcVVfgs3zAHu5QmTGUQrTlQojd5r6G0Yekz947VRrsL4bwyl7dXJafknTcv8
         gaPiGA8JWy9jeqmrQ4zs+NbQFhpiXNwNaLDa/r/8yO7hrxMHgpnIbkSF3R29ZBYc3mMs
         Md/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695923478; x=1696528278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9faVLxD3M9q3YdOamD3SiBzoQp11HsxDk7q3mwipfgs=;
        b=h1aU+Lb3zjjhf5cjP3KsYjODP65W1/dwlQDVOdk7Q+bzHD9nWnCsh1wt+YQrLmwSPZ
         KMLQMZ9bqsQfev15zTo7uUFfg3fFQOTJ8CtMcXNdjnvg1cDrUXeomYp/7Wl1BARQMmvv
         g0LX+nxJPrj3jUtGVkf2duPtxx6MndQ8ePrSj1IG3vsxSnxCgjrLxc6ERIsCzfYazZMj
         mvByAnK9zg7gzHE9ooM/P4OdlL3yqTuRtaEaxq8/Ik7nVJ3+JyRd2stqFdzi9RrqTAQU
         AuPMIS2rzlaTn9Kh8XdzdwlX6RXMfhOV+8HjuKjeRXwMtXFxqw4uSvXCw0+Dow3t3uFX
         9gUg==
X-Gm-Message-State: AOJu0YyRbaWKzRQ27KN2qj9D5r8cTBTba71lWK5ni8yeGUYhYuON1I4Q
        FCdJjiCyho2ST8EquRWWy4J9nhDp0cc=
X-Google-Smtp-Source: AGHT+IGXV2menI46aJ1y6APIPrJAyJ090wW86yuV5gu6eZ55drd3Uw9lYZd1Gkx/bS9wmoMTQKlt8A==
X-Received: by 2002:a05:6808:2c3:b0:3ad:f5b3:844c with SMTP id a3-20020a05680802c300b003adf5b3844cmr1822774oid.18.1695923478327;
        Thu, 28 Sep 2023 10:51:18 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:9bdf:7d57:cf98:e71d])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm13612219pff.1.2023.09.28.10.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:51:17 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: do not support user-space cache
Date:   Thu, 28 Sep 2023 10:51:13 -0700
Message-ID: <20230928175113.3840888-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We don't have lots of benefits from this, since block devices already
have page caches in the kernel. Moreover, this feature has some
stability issues corrupting metadata. So, we better make this deprecated.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/main.c       |  18 +--
 include/f2fs_fs.h |  18 ---
 lib/libf2fs_io.c  | 329 ----------------------------------------------
 3 files changed, 2 insertions(+), 363 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 3690c74..e94de7f 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -10,9 +10,6 @@
  *   Liu Shuoran <liushuoran@huawei.com>
  *   Jaegeuk Kim <jaegeuk@kernel.org>
  *  : add sload.f2fs
- * Copyright (c) 2019 Google Inc.
- *   Robin Hsu <robinhsu@google.com>
- *  : add cache layer
  * Copyright (c) 2020 Google Inc.
  *   Robin Hsu <robinhsu@google.com>
  *  : add sload compression support
@@ -26,7 +23,6 @@
 #include <ctype.h>
 #include <time.h>
 #include <getopt.h>
-#include <stdbool.h>
 #include "quotaio.h"
 #include "compress.h"
 
@@ -59,10 +55,6 @@ void fsck_usage()
 	MSG(0, "\nUsage: fsck.f2fs [options] device\n");
 	MSG(0, "[options]:\n");
 	MSG(0, "  -a check/fix potential corruption, reported by f2fs\n");
-	MSG(0, "  -c <num-cache-entry>  set number of cache entries"
-			" (default 0)\n");
-	MSG(0, "  -m <max-hash-collision>  set max cache hash collision"
-			" (default 16)\n");
 	MSG(0, "  -C encoding[:flag1,flag2] Set options for enabling"
 			" casefolding\n");
 	MSG(0, "  -d debug level [default:0]\n");
@@ -80,7 +72,6 @@ void fsck_usage()
 	MSG(0, "  --dry-run do not really fix corruptions\n");
 	MSG(0, "  --no-kernel-check skips detecting kernel change\n");
 	MSG(0, "  --kernel-check checks kernel change\n");
-	MSG(0, "  --debug-cache to debug cache when -c is used\n");
 	exit(1);
 }
 
@@ -241,8 +232,6 @@ void f2fs_parse_options(int argc, char *argv[])
 		};
 
 		c.func = FSCK;
-		c.cache_config.max_hash_collision = 16;
-		c.cache_config.dbg_en = false;
 		while ((option = getopt_long(argc, argv, option_string,
 						long_opt, &opt)) != EOF) {
 			switch (option) {
@@ -259,18 +248,15 @@ void f2fs_parse_options(int argc, char *argv[])
 				MSG(0, "Info: Do Kernel Check\n");
 				break;
 			case 4:
-				c.cache_config.dbg_en = true;
+				MSG(0, "Info: Deprecated option \"debug-cache\"\n");
 				break;
 			case 'a':
 				c.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption.\n");
 				break;
 			case 'c':
-				c.cache_config.num_cache_entry = atoi(optarg);
-				break;
 			case 'm':
-				c.cache_config.max_hash_collision =
-						atoi(optarg);
+				MSG(0, "Info: Deprecated option \'%c\'\n", option);
 				break;
 			case 'g':
 				if (!strcmp(optarg, "android")) {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 7e7db22..dd41a91 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -3,8 +3,6 @@
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- * Copyright (c) 2019 Google Inc.
- *             http://www.google.com/
  * Copyright (c) 2020 Google Inc.
  *   Robin Hsu <robinhsu@google.com>
  *  : add sload compression support
@@ -443,16 +441,6 @@ struct device_info {
 	size_t *zone_cap_blocks;
 };
 
-typedef struct {
-	/* Value 0 means no cache, minimum 1024 */
-	long num_cache_entry;
-
-	/* Value 0 means always overwrite (no collision allowed). maximum 16 */
-	unsigned max_hash_collision;
-
-	bool dbg_en;
-} dev_cache_config_t;
-
 /* f2fs_configration for compression used for sload.f2fs */
 typedef struct  {
 	void (*init)(struct compress_ctx *cc);
@@ -1471,9 +1459,6 @@ struct f2fs_configuration {
 	/* precomputed fs UUID checksum for seeding other checksums */
 	uint32_t chksum_seed;
 
-	/* cache parameters */
-	dev_cache_config_t cache_config;
-
 	/* compression support for sload.f2fs */
 	compress_config_t compress;
 
@@ -1519,9 +1504,6 @@ extern void f2fs_release_sparse_resource(void);
 extern int f2fs_finalize_device(void);
 extern int f2fs_fsync_device(void);
 
-extern void dcache_init(void);
-extern void dcache_release(void);
-
 extern int dev_read(void *, __u64, size_t);
 #ifdef POSIX_FADV_WILLNEED
 extern int dev_readahead(__u64, size_t);
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index 74e5f3a..e912c30 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -3,8 +3,6 @@
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- * Copyright (c) 2019 Google Inc.
- *             http://www.google.com/
  * Copyright (c) 2020 Google Inc.
  *   Robin Hsu <robinhsu@google.com>
  *  : add quick-buffer for sload compression support
@@ -34,9 +32,6 @@
 #include <linux/hdreg.h>
 #endif
 
-#include <stdbool.h>
-#include <assert.h>
-#include <inttypes.h>
 #include "f2fs_fs.h"
 
 struct f2fs_configuration c;
@@ -65,318 +60,6 @@ static int __get_device_fd(__u64 *offset)
 	return -1;
 }
 
-/* ---------- dev_cache, Least Used First (LUF) policy  ------------------- */
-/*
- * Least used block will be the first victim to be replaced when max hash
- * collision exceeds
- */
-static bool *dcache_valid; /* is the cached block valid? */
-static off_t  *dcache_blk; /* which block it cached */
-static uint64_t *dcache_lastused; /* last used ticks for cache entries */
-static char *dcache_buf; /* cached block data */
-static uint64_t dcache_usetick; /* current use tick */
-
-static uint64_t dcache_raccess;
-static uint64_t dcache_rhit;
-static uint64_t dcache_rmiss;
-static uint64_t dcache_rreplace;
-
-static bool dcache_exit_registered = false;
-
-/*
- *  Shadow config:
- *
- *  Active set of the configurations.
- *  Global configuration 'dcache_config' will be transferred here when
- *  when dcache_init() is called
- */
-static dev_cache_config_t dcache_config = {0, 16, 1};
-static bool dcache_initialized = false;
-
-#define MIN_NUM_CACHE_ENTRY  1024L
-#define MAX_MAX_HASH_COLLISION  16
-
-static long dcache_relocate_offset0[] = {
-	20, -20, 40, -40, 80, -80, 160, -160,
-	320, -320, 640, -640, 1280, -1280, 2560, -2560,
-};
-static int dcache_relocate_offset[16];
-
-static void dcache_print_statistics(void)
-{
-	long i;
-	long useCnt;
-
-	/* Number of used cache entries */
-	useCnt = 0;
-	for (i = 0; i < dcache_config.num_cache_entry; i++)
-		if (dcache_valid[i])
-			++useCnt;
-
-	/*
-	 *  c: number of cache entries
-	 *  u: used entries
-	 *  RA: number of read access blocks
-	 *  CH: cache hit
-	 *  CM: cache miss
-	 *  Repl: read cache replaced
-	 */
-	printf ("\nc, u, RA, CH, CM, Repl=\n");
-	printf ("%ld %ld %" PRIu64 " %" PRIu64 " %" PRIu64 " %" PRIu64 "\n",
-			dcache_config.num_cache_entry,
-			useCnt,
-			dcache_raccess,
-			dcache_rhit,
-			dcache_rmiss,
-			dcache_rreplace);
-}
-
-void dcache_release(void)
-{
-	if (!dcache_initialized)
-		return;
-
-	dcache_initialized = false;
-
-	if (c.cache_config.dbg_en)
-		dcache_print_statistics();
-
-	if (dcache_blk != NULL)
-		free(dcache_blk);
-	if (dcache_lastused != NULL)
-		free(dcache_lastused);
-	if (dcache_buf != NULL)
-		free(dcache_buf);
-	if (dcache_valid != NULL)
-		free(dcache_valid);
-	dcache_config.num_cache_entry = 0;
-	dcache_blk = NULL;
-	dcache_lastused = NULL;
-	dcache_buf = NULL;
-	dcache_valid = NULL;
-}
-
-// return 0 for success, error code for failure.
-static int dcache_alloc_all(long n)
-{
-	if (n <= 0)
-		return -1;
-	if ((dcache_blk = (off_t *) malloc(sizeof(off_t) * n)) == NULL
-		|| (dcache_lastused = (uint64_t *)
-				malloc(sizeof(uint64_t) * n)) == NULL
-		|| (dcache_buf = (char *) malloc (F2FS_BLKSIZE * n)) == NULL
-		|| (dcache_valid = (bool *) malloc(sizeof(bool) * n)) == NULL)
-	{
-		dcache_release();
-		return -1;
-	}
-	dcache_config.num_cache_entry = n;
-	return 0;
-}
-
-static void dcache_relocate_init(void)
-{
-	int i;
-	int n0 = (sizeof(dcache_relocate_offset0)
-			/ sizeof(dcache_relocate_offset0[0]));
-	int n = (sizeof(dcache_relocate_offset)
-			/ sizeof(dcache_relocate_offset[0]));
-
-	ASSERT(n == n0);
-	for (i = 0; i < n && i < dcache_config.max_hash_collision; i++) {
-		if (labs(dcache_relocate_offset0[i])
-				> dcache_config.num_cache_entry / 2) {
-			dcache_config.max_hash_collision = i;
-			break;
-		}
-		dcache_relocate_offset[i] =
-				dcache_config.num_cache_entry
-				+ dcache_relocate_offset0[i];
-	}
-}
-
-void dcache_init(void)
-{
-	long n;
-
-	if (c.cache_config.num_cache_entry <= 0)
-		return;
-
-	/* release previous cache init, if any */
-	dcache_release();
-
-	dcache_blk = NULL;
-	dcache_lastused = NULL;
-	dcache_buf = NULL;
-	dcache_valid = NULL;
-
-	dcache_config = c.cache_config;
-
-	n = max(MIN_NUM_CACHE_ENTRY, dcache_config.num_cache_entry);
-
-	/* halve alloc size until alloc succeed, or min cache reached */
-	while (dcache_alloc_all(n) != 0 && n !=  MIN_NUM_CACHE_ENTRY)
-		n = max(MIN_NUM_CACHE_ENTRY, n/2);
-
-	/* must be the last: data dependent on num_cache_entry */
-	dcache_relocate_init();
-	dcache_initialized = true;
-
-	if (!dcache_exit_registered) {
-		dcache_exit_registered = true;
-		atexit(dcache_release); /* auto release */
-	}
-
-	dcache_raccess = 0;
-	dcache_rhit = 0;
-	dcache_rmiss = 0;
-	dcache_rreplace = 0;
-}
-
-static inline char *dcache_addr(long entry)
-{
-	return dcache_buf + F2FS_BLKSIZE * entry;
-}
-
-/* relocate on (n+1)-th collision */
-static inline long dcache_relocate(long entry, int n)
-{
-	assert(dcache_config.num_cache_entry != 0);
-	return (entry + dcache_relocate_offset[n]) %
-			dcache_config.num_cache_entry;
-}
-
-static long dcache_find(off_t blk)
-{
-	register long n = dcache_config.num_cache_entry;
-	register unsigned m = dcache_config.max_hash_collision;
-	long entry, least_used, target;
-	unsigned try;
-
-	assert(n > 0);
-	target = least_used = entry = blk % n; /* simple modulo hash */
-
-	for (try = 0; try < m; try++) {
-		if (!dcache_valid[target] || dcache_blk[target] == blk)
-			return target;  /* found target or empty cache slot */
-		if (dcache_lastused[target] < dcache_lastused[least_used])
-			least_used = target;
-		target = dcache_relocate(entry, try); /* next target */
-	}
-	return least_used;  /* max search reached, return least used slot */
-}
-
-/* Physical read into cache */
-static int dcache_io_read(int fd, long entry, off_t offset, off_t blk)
-{
-	if (lseek(fd, offset, SEEK_SET) < 0) {
-		MSG(0, "\n lseek fail.\n");
-		return -1;
-	}
-	if (read(fd, dcache_buf + entry * F2FS_BLKSIZE, F2FS_BLKSIZE) < 0) {
-		MSG(0, "\n read() fail.\n");
-		return -1;
-	}
-	dcache_lastused[entry] = ++dcache_usetick;
-	dcache_valid[entry] = true;
-	dcache_blk[entry] = blk;
-	return 0;
-}
-
-/*
- *  - Note: Read/Write are not symmetric:
- *       For read, we need to do it block by block, due to the cache nature:
- *           some blocks may be cached, and others don't.
- *       For write, since we always do a write-thru, we can join all writes into one,
- *       and write it once at the caller.  This function updates the cache for write, but
- *       not the do a physical write.  The caller is responsible for the physical write.
- *  - Note: We concentrate read/write together, due to the fact of similar structure to find
- *          the relavant cache entries
- *  - Return values:
- *       0: success
- *       1: cache not available (uninitialized)
- *      -1: error
- */
-static int dcache_update_rw(int fd, void *buf, off_t offset,
-		size_t byte_count, bool is_write)
-{
-	off_t blk;
-	int addr_in_blk;
-	off_t start;
-
-	if (!dcache_initialized)
-		dcache_init(); /* auto initialize */
-
-	if (!dcache_initialized)
-		return 1; /* not available */
-
-	blk = offset / F2FS_BLKSIZE;
-	addr_in_blk = offset % F2FS_BLKSIZE;
-	start = blk * F2FS_BLKSIZE;
-
-	while (byte_count != 0) {
-		size_t cur_size = min(byte_count,
-				(size_t)(F2FS_BLKSIZE - addr_in_blk));
-		long entry = dcache_find(blk);
-
-		if (!is_write)
-			++dcache_raccess;
-
-		if (dcache_valid[entry] && dcache_blk[entry] == blk) {
-			/* cache hit */
-			if (is_write)  /* write: update cache */
-				memcpy(dcache_addr(entry) + addr_in_blk,
-					buf, cur_size);
-			else
-				++dcache_rhit;
-		} else {
-			/* cache miss */
-			if (!is_write) {
-				int err;
-				++dcache_rmiss;
-				if (dcache_valid[entry])
-					++dcache_rreplace;
-				/* read: physical I/O read into cache */
-				err = dcache_io_read(fd, entry, start, blk);
-				if (err)
-					return err;
-			}
-		}
-
-		/* read: copy data from cache */
-		/* write: nothing to do, since we don't do physical write. */
-		if (!is_write)
-			memcpy(buf, dcache_addr(entry) + addr_in_blk,
-				cur_size);
-
-		/* next block */
-		++blk;
-		buf += cur_size;
-		start += F2FS_BLKSIZE;
-		byte_count -= cur_size;
-		addr_in_blk = 0;
-	}
-	return 0;
-}
-
-/*
- * dcache_update_cache() just update cache, won't do physical I/O.
- * Thus even no error, we need normal non-cache I/O for actual write
- *
- * return value: 1: cache not available
- *               0: success, -1: I/O error
- */
-int dcache_update_cache(int fd, void *buf, off_t offset, size_t count)
-{
-	return dcache_update_rw(fd, buf, offset, count, true);
-}
-
-/* handles read into cache + read into buffer  */
-int dcache_read(int fd, void *buf, off_t offset, size_t count)
-{
-	return dcache_update_rw(fd, buf, offset, count, false);
-}
-
 /*
  * IO interfaces
  */
@@ -511,7 +194,6 @@ static int sparse_write_zeroed_blk(__u64 UNUSED(block), int UNUSED(count))
 int dev_read(void *buf, __u64 offset, size_t len)
 {
 	int fd;
-	int err;
 
 	if (c.sparse_mode)
 		return sparse_read_blk(offset / F2FS_BLKSIZE,
@@ -521,11 +203,6 @@ int dev_read(void *buf, __u64 offset, size_t len)
 	if (fd < 0)
 		return fd;
 
-	/* err = 1: cache not available, fall back to non-cache R/W */
-	/* err = 0: success, err=-1: I/O error */
-	err = dcache_read(fd, buf, (off_t)offset, len);
-	if (err <= 0)
-		return err;
 	if (lseek(fd, (off_t)offset, SEEK_SET) < 0)
 		return -1;
 	if (read(fd, buf, len) < 0)
@@ -565,12 +242,6 @@ int dev_write(void *buf, __u64 offset, size_t len)
 	if (fd < 0)
 		return fd;
 
-	/*
-	 * dcache_update_cache() just update cache, won't do I/O.
-	 * Thus even no error, we need normal non-cache I/O for actual write
-	 */
-	if (dcache_update_cache(fd, buf, (off_t)offset, len) < 0)
-		return -1;
 	if (lseek(fd, (off_t)offset, SEEK_SET) < 0)
 		return -1;
 	if (write(fd, buf, len) < 0)
-- 
2.42.0.582.g8ccd20d70d-goog


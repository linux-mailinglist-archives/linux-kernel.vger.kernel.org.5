Return-Path: <linux-kernel+bounces-24988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6C482C5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14381C2212C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FE415AD7;
	Fri, 12 Jan 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtIkcx34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30A15AC6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE036C433C7;
	Fri, 12 Jan 2024 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705085947;
	bh=3ibygWlbfSkC0FBcuBrq55XAKl25vUGqLzjDUTlhUwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DtIkcx34By6VgPFf8lo2BTDnvhF6QQjOelSvfydld6vmUqrdazzSRqg0pIDwXN7Uo
	 H8k77MepDSjADQ6+o12Va2qKoR+Fsi8FA5TvLceCZkPHyFnaAwsJyVWehm55sXWPFX
	 /TLYirvpcvcqUi3V+O5qKWVGDcvTapvRDVSR1i57cvnKpe4bBwcA7NxRdKiJMmZ4GO
	 RTPCI1ib6ToxxEbz/dXoFDl5C6ubioYCFqJbiJIadjvVzrhIjUHXMbqWTHdQKwl22e
	 7i5J4q2Xd7VXIEh5ATPJB2CytgzqBuZkuM4lcytWnCg1wLF7odfhbmT+TfK2AFDoE+
	 86QwFMkrXh1hQ==
From: SeongJae Park <sj@kernel.org>
To: jgross@suse.com
Cc: sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] xen/xenbus: document will_handle argument for xenbus_watch_path()
Date: Fri, 12 Jan 2024 10:59:03 -0800
Message-Id: <20240112185903.83737-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2e85d32b1c86 ("xen/xenbus: Add 'will_handle' callback support in
xenbus_watch_path()") added will_handle argument to xenbus_watch_path()
and its wrapper, xenbus_watch_pathfmt(), but didn't document it on the
kerneldoc comments of the function.  This is causing warnings that
reported by kernel test robot.  Add the documentation to fix it.

Fixes: 2e85d32b1c86 ("xen/xenbus: Add 'will_handle' callback support in xenbus_watch_path()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401121154.FI8jDGun-lkp@intel.com/
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 drivers/xen/xenbus/xenbus_client.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index d4b251925796..d539210b39d8 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -116,14 +116,16 @@ EXPORT_SYMBOL_GPL(xenbus_strstate);
  * @dev: xenbus device
  * @path: path to watch
  * @watch: watch to register
+ * @will_handle: events queuing determine callback
  * @callback: callback to register
  *
  * Register a @watch on the given path, using the given xenbus_watch structure
- * for storage, and the given @callback function as the callback.  Return 0 on
- * success, or -errno on error.  On success, the given @path will be saved as
- * @watch->node, and remains the caller's to free.  On error, @watch->node will
- * be NULL, the device will switch to %XenbusStateClosing, and the error will
- * be saved in the store.
+ * for storage, @will_handle function as the callback to determine if each
+ * event need to be queued, and the given @callback function as the callback.
+ * Return 0 on success, or -errno on error.  On success, the given @path will
+ * be saved as @watch->node, and remains the caller's to free.  On error,
+ * @watch->node will be NULL, the device will switch to %XenbusStateClosing,
+ * and the error will be saved in the store.
  */
 int xenbus_watch_path(struct xenbus_device *dev, const char *path,
 		      struct xenbus_watch *watch,
@@ -156,16 +158,18 @@ EXPORT_SYMBOL_GPL(xenbus_watch_path);
  * xenbus_watch_pathfmt - register a watch on a sprintf-formatted path
  * @dev: xenbus device
  * @watch: watch to register
+ * @will_handle: events queuing determine callback
  * @callback: callback to register
  * @pathfmt: format of path to watch
  *
  * Register a watch on the given @path, using the given xenbus_watch
- * structure for storage, and the given @callback function as the callback.
- * Return 0 on success, or -errno on error.  On success, the watched path
- * (@path/@path2) will be saved as @watch->node, and becomes the caller's to
- * kfree().  On error, watch->node will be NULL, so the caller has nothing to
- * free, the device will switch to %XenbusStateClosing, and the error will be
- * saved in the store.
+ * structure for storage, @will_handle function as the callback to determine if
+ * each event need to be queued, and the given @callback function as the
+ * callback.  Return 0 on success, or -errno on error.  On success, the watched
+ * path (@path/@path2) will be saved as @watch->node, and becomes the caller's
+ * to kfree().  On error, watch->node will be NULL, so the caller has nothing
+ * to free, the device will switch to %XenbusStateClosing, and the error will
+ * be saved in the store.
  */
 int xenbus_watch_pathfmt(struct xenbus_device *dev,
 			 struct xenbus_watch *watch,
-- 
2.39.2



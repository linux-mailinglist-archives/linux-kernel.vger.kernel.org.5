Return-Path: <linux-kernel+bounces-63300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277DD852D69
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB501C203DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C3F23758;
	Tue, 13 Feb 2024 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrgfU7Zx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62C22EFB;
	Tue, 13 Feb 2024 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818642; cv=none; b=Zbmk9DpX/jlVj5yQdfEJny3IDrWJ/jQdDzCGEYBHjKzhUWEXblRZdnRfX0qhZntuaadHfZM3G+uMxalnsxtgnjCL+8mtldxT5K90CYlYfGoeV/RkwAsk2KlZ/TLQMOPcErQMG5RPS48gN+JncGof7GV7gpPrwP+77y4lUMCZYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818642; c=relaxed/simple;
	bh=AMPyajMBIKdkNHT3a2o6PUCBHMhRtBLpcuVcQ5oFUck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F6tHmUSzaz8WrLsQHjDGFuuO4m0QDhiBiAO3XtrtC/+NCowHnggoFbN7NSJNoytDLWlKEk8jMtAKvlamXSa8AW1YHArvB7IV0GmFqRVbD6VY5x6Jk8fIvi03jWj2hhzc+PNLFikZWn28qRfw4m2kUPRM4dotqkzhE+J5+jwUYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrgfU7Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF98C433C7;
	Tue, 13 Feb 2024 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818641;
	bh=AMPyajMBIKdkNHT3a2o6PUCBHMhRtBLpcuVcQ5oFUck=;
	h=From:To:Cc:Subject:Date:From;
	b=DrgfU7Zx6Etobfy1vv5gV1AHdFbilX9QehQ1OaWhDyfH6329fDE3v0nH7JlHBz2fb
	 PZzRouGmom4B5PIGODjMrlwOGNtQN6JSoO41ORbywm3BAUjUrYC8vsxmvxGoDbCei7
	 C7SIYU9AkC4UrNNhxOMG2/NQSo2ippl2uas//vJ0hcdhhWctvOQ0zO51dm1I90N3e2
	 6VnebmDZT3dYrXVGYH/Jrks8y0S1vO0Dwaw69Wpj/ClUOy5WdYuuRplyyEMNeNqkNK
	 Re3EJ4ITP7mGM5Vw7vvj8PBjN9pzRkc3nLL79nkBFVthLOkpiPTDh828Sw1rIjRZ9c
	 SdVWAIh87EmlQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] drbd: fix function cast warnings in state machine
Date: Tue, 13 Feb 2024 11:03:01 +0100
Message-Id: <20240213100354.457128-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There are four state machines in drbd that use a common infrastructure, with
a cast to an incompatible function type in REMEMBER_STATE_CHANGE that clang-16
now warns about:

drivers/block/drbd/drbd_state.c:1632:3: error: cast from 'int (*)(struct sk_buff *, unsigned int, struct drbd_resource_state_change *, enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct sk_buff *, unsigned int, void *, enum drbd_notification_type)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1632 |                 REMEMBER_STATE_CHANGE(notify_resource_state_change,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1633 |                                       resource_state_change, NOTIFY_CHANGE);
      |                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/block/drbd/drbd_state.c:1619:17: note: expanded from macro 'REMEMBER_STATE_CHANGE'
 1619 |            last_func = (typeof(last_func))func; \
      |                        ^~~~~~~~~~~~~~~~~~~~~~~
drivers/block/drbd/drbd_state.c:1641:4: error: cast from 'int (*)(struct sk_buff *, unsigned int, struct drbd_connection_state_change *, enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct sk_buff *, unsigned int, void *, enum drbd_notification_type)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1641 |                         REMEMBER_STATE_CHANGE(notify_connection_state_change,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1642 |                                               connection_state_change, NOTIFY_CHANGE);
      |                                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change these all to actually expect a void pointer to be passed, which
matches the caller.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/drbd/drbd_state.c        | 24 ++++++++++++++----------
 drivers/block/drbd/drbd_state_change.h |  8 ++++----
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 287a8d1d3f70..e858e7e0383f 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1542,9 +1542,10 @@ int drbd_bitmap_io_from_worker(struct drbd_device *device,
 
 int notify_resource_state_change(struct sk_buff *skb,
 				  unsigned int seq,
-				  struct drbd_resource_state_change *resource_state_change,
+				  void *state_change,
 				  enum drbd_notification_type type)
 {
+	struct drbd_resource_state_change *resource_state_change = state_change;
 	struct drbd_resource *resource = resource_state_change->resource;
 	struct resource_info resource_info = {
 		.res_role = resource_state_change->role[NEW],
@@ -1558,13 +1559,14 @@ int notify_resource_state_change(struct sk_buff *skb,
 
 int notify_connection_state_change(struct sk_buff *skb,
 				    unsigned int seq,
-				    struct drbd_connection_state_change *connection_state_change,
+				    void *state_change,
 				    enum drbd_notification_type type)
 {
-	struct drbd_connection *connection = connection_state_change->connection;
+	struct drbd_connection_state_change *p = state_change;
+	struct drbd_connection *connection = p->connection;
 	struct connection_info connection_info = {
-		.conn_connection_state = connection_state_change->cstate[NEW],
-		.conn_role = connection_state_change->peer_role[NEW],
+		.conn_connection_state = p->cstate[NEW],
+		.conn_role = p->peer_role[NEW],
 	};
 
 	return notify_connection_state(skb, seq, connection, &connection_info, type);
@@ -1572,9 +1574,10 @@ int notify_connection_state_change(struct sk_buff *skb,
 
 int notify_device_state_change(struct sk_buff *skb,
 				unsigned int seq,
-				struct drbd_device_state_change *device_state_change,
+				void *state_change,
 				enum drbd_notification_type type)
 {
+	struct drbd_device_state_change *device_state_change = state_change;
 	struct drbd_device *device = device_state_change->device;
 	struct device_info device_info = {
 		.dev_disk_state = device_state_change->disk_state[NEW],
@@ -1585,9 +1588,10 @@ int notify_device_state_change(struct sk_buff *skb,
 
 int notify_peer_device_state_change(struct sk_buff *skb,
 				     unsigned int seq,
-				     struct drbd_peer_device_state_change *p,
+				     void *state_change,
 				     enum drbd_notification_type type)
 {
+	struct drbd_peer_device_state_change *p = state_change;
 	struct drbd_peer_device *peer_device = p->peer_device;
 	struct peer_device_info peer_device_info = {
 		.peer_repl_state = p->repl_state[NEW],
@@ -1605,8 +1609,8 @@ static void broadcast_state_change(struct drbd_state_change *state_change)
 	struct drbd_resource_state_change *resource_state_change = &state_change->resource[0];
 	bool resource_state_has_changed;
 	unsigned int n_device, n_connection, n_peer_device, n_peer_devices;
-	int (*last_func)(struct sk_buff *, unsigned int, void *,
-			  enum drbd_notification_type) = NULL;
+	int (*last_func)(struct sk_buff *, unsigned int,
+		void *, enum drbd_notification_type) = NULL;
 	void *last_arg = NULL;
 
 #define HAS_CHANGED(state) ((state)[OLD] != (state)[NEW])
@@ -1616,7 +1620,7 @@ static void broadcast_state_change(struct drbd_state_change *state_change)
 	})
 #define REMEMBER_STATE_CHANGE(func, arg, type) \
 	({ FINAL_STATE_CHANGE(type | NOTIFY_CONTINUES); \
-	   last_func = (typeof(last_func))func; \
+	   last_func = func; \
 	   last_arg = arg; \
 	 })
 
diff --git a/drivers/block/drbd/drbd_state_change.h b/drivers/block/drbd/drbd_state_change.h
index 9d78d8e3912e..a56a57d67686 100644
--- a/drivers/block/drbd/drbd_state_change.h
+++ b/drivers/block/drbd/drbd_state_change.h
@@ -46,19 +46,19 @@ extern void forget_state_change(struct drbd_state_change *);
 
 extern int notify_resource_state_change(struct sk_buff *,
 					 unsigned int,
-					 struct drbd_resource_state_change *,
+					 void *,
 					 enum drbd_notification_type type);
 extern int notify_connection_state_change(struct sk_buff *,
 					   unsigned int,
-					   struct drbd_connection_state_change *,
+					   void *,
 					   enum drbd_notification_type type);
 extern int notify_device_state_change(struct sk_buff *,
 				       unsigned int,
-				       struct drbd_device_state_change *,
+				       void *,
 				       enum drbd_notification_type type);
 extern int notify_peer_device_state_change(struct sk_buff *,
 					    unsigned int,
-					    struct drbd_peer_device_state_change *,
+					    void *,
 					    enum drbd_notification_type type);
 
 #endif  /* DRBD_STATE_CHANGE_H */
-- 
2.39.2



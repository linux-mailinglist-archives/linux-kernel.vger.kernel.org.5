Return-Path: <linux-kernel+bounces-122470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764488F814
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C3D1C2423F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610A54F616;
	Thu, 28 Mar 2024 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGEG+uJG"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9E29CEF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711608376; cv=none; b=r53u+kkEQESZbE+cPY1x1NmMzviJQPVS8dp4MAqeOz56wIxI0PDP8tQwFDSuqO8qfyE45T4rQlC5T0ACoX6G+yfaw0wYiVI3dz4+SgxXpmPKY/tZ36sKIEsICsILzSgALHqdzyZeiIkbO6MK2zpAg9/u6cSZoaAmYQCSdr6Gwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711608376; c=relaxed/simple;
	bh=A0eqZc2Idq8YoVPpTu2o6tJ994aWXVyAWN+lD2sX1Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HTndsJIU/hDTFFF3T5dCXpcsuBcsOPoWvzB34vMZxz1GZLmcttIumnIhd41LiCoxiNyQGhbTgufAY4kH5ozI3METsDweu/BmNLG1ZYRhYLy8K/qtBB4779PFeUwAmrF2ECWujvrhUiYmk4yq6qsw0NMietohr+M3Rp4ofTtzbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGEG+uJG; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a48320f0f3so151761eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711608374; x=1712213174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdajnQBU4jDnyCtQCC669gXeD7BjwrpkfYPJe3b08SU=;
        b=AGEG+uJGy9QXmsVXybA6ArKZIo8Iwh+PiXDSBYfOFlhKffXiwSTyUV2Jiex2oC4lPl
         pHXpS3yJid2vwj5OWmeY/qSeVvhm9mFM75LPO4mahrOKOsNw2bzS0zJH52h7G/owS7HS
         mTLGI0SQmSvRut1qjYzcSngfFRf541fF/aLHw4lxcypjqYqNI2WJqGZrqzrMk8RQWNYH
         ok+w6jIS9Wq7jtOApDBn1ECIeEEFGhL8Om9IaqIPqhFS3RY0WZ7JCdTF6+nvPQKLm85O
         XrNKIdpaJwYzN47xkwE59TJxyZrkWJJynme0ywrFJNvOdqLNavkDgookQNCBsvr1d24L
         2gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711608374; x=1712213174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdajnQBU4jDnyCtQCC669gXeD7BjwrpkfYPJe3b08SU=;
        b=oUuDUQLfaETIxrncVvNCIH7ZlDkdyWLWw2q9zZVxPik3eAtSeFCdVGFlYDbfdn/a8V
         C8Rk65//2aA2xniV1PpkSqA6Ew44Wxr5gFIY2+LgF+T4mR+Cxsu98Xng4r1Xc7TfHF6r
         xMRZdAxT9WYC08+YCvFCCUNXWALQpJLqd9AdN9LrW4peKeiiQQKKoilTbQfOLd91MYOc
         olnAMnlPxHUkPcngRitJ92PQAGODRUzD3M3ytqOoueksGQH3DU6+Jh3u3d44MxGVCh2z
         KyMxFPUdb5qsqxupjFj/gQq5w/cnMFJbDXhFszG5SfvIBIeCzwji3ZhGKHq/w8XrBlwa
         sIiw==
X-Gm-Message-State: AOJu0YyXSrIx6gtAKXXu1eOiBhWwiBWTieJ159WQPaLQ4IDRsBUJ+yyJ
	pKUTK+DO0l0cIdxkUOOknrcKPsOa0MPq1ZlesR0CVpFDzCFX7w4j
X-Google-Smtp-Source: AGHT+IFegp8DMhCskJJfBONUhKvJscDzs4jPfvx4ybQq1Y6D1vPon/xwZFbkG9T5qmfrTTDbkJ4HFQ==
X-Received: by 2002:a05:6808:1829:b0:3c3:c913:2709 with SMTP id bh41-20020a056808182900b003c3c9132709mr2378923oib.2.1711608374146;
        Wed, 27 Mar 2024 23:46:14 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:7dc2:a884:7fe:b8b5])
        by smtp.gmail.com with ESMTPSA id p43-20020a056a0026eb00b006e6b12d650asm636734pfw.31.2024.03.27.23.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 23:46:13 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] rbtree: Introduce rb_remove()
Date: Thu, 28 Mar 2024 14:45:39 +0800
Message-Id: <20240328064539.95795-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the function "rb_remove()", which can perform the removal of a
certain key from the tree. Once the node with the searched key is found,
we call "rb_erase()" to perform the removal of the node, otherwise the
key doesn't exists in the tree then we return NULL.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 include/linux/rbtree.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index f7edca369..1958be66f 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -302,6 +302,34 @@ rb_find_first(const void *key, const struct rb_root *tree,
 	return match;
 }
 
+/**
+ * rb_remove() - remove @key in tree @tree
+ * @key: key to remove
+ * @tree: tree to modify
+ * @less: operator defining the (partial) node order
+ */
+static __always_inline struct rb_node *
+rb_remove(const void *key, const struct rb_root *tree,
+	  int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = node->rb_left;
+		else if (c > 0)
+			node = node->rb_right;
+		else {
+			rb_erase(node, tree->rb_node);
+			return node;
+		}
+	}
+
+	return NULL;
+}
+
 /**
  * rb_next_match() - find the next @key in @tree
  * @key: key to match
-- 
2.34.1



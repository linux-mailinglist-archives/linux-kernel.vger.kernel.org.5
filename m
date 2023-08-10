Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148447777E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjHJMMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjHJMMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7DE26AA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691669497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2mTwC/A1bemPLD8wVSu1bItAbEwKoB4ThQwlpab2yo=;
        b=U7EmSq/mWoX7s/geXBLuG8OAWMFsxkAxKlv6ExJL8dSk+LR/yAaXK8e2BZ+GuxWRFX9a03
        17VwExKWfcGQVFjm6NUDsYOyRQsHFkkyHtMJQmTzafoSpYZjfRRSgWbiiXCGAUdOFBvw9r
        zKbLSixe4gHMB9hiVGz01tCszg4wob4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-Mi8AftagPdmWdIKfePxX9g-1; Thu, 10 Aug 2023 08:11:36 -0400
X-MC-Unique: Mi8AftagPdmWdIKfePxX9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB87285CBE7;
        Thu, 10 Aug 2023 12:11:35 +0000 (UTC)
Received: from o.redhat.com (unknown [10.39.192.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FB0140C2076;
        Thu, 10 Aug 2023 12:11:34 +0000 (UTC)
From:   heinzm@redhat.com
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, xni@redhat.com
Subject: [PATCH 2/3] md raid1: make first_clone a bool
Date:   Thu, 10 Aug 2023 14:11:31 +0200
Message-ID: <d6913d99e76bb72d3561fc9665e089fa5c7a1fb3.1691592775.git.heinzm@redhat.com>
In-Reply-To: <cover.1691592775.git.heinzm@redhat.com>
References: <cover.1691592775.git.heinzm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: heinzm <heinzm@redhat.com>

first_clone is used as a bool so make it one.

Signed-off-by: heinzm <heinzm@redhat.com>
---
 drivers/md/raid1.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 913cd46b786b..0aed74efd758 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1337,9 +1337,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct bitmap *bitmap = mddev->bitmap;
 	unsigned long flags;
 	struct md_rdev *blocked_rdev;
-	int first_clone;
 	int max_sectors;
-	bool write_behind = false;
+	bool first_clone, write_behind = false;
 
 	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
@@ -1505,7 +1504,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	atomic_set(&r1_bio->remaining, 1);
 	atomic_set(&r1_bio->behind_remaining, 0);
 
-	first_clone = 1;
+	first_clone = true;
 
 	for (i = 0; i < disks; i++) {
 		struct bio *mbio = NULL;
@@ -1528,7 +1527,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 			md_bitmap_startwrite(bitmap, r1_bio->sector, r1_bio->sectors,
 					     test_bit(R1BIO_BehindIO, &r1_bio->state));
-			first_clone = 0;
+			first_clone = false;
 		}
 
 		if (r1_bio->behind_master_bio) {
-- 
2.41.0


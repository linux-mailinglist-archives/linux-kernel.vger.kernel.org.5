Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CC577B82B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjHNMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjHNMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3381984
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692014478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kgb1jw0bzFWkffgnm96Ld5vnVs7PAmnVM7ePjYfLhG0=;
        b=MiJAu+BfH1uo13cLYa95YwW8rl/EttRqhrNF3rQKVb75O603agUZ5bt1xOfkGRKm4Ktw6D
        b1NSrSoc5KiB0N0R+hpLW5vFAwBcWioesDmT/349GU5/DlL+BHxiZPe2e24jUTtU9H5Qim
        /Rwajk4jmr5xfJXbQWPze78J/1tOUGk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-4dYH5Rj3P0qmCT4XJv9qrQ-1; Mon, 14 Aug 2023 08:01:17 -0400
X-MC-Unique: 4dYH5Rj3P0qmCT4XJv9qrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E45A53802131;
        Mon, 14 Aug 2023 12:01:16 +0000 (UTC)
Received: from o.redhat.com (unknown [10.39.192.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 387441121314;
        Mon, 14 Aug 2023 12:01:16 +0000 (UTC)
From:   heinzm@redhat.com
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     xni@redhat.com, ncroxon@redhat.com
Subject: [PATCH v2] md raid1: allow writebehind to work on any leg device set WriteMostly
Date:   Mon, 14 Aug 2023 14:01:15 +0200
Message-ID: <2a9592bf3340f34bf588eec984b23ee219f3985e.1692013451.git.heinzm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinz Mauelshagen <heinzm@redhat.com>

This is version 2 replacing my previous patch series as requested by Song Liu.

As the WriteMostly flag can be set on any component device of a RAID1
array, remove the constraint that it only works if set on the first one.


Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Tested-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index dd25832eb045..913cd46b786b 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1519,7 +1519,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			 * allocate memory, or a reader on WriteMostly
 			 * is waiting for behind writes to flush */
 			if (bitmap &&
-			    test_bit(WriteMostly, &rdev->flags) &&
+			    write_behind &&
 			    (atomic_read(&bitmap->behind_writes)
 			     < mddev->bitmap_info.max_write_behind) &&
 			    !waitqueue_active(&bitmap->behind_wait)) {
-- 
2.41.0


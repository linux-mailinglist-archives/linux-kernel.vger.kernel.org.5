Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E27777E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjHJMM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjHJMMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA6B1982
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691669496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MplB6YhphBAcNbfgEP4dpmv/8GnOMVzO201/lFbJ2Z4=;
        b=eaOpYisNkNFMnEPYjursfiRtUiConkx3E8VHJivhKxCAYcidcK63abK3C97pZOS9CsQSgx
        136MPu/Tr1P7rrXP9Jiq0heCc9yrDmDnyUxgXEg1y+0bZ9nz59aE80brmTVHnjIOxXh6IH
        nUW9RcZqubQLLSJRR7CP1jX7HoiVPqo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-SU0nEepTNE-IarH6p96YHg-1; Thu, 10 Aug 2023 08:11:35 -0400
X-MC-Unique: SU0nEepTNE-IarH6p96YHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDCB4857A84;
        Thu, 10 Aug 2023 12:11:34 +0000 (UTC)
Received: from o.redhat.com (unknown [10.39.192.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F69C40C2077;
        Thu, 10 Aug 2023 12:11:33 +0000 (UTC)
From:   heinzm@redhat.com
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, xni@redhat.com
Subject: [PATCH 1/3] md raid1: allow writebehind to work on any leg device set WriteMostly
Date:   Thu, 10 Aug 2023 14:11:30 +0200
Message-ID: <31b94de1196389c8d5e7a29d01ec1e7d20735d4e.1691592775.git.heinzm@redhat.com>
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

As the WriteMostly flag can be set on any component device of a RAID1 array,
remove the constraint that it only works if set on the first one.

Signed-off-by: heinzm <heinzm@redhat.com>
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


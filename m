Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2061F7DCFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjJaOok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344319AbjJaOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594AADA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698763426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xXlUwrZ8a+TiVbwN/xlzrhXNH8IBziMOpwtSPkVcE7I=;
        b=GJ1iqCbApRyL0eJNzcCjKXNxC6l+11DD9o3fYtGEKRLgYe7qK11H94n59EHcPgF68235ZW
        ipfNUfza9asXB6bqGMsXBD9VpykJCUxN77gW9yCLMdAmrAGFLtlX5kd+IQ9jYzpFn49jAX
        dmxqu2uraoIZbKD02XE0aevBi88tBhE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-vpOiIKskOfKYgd17sxPdxg-1; Tue, 31 Oct 2023 10:43:44 -0400
X-MC-Unique: vpOiIKskOfKYgd17sxPdxg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d30af2399bso1077096a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698763424; x=1699368224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXlUwrZ8a+TiVbwN/xlzrhXNH8IBziMOpwtSPkVcE7I=;
        b=Z9EkhRvFmey9aUsPm6kDeY3DhhJ+MVthX46F76rjDEEpThtcox6LpsSC0SgIt5uA1Y
         tTnDX98e2hpJDMX4qOC23/MS1U1dBYy9KzPckQ5Q0Inln7h93pA22GFCyLNdtA2FKM42
         QBHxcVilD14kWOlESM9tIApwGTLhPcJmeLstEpWwtigeBbaUJRoTlvj4ijdCusRATGM/
         cfcn6gfgsJBf5odRzMpvYSSBFNOlvqE18Yd8O1hV+uLWyq25kP2w829tnPdhRRd8Gj16
         VvD0Bbk9rkrgb4aO5whXwiemGc9Iwl+YA0YUkRFwWcbg4ZitX5AJOpCKZLR3iKdHH9A0
         NN/w==
X-Gm-Message-State: AOJu0Yy5ZvVzoeNWjiz9zrHxqXNAKa76x/XJ3y9TLuBDyCdt3rPxzN/t
        EQQbds10QhrYjByHVxavv0uQem+Z2zTmv+dxNUz4LG4cERxua5JXeIXMkK+cf0mzsvt+8bMBdoC
        mi+QROou/7c5zrES7gSLUlvXH
X-Received: by 2002:a05:6830:1e35:b0:6d3:a14:f3f1 with SMTP id t21-20020a0568301e3500b006d30a14f3f1mr2374206otr.7.1698763424288;
        Tue, 31 Oct 2023 07:43:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFBHVEKDScky83TG83898xQYY2ysehM/b/1rfoz+oNpMActtM8216vJOH2Z5EptpCShbw5hQ==
X-Received: by 2002:a05:6830:1e35:b0:6d3:a14:f3f1 with SMTP id t21-20020a0568301e3500b006d30a14f3f1mr2374193otr.7.1698763424028;
        Tue, 31 Oct 2023 07:43:44 -0700 (PDT)
Received: from step1.redhat.com ([5.179.178.82])
        by smtp.gmail.com with ESMTPSA id j7-20020ac84c87000000b004181e5a724csm544231qtv.88.2023.10.31.07.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 07:43:43 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Qing Wang <qinwang@redhat.com>
Subject: [PATCH] vdpa_sim_blk: allocate the buffer zeroed
Date:   Tue, 31 Oct 2023 15:43:39 +0100
Message-ID: <20231031144339.121453-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deleting and recreating a device can lead to having the same
content as the old device, so let's always allocate buffers
completely zeroed out.

Fixes: abebb16254b3 ("vdpa_sim_blk: support shared backend")
Suggested-by: Qing Wang <qinwang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index b3a3cb165795..b137f3679343 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -437,7 +437,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (blk->shared_backend) {
 		blk->buffer = shared_buffer;
 	} else {
-		blk->buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+		blk->buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
 				       GFP_KERNEL);
 		if (!blk->buffer) {
 			ret = -ENOMEM;
@@ -495,7 +495,7 @@ static int __init vdpasim_blk_init(void)
 		goto parent_err;
 
 	if (shared_backend) {
-		shared_buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+		shared_buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
 					 GFP_KERNEL);
 		if (!shared_buffer) {
 			ret = -ENOMEM;
-- 
2.41.0


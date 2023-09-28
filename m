Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855C47B17A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjI1Jji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjI1JjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:39:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CC6CE0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40535597f01so128190245e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1695893942; x=1696498742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxdqCPbXhmzZcYHHWzAs1Pz189GcHmpMYCt/LIrBVmA=;
        b=defPPbsL31qtr6Fegpk+sAyp/swDW33q+GGjJfm2HTUJBv1BXu4Yz/obKNEjhlODV3
         FhWVgZyPQfTjtl/IfBLB0ay4Vr4hvmNUeyp3zgWJloAIymdu8BsIayJlOPkhtuD1cium
         e0LOnSuwZCLSaz7I0euNIkAmht+SDP3LBF2w0d4q9jYUbujT40YXccUKDdnr3Mwka+x6
         +4Stdr0uux2cHqTe/trKh6Yu0nUcYjr8Jtes6b3D/0f4Z3cewVQTrBFEc7oGmrVs7CJf
         bT5LZFeJ08cYFkqP5GVSRszrsq32sjQ8O2xJ2gb6mbA0ZaGIQMpDtls3SnsQHmFF8WFl
         xKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893942; x=1696498742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxdqCPbXhmzZcYHHWzAs1Pz189GcHmpMYCt/LIrBVmA=;
        b=sWITgx9399Vx+cuJ2Y+LOdmPwRYvolbYmLpCR/e6hXL8eVIRmzElU2/RrlY4xfBiyv
         XR9UDv75ofvL35Wj/mruLKLaKg0zm+g5YBUYem6AZAiszMeO0KgrA1JWV9nhqFqCqRbK
         oJ4LpqY2qxzEwxVOknLzuhUdQE4QYLEUo+ZfLC1zX6pfgWNvqm1r/SxK3AiGB7nfP90u
         9uaTFX5vQpxwrdrCSjKu+JXVitfuBHIRbJiajTEoWw+CZ8yk0aMM/FNftT9+lBnII8aG
         NYx5gkv2S9QvI+XBZLDFncIaUHvDPDiiY85EsvrKH8Hv0Z4dCgky6PRRIHNM4wVQd4Wd
         lVcA==
X-Gm-Message-State: AOJu0YziG0+2nCpHar2ZTl9cujxThXadrEjrhKk7siW02KIuH8B1AgmS
        vnonD4nTE0CCLFE1fp4aGq4ezA==
X-Google-Smtp-Source: AGHT+IFXErMwVQh26NX4Lo+CN3tqVv9eERZaRoI/iWHEjF+72aA0bMsuVLkXufdDKwDB+VZd3qOeDQ==
X-Received: by 2002:a05:6000:10c4:b0:319:77dd:61f9 with SMTP id b4-20020a05600010c400b0031977dd61f9mr668384wrx.35.1695893942239;
        Thu, 28 Sep 2023 02:39:02 -0700 (PDT)
Received: from localhost.localdomain (213-225-13-130.nat.highway.a1.net. [213.225.13.130])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0031fa870d4b3sm18931449wrt.60.2023.09.28.02.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:39:01 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Joel Colledge <joel.colledge@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 3/5] drbd: Move connection independent work from "sender" to "worker"
Date:   Thu, 28 Sep 2023 11:38:50 +0200
Message-ID: <20230928093852.676786-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 drivers/block/drbd/drbd_req.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0c9f54197768..6e21df44b5aa 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5890,7 +5890,7 @@ static int got_OVResult(struct drbd_connection *connection, struct packet_info *
 		if (dw) {
 			dw->w.cb = w_ov_finished;
 			dw->device = device;
-			drbd_queue_work(&peer_device->connection->sender_work, &dw->w);
+			drbd_queue_work(&device->resource->work, &dw->w);
 		} else {
 			drbd_err(device, "kmalloc(dw) failed.");
 			ov_out_of_sync_print(peer_device);
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index cd56fd0f3b06..fbb47138a52b 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -823,8 +823,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 
 		get_ldev(device); /* always succeeds in this call path */
 		req->w.cb = w_restart_disk_io;
-		drbd_queue_work(&connection->sender_work,
-				&req->w);
+		drbd_queue_work(&device->resource->work, &req->w);
 		break;
 
 	case RESEND:
-- 
2.41.0


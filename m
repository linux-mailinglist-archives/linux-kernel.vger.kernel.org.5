Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5795D7E2FC1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjKFWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjKFWVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:21:11 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4E0D6E;
        Mon,  6 Nov 2023 14:21:09 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1e9e4636ce6so476546fac.0;
        Mon, 06 Nov 2023 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699309268; x=1699914068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk1iGqzSFhqcLXMUJQBLSwculIJFSVmZJKxDlYOyfpY=;
        b=WOVjzewsq3/y9eXUAdiAZ2CFK4bHu9BPXC3HKVx/MRSZuJ/r47AtXuos6EbFQLn1ZY
         t5QxcNLL1q80pL5Zvv6ivZjRpihdkmVGn5tRGDJoaOwLOvQ7oQi4w8MYsGSNnM/hbFaQ
         bG8kUriiJEX2tuHZMRezDi/v0Oqj1I9+0RyhiDehAhfaFWkRYHmG8PxHbZMSQ3CYpvZB
         1WFfvgMqH1+xslmtOsjekiDQ8edUfBvvWvgU15kCbYnd7HbatPNI19S6f8lwaqMNKRjX
         HObUXR+y2snam51owS1ZRGVzoQ5J/5vwrk76FIqkSlLgB4lPzJu9h9DWQs+miQN1RXq6
         famw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699309268; x=1699914068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk1iGqzSFhqcLXMUJQBLSwculIJFSVmZJKxDlYOyfpY=;
        b=TfI0ZDaQJL5pLsIqCFLJ3HuuYjO1x/S3i6IOAZBPq0zDmfEDC3CX2vRh35GuLk8ioW
         TjwFpDnC3V/Gz1HY0L2WS+dU5sQVUxHV34FKmzihhOCrXzFin2kxVxSKf0EGGc5DDxVs
         pO4EvAHRg6LoBVp+kPkKKyjK02s11paAJpbESMkJS4Ilz/AmgUxKrEAJTp/XyqjxkmWI
         xRJdIduRzqeGNEtZzPQwbVfVoXIyiFRIQkeWwkB0diH8BRIpZpHhlcrfQEsWcJ+14TLK
         0jFu4wyGaGtUtdmukumoqHLlploAiQR6PPiF0ZQvj3QkHi/O6sf2lev46beF6LtJ9NaG
         rGXg==
X-Gm-Message-State: AOJu0Yy+/mrigYS+NWSq0l0H2T0scxYp7Dpc4Hceo2KJwoOfxvqCCpBT
        fLhFpW12ylqKlfYGEHfC57A=
X-Google-Smtp-Source: AGHT+IFrQVI3UuOVAMqIkpO31ev7YOIxC0kgQ+xbMLCn9eC76+pRj/jd6eEkJJQYjVE7MHOWeg1B+g==
X-Received: by 2002:a05:6358:6f0e:b0:16b:6e91:f7f8 with SMTP id r14-20020a0563586f0e00b0016b6e91f7f8mr2559604rwn.0.1699309268298;
        Mon, 06 Nov 2023 14:21:08 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id b7-20020a63cf47000000b00588e8421fa8sm217869pgj.84.2023.11.06.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:21:07 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] s390/qeth: Fix typo 'weed' in comment
Date:   Tue,  7 Nov 2023 06:20:59 +0800
Message-Id: <20231106222059.1475375-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'weed' with 'we' in the comment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 6af2511e070c..cf8506d0f185 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3675,7 +3675,7 @@ static void qeth_flush_queue(struct qeth_qdio_out_q *queue)
 static void qeth_check_outbound_queue(struct qeth_qdio_out_q *queue)
 {
 	/*
-	 * check if weed have to switch to non-packing mode or if
+	 * check if we have to switch to non-packing mode or if
 	 * we have to get a pci flag out on the queue
 	 */
 	if ((atomic_read(&queue->used_buffers) <= QETH_LOW_WATERMARK_PACK) ||
-- 
2.25.1


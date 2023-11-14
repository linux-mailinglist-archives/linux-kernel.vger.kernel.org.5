Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2B7EAEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjKNLTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjKNLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2327D12C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699960788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5YJYH1v0uugBJ+ptP05BEEV2yywxHJ1l8QRV0Sx86TE=;
        b=D2aNx1vRqIYdZI94bYeGyXrO4qs9uTbfXLvSe2xXs0US1CqjMSQC4mI6cJynZ1R6qnISBI
        +uWykoOPLh4QIv+LbI1IfNX1CsKyNOg/4koDfzZJYc3+38iMNoWynLqVTicwxisOWmoQfh
        OAyHFa+GuErUuvVPtyc0pKCeXJLY1iY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-XYzdVEqzMciNKLWx2Uhjsg-1; Tue, 14 Nov 2023 06:19:46 -0500
X-MC-Unique: XYzdVEqzMciNKLWx2Uhjsg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5094bb86ebfso767455e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699960785; x=1700565585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YJYH1v0uugBJ+ptP05BEEV2yywxHJ1l8QRV0Sx86TE=;
        b=UmvDSilfNARrhSLhzMdOvc3fS0y6hIEhjrv5I6FFQAUzdiFkRi1AhpB2IdRt6f+jGX
         69Hk/fCMs/VF0HmJGD0YgBOc9blfpa/MGy4zs87bzQ0o1ucDuclzgAySA3Mtjv4Mp7mr
         YMAvbvJIiN9hU6/2bfwLOunjvUfSXHiREuzMQYeqcciX3DqajHBB10xBmxxKF4lreYtQ
         5vUvrfrZL+83fcmGzHPGPbZ7C/xE5LA6OoslMPJ+CeDiG2A4Q3NiV19wyv3zMFdMe1is
         Ep5xJxw56iV8K5fX03KTG8maZ7rJtexIZXkRTquKVlXF0arEMXbdGjGrDS5PuxpFq7xS
         lxEQ==
X-Gm-Message-State: AOJu0YxCNpu+kPV4mFAFZZ6CpnYRUlNHaUvnZJh94Xu1BliYQoJmPiNj
        w2E69ZOpBdnd0xD0Y2vpuyC+ez6Phwa+vErgCIbWSASLzwq3tls+asBGDDI1H6kVweSBuXr3HaP
        CWCiYoDP0Hj3uOdb01nUfiQrE
X-Received: by 2002:a05:6512:48cd:b0:507:9d5c:62e3 with SMTP id er13-20020a05651248cd00b005079d5c62e3mr1195100lfb.5.1699960785290;
        Tue, 14 Nov 2023 03:19:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdb04nRiqIQnJcrT16Dda91bu/bXi3ErlEL/19p/NPUTa0J9CdAk9QVyXhqvTifytDdFyFmA==
X-Received: by 2002:a05:6512:48cd:b0:507:9d5c:62e3 with SMTP id er13-20020a05651248cd00b005079d5c62e3mr1195082lfb.5.1699960784990;
        Tue, 14 Nov 2023 03:19:44 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:90a:30ce:554c:3b85:52df:8c32])
        by smtp.gmail.com with ESMTPSA id 27-20020a508e1b000000b0053e89721d4esm5039345edw.68.2023.11.14.03.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 03:19:44 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH v2] drivers/fpga: use standard array-copy function
Date:   Tue, 14 Nov 2023 12:19:02 +0100
Message-ID: <20231114111901.19380-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dfl.c utilizes memdup_user() and array_size() to copy a userspace array.
array_size() will likely never trigger thanks to the preceeding check.
Nevertheless, in the theoretical event that it would, it would return
SIZE_MAX to memdup_user(), resulting in an attempt to allocate huge
amounts of memory.

string.h from the core-api now provides memdup_array_user() which also
performs an overflow check and returns an error-pointer with -EOVERFLOW
to the caller.
As an additional advantage it standardizes how userspace-arrays are
being copied and, thus, makes it more obvious to readers that an array
is being copied.

Replace memdup_user() with memdup_array_user().

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
- Rewrite commit's name and message to clarify the patch's advantages
---
 drivers/fpga/dfl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index dd7a783d53b5..e69b9f1f2a50 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -2008,8 +2008,8 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 	    (hdr.start + hdr.count < hdr.start))
 		return -EINVAL;
 
-	fds = memdup_user((void __user *)(arg + sizeof(hdr)),
-			  array_size(hdr.count, sizeof(s32)));
+	fds = memdup_array_user((void __user *)(arg + sizeof(hdr)),
+				hdr.count, sizeof(s32));
 	if (IS_ERR(fds))
 		return PTR_ERR(fds);
 
-- 
2.41.0


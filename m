Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028117E023D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjKCLbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjKCLbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA59134
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699011065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1e9VakvLuO9AJ2KzUAGqzMN6gS+iv5oxh/hyIPNBpX4=;
        b=VPiziRglnQ4IkAVuNueRsVqzmxi2d/C65MM74dZTBer0hcfcx0SQUP7/lMB/LCgxaHsAN0
        7OHqgM80yD024zSTRqxAHs92wGxpGq9OqLrAEidOVyW5zthgoNkct4t4Bs9ieh2fLQbI0D
        81hBhsNWTid9c2ft9Q0M7SB2gL9q4Aw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-_oZGRi8XOgSflYrTojT5zQ-1; Fri, 03 Nov 2023 07:31:03 -0400
X-MC-Unique: _oZGRi8XOgSflYrTojT5zQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-53f8893ddbdso385662a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699011062; x=1699615862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1e9VakvLuO9AJ2KzUAGqzMN6gS+iv5oxh/hyIPNBpX4=;
        b=JcWqkKdbSEgeUeVBhOAOPteucKZ3b1l3wuD7pSYth6SqLq2hE2JFGuJ/ZSiSef0bLS
         cCR5rkvOSB78e4Z804a1sVvsa0bTFNyOsiln98DUehBUbgmgm4xA6rnvBvqxntRmioel
         d9O+IKEzEG9R0p+PdmrWzoPKNsWOUCz1MHm8HKH9ahgIsFWUxtX4xPYPiywOQn1+JWNL
         OCeXUi1JtuTNcvfoi+rmHW/PFnnkaTGhcjzZZfBtdTXyrzgn38Pz2OoVQvMKVjiIHPfz
         nwbztXkny2hjYTUdZ4dKCRR5/JkI15Bi0MMAD82rTfPYZfd10eanb4IT1dWwoPhE0/UL
         JYgA==
X-Gm-Message-State: AOJu0Yxu90neSdTHj5wuKrq42Zju+Wt1+eu6/Z5MJ3VJpkJWwcj/x7oi
        qFYmI7xpq596+xEOjbWbL1xLQnWYyvvn6BuaT1q+tAPgtAgwMSflWnyYSmy3l7CPxQHtG+XC3op
        QJoiCuXMw2dhwkC6s2B0Kf1sx
X-Received: by 2002:a05:6402:e9b:b0:542:a609:167f with SMTP id h27-20020a0564020e9b00b00542a609167fmr18233539eda.1.1699011062604;
        Fri, 03 Nov 2023 04:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4JRUDEt5Yy5vBFanWHerpkas8W6GmYxSnD8ToXA7e6i8DhmLr4oeS0ZYDxEOCqCCT1UplXg==
X-Received: by 2002:a05:6402:e9b:b0:542:a609:167f with SMTP id h27-20020a0564020e9b00b00542a609167fmr18233521eda.1.1699011062295;
        Fri, 03 Nov 2023 04:31:02 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32d1:5200:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id f11-20020a50d54b000000b0054351b5a768sm864607edj.82.2023.11.03.04.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 04:31:02 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Stanner <pstanner@redhat.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: [PATCH v2] drivers/comedi: use standard array-copy-function
Date:   Fri,  3 Nov 2023 12:29:33 +0100
Message-ID: <20231103112932.75795-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

comedi_fops.c utilizes memdup_user() to copy a userspace array.

The new function memdup_array_user() provides a standardized way to copy
userspace-arrays. It makes it easier to see that an array is being
copied and, additionally, performs a generic overflow-check which might
help make the code more robust in case of changes in the future.

Replace memdup_user() with memdup_array_user().

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
---
Changes in v2:
- Rephrase commit message so that it doesn't sound as if an actual
  overflow is being fixed here. (Greg K-H)
- Add Reviewed-by from Ian Abbott
---
 drivers/comedi/comedi_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 1548dea15df1..1b481731df96 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1714,8 +1714,8 @@ static int __comedi_get_user_chanlist(struct comedi_device *dev,
 
 	lockdep_assert_held(&dev->mutex);
 	cmd->chanlist = NULL;
-	chanlist = memdup_user(user_chanlist,
-			       cmd->chanlist_len * sizeof(unsigned int));
+	chanlist = memdup_array_user(user_chanlist,
+				     cmd->chanlist_len, sizeof(unsigned int));
 	if (IS_ERR(chanlist))
 		return PTR_ERR(chanlist);
 
-- 
2.41.0


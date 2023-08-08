Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F141774520
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjHHShg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjHHShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD6B11F79
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691512086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rdR/nWVu06E+qaDd21vThD7HnAhSxkVHgZWXT66GKkM=;
        b=Lfyb+qry2FT1+ixwQ5tbKwXnA4ofoGY5TgGyiuxqECQ/RONb7ZIqudvb9FxyoyV3d3U/s9
        hCmA+Tnhqar6EtXZlEwtN2nj5nLe+gMBDuxZwM1qTTl0u0XJPiGdF5B9O4tRkt3eGd8Glz
        TpimB9852M9M6xv7YskEHYqgQAxGz/8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Vj3WET0WNfCb3PiJIYC3fw-1; Tue, 08 Aug 2023 10:27:12 -0400
X-MC-Unique: Vj3WET0WNfCb3PiJIYC3fw-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-d4db064e4e2so3554564276.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 07:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691504831; x=1692109631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdR/nWVu06E+qaDd21vThD7HnAhSxkVHgZWXT66GKkM=;
        b=LyeXm2QQT+YXHX6lJV2ZWcPWpQG0HBWFuTZ4MP6epsCh0nYipHqQfNCsFMnixEyGG9
         yceH05EzWCGis8DZ0vgsC5xMzSMM330q3HlZr8622NAfFFWbFtEU1qw+cxORsUmHzLgU
         hy9hdLgJeRGH1kgL9iKMcRb1Tsdy0YnFyqk30ZSGY39MbP6HgzteuSQjBWgrrIKFtAo4
         abq4mJXzygGoriP6jdlFv3YrSH0BKNApzOA4RIuiv9ffr/+XqGqvRxRDt5pw8V4VFCaS
         ZwE9Ol8aZT+Asg7U6fDXVq3mR520v9suJXoMeFiIndhs5GrJNxnwy2ESIv6sEvAsi13D
         9DbQ==
X-Gm-Message-State: AOJu0YxkATTkmyUty0JiV3eXksLApQguj/ulvPA5iCBkpTEA7H/dxofc
        KNyu/QwCZkVV1m0c6H0LmKhOprwGC9RLUCuf8JYNW3QUyX2081jA8XUBuSbYIKP0hl2QEIuoaW6
        JHFNazXFGRMnk25C6HZy8TI8B
X-Received: by 2002:a25:aa31:0:b0:ced:6134:7606 with SMTP id s46-20020a25aa31000000b00ced61347606mr13222320ybi.30.1691504831616;
        Tue, 08 Aug 2023 07:27:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYUnMBFGOvVTn0B2fVJuWFGk0rbvX7MlTI9s+MDkABAAgnqZK/6AMRAo9gbZmrxokTCuY6Gg==
X-Received: by 2002:a25:aa31:0:b0:ced:6134:7606 with SMTP id s46-20020a25aa31000000b00ced61347606mr13222304ybi.30.1691504831336;
        Tue, 08 Aug 2023 07:27:11 -0700 (PDT)
Received: from brian-x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y9-20020a259c89000000b00c71e4833957sm2713058ybo.63.2023.08.08.07.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 07:27:10 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] scsi: ufs: convert probe to use dev_err_probe()
Date:   Tue,  8 Aug 2023 10:26:48 -0400
Message-ID: <20230808142650.1713432-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two log messages are shown on bootup due to an
-EPROBE_DEFER when booting on a Qualcomm sa8775p development board:

    ufshcd-qcom 1d84000.ufs: ufshcd_variant_hba_init: variant qcom init
        failed err -517
    ufshcd-qcom 1d84000.ufs: Initialization failed

This patch series converts the relevant two probe functions over to use
dev_err_probe() so that these messages are not shown on bootup.

Brian Masney (2):
  scsi: ufs: core: convert to dev_err_probe() in hba_init
  scsi: ufs: host: convert to dev_err_probe() in pltfrm_init

 drivers/ufs/core/ufshcd.c        | 17 +++++++++--------
 drivers/ufs/host/ufshcd-pltfrm.c |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAC677BFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjHNSo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjHNSos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0E12E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692038643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gMFMHL74t2T5YQCuOIjcESsgAxQGO/F/5mkeBwii9+g=;
        b=cDw2YjvOE0YLpkbh68mx81CLPnDAhU04ATw1M2ZXxeBbQdacHQQTqenhvzBLXGisnpcnIb
        wBV85FsXB0p3zPRfiDJwYwYEyGvku/I+HzoKU1S1jten5NBHcLYAFFYRnMsatMHz9/h+B7
        HDy2/Plff1ts39zzsjp4gl+ZQUjwuGA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-kbPn9DlPOPu4MN4aNNORyw-1; Mon, 14 Aug 2023 14:44:01 -0400
X-MC-Unique: kbPn9DlPOPu4MN4aNNORyw-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-d6ac5db336eso1641347276.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038640; x=1692643440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMFMHL74t2T5YQCuOIjcESsgAxQGO/F/5mkeBwii9+g=;
        b=XLQAl2SMPX6nbdf3dIF51Pl8bH9XaLPp8fxxAgj+qcFcnA3e8H61T61PA+M1NPx+t/
         UrsK1ir7G/fJql+r5spvza31mpVu/yDa01nX3k07iVtBKPEu057WZpBAB0IK6G4KUISA
         KgZSoj/V4UPvcFVLGwJxxpNQyNQVxgzN4uyZP0M66YbF1nMjt3WWSKrRE+LbzJbeXEZq
         W9rPpYHYb55blD/BVvbvqADzvlc7xfKzC7LXgZF1t75hZ0n27sTZ5liaFFdmWb+j7ZLj
         PJsRWPIBGOoLhYP4wXdYR4X0XB2Jz1yopWG7mZpOOoQGELstx8mfqOlyY1PgUJ4TXi/r
         /jGQ==
X-Gm-Message-State: AOJu0Yw7gMqXF6Zjfnxg6ClYxS8dh5Argd4CqFxTy3dLwAieVqAhuZvS
        X/oTsIVy5Qu0Uv8xdIzelMy1/yfxlfz6vglh1SI27CRaD8JBr5IzxFPuVE8I6jCGuTpXrm2YZ9M
        w9Q2xA32Zsd9/PayhUN0xL8bGcUiCedIs
X-Received: by 2002:a25:dad7:0:b0:ced:6134:7606 with SMTP id n206-20020a25dad7000000b00ced61347606mr13115416ybf.30.1692038640193;
        Mon, 14 Aug 2023 11:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPVBPkqxgxKUguqFVu0WE+kAMWlWC/xWovboumFU5uuvLkGHLhDjQYXjTgtt+Btm5ldVeQag==
X-Received: by 2002:a25:dad7:0:b0:ced:6134:7606 with SMTP id n206-20020a25dad7000000b00ced61347606mr13115408ybf.30.1692038639962;
        Mon, 14 Aug 2023 11:43:59 -0700 (PDT)
Received: from brian-x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id x131-20020a25ce89000000b00d674f3e2891sm1864387ybe.40.2023.08.14.11.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:43:59 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com, quic_nguyenb@quicinc.com
Subject: [PATCH v3 0/2] scsi: ufs: convert probe to use dev_err_probe()
Date:   Mon, 14 Aug 2023 14:43:50 -0400
Message-ID: <20230814184352.200531-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Changes since v2
https://lore.kernel.org/lkml/20230809191054.2197963-1-bmasney@redhat.com/
- Add error code to message in second patch

Changes since v1
https://lore.kernel.org/lkml/20230808142650.1713432-1-bmasney@redhat.com/
- Dropped code cleanup from first patch

Brian Masney (2):
  scsi: ufs: core: convert to dev_err_probe() in hba_init
  scsi: ufs: host: convert to dev_err_probe() in pltfrm_init

 drivers/ufs/core/ufshcd.c        | 5 +++--
 drivers/ufs/host/ufshcd-pltfrm.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.41.0


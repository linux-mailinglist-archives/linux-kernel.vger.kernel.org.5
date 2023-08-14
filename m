Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4786E77BFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjHNSo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjHNSos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE410C6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692038646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4joPWpzOwMxG2JmzffBKuFwUsBB4CLDunmCkMRyxEIg=;
        b=aab/qDtAA57RjGdWgB+ZvuCAFnuf1abNaS9dSYmdVSSoyA8vZD8H09VoirBJFBAq6KBlTH
        6Ko64M1RTC7uGw5hbF541Fg2UijadUVrGY/HcWYkm94SJ1ib2UfYrgK7XepMKbCqYMeRXU
        PxM75FS+Av3yOsFVbAokwl7exX9DL+w=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-DiTh6MFPNGKmocjIxYqShw-1; Mon, 14 Aug 2023 14:44:02 -0400
X-MC-Unique: DiTh6MFPNGKmocjIxYqShw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-c647150c254so9212268276.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038642; x=1692643442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4joPWpzOwMxG2JmzffBKuFwUsBB4CLDunmCkMRyxEIg=;
        b=JYosALfSifeNl4JYjamtaNOOXhbo0TjRWnL4kabrvDXDaCtl90KlZCNDo3pjfg8UY3
         pZ1Uv1H5c9RwR1Brko9XGP2ztITF8monLk1F4TWNtdaX2w+wVRK/DUyrrETQB9WsLdWl
         Ihp5P9L3b9QEnWlFPJEDzT9GHZ+rVa03Km9Edd3kFlBjotZVoWfE2+Duu2cPAWIq6B6F
         M+mwTUeQl0TkOdUQm44WVbKTtZWynMwHxCx23fG2UhsNXe++BUroFfznspwC3JMsP3Th
         OsnpDtYbj+HwYtYrw+WAC7ZbGsnDidTMekal4RFQkT4SX/MVmGsnDaHBnhtxmoiyNhpC
         8Gmg==
X-Gm-Message-State: AOJu0YydUEEyIfIGE5XEVUOtqbtk0pPMmzY2sBcvXND3pRykzkWinlvw
        vXTECoBjiz6QfI2thpPeAK1Kw2GCYNI5PjTRqx8z/Cd49Vw/s1aMe9jgsBd4/c4Vb9kPkXG/kPR
        TrYDXFEWPneO0rIv08oB5Vdmf
X-Received: by 2002:a25:dbc6:0:b0:d3f:cfa:2349 with SMTP id g189-20020a25dbc6000000b00d3f0cfa2349mr12990852ybf.3.1692038642194;
        Mon, 14 Aug 2023 11:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDOouh4FCszIJRQfOkk++fDwHAw9URgmOfSdxESw5t1t1TvI9bn4i/fnwtAhx4HqGXA2+NTg==
X-Received: by 2002:a25:dbc6:0:b0:d3f:cfa:2349 with SMTP id g189-20020a25dbc6000000b00d3f0cfa2349mr12990842ybf.3.1692038641946;
        Mon, 14 Aug 2023 11:44:01 -0700 (PDT)
Received: from brian-x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id x131-20020a25ce89000000b00d674f3e2891sm1864387ybe.40.2023.08.14.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:44:01 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com, quic_nguyenb@quicinc.com
Subject: [PATCH v3 1/2] scsi: ufs: core: convert to dev_err_probe() in hba_init
Date:   Mon, 14 Aug 2023 14:43:51 -0400
Message-ID: <20230814184352.200531-2-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814184352.200531-1-bmasney@redhat.com>
References: <20230814184352.200531-1-bmasney@redhat.com>
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

Convert ufshcd_variant_hba_init() over to use dev_err_probe() to avoid
log messages like the following on bootup:

    ufshcd-qcom 1d84000.ufs: ufshcd_variant_hba_init: variant qcom init
        failed err -517

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Changes since v2
- None

Changes since v1
- Dropped code cleanup

 drivers/ufs/core/ufshcd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 129446775796..409d176542e1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9235,8 +9235,9 @@ static int ufshcd_variant_hba_init(struct ufs_hba *hba)
 
 	err = ufshcd_vops_init(hba);
 	if (err)
-		dev_err(hba->dev, "%s: variant %s init failed err %d\n",
-			__func__, ufshcd_get_var_name(hba), err);
+		dev_err_probe(hba->dev, err,
+			      "%s: variant %s init failed err %d\n",
+			      __func__, ufshcd_get_var_name(hba), err);
 out:
 	return err;
 }
-- 
2.41.0


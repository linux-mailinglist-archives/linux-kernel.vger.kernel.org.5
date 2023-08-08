Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC430774511
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjHHSgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjHHSgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA1B132FB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691512152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RiiUrTAdlH1WDAwp4uIE1Px1Zl2wmGgAzSKjNn/1kOs=;
        b=VmBFJoX5HvT54Vt+aSZzXQQoLa+2U4tPFhQQcHX0cTDRV6CcDTt/2eu/aHBPJXRYFNtdYd
        25J33MRvy0XeWUn0qMuN1CVqA/KXWEUn5sp8Jex/aCIAD0hXt+PuIEipXn4JzU+n73GDjh
        O86eis8l/fpUwgHeC0ALLqSSp65bk3o=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-Bi6bfTpvPiaIaWFhgRLbmQ-1; Tue, 08 Aug 2023 10:27:14 -0400
X-MC-Unique: Bi6bfTpvPiaIaWFhgRLbmQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-585f04ffa3eso74487177b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 07:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691504833; x=1692109633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiiUrTAdlH1WDAwp4uIE1Px1Zl2wmGgAzSKjNn/1kOs=;
        b=SnSAZlqvdjKiwTeuMDkxPmUJfHJ+UaJySi0n14fcDjj4ej3pjlbEedEt20+B+MAGF2
         FRiLoD+bpkzLCBa5IIB3z6DuOH79PJ9SZwQaMOM3bcMj0k42cBVqtnN5GC1nb4dapJGK
         9Os+NEpe/vA8h4ihVJe0U6Tc4LH15CBPLPbAAqRdzJWXSREfrzMSgKtU55TroesiRPi3
         hZsPE5chlR6tRtM2qshx/K4lU59D5AnuC2CyGPh7rXtfuIPlUVgrrkdxFzMXQUfDpjAP
         +mBc8WcHSRTrLiiHZYe7ImvFzFBkh6GkSpNQHMVKCSfv8RZ4MhX17kdeDBAxe2HT+cqt
         4VZg==
X-Gm-Message-State: AOJu0YzyxGPOCEPlt5YK0993BEYsoYvwgr/Nqfc0LxwhCKZKvvPJs3Ve
        F/i8+6RQR+Seye8iYVP54ngJYQ8d6OpQTiAkRM/KoNgPSMulardJFCujFx64gF9ukchpnH3CL7R
        sLiTMVin3hb1FVRitbJtOFU0S
X-Received: by 2002:a25:2686:0:b0:d4b:6936:90f9 with SMTP id m128-20020a252686000000b00d4b693690f9mr10735262ybm.49.1691504833430;
        Tue, 08 Aug 2023 07:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSZr2v/luenLdvMzRHvyNRK7DrsRTyyulfTGLb3xjOhaRryRb47w5qC1xKFlgnLqi3DmK+FQ==
X-Received: by 2002:a25:2686:0:b0:d4b:6936:90f9 with SMTP id m128-20020a252686000000b00d4b693690f9mr10735245ybm.49.1691504833186;
        Tue, 08 Aug 2023 07:27:13 -0700 (PDT)
Received: from brian-x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y9-20020a259c89000000b00c71e4833957sm2713058ybo.63.2023.08.08.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 07:27:12 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scsi: ufs: core: convert to dev_err_probe() in hba_init
Date:   Tue,  8 Aug 2023 10:26:49 -0400
Message-ID: <20230808142650.1713432-2-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808142650.1713432-1-bmasney@redhat.com>
References: <20230808142650.1713432-1-bmasney@redhat.com>
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

Convert ufshcd_variant_hba_init() over to use dev_err_probe() to avoid
log messages like the following on bootup:

    ufshcd-qcom 1d84000.ufs: ufshcd_variant_hba_init: variant qcom init
        failed err -517

While changes are being made here, let's go ahead and clean up the rest
of that function.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/ufs/core/ufshcd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 129446775796..90d87cf5e25e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9228,17 +9228,18 @@ static int ufshcd_init_clocks(struct ufs_hba *hba)
 
 static int ufshcd_variant_hba_init(struct ufs_hba *hba)
 {
-	int err = 0;
+	int ret;
 
 	if (!hba->vops)
-		goto out;
+		return 0;
 
-	err = ufshcd_vops_init(hba);
-	if (err)
-		dev_err(hba->dev, "%s: variant %s init failed err %d\n",
-			__func__, ufshcd_get_var_name(hba), err);
-out:
-	return err;
+	ret = ufshcd_vops_init(hba);
+	if (ret)
+		dev_err_probe(hba->dev, ret,
+			      "%s: variant %s init failed with error %d\n",
+			      __func__, ufshcd_get_var_name(hba), ret);
+
+	return ret;
 }
 
 static void ufshcd_variant_hba_exit(struct ufs_hba *hba)
-- 
2.41.0


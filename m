Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4C78BA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjH1Vbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjH1VbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:31:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88819194;
        Mon, 28 Aug 2023 14:31:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c71898109so3164599f8f.2;
        Mon, 28 Aug 2023 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693258263; x=1693863063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0x0vlFhawEtT6ZLRUNUkUNLsMfxgSs9gin/e6c5kP8=;
        b=gxr01ZE/NCLkm5nQhEpmWAN5SoIZl2UnWfvFHYEBnK85ptaU421j936pMn+Kz9OoR3
         izDxxZUB3gJGdv4Qd3uHJ4zGhxrxXcU+CDwgR5mfHsTH7vfuISrVeu2YTqbM1brggKtG
         IdO/WiUiKaLWiBT4ZjPaips8Ip+YtaDarujz4Wjpm+j0x+ePlDYwELCARfYt3Pj0S3z+
         Cvd0NjqegsPx/PhkWvJAmDripl415+nmJgVIxALumsniYDFf+UYwrzrZBDgl5EWpL0xK
         ezUpFm6jPM1j3MpmkxwHSIx/MR5Tqnmgwp9Jy2cjHkJdipcsXqUC98ikSqKgWDErSsea
         O0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693258263; x=1693863063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0x0vlFhawEtT6ZLRUNUkUNLsMfxgSs9gin/e6c5kP8=;
        b=WdHj/AaBRRqcLOxqm2KlvDscDa4cf8OF7vYhMeLujPqhC86KTGaDmHhXbFCS/FpFE4
         qNOAvhO3hx30CDoJSHB1VHzOs2qBWyqUI+TpCX1SPogAFMmq+dnsykSY/PwnBk/d8yAh
         OrDrBy/fJSdxNbm6zQYV9J5xTO/gJswI2TOXDw7rPzsJLv0LIJhr/fpQBTt9o7uRao3E
         gfPFy2/OjjgxniN+cpGgQbSTs0oilPF1A072QhY8odzhqwj+ozQYKe16tIFXR8ucvjmC
         f4E4mz0Y+RMwy1g1i3B9v7VeNoCb7PemT45F3XT7pkR4F3DX/ku3u/1aj+2sT+RsTrs3
         rTDA==
X-Gm-Message-State: AOJu0Yz0q1mcSqN1QH+nMSPhjCJ4/xXWtEGWcKveRY1v9U+B1SGFGlJF
        hisfA1lbyRatlOL6c7mBiU2SaJxodNE=
X-Google-Smtp-Source: AGHT+IEI2oQ1tZ9EVEM2cyDcjwgEDA8bCclGhtkajA6M2Br5vngzbkGo6kV6BGGtTh65lxMIV0YMmw==
X-Received: by 2002:adf:edca:0:b0:31a:d7fc:28f with SMTP id v10-20020adfedca000000b0031ad7fc028fmr21272839wro.19.1693258262696;
        Mon, 28 Aug 2023 14:31:02 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h8-20020a056000000800b0031759e6b43fsm11593148wrx.39.2023.08.28.14.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 14:31:01 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: qla2xxx: Fix spelling mistake "tranport" -> "transport"
Date:   Mon, 28 Aug 2023 22:31:01 +0100
Message-Id: <20230828213101.758609-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a ql_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 62a67662cbf3..04e02de36100 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -1189,7 +1189,7 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
 				 &item->iocb, item->size);
 #endif
 	if (ret) {
-		ql_dbg(ql_dbg_unsol, vha, 0x2125, "NVMe tranport ls_req failed\n");
+		ql_dbg(ql_dbg_unsol, vha, 0x2125, "NVMe transport ls_req failed\n");
 		memset((void *)&a, 0, sizeof(a));
 		a.vp_idx = vha->vp_idx;
 		a.nport_handle = uctx->nport_handle;
-- 
2.39.2


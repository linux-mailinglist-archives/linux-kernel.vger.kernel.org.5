Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17807EA1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjKMRdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:33:17 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3135910E5;
        Mon, 13 Nov 2023 09:33:15 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bd73395bceso3606884b3a.0;
        Mon, 13 Nov 2023 09:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699896794; x=1700501594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIiFWyxFC1HOSVVyldmWbIpiXOMSUH/VwjcC908opxI=;
        b=faE8HEeeHZmXbsjJIHxT5JRiJ7LvFfL5mryTwj6JkmzjQU/VXN8WSixuBRA/D/5G76
         f8Gry5eDZZbxts35YRGI1RRva0RwN+jEZRL0J+gILZBhTjsYTtLNC3GY7O9/ab2OhOKT
         viGIhajjjbm2zlL4GQjDDOhVInnUn8UGIEyCapA85rQY1GmGL4N8hQ9x/EwAYZwHDGGa
         Ol8oKbU75OQ36rCYZBAlO1C1FlGyCSLWsiKTmb2jZd2JsCtLSAu3PQzLUhhDXN86H/iz
         f4fgl51suzdbTcYxrzj3IXP5+TSieh5Ve3txdH1R6mMNkRmJFm2EFZNXEiZ2MpBxPTcX
         sRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699896794; x=1700501594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIiFWyxFC1HOSVVyldmWbIpiXOMSUH/VwjcC908opxI=;
        b=ksweX+aulkXZU4cBH6ghIp0OA2bPjQWB9L27GJ7ZNORn2Ve+jbI94yI4FE/GiTgG6y
         NTALAEIbIpGQ9/FjSnB+Axbf0aOZuqgdEZbWuFEAPmj0CSmFANoYwLRQstEOdddEXtyP
         h+fbGAC1JKHdYNIOzSrlJPGsNX+sChLYzXNFty7h0/+17exDw5AM15neH27yXw3XpJu9
         4jIlMyEuhVa+Of0zEO1rbPalFheYy2B9PX9KhmTBqpuIXgQVVBt0lZ/QORGqqOijalFk
         ROaWxZ0RWaNcx0BKr2XyxA805vTKTy77XxnN+KUQgkMsPCdQbFO6emGi1GKGWAu9FdZs
         yH8A==
X-Gm-Message-State: AOJu0YyHQ1Tp6Ad+0zzhvYXDSqCoPt3srEqeiyDua2wysZVH9cLP3H8B
        q+9sfQ40t6q2ptNgWOa3+vu66/QxgoSutQ==
X-Google-Smtp-Source: AGHT+IGDOTw4btLadk30e4pq3hs3nRiRTYRanmEDZrDxKxqMOnKUAA/7bsT8bFo4wKSI4J9uD9B78Q==
X-Received: by 2002:a05:6a20:430f:b0:17a:f4b6:bf89 with SMTP id h15-20020a056a20430f00b0017af4b6bf89mr174764pzk.31.1699896794496;
        Mon, 13 Nov 2023 09:33:14 -0800 (PST)
Received: from localhost.localdomain ([149.167.148.33])
        by smtp.gmail.com with ESMTPSA id v65-20020a632f44000000b0058a9621f583sm4210456pgv.44.2023.11.13.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 09:33:13 -0800 (PST)
From:   Ronald Monthero <debug.penguin32@gmail.com>
To:     miquel.raynal@bootlin.com, andriy.shevchenko@linux.intel.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        debug.penguin32@gmail.com, AVKrasnov@sberdevices.ru,
        r.czerwinski@pengutronix.de, jaimeliao.tw@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v3] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response
Date:   Tue, 14 Nov 2023 03:32:49 +1000
Message-Id: <20231113173251.623268-1-debug.penguin32@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZVJJAReXiEVc35HZ@smile.fi.intel.com>
References: <ZVJJAReXiEVc35HZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under heavy load it is likely that the controller is done
with its own task but the thread unlocking the wait is not
scheduled in time. Increasing IFC_TIMEOUT_MSECS allows the
controller to respond within allowable timeslice of 1 sec.

fsl,ifc-nand 7e800000.nand: Controller is not responding

[<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0x4a)
[<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
[<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
[<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1d0)

Cc: stable@vger.kernel.org
Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
---
 drivers/mtd/nand/raw/fsl_ifc_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 20bb1e0cb5eb..f0e2318ce088 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -21,7 +21,7 @@
 
 #define ERR_BYTE		0xFF /* Value returned for read
 					bytes when read failed	*/
-#define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
+#define IFC_TIMEOUT_MSECS	1000 /* Maximum timeout to wait
 					for IFC NAND Machine	*/
 
 struct fsl_ifc_ctrl;
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007FC80E199
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbjLLC2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjLLC2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:30 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EBDB5;
        Mon, 11 Dec 2023 18:28:20 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-591341db3a1so70488eaf.3;
        Mon, 11 Dec 2023 18:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348099; x=1702952899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tKG4WVl45TB2YunCHhniL08YBM1/uYaQavYz+dOQLk=;
        b=c5Do9fdrvNlgsvxKmOXubSHYbw5IByjEzwLXYzvGflKFUIzahrCh4MfD5RVyWNb3zt
         hECclnmOhcWHyA08AaE2pITiZypfnVCbcVYypiwf7YJe2dYOOr131i2v8deaKEW7pUFn
         xLEUVslbrv+sbTZyfvzXAI7XAY2B5ZnB6ytx0thxNhx7rgqQHwUXHnlyspPZQHuc6ShH
         4sUEec933NbAXVGf/4+CTWSlskR9GRL5tF+iCMzGlG4pXwutBoB10YiNwoak/Jm82r+Z
         oThLNI3Qqv7RpiVPGd/8NAcmEXkQroLC4lAJBqmc8+Xh4XcjxWiwlzdZegP/RjyD7KML
         qGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348099; x=1702952899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tKG4WVl45TB2YunCHhniL08YBM1/uYaQavYz+dOQLk=;
        b=D2K0Siqo9v4vXwpuZniBmMA9Z9A9iGBfPIw0GrPeSuIGB6/MiAOUqcWUwD5h8U8KmQ
         sWSZAwd5Bsed6PqCBn0YVX7FNzsE4Pbnrt2BkE9Xfo8FFf/XQxu+tRHII4ztgFff4A4a
         +/VN/WBmpgsb4KKMM8/l+rcR5Sg1nMCBL4Ucqm4nhkJgAwQbCMw2R3X0ZqBuMi3tlt52
         p4GQVPRjN0qhv7P5WmS9mf4etXRLP3/+ou0RnxFjGFg+5V769qxCdKB2pXnX7CKs2pjs
         gmjj3noX7gjlK2s2eDT7p1YbjHCfrxLua7pWC+Q/dE7dsGuxpl/QtgwtmLx2l2ZAgoJW
         VY4g==
X-Gm-Message-State: AOJu0YxcG7xRaIhP9E9Dsb5RptZGwI51i64bpQ6EJbOZgz9NPxWt3Nvl
        aO/tQRlwugXEEQYEslMI4/yOqYrdj4LvPA==
X-Google-Smtp-Source: AGHT+IEscRoCcdNEu5b4gPtdNv417w7Q2p6hqBpRJ0mghg3Bm69GtWMzaPxlc4WSZMdkdvbYqttDLQ==
X-Received: by 2002:a05:6870:7ec4:b0:1fa:f7b1:b6d6 with SMTP id wz4-20020a0568707ec400b001faf7b1b6d6mr5231672oab.55.1702348098544;
        Mon, 11 Dec 2023 18:28:18 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id i187-20020a8154c4000000b005d40a826831sm3435431ywb.115.2023.12.11.18.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:18 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 17/35] scsi: qedi: optimize qedi_get_task_idx() by using find_and_set_bit()
Date:   Mon, 11 Dec 2023 18:27:31 -0800
Message-Id: <20231212022749.625238-18-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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

qedi_get_task_idx() opencodes find_and_set_bit(). Simplify it and make the
whole function a simiple almost one-liner.

CC: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/scsi/qedi/qedi_main.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index cd0180b1f5b9..2f940c6898ef 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1824,20 +1824,13 @@ int qedi_get_task_idx(struct qedi_ctx *qedi)
 {
 	s16 tmp_idx;
 
-again:
-	tmp_idx = find_first_zero_bit(qedi->task_idx_map,
-				      MAX_ISCSI_TASK_ENTRIES);
+	tmp_idx = find_and_set_bit(qedi->task_idx_map, MAX_ISCSI_TASK_ENTRIES);
 
 	if (tmp_idx >= MAX_ISCSI_TASK_ENTRIES) {
 		QEDI_ERR(&qedi->dbg_ctx, "FW task context pool is full.\n");
 		tmp_idx = -1;
-		goto err_idx;
 	}
 
-	if (test_and_set_bit(tmp_idx, qedi->task_idx_map))
-		goto again;
-
-err_idx:
 	return tmp_idx;
 }
 
-- 
2.40.1


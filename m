Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1780E193
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345806AbjLLC2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjLLC2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:30 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52A9101;
        Mon, 11 Dec 2023 18:28:18 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5e176babd4eso9934877b3.2;
        Mon, 11 Dec 2023 18:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348097; x=1702952897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czhSXAh440OIvaVFdm7Ai9lj2nzvHorDl5GV/YP7fGM=;
        b=BjtRSh3IWCNseVR+csP0ND2JJ0Ub+jnuOEp4oGWSaWCN1drlKOmgmgSWc6bRzrJSaA
         fR35bKHhVhuWVILPNHLofkGU+9fJyDOqZPgBIGiBxXLxihAq0UAwShB3y/50n9+Ui/3F
         MYE4716zFe/nJFMS1/gnDbrMYH926oY0BaSXeVT47s3z86TQMQqUNzRyXgclTCShZKbv
         KKRhLJDlcx65+gFsFCmygNap+54/G5vD4TZ7SZFSVkJ2UKNmUTNVnaItJn8DCBsoSgtf
         vXU6AktdJ8JJARirmLNuoF9lHycNzU2BBvN1lP1C1S9uwb4k+Cgs2isWHhLac0DNgYZ3
         WgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348097; x=1702952897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czhSXAh440OIvaVFdm7Ai9lj2nzvHorDl5GV/YP7fGM=;
        b=LzaIK6rWRSFJeyffNHUovSP0Ib3NbOZD2AF8vm/jfdFxEtUOGaCkcf2T45JvttGjeu
         geIWAEq8L6b41IUQah/WBrKvYycpNpYHmQWVBILdNpEHsmV0UxBqv4ccPZuitFpOYWFa
         lHIzizB0M0L1JZ5nbhLSaAu+RCrJe/pi1lySmdEsKELtkkMoquFFv6v8kT2QWChsVNCV
         3260mj53uM5zFLDVBLGGTITbfOidC/MDl1wvkYsFgjQwrRabapKKylphgwmUVpMlyUqg
         4VDN8ChyXep8EE+VogWFTiON1EdSxXuA+qB2tcKnn+qgv/ZjDmLLpH5o50IcxD5XUDDA
         LmyQ==
X-Gm-Message-State: AOJu0Yx+7rdHeOAB85DCHaMeJuwwmFX6/3hIwSZ0ikrJYqo6/WCgMnfc
        +lAgYQrO2l49B5i0HjRD9dxj0T8dxPX68w==
X-Google-Smtp-Source: AGHT+IH7eIiDWyUTJ7/p4pl9/UGdniMwqi1z758tMWmHf8Wuo26y56frYL+SZRZ8oKSuU6rNYq22XA==
X-Received: by 2002:a0d:ea56:0:b0:5de:7be5:b0d4 with SMTP id t83-20020a0dea56000000b005de7be5b0d4mr4526608ywe.23.1702348097341;
        Mon, 11 Dec 2023 18:28:17 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id l5-20020a0de205000000b005d37278f973sm3440959ywe.36.2023.12.11.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:16 -0800 (PST)
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
Subject: [PATCH v3 16/35] scsi: mpi3mr: optimize the driver by using find_and_set_bit()
Date:   Mon, 11 Dec 2023 18:27:30 -0800
Message-Id: <20231212022749.625238-17-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpi3mr_dev_rmhs_send_tm() and mpi3mr_send_event_ack() opencode
find_and_set_bit(). Simplify them by using dedicated function.

CC: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/scsi/mpi3mr/mpi3mr_os.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 040031eb0c12..11139a2008fd 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -2276,13 +2276,9 @@ static void mpi3mr_dev_rmhs_send_tm(struct mpi3mr_ioc *mrioc, u16 handle,
 	if (drv_cmd)
 		goto issue_cmd;
 	do {
-		cmd_idx = find_first_zero_bit(mrioc->devrem_bitmap,
-		    MPI3MR_NUM_DEVRMCMD);
-		if (cmd_idx < MPI3MR_NUM_DEVRMCMD) {
-			if (!test_and_set_bit(cmd_idx, mrioc->devrem_bitmap))
-				break;
-			cmd_idx = MPI3MR_NUM_DEVRMCMD;
-		}
+		cmd_idx = find_and_set_bit(mrioc->devrem_bitmap, MPI3MR_NUM_DEVRMCMD);
+		if (cmd_idx < MPI3MR_NUM_DEVRMCMD)
+			break;
 	} while (retrycount--);
 
 	if (cmd_idx >= MPI3MR_NUM_DEVRMCMD) {
@@ -2417,14 +2413,9 @@ static void mpi3mr_send_event_ack(struct mpi3mr_ioc *mrioc, u8 event,
 	    "sending event ack in the top half for event(0x%02x), event_ctx(0x%08x)\n",
 	    event, event_ctx);
 	do {
-		cmd_idx = find_first_zero_bit(mrioc->evtack_cmds_bitmap,
-		    MPI3MR_NUM_EVTACKCMD);
-		if (cmd_idx < MPI3MR_NUM_EVTACKCMD) {
-			if (!test_and_set_bit(cmd_idx,
-			    mrioc->evtack_cmds_bitmap))
-				break;
-			cmd_idx = MPI3MR_NUM_EVTACKCMD;
-		}
+		cmd_idx = find_and_set_bit(mrioc->evtack_cmds_bitmap, MPI3MR_NUM_EVTACKCMD);
+		if (cmd_idx < MPI3MR_NUM_EVTACKCMD)
+			break;
 	} while (retrycount--);
 
 	if (cmd_idx >= MPI3MR_NUM_EVTACKCMD) {
-- 
2.40.1


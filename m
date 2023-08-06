Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F340077162D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjHFRHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHFRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:07:30 -0400
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D861735
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 10:07:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1691341648; x=1691348848; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=WM8pRZoSs1w6+2t9XdlAsuyYJygupsdh/CvlPXr0AJ0=;
 b=P6YwMsWzFqMEkjt0EKIUetkcUz1Zl0XbvX7oWRKS/uJ4b7cUZbq0cJXa9+j9zPOfYWr+sPRoJAMOk88QqQ9bn+iNJ9XOCMKTxHMAOSpq9q6igoTrTlwaRZIcMnjL0yucvEbPFiAzK+nunmKMRPF0YOt2Ropz8U0gzYZt3IdorNjM5Spk3YzmZWBJHJ2bTXK7tmSJO1KGUufd4StwGO88H4moi5QqUXJYr0CqFzuusnsx/pZs2Fignr1FRJ+ny6ePeSZQIcKcoVC9V0fDMrpnfNCcw2ufFdtZSjRL47M1I8yhUAb/hZQV3I/rZ9dzkx/u1oOHbSpyYp82D2h2EAJabw==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 10149de56625 with SMTP id
 64cfd3509b55128dd8500689 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 06 Aug 2023 17:07:28 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     James Seo <james@equiv.tech>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] scsi: mpt3sas: Make MPI2_CONFIG_PAGE_IO_UNIT_8::Sensor[] a flexible array
Date:   Sun,  6 Aug 2023 10:05:54 -0700
Message-Id: <20230806170604.16143-3-james@equiv.tech>
In-Reply-To: <20230806170604.16143-1-james@equiv.tech>
References: <20230806170604.16143-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This terminal 1-length variable array can be directly converted into
a C99 flexible array member.

As all users of MPI2_CONFIG_PAGE_IO_UNIT_8 (Mpi2IOUnitPage8_t) do not
use Sensor[], no further source changes are required to accommodate
its reduced sizeof():

- mpt3sas_config.c:mpt3sas_config_get_iounit_pg8() fetches a
  Mpi2IOUnitPage8_t into a caller-provided buffer, assuming
  sizeof(Mpi2IOUnitPage8_t) as the buffer size. It has one caller:

  - mpt3sas_base.c:_base_static_config_pages() passes the address of
    the Mpi2IOUnitPage8_t iounit_pg8 member of the per-adapter struct
    (struct MPT3SAS_ADAPTER *ioc) as the buffer. The assumed buffer
    size is therefore correct.

    However, the only subsequent use in mpt3sas of the thus populated
    ioc->iounit_pg8 is a little further on in the same function, and
    this use does not involve ioc->iounit_pg8.Sensor[].

    Note that iounit_pg8 occurs in the middle of the per-adapter
    struct, not at the end. The per-adapter struct is extensively
    used throughout mpt3sas even if its iounit_pg8 member isn't,
    resulting in an especially large amount of noise when comparing
    binary changes attributable to this commit.

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index 42d820159c44..12b656bd883d 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
@@ -1200,12 +1200,9 @@ typedef struct _MPI2_IOUNIT8_SENSOR {
 #define MPI2_IOUNIT8_SENSOR_FLAGS_T0_ENABLE         (0x0001)
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumSensors at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumSensors at runtime before using Sensor[].
  */
-#ifndef MPI2_IOUNITPAGE8_SENSOR_ENTRIES
-#define MPI2_IOUNITPAGE8_SENSOR_ENTRIES     (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_8 {
 	MPI2_CONFIG_PAGE_HEADER Header;                 /*0x00 */
@@ -1214,8 +1211,7 @@ typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_8 {
 	U8                      NumSensors;             /*0x0C */
 	U8                      PollingInterval;        /*0x0D */
 	U16                     Reserved3;              /*0x0E */
-	MPI2_IOUNIT8_SENSOR
-		Sensor[MPI2_IOUNITPAGE8_SENSOR_ENTRIES];/*0x10 */
+	MPI2_IOUNIT8_SENSOR     Sensor[];               /*0x10 */
 } MPI2_CONFIG_PAGE_IO_UNIT_8,
 	*PTR_MPI2_CONFIG_PAGE_IO_UNIT_8,
 	Mpi2IOUnitPage8_t, *pMpi2IOUnitPage8_t;
-- 
2.39.2


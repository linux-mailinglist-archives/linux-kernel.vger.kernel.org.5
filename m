Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EB1771631
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjHFRIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 13:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjHFRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:08:32 -0400
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253F319B9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 10:08:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1691341684; x=1691348884; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=3E50Wyjlak98XVVuVP8qG+8W1M0fy+YEfeOVX7MTZx4=;
 b=QR4qTxdr0bKuytQZGkc95DCXAongNej9JdSUY0bfTdfPwEdiJ8nrLbjKWw01tqse1CdwovdIn3OiR71u04uMXgqxyjFeclc3MKh/OEpWCV32Oj1ka7hhZZ+IylYFmtfWPFZQW11g02yJVMrejcZWvjCJ4ziaTs+D7x9jELwFilmELzQUZYaY38tKsbB5x8Nu/rLUhI21FX5nvv+YeXnM8jn4VvRMzKp6RbjF4Mt+tkNkCKz/5hBbxW0QOKusXnNA/d8yi/HYkVPkPyi+LxQ9IDZFitJzGY3y6zlijv3yv6udJZweySYtnL3PiplNpI4MvOG+W0ubjX3Mla8P6or/Rg==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 35c6ad30e4ae with SMTP id
 64cfd37463abb9f3db29c4e5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 06 Aug 2023 17:08:04 GMT
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
Subject: [PATCH v2 05/12] scsi: mpt3sas: Make MPI2_CONFIG_PAGE_SASIOUNIT_1::PhyData[] a flexible array
Date:   Sun,  6 Aug 2023 10:05:57 -0700
Message-Id: <20230806170604.16143-6-james@equiv.tech>
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

As all users of MPI2_CONFIG_PAGE_SASIOUNIT_1 (Mpi2SasIOUnitPage1_t)
either calculate its size without depending on its sizeof() or do not
use PhyData[], no further source changes are required:

- mpt3sas_config.c:mpt3sas_config_get_sas_iounit_pg1() fetches a
  Mpi2SasIOUnitPage1_t into a caller-provided buffer, and may fetch
  and write PhyData[] into that buffer depending on its sz argument.
  Its callers:

  - mpt3sas_base.c:_base_assign_fw_reported_qd() passes
    sizeof(Mpi2SasIOUnitPage1_t) as sz, but does not use PhyData[].

  - mpt3sas_base.c:mpt3sas_base_update_missing_delay(),
    mpt3sas_scsih.c:_scsih_sas_host_add(),
    mpt3sas_transport.c:_transport_phy_enable(), and
    mpt3sas_transport.c:_transport_phy_speed() all calculate sz
    independently of sizeof(Mpi2SasIOUnitPage1_t) and allocate a
    suitable buffer before calling mpt3sas_config_get_sas_iounit_pg1()
    and using PhyData[].

- mpt3sas_config.c:mpt3sas_config_set_sas_iounit_pg1() writes the
  contents of a caller-provided buffer to the adapter, with the size
  of the write depending on its sz argument. Its callers:

  - mpt3sas_base.c:mpt3sas_base_update_missing_delay(),
    mpt3sas_transport.c:_transport_phy_enable(), and
    mpt3sas_transport.c:_transport_phy_speed() have all previously
    called mpt3sas_config_get_sas_iounit_pg1() to obtain a
    Mpi2SasIOUnitPage1_t, and are merely writing back this same
    struct with the same previously calculated sz.

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index 07a8d7646b6d..138f31def81d 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
@@ -2249,12 +2249,9 @@ typedef struct _MPI2_SAS_IO_UNIT1_PHY_DATA {
 	*pMpi2SasIOUnit1PhyData_t;
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumPhys at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumPhys at runtime before using PhyData[].
  */
-#ifndef MPI2_SAS_IOUNIT1_PHY_MAX
-#define MPI2_SAS_IOUNIT1_PHY_MAX        (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_SASIOUNIT_1 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER    Header; /*0x00 */
@@ -2275,7 +2272,7 @@ typedef struct _MPI2_CONFIG_PAGE_SASIOUNIT_1 {
 	U8
 		IODeviceMissingDelay;               /*0x13 */
 	MPI2_SAS_IO_UNIT1_PHY_DATA
-		PhyData[MPI2_SAS_IOUNIT1_PHY_MAX];  /*0x14 */
+		PhyData[];                          /*0x14 */
 } MPI2_CONFIG_PAGE_SASIOUNIT_1,
 	*PTR_MPI2_CONFIG_PAGE_SASIOUNIT_1,
 	Mpi2SasIOUnitPage1_t, *pMpi2SasIOUnitPage1_t;
-- 
2.39.2


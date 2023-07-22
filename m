Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E561075DBDA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGVLUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGVLUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:20:37 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B67530EF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e82mC/lwAop4514tnuJKMszQabi7rsyKl7UmZ10uNsEcdkIWLZmoXTiKzOXkWtdORxPNgKKsAMPhwWEWtq3OH9mgXIK3PHlUqwGGX326MoMPqBWiAAkrQY3d7HowhmY//mg2QFUWB+1lAkQzuhzf7E8RkEWSpN/zlOgS1ROH3FuWKEDqiQuZ0irTckSexHC//eazuItLjTYTIwR7dbTiJbonzDmfUbcBhk9ztX3vvPy1uOf6WoEXksQcrYPwRzP7gre+kLp9d6xOVUB7+CFcCPVcQpR2wWkntuUyfkHOL1Phl67wRWAeA7VFv7r8kzBSc61x2aslQ3DIQFum8RwLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffpilB/3qGPS3ggbgJHMnuvXxdipbw488Qhjx0AVJPc=;
 b=k7cedH9EeZmz8n5LCMYceSs3cEEOIbvk2DY7e40/oXPWr39gyqBV57hyF0FZp/fUgiGOrOGnYiBbmo3724fFh39gGAzGcZ8AmnT4Eia137g77KIQHOtRXTn8PrTnP6I3c4TeSwUOcLvrgAGatMuKA/Y4El1zEWIWuqylFB273n3fL7TBcJrL96sBZD8jx51GIBn+xF4M6gAgQW2+a9KUMl/wZ8btimSqLFQ6zLR/blCrMno7zfkMiujcBGacDluFany/JRA7iWf27qgG5AIsKH4/StvPZ2vmtY9H8/TA5rU/zAwrEAYrVleGM2mKG9VaRsKn7QIMaHXTduNS4wpcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffpilB/3qGPS3ggbgJHMnuvXxdipbw488Qhjx0AVJPc=;
 b=5QRQyQ/UT5Qv9llZ4HEZpscITtrZp5mgRNn2NzinnCHYcHY2S58luOQlBBIn2CgV4cX3+uirmEcwp03z4RATZ7zlTBFzdLNZk50MSG/Wk102aHOFeo6XDsP3+kOvRu1JvuUDGLNWXvYc3bPKEhnJawCYWJgplU8ug7lIRxbkQrw=
Received: from SJ0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:a03:2c2::28)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Sat, 22 Jul
 2023 11:20:27 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c2:cafe::c9) by SJ0PR13CA0053.outlook.office365.com
 (2603:10b6:a03:2c2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Sat, 22 Jul 2023 11:20:26 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:23 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 04/14] virt: sev-guest: Add SNP guest request structure
Date:   Sat, 22 Jul 2023 16:48:59 +0530
Message-ID: <20230722111909.15166-5-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722111909.15166-1-nikunj@amd.com>
References: <20230722111909.15166-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 942a793b-def1-407a-c598-08db8aa5a644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ea7xun6G8DOzAf7DjrQsomslp6r88n1lTEojuXvOeDcnlie5McLmmwh360oJFExLbIxqqFpJn3daYGv6Z8QBd5GHJlulqOYoX6Ttz2a7S8EYzyykK5YEn6JynPK4y75wIVY0YLDT+DGYeZnl2FoadX8JIGrihkA2COqH9dikcBwSsBf6skYof/rtCB0wGzA6xhv3+DFxw1fbZ/hrdkzjmDo+1mwl3glOGFxmHDYhL16wYsMQHlaS9Yy+GchPEKesalBeo9RRd03Wl6HuYQLVoVHCWmkI9BHKcsEQUH4z5PBtesP8ADEs1NfHUsQEpxyboqgvzjUxPcUIyveORMF387rGIdWH8wooPrI5wGeI7xz+SeidEdQxQPOitPochCOvZGwGQl6Yib0E0HjI8XcdQ59NSFzXTqkyXCU/wAkQiOTSg98olCW4U0CCp04XU1uJ4HU8dVAPJ6xqB14TvALwlsw0KQROFam+6ypoI8cPv+R6dXD2eVWHHTS0I12diJdEkWN5IIa0VqGqZbTGdlEIOohpWX3c4uxL+Wf9TPNd8epxlpMJSnIYmMkQwfUonQuMA23YyVqsXNPQS53ZtGPBoDC/HSbX3LAk+sAFN4Wg0aZBH7axtJqAebza3nJgyqCEREdO65aNmjAAAusqSTxg0c+6yc2vk+M3Trbs5sCArUwJzaqDsV43TB4MVCTxuj4AZAfVLnZrDIFYOCzpW0zsV7GnTF7knZ7xfeFL+iZr+pgHRwcHOn0Snes4moPz5kS3FLJCIo4ZESD3mIs7YknKhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(36756003)(6666004)(70586007)(70206006)(478600001)(110136005)(54906003)(7696005)(26005)(4326008)(1076003)(8676002)(2906002)(40480700001)(8936002)(41300700001)(30864003)(82740400003)(81166007)(5660300002)(356005)(316002)(186003)(47076005)(16526019)(336012)(2616005)(36860700001)(426003)(83380400001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:26.6037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942a793b-def1-407a-c598-08db8aa5a644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a snp_guest_req structure to simplify the function arguments. The
structure will be used to call the SNP Guest message request API
instead of passing a long list of parameters.

Add two helper functions for filling up the parameters:
handle_guest_request() and handle_guest_request_ext(). GET_EXT_REPORT
queries for certs_data from the AMD Security processor.
handle_guest_request_ext() provides those extra parameters for
receiving certs_data from the AMD security processor.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 .../x86/include/asm}/sev-guest.h              |  11 ++
 arch/x86/include/asm/sev.h                    |   7 --
 arch/x86/kernel/sev.c                         |  15 ++-
 drivers/virt/coco/sev-guest/sev-guest.c       | 107 ++++++++++++------
 4 files changed, 93 insertions(+), 47 deletions(-)
 rename {drivers/virt/coco/sev-guest => arch/x86/include/asm}/sev-guest.h (80%)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/arch/x86/include/asm/sev-guest.h
similarity index 80%
rename from drivers/virt/coco/sev-guest/sev-guest.h
rename to arch/x86/include/asm/sev-guest.h
index ceb798a404d6..22ef97b55069 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.h
+++ b/arch/x86/include/asm/sev-guest.h
@@ -63,4 +63,15 @@ struct snp_guest_msg {
 	u8 payload[4000];
 } __packed;
 
+struct snp_guest_req {
+	void *req_buf, *resp_buf, *data;
+	size_t req_sz, resp_sz, *data_npages;
+	u64 exit_code;
+	unsigned int vmpck_id;
+	u8 msg_version;
+	u8 msg_type;
+};
+
+int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
+			    struct snp_guest_request_ioctl *rio);
 #endif /* __VIRT_SEVGUEST_H__ */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 13dc2a9d23c1..d8e972aeb22c 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -92,8 +92,6 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 struct snp_req_data {
 	unsigned long req_gpa;
 	unsigned long resp_gpa;
-	unsigned long data_gpa;
-	unsigned int data_npages;
 };
 
 struct sev_guest_platform_data {
@@ -201,7 +199,6 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -221,10 +218,6 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
-static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
-{
-	return -ENOTTY;
-}
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b031244d6d2d..a10cf9f21e22 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -28,6 +28,7 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
+#include <asm/sev-guest.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
@@ -2177,15 +2178,21 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
+int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input,
+			    struct snp_guest_request_ioctl *rio)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
 	unsigned long flags;
 	struct ghcb *ghcb;
+	u64 exit_code;
 	int ret;
 
 	rio->exitinfo2 = SEV_RET_NO_FW_CALL;
+	if (!req)
+		return -EINVAL;
+
+	exit_code = req->exit_code;
 
 	/*
 	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
@@ -2202,8 +2209,8 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 	vc_ghcb_invalidate(ghcb);
 
 	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
-		ghcb_set_rax(ghcb, input->data_gpa);
-		ghcb_set_rbx(ghcb, input->data_npages);
+		ghcb_set_rax(ghcb, __pa(req->data));
+		ghcb_set_rbx(ghcb, *req->data_npages);
 	}
 
 	ret = sev_es_ghcb_hv_call(ghcb, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
@@ -2222,7 +2229,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN):
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
-			input->data_npages = ghcb_get_rbx(ghcb);
+			*req->data_npages = ghcb_get_rbx(ghcb);
 			ret = -ENOSPC;
 			break;
 		}
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 538c42e64baa..d4241048b397 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -23,8 +23,7 @@
 
 #include <asm/svm.h>
 #include <asm/sev.h>
-
-#include "sev-guest.h"
+#include <asm/sev-guest.h>
 
 #define DEVICE_NAME	"sev-guest"
 
@@ -198,7 +197,7 @@ static int dec_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
 		return -EBADMSG;
 }
 
-static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
+static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_req *guest_req)
 {
 	struct snp_guest_msg *resp = &snp_dev->secret_response;
 	struct snp_guest_msg *req = &snp_dev->secret_request;
@@ -226,29 +225,28 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	 * If the message size is greater than our buffer length then return
 	 * an error.
 	 */
-	if (unlikely((resp_hdr->msg_sz + ctx->authsize) > sz))
+	if (unlikely((resp_hdr->msg_sz + ctx->authsize) > guest_req->resp_sz))
 		return -EBADMSG;
 
 	/* Decrypt the payload */
-	return dec_payload(ctx, resp, payload, resp_hdr->msg_sz);
+	return dec_payload(ctx, resp, guest_req->resp_buf, resp_hdr->msg_sz);
 }
 
-static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
-			void *payload, size_t sz)
+static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, struct snp_guest_req *req)
 {
-	struct snp_guest_msg *req = &snp_dev->secret_request;
-	struct snp_guest_msg_hdr *hdr = &req->hdr;
+	struct snp_guest_msg *msg = &snp_dev->secret_request;
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
 
-	memset(req, 0, sizeof(*req));
+	memset(msg, 0, sizeof(*msg));
 
 	hdr->algo = SNP_AEAD_AES_256_GCM;
 	hdr->hdr_version = MSG_HDR_VER;
 	hdr->hdr_sz = sizeof(*hdr);
-	hdr->msg_type = type;
-	hdr->msg_version = version;
+	hdr->msg_type = req->msg_type;
+	hdr->msg_version = req->msg_version;
 	hdr->msg_seqno = seqno;
-	hdr->msg_vmpck = vmpck_id;
-	hdr->msg_sz = sz;
+	hdr->msg_vmpck = req->vmpck_id;
+	hdr->msg_sz = req->req_sz;
 
 	/* Verify the sequence number is non-zero */
 	if (!hdr->msg_seqno)
@@ -257,10 +255,10 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
 		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
-	return __enc_payload(snp_dev->ctx, req, payload, sz);
+	return __enc_payload(snp_dev->ctx, msg, req->req_buf, req->req_sz);
 }
 
-static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
+static int __handle_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req,
 				  struct snp_guest_request_ioctl *rio)
 {
 	unsigned long req_start = jiffies;
@@ -275,7 +273,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, rio);
+	rc = snp_issue_guest_request(req, &snp_dev->input, rio);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -285,8 +283,8 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		 * order to increment the sequence number and thus avoid
 		 * IV reuse.
 		 */
-		override_npages = snp_dev->input.data_npages;
-		exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
+		override_npages = *req->data_npages;
+		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
 		 * Override the error to inform callers the given extended
@@ -341,15 +339,13 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	}
 
 	if (override_npages)
-		snp_dev->input.data_npages = override_npages;
+		*req->data_npages = override_npages;
 
 	return rc;
 }
 
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
-				struct snp_guest_request_ioctl *rio, u8 type,
-				void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz)
+static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req,
+				  struct snp_guest_request_ioctl *rio)
 {
 	u64 seqno;
 	int rc;
@@ -363,7 +359,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
-	rc = enc_payload(snp_dev, seqno, rio->msg_version, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, req);
 	if (rc)
 		return rc;
 
@@ -374,7 +370,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	memcpy(snp_dev->request, &snp_dev->secret_request,
 	       sizeof(snp_dev->secret_request));
 
-	rc = __handle_guest_request(snp_dev, exit_code, rio);
+	rc = __handle_guest_request(snp_dev, req, rio);
 	if (rc) {
 		if (rc == -EIO &&
 		    rio->exitinfo2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
@@ -383,12 +379,11 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, exitinfo2: 0x%llx\n",
 			  rc, rio->exitinfo2);
-
 		snp_disable_vmpck(snp_dev);
 		return rc;
 	}
 
-	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
+	rc = verify_and_dec_payload(snp_dev, req);
 	if (rc) {
 		dev_alert(snp_dev->dev, "Detected unexpected decode failure from ASP. rc: %d\n", rc);
 		snp_disable_vmpck(snp_dev);
@@ -398,6 +393,46 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	return 0;
 }
 
+static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
+				struct snp_guest_request_ioctl *rio, u8 type,
+				void *req_buf, size_t req_sz, void *resp_buf,
+				u32 resp_sz)
+{
+	struct snp_guest_req guest_req = {
+		.msg_version = rio->msg_version,
+		.msg_type = type,
+		.vmpck_id = vmpck_id,
+		.req_buf = req_buf,
+		.req_sz = req_sz,
+		.resp_buf = resp_buf,
+		.resp_sz = resp_sz,
+		.exit_code = exit_code,
+	};
+
+	return snp_send_guest_request(snp_dev, &guest_req, rio);
+}
+
+static int handle_guest_request_ext(struct snp_guest_dev *snp_dev, u64 exit_code,
+				    struct snp_guest_request_ioctl *rio, u8 type,
+				    void *req_buf, size_t req_sz, void *resp_buf,
+				    u32 resp_sz, void *certs_data, size_t *npages)
+{
+	struct snp_guest_req guest_req = {
+		.msg_version = rio->msg_version,
+		.msg_type = type,
+		.vmpck_id = vmpck_id,
+		.req_buf = req_buf,
+		.req_sz = req_sz,
+		.resp_buf = resp_buf,
+		.resp_sz = resp_sz,
+		.exit_code = exit_code,
+		.data = certs_data,
+		.data_npages = npages,
+	};
+
+	return snp_send_guest_request(snp_dev, &guest_req, rio);
+}
+
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
 	struct snp_report_resp *resp;
@@ -480,7 +515,8 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 {
 	struct snp_ext_report_req req;
 	struct snp_report_resp *resp;
-	int ret, npages = 0, resp_len;
+	int ret, resp_len;
+	size_t npages = 0;
 
 	lockdep_assert_held(&snp_dev->cmd_mutex);
 
@@ -520,14 +556,14 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (!resp)
 		return -ENOMEM;
 
-	snp_dev->input.data_npages = npages;
-	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
-				   SNP_MSG_REPORT_REQ, &req.data,
-				   sizeof(req.data), resp->data, resp_len);
+	ret = handle_guest_request_ext(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST,
+				       arg, SNP_MSG_REPORT_REQ, &req.data,
+				       sizeof(req.data), resp->data, resp_len,
+				       snp_dev->certs_data, &npages);
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
+		req.certs_len = npages << PAGE_SHIFT;
 
 		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
 			ret = -EFAULT;
@@ -536,7 +572,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (ret)
 		goto e_free;
 
-	if (npages &&
+	if (npages && req.certs_len &&
 	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
 			 req.certs_len)) {
 		ret = -EFAULT;
@@ -740,7 +776,6 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	/* initial the input address for guest request */
 	snp_dev->input.req_gpa = __pa(snp_dev->request);
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
-	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
 	ret =  misc_register(misc);
 	if (ret)
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DF67AE47C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjIZER2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjIZERY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:17:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A359BF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695701837; x=1727237837;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHkxxHhfcS/p1Zj4sNJBN+HXPs+0Ubf8u2ycubsIO3g=;
  b=CSqdrlm67xxNdLS93wEThmfZXIFP/QheO7Win5Nf3sjFAYzt8/1aOQ0i
   sXxVIC2eM1476TZp6qyi24eDEXZH8xGN3Uj2CM7sLiDQWSBkdfEB7ONb8
   Y2BdU6sjsZOR1m/fP6lefz44F8ns5+1xQzzT10OsLVdNGfLYHY8oFukPI
   PzhW9VY+weMuLYFrQQwfJBXA4GQxiFCpQ+CoT3MrLHoAhQ4TJ/z8b2/cr
   Wd2LvzE6v7/FZzj+nVzgIJmWpdgpd6tpk4rqbbOcQpjwhMQtATDBaQ4Z+
   02MNJdT7Y+r4mhu8jHy6QuS9XR43N9rswfTyRUbmtFOlENJVgSWpFyALI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412395834"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="412395834"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 21:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814314528"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="814314528"
Received: from fvivekku-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.18.72])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 21:17:16 -0700
Subject: [PATCH v4 3/6] virt: sevguest: Prep for kernel internal {get,
 get_ext}_report()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-coco@lists.linux.dev
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Date:   Mon, 25 Sep 2023 21:17:16 -0700
Message-ID: <169570183602.596431.6477217304734993370.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for using the configs-tsm facility to convey attestation
blobs to userspace, switch to using the 'sockptr' api for copying
payloads to provided buffers where 'sockptr' handles user vs kernel
buffers.

While configfs-tsm is meant to replace existing confidential computing
ioctl() implementations for attestation report retrieval the old ioctl()
path needs to stick around for a deprecation period.

No behavior change intended.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c |   50 ++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 97dbe715e96a..c3c9e9ea691f 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -19,6 +19,7 @@
 #include <crypto/aead.h>
 #include <linux/scatterlist.h>
 #include <linux/psp-sev.h>
+#include <linux/sockptr.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
 
@@ -470,7 +471,13 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	return 0;
 }
 
-static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+struct snp_req_resp {
+	sockptr_t req_data;
+	sockptr_t resp_data;
+};
+
+static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg,
+		      struct snp_req_resp *io)
 {
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_report_resp *resp;
@@ -479,10 +486,10 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 	lockdep_assert_held(&snp_cmd_mutex);
 
-	if (!arg->req_data || !arg->resp_data)
+	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
 
-	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+	if (copy_from_sockptr(&req, io->req_data, sizeof(req)))
 		return -EFAULT;
 
 	/*
@@ -501,7 +508,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (rc)
 		goto e_free;
 
-	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+	if (copy_to_sockptr(io->resp_data, resp, sizeof(*resp)))
 		rc = -EFAULT;
 
 e_free:
@@ -550,22 +557,25 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	return rc;
 }
 
-static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg,
+			  struct snp_req_resp *io)
+
 {
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_ext_report_req req;
 	struct snp_report_resp *resp;
 	int ret, npages = 0, resp_len;
+	sockptr_t certs_address;
 
 	lockdep_assert_held(&snp_cmd_mutex);
 
-	if (!arg->req_data || !arg->resp_data)
+	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
 
-	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+	if (copy_from_sockptr(&req, io->req_data, sizeof(req)))
 		return -EFAULT;
 
-	/* userspace does not want certificate data */
+	/* caller does not want certificate data */
 	if (!req.certs_len || !req.certs_address)
 		goto cmd;
 
@@ -573,8 +583,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
 		return -EINVAL;
 
-	if (!access_ok((const void __user *)req.certs_address, req.certs_len))
-		return -EFAULT;
+	if (sockptr_is_kernel(io->resp_data)) {
+		certs_address = KERNEL_SOCKPTR((void *)req.certs_address);
+	} else {
+		certs_address = USER_SOCKPTR((void __user *)req.certs_address);
+		if (!access_ok(certs_address.user, req.certs_len))
+			return -EFAULT;
+	}
 
 	/*
 	 * Initialize the intermediate buffer with all zeros. This buffer
@@ -604,21 +619,19 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
-		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
+		if (copy_to_sockptr(io->req_data, &req, sizeof(req)))
 			ret = -EFAULT;
 	}
 
 	if (ret)
 		goto e_free;
 
-	if (npages &&
-	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
-			 req.certs_len)) {
+	if (npages && copy_to_sockptr(certs_address, snp_dev->certs_data, req.certs_len)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
 
-	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+	if (copy_to_sockptr(io->resp_data, resp, sizeof(*resp)))
 		ret = -EFAULT;
 
 e_free:
@@ -631,6 +644,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	struct snp_guest_dev *snp_dev = to_snp_dev(file);
 	void __user *argp = (void __user *)arg;
 	struct snp_guest_request_ioctl input;
+	struct snp_req_resp io;
 	int ret = -ENOTTY;
 
 	if (copy_from_user(&input, argp, sizeof(input)))
@@ -651,15 +665,17 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 		return -ENOTTY;
 	}
 
+	io.req_data = USER_SOCKPTR((void __user *)input.req_data);
+	io.resp_data = USER_SOCKPTR((void __user *)input.resp_data);
 	switch (ioctl) {
 	case SNP_GET_REPORT:
-		ret = get_report(snp_dev, &input);
+		ret = get_report(snp_dev, &input, &io);
 		break;
 	case SNP_GET_DERIVED_KEY:
 		ret = get_derived_key(snp_dev, &input);
 		break;
 	case SNP_GET_EXT_REPORT:
-		ret = get_ext_report(snp_dev, &input);
+		ret = get_ext_report(snp_dev, &input, &io);
 		break;
 	default:
 		break;


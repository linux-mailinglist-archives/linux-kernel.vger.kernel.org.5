Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C8767661
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjG1TbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjG1TbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:31:06 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B24A2736;
        Fri, 28 Jul 2023 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690572665; x=1722108665;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZKEMKTZcxb+bR5sevS5HirhkX4iYwm8FNvR5plo9bz8=;
  b=Y/nsKeO2ccCHbcJ5ElgM+6O1+yydrPdT11Stfs/TB3eFFmoEGEaYmW0s
   w2DNC8dz+P59286ou+eDVY1nBEQPX3fnN1mVj/covmOy+DGOYd9/XT3/d
   b/8YMm4ORNZoArlUepOipsrO8RsPYrtEmzKGTF01tM2hwvkRrh7alr7N/
   cvUKHe6WWR532Q9Qsnv11Ef2WvgfgNg6U6ptoVJpaKBDeTmGQWaBbcwJC
   8YNhaQ2G0cGC0B2MTyfgZ3xSoLpY8fxJXAEXqlNuevs8gdmtAGQB0yBE2
   TT87PouhfY8Z/nBULQ5ZuVkzZP3b+p2UwzuSdsLdftr4YYjkQSnjxPGZu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="348958868"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="348958868"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:31:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="797529706"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="797529706"
Received: from cheehong-laptop.gar.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.158.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:31:04 -0700
Subject: [PATCH 2/4] virt: sevguest: Prep for kernel internal {get,
 get_ext}_report()
From:   Dan Williams <dan.j.williams@intel.com>
To:     dhowells@redhat.com
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jul 2023 12:31:04 -0700
Message-ID: <169057266405.180586.11333199807740052979.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for using the TSM key facility to convey attestation blobs
to userspace, add an argument to flag whether @arg is a user buffer or a
kernel buffer.

While TSM keys is meant to replace existing confidenital computing
ioctl() implementations for attestation report retrieval the old ioctl()
path needs to stick around for a deprecation period.

No behavior change intended, just introduce the copy wrappers and @type
argument.

Note that these wrappers are similar to copy_{to,from}_sockptr(). If
this approach moves forward that concept is something that can be
generalized into a helper with a generic name.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c |   48 ++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 97dbe715e96a..f48c4764a7a2 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -470,7 +470,32 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	return 0;
 }
 
-static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+enum snp_arg_type {
+	SNP_UARG,
+	SNP_KARG,
+};
+
+static unsigned long copy_from(void *to, unsigned long from, unsigned long n,
+			       enum snp_arg_type type)
+{
+	if (type == SNP_UARG)
+		return copy_from_user(to, (void __user *)from, n);
+	memcpy(to, (void *)from, n);
+	return 0;
+}
+
+static unsigned long copy_to(unsigned long to, const void *from,
+			     unsigned long n, enum snp_arg_type type)
+{
+	if (type == SNP_UARG)
+		return copy_to_user((void __user *)to, from, n);
+	memcpy((void *)to, from, n);
+	return 0;
+}
+
+static int get_report(struct snp_guest_dev *snp_dev,
+		      struct snp_guest_request_ioctl *arg,
+		      enum snp_arg_type type)
 {
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_report_resp *resp;
@@ -482,7 +507,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
-	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+	if (copy_from(&req, arg->req_data, sizeof(req), type))
 		return -EFAULT;
 
 	/*
@@ -501,7 +526,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (rc)
 		goto e_free;
 
-	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+	if (copy_to(arg->resp_data, resp, sizeof(*resp), type))
 		rc = -EFAULT;
 
 e_free:
@@ -550,7 +575,9 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	return rc;
 }
 
-static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+static int get_ext_report(struct snp_guest_dev *snp_dev,
+			  struct snp_guest_request_ioctl *arg,
+			  enum snp_arg_type type)
 {
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_ext_report_req req;
@@ -562,7 +589,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
-	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+	if (copy_from(&req, arg->req_data, sizeof(req), type))
 		return -EFAULT;
 
 	/* userspace does not want certificate data */
@@ -611,14 +638,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (ret)
 		goto e_free;
 
-	if (npages &&
-	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
-			 req.certs_len)) {
+	if (npages && copy_to(req.certs_address, snp_dev->certs_data,
+			      req.certs_len, type)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
 
-	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+	if (copy_to(arg->resp_data, resp, sizeof(*resp), type))
 		ret = -EFAULT;
 
 e_free:
@@ -653,13 +679,13 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	switch (ioctl) {
 	case SNP_GET_REPORT:
-		ret = get_report(snp_dev, &input);
+		ret = get_report(snp_dev, &input, SNP_UARG);
 		break;
 	case SNP_GET_DERIVED_KEY:
 		ret = get_derived_key(snp_dev, &input);
 		break;
 	case SNP_GET_EXT_REPORT:
-		ret = get_ext_report(snp_dev, &input);
+		ret = get_ext_report(snp_dev, &input, SNP_UARG);
 		break;
 	default:
 		break;


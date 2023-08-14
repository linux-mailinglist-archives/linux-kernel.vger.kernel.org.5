Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFA77B2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjHNHn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjHNHnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:43:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43F7E4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691999019; x=1723535019;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15/ym61eprNFu/c45N9s1qgj9aCJOKnDqXwNGWTOn7k=;
  b=RfizRayPkp6kyL+ko4tnHpcmDC9r/u5HgyG+8L8Iu6b4mYymve247GGb
   5uzX2utQRGhcfwLh/l2BWUuLZXF2JCUtoUFyEW62zAKV3OmfgxKFJhc5Y
   CeXMOsqi/8C+rAOa6XsIBBhPJ1KS80OYAMnSH9JadBGO1mUG96n0Lb4+G
   cLsYu6JY7ea7hy5JFCe6PDnU/E77h9yuOWFU7uB6gqt2dGKxWriYqTWst
   X495wW9pOUm6LE0LqO3owQj+Q2B7rGaqDBmCQ8+iFdbMWNVAOJyxkiagS
   Ivo/UeEkRihg3+R+5YUmrvOMVGVRIFMNsAIZ5lf75slE2fIfOw1/fe4VP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="438314768"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="438314768"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="803372573"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="803372573"
Received: from navanban-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.127.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:43:38 -0700
Subject: [PATCH v2 5/5] virt: sevguest: Add TSM_REPORTS support for SNP_{GET,
 GET_EXT}_REPORT
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-coco@lists.linux.dev
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Aug 2023 00:43:38 -0700
Message-ID: <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sevguest driver was a first mover in the confidential computing
space. As a first mover that afforded some leeway to build the driver
without concern for common infrastructure.

Now that sevguest is no longer a singleton [1] the common operation of
building and transmitting attestation report blobs can / should be made
common. In this model the so called "TSM-provider" implementations can
share a common envelope ABI even if the contents of that envelope remain
vendor-specific. When / if the industry agrees on an attestation record
format, that definition can also fit in the same ABI. In the meantime
the kernel's maintenance burden is reduced and collaboration on the
commons is increased.

Convert sevguest to use CONFIG_TSM_REPORTS to retrieve the blobs that
the SNP_{GET,GET_EXT}_REPORT ioctls produce. An example flow for
retrieving the SNP_GET_REPORT blob via the TSM interface utility,
assuming no nonce and VMPL==2:

    echo 2 > /sys/class/tsm/tsm0/privlevel
    dd if=/dev/urandom bs=64 count=1 | xxd -p -c 0 > /sys/class/tsm/tsm0/inhex
    hexdump -C /sys/class/tsm/tsm0/outblob

...while the SNP_GET_EXT_REPORT flow needs to additionally set the
format to "extended":

    echo 2 > /sys/class/tsm/tsm0/privlevel
    echo extended > /sys/class/tsm/tsm0/format
    dd if=/dev/urandom bs=64 count=1 | xxd -p -c 0 > /sys/class/tsm/tsm0/inhex
    hexdump -C /sys/class/tsm/tsm0/outblob

The old ioctls can be lazily deprecated, the main motivation of this
effort is to stop the proliferation of new ioctls, and to increase
cross-vendor colloboration.

Note, only compile-tested.

Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/sev-guest/Kconfig     |    1 
 drivers/virt/coco/sev-guest/sev-guest.c |   81 +++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
index da2d7ca531f0..1cffc72c41cb 100644
--- a/drivers/virt/coco/sev-guest/Kconfig
+++ b/drivers/virt/coco/sev-guest/Kconfig
@@ -5,6 +5,7 @@ config SEV_GUEST
 	select CRYPTO
 	select CRYPTO_AEAD2
 	select CRYPTO_GCM
+	select TSM_REPORTS
 	help
 	  SEV-SNP firmware provides the guest a mechanism to communicate with
 	  the PSP without risk from a malicious hypervisor who wishes to read,
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f48c4764a7a2..5941081502e8 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -16,6 +16,7 @@
 #include <linux/miscdevice.h>
 #include <linux/set_memory.h>
 #include <linux/fs.h>
+#include <linux/tsm.h>
 #include <crypto/aead.h>
 #include <linux/scatterlist.h>
 #include <linux/psp-sev.h>
@@ -769,6 +770,78 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
 	return key;
 }
 
+static u8 *sev_report_new(struct device *dev, const struct tsm_desc *desc,
+			  size_t *outblob_len)
+{
+	struct snp_guest_dev *snp_dev = dev_get_drvdata(dev);
+	const int report_size = SZ_16K;
+	const int ext_size = SZ_16K;
+	int ret, size;
+
+	if (desc->inblob_len != 64)
+		return ERR_PTR(-EINVAL);
+
+	if (desc->outblob_format == TSM_FORMAT_EXTENDED)
+		size = report_size + ext_size;
+	else
+		size = report_size;
+
+	u8 *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
+
+	if (desc->outblob_format == TSM_FORMAT_EXTENDED) {
+		struct snp_ext_report_req ext_req = {
+			.data = { .vmpl = desc->privlevel },
+			.certs_address = (__u64)buf + report_size,
+			.certs_len = ext_size,
+		};
+		memcpy(&ext_req.data.user_data, desc->inblob, desc->inblob_len);
+
+		struct snp_guest_request_ioctl input = {
+			.msg_version = 1,
+			.req_data = (__u64)&ext_req,
+			.resp_data = (__u64)buf,
+		};
+
+		ret = get_ext_report(snp_dev, &input, SNP_KARG);
+	} else {
+		struct snp_report_req req = {
+			.vmpl = desc->privlevel,
+		};
+		memcpy(&req.user_data, desc->inblob, desc->inblob_len);
+
+		struct snp_guest_request_ioctl input = {
+			.msg_version = 1,
+			.req_data = (__u64) &req,
+			.resp_data = (__u64) buf,
+		};
+
+		ret = get_report(snp_dev, &input, SNP_KARG);
+	}
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	*outblob_len = size;
+	no_free_ptr(buf);
+	return buf;
+}
+
+static const struct tsm_ops sev_tsm_ops = {
+	.name = KBUILD_MODNAME,
+	.report_new = sev_report_new,
+};
+
+static const struct attribute_group *sev_tsm_attribute_groups[] = {
+	&tsm_default_attribute_group,
+	&tsm_extra_attribute_group,
+	NULL,
+};
+
+static void unregister_sev_tsm(void *data)
+{
+	unregister_tsm(&sev_tsm_ops);
+}
+
 static int __init sev_guest_probe(struct platform_device *pdev)
 {
 	struct snp_secrets_page_layout *layout;
@@ -842,6 +915,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
+	ret = register_tsm(&sev_tsm_ops, &pdev->dev, sev_tsm_attribute_groups);
+	if (ret)
+		goto e_free_cert_data;
+
+	ret = devm_add_action_or_reset(&pdev->dev, unregister_sev_tsm, NULL);
+	if (ret)
+		goto e_free_cert_data;
+
 	ret =  misc_register(misc);
 	if (ret)
 		goto e_free_cert_data;


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF97767665
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjG1Tbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbjG1Tbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:31:44 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A163268B;
        Fri, 28 Jul 2023 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690572689; x=1722108689;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZmjmGLkvlIjh8KgnWd4vxpMs4lTuf4Wk7sbNKNMFp8U=;
  b=WTPuKzK5XobA6Sm+c1I2DA0Ff/Ssu2SMO+MSAgrAosreBiIJ6r6l6qn+
   NWNYzIy8vylJU3LyQ2l3+rFunizuyWAXJDKE4JtEiNE0qQVkk7As0MZKY
   ETE3/+voU1ujHKhkCkTVuH+MPTpohdGM7m7G60n9Fx3xKy4MhirpO4v1N
   R91S96ijr9eUh8Yg/shnGiH5N4M7C3OfFFzEsOd6P3yqwZ3mRN45T4OVK
   /2WgxrXo93HQGZmm6M1Nx3usIUzHy9tBFFLSRCS6UrZwykg5A9JKMLw4t
   YOdm/YBUplC1oKzJjZkVHbbossCrDwVSF4x6dfcSBKCkUVMgFUDK4EX0f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="348958904"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="348958904"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="797529767"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="797529767"
Received: from cheehong-laptop.gar.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.158.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:31:16 -0700
Subject: [PATCH 4/4] virt: sevguest: Add TSM key support for SNP_{GET,
 GET_EXT}_REPORT
From:   Dan Williams <dan.j.williams@intel.com>
To:     dhowells@redhat.com
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jul 2023 12:31:15 -0700
Message-ID: <169057267580.180586.15710177655506555147.stgit@dwillia2-xfh.jf.intel.com>
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

Convert sevguest to use TSM keys to retrieve the blobs that the
SNP_{GET,GET_EXT}_REPORT ioctls produce. The flow for retrieving the
SNP_GET_REPORT blob via the keyctl utility would be:

    dd if=/dev/urandom of=pubkey bs=1 count=64
    keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=2" @u
    keyctl print $key_id | awk '{ print $3 }' | xxd -p -c 0 -r | hexdump -C

...while the SNP_GET_EXT_REPORT flow adds the "format=extended" option
to the request flow:

    keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=2 format=extended" @u

The output format from 'keyctl print' is:

    <pubkey blob> <auth blob desc[:format]> <auth blob>

...where the blobs are hex encoded and the descriptor string is either
"sev" or "sev:extended" in this case.

Note, the Keys subsystem frontend for the functionality that
SNP_GET_DERIVED_KEY represents is saved for follow-on work that likely
needs to become a new trusted-keys type. The old ioctls can be lazily
deprecated, the main motivation of this effort is to stop the
proliferation of new ioctls, and to increase cross-vendor colloboration.

Note, only compile-tested.

Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/sev-guest/Kconfig     |    2 +
 drivers/virt/coco/sev-guest/sev-guest.c |   87 +++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
index da2d7ca531f0..bce43d4639ce 100644
--- a/drivers/virt/coco/sev-guest/Kconfig
+++ b/drivers/virt/coco/sev-guest/Kconfig
@@ -2,9 +2,11 @@ config SEV_GUEST
 	tristate "AMD SEV Guest driver"
 	default m
 	depends on AMD_MEM_ENCRYPT
+	depends on KEYS
 	select CRYPTO
 	select CRYPTO_AEAD2
 	select CRYPTO_GCM
+	select TSM_KEYS
 	help
 	  SEV-SNP firmware provides the guest a mechanism to communicate with
 	  the PSP without risk from a malicious hypervisor who wishes to read,
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f48c4764a7a2..2bdca268272d 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -21,6 +21,7 @@
 #include <linux/psp-sev.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
+#include <keys/tsm.h>
 
 #include <asm/svm.h>
 #include <asm/sev.h>
@@ -769,6 +770,84 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
 	return key;
 }
 
+static int sev_auth_new(struct tsm_key_payload *t, void *provider_data)
+{
+	struct snp_guest_dev *snp_dev = provider_data;
+	const int report_size = SZ_16K;
+	const int ext_size =
+		PAGE_ALIGN_DOWN(TSM_DATA_MAX - report_size - sizeof(*t));
+	int ret;
+
+	if (t->pubkey_len != 64)
+		return -EINVAL;
+
+	if (t->auth_blob_format[0] &&
+	    strcmp(t->auth_blob_format, "extended") != 0)
+		return -EINVAL;
+
+	if (t->auth_blob_format[0]) {
+		u8 *buf __free(kvfree) =
+			kvzalloc(report_size + ext_size, GFP_KERNEL);
+
+		struct snp_ext_report_req req = {
+			.data = { .vmpl = t->privlevel },
+			.certs_address = (__u64)buf + report_size,
+			.certs_len = ext_size,
+		};
+		memcpy(&req.data.user_data, t->pubkey, 64);
+
+		struct snp_guest_request_ioctl input = {
+			.msg_version = 1,
+			.req_data = (__u64) &req,
+			.resp_data = (__u64) buf,
+		};
+
+		ret = get_ext_report(snp_dev, &input, SNP_KARG);
+		if (ret)
+			return ret;
+
+		no_free_ptr(buf);
+		t->auth_blob = buf;
+		t->auth_blob_len = report_size + ext_size;
+		t->auth_blob_desc = "sev";
+	} else {
+		u8 *buf __free(kvfree) = kvzalloc(report_size, GFP_KERNEL);
+
+		struct snp_report_req req = {
+			.vmpl = t->privlevel,
+		};
+		memcpy(&req.user_data, t->pubkey, 64);
+
+		struct snp_guest_request_ioctl input = {
+			.msg_version = 1,
+			.req_data = (__u64) &req,
+			.resp_data = (__u64) buf,
+		};
+
+		ret = get_report(snp_dev, &input, SNP_KARG);
+		if (ret)
+			return ret;
+
+		no_free_ptr(buf);
+		t->auth_blob = buf;
+		t->auth_blob_len = report_size;
+		t->auth_blob_desc = "sev";
+	}
+
+	return 0;
+}
+
+static const struct tsm_key_ops sev_tsm_ops = {
+	.name = KBUILD_MODNAME,
+	.module = THIS_MODULE,
+	.auth_new = sev_auth_new,
+};
+
+static void unregister_sev_tsm(void *data)
+{
+	unregister_tsm_provider(&sev_tsm_ops);
+}
+
 static int __init sev_guest_probe(struct platform_device *pdev)
 {
 	struct snp_secrets_page_layout *layout;
@@ -842,6 +921,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
+	ret = register_tsm_provider(&sev_tsm_ops, snp_dev);
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


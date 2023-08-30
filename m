Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBA778E01F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjH3UBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbjH3UAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:00:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFAA4EE3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693424222; x=1724960222;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+jEDPqTHm9uescgnXUEsEv+dnWGPwPiDy6A7HSsyBA=;
  b=bRxOJuPHzQMsBFrFvRi0n4OV0PVxmaxz1+7BUY1unwTFfF5FJsdQTuY+
   u2QsbRAnHcqgph/1zwST8lT4xNcrDnJbVe8fxNp3kYzCmzW/M5k8y6PUw
   yaPp8atkOwI0iFvbwkArNV7KDQmsV0LglZjzCI20plDhY35/LuMUoggan
   ulOwjTIO4Bb+XIDY1CbVY0bFpi4ICbFlAR+FMLWdgxk9OgReZ/AmRQDMv
   ayPHzrklOQL/3a036t7r+MvJz4mC2AVzFH14FDX5b5Rct0qKLYMeDvt26
   LZ1OEp1iC5eEd9JkHJKGl8aHiKtAL28eNTo21Gfi7KjbVzQmTw8TgLivF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360723672"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="360723672"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 12:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="853844918"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="853844918"
Received: from nivakuma-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.238.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 12:33:43 -0700
Subject: [PATCH v3 5/5] virt: sevguest: Add TSM_REPORTS support for SNP_{GET,
 GET_EXT}_REPORT
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-coco@lists.linux.dev
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Date:   Wed, 30 Aug 2023 12:33:42 -0700
Message-ID: <169342402274.3934343.11704206926819634506.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
the SNP_{GET,GET_EXT}_REPORT ioctls produce. An example flow follows for
retrieving the SNP_GET_REPORT blob via the TSM interface utility,
assuming no nonce and VMPL==2:

    report=/sys/kernel/config/tsm/report/report0
    mkdir $report
    echo 2 > $report/privlevel
    dd if=/dev/urandom bs=64 count=1 > $report/inblob
    hexdump -C $report/outblob
    rmdir $report

...while the SNP_GET_EXT_REPORT flow needs to additionally set the
format to "extended":

    report=/sys/kernel/config/tsm/report/report1
    mkdir $report
    echo extended > $report/format
    dd if=/dev/urandom bs=64 count=1 > $report/inblob
    hexdump -C $report/outblob
    rmdir $report

The old ioctls can be lazily deprecated, the main motivation of this
effort is to stop the proliferation of new ioctls, and to increase
cross-vendor collaboration.

Note, only compile-tested.

Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/sev-guest/Kconfig     |    1 
 drivers/virt/coco/sev-guest/sev-guest.c |   83 +++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

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
index c3c9e9ea691f..c7bbb8f372a3 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -16,10 +16,12 @@
 #include <linux/miscdevice.h>
 #include <linux/set_memory.h>
 #include <linux/fs.h>
+#include <linux/tsm.h>
 #include <crypto/aead.h>
 #include <linux/scatterlist.h>
 #include <linux/psp-sev.h>
 #include <linux/sockptr.h>
+#include <linux/cleanup.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
 
@@ -759,6 +761,79 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
 	return key;
 }
 
+static u8 *sev_report_new(const struct tsm_desc *desc, void *data, size_t *outblob_len)
+{
+	struct snp_guest_dev *snp_dev = data;
+	const int report_size = SZ_4K;
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
+	guard(mutex)(&snp_cmd_mutex);
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
+		struct snp_req_resp io = {
+			.req_data = KERNEL_SOCKPTR(&ext_req),
+			.resp_data = KERNEL_SOCKPTR(buf),
+		};
+
+		ret = get_ext_report(snp_dev, &input, &io);
+	} else {
+		struct snp_report_req req = {
+			.vmpl = desc->privlevel,
+		};
+		memcpy(&req.user_data, desc->inblob, desc->inblob_len);
+
+		struct snp_guest_request_ioctl input = {
+			.msg_version = 1,
+			.req_data = (__u64)&req,
+			.resp_data = (__u64)buf,
+		};
+		struct snp_req_resp io = {
+			.req_data = KERNEL_SOCKPTR(&req),
+			.resp_data = KERNEL_SOCKPTR(buf),
+		};
+
+		ret = get_report(snp_dev, &input, &io);
+	}
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	*outblob_len = size;
+	return_ptr(buf);
+}
+
+static const struct tsm_ops sev_tsm_ops = {
+	.name = KBUILD_MODNAME,
+	.report_new = sev_report_new,
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
@@ -832,6 +907,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
+	ret = register_tsm(&sev_tsm_ops, snp_dev, &tsm_report_ext_type);
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


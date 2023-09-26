Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299447AE47E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjIZERr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjIZERl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:17:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6DCCD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695701849; x=1727237849;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PfDJdV1MeteTn9hq9ZkG+FRq6bGpd3Tn8MKDSNKJEJQ=;
  b=CNE/9wHO8LnIr9AtWhRS6a+hryPeQWiXSP34uBnKTzROmkR/hZoAq6a/
   iNDomDNXUaGoU0dDfpdaXOdyEmIUzcCXxIY9f2a5d+H7WSrQBv7oG/ulP
   65/1FNI7E9SR0DpuX0EQxYWquIgt0RFC0h7m7+aEAH8gX+T+fE0S2fJFz
   36STBlE6MBxf+cHdgMtEHc3XB5tAdYwekSvtVQyYFEIvN92IudGgAFbeH
   NZHvpECQoe3NEPUxXQHET4mSXzMVqsz4fwaHBoRd2gklwtJAcN4D3KxXa
   KFXNMV5CV1Vu65sHTJhXluzVl8T4FBX/UTA0GynV6T3WL21gG/cHnJtd+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412395867"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="412395867"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 21:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814314543"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="814314543"
Received: from fvivekku-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.18.72])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 21:17:28 -0700
Subject: [PATCH v4 5/6] virt: sevguest: Add TSM_REPORTS support for SNP_{GET,
 GET_EXT}_REPORT
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-coco@lists.linux.dev
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Date:   Mon, 25 Sep 2023 21:17:28 -0700
Message-ID: <169570184829.596431.15991881056638719011.stgit@dwillia2-xfh.jf.intel.com>
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

Convert sevguest to use CONFIG_TSM_REPORTS to retrieve the data that
the SNP_GET_EXT_REPORT ioctl produces. An example flow follows for
retrieving the report blob via the TSM interface utility,
assuming no nonce and VMPL==2:

    report=/sys/kernel/config/tsm/report/report0
    mkdir $report
    echo 2 > $report/privlevel
    dd if=/dev/urandom bs=64 count=1 > $report/inblob
    hexdump -C $report/outblob
    cat $report/certs
    rmdir $report

Given that the platform implementation is free to return empty certificate data
if none is available it lets configfs-tsm be simplified if it only needs
to worry about one output format.

The old ioctls can be lazily deprecated, the main motivation of this
effort is to stop the proliferation of new ioctls, and to increase
cross-vendor collaboration.

Note, only compile-tested.

Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/sev-guest/Kconfig     |    1 
 drivers/virt/coco/sev-guest/sev-guest.c |  130 +++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

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
index c3c9e9ea691f..646feb433b1c 100644
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
 
@@ -759,6 +761,126 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
 	return key;
 }
 
+struct snp_msg_report_resp_hdr {
+	u32 status;
+	u32 report_size;
+	u8 rsvd[24];
+};
+#define SNP_REPORT_INVALID_PARAM 0x16
+#define SNP_REPORT_INVALID_KEY_SEL 0x27
+
+struct snp_msg_cert_entry {
+	unsigned char guid[16];
+	u32 offset;
+	u32 length;
+};
+
+static int sev_report_new(struct tsm_report *report, void *data)
+{
+	static const struct snp_msg_cert_entry zero_ent = { 0 };
+	struct tsm_desc *desc = &report->desc;
+	struct snp_guest_dev *snp_dev = data;
+	struct snp_msg_report_resp_hdr hdr;
+	const int report_size = SZ_4K;
+	const int ext_size = SZ_16K;
+	int ret, size = report_size + ext_size;
+	int certs_size, cert_count, i, offset;
+	u8 *certs_address;
+
+	if (desc->inblob_len != 64)
+		return -EINVAL;
+
+	void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	guard(mutex)(&snp_cmd_mutex);
+	certs_address = buf + report_size;
+	struct snp_ext_report_req ext_req = {
+		.data = { .vmpl = desc->privlevel },
+		.certs_address = (__u64)certs_address,
+		.certs_len = ext_size,
+	};
+	memcpy(&ext_req.data.user_data, desc->inblob, desc->inblob_len);
+
+	struct snp_guest_request_ioctl input = {
+		.msg_version = 1,
+		.req_data = (__u64)&ext_req,
+		.resp_data = (__u64)buf,
+	};
+	struct snp_req_resp io = {
+		.req_data = KERNEL_SOCKPTR(&ext_req),
+		.resp_data = KERNEL_SOCKPTR(buf),
+	};
+
+	ret = get_ext_report(snp_dev, &input, &io);
+
+	if (ret)
+		return ret;
+
+	memcpy(&hdr, buf, sizeof(hdr));
+	if (hdr.status == SNP_REPORT_INVALID_PARAM)
+		return -EINVAL;
+	if (hdr.status == SNP_REPORT_INVALID_KEY_SEL)
+		return -EINVAL;
+	if (hdr.status)
+		return -ENXIO;
+	if ((hdr.report_size + sizeof(hdr)) > report_size)
+		return -ENOMEM;
+
+	void *rbuf __free(kvfree) = kvzalloc(hdr.report_size, GFP_KERNEL);
+	if (!rbuf)
+		return -ENOMEM;
+
+	memcpy(rbuf, buf + sizeof(hdr), hdr.report_size);
+	report->outblob = no_free_ptr(rbuf);
+	report->outblob_len = hdr.report_size;
+
+	for (i = 0; i < ext_size / sizeof(struct snp_msg_cert_entry); i++) {
+		struct snp_msg_cert_entry *certs = buf + report_size;
+
+		if (memcmp(&certs[i], &zero_ent, sizeof(zero_ent)) == 0)
+			break;
+		certs_size += certs[i].length;
+	}
+	cert_count = i;
+
+	/* No certs to report */
+	if (cert_count == 0)
+		return 0;
+
+	/* sanity check that the entire certs table with metadata fits */
+	if ((cert_count + 1) * sizeof(zero_ent) + certs_size > ext_size)
+		return -ENXIO;
+
+	void *cbuf __free(kvfree) = kvzalloc(certs_size, GFP_KERNEL);
+	if (!cbuf)
+		return -ENOMEM;
+
+	/* Concatenate returned certs */
+	for (i = 0, offset = 0; i < cert_count; i++) {
+		struct snp_msg_cert_entry *certs = buf + report_size;
+
+		memcpy(cbuf + offset, certs_address + certs[i].offset, certs[i].length);
+		offset += certs[i].length;
+	}
+
+	report->certs = no_free_ptr(cbuf);
+	report->certs_len = certs_size;
+
+	return 0;
+}
+
+static const struct tsm_ops sev_tsm_ops = {
+	.name = KBUILD_MODNAME,
+	.report_new = sev_report_new,
+};
+
+static void unregister_sev_tsm(void *data)
+{
+	tsm_unregister(&sev_tsm_ops);
+}
+
 static int __init sev_guest_probe(struct platform_device *pdev)
 {
 	struct snp_secrets_page_layout *layout;
@@ -832,6 +954,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
+	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_ext_type);
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


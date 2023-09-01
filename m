Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EA378FFEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjIAPZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjIAPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:25:31 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D210994
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:25:27 -0700 (PDT)
Received: from [192.168.2.39] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id DCC51212A79E;
        Fri,  1 Sep 2023 08:25:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCC51212A79E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1693581927;
        bh=3U6deW3WmkYHw2SKJa5pZv80uKTtSTYWF2LN0Z1o9Gw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GH4y+ldXLGqvCvUFGbRh8Fwd0Y9no0kf2KbdFCHsw6mtioKMCTcjDfgGK+iU8D+Cu
         S7zJJq/FoKvWEJZ5BjnUkJb5Z8WXfTGVtiVeOXsdnuQSUC8ctmYWr82yQmaAMczTaK
         TTIdljDnDThnsTB/IuD5VLx63ur6ZfoFbS5zbA2E=
Message-ID: <4e4407b0-179d-4be4-bf0b-0d674103d4f6@linux.microsoft.com>
Date:   Fri, 1 Sep 2023 17:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342402274.3934343.11704206926819634506.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <169342402274.3934343.11704206926819634506.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2023 9:33 PM, Dan Williams wrote:
> The sevguest driver was a first mover in the confidential computing
> space. As a first mover that afforded some leeway to build the driver
> without concern for common infrastructure.
> 
> Now that sevguest is no longer a singleton [1] the common operation of
> building and transmitting attestation report blobs can / should be made
> common. In this model the so called "TSM-provider" implementations can
> share a common envelope ABI even if the contents of that envelope remain
> vendor-specific. When / if the industry agrees on an attestation record
> format, that definition can also fit in the same ABI. In the meantime
> the kernel's maintenance burden is reduced and collaboration on the
> commons is increased.
> 
> Convert sevguest to use CONFIG_TSM_REPORTS to retrieve the blobs that
> the SNP_{GET,GET_EXT}_REPORT ioctls produce. An example flow follows for
> retrieving the SNP_GET_REPORT blob via the TSM interface utility,
> assuming no nonce and VMPL==2:
> 
>     report=/sys/kernel/config/tsm/report/report0
>     mkdir $report
>     echo 2 > $report/privlevel
>     dd if=/dev/urandom bs=64 count=1 > $report/inblob
>     hexdump -C $report/outblob
>     rmdir $report
> 
> ...while the SNP_GET_EXT_REPORT flow needs to additionally set the
> format to "extended":
> 
>     report=/sys/kernel/config/tsm/report/report1
>     mkdir $report
>     echo extended > $report/format
>     dd if=/dev/urandom bs=64 count=1 > $report/inblob
>     hexdump -C $report/outblob
>     rmdir $report
> 
> The old ioctls can be lazily deprecated, the main motivation of this
> effort is to stop the proliferation of new ioctls, and to increase
> cross-vendor collaboration.
> 
> Note, only compile-tested.
> 
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dionna Glaze <dionnaglaze@google.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/virt/coco/sev-guest/Kconfig     |    1 
>  drivers/virt/coco/sev-guest/sev-guest.c |   83 +++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
> index da2d7ca531f0..1cffc72c41cb 100644
> --- a/drivers/virt/coco/sev-guest/Kconfig
> +++ b/drivers/virt/coco/sev-guest/Kconfig
> @@ -5,6 +5,7 @@ config SEV_GUEST
>  	select CRYPTO
>  	select CRYPTO_AEAD2
>  	select CRYPTO_GCM
> +	select TSM_REPORTS
>  	help
>  	  SEV-SNP firmware provides the guest a mechanism to communicate with
>  	  the PSP without risk from a malicious hypervisor who wishes to read,
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index c3c9e9ea691f..c7bbb8f372a3 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -16,10 +16,12 @@
>  #include <linux/miscdevice.h>
>  #include <linux/set_memory.h>
>  #include <linux/fs.h>
> +#include <linux/tsm.h>
>  #include <crypto/aead.h>
>  #include <linux/scatterlist.h>
>  #include <linux/psp-sev.h>
>  #include <linux/sockptr.h>
> +#include <linux/cleanup.h>
>  #include <uapi/linux/sev-guest.h>
>  #include <uapi/linux/psp-sev.h>
>  
> @@ -759,6 +761,79 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
>  	return key;
>  }
>  
> +static u8 *sev_report_new(const struct tsm_desc *desc, void *data, size_t *outblob_len)
> +{
> +	struct snp_guest_dev *snp_dev = data;
> +	const int report_size = SZ_4K;
> +	const int ext_size = SZ_16K;
> +	int ret, size;
> +
> +	if (desc->inblob_len != 64)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (desc->outblob_format == TSM_FORMAT_EXTENDED)
> +		size = report_size + ext_size;
> +	else
> +		size = report_size;
> +
> +	u8 *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
> +
> +	guard(mutex)(&snp_cmd_mutex);
> +	if (desc->outblob_format == TSM_FORMAT_EXTENDED) {
> +		struct snp_ext_report_req ext_req = {
> +			.data = { .vmpl = desc->privlevel },
> +			.certs_address = (__u64)buf + report_size,
> +			.certs_len = ext_size,
> +		};
> +		memcpy(&ext_req.data.user_data, desc->inblob, desc->inblob_len);
> +
> +		struct snp_guest_request_ioctl input = {
> +			.msg_version = 1,
> +			.req_data = (__u64)&ext_req,
> +			.resp_data = (__u64)buf,
> +		};
> +		struct snp_req_resp io = {
> +			.req_data = KERNEL_SOCKPTR(&ext_req),
> +			.resp_data = KERNEL_SOCKPTR(buf),
> +		};
> +
> +		ret = get_ext_report(snp_dev, &input, &io);
> +	} else {
> +		struct snp_report_req req = {
> +			.vmpl = desc->privlevel,
> +		};
> +		memcpy(&req.user_data, desc->inblob, desc->inblob_len);
> +
> +		struct snp_guest_request_ioctl input = {
> +			.msg_version = 1,
> +			.req_data = (__u64)&req,
> +			.resp_data = (__u64)buf,
> +		};
> +		struct snp_req_resp io = {
> +			.req_data = KERNEL_SOCKPTR(&req),
> +			.resp_data = KERNEL_SOCKPTR(buf),
> +		};
> +
> +		ret = get_report(snp_dev, &input, &io);
> +	}
> +
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	*outblob_len = size;
> +	return_ptr(buf);
> +}
> +
> +static const struct tsm_ops sev_tsm_ops = {
> +	.name = KBUILD_MODNAME,
> +	.report_new = sev_report_new,
> +};
> +
> +static void unregister_sev_tsm(void *data)
> +{
> +	unregister_tsm(&sev_tsm_ops);
> +}
> +
>  static int __init sev_guest_probe(struct platform_device *pdev)
>  {
>  	struct snp_secrets_page_layout *layout;
> @@ -832,6 +907,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>  	snp_dev->input.resp_gpa = __pa(snp_dev->response);
>  	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
>  
> +	ret = register_tsm(&sev_tsm_ops, snp_dev, &tsm_report_ext_type);
> +	if (ret)
> +		goto e_free_cert_data;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, unregister_sev_tsm, NULL);
> +	if (ret)
> +		goto e_free_cert_data;
> +
>  	ret =  misc_register(misc);
>  	if (ret)
>  		goto e_free_cert_data;
> 

I tried this with the non-extended request and realized it's a bit awkward from
a uapi point of view. The returned outblob has a header prepended (table 23 in [1])
and is arbitrarily sized at 4096. It would be more natural to only return the report
field and the count bytes that the report actually has. I've attached a rough patch
below to give you an idea of what I mean.

The extended guest request is another topic, since userspace has to be aware of
where the kernel choses to put the extended data, and fixup all the offsets in the
table (section 4.1.8.1 in [2]). It would be better to return this data through a
separate file.

[1]: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56860.pdf
[2]: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421-guest-hypervisor-communication-block-standardization.pdf

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index c7bbb8f372a3..e92a82d9c53f 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -761,9 +761,18 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
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
 static u8 *sev_report_new(const struct tsm_desc *desc, void *data, size_t *outblob_len)
 {
 	struct snp_guest_dev *snp_dev = data;
+	struct snp_msg_report_resp_hdr hdr;
 	const int report_size = SZ_4K;
 	const int ext_size = SZ_16K;
 	int ret, size;
@@ -777,6 +786,8 @@ static u8 *sev_report_new(const struct tsm_desc *desc, void *data, size_t *outbl
 		size = report_size;
 
 	u8 *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
 
 	guard(mutex)(&snp_cmd_mutex);
 	if (desc->outblob_format == TSM_FORMAT_EXTENDED) {
@@ -820,8 +831,24 @@ static u8 *sev_report_new(const struct tsm_desc *desc, void *data, size_t *outbl
 	if (ret)
 		return ERR_PTR(ret);
 
-	*outblob_len = size;
-	return_ptr(buf);
+	memcpy(&hdr, buf, sizeof(hdr));
+	if (hdr.status == SNP_REPORT_INVALID_PARAM)
+		return ERR_PTR(-EINVAL);
+	if (hdr.status == SNP_REPORT_INVALID_KEY_SEL)
+		return ERR_PTR(-ENOKEY);
+	if (hdr.status)
+		return ERR_PTR(-EPROTO);
+	if ((hdr.report_size + sizeof(hdr)) > size)
+		return ERR_PTR(-ENOSPC);
+
+	/* TODO: figure out how we want to handle extended report */
+	u8 *buf2 = kvzalloc(hdr.report_size, GFP_KERNEL);
+	if (!buf2)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(buf2, buf + sizeof(hdr), hdr.report_size);
+	*outblob_len = hdr.report_size;
+	return buf2;
 }
 
 static const struct tsm_ops sev_tsm_ops = {


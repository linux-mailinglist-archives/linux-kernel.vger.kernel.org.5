Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB977B42B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjHNIbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjHNIag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:30:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6824E63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:30:34 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 705532101843;
        Mon, 14 Aug 2023 01:30:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 705532101843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692001834;
        bh=Olc8V0eNS++HYRmqy9awQMJWnsJ+AckezL5tfEWL2DI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LTzFgcWUaitBC2B2hudh8wC1B5tiXNtvgONST7tBhk4h+WIjX+65u0oIm/T0AVH6j
         TSYoLMOGcdtRZzarH71GpS9G/pAlQc5HnWYVNYIKUQEYDQKHv+MMKoJFcaWVFk0+Xo
         XFHGFV37aQoD9KQ8g58pCpHVARmhLNfqx45w2r+Y=
Message-ID: <38891bc8-3550-403c-88d7-2e4058bbe20c@linux.microsoft.com>
Date:   Mon, 14 Aug 2023 10:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2023 9:43 AM, Dan Williams wrote:
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
> the SNP_{GET,GET_EXT}_REPORT ioctls produce. An example flow for
> retrieving the SNP_GET_REPORT blob via the TSM interface utility,
> assuming no nonce and VMPL==2:
> 
>     echo 2 > /sys/class/tsm/tsm0/privlevel
>     dd if=/dev/urandom bs=64 count=1 | xxd -p -c 0 > /sys/class/tsm/tsm0/inhex
>     hexdump -C /sys/class/tsm/tsm0/outblob
> 
> ...while the SNP_GET_EXT_REPORT flow needs to additionally set the
> format to "extended":
> 
>     echo 2 > /sys/class/tsm/tsm0/privlevel
>     echo extended > /sys/class/tsm/tsm0/format
>     dd if=/dev/urandom bs=64 count=1 | xxd -p -c 0 > /sys/class/tsm/tsm0/inhex
>     hexdump -C /sys/class/tsm/tsm0/outblob
> 
> The old ioctls can be lazily deprecated, the main motivation of this
> effort is to stop the proliferation of new ioctls, and to increase
> cross-vendor colloboration.
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
>  drivers/virt/coco/sev-guest/sev-guest.c |   81 +++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+)
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
> index f48c4764a7a2..5941081502e8 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -16,6 +16,7 @@
>  #include <linux/miscdevice.h>
>  #include <linux/set_memory.h>
>  #include <linux/fs.h>
> +#include <linux/tsm.h>
>  #include <crypto/aead.h>
>  #include <linux/scatterlist.h>
>  #include <linux/psp-sev.h>
> @@ -769,6 +770,78 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
>  	return key;
>  }
>  
> +static u8 *sev_report_new(struct device *dev, const struct tsm_desc *desc,
> +			  size_t *outblob_len)

get_report and get_ext_report both have a:

    lockdep_assert_held(&snp_cmd_mutex);

so you'd need to take that lock somewhere here.

Jeremi

> +{
> +	struct snp_guest_dev *snp_dev = dev_get_drvdata(dev);
> +	const int report_size = SZ_16K;
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
> +
> +		ret = get_ext_report(snp_dev, &input, SNP_KARG);
> +	} else {
> +		struct snp_report_req req = {
> +			.vmpl = desc->privlevel,
> +		};
> +		memcpy(&req.user_data, desc->inblob, desc->inblob_len);
> +
> +		struct snp_guest_request_ioctl input = {
> +			.msg_version = 1,
> +			.req_data = (__u64) &req,
> +			.resp_data = (__u64) buf,
> +		};
> +
> +		ret = get_report(snp_dev, &input, SNP_KARG);
> +	}
> +
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	*outblob_len = size;
> +	no_free_ptr(buf);
> +	return buf;
> +}
> +
> +static const struct tsm_ops sev_tsm_ops = {
> +	.name = KBUILD_MODNAME,
> +	.report_new = sev_report_new,
> +};
> +
> +static const struct attribute_group *sev_tsm_attribute_groups[] = {
> +	&tsm_default_attribute_group,
> +	&tsm_extra_attribute_group,
> +	NULL,
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
> @@ -842,6 +915,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>  	snp_dev->input.resp_gpa = __pa(snp_dev->response);
>  	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
>  
> +	ret = register_tsm(&sev_tsm_ops, &pdev->dev, sev_tsm_attribute_groups);
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863757AF34E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbjIZSwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjIZSwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:52:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F02EB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695754313; x=1727290313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+wegRiDNb1yF2vfkhuGSgAT8xvEdawKiGzYPeZlEWX4=;
  b=SJOojPok+AKhuBqRJm/HN08r0MXUAsXTZwfuGibY4Wfh4g1WlqCRwbEW
   7zsNyC1BWzTWW4TE+WBSw6MPlLFjeb6evu3yOkWLfBawOeLQ5YbvS5aIr
   OueCmf5WcoV2UFhCnxzDkWEFzh0V/1RHnU/eblcZoDSBHq3nh38KFVXLX
   liJPIop47IHDT1Rs9cpYyfP0sxjj5sHIFQMEkE2mRHvMk3iZ/GlCOQC5S
   BhEYWDcPqJm6wQ0MxbOJHivhCbW/smciy1rItTYCRwOq4Y7hQwvS0LzT9
   3DfSjWnzV4KQL+sv/DmUPr8S/YCgSjaBJ53wxJ9kysH7QBfb0pHZ32RFs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361023656"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="361023656"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892314054"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="892314054"
Received: from cchiu4-mobl.gar.corp.intel.com (HELO [10.212.145.91]) ([10.212.145.91])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:50:46 -0700
Message-ID: <14b8f8f9-0dac-4745-ac81-4c52631784e7@linux.intel.com>
Date:   Tue, 26 Sep 2023 11:51:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] virt: sevguest: Prep for kernel internal {get,
 get_ext}_report()
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570183602.596431.6477217304734993370.stgit@dwillia2-xfh.jf.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <169570183602.596431.6477217304734993370.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2023 9:17 PM, Dan Williams wrote:
> In preparation for using the configs-tsm facility to convey attestation
> blobs to userspace, switch to using the 'sockptr' api for copying
> payloads to provided buffers where 'sockptr' handles user vs kernel
> buffers.
> 
> While configfs-tsm is meant to replace existing confidential computing
> ioctl() implementations for attestation report retrieval the old ioctl()
> path needs to stick around for a deprecation period.
> 
> No behavior change intended.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dionna Glaze <dionnaglaze@google.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/virt/coco/sev-guest/sev-guest.c |   50 ++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 97dbe715e96a..c3c9e9ea691f 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -19,6 +19,7 @@
>  #include <crypto/aead.h>
>  #include <linux/scatterlist.h>
>  #include <linux/psp-sev.h>
> +#include <linux/sockptr.h>
>  #include <uapi/linux/sev-guest.h>
>  #include <uapi/linux/psp-sev.h>
>  
> @@ -470,7 +471,13 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>  	return 0;
>  }
>  
> -static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +struct snp_req_resp {
> +	sockptr_t req_data;
> +	sockptr_t resp_data;
> +};
> +
> +static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg,
> +		      struct snp_req_resp *io)
>  {
>  	struct snp_guest_crypto *crypto = snp_dev->crypto;
>  	struct snp_report_resp *resp;
> @@ -479,10 +486,10 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>  
>  	lockdep_assert_held(&snp_cmd_mutex);
>  
> -	if (!arg->req_data || !arg->resp_data)
> +	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
>  		return -EINVAL;
>  
> -	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +	if (copy_from_sockptr(&req, io->req_data, sizeof(req)))
>  		return -EFAULT;
>  
>  	/*
> @@ -501,7 +508,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>  	if (rc)
>  		goto e_free;
>  
> -	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
> +	if (copy_to_sockptr(io->resp_data, resp, sizeof(*resp)))
>  		rc = -EFAULT;
>  
>  e_free:
> @@ -550,22 +557,25 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>  	return rc;
>  }
>  
> -static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg,
> +			  struct snp_req_resp *io)
> +
>  {
>  	struct snp_guest_crypto *crypto = snp_dev->crypto;
>  	struct snp_ext_report_req req;
>  	struct snp_report_resp *resp;
>  	int ret, npages = 0, resp_len;
> +	sockptr_t certs_address;
>  
>  	lockdep_assert_held(&snp_cmd_mutex);
>  
> -	if (!arg->req_data || !arg->resp_data)
> +	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
>  		return -EINVAL;
>  
> -	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +	if (copy_from_sockptr(&req, io->req_data, sizeof(req)))
>  		return -EFAULT;
>  
> -	/* userspace does not want certificate data */
> +	/* caller does not want certificate data */
>  	if (!req.certs_len || !req.certs_address)
>  		goto cmd;
>  
> @@ -573,8 +583,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>  	    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
>  		return -EINVAL;
>  
> -	if (!access_ok((const void __user *)req.certs_address, req.certs_len))
> -		return -EFAULT;
> +	if (sockptr_is_kernel(io->resp_data)) {
> +		certs_address = KERNEL_SOCKPTR((void *)req.certs_address);
> +	} else {
> +		certs_address = USER_SOCKPTR((void __user *)req.certs_address);
> +		if (!access_ok(certs_address.user, req.certs_len))
> +			return -EFAULT;
> +	}
>  
>  	/*
>  	 * Initialize the intermediate buffer with all zeros. This buffer
> @@ -604,21 +619,19 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>  	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
>  		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
>  
> -		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
> +		if (copy_to_sockptr(io->req_data, &req, sizeof(req)))
>  			ret = -EFAULT;
>  	}
>  
>  	if (ret)
>  		goto e_free;
>  
> -	if (npages &&
> -	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
> -			 req.certs_len)) {
> +	if (npages && copy_to_sockptr(certs_address, snp_dev->certs_data, req.certs_len)) {
>  		ret = -EFAULT;
>  		goto e_free;
>  	}
>  
> -	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
> +	if (copy_to_sockptr(io->resp_data, resp, sizeof(*resp)))
>  		ret = -EFAULT;
>  
>  e_free:
> @@ -631,6 +644,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>  	struct snp_guest_dev *snp_dev = to_snp_dev(file);
>  	void __user *argp = (void __user *)arg;
>  	struct snp_guest_request_ioctl input;
> +	struct snp_req_resp io;
>  	int ret = -ENOTTY;
>  
>  	if (copy_from_user(&input, argp, sizeof(input)))
> @@ -651,15 +665,17 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>  		return -ENOTTY;
>  	}
>  
> +	io.req_data = USER_SOCKPTR((void __user *)input.req_data);
> +	io.resp_data = USER_SOCKPTR((void __user *)input.resp_data);
>  	switch (ioctl) {
>  	case SNP_GET_REPORT:
> -		ret = get_report(snp_dev, &input);
> +		ret = get_report(snp_dev, &input, &io);
>  		break;
>  	case SNP_GET_DERIVED_KEY:
>  		ret = get_derived_key(snp_dev, &input);
>  		break;
>  	case SNP_GET_EXT_REPORT:
> -		ret = get_ext_report(snp_dev, &input);
> +		ret = get_ext_report(snp_dev, &input, &io);
>  		break;
>  	default:
>  		break;
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

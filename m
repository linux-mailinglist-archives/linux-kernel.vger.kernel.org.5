Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B7A7A23E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjIOQrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjIOQrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:47:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FDC268E;
        Fri, 15 Sep 2023 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694796405; x=1726332405;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+zobR5lGXgXP3onpep1hv+W0ln3Xl8Jm5wQKIz7tcPs=;
  b=SUNHJa+odKVu2FB5e+qMvfRujCWWojamFSdSRMTZTXXIGsQo3A+D+20q
   wX5lbTs09mrCKPZhTKUzTcZsZyQFjCGt7/1EZywwU8tKo6SPJNQsG58pl
   klNrKAFW626w2AgLLVGnkM9rdq3Pb8zeCkoRUH7nBDNUKE0njDhRCnUbT
   hMDflA77fOS280bc9H75Qi99ifAV3APnMgPMVJboSBrYd5ZFTqZJuc9A+
   fkcg5suz8jST1EJHEsvlMh4JNrWE6rXIJiv6Magx/zaZQBfgratzZXEJA
   MSzQBmL/OZ4EYQlrF17wKefbfamBvd90iEA0GOsEeeGYE8u7yRmmIO884
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="378205613"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="378205613"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="694779664"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="694779664"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:46:40 -0700
Date:   Fri, 15 Sep 2023 19:46:38 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        pengfei.xu@intel.com
Subject: Re: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
In-Reply-To: <20230913183348.1349409-4-jithu.joseph@intel.com>
Message-ID: <ba753b39-1819-35ff-1248-6ce2c2824ae9@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230913183348.1349409-4-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, Jithu Joseph wrote:

> Scan image loading flow for newer IFS generations (1 and 2) are slightly
> different from that of current generation (0). In newer schemes,
> loading need not be done once for each socket as was done in gen0.
> 
> Also the width of CHUNK related bitfields in SCAN_HASHES_STATUS MSR has
> increased from 8 -> 16 bits. Similarly there are width differences
> for CHUNK_AUTHENTICATION_STATUS too.
> 
> Further the parameter to AUTHENTICATE_AND_COPY_CHUNK is passed
> differently in newer generations.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h  |  27 ++++++
>  drivers/platform/x86/intel/ifs/load.c | 113 +++++++++++++++++++++++++-
>  2 files changed, 138 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index d666aeed20fc..886dc74de57d 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -137,6 +137,8 @@
>  #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
>  #define MSR_ACTIVATE_SCAN			0x000002c6
>  #define MSR_SCAN_STATUS				0x000002c7
> +#define MSR_SAF_CTRL				0x000004f0
> +
>  #define SCAN_NOT_TESTED				0
>  #define SCAN_TEST_PASS				1
>  #define SCAN_TEST_FAIL				2
> @@ -158,6 +160,19 @@ union ifs_scan_hashes_status {
>  	};
>  };
>  
> +union ifs_scan_hashes_status_gen2 {
> +	u64	data;
> +	struct {
> +		u16	chunk_size;
> +		u16	num_chunks;
> +		u8	error_code;
> +		u32	chunks_in_stride :9;
> +		u32	rsvd		:2;
> +		u32	max_core_limit	:12;
> +		u32	valid		:1;

This doesn't look it would be guaranteed to provide the alignment you seem 
to want for the fields.

> +	};
> +};
> +
>  /* MSR_CHUNKS_AUTH_STATUS bit fields */
>  union ifs_chunks_auth_status {
>  	u64	data;
> @@ -170,6 +185,16 @@ union ifs_chunks_auth_status {
>  	};
>  };
>  
> +union ifs_chunks_auth_status_gen2 {
> +	u64	data;
> +	struct {
> +		u16	valid_chunks;
> +		u16	total_chunks;
> +		u8	error_code;
> +		u32	rsvd		:24;

Ditto.

> +	};
> +};
> +
>  /* MSR_ACTIVATE_SCAN bit fields */
>  union ifs_scan {
>  	u64	data;
> @@ -230,6 +255,7 @@ struct ifs_test_caps {
>   * @scan_details: opaque scan status code from h/w
>   * @cur_batch: number indicating the currently loaded test file
>   * @generation: IFS test generation enumerated by hardware
> + * @chunk_size: size of a test chunk
>   */
>  struct ifs_data {
>  	int	loaded_version;
> @@ -240,6 +266,7 @@ struct ifs_data {
>  	u64	scan_details;
>  	u32	cur_batch;
>  	u32	generation;
> +	u32	chunk_size;
>  };
>  
>  struct ifs_work {
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index 851c97cc6a6b..e8fb03dd8bcf 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -26,6 +26,11 @@ union meta_data {
>  
>  #define IFS_HEADER_SIZE	(sizeof(struct microcode_header_intel))
>  #define META_TYPE_IFS	1
> +#define INVALIDATE_STRIDE (0x1UL)

Unnecessary parenthesis. 

Align.

> +#define IFS_GEN_STRIDE_AWARE	2
> +#define AUTH_INTERRUPTED_ERROR	5
> +#define IFS_AUTH_RETRY_CT	10
> +
>  static  struct microcode_header_intel *ifs_header_ptr;	/* pointer to the ifs image header */
>  static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
>  static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
> @@ -44,7 +49,10 @@ static const char * const scan_hash_status[] = {
>  static const char * const scan_authentication_status[] = {
>  	[0] = "No error reported",
>  	[1] = "Attempt to authenticate a chunk which is already marked as authentic",
> -	[2] = "Chunk authentication error. The hash of chunk did not match expected value"
> +	[2] = "Chunk authentication error. The hash of chunk did not match expected value",
> +	[3] = "Reserved",
> +	[4] = "Chunk outside the current stride",
> +	[5] = "Authentication flow interrupted"

Add the trailing comma to avoid the need to touch the line later if more
entries are added.

>  };
>  
>  #define MC_HEADER_META_TYPE_END		(0)
> @@ -154,6 +162,104 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
>  	complete(&ifs_done);
>  }
>  
> +static int get_num_chunks(int gen, union ifs_scan_hashes_status_gen2 status)
> +{
> +	return  gen >= IFS_GEN_STRIDE_AWARE ? status.chunks_in_stride : status.num_chunks;

Remove extra space.

> +}
> +
> +static bool need_copy_scan_hashes(struct ifs_data *ifsd)
> +{
> +	if (!ifsd->loaded || ifsd->generation < IFS_GEN_STRIDE_AWARE ||
> +	    ifsd->loaded_version != ifs_header_ptr->rev) {
> +		return true;
> +	}
> +	return false;

IMO, this would be easier to read:

	return !ifsd->loaded ||
	       ifsd->generation < IFS_GEN_STRIDE_AWARE ||
	       ifsd->loaded_version != ifs_header_ptr->rev;

> +}
> +
> +static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
> +{
> +	union ifs_scan_hashes_status_gen2 hashes_status;
> +	union ifs_chunks_auth_status_gen2 chunk_status;
> +	u32 err_code, valid_chunks, total_chunks;
> +	int i, num_chunks, chunk_size;
> +	union meta_data *ifs_meta;
> +	int starting_chunk_nr;
> +	struct ifs_data *ifsd;
> +	u64 linear_addr, base;
> +	u64 chunk_table[2];
> +	int retry_count;
> +
> +	ifsd = ifs_get_data(dev);
> +
> +	if (need_copy_scan_hashes(ifsd)) {
> +		wrmsrl(MSR_COPY_SCAN_HASHES, ifs_hash_ptr);
> +		rdmsrl(MSR_SCAN_HASHES_STATUS, hashes_status.data);
> +
> +		/* enumerate the scan image information */
> +		chunk_size = hashes_status.chunk_size * 1024;

SZ_1K ?

> +		err_code = hashes_status.error_code;
> +
> +		num_chunks = get_num_chunks(ifsd->generation, hashes_status);
> +
> +		if (!hashes_status.valid) {
> +			hashcopy_err_message(dev, err_code);
> +			return -EIO;
> +		}
> +		ifsd->loaded_version = ifs_header_ptr->rev;
> +		ifsd->chunk_size = chunk_size;
> +	} else {
> +		num_chunks = ifsd->valid_chunks;
> +		chunk_size = ifsd->chunk_size;
> +	}
> +
> +	if (ifsd->generation >= IFS_GEN_STRIDE_AWARE) {
> +		wrmsrl(MSR_SAF_CTRL, INVALIDATE_STRIDE);
> +		rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
> +		if (chunk_status.valid_chunks != 0) {
> +			dev_err(dev, "Couldn't invalidate installed stride - %d\n",
> +				chunk_status.valid_chunks);
> +			return -EIO;
> +		}
> +	}
> +
> +	base = ifs_test_image_ptr;
> +	ifs_meta = (union meta_data *)find_meta_data(ifs_header_ptr, META_TYPE_IFS);
> +	starting_chunk_nr = ifs_meta->starting_chunk;
> +
> +	/* scan data authentication and copy chunks to secured memory */
> +	for (i = 0; i < num_chunks; i++) {
> +		retry_count = IFS_AUTH_RETRY_CT;
> +		linear_addr = base + i * chunk_size;
> +
> +		chunk_table[0] = starting_chunk_nr + i;
> +		chunk_table[1] = linear_addr;
> +auth_retry:
> +		wrmsrl(MSR_AUTHENTICATE_AND_COPY_CHUNK, (u64)chunk_table);
> +		rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
> +		err_code = chunk_status.error_code;
> +		if (err_code == AUTH_INTERRUPTED_ERROR && --retry_count)
> +			goto auth_retry;

do {

} while ();

> +		if (err_code) {
> +			ifsd->loading_error = true;
> +			auth_err_message(dev, err_code);
> +			return -EIO;
> +		}
> +	}
> +
> +	valid_chunks = chunk_status.valid_chunks;
> +	total_chunks = chunk_status.total_chunks;
> +
> +	if (valid_chunks != total_chunks) {
> +		ifsd->loading_error = true;
> +		dev_err(dev, "Couldn't authenticate all the chunks.Authenticated %d total %d.\n",

Missing whitespace.

> +			valid_chunks, total_chunks);
> +		return -EIO;
> +	}
> +	ifsd->valid_chunks = valid_chunks;
> +
> +	return 0;
> +}
> +
>  static int validate_ifs_metadata(struct device *dev)
>  {
>  	struct ifs_data *ifsd = ifs_get_data(dev);
> @@ -206,7 +312,9 @@ static int scan_chunks_sanity_check(struct device *dev)
>  		return ret;
>  
>  	ifsd->loading_error = false;
> -	ifsd->loaded_version = ifs_header_ptr->rev;
> +
> +	if (ifsd->generation > 0)
> +		return copy_hashes_authenticate_chunks_gen2(dev);
>  
>  	/* copy the scan hash and authenticate per package */
>  	cpus_read_lock();
> @@ -226,6 +334,7 @@ static int scan_chunks_sanity_check(struct device *dev)
>  		ifs_pkg_auth[curr_pkg] = 1;
>  	}
>  	ret = 0;
> +	ifsd->loaded_version = ifs_header_ptr->rev;
>  out:
>  	cpus_read_unlock();
>  
> 

-- 
 i.


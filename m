Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAD37ADB3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjIYPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjIYPVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:21:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D6D101;
        Mon, 25 Sep 2023 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695655269; x=1727191269;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+dPD40sRFrtUd5JAcB/1MYn442cJfUxBOmEFl6kxeFU=;
  b=f5terSgmmJrvKDTFdZtNO5gCBPfDjktcCyVXqIEWDlgEL/bDxeZ2C4or
   75e1xNAhm25ihn71Wp1eoKDUxR9jVf0GAkGTQxP9HY/64wfVyMuYx3eiW
   opOafg1zB/VeuM36Xn8/pvTj6Yekc3q6P17kCyZaWmRA97xWSZF2d3jJj
   q15Inot26WaBIPuhivDGscbe9eDqZNQ37D8gcdbOtHA+YATWZa63JjA4K
   jKRXbcdjP2OngjKvfc92fwvQKKYDFNFzYrc2H+6j0y5fRVEJunhr83kcj
   8CSbIG7VsErUxE3YpPmJhvrLwpe2kiQhR9EZP5fxmkYsZpdff/PLKRvm5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371599287"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="371599287"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814011272"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="814011272"
Received: from stamengx-mobl1.ger.corp.intel.com ([10.249.32.149])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:20:54 -0700
Date:   Mon, 25 Sep 2023 18:20:51 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v2 2/9] platform/x86/intel/ifs: Refactor image loading
 code
In-Reply-To: <20230922232606.1928026-3-jithu.joseph@intel.com>
Message-ID: <61944596-ce90-f883-2f6e-c372a42459c2@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230922232606.1928026-1-jithu.joseph@intel.com> <20230922232606.1928026-3-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1473190008-1695655259=:2147"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1473190008-1695655259=:2147
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 22 Sep 2023, Jithu Joseph wrote:

> IFS image loading flow is slightly different for newer IFS generations.
> 
> In preparation for adding support for newer IFS generations, refactor
> portions of existing image loading code for reuse.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/load.c | 31 ++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index cefd0d886cfd..851c97cc6a6b 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -80,6 +80,23 @@ static struct metadata_header *find_meta_data(void *ucode, unsigned int meta_typ
>  	return NULL;
>  }
>  
> +static void hashcopy_err_message(struct device *dev, u32 err_code)
> +{
> +	if (err_code >= ARRAY_SIZE(scan_hash_status))
> +		dev_err(dev, "invalid error code 0x%x for hash copy\n", err_code);
> +	else
> +		dev_err(dev, "Hash copy error : %s\n", scan_hash_status[err_code]);
> +}
> +
> +static void auth_err_message(struct device *dev, u32 err_code)
> +{
> +	if (err_code >= ARRAY_SIZE(scan_authentication_status))
> +		dev_err(dev, "invalid error code 0x%x for authentication\n", err_code);
> +	else
> +		dev_err(dev, "Chunk authentication error : %s\n",
> +			scan_authentication_status[err_code]);
> +}
> +
>  /*
>   * To copy scan hashes and authenticate test chunks, the initiating cpu must point
>   * to the EDX:EAX to the test image in linear address.
> @@ -109,11 +126,7 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
>  
>  	if (!hashes_status.valid) {
>  		ifsd->loading_error = true;
> -		if (err_code >= ARRAY_SIZE(scan_hash_status)) {
> -			dev_err(dev, "invalid error code 0x%x for hash copy\n", err_code);
> -			goto done;
> -		}
> -		dev_err(dev, "Hash copy error : %s", scan_hash_status[err_code]);
> +		hashcopy_err_message(dev, err_code);
>  		goto done;
>  	}
>  
> @@ -133,13 +146,7 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
>  
>  		if (err_code) {
>  			ifsd->loading_error = true;
> -			if (err_code >= ARRAY_SIZE(scan_authentication_status)) {
> -				dev_err(dev,
> -					"invalid error code 0x%x for authentication\n", err_code);
> -				goto done;
> -			}
> -			dev_err(dev, "Chunk authentication error %s\n",
> -				scan_authentication_status[err_code]);
> +			auth_err_message(dev, err_code);
>  			goto done;
>  		}
>  	}
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1473190008-1695655259=:2147--

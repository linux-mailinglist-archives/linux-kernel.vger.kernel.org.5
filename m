Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582867ADBFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjIYPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjIYPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:45:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0FFBC;
        Mon, 25 Sep 2023 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695656730; x=1727192730;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/oz9+CAICiYxIKLAPMlcwFajtVFMzg2UMgD5Z00t91E=;
  b=UHHapqbjtXEVQPbXDA5B+ZxUDDDQ+kDcpOEysJtfHf9goyRsjhheGHHs
   KyPA/KZ1uczTlTQ3z5TmNjFL4neo19jiyMoFLTGM7D6LgFzKJep5G3fqT
   QlDE5GEDgs9CiKS0djPIiJTY5FoMUcKiv7kevKzUT9SkAPk6y5vvsW3tO
   uh6ZU/oAPBs6yI8ZX3UlrrAu84aigmM41Wiu+bmly/u2nBpFKCFjPBAbI
   tCsMVTqMvOMj+u5xf4p+9RrN8jhreR5QXUrU3LYNsPah8juSdlo+T0geE
   3Oh0CUUwmJ5y6iVSj26FF40Znmr8ma5eFm7PxW5heWjd4UwctAhtZOAt+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="385120598"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="385120598"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748382090"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="748382090"
Received: from stamengx-mobl1.ger.corp.intel.com ([10.249.32.149])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:45:17 -0700
Date:   Mon, 25 Sep 2023 18:45:15 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v2 6/9] platform/x86/intel/ifs: Metadata validation for
 start_chunk
In-Reply-To: <20230922232606.1928026-7-jithu.joseph@intel.com>
Message-ID: <e628f81c-5023-2e59-f45f-e76885e41446@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230922232606.1928026-1-jithu.joseph@intel.com> <20230922232606.1928026-7-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023, Jithu Joseph wrote:

> Add an additional check to validate IFS image metadata field prior to
> loading the test image.
> 
> If start_chunk is not a multiple of chunks_per_stride error out.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/load.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index b09106034fac..c92d313b921f 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -291,6 +291,13 @@ static int validate_ifs_metadata(struct device *dev)
>  		return ret;
>  	}
>  
> +	if (ifs_meta->chunks_per_stride != 0 &&
> +	    (ifs_meta->starting_chunk % ifs_meta->chunks_per_stride)) {

I meant that != 0 should be on the second line.

-- 
 i.

> +		dev_warn(dev, "Starting chunk num %d not a multiple of chunks_per_stride %d\n",
> +			 ifs_meta->starting_chunk, ifs_meta->chunks_per_stride);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> 


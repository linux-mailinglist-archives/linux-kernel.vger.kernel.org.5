Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA6E7B51AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbjJBLrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbjJBLrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:47:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39AA6;
        Mon,  2 Oct 2023 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696247235; x=1727783235;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nGT64aLj6aCAR4SxHGB4G+zMfkc71+hJeH9BwNHnCK8=;
  b=AIgUPakw3gHMPBsJzaq9JtD/vxUu7TT/a5iVRqNL9uhWmq+WsObWDtDN
   wINmWxEvP1C+YDS+2+txW2stuY6IfdHftiSZF0Eq2z0+xSBhr2/bXQ6Be
   HiqiyW3Un0lF25M8aGr1gzshttFoeqy/pwbO2awJKB4B5oFz3unuQn19L
   t0aGXPtFEN4OLUnbnjTsTNNF0OOBQxq1yERJqKrmWMNgCTrgthcRstZMN
   mEt1bL1q4VaRpBshyKDGD9ULb401Oa/ikqHj9OGAiuVLGIkOnK+767eeT
   WLd4jRIPfpRHihcW4jmq79c2O+3rDNM8IysmqEKouAEdLumC78t9pIWam
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="381509008"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="381509008"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1495707"
Received: from roliveir-mobl1.ger.corp.intel.com ([10.251.222.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:46:31 -0700
Date:   Mon, 2 Oct 2023 14:47:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v3 6/9] platform/x86/intel/ifs: Metadata validation for
 start_chunk
In-Reply-To: <20230929202436.2850388-7-jithu.joseph@intel.com>
Message-ID: <e8bcbdcc-8cba-57ec-b0fc-4d66305d5aed@linux.intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com> <20230929202436.2850388-1-jithu.joseph@intel.com> <20230929202436.2850388-7-jithu.joseph@intel.com>
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

On Fri, 29 Sep 2023, Jithu Joseph wrote:

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
> index da54fd060878..6f8abb4729e9 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -291,6 +291,13 @@ static int validate_ifs_metadata(struct device *dev)
>  		return ret;
>  	}
>  
> +	if (ifs_meta->chunks_per_stride &&
> +	    (ifs_meta->starting_chunk % ifs_meta->chunks_per_stride != 0)) {
> +		dev_warn(dev, "Starting chunk num %d not a multiple of chunks_per_stride %d\n",
> +			 ifs_meta->starting_chunk, ifs_meta->chunks_per_stride);

Please use %u as both are u32s.

-- 
 i.

> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> 


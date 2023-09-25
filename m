Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748B77ADBF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjIYPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjIYPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:44:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F0E66;
        Mon, 25 Sep 2023 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695656614; x=1727192614;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KBtV9Wt5TwMqqcq4D9cO2jjNjTy6l+lb5oWWBcyEU1Q=;
  b=JlC5QpAYi6V08OoibbDy269r7g8ybSxZgYnffJoMyZ3iUTxRWvCrMuZ8
   hxuVwJLj7pH1uzU+3ttlAvm1IzOXX/wEvcyrvFFnPfvwFz6HjBlbz3G7X
   xdExxJRv8KF0J2J+f1E2lK9ARn6Q3VGDzQ2ctth7asXLVuYayiHUBgS5G
   Wkt08yowhaJhdwh8EG+rzQftXXyQ0mdzAQAl+fKVJ38c7o+qisrSezQIH
   cJkks/yy1O3xMpVzCHn5N6QhIBXsVW7cE1P2FPL+GplNk73JfbbE93qPD
   r60kVY2OY+kguPuj3lpbMRZvm3MqO/ZgZHH0nmJMakrQX2KxnIUzDQ5rS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="361536153"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="361536153"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="872090067"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="872090067"
Received: from stamengx-mobl1.ger.corp.intel.com ([10.249.32.149])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:43:27 -0700
Date:   Mon, 25 Sep 2023 18:43:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v2 5/9] platform/x86/intel/ifs: Validate image size
In-Reply-To: <20230922232606.1928026-6-jithu.joseph@intel.com>
Message-ID: <318e7426-fcab-c1e4-6e84-752c332088f2@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230922232606.1928026-1-jithu.joseph@intel.com> <20230922232606.1928026-6-jithu.joseph@intel.com>
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

> Perform additional validation prior to loading IFS image.
> 
> Error out if the size of the file being loaded doesn't match the size
> specified in the header.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/load.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index 6b827247945b..b09106034fac 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -375,6 +375,7 @@ int ifs_load_firmware(struct device *dev)
>  {
>  	const struct ifs_test_caps *test = ifs_get_test_caps(dev);
>  	struct ifs_data *ifsd = ifs_get_data(dev);
> +	unsigned int expected_size;
>  	const struct firmware *fw;
>  	char scan_path[64];
>  	int ret = -EINVAL;
> @@ -389,6 +390,13 @@ int ifs_load_firmware(struct device *dev)
>  		goto done;
>  	}
>  
> +	expected_size = ((struct microcode_header_intel *)fw->data)->totalsize;
> +	if (fw->size != expected_size) {
> +		dev_err(dev, "File size mismatch (expected %d, actual %ld). Corrupted IFS image.\n",
> +			expected_size, fw->size);
> +		return -EBADFD;

I don't think this error code is best suited for what occurred. I guess 
returning just -EINVAL would be fine.

-- 
 i.

> +	}
> +
>  	ret = image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
>  	if (ret)
>  		goto release;
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991D279D7D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbjILRoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbjILRoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:44:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC71F10F7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694540653; x=1726076653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4ETaAmE+XF3QgKmb5VAd8/TjXXslOJdM7cBkt+aXyyg=;
  b=DmyYLI37UbzZbmDlfa81dJu/T0JERF2vzIrmCUmjtemJ05vlSdmRsKTH
   I2vfWwEBahhhpQpQuFyQtTRZxnYJhFLV8lS6hci+Zy/p0t04eAzKU+LoR
   fUZwvBRx9fXm1zOizYa/aiguD5cFL3g/xHWzV72hBd9HwK91TFm0+UhB8
   AN93B+Qv2g+al4zEGhvevyo5e/9nq2GcPx9dDia+QsAPxEXQVe913zZlk
   9Zjiq5j78NzeeG/6a6xSgKXyYdfm+8B1dS1qzk8zxQ0iyEK6LuMpzgTtz
   wHoFJ/uB1KMRQU2f6I98VkljtygpU9NI8QXUwD8kVqum3CNgGhD6dsWU/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378356214"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378356214"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809363940"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="809363940"
Received: from skotini-mobl.amr.corp.intel.com (HELO [10.209.169.137]) ([10.209.169.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:44:12 -0700
Message-ID: <5a8de960-8ec4-be7b-1a60-0285f7627163@linux.intel.com>
Date:   Tue, 12 Sep 2023 13:33:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH] ALSA: hda: intel-sdw-acpi: Use u8 type for link index
Content-Language: en-US
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, tiwai@suse.com,
        perex@perex.cz, arnd@arndb.de
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20230912162617.29178-1-peter.ujfalusi@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230912162617.29178-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/23 12:26, Peter Ujfalusi wrote:
> Use consistently u8 for sdw link index. The id is limited to 4, u8 is
> adequate in size to store it.
> 
> This change will also fixes the following compiler warning/error (W=1):
> 
> sound/hda/intel-sdw-acpi.c: In function ‘sdw_intel_acpi_scan’:
> sound/hda/intel-sdw-acpi.c:34:35: error: ‘-subproperties’ directive output may be truncated writing 14 bytes into a region of size between 7 and 17 [-Werror=format-truncation=]
>    34 |                  "mipi-sdw-link-%d-subproperties", i);
>       |                                   ^~~~~~~~~~~~~~
> In function ‘is_link_enabled’,
>     inlined from ‘sdw_intel_scan_controller’ at sound/hda/intel-sdw-acpi.c:106:8,
>     inlined from ‘sdw_intel_acpi_scan’ at sound/hda/intel-sdw-acpi.c:180:9:
> sound/hda/intel-sdw-acpi.c:33:9: note: ‘snprintf’ output between 30 and 40 bytes into a destination of size 32
>    33 |         snprintf(name, sizeof(name),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    34 |                  "mipi-sdw-link-%d-subproperties", i);
>       |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> The warnings got brought to light by a recent patch upstream:
> commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow warnings in W=1")
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>  sound/hda/intel-sdw-acpi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/hda/intel-sdw-acpi.c b/sound/hda/intel-sdw-acpi.c
> index 5cb92f7ccbca..b57d72ea4503 100644
> --- a/sound/hda/intel-sdw-acpi.c
> +++ b/sound/hda/intel-sdw-acpi.c
> @@ -23,7 +23,7 @@ static int ctrl_link_mask;
>  module_param_named(sdw_link_mask, ctrl_link_mask, int, 0444);
>  MODULE_PARM_DESC(sdw_link_mask, "Intel link mask (one bit per link)");
>  
> -static bool is_link_enabled(struct fwnode_handle *fw_node, int i)
> +static bool is_link_enabled(struct fwnode_handle *fw_node, u8 idx)
>  {
>  	struct fwnode_handle *link;
>  	char name[32];
> @@ -31,7 +31,7 @@ static bool is_link_enabled(struct fwnode_handle *fw_node, int i)
>  
>  	/* Find master handle */
>  	snprintf(name, sizeof(name),
> -		 "mipi-sdw-link-%d-subproperties", i);
> +		 "mipi-sdw-link-%hhu-subproperties", idx);
>  
>  	link = fwnode_get_named_child_node(fw_node, name);
>  	if (!link)
> @@ -51,8 +51,8 @@ static int
>  sdw_intel_scan_controller(struct sdw_intel_acpi_info *info)
>  {
>  	struct acpi_device *adev = acpi_fetch_acpi_dev(info->handle);
> -	int ret, i;
> -	u8 count;
> +	u8 count, i;
> +	int ret;
>  
>  	if (!adev)
>  		return -EINVAL;

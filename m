Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C312C7E2F5F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjKFWAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjKFWAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:00:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8E11F;
        Mon,  6 Nov 2023 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699308042; x=1730844042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vszWPPXsju9JscN66VI8Yo3KG0OPHwEoAvA9/gUL2jU=;
  b=Kmj/zlsYRdv8Wg1N+SX7OR//+Nx8rogG5zxkhDhUuq1K186mRt1F6e+y
   wDmt7s0pxU7D0KBJI6Ce9zFd7UfaoITRBvn2aaKLV2rdrULn/8rM79D6m
   8iqZag3QIWOL3mz5oTPASuDD2zQEutnSIxOpgrMugvzuSjpzrwnrNfNho
   1ASZhzmb/UfPrwQkUO8g7agemd0UxaZN3m17U+i92wnSjXYWbfEFWLaug
   F1OaxVW9p6TqZ0HqfcAp7feRTvFKaMcPzAFwZpclz5EW2QCSrDUUSIJbc
   az39zQKRc+BUkXMOr6n/Z9Io0QsssmZpYaLi+qJN9og5IZFaVf7dcr6RI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475614938"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475614938"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="712335738"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="712335738"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:00:40 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id A5CD211F894;
        Mon,  6 Nov 2023 23:50:49 +0200 (EET)
Date:   Mon, 6 Nov 2023 21:50:49 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] ACPI: scan: Extract MIPI DisCo for Imaging data
 into swnodes
Message-ID: <ZUlfuWB9z1tlOGG7@kekkonen.localdomain>
References: <4542595.LvFx2qVVIh@kreacher>
 <1987710.usQuhbGJ8B@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1987710.usQuhbGJ8B@kreacher>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Mon, Nov 06, 2023 at 05:27:26PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes
> 
> Add information extracted from the MIPI DisCo for Imaging device
> properties to software nodes created during the CSI-2 connection graph
> discovery.
> 
> Link: https://www.mipi.org/specifications/mipi-disco-imaging
> Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3:
>    * Change the name of the new file to mipi-disco-img.c
>    * "DiSco" -> "DisCo" in multiple places
>    * Fix the link in the Link: tag
>    * Change the number of data lanes limit and add a comment regarding it
>    * Use ACPI_DEVICE_CSI2_DATA_LANES directly in several places instead
>      of array sizes equal to it

Thanks for the update. I've tested the set, so you can add:

Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>

with the following diff fixing mipi-img-lane-polarities parsing:

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index 3123180d9b54..92b45e792a07 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -530,7 +530,12 @@ static void init_csi2_port(struct acpi_device *adev,
 	}
 
 	ret = fwnode_property_count_u8(port_fwnode, "mipi-img-lane-polarities");
-	if (ret * BITS_PER_TYPE(u8) >= num_lanes + 1) {
+	if (ret < 0) {
+		acpi_handle_debug(handle, "Lane polarity bytes missing\n");
+	} else if (ret * BITS_PER_TYPE(u8) < num_lanes + 1) {
+		acpi_handle_info(handle, "Too few lane polarity bytes (%lu vs. %d)\n",
+				 ret * BITS_PER_TYPE(u8), num_lanes + 1);
+	} else {
 		unsigned long mask = 0;
 		int byte_count = ret;
 		unsigned int i;
@@ -543,15 +548,15 @@ static void init_csi2_port(struct acpi_device *adev,
 		 */
 		BUILD_BUG_ON(BITS_PER_TYPE(unsigned long) <= ACPI_DEVICE_CSI2_DATA_LANES);
 
-		if (byte_count > ACPI_DEVICE_CSI2_DATA_LANES) {
+		if (byte_count > sizeof(mask)) {
 			acpi_handle_info(handle, "Too many lane polarities: %d\n",
 					 byte_count);
-			byte_count = ACPI_DEVICE_CSI2_DATA_LANES;
+			byte_count = sizeof(mask);
 		}
 		fwnode_property_read_u8_array(port_fwnode, "mipi-img-lane-polarities",
 					      val, byte_count);
 
-		for (i = 0; BITS_PER_TYPE(u8) * i <= num_lanes; i++)
+		for (i = 0; i < byte_count; i++)
 			mask |= (unsigned long)val[i] << BITS_PER_TYPE(u8) * i;
 
 		for (i = 0; i <= num_lanes; i++)
@@ -561,8 +566,6 @@ static void init_csi2_port(struct acpi_device *adev,
 				PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
 							     port->lane_polarities,
 							     num_lanes + 1);
-	} else {
-		acpi_handle_info(handle, "Lane polarity bytes missing\n");
 	}
 
 	swnodes->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =

-- 
Kind regards,

Sakari Ailus

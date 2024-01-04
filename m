Return-Path: <linux-kernel+bounces-16612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142C824129
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2551F225C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235782136D;
	Thu,  4 Jan 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7Mmsssw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B321360;
	Thu,  4 Jan 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704369547; x=1735905547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTe/RxVVE0sGfQ8+wsroyqcIDjd9fQHmLgDYmLEGuUY=;
  b=e7MmssswY+j9lfVs80IuesQKJPAOfiQnLdJKo5w5GsOv2sSeaNsNmfeL
   CloToH7/gqEnOc0W6tfk8Rg21XlnzWDLryx4A4HBOe67ypWGIzk3yj41g
   fDJ84lbqa04D4lf7QIAZLwhINWEIzzi27nuD7CufHgOa+Pwwei18c6nCK
   3A8aBIW+Gvdy+oC4LqruX08+vE+DRf7/rarxEkb8b+gER29KsuN8HuEG8
   9Meo6Z7a2Hf3Lmq/Ebm5acMCkiaiNDC1mAg2jheaL1ml1TYwKnw8WhZTL
   Pi7vVCualiH4R9lUwOnlzCr+aEtptCK7EwE2qAjjnIVZSr6RJGFQ9H9Je
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="399995586"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="diff'?scan'208";a="399995586"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 03:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="809200356"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="diff'?scan'208";a="809200356"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga008.jf.intel.com with SMTP; 04 Jan 2024 03:59:03 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 04 Jan 2024 13:59:02 +0200
Date: Thu, 4 Jan 2024 13:59:02 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] Fix stuck UCSI controller on DELL
Message-ID: <ZZadhlh3q9ZInxvU@kuha.fi.intel.com>
References: <20240103100635.57099-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YdX7gGF+0oK9KB31"
Content-Disposition: inline
In-Reply-To: <20240103100635.57099-1-lk@c--e.de>


--YdX7gGF+0oK9KB31
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

On Wed, Jan 03, 2024 at 11:06:35AM +0100, Christian A. Ehrhardt wrote:
> I have a DELL Latitude 5431 where typec only works somewhat.
> After the first plug/unplug event the PPM seems to be stuck and
> commands end with a timeout (GET_CONNECTOR_STATUS failed (-110)).
> 
> This patch fixes it for me but according to my reading it is in
> violation of the UCSI spec. On the other hand searching through
> the net it appears that many DELL models seem to have timeout problems
> with UCSI.
> 
> Do we want some kind of quirk here? There does not seem to be a quirk
> framework for this part of the code, yet. Or is it ok to just send the
> additional ACK in all cases and hope that the PPM will do the right
> thing?

We can use DMI quirks. Something like the attached diff (not tested).

thanks,

-- 
heikki

--YdX7gGF+0oK9KB31
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dell_ucsi_quirk.diff"

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 6bbf490ac401..7e8b1fcfa024 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -113,18 +113,44 @@ ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_
 	return 0;
 }
 
-static const struct ucsi_operations ucsi_zenbook_ops = {
-	.read = ucsi_zenbook_read,
-	.sync_write = ucsi_acpi_sync_write,
-	.async_write = ucsi_acpi_async_write
-};
+static int ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
+				const void *val, size_t val_len)
+{
+	u64 ctrl = *(u64 *)val;
+	int ret;
+
+	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
+	if (ret && (ctrl & (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE))) {
+		ctrl= UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
+
+		dev_dbg(ucsi->dev->parent, "%s: ACK failed\n", __func__);
+		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
+	}
 
-static const struct dmi_system_id zenbook_dmi_id[] = {
+	return ret;
+}
+
+static const struct dmi_system_id ucsi_acpi_quirks[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
 		},
+		.driver_data = &(struct ucsi_operations) {
+			.read = ucsi_zenbook_read,
+			.sync_write = ucsi_acpi_sync_write,
+			.async_write = ucsi_acpi_async_write
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+		.driver_data = &(struct ucsi_operations) {
+			.read = ucsi_acpi_read,
+			.sync_write = ucsi_dell_sync_write,
+			.async_write = ucsi_acpi_async_write
+		},
 	},
 	{ }
 };
@@ -151,6 +177,7 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	const struct ucsi_operations *ops = &ucsi_acpi_ops;
+	const struct dmi_system_id *id;
 	struct ucsi_acpi *ua;
 	struct resource *res;
 	acpi_status status;
@@ -180,8 +207,9 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	init_completion(&ua->complete);
 	ua->dev = &pdev->dev;
 
-	if (dmi_check_system(zenbook_dmi_id))
-		ops = &ucsi_zenbook_ops;
+	id = dmi_first_match(ucsi_acpi_quirks);
+	if (id)
+		ops = id->driver_data;
 
 	ua->ucsi = ucsi_create(&pdev->dev, ops);
 	if (IS_ERR(ua->ucsi))

--YdX7gGF+0oK9KB31--


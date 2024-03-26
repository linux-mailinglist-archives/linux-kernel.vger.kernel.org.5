Return-Path: <linux-kernel+bounces-118363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510A88B989
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4431F34F11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A009823C7;
	Tue, 26 Mar 2024 04:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HHLRwVU/"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845829B0;
	Tue, 26 Mar 2024 04:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711428799; cv=none; b=MERi88K8D/oyU4CCLxKmFvNdAEADHLpPrVhxwqhQFaeey2to9fiCYADSlT8on4JaYuzSgCL8/JUjZenrq9dXNzxVM7ha5CleToVArH2sOjdoQJpWssd1JSHf7jrPFpKIYOrxivJwvF2HBxsP2riAlcDkG9quHZdKpq9ZJPKuOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711428799; c=relaxed/simple;
	bh=KmGUCevKcmeoE58Ez81yLHfAaMdcLuTjmIxyniFVV4c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWXTxl04J0/FaV1nja5ysQMJ+dFGoBopVQjlDtle3w9qnapnrdZjLCfzVK5Ven49FUftZ5AO7zvI5QoNcTMcs6j3a7LTaketR4AkMEZ9ERhkfhkB7C3dZ8BDMDgrOq4bvo7NSBiDXmUyRJfllIYyo45Hi+z7T5UBeO88Ol4mu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HHLRwVU/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42Q4r5uC080230;
	Mon, 25 Mar 2024 23:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711428785;
	bh=0jmyopnfie40ZqE9WVMKJH5VXLjoauA7GY8jkoeRMGg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HHLRwVU/xCLZ3GlW7nKv9vRTfQWpEPgy+2/+QGCODixJ+dQT4DtV0vU2+vkRGvDwD
	 GwC9+nLFcTaIWx3s3xGg1iabU5L+ET1WUy9GC1+DWjNOw22ZYvQ9PmfNMr8mmFfHGt
	 lVVZJcP9bzU2YDN9dJjcJa3lo/y+WXJmAxw70OWY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42Q4r5qc097858
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 23:53:05 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 23:53:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 23:53:05 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42Q4r4eL052507;
	Mon, 25 Mar 2024 23:53:04 -0500
Date: Tue, 26 Mar 2024 10:23:03 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Documentation: PM: Update platform_pci_wakeup_init()
 reference
Message-ID: <20240326045303.qy4przp73jcoutvh@dhruva>
References: <20240325220952.1453477-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325220952.1453477-1-helgaas@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Mar 25, 2024 at 17:09:53 -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> platform_pci_wakeup_init() was removed by d2e5f0c16ad6 ("ACPI / PCI: Rework
> the setup and cleanup of device wakeup") but was still mentioned in the
> documentation.
> 
> Update the doc to refer to pci_acpi_setup(), which does the equivalent
> work.
> 

Thanks! Documentation does go unnoticed sometimes.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> 
> pci_acpi_setup() is a firmware-specific wart in this otherwise generic
> paragraph, so maybe there's some better way to express this?
> 
>  Documentation/power/pci.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> index 12070320307e..e2c1fb8a569a 100644
> --- a/Documentation/power/pci.rst
> +++ b/Documentation/power/pci.rst
> @@ -333,7 +333,7 @@ struct pci_dev.
>  The PCI subsystem's first task related to device power management is to
>  prepare the device for power management and initialize the fields of struct
>  pci_dev used for this purpose.  This happens in two functions defined in
> -drivers/pci/pci.c, pci_pm_init() and platform_pci_wakeup_init().
> +drivers/pci/, pci_pm_init() and pci_acpi_setup().

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva


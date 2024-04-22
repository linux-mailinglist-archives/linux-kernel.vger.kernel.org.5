Return-Path: <linux-kernel+bounces-152897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4AE8AC5E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D906B22284
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F924F21D;
	Mon, 22 Apr 2024 07:45:52 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588654CE13
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771951; cv=none; b=Byj04xVsCLPnJJcH4awpqFEm70IJ76pqrb7rEFXBGWFBW+zeZrm6C0rCuy41Qj6ePn3x1K3dbQFPYKQckg9SUvoYorq/3dGwdwBo8KlkP7dR2kc263jPvggLHQdL6AKo0Zu3khQJo/AQC4P+o3WKtHyGLV+GYCU9XiwV/KZU2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771951; c=relaxed/simple;
	bh=0tZUCejrJ79JNWlBVqZKd9V4vKZCGo0VoibkvLVA/P8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqyebP9lKA285QplUNKcIRB0YL0LfhH6n833FzRDXtnRnvaS2AtyKTLdgPDzviixL9Kc39UNaYo4juOFXq+jPQy/W7HKtlaEycMvSBq76OFOx17c3kiMxeemWb0E8wrOCoW/c6ST7lqVipghHvzL9B9pLIIpJY13k+6IRZsDeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 5482aa03-007c-11ef-a9de-005056bdf889;
	Mon, 22 Apr 2024 10:45:46 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 10:45:46 +0300
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7-incomplete 1/3] PCI: Move PRESERVE_BOOT_CONFIG _DSM
 evaluation to pci_register_host_bridge()
Message-ID: <ZiYVqulm8cE_FGKx@surfacebook.localdomain>
References: <20240418174043.3750240-1-vidyas@nvidia.com>
 <20240421190914.374399-1-helgaas@kernel.org>
 <20240421190914.374399-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421190914.374399-2-helgaas@kernel.org>

Sun, Apr 21, 2024 at 02:09:12PM -0500, Bjorn Helgaas kirjoitti:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Move the PRESERVE_BOOT_CONFIG _DSM evaluation from acpi_pci_root_create()
> to pci_register_host_bridge().
> 
> This will help unify the ACPI _DSM path and the DT-based
> "linux,pci-probe-only" paths.

..

> +bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
> +{
> +	if (ACPI_HANDLE(&host_bridge->dev)) {

Wouldn't the below looks nicer if you invert the conditional?

	handle = ACPI_HANDLE(...);

	if (!handle)
		return false;

	...

> +		union acpi_object *obj;
> +
> +		/*
> +		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> +		 * exists and returns 0, we must preserve any PCI resource
> +		 * assignments made by firmware for this host bridge.
> +		 */
> +		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
> +					      &pci_acpi_dsm_guid,
> +					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
> +					      NULL, ACPI_TYPE_INTEGER);
> +		if (obj && obj->integer.value == 0)
> +			return true;
> +		ACPI_FREE(obj);
> +	}
> +
> +	return false;
> +}


-- 
With Best Regards,
Andy Shevchenko




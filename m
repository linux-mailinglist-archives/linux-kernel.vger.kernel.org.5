Return-Path: <linux-kernel+bounces-152890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EAE8AC5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F791F22551
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C6502B3;
	Mon, 22 Apr 2024 07:43:13 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4B50283
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771793; cv=none; b=nABE89S1Yeb+v37/6XQnWTv1Tadjs8PoPGQOdPe3neG3erW0YxZXrhPxvDa3VcpMHqSaL39oM/En92fsHClbOfwBO9j4Og/T9hsgKbDRkoMlljYaR24xhwjNVQDSGieiupoMcoRkQROk8hYCqjk/NojBulDatMJQxnp4hmlccXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771793; c=relaxed/simple;
	bh=ew5dSgQMfS9IwbBwrIa9E4pKL0iPTREwTY8/gbHfluY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjtJNnJta4xiUnqJKhUUYykBXiIljo8/UlFZfrU6Ig0xlkManTioTSQz4p2tnb0EAiCKUgbD8FZr8xSvjCpOJLAnoWDlqO3zXmFCdgkoMGaCC5c3rDNL701IlhFQXQ2p0ST2sgir/NXfwE1cngpmAvH+Z2KO14bjsFd+DgCCt1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id f64f7c0a-007b-11ef-a9de-005056bdf889;
	Mon, 22 Apr 2024 10:43:09 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 10:43:08 +0300
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
Subject: Re: [PATCH v7-incomplete 3/3] PCI: Unify ACPI and DT 'preserve
 config' support
Message-ID: <ZiYVDEt-c57rAIl7@surfacebook.localdomain>
References: <20240418174043.3750240-1-vidyas@nvidia.com>
 <20240421190914.374399-1-helgaas@kernel.org>
 <20240421190914.374399-4-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421190914.374399-4-helgaas@kernel.org>

Sun, Apr 21, 2024 at 02:09:14PM -0500, Bjorn Helgaas kirjoitti:

..

> +	if (host_bridge->dev.parent && host_bridge->dev.parent->of_node)
> +		return of_pci_preserve_config(host_bridge->dev.parent->of_node);

If you need fwnode or of_node from struct device, please avoid direct
dereference, we have

dev_fwnode()
of_fwnode_handle()
dev_of_node()

-- 
With Best Regards,
Andy Shevchenko




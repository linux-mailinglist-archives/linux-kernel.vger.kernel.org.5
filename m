Return-Path: <linux-kernel+bounces-157036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2498B0BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A883328A0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F8615DBC1;
	Wed, 24 Apr 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8sfgpaQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74815D5C0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967534; cv=none; b=iEJ8d6LOfsvGdTDV6UtjSiWpnmlzwfqkP629GQ3uD5O8Qv39xbWrxiv6q4MDJ5f25MVDT8udyPlPkCQzPJ6hdiSHF/gah1nOXNQSkRuHIpxLWLhq8kwmffRky0LDK6c7sp3Wj8Uv2M/6b3mo4/wEM2edETRiWQFn6Dx4Y5I7TDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967534; c=relaxed/simple;
	bh=ey9oyTmXZlZecBO3QRFen31KFyHb1ry9Zqo53j3ICDk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MM5dm5tePqcIqC41vTXEPrAYKYcAj4j3/nxIkrFLupy7JaHsXhN5t/mwjiGB/aDWRp5DbYoqsZaejgFwLoAIPjP9AoCV6CMn1ayQAw+COVxSyBtlMCm1la0H/xowp8ulSQvTaPRYLKQjmGH1vw6dDIvdjc+v0SEOMUbFMFFbqDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8sfgpaQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713967533; x=1745503533;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ey9oyTmXZlZecBO3QRFen31KFyHb1ry9Zqo53j3ICDk=;
  b=X8sfgpaQq0+uKgbNI3IYZwmzGQf7BYTYHr+7pkBwS9ZhoKexFbcez8uu
   u7ZfxCDUO1cI3wQN3MZerTUIHvdIx3sw5Ut8PevTclS62iI7zGZe2wGDX
   voTVQh1yAEYGasT8W6azVYCt2DkszsAtZC61CDwhFpI2jya5d+z1MObYK
   1NfuCgl7mt4FXNqe+m+6lILSnPRXBi7UfcsT4OOJhdh6Y/EpstilXfsl6
   xtGnAlwwCITJAy3UVIj3E3Ut4nD79+EOj1KqwD2p2ki20oJ+xJgZwnn4k
   6I95HKlv3tftuoYpPy1xTPYcgszNth/4WzE8pbHCoDa+jLBThKfTIW4WJ
   g==;
X-CSE-ConnectionGUID: HyddI94sTem57d3QCOQptQ==
X-CSE-MsgGUID: 2civfGz3TIahMaIgFCdVtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="21008442"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="21008442"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:05:32 -0700
X-CSE-ConnectionGUID: Sjwfo/90RAKUPAsMZhL7Qw==
X-CSE-MsgGUID: DurwqDyzT964FX5Sx/+hwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24762215"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:05:29 -0700
Message-ID: <d43d54bc-e51d-4483-80ab-c0d52572de24@linux.intel.com>
Date: Wed, 24 Apr 2024 22:05:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 ewagner12@gmail.com, suravee.suthikulpanit@amd.com, vashegde@amd.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
 <3cf97e3c-c8d9-4282-a8ca-e4c1ea383dbd@arm.com>
 <20240424130457.GF231144@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240424130457.GF231144@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/24 21:04, Jason Gunthorpe wrote:
>> Furthermore I'm pretty sure we're still letting an
>> untrusted device be hotplugged into an existing group without any
>> checks at all.
> Yes, combining trusted and untrusted in the same group, regardless of
> domain type, is fundamentally wrong and we don't check it.

I suppose this should be fixed in the PCI layer. The current algorithm
is setting external_facing to the pci port which has been marked as an
external facing port.

static void pci_acpi_set_external_facing(struct pci_dev *dev)
{
         u8 val;

         if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
                 return;
         if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
                 return;

         /*
          * These root ports expose PCIe (including DMA) outside of the
          * system.  Everything downstream from them is external.
          */
         if (val)
                 dev->external_facing = 1;
}

Then, all devices connected to this port are marked as untrusted.

static void set_pcie_untrusted(struct pci_dev *dev)
{
         struct pci_dev *parent;

         /*
          * If the upstream bridge is untrusted we treat this device
          * untrusted as well.
          */
         parent = pci_upstream_bridge(dev);
         if (parent && (parent->untrusted || parent->external_facing))
                 dev->untrusted = true;
}

The above algorithms don't consider the ACS. Hence, an untrusted device
could possibly gain P2P access to other devices that are treated as
trusted. This appears to be already broken.

Thus, the impact has already beyond iommu group if I didn't overlook
anything.

Best regards,
baolu


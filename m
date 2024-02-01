Return-Path: <linux-kernel+bounces-48556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9785D845DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B619EB320ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A7566F;
	Thu,  1 Feb 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVti+aIf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA27E0F3;
	Thu,  1 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806421; cv=none; b=BEXf1IkoHHIC23IeW6CuxmMUlDwa3nEQ09801NPtvJgVtfTyX7aMcbrJqhZwVlic9634XweBoLM68f6s9y6lIIc0WJtLhukHZjrNBRt+xywZ8I5FcxtBRmCgkrXRo0S3dErFxJ1uMAR4nxlMF/XyYTZAh2jcOK/6CIsJGR94Tpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806421; c=relaxed/simple;
	bh=I7Ahts5FC1yoo78oedJYZm6nSk97Y43sZz3297dmoX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARbiupv3LcePDVPqk5YDJ+UacA9EpIZLOwLxJzZ/5KmGKFWT3ZkriI0LuX1b3aEeWT6bihQjjJQaxjV5tzW2KWtvehctaQHzCCE4uqwip2HRiWx0E3T1ngK4lrVDpE/VDRF1YRiclakrMAKpjqxc6zxMRFIMdk9dDH2NdUFsT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVti+aIf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706806420; x=1738342420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I7Ahts5FC1yoo78oedJYZm6nSk97Y43sZz3297dmoX0=;
  b=MVti+aIfjs3qFrgbLOM+9+YvifNUVs9uXPf1OHxh43tASq9nlSv8RfJN
   vbcC/qp2LWhlL8ZvUfXlN1hearKsHco3OJ4/GfoxJYl3ZAOSHbRhkSEgA
   3nXr6OukJQjZHTKnLf/LGYpa1uS3NAIPBp0ReH/r1MEAqlVtm5op5w1Eh
   00RKJhOo0KNGKxfRXTUpPiPLyh7aCecHHiUsvVTUQq/9hi8RpwzZtqR0a
   JFNCIu4iewlgnkcykmfZOKqdwBK4oxESjd49r74auvPVdmATbMs5kR5TF
   tBjblgGmKaxjfPWKIU+fwOp10tNEmRtyAeNAz3rtU9N5A/EnmRDd3kbrR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3774530"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3774530"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:53:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="136586"
Received: from cacasing-mobl1.amr.corp.intel.com (HELO [10.209.102.228]) ([10.209.102.228])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:53:39 -0800
Message-ID: <ea0ae8ac-41bc-4aaa-87b6-af31002e6ce0@linux.intel.com>
Date: Thu, 1 Feb 2024 08:53:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Intel On Demand: Add netlink interface for SPDM
 attestation
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>, netdev@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240201010747.471141-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/31/24 5:07 PM, David E. Box wrote:
> This patch series primarily adds support for a new netlink ABI in the
> Intel On Demand driver for performing attestation of the hardware state.

Try to add some info about why you need new netlink ABI?

>
> Attestation patches
>
> Patch 1: The attestation mailbox command requires that the message size
> register be set along with the package size. Adds that support.
>
> Patch 2: The attestation command will need to write the SPDM message and
> read the response. The current mailbox flow handles reads and writes
> separately. Combines the two flows.
>
> Patch 3: Patch 4 will create a separate c file for the netlink
> interface. Add a separate header file now. No functional changes. This
> mostly just makes it easier to see the changes in Patch 4.
>
> Patch 4: Adds attestation support to the driver and provides a netlink
> interface to perform the service.
>
> Other changes
>
> Patch 5: Adds support to read the in-band BIOS lock. If set, On Demand
> controls are not available in the driver.
>
> Patch 6: Adds a new attribute to allow reading the most current metering
> state.
>
> Patch 7: Fixes for the intel_sdsi tool
>
> Patch 8: Adds support to the intel_sdsi tool to read the current meter
> state.
>
> David E. Box (7):
>   platform/x86/intel/sdsi: Set message size during writes
>   platform/x86/intel/sdsi: Combine read and write mailbox flows
>   platform/x86/intel/sdsi: Add header file
>   platform/x86/intel/sdsi: Add netlink SPDM transport
>   platform/x86/intel/sdsi: Add attribute to read the current meter state
>   tools: Fix errors in meter_certificate display
>   tools: intel_sdsi: Add current meter support
>
> Kuppuswamy Sathyanarayanan (1):
>   platform/x86/intel/sdsi: Add in-band BIOS lock support
>
>  Documentation/netlink/specs/intel_sdsi.yaml |  97 ++++++
>  MAINTAINERS                                 |   3 +
>  drivers/platform/x86/intel/Makefile         |   2 +-
>  drivers/platform/x86/intel/sdsi.c           | 317 ++++++++++++++++----
>  drivers/platform/x86/intel/sdsi.h           |  47 +++
>  drivers/platform/x86/intel/sdsi_genl.c      | 249 +++++++++++++++
>  include/uapi/linux/intel-sdsi.h             |  40 +++
>  tools/arch/x86/intel_sdsi/intel_sdsi.c      |  99 +++---
>  8 files changed, 754 insertions(+), 100 deletions(-)
>  create mode 100644 Documentation/netlink/specs/intel_sdsi.yaml
>  create mode 100644 drivers/platform/x86/intel/sdsi.h
>  create mode 100644 drivers/platform/x86/intel/sdsi_genl.c
>  create mode 100644 include/uapi/linux/intel-sdsi.h
>
>
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



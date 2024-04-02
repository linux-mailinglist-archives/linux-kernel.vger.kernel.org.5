Return-Path: <linux-kernel+bounces-128718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6CC895E99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2ABB26912
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD415E5B5;
	Tue,  2 Apr 2024 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0qlstZK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE115E1ED;
	Tue,  2 Apr 2024 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092738; cv=none; b=gdiZXphNn3nqxqNQcthEAXt8msnq71WanWmMF/FW3awlMzYZvCz9LjyE4SafP+qCvR13Lv+Qu34o8CvlWtS+f+/1RZtjSUujo+muvOUF/3xmvIwxgP432zevCzTzlfNCJh0+UBJ2PgclundSZcdhq5R4Wvb+2TQaXqQallArwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092738; c=relaxed/simple;
	bh=a64aBz+qJCuDjrZzXwUHTG67TCnU0BFz9DnSbJBBS34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIjS5ibPifQKveIV/1jn2QCrNRqtm+ES7G8n2jc6qrmYEg/l2eLAqaVYRIK8Nmuq3Muqs0zhofc64b617FyjhL6c8K6ZOT5osBQlUb94Fx5L/dEDeQ/YkVSUeIGTpGKZ207JldFgD9s5LKs/tDXUNWqsLR5HUuCpGmAh0iKtzjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0qlstZK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712092737; x=1743628737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a64aBz+qJCuDjrZzXwUHTG67TCnU0BFz9DnSbJBBS34=;
  b=L0qlstZKQU2NzKCqOuwTzj8miWPp10yEpEnJF4wAUObzMQ/Zhfhdsmiy
   zEymnXSY1fDXCDmeTOeddp33xjFh06IxEcH37MxPVdRtbjp6jP+ytEllu
   AW//nCLN6RzeKeSiuQx/wydyX04G5io8CpbHsfMl5tfC6vReRtNWCrOj7
   2t7E+rWFpF1QMF+DQ+K4z9f1ZP1iVSy4jd8QkugzE2qj6GnXRqD7hrgy2
   o10GCxMLLF6e4ikKClpxu9lQMW4hHBfSoDNoDH1zNYesW7eGySSxe0d3C
   8E7Y2DFl7ELpwHbfsTy8PbJ/S4r2r/hlTUhMunz0TBVP0a5blEuBojgG2
   A==;
X-CSE-ConnectionGUID: 4SEso44ORB2z1MBW1ZGegw==
X-CSE-MsgGUID: 0Wz6gOBtTKKMRkaNSRzYmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18657523"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18657523"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:18:56 -0700
X-CSE-ConnectionGUID: Fy7xWkSuSCGfkK7MWH6qQQ==
X-CSE-MsgGUID: 89GzvOrnT4WT0pjeCG3DJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22668131"
Received: from ooginni-mobl.amr.corp.intel.com (HELO [10.209.114.45]) ([10.209.114.45])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:18:56 -0700
Message-ID: <87797de2-7c10-4280-96c6-1e094762be69@linux.intel.com>
Date: Tue, 2 Apr 2024 14:18:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] ACPI: LPSS: Prepare for SPI code cleanup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
References: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/2/24 8:28 AM, Andy Shevchenko wrote:
> An ad-hoc cleanup followed by preparation for SPI code cleaning.
> The latter will be done in the next kernel cycle to avoid conflicts.

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Andy Shevchenko (2):
>   ACPI: LPSS: Remove nested ifdeffery for CONFIG_PM
>   ACPI: LPSS: Advertise number of chip selects via property
>
>  drivers/acpi/acpi_lpss.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



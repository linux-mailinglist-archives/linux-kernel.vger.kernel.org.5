Return-Path: <linux-kernel+bounces-36824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E173383A767
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB41B242B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BCA1AACE;
	Wed, 24 Jan 2024 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5rW4pNt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581F1AAB1;
	Wed, 24 Jan 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094074; cv=none; b=YQhPi3ECj130U99Cm0/eOJezkcyKOmV5opRxtv6sxrt96uosC4wXS+/TjG3FLjoWNvhxlvFfXrgrHnr5wq4SwWcqqJCcSqvk/pnqfkiuaCOP+eZLilMv/Cx8QsI4GjG5xLDte/vWOi9z/2CX2EUgjBKU07U+g9OFLO96A3a+gAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094074; c=relaxed/simple;
	bh=B2qi/Hw43qFMhMK3boYnGYHzXu79gEK/nCZdLkqlPWc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lQqb6qmDOL3vH6gA7NqO7yTZm0ylahpyfg0KfGd0selTbhAezxjFAifouZnQKAO/t73/Cma/F18PIL3rkFlXRVyNOO+vrWgrPzpKBsJRGZyWtz/ADV7+8bzLvQenz7HJi/peuOCrSsdIpp2F/TLZrfmPZ2eOOG+3yV7NrwB5kMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5rW4pNt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706094073; x=1737630073;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B2qi/Hw43qFMhMK3boYnGYHzXu79gEK/nCZdLkqlPWc=;
  b=k5rW4pNtCJ3a6LkAc+ozKBACTxrUdfRAANWoGZ4+afzTMCUq85Ln7gQc
   nb/3Vd3pebbd8IC4fzTNwGsCZyEfVrfUrc3NQHIaUSLzZLM7NSgg1iZjj
   Uc0Ei3vyMUnC6LIGQgkE5VFyWRHSpQI1gsfgl5udLFcWb4fymHIQ/3zQs
   6ITmUwABoT9PUVmwBVpKE/p082Gb1uXwcXibyNDJv+4P8k6DT7xGRoMPY
   e4qdnK1cdIiOJJGfrOtzc/pdsZbfLEqRnOD2r65VafbcASJ6UaKWaDGLM
   01QnsLdMn8dN2hofSmak/JoAnE0oqI42LrKTpd3J4HcE+fYKRwkIO5B/E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15334630"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15334630"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:01:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1937235"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:01:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Jan 2024 13:01:05 +0200 (EET)
To: Li Zhijian <lizhijian@fujitsu.com>
cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
    Vadim Pasternak <vadimp@nvidia.com>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 14/42] drivers/platform/mellanox: Convert snprintf to
 sysfs_emit
In-Reply-To: <20240116045151.3940401-12-lizhijian@fujitsu.com>
Message-ID: <1ddc2cc6-1f9c-09c0-acf6-93fa39a10540@linux.intel.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com> <20240116045151.3940401-1-lizhijian@fujitsu.com> <20240116045151.3940401-12-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Jan 2024, Li Zhijian wrote:

> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> > ./drivers/platform/mellanox/mlxbf-bootctl.c:466:8-16: WARNING: please use sysfs_emit
> > ./drivers/platform/mellanox/mlxbf-bootctl.c:584:8-16: WARNING: please use sysfs_emit
> > ./drivers/platform/mellanox/mlxbf-bootctl.c:635:8-16: WARNING: please use sysfs_emit
> > ./drivers/platform/mellanox/mlxbf-bootctl.c:686:8-16: WARNING: please use sysfs_emit
> > ./drivers/platform/mellanox/mlxbf-bootctl.c:737:8-16: WARNING: please use sysfs_emit
> > ./drivers/platform/mellanox/mlxbf-bootctl.c:788:8-16: WARNING: please use sysfs_emit
> > ./drivers/platform/mellanox/mlxbf-bootctl.c:839:8-16: WARNING: please use sysfs_emit
> 
> No functional change intended
> 
> CC: Hans de Goede <hdegoede@redhat.com>
> CC: ilpo.jarvinen@linux.intel.com
> CC: Vadim Pasternak <vadimp@nvidia.com>
> CC: platform-driver-x86@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Applied to pdx86 review-ilpo branch.

-- 
 i.


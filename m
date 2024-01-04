Return-Path: <linux-kernel+bounces-17077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE2E824804
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7FE1C20E4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6F28DD7;
	Thu,  4 Jan 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQsYPQBj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF828DC3;
	Thu,  4 Jan 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704392084; x=1735928084;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sA1m4Z7P3CQ1pNqVc8Y8YSLSGCDu3yuKBy1DkHN+zck=;
  b=mQsYPQBjgRlZdQ4qmkqz4gbzWbLuCn8vxhrsg/xe/7b9nGOxx2IMkaeF
   QecmRq3O66R75nk6/i6wjTW033UkvEPojsRAkz0VfuZaeWP9a16KunqAk
   rxAzpHchOETZH+QXtN6JTbQyXECqertvbR9hYku4Yj1z9iy8IMTD5IBUM
   RZl565PysoT09zClML9zXFNW+feZ6teQC0lDdl2ZZlWY3S/hxtjCB+syi
   kJdtzC5uV4PNF4QCd2fO0/jvq9kwMtWmLqj2MtyWpDPydRmpB420rabYB
   BgCeiZM11IeHXSAKoyR9L045HTBMrqz/vXB/gR1e6MG34urtgyUeV6GEO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="15952104"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="15952104"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="903905911"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="903905911"
Received: from asebenix-mobl1.ger.corp.intel.com ([10.251.210.215])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:14:41 -0800
Date: Thu, 4 Jan 2024 20:14:38 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] platform/x86: wmi: Decouple legacy WMI notify handlers
 from wmi_block_list
In-Reply-To: <20240103192707.115512-4-W_Armin@gmx.de>
Message-ID: <ff735fbd-a0b4-6e-d3c9-a1358e9d9616@linux.intel.com>
References: <20240103192707.115512-1-W_Armin@gmx.de> <20240103192707.115512-4-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1830788590-1704392082=:10531"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1830788590-1704392082=:10531
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 3 Jan 2024, Armin Wolf wrote:

> Until now, legacy WMI notify handler functions where using the
> wmi_block_list, which did no refcounting on the returned WMI device.
> This meant that the WMI device could disappear at any moment,
> potentially leading to various errors.
> Fix this by using bus_find_device() which returns an actual
> reference to the found WMI device.
> 
> Tested on a Dell Inspiron 3505 and a Acer Aspire E1-731.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1830788590-1704392082=:10531--


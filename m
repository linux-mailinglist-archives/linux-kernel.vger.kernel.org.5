Return-Path: <linux-kernel+bounces-17074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4CF8247FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505AC1C223BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B128DCF;
	Thu,  4 Jan 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxNi6PqY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CE28DC1;
	Thu,  4 Jan 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704391832; x=1735927832;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1Vek50sjpofiA67BZR6wezH67rKyzIFgowkaO9Lgv4U=;
  b=KxNi6PqYqZBlEW5pCU7dJ3FVANs3uMV/zqlr3aefDn5WsaM16DKt0I10
   zZcC25h4EQ5DIoC0tV9jjhXyaR78xr3C4OucE/v9KOrwk8nEcf0X6y5wN
   UnPA0Cy6jWdf9BJoT3q39fiLMuG2hOAM6dfAnI+toVjHaaYLM0R551Pub
   JtUhaHkO82mtks+nE3E9bTRz4gS71g18i/4QICfUT5N8oFALHKrwkxh41
   m4PXu1vRVqG6XGi+j2z1lZm5oHwL4YRbvuC0bQmHcBgbvpEYNwUVS/B+T
   bakV4dgbcxqUVJV4kwodrAH6p6WGRGlDjgtXajC646I2aXZHKlNYFgpXv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="461627566"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="461627566"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:10:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="953695272"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="953695272"
Received: from asebenix-mobl1.ger.corp.intel.com ([10.251.210.215])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:10:28 -0800
Date: Thu, 4 Jan 2024 20:10:26 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] platform/x86: wmi: Fix error handling in legacy WMI
 notify handler functions
In-Reply-To: <20240103192707.115512-2-W_Armin@gmx.de>
Message-ID: <f17bb6e-579-5031-b533-249e90948a40@linux.intel.com>
References: <20240103192707.115512-1-W_Armin@gmx.de> <20240103192707.115512-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-123273794-1704391829=:10531"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-123273794-1704391829=:10531
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 3 Jan 2024, Armin Wolf wrote:

> When wmi_install_notify_handler()/wmi_remove_notify_handler() are
> unable to enable/disable the WMI device, they unconditionally return
> an error to the caller.
> When registering legacy WMI notify handlers, this means that the
> callback remains registered despite wmi_install_notify_handler()
> having returned an error.
> When removing legacy WMI notify handlers, this means that the
> callback is removed despite wmi_remove_notify_handler() having
> returned an error.
> 
> Fix this by only warning when the WMI device could not be enabled.
> This behaviour matches the bus-based WMI interface.
> 
> Tested on a Dell Inspiron 3505 and a Acer Aspire E1-731.
> 
> Fixes: 58f6425eb92f ("WMI: Cater for multiple events with same GUID")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-123273794-1704391829=:10531--


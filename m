Return-Path: <linux-kernel+bounces-17076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5C2824801
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA8C1F22C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AAA28DCC;
	Thu,  4 Jan 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXdgM8Dx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A5D28E0C;
	Thu,  4 Jan 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704392037; x=1735928037;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5yVYAGe6UBT/4OgO8YOiJPQ2PSEyGYD5OvzWkkodYqg=;
  b=nXdgM8DxWBCT/D0hmIJaLPjUAVj5tYJUtFb8ytLmgTwOEhTRmB7L8WAh
   ucGXOCpBSYkQBola4Mm5YmSjLMXh3aFZpIfVAw+ov99bRziOT+WX3M+CE
   1W5379ibuRyiue8N72X0Y+j/JwwHFoAz45mD7SFXQlV1EfdMY1YwuGNTM
   nLgj7KmzVBhGC64OlJ500vFU+XgOhlc9rEowmthtoi0ISJ5t5D1Mk5+HS
   kxL2QfmIYHdeJxkVzC7NVCCzuKuVH4lfDVRdqAoQFssR3DPSbbDYUuNsg
   FL2tVklBtTmhvvhNgH1SaKi8x42xl93EGFbXyzjnvF6XrUteahC/AI2Lo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="400089673"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="400089673"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:13:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="783964573"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="783964573"
Received: from asebenix-mobl1.ger.corp.intel.com ([10.251.210.215])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:13:55 -0800
Date: Thu, 4 Jan 2024 20:13:53 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] platform/x86: wmi: Return immediately if an suitable
 WMI event is found
In-Reply-To: <20240103192707.115512-3-W_Armin@gmx.de>
Message-ID: <1fc39362-c4fc-6088-4ec-d44ca6328252@linux.intel.com>
References: <20240103192707.115512-1-W_Armin@gmx.de> <20240103192707.115512-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-965000451-1704392036=:10531"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-965000451-1704392036=:10531
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 3 Jan 2024, Armin Wolf wrote:

> Commit 58f6425eb92f ("WMI: Cater for multiple events with same GUID")
> allowed legacy WMI notify handlers to be installed for multiple WMI
> devices with the same GUID.
> However this is useless since the legacy GUID-based interface is
> blacklisted from seeing WMI devices with duplicated GUIDs.
> 
> Return immediately if a suitable WMI event is found in
> wmi_install/remove_notify_handler() since searching for other suitable
> events is pointless.
> 
> Tested on a Dell Inspiron 3505 and a Acer Aspire E1-731.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-965000451-1704392036=:10531--


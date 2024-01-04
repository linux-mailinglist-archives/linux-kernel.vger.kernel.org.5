Return-Path: <linux-kernel+bounces-17080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C7582480A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C941C22362
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F37B28DD1;
	Thu,  4 Jan 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPTJthAl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910128E09;
	Thu,  4 Jan 2024 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704392165; x=1735928165;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YLRcpSO6cAN5RETNk8SYfL6LjFkpEAgImWajLZwuDFo=;
  b=cPTJthAlje4kflhUfTkjqwFluPdOwnY8YA+S5OYAh30AfNhwHQ78L2Sr
   azqMgP5TDL+17lmja3qoMQrlCptPSeA5dupZgqGV/vUVFtLyke6smE5c0
   mFMB95+9zzz5OtLaHWmW+bLMd3IrUh8ov3R4Y3x+dKocazaTRD2E9rOjK
   uQXNtYHK0Yh99FSH7SPMsojjasPdGZgxc067UZQ4YGF/fUZLKXgbRc53P
   SquiEIjp8jZRNctGAqDt7ZcqEHuzLNm1BfhA71k0Hs5Tfr8EL1CH+iP5W
   84nqMPchrZwtsWjDkQS0xtK0yc7KcQnfy7+54Q/TDNikT2sLevJsHLZDg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="376812143"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="376812143"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:16:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="730252352"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="730252352"
Received: from asebenix-mobl1.ger.corp.intel.com ([10.251.210.215])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:15:58 -0800
Date: Thu, 4 Jan 2024 20:15:54 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] platform/x86: wmi: Fix notify callback locking
In-Reply-To: <20240103192707.115512-5-W_Armin@gmx.de>
Message-ID: <7ab5e3e6-b8c2-bc57-c12f-b77ed06b84de@linux.intel.com>
References: <20240103192707.115512-1-W_Armin@gmx.de> <20240103192707.115512-5-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1628265332-1704392159=:10531"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1628265332-1704392159=:10531
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 3 Jan 2024, Armin Wolf wrote:

> When an legacy WMI event handler is removed, an WMI event could
> have called the handler just before it was removed, meaning the
> handler could still be running after wmi_remove_notify_handler()
> returns.
> Something similar could also happens when using the WMI bus, as
> the WMI core might still call the notify() callback from an WMI
> driver even if its remove() callback was just called.
> 
> Fix this by introducing a rw semaphore which ensures that the
> event state of a WMI device does not change while the WMI core
> is handling an event for it.
> 
> Tested on a Dell Inspiron 3505 and a Acer Aspire E1-731.
> 
> Fixes: 1686f5444546 ("platform/x86: wmi: Incorporate acpi_install_notify_handler")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1628265332-1704392159=:10531--


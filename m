Return-Path: <linux-kernel+bounces-39451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FAC83D158
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D33B23F72
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A026D801;
	Fri, 26 Jan 2024 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4SzeITF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072117E;
	Fri, 26 Jan 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227866; cv=none; b=nnw78eEDjgmpdVtWjzAYKD2pVCfFgNC42dwTdmTQpw/BOa5oTjBwrwvuA8gPTZOMWpXYKh7IVoDAfkUbrHR5gqLXhlUci5KJwytNFrqYe1AQoRrII97R4N6EXTJq7deJi3/tReWaDjFdyft0AmSzzSzUaFh60/IR0xGEjK+R/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227866; c=relaxed/simple;
	bh=4EmZ7AHKnqM9ji1M7aTEUzuNksCxHC5kwkNr6lbdQ9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RJMu0/PgfBNXzXQI+a5xJ9ikdaWlSYhbYu0jtZgO+nDER438dblkwwxrduEKsd0G8s3Iv55Xz6O2zTf7HdxRUrRWXk2XXAXX/G9wFeTS/AA0jMSJG9VJBLCYKDvylltJ0YwfEHKqpZAF5ypBGDh4OX+2kJKGdR/y5GW7XP9hMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4SzeITF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706227864; x=1737763864;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4EmZ7AHKnqM9ji1M7aTEUzuNksCxHC5kwkNr6lbdQ9I=;
  b=W4SzeITF5kjya+z6ob92rVPaGxwoyYW4ntVducxmoGFRvR5X3auqoQKu
   VPBQ0gx4nnsp+qBG3Q6CI9GEROmfTQ/dDlA1/Oryix1jbiMYGVDBr6HK6
   5e18KikZJ0U5JSikEz+wrm+nbaw9jumUi9OG95E4eUFOR/0p8NrUapbKw
   UxGNPvif2qXHgdS4rXdaNhcTQpya06HvHR7xVVvxaLlg2oWpoKkw0I7o+
   D9rgCNzJbtFhvOU9aw4hmyh5ER84Djhgzy88w29Vbzsx2g/jv8dtai6T7
   gks+vucEaASp8dNDBcizszjlJMZNj5Tz976o0ptJ3bgZ2YtGN3cUkd/7p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15870615"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15870615"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:11:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28951861"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.67])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:11:03 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Sai Krishna <saikrishnag@marvell.com>, richardcochran@gmail.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 lcherian@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Cc: Sai Krishna <saikrishnag@marvell.com>, Naveen Mamindlapalli
 <naveenm@marvell.com>
Subject: Re: [net-next PATCH] octeontx2: Add PTP clock driver for Octeon PTM
 clock.
In-Reply-To: <20240124064156.2577119-1-saikrishnag@marvell.com>
References: <20240124064156.2577119-1-saikrishnag@marvell.com>
Date: Thu, 25 Jan 2024 16:11:02 -0800
Message-ID: <87h6j154yx.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sai Krishna <saikrishnag@marvell.com> writes:

> The PCIe PTM(Precision time measurement) protocol provides precise
> coordination of events across multiple components like PCIe host
> clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
> support for ptp clock based PTM clock. We can use this PTP device
> to sync the PTM time with CLOCK_REALTIME or other PTP PHC
> devices using phc2sys.
>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> ---

I can see that the same device id (PCI_DEVID_OCTEONTX2_PTP) is used by a
ethernet driver.

That brings me a question: why expose a different PTP chardev? In other
words, why can't you just implement .getcrosststamp() for that ethernet
device?


Cheers,
-- 
Vinicius


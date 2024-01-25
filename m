Return-Path: <linux-kernel+bounces-38863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F083C778
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26C41C243FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8774E17;
	Thu, 25 Jan 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQweOO0N"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024876908;
	Thu, 25 Jan 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198724; cv=none; b=VTUTSrLs8yK6iSKALu6YAa7IIx7OPCDjj2ekC5GpjFIKIYSzYyMD75HUelg7pimyM77uGzVAfz2F0PcBFn/C8ZPD3EfiSPHfU6TpWTAioXjOsMuN1vwh6sVF+NdAQfVoqrDMq6hTNWlwn0XqDymIp9KXh3ONZYyoGoVLYMw7oyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198724; c=relaxed/simple;
	bh=TXVIXDCTKF6U5/eP+UDVBy27zgOIVAGO0MqhmuCJGV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mw6ppBsqsLhSR/fztGZees2ZyOHXoBtajqyx/a3syoPSJuDjaTocx2vWrrLo0C3GQAVphs5Pl07dhgPhh06L1242GezBlydJT02bj6JPfK/YnCrWC0GLQItHAcVfCyiqcx4XG4rmO6uaCUinL5bQQcVnLEMzD5bvcS/hY3FBzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQweOO0N; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706198721; x=1737734721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TXVIXDCTKF6U5/eP+UDVBy27zgOIVAGO0MqhmuCJGV8=;
  b=BQweOO0NAp+3EgvVe7AZNepe+GYrxuHxcvCVU6EaEQoEOXnTOS2gwuz9
   GbIFPmIp684Z0WV1mK21KrBp2QRdV4uBnNnyXFadSpZ/qUEutkrugY47x
   wsYM4jC/VHYXrdoz/lRuSWw6jgBO+fRt7jnr2DX/tDpHXZlefYG66y23p
   iTmwWxTP14UmT7I7412VoJXxuQTcGIoGFxfNtmfYLY17itEJAzTXbKnoC
   1IX9bt2A1Llf7m9qBShbXCfoKAWeKnrKSc3eTfkiXh16NA25+ycrAr8Z6
   1Iyx9QCgnFkwJBIlqH/f1RQlrPcSpihxW4Sr6LGUPs/1aiVFpr8NO860T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="466485711"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466485711"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:05:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="905997017"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="905997017"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:05:20 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id F09CE11FB9B;
	Thu, 25 Jan 2024 18:05:17 +0200 (EET)
Date: Thu, 25 Jan 2024 16:05:17 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] media: i2c: imx335: Drop setting of 0x3a00 register
Message-ID: <ZbKGvfoAwQTl0CvO@kekkonen.localdomain>
References: <20240125154908.465191-1-umang.jain@ideasonboard.com>
 <20240125154908.465191-2-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125154908.465191-2-umang.jain@ideasonboard.com>

Hi Umang,

On Thu, Jan 25, 2024 at 09:19:05PM +0530, Umang Jain wrote:
> Register 0x3a00 is a reserved field as per the IMX335 datasheet,
> hence shouldn't be set by the driver.

How have you checked this has no effect on the device's operation?

It's not uncommon for sensor vendors to document some hush-hush registers
as "reserved".

-- 
Regards,

Sakari Ailus


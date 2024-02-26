Return-Path: <linux-kernel+bounces-80626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3159866A96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8365B2831D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F261BF20;
	Mon, 26 Feb 2024 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsjpGFC5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1FEEDA;
	Mon, 26 Feb 2024 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708931941; cv=none; b=NN+Nx5ETs9TgVKWlBJ4QfQ1Ze2/LraZiZPT/4uDQGvABqe/RhwFxGBES9P8BQUT1de5VneJXvW2s14hahGjua+WRcOAh7/0MQp8j+2NCfTzOPy9ZG9sQqk3S/NChNhzFx7gcLQ55L6iFZHLNDGktBFTVryI350OvhRRCWnEOgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708931941; c=relaxed/simple;
	bh=uDHrC4LsfOn1VnuBdjlGU4Vy2ZoIIkjiedIFz+qgMMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5K+Zvi5p2LznQryebo1nrEk4rJk5SnL4xFgbYBr9UcY4TTRr2rYh5gKhB8yyceERXFD4CPazQyfiDRKpbOmu5BrhSZc1wlqmJFW6aUuxYrnZatVAg2MaaTfY898jIFfL4ATV4ILYsBMhbZkKD+dLeffrJTLYOkX9M5PMPPS4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsjpGFC5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708931940; x=1740467940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uDHrC4LsfOn1VnuBdjlGU4Vy2ZoIIkjiedIFz+qgMMQ=;
  b=fsjpGFC5EkOHINZLPuvJh2JPnfov17EB7MiLKnE0Is27Q5jh5zdaCnGt
   wPBGsOPnTib93XwO1pBbSUfmfbGPJTG8DC/lX1XOtpyqWPTwhVg6+oMQm
   q5nNSMEdKp5PvItYRDLFAzSxZALSx4GhAz03OQohgmlgrz1Y+iALWCH8a
   duPjK/xcmAmw2MxbjTjpXI1OX1DV5ecT4BHhJ5L6gq/IcTxEli3WQfFK2
   VC0Gv0xjqMhztTLlaQyhz+PB22bt5+Up7l56H2rj+Uz68+OYg88pmNHxH
   zwVOjYNeZEwDXUSQ2FMSFPcg5+iCgGLhEqkFTrtSJKhkyHxXE2PlAOlrK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3363999"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3363999"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 23:18:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029376"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029376"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2024 23:18:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 03E674FD; Mon, 26 Feb 2024 09:18:55 +0200 (EET)
Date: Mon, 26 Feb 2024 09:18:55 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] thunderbolt: constify the struct device_type usage
Message-ID: <20240226071855.GY8454@black.fi.intel.com>
References: <20240219-device_cleanup-thunderbolt-v1-1-7890787f1ec5@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240219-device_cleanup-thunderbolt-v1-1-7890787f1ec5@marliere.net>

On Mon, Feb 19, 2024 at 09:45:50AM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> tb_domain_type, tb_retimer_type, tb_switch_type, usb4_port_device_type,
> tb_service_type and tb_xdomain_type variables to be constant structures as
> well, placing it into read-only memory which can not be modified at
> runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied to thunderbolt.git/next, thanks!


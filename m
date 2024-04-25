Return-Path: <linux-kernel+bounces-158345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7265E8B1EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A373A1C225F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AED85646;
	Thu, 25 Apr 2024 10:01:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98684E0D;
	Thu, 25 Apr 2024 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039282; cv=none; b=ZH3yhOmm4oxN7hwkiIck9tWTPF0pc/2wFR1EtYs7T2p562rpiZSP38DDO0H8zwcrtK8fCbuI6q9wLkMAvQr6V2ja4m0FqiQGwZoZiZW87J3svzfLUoiMohqMqO8UaZ8m0E3axDLu1OzB1tDccr4A7y36w08pNEJdnSED8ovA8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039282; c=relaxed/simple;
	bh=ADHJqszQ9Txm7S8seePFYWigxzHqi720FOMldE5VrLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qunoqBGeUhzvxdlZYr5Aj4aDRcTi9pjY4dXe7Fzf1RX9+NobWzF4pT3CNePjpHtcTzUAyMs2OQjZaJ3Zlzv4GJV0+0BlwcOHSg0Bsl1oxOHPEPIpQM3IDDCyR9AHddNUJef6nmPJiuNKF9vvpPjmdADRwvW+ZpGvlJSqh+iHtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: AwZPqcaHScCjlqrH87V/Og==
X-CSE-MsgGUID: Cf/IN/6kQ7Gmbl3vjOv7dw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="32205332"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="32205332"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 03:01:20 -0700
X-CSE-ConnectionGUID: vluF/VF4QJWns9PuSQw9+w==
X-CSE-MsgGUID: vQ4YuJjmSGGXK3+CRl6LhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29647088"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 03:01:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rzvui-00000000xMg-005v;
	Thu, 25 Apr 2024 13:01:12 +0300
Date: Thu, 25 Apr 2024 13:01:11 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
	robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Konstantin Pugin <ria.freelander@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v8 0/3] add support for EXAR XR20M1172 UART
Message-ID: <Ziop56dmSsX4NJds@smile.fi.intel.com>
References: <20240424191908.32565-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424191908.32565-1-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 24, 2024 at 10:18:51PM +0300, Konstantin Pugin wrote:
> EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> it has additional register which can change UART multiplier
> to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
> flag to guard access to its specific DLD register. It seems than
> other EXAR SPI UART modules also have this register, but I tested
> only XR20M1172.
> Yes, in datasheet this register is called "DLD - Divisor Fractional"
> or "DLD - Divisor Fractional Register", calling depends on datasheet
> version.

A side note about email. It seems you have To: email header empty which may
increase chances to get these messages into spam. Again, I recommend to look
at the implementation of my script [1] which I use on daily-basis and re-use
it or taking an ideas how to send patches to the Linux kernel mailing lists.
Alternatively you may study `b4` tool, it also has something like that in
recent versions.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko




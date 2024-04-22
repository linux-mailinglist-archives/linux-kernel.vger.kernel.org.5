Return-Path: <linux-kernel+bounces-153373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63FB8ACD51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4535B1F21223
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52A14A4C6;
	Mon, 22 Apr 2024 12:50:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FD149C6C;
	Mon, 22 Apr 2024 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790242; cv=none; b=jQbdd1bjXBfMwGVZBWhVGSgWAxXS9ezjP5aw+XOAoxmWGfwgWYX4M1JCwI6F5M2iZrubbjOswjXvLGVNHFl54nzwKfQ77FHEvg3iVYGf/yuqEthk6HUWRpXqraO/OSo1mQoRDmYj1cKBbQrPEwMcwNYbttKZyx37gxT5sb2GR68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790242; c=relaxed/simple;
	bh=qSWR9D2pGiWFZWTBqoJhjCRX7YaTWRZIJb8Zb5i2Iu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5JQd2MVgZdzHGDH1DqXz/AUGJho4nIX7MiqtCd9lnUXXrkfo6Um5aYfDief1jWyFSSIe5xJbQU/+9ztfS2T/XDraBsLwcg0X16ThAQT7KJVd5IyMNMkqAK87sg8dMN7w3KDIqElpYpWNObwSWTnV5r0IgcYsn/TBs449izMeSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: JOM8JGhrT4y4N5nWBvy1yg==
X-CSE-MsgGUID: 2x35e12PRyCVUrBWUpgbWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20725354"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="20725354"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:50:40 -0700
X-CSE-ConnectionGUID: kHih8TYcRYe8HlpPjqKK3g==
X-CSE-MsgGUID: CYlww7x+RvmerIjmJl1q/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="23878211"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:50:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1ryt7v-000000003fb-2dNY;
	Mon, 22 Apr 2024 15:50:31 +0300
Date: Mon, 22 Apr 2024 15:50:31 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
	robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 0/3]  add support for EXAR XR20M1172 UART
Message-ID: <ZiZdF7FWsQcTpxYy@smile.fi.intel.com>
References: <20240422123801.2695129-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422123801.2695129-1-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 22, 2024 at 03:37:54PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> it has additional register which can change UART multiplier
> to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
> flag to guard access to its specific DLD register. It seems than
> other EXAR SPI UART modules also have this register, but I tested
> only XR20M1172.
> Yes, in datasheet this register is called "DLD - Divisor Fractional"
> or "DLD - Divisor Fractional Register", calling depends on datasheet
> version.
> 
> I am sorry about too many submissions and top post reply. About second -
> I do not know how to reply properly to this ML from GMail phone app.

Isn't it as simple as moving cursor right after the quoted line and replying
there? It might require to remove --- cutter at the top manually.

> About first - I just get very good feedback from Andy Shevchenko, and want to
> fix his review picks ASAP.

-- 
With Best Regards,
Andy Shevchenko




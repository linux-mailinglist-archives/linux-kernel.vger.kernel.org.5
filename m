Return-Path: <linux-kernel+bounces-61534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F0F851359
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D41A1C20F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB66939FCC;
	Mon, 12 Feb 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr7tY7zf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F53A1B5;
	Mon, 12 Feb 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740137; cv=none; b=sgmy+Iw4MWqF9uwN+gyQqij1iFqZ9TIoJWf1NixeNSmenb/N3FzBTQD3qMDu/jezSarTkSUzMO0zhUrR5IAAfjq5p18faFl8Mn8KXB9x/UEQGMnUcPO1+LX+qB4qQBukaDyp+rn82QVAWO4Bsv/N84s41n81Kjp5nY7DnzphO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740137; c=relaxed/simple;
	bh=PZkQPDyP1m/c/g1ZAZtDwyEcA3ZFwJ232NOy9QvkH/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rut0Pilm8A9Llabc08ks+gvMPc/Ml1Cbcy9LR1Dg18hIp/dbdeMpzhHZpfynVQQj6yulcDrlzhAaptdH+MNSGQ/oIKgUlLzpfR2yFawCoM6V0A5tqjFx3GddhYiOdRzOTlGUSdTlcOMT8Jrs72x62U956AM+79m8piR40hk9maI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mr7tY7zf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707740135; x=1739276135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PZkQPDyP1m/c/g1ZAZtDwyEcA3ZFwJ232NOy9QvkH/U=;
  b=mr7tY7zfi2UY3xUHdUT6IZcKsenI32Eed+WE48VfWO8fpXBxrQZAvnR0
   3J67RZOQbusV1L52BgQ/adSmdG7FY+TOA8/tlSvFuy3ltyBhsVCoD7arZ
   FbcctEPHJrj8HP3VjKjXBwgJgp0tJGcvpNhFMjQv0qSYbYp/eEV2px6fL
   fPW5nrd4w8x8x8a9mmO5ym+LagthlDPlV4WB5DJU/9Yb9bxfwTgTKZ5tq
   A7RHoJH60d6wQFlKE5s+0MO8SNcdOvlpPz/TbTqG2ACcpMmkpSTOcZQvD
   VLIr7IGG0oP4n0CqbJgXMXUxdq+SJ3hyMT1YKOGOfCk6PyYI7jQqakcBD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1590963"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1590963"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:15:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911465640"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911465640"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:15:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZVDE-00000003tCF-2Die;
	Mon, 12 Feb 2024 14:15:04 +0200
Date: Mon, 12 Feb 2024 14:15:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: auxdisplay: hit,hd44780: use defines
 for GPIO flags
Message-ID: <ZcoLyAI-RuaN5X6H@smile.fi.intel.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <20240212083426.26757-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212083426.26757-3-krzysztof.kozlowski@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 09:34:26AM +0100, Krzysztof Kozlowski wrote:
> Improve example DTS readability by using known defines for GPIO flags.

Yes, it's better this way.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko




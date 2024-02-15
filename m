Return-Path: <linux-kernel+bounces-66864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1878562C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A62128BB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C0D12BF18;
	Thu, 15 Feb 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbelOGZf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DC12BEA7;
	Thu, 15 Feb 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999125; cv=none; b=Z2COa1PE32Xa6vLASSXj1E9pX4fRdCXuljC1+n+YiC4mbyhkTLHHwmnfB14NhPaJ0d2vlLvoPzef1ugiHaCQVNGUmGEOCdYZ+sz3sSDzJV+pX+O22woK2F7bMQe7J6enOlMRgguDNQQuLwlqOzsZrmJJP5wM0oF8hPYZcy0zJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999125; c=relaxed/simple;
	bh=og8a3B8c6vwOlUxd196/k/TpM8xly3rBnfUQFM41amw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e29fqi34uj8SBj6zhgW2YpxNqzWYuWkQiZswg8HlthHgOzcZ7pxBEozmd2citgKZefJffsysQ0oncBVhkyZgoEu3DQ9H1udx26Nk1dcN9/En51v9WSj9Sl2e5cPvqgksNWpsmxw/J1MoHB6sS8ulJ3bq9FbpwNu4JlhQfY2mvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbelOGZf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707999124; x=1739535124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=og8a3B8c6vwOlUxd196/k/TpM8xly3rBnfUQFM41amw=;
  b=FbelOGZf4tcLZyEw6A2o+CkhDYuJuRjuUML83fwYMdh7BIdwNSFAZKRP
   upg/OX1QBUZZYl+Zpt4udjBVQa6sHiRhz0cFX7dUWEbrgzmGhH+MKEjTD
   bLXtkG1N5rxLGOZiF+lhliZjGsX7tzitgW1jIOUseWoc/SJWHSxPe1+/m
   b6XVz6Pg82IKntbcGIp6q+zoIKCr2VA6DwPslHPbXl4i9IHUmpss1NHSc
   fj2NuFXDkfXMILn7kUxO++zlFkVMwT5mlbVLoaxx4vYbMhIelj59WwGc9
   uWpe28tnfkcPSGVIDnbFpgUnLcqpURj+Piyo2ycmlFKR7sWJunCa9YS3c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5049102"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5049102"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:11:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912155931"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912155931"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:11:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raaai-00000004meN-3fLD;
	Thu, 15 Feb 2024 14:11:48 +0200
Date: Thu, 15 Feb 2024 14:11:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 08/15] auxdisplay: linedisp: Provide struct
 linedisp_ops for future extension
Message-ID: <Zc3_hDeojqo_KR6q@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-9-andriy.shevchenko@linux.intel.com>
 <CAMuHMdXWu4JYT5wCX8sbwdM8gt571JakL1UHi2SGd5wKB41pxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXWu4JYT5wCX8sbwdM8gt571JakL1UHi2SGd5wKB41pxQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 11:13:31AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 12, 2024 at 6:04 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

..

> > +       err = linedisp_register(&seg->linedisp, dev, 4, seg->curr, &ht16k33_linedisp_ops);
> 
> Please wrap this long line (everywhere).
> All lines in these drivers fit in 80-columns before.

Done.

-- 
With Best Regards,
Andy Shevchenko




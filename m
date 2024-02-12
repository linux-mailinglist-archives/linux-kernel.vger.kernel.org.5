Return-Path: <linux-kernel+bounces-61725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B386851601
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7C1B2A0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3FD3B194;
	Mon, 12 Feb 2024 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOo6nEDx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6573A28B;
	Mon, 12 Feb 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745440; cv=none; b=ky5ytH4dJcyWbh54hJ48sy3q8fe0V0OgXLgfNvxLfAK4FJ2MbKXugAlsYfs2exCLMp2T7w5JUgsLdbne/CbGvaEw7QCiuSYjlXJeKBwQSwH5g3xydFgZWozNxBr0eYTV02ZYGzkPz9QZe/Evzh1CwNRy957FVEaIuq9BFAWxz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745440; c=relaxed/simple;
	bh=ReFfb4Ca/K0nRT7HGDlG5FJYa8HVxtgFYOvGETOwcfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+i1wKBniUI/TlOAVshoVdCHDP6V+w5tb2VKwPwkl0x0TOlef1tGs3GbwNDasTOX5FtUGOLJJzTvd73VIKy8NjN4SKZ0ne0hK5hBP+5+a4C/j1OBvU8xsxJk22nxLNKxouGmtpFUIAfEu/QkQ8gBA5NgRCytPQCRTXVrDCawi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOo6nEDx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707745438; x=1739281438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ReFfb4Ca/K0nRT7HGDlG5FJYa8HVxtgFYOvGETOwcfE=;
  b=AOo6nEDxe6ucOz1S9QCPoA74tvFVf+hwQ7J8Ti4+NbymUSeqsOCi4WNX
   7FH/4kTGxBFc1XARW/q/vFHO56RU6mPsIIQOwBkGKnob0hZIeev2K8NXD
   VOPxeoIf7GR5ayPAy5B3F41/BBHIJz7EFmFi0WUDMouTfxrtySUtJCeJk
   sGq8LZgzhOZstYFW4aBg6sh2eXRzqTVuxBfHgWlBMCD2/tYSrSLfkGMJF
   niCsAUIQm+txwa/d4qmMNrYPxq7ptR6oq9zQCZPRAOVX39bZxgYnUb2n8
   7zHb8R8Cktkij5SWCd38UpQhrRGEGbbyJ+XQ6EqE3FRR80OYEbevgYf1+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5533892"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5533892"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911485132"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911485132"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:43:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWb9-00000003uR5-2c5X;
	Mon, 12 Feb 2024 15:43:51 +0200
Date: Mon, 12 Feb 2024 15:43:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ralf Schlatterbeck <rsc@runtux.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit, hd44780: drop
 redundant GPIO node
Message-ID: <Zcogl6tqbMdQldKA@smile.fi.intel.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
 <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org>
 <20240212115837.efz73yxinkysdmgh@runtux.com>
 <e2a5b005-7916-4296-b072-c24efd4b3357@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a5b005-7916-4296-b072-c24efd4b3357@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 02:38:27PM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2024 12:58, Ralf Schlatterbeck wrote:

..

> Anyway, binding examples should not be collection of unrelated
> solutions, because then we should accept for each device schema several
> other variations and combinations.

Is this documented?

In any case, you would need to amend your series one way or another.

-- 
With Best Regards,
Andy Shevchenko




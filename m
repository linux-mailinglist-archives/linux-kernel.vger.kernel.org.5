Return-Path: <linux-kernel+bounces-61533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722D7851357
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0FC2820F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0843A1B0;
	Mon, 12 Feb 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amQDgSKJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07E39FCC;
	Mon, 12 Feb 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740134; cv=none; b=qQwsmxX0ulMElnKFH4rmfrCTFDViUM6xnTFDRolNocggZSKW4c1n+PKJJHZzQiqVaeZr0w/l/ES5OKRPlblH7rvFJcUWpgcqUsHP/weO4rodHeqkSHu+ojjcy/IXywihp0/1IdUjTqzQK/h3bPhNe/vC4MRHrTsgz1NeHwAZAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740134; c=relaxed/simple;
	bh=+MFgKZeBXzB8Bv3Zt1/oGkVXLuBqcn39R8xEGLTb04Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fckojeTYR8AQBklZUfyIo8e5puU2TqyaIqvxjT74zGsOTv2U2b0wCYDrqm0LnJnik5mbZiTR7PLl5ptApYb3+Z4JHbhJZ/tfLGvCUCIRlInE/zSYEWGqghalgpWv7LAR0naT4cNcghPAoyksNVpy1ZkfNQW0BLkmDafsqjLV1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amQDgSKJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707740133; x=1739276133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+MFgKZeBXzB8Bv3Zt1/oGkVXLuBqcn39R8xEGLTb04Y=;
  b=amQDgSKJiy90FESpuGoxNm89ki+mjsTJHEnOFk2z00aiKJflPflceCgG
   eTRpgyCXHD+kVHPY/z/cNaQ9raSIdHLscMlsjs5nNgqYFKDK/PLLsXqeM
   50mYcX5+XlYZMt5YZgb0PhK3/U2lXAKhLEX+YCU6PK8Wt46Aa/Y98UGQv
   yd5Yfreq6aG4Cjwh1GHbqMHU0Pq2bDhizpxkhicosVl/RBK7lRbnyEFBc
   qoLSraCwJXJexb8M6kX2y5JWoFCTJw7TKX/r7+xiwXBoYqw1YN+koQyVS
   BP917z9C3O6WzXwJZyATGtCuBblOxcQK81qUvV4U5p1vqBMk82E1VBfr5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1590904"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1590904"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:14:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911465490"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911465490"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:14:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZVCk-00000003tBo-2qwr;
	Mon, 12 Feb 2024 14:14:34 +0200
Date: Mon, 12 Feb 2024 14:14:34 +0200
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
Subject: Re: [PATCH 2/3] dt-bindings: auxdisplay: adjust example indentation
 and use generic node names
Message-ID: <ZcoLqjBnif7ZZ7-j@smile.fi.intel.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <20240212083426.26757-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212083426.26757-2-krzysztof.kozlowski@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 09:34:25AM +0100, Krzysztof Kozlowski wrote:
> The example DTS should be indented with two or four (preferred) spaces,
> as mentioned in Writing Schema document.  While re-indenting, change the
> node names to somehow generic names, as expected by Devicetree
> specification.

Thank you, it's helpful!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko




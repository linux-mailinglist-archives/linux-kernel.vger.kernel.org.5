Return-Path: <linux-kernel+bounces-61718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFB08515A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89709288B35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331DB3BB3D;
	Mon, 12 Feb 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bj+VF1Nv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAF25740;
	Mon, 12 Feb 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745165; cv=none; b=BOZpyRpZ0gWSHXU3oj8S++Oo6Q3rrrMfli60ZtTIqODctN/5TdieqIYLVLW+YFaeFTZH1k5snRhCzEzkQPf+gBsBnbhWWyYfCekfCDTtusaY7vxMi+g0XyO1Tsy3haoiouBhzZNx1R8khZxkoPlRdECtGM4CO0a+iSZcvu2kP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745165; c=relaxed/simple;
	bh=948+gbIDD++X6iDS6m8bcwbspLrj/CTXPo3HRGxyMDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5tIiBbs747sr/zu9yacSwXwzKbBnGeZzYTkx39Bh1A3FkkdMatPJKQIRnfCxLewbjvfAh0XbdcSE+1PWns3TivKxh4/yh4UuLyWF2m+dqbhzDBBweqEXg8k20ecn+jYiCQ/EvoLzrnnGsKsrmLuCBaVaN8mckn2EkeY/L/aigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bj+VF1Nv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707745164; x=1739281164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=948+gbIDD++X6iDS6m8bcwbspLrj/CTXPo3HRGxyMDo=;
  b=Bj+VF1Nv7vXtr4JxZibSkNUPwpREwnrJRXpWhRI48r3upu52SjsDkM/o
   iAfT3DlY8pApjWGBF6G8g4Nqe8IW+V5BTUbSrPbsQxt+5SllWg76qdQ9g
   EObOp0P3K1+1L6aZ1JQNPg8fvA8WdXRsfjVJwg+8YwLDGMT0nYvhkM3Yl
   +pbla1ND4A31tDKfsR5bNju3ewLdxsa2H4liZSVrlImiHBpfAd3g2yEyK
   yFg49YbgLqU8tO/I3AClnvQMrogu/SOljnvHZ9mejn8wgdGgRwlE4o9C8
   qqMtYP0FTWI11FbNMuyNrME0kTy26393UovTXfQK1J31Z7xN8nM6R0BaE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="19226953"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19226953"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:39:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911484287"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911484287"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:39:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWWj-00000003uNE-2OdR;
	Mon, 12 Feb 2024 15:39:17 +0200
Date: Mon, 12 Feb 2024 15:39:17 +0200
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
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit,hd44780: drop redundant
 GPIO node
Message-ID: <ZcofhWb8stiddmru@smile.fi.intel.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 09:34:24AM +0100, Krzysztof Kozlowski wrote:
> Examples of other nodes, like GPIO controller, are redundant and not
> really needed in device bindings.

..

> -    i2c {
> -            #address-cells = <1>;
> -            #size-cells = <0>;
>  
> -            pcf8574: pcf8574@27 {
> -                    compatible = "nxp,pcf8574";
> -                    reg = <0x27>;
> -                    gpio-controller;
> -                    #gpio-cells = <2>;
> -            };
> -    };

In patch 3 you updated the lines that have lost their sense due to this one.
And I agree with others, please leave this example in place.

-- 
With Best Regards,
Andy Shevchenko




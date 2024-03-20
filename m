Return-Path: <linux-kernel+bounces-108776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67642880FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227842852A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DBA3FB39;
	Wed, 20 Mar 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeKZ41OI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64413FB2E;
	Wed, 20 Mar 2024 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930463; cv=none; b=Fv8mYvXFygM3+x0VINS2LcxIDjQ5GWcphmqVI004NUKn04PBc3/6Wy3xomNsdZt190Ib9WVe5e94bAKPBO1uXHK54eZ9crH71/dtOxvFxr+BvfsIixsMkhSkDWUfGmU1CQ6enQnWTOeaLa3CbJGYSmlLUdh4VPUdOv5GQ/6c5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930463; c=relaxed/simple;
	bh=xhXeyDGOb3pQKxcGo7mj/IRBOHnIFDLmPNQP6tybMTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkLF41Tt0/9+AZ66pxbgKSs7leTU1+oBgBUSTnRzJac5W/74ctrjKf13js4ISDcT+4UJSHE7CYTx6hw0Q5KFWcnzeJ0ZfYaaELLhoJLq1Lx9ujynpfPbt3IQpi892LFDhotXxz6llu3BrkPKR3ftc9QZq9nzFu7GUzVkcvXZZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YeKZ41OI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710930461; x=1742466461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhXeyDGOb3pQKxcGo7mj/IRBOHnIFDLmPNQP6tybMTI=;
  b=YeKZ41OIzTaRKQwyy82xVGHjKE85+XePXJi/3y8RY1FOwq00sOYOkvco
   9AmJvO+JH8s9MwNakTdBAsBK6MIYMpWvtbDKAU4afNXo2qlhctoZRsfug
   EPUjpP//BxG/lonthac1aCXUIUQjMgpDx8GQxuqPDfOhBGcd7B5w5hcZz
   DZRU2uDbRkHTmDjIInWiDMWnAOZuoP3F7+e64LE/vm6sQ1gNVcciT5CB3
   h98KKh3ZuimcSLXxoyXsO63u4Q1YatS2Vm0SQXM0dJTR9bnRST8qcfA3x
   7R1vtrgQdKhnY1MITVHIkgJq5hYPoLDtAWW+7UFySyX3R1rPRg8TdotyA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23303725"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="23303725"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914662024"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="914662024"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:27:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmtAX-0000000EXXG-3Kem;
	Wed, 20 Mar 2024 12:27:37 +0200
Date: Wed, 20 Mar 2024 12:27:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v1 1/1] nfc: st95hf: Switch to using gpiod API
Message-ID: <Zfq6GYnPAn000my0@smile.fi.intel.com>
References: <20240318203923.183943-1-andriy.shevchenko@linux.intel.com>
 <ZfloHvWaTOQErWfU@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfloHvWaTOQErWfU@nanopsycho>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 19, 2024 at 11:25:34AM +0100, Jiri Pirko wrote:
> Mon, Mar 18, 2024 at 09:39:23PM CET, andriy.shevchenko@linux.intel.com wrote:
> >This updates the driver to gpiod API, and removes yet another use of
> >of_get_named_gpio().
> >
> net-next is closed, send again next week.

Same Q: Why to resend? Can't you utilise lore.kernel.org?

-- 
With Best Regards,
Andy Shevchenko




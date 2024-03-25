Return-Path: <linux-kernel+bounces-117366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F06488B492
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E17C07808
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F93139D05;
	Mon, 25 Mar 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlDGJay+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA672131188
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380498; cv=none; b=AOLuvRqz/obs4xwfLPxUtvuzFAnsh6LK5keKsA9GkIE1yAyjnGaP6o3mcHON4Md1Vx9SxO8XVEvpnUi17evb+VMdoinSIvxAFCG08VpNEIo/+DODNeSD4Y58oTqYialPOVMXI4SZ7Cw8aliJy85JZb8WVQFxp3QSW6F/pLBs3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380498; c=relaxed/simple;
	bh=hFH5HS1gKtBfdacUKeLYr29lMbYa1oGBsoDCuw1Wvjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdDoIftfEh16YLPUO/0JGr3Kf22eN8wi2ZOQ9HalXEuQfISVtJE3NLVeHcJS1upzMepmvlTLofchLS2CGX/nN18AT/UAyiEP+rjfOpTeLydMluisiEigPMnUQY5YCos6XgG+o1gd0X3JROTn4C9V75eEwJwjnZKurbU4Uzeq5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlDGJay+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711380497; x=1742916497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hFH5HS1gKtBfdacUKeLYr29lMbYa1oGBsoDCuw1Wvjk=;
  b=ZlDGJay+8QbTXPIgbLvcVBLU1c8XSKq4xkwdYj4fV7X02BZ68LhFlPQQ
   Apn3UOcpQOG0fQT46qWtxpJbq6DG3PwlyVF2F2zGo6Wsm9B66+x37i8fi
   R8f41sLePpIho/1Ffp1QzoGESf3k1RmdslsABincHvyFtIP2OpizyUfKj
   Vry1wojmbI/WxE2CdDHUYHCrQyRb3DSchaNIvDzVX3g8jEPBUdNAO8BnO
   1dCGtTHZX0D+DoKxmewh0k4+ORtkmHo7Wj7+Oxyhby5tXsDYOLbBrYoDa
   1jeMyLIqNkjYJxIEA46uy8+OPAVCbo9zFmap4o/po+4HIWqm1mjKRHkXV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6250710"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6250710"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:28:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914846583"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914846583"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:28:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1romFA-0000000G1ad-1ChE;
	Mon, 25 Mar 2024 17:28:12 +0200
Date: Mon, 25 Mar 2024 17:28:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: core: Align comment with an action in
 mtd_otp_nvmem_add()
Message-ID: <ZgGYDMzAWEaPkAXh@smile.fi.intel.com>
References: <20240325151150.3368658-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325151150.3368658-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 05:11:50PM +0200, Andy Shevchenko wrote:
> The comment is related to the non-error case, make it more clear
> by inverting the condition. It also makes code neater at the end.

Just realized that even semantically it's better as it's done here
since we have an error path from which we exceptionally return successes
(in some cases). Tell me if I need to add this to the commit message.

-- 
With Best Regards,
Andy Shevchenko




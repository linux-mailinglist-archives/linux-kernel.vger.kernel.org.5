Return-Path: <linux-kernel+bounces-74256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD77A85D1B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE14F1C24600
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B5E3B199;
	Wed, 21 Feb 2024 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRGSkJ5C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91A3A8E3;
	Wed, 21 Feb 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501671; cv=none; b=SkQ7Dcd8gmircxffAGE0w1u7eYnzUSNTIz32VnYr0CH+nVvHVbW3rXpOJU8j9Jset80rh4Sr36d0Gk1aqXl0es4qsMsR4uGwPZTj0db19mXuqOgvZiNF9x8zH4r+hzv/SEhw3acyVeCrZ7ysmnt8LcxluC9smh7v+nejS5VO1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501671; c=relaxed/simple;
	bh=tAM+xAvzOrgvzk53bwi9cjdiV077BhZDvjgFfZc2M6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCI481gSBA7SRL02rTxkrPAud7CyfYYxIaltix/bXdM1+4ESS8Iwr9JwNONJKI9cXgJX8kxEL6zdIOr0IBuBf4JvmG6M6/dJo9dr8ZKByycWRRqi6aNm+VNnr0T7B9YWrNct7VMZ8rzK7OL+6iirnXahv0wQ6slR0ojwCRN+IFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRGSkJ5C; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708501670; x=1740037670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tAM+xAvzOrgvzk53bwi9cjdiV077BhZDvjgFfZc2M6A=;
  b=dRGSkJ5CHDY533qSH095/sG9JpSiwxw1uytHOZaXmLlMm1oycrpQwDx7
   aN/3Xo+K2tT1kQaC0CA0ku4X0hXcNdbsQPE2g49+mkcZs24gW1wlSUewK
   UtpvDbo2ykPnpy5Ky0D+y35Y4P5M8f7rZWDzZ8L0HMfGViso2bRJf3VVs
   vc9iY4693g/+AdUirNje4ao8GI5pzcinM9crBzPTRfkikssN6eQMbsnxl
   atxFGablXINoxTVQ77ZLDQ4q2/iksW1tn9EXsmo/ycGGAz5Y29AKZeJK+
   7qVZWU2nxyZtWGwzzRZEDyjWbxClXeARY18bqUlmyk87UcxZkzfCbFrDz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2785967"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2785967"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:47:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913251921"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="913251921"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:47:47 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 226C111F855;
	Wed, 21 Feb 2024 09:47:45 +0200 (EET)
Date: Wed, 21 Feb 2024 07:47:45 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1 1/1] driver core: Move fw_devlink stuff to where it
 belongs
Message-ID: <ZdWqodFSRBZ1NAco@kekkonen.localdomain>
References: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>

On Tue, Feb 20, 2024 at 06:10:02PM +0200, Andy Shevchenko wrote:
> A few APIs that belong specifically to the fw_devlink APIs
> - are exposed to others without need
> - prevents device property code to be cleaned up in the future
> 
> Resolve this mess by moving fw_devlink code to where it belongs
> and hide from others.
> 
> Fixes: b5d3e2fbcb10 ("device property: Add fwnode_is_ancestor_of() and fwnode_get_next_parent_dev()")
> Fixes: 372a67c0c5ef ("driver core: Add fwnode_to_dev() to look up device from fwnode")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus


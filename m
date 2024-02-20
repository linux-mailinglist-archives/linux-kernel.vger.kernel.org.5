Return-Path: <linux-kernel+bounces-73469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F44285C300
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0201B227B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E0877648;
	Tue, 20 Feb 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCTc9Smc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B076C89;
	Tue, 20 Feb 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451528; cv=none; b=T2rDZu5PTVwKMLhieZtwYwLZc8Z6NU6DgdVKszVCNsigw36iMpO0gWbFK5vj2enapDVxDLBClg8+T0QHhC0Y24C+EPp4TxxgE/VO/Nesr9upxuiPlvBJpRFE+U46CVLP7t2Tnm4VKEjZ/Dh4xn+ggMtCK/2AYl+hVPqRosFkF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451528; c=relaxed/simple;
	bh=07NZaNS/lvIIT2XfHfsULw5hQHjc10frrDfze3nLP4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2twMQhJ0kENDUhM1477izCh6eFwzvZV8zLTvQWr2FDJs1qCMAk1rHOWpCw7KM4qHHUsitAY5LCwBNludoopyAOVxUP4sbbXsMteFo7Zc0rbndrlVgOD1GSpDAZCG9POFLyrmjySrDnUNpQ7nha+BCFET9zeOSp6nwmj5JJkoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCTc9Smc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708451527; x=1739987527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=07NZaNS/lvIIT2XfHfsULw5hQHjc10frrDfze3nLP4s=;
  b=CCTc9SmcsxkRtKaGc7P1or05m/sztEnm33In1RsRR7UdHx3MDGzUsP72
   p0sc7PxmAckpmyVVeLT3DRNbtDWMBcpk7+9ZRF+Ul7Xi8UO+My8VeNexR
   Ap7MLCtVE4yTo8HJi/NMMRZMluofa5AX0sCGS/rU7/BU4hi85FYecobKp
   SlBs6SLe1kErd6HLjfCMDbe3gp+d/b9fst51Niv2Um2uKpEqbtsOKyzAV
   ytSb0vWV+kJEMUZq0zITtoYtNyGqZl6plT4EqnjqfCRM7f2J0iQm7Eie4
   HWvBQVFsGTJo7O4ipfOfcQpOjEtUC6qneYz6uVcKWoAVqqlnpRctLn2KO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="3036033"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="3036033"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 09:52:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913116549"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="913116549"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 09:52:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcUHg-000000069Ha-2GtT;
	Tue, 20 Feb 2024 19:52:00 +0200
Date: Tue, 20 Feb 2024 19:52:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1 1/1] driver core:  Drop unneeded 'externt' keyword in
 fwnode.h
Message-ID: <ZdTmwCSZrHhS5K1H@smile.fi.intel.com>
References: <20240220154532.2684428-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220154532.2684428-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 05:45:32PM +0200, Andy Shevchenko wrote:
> We do not use 'extern' keywork with functions. Remove the last one
> mistakenly added to fwnode.h.

Oops, there are two typos in the Subject.
I'm going to send a v2 with them fixed.

-- 
With Best Regards,
Andy Shevchenko




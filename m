Return-Path: <linux-kernel+bounces-80674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C4A866B15
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825741F21E22
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52E01C6A7;
	Mon, 26 Feb 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPAFIx/c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBF1B94E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932776; cv=none; b=oaAye5XzOPf8WcPOn/eschlnXBlEwE/Q7NTGXZPavubUE9UAuid+kP+K+bOicUvvlniHz2nOCUvCZMu5Noch90co/dgjco11QgBc1Xh2fnyeprqt5BP9wap+HCrII8Fad77N7MBDE6pOigeYhT+gGdgqQDmutTIJOnCzpn2Sgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932776; c=relaxed/simple;
	bh=HnEzKqFMvZDJt1p2kVPSErow/iTlRTSedXYwGSXap2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biwDXrGZ/8hQziHf37ls9KS3+dXj8AJg2RQBc8oBNPqJTwS34Si4CY1J5day1hKj1bFFotidu8oFUHpqiBGCv5rqOVJV1V/ZnZ+E9M8f+AAA3whYnvOQHOnvqj5Hn2A3yeGMBP/+GI0mMiE10Zg59jeh8lg4yIuL2WqOgNaVrFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPAFIx/c; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708932774; x=1740468774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HnEzKqFMvZDJt1p2kVPSErow/iTlRTSedXYwGSXap2g=;
  b=lPAFIx/cKLmrWU82d+YMI9hU9sH+2LC1E5AFODm13XLRbWchJ9Y1J+Ik
   9stg0hU1CunX5EFZfsKqkLLe7q8UIh2l8aXudqWLnhOg/BpZtW79YHiK2
   oRuhBQT6TJYlH81qs00RMkWy0E1TgBPavg2H+fodWWshtn+/ZKVNaQPqj
   UrH7Nv0Ub6jwHBDvAKl0HP5nDoXK2v+n7ObG5UtWOnTO5TuGrGAeOwgLa
   RsYlQKuxOS8PlUpVTWhXP1JP19gELBsOevg78ffvYrviSV+rXF20jeRn3
   TsxACfjGc5ENeuziGLpCTDb+38hzkcgDwukCw0ZCXffqep5vhw6twxUvO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3365770"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3365770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 23:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029404"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029404"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 25 Feb 2024 23:32:51 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 09:32:50 +0200
Date: Mon, 26 Feb 2024 09:32:50 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Drop myself as maintainer of TYPEC port
 controller drivers
Message-ID: <Zdw+oku+pBOOtqnu@kuha.fi.intel.com>
References: <20240215202039.1982539-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215202039.1982539-1-linux@roeck-us.net>

Hi Guenter,

On Thu, Feb 15, 2024 at 12:20:39PM -0800, Guenter Roeck wrote:
> I am no longer involved in Type-C development and not really current on its
> status and progress. Recently I have been doing more damage than good.
> It is time to go.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73d898383e51..ae3283f9eceb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22864,9 +22864,8 @@ S:	Maintained
>  F:	drivers/usb/typec/mux/pi3usb30532.c
>  
>  USB TYPEC PORT CONTROLLER DRIVERS
> -M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-usb@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/usb/typec/tcpm/
>  
>  USB UHCI DRIVER
> -- 
> 2.39.2

I'm sorry to respond a bit late, but I wanted to also thank you for
all the help.

Br,

-- 
heikki


Return-Path: <linux-kernel+bounces-65170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F58548D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644041C21FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD31B5B2;
	Wed, 14 Feb 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDLBHJYL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202971AAD4;
	Wed, 14 Feb 2024 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911953; cv=none; b=LK1wsQ0unVmXvZXzLMPsR0+Q/LvPLGpkcUwLgIsMXBmBWU/kCcw6FiH4HBUOECKG2dRzfqQAIFpwy98NDYOBywocOrpRIpdPGtyUHyNge6lGTXdhMkTVlCkqjZXlrIpTAckqwakl1SLvDq+eCyZxzIztB3kCMKiczh2AYkCssEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911953; c=relaxed/simple;
	bh=w4uXVUfh72WhrIt47Fr/6saEOm4ZhJrZnrpH4HCXooE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYt6Wew03yh1am8qi03ZghWUIio6r3ma/LprXB2sGdrwxCZ1HZqUqK4OpAT1oX8z7LK449VmmV6M43BFnq0iE4WLJ5PK7dAATXHQUxOO1p6kwJq8UrCjVrFkuAGepYv8+ZofGrWE+A53XKO4dqFaEpGQJo2yepv4LWypqSiO5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDLBHJYL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707911952; x=1739447952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w4uXVUfh72WhrIt47Fr/6saEOm4ZhJrZnrpH4HCXooE=;
  b=oDLBHJYL6rvCiOmK8i/V+MMJPGrg/DTgDCGvutFG15ZUN5763M1iucar
   qB6Sut3B6Yt5XNOXGFo9bQz+cpqdBXS/+f5iFS/bXhzlCizfCXOvUG6DH
   s5RyMlX28BeSuB7Rg4NtcluGBCndpr4jXDC+8QsIfioXQs1XJqpi77mcL
   FUppmfHbiBFOY1QIJfEoe7Z40klnJWY6EWPr0IrpNdHr/nOLX0fHXbZi6
   kqxFBq9iehYWMcF0vP1qX5tmqOtq6kbXAuArgRr9aE1pDSBIUHHRTQMu+
   gmH2Yhdt6tG0MollkNyLs8NTzG3aDSP844iTAm8ZLEG698QYlHPHb2CjV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13045263"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="13045263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 03:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935616225"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="935616225"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Feb 2024 03:59:07 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 14 Feb 2024 13:59:06 +0200
Date: Wed, 14 Feb 2024 13:59:06 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Emilie Roberts <hadrosaur@google.com>
Cc: Prashant Malani <pmalani@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
	"Radjacoumar, Shyam Sundar" <ssradjacoumar@google.com>,
	Samuel Jacob <samjaco@google.com>,
	Uday Bhat <uday.m.bhat@intel.com>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Make sure the USB
 role switch has PLD
Message-ID: <ZcyrCosNDXxGZh9O@kuha.fi.intel.com>
References: <20240213130018.3029991-1-heikki.krogerus@linux.intel.com>
 <20240213130018.3029991-3-heikki.krogerus@linux.intel.com>
 <CACeCKadLKg89c8s68QD6VsqiKBMms6765O7mFFihqtET30pUyQ@mail.gmail.com>
 <ZcyUblecufzeso17@kuha.fi.intel.com>
 <CAAuZZi9h=d2_CM4tU4-H9wJfhLZbw99X2dGSddiCeDFDdb+kjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAuZZi9h=d2_CM4tU4-H9wJfhLZbw99X2dGSddiCeDFDdb+kjw@mail.gmail.com>

Hi Emilie,

On Wed, Feb 14, 2024 at 12:04:22PM +0100, Emilie Roberts wrote:
> My understanding is that this is related to the wiring spec and not
> ChromeOS specific. It seems possible that OEMs making non-ChromeOS devices
> may have this same issue. Or are we certain that only Chromebooks will ever
> see this?

Non-ChromeOS platforms do not have this issue.

The issue is with the ACPI tables - the USB role switch ACPI device
nodes don't have the _PLD object on these systems. Ideally this could
be fixed there by simply adding the _PLD to those ACPI device objects,
but I understood that that is not an option.

But maybe I misunderstood... Can the ACPI tables on these platforms
still be updated?

thanks,

-- 
heikki


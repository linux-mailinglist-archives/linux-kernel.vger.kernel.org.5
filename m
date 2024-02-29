Return-Path: <linux-kernel+bounces-87312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBA186D28B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4871C217AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371B134425;
	Thu, 29 Feb 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LeV32OQ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BD13441D;
	Thu, 29 Feb 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232380; cv=none; b=a703Rd4ZMJJswI2T77CiUxM02RLh3HyJCczAx3bbRFB/LEsTOm4UFjjnTlZ5nyDZpTpjfgOq9xFRWtHd4C4ybScTXBbJHuSFyBmDTkJyoYyrbGXZ8wb5EoFAwnXzuoRPNjUQybe4PXppXKR330AkI0bSFmzpbYAqkFo1du2/XBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232380; c=relaxed/simple;
	bh=Xpf/23s+tpbFYRdfPV6fub2fKtvmlhUT09D+IZLg50Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEdeiOD7eB31b/xwsi+TJ4LVrLz25bSf+acv0zQU+Vr3FiuHhmItfA3lFlYChfm/bmUc2TK+2ybEvAMCz4xnn7itpvnbYAyM+s7mlQjeek8EjLkPLc2kcDTQpNu0/WVeRL/pzax1Hnite+0Bqd1XlX+XL2D+COCtwijYVwDKaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LeV32OQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AD7C43399;
	Thu, 29 Feb 2024 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709232379;
	bh=Xpf/23s+tpbFYRdfPV6fub2fKtvmlhUT09D+IZLg50Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeV32OQ9yS57vew36uCuLwNmHGchAdfS5eb8fig+23+Edl5bVOhE7v3rBvqdsSF19
	 uSzlBD8RVBd2h76dfec1Zvimu/rmLW5qRj+zh/BsgaKU+8WYdnhjzPgoTsMufZVAIl
	 jkDA5Y3WygOyS4bty3gOIodyXNmsLNoP3Kma8lxI=
Date: Thu, 29 Feb 2024 19:46:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 0/4] driver core & device property: clean up APIs
Message-ID: <2024022958-motocross-abdominal-e709@gregkh>
References: <20240229162741.3854912-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229162741.3854912-1-andriy.shevchenko@linux.intel.com>

On Thu, Feb 29, 2024 at 06:23:42PM +0200, Andy Shevchenko wrote:
> There are two, but dependent pair of patches that:
> - makes some of devlink APIs static
> - removes 'proxy' header use
> 
> This is rebased on top of latest patches from Jonathan as it has a minor
> conflict in property.h. The series can be applied directly to driver
> core tree with reduced context, but it may be better just to route it
> via IIO. Greg, which way do you prefer?

Why would IIO mess with driver core stuff?

I can just take it in my driver core tree, thanks.

greg k-h


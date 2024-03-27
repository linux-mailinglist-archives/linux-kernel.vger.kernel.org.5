Return-Path: <linux-kernel+bounces-121410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC60F88E79C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BC929E677
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFC6131BAC;
	Wed, 27 Mar 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzW4mkrS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5542A83
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548754; cv=none; b=ItXFJuAKnEN5VMRsSRgWzZXdoWyXvcuarXm4PavmahArH9U+DCogCxaYs6sto2Nr9Y94N6LM/MXxMzVC48Le9jcdRyj6tLl7+tMzsIcXSLkgiutgHHZquGsTnphaCsZry7owaXw/U97M1aNPtL7vSeoZz5CApkz45H+MHKJT5XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548754; c=relaxed/simple;
	bh=wzLHLPpT4PzM2YwOESubJPteBr1NvLOXUqw1LC0YMWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvzAQUgtdzhQWCxxxpNhSjHQ/X094BWwNd+m80Bdt+Q2DSj0zdt/gRtGt24sXx+oT//vYZONLaRzpYRN5YgTOIHUsKZ3D+RPNRIeVmIhKuTD9z07UqrsuUATi2zKl/duMoNSKntiM26iV5z7+cIBk1+KgnXxFnsaVC6+S3FO1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzW4mkrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92081C433C7;
	Wed, 27 Mar 2024 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711548753;
	bh=wzLHLPpT4PzM2YwOESubJPteBr1NvLOXUqw1LC0YMWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzW4mkrSRjz6W4ukdTtDXSS0txxAKr7JkeVKRU9rpfcY2DhZK7NWZFCpJ9m2ElJvu
	 GRUxF5ysqjZ2GO8Cq0Mto5ctsbUBD8FovCHDcOZbd+hF5/XJLsaTsJ7qnJOhcY0HHL
	 4xmZ3paVcPqkSkP1g+r+m3OfzKEOTBCelasKmRcCV2BrDau1621iq9WHb9cCTe5Rmr
	 IGVrLXCvqQdzZnHtkW7Vci2SjlVFTg5qJGYPyfFhAhOZd2QN9+W/fZKRu61AeEJf2G
	 GSrjlYI6dIa8LYExOQE2h2dNByeRK3cE9osjDBzPFVeYPVZunUgtEjCed7rdKg5lsL
	 uU3QgHFriu91Q==
Date: Wed, 27 Mar 2024 14:12:29 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mateusz K <mateusz.kaduk@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <20240327141229.GS13211@google.com>
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
 <20240325211915.GA1449994@bhelgaas>
 <CAPf=4Rc2vQrWqcs=-ND3iOZFJyKE7FdPoqU9w6DKjoSaJo6KaQ@mail.gmail.com>
 <ZgLefFQanbq-ozKM@smile.fi.intel.com>
 <ZgLooJa1JVKEMOtf@smile.fi.intel.com>
 <20240327131711.GR13211@google.com>
 <ZgQeKfsFy9i0h4Kj@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgQeKfsFy9i0h4Kj@smile.fi.intel.com>

On Wed, 27 Mar 2024, Andy Shevchenko wrote:

> On Wed, Mar 27, 2024 at 01:17:11PM +0000, Lee Jones wrote:
> > On Tue, 26 Mar 2024, Andy Shevchenko wrote:
> > > On Tue, Mar 26, 2024 at 04:41:01PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > Hold on, but IIUC this is the report about new hardware that never had
> > > a support by Linux before.
> > 
> > So a revert is no longer required?
> 
> No, it seems an old issue unrelated to this patch.

Very well, consider it *not* done. :)

-- 
Lee Jones [李琼斯]


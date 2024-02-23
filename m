Return-Path: <linux-kernel+bounces-78309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6858611AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A166D1F2636B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA1C7E579;
	Fri, 23 Feb 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mU4/+cna"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAD7E10D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691971; cv=none; b=q/UCfOsiRfBZU/lQgu6lUFLC1RcfA7nEl4TndG2tpxPJbgXGATk9T8anMQ/fdnGBgSB7z7GJxBeAxXfZjCpC6P3DsCV6FdU5emBZ4Zen8aVfLaBljl8r2U6w8iNzck80/zlB5U9NiKSvaoQwM59+8tTt/ktiuPPwt6bdZRj+rXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691971; c=relaxed/simple;
	bh=d6N9a5eFOb78EvjVCYUk+DICF6OeM5B2UxtQQ0HXqRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWrlUVa3vXJXhZc1SkrXWzZ9bYQy9fjHMbaXztoJ4SjW+pRF7qvKlvUnmfvH7lxlcUg6m7/n8TyWhsTUFI75TPDNKHYl0Tb4/8gAlaJwmI3EAvqdwKNtgJ0ptZqPshCUlOijm9nj80tFVwUi5QAsBO1hmyjBK2cPr+sf+snO8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mU4/+cna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DB2C433F1;
	Fri, 23 Feb 2024 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708691970;
	bh=d6N9a5eFOb78EvjVCYUk+DICF6OeM5B2UxtQQ0HXqRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mU4/+cnaCtQlVBIwoEV44zvjbbt64HbHMazJ/LtehX383bnDg52IYqVpRczhPwC8W
	 hUGKcd5oevwsI1Rlf8OKp0lTF2vVLNTD2xjqjKf58DwUnZr1DzOUbC/XTelQn1Qb4J
	 oR69lYRKkD/uf/zAlnw3DwsrqcHOoe9XbeHziU5E=
Date: Fri, 23 Feb 2024 13:39:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gupta, Nipun" <Nipun.Gupta@amd.com>
Cc: "maz@kernel.org" <maz@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Anand, Harpreet" <harpreet.anand@amd.com>,
	"Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
	"Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
	"srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v8 2/2] add wrapper msi allocation API and export msi
 functions
Message-ID: <2024022340-washable-banter-e779@gregkh>
References: <20240223092447.65564-1-nipun.gupta@amd.com>
 <20240223092447.65564-2-nipun.gupta@amd.com>
 <2024022340-reversion-detonator-f229@gregkh>
 <CH3PR12MB9193A635BC7952495469B2C5E8552@CH3PR12MB9193.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB9193A635BC7952495469B2C5E8552@CH3PR12MB9193.namprd12.prod.outlook.com>

On Fri, Feb 23, 2024 at 11:40:51AM +0000, Gupta, Nipun wrote:
> [AMD Official Use Only - General]
> 
> Hi Greg,
> 
> We will be updating soon VFIO CDX irq support patch (which is
> in review) to use this wrapper API.

Please do not top-post and send html emails, the mailing list rejects
them.

Anyway, we can't accept code that isn't actually being used, you know
this, please submit this patch when the actual user is also submitted.

thanks,

greg k-h


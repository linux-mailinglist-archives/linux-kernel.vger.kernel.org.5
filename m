Return-Path: <linux-kernel+bounces-161011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C38B45C0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFE1B213FF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3C495CC;
	Sat, 27 Apr 2024 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LqqAeS9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC244C8D;
	Sat, 27 Apr 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216358; cv=none; b=bQ5v2VFvxy8oOaFT6YsQamlYXcrud0ECPUNDGtK/A+PtMoMrFUlviIpj1w659lXLfMaYD277767RG30160uKUWs/paWCK6opItN6r6evrS84ZT9UbsDgNd8bO8IxjJFQufCtqNGtY4Jdu4YqhlKbfsPt/hlil7mR9u1mPFS2Qbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216358; c=relaxed/simple;
	bh=tr79Artks8dAf9QK673sxTgZ9h7swDRJ+v3dL9mwHDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOnJ/78hRI0vazPtiGMiuV7WEDsYSP8Jx+sD5wvWIG2yErrtLhNYEmI83tYgvTxQcXiGrMTDNpOMnjOj2tqr5TB/HK1uXYDzrUo8i8ov3zok/lECGmiobJLcR6tyPO8/DwVDk9PuxTSr+t+d/Quu8a8W4Exrh+GvE9JDtvNQeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LqqAeS9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630C2C113CE;
	Sat, 27 Apr 2024 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714216357;
	bh=tr79Artks8dAf9QK673sxTgZ9h7swDRJ+v3dL9mwHDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqqAeS9UqZArFJv9wFxwNbNEYqtnYI+JWc9J4k6bQp633ND4Q80LzxyWTuvLGtXpZ
	 h9GsDQ6bAmDlL+Edfn8198q1drntIrka1pMykjFmjBRMHzorwJ9smAZMs/FqurMhS4
	 Qtj9YT+0GBolm8u4MlwLdCGnmL1yqjxDmFwAGTfA=
Date: Sat, 27 Apr 2024 13:12:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Harold Johnson <harold.johnson@broadcom.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>,
	Brett Henning <brett.henning@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linuxarm@huawei.com,
	linux-api@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <2024042708-outscore-dreadful-2c21@gregkh>
References: <20240410124517.000075f2@Huawei.com>
 <66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
 <20240425123344.000001a9@Huawei.com>
 <662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240425182605.00005f22@Huawei.com>
 <662aae2fe4887_a96f294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240426094550.00002e37@Huawei.com>
 <662bd36caae55_a96f2943f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240426175341.00002e67@Huawei.com>
 <6351024b5d6206c4e9a8cd98d1a09d43@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6351024b5d6206c4e9a8cd98d1a09d43@mail.gmail.com>

On Fri, Apr 26, 2024 at 02:25:29PM -0500, Harold Johnson wrote:
> A few examples:
> a) Temperature monitoring of a component or internal chip die
> temperatures.  Could CXL define a standard OpCode to gather temperatures,
> yes it could; but is this really part of CXL?  Then how many temperature
> elements and what does each element mean?  This enters into the
> implementation and therefore is vendor specific.  Unless the CXL spec
> starts to define the implementation, something along the lines of "thou
> shall have an average die temperature, rather than specific temperatures
> across a die", etc.
> 
> b) Error counters, metrics, internal counters, etc.  Could CXL define a
> set of common error counters, absolutely.  PCIe has done some of this.
> However, a specific implementation may have counters and error reporting
> that are meaningful only to a specific design and a specific
> implementation rather than a "least common denominator" approach of a
> standard body.
> 
> c) Performance counters, metric, indicators, etc.  Performance can be very
> implementation specific and tweaking performance is likely to be
> implementation specific.  Yes, generic and a least common denominator
> elements could be created, but are likely to limiting in realizing the
> maximum performance of an implementation.
> 
> d) Logs, errors and debug information.  In addition to spec defined
> logging of CXL topology errors, specific designs will have logs, crash
> dumps, debug data that is very specific to a implementation.  There are
> likely to be cases where a product that conforms to a specification like
> CXL, may have features that don't directly have anything to do with CXL,
> but where a standards based management interface can be used to configure,
> manage, and collect data for a non-CXL feature.

All of the above should be able to be handled by vendor-specific KERNEL
drivers that feed the needed information to the proper user/kernel apis
that the kernel already provides.

So while innovating at the hardware level is fine, follow the ways that
everyone has done this for other specification types (USB, PCI, etc.)
and just allow vendor drivers to provide the information.  Don't do this
in crazy userspace drivers which will circumvent the whole reason we
have standard kernel/user apis in the first place for these types of
things.

> e) Innovation.  I believe that innovation should be encouraged.  There may
> be designs that support CXL, but that also incorporate unique and
> innovative features or functions that might service a niche market.  The
> AI space is ripe for innovation and perhaps specialized features that may
> not make sense for the overall CXL specification.
> 
> I think that in most cases Vendor specific opcodes are not used to
> circumvent the standards, but are used when the standards group has no
> interested in driving into the standard certain features that are clearly
> either implementation specific or are vendor specific additions that have
> a specific appeal to a select class of customer, but yet are not relevant
> to a specific standard.

Then fight this out in the specification groups, which are highly
political, and do not push that into the kernel space please.  Again,
this is nothing new, we have all done this for specs for decades now,
allow vendor additions to the spec and handle that in the kernel and all
should be ok, right?

Or am I missing something obvious here where we would NOT want to do
what all other specs have done?

thanks,

greg k-h


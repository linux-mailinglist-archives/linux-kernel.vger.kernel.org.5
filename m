Return-Path: <linux-kernel+bounces-1274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2EC814CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFF028984B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562B53BB29;
	Fri, 15 Dec 2023 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6hkFAZG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB03DB8B;
	Fri, 15 Dec 2023 16:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA078C433C7;
	Fri, 15 Dec 2023 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702656849;
	bh=4OqhZTmDHDfa6MzpLM8KMW5Z+d4w8EohcY6n1qhIOCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6hkFAZGaxNHfOw7q/tXLyy1StzEIP29myEihwXcqVc/KANRpoWP8p1GdYjeEPpP4
	 cJ8iBxnm7LnDnHvIFzkoQP/vLYDyIwVPWDn72FvXm1UhQWvteoyZMpEj4HpnlZPtC5
	 oy0GgtILCeg+jFvmpKotyjONye8+HLPSzUrtd4nE=
Date: Fri, 15 Dec 2023 17:14:07 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "willy@infradead.org" <willy@infradead.org>,
	"david@redhat.com" <david@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"osalvador@suse.de" <osalvador@suse.de>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v6 2/4] dax/bus: Use guard(device) in sysfs attribute
 helpers
Message-ID: <2023121547-goldfish-snowplow-345f@gregkh>
References: <20231214-vv-dax_abi-v6-0-ad900d698438@intel.com>
 <20231214-vv-dax_abi-v6-2-ad900d698438@intel.com>
 <ZXvqjIqvcGkumNXf@casper.infradead.org>
 <d3eef0c19e949825ad0990a03eb55cc5f3033720.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3eef0c19e949825ad0990a03eb55cc5f3033720.camel@intel.com>

On Fri, Dec 15, 2023 at 06:33:58AM +0000, Verma, Vishal L wrote:
> On Fri, 2023-12-15 at 05:56 +0000, Matthew Wilcox wrote:
> > On Thu, Dec 14, 2023 at 10:25:27PM -0700, Vishal Verma wrote:
> > > @@ -294,13 +294,10 @@ static ssize_t available_size_show(struct device *dev,
> > >                 struct device_attribute *attr, char *buf)
> > >  {
> > >         struct dax_region *dax_region = dev_get_drvdata(dev);
> > > -       unsigned long long size;
> > >  
> > > -       device_lock(dev);
> > > -       size = dax_region_avail_size(dax_region);
> > > -       device_unlock(dev);
> > > +       guard(device)(dev);
> > >  
> > > -       return sprintf(buf, "%llu\n", size);
> > > +       return sprintf(buf, "%llu\n", dax_region_avail_size(dax_region));
> > >  }
> > 
> > Is this an appropriate use of guard()?  sprintf is not the fastest of
> > functions, so we will end up holding the device_lock for longer than
> > we used to.
> 
> Hi Matthew,
> 
> Agreed that we end up holding the lock for a bit longer in many of
> these. I'm inclined to say this is okay, since these are all user
> configuration paths through sysfs, not affecting any sort of runtime
> performance.

Why does the lock have to be taken at all?  You have a valid reference,
isn't that all you need?

thanks,

greg k-h


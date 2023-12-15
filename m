Return-Path: <linux-kernel+bounces-1474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A680814F45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D73287AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0F93011A;
	Fri, 15 Dec 2023 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n1HNiIs7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0530108;
	Fri, 15 Dec 2023 17:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E78C433C7;
	Fri, 15 Dec 2023 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702662794;
	bh=bCeZYjdKbAsjH+3ZnxxwoKFd5W+uxUmvZZXD9LOmVAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1HNiIs70ftZwmIX3BAKT7HlQFwEbubiqSnRfQqpa9/Sfl3TuxPsso5m19okbZO5v
	 nw9dM7Vsy5Kt7w2PbsH6hj2ArcNdwxExg5KAlYr2dArzus0yDJByYdefDdLnKtFEDf
	 kPAtGPf4l5SHoWFNvuAQILAgH9gaflnt5pWNgKU8=
Date: Fri, 15 Dec 2023 18:53:11 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
	"david@redhat.com" <david@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"osalvador@suse.de" <osalvador@suse.de>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v6 2/4] dax/bus: Use guard(device) in sysfs attribute
 helpers
Message-ID: <2023121517-flammable-ragweed-d42e@gregkh>
References: <20231214-vv-dax_abi-v6-0-ad900d698438@intel.com>
 <20231214-vv-dax_abi-v6-2-ad900d698438@intel.com>
 <2023121515-litigate-finished-76dd@gregkh>
 <657c89c16d5f5_269bd294bd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <89ea0a46cd1cf22393c6b05a50cd3e719ab6a4ba.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89ea0a46cd1cf22393c6b05a50cd3e719ab6a4ba.camel@intel.com>

On Fri, Dec 15, 2023 at 05:32:50PM +0000, Verma, Vishal L wrote:
> On Fri, 2023-12-15 at 09:15 -0800, Dan Williams wrote:
> > Greg Kroah-Hartman wrote:
> > > On Thu, Dec 14, 2023 at 10:25:27PM -0700, Vishal Verma wrote:
> > > > Use the guard(device) macro to lock a 'struct device', and unlock it
> > > > automatically when going out of scope using Scope Based Resource
> > > > Management semantics. A lot of the sysfs attribute writes in
> > > > drivers/dax/bus.c benefit from a cleanup using these, so change these
> > > > where applicable.
> > > 
> > > Wait, why are you needing to call device_lock() at all here?  Why is dax
> > > special in needing this when no other subsystem requires it?
> > > 
> > > > 
> > > > Cc: Joao Martins <joao.m.martins@oracle.com>
> > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > > ---
> > > >  drivers/dax/bus.c | 143 ++++++++++++++++++++++--------------------------------
> > > >  1 file changed, 59 insertions(+), 84 deletions(-)
> > > > 
> > > > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > > > index 1ff1ab5fa105..6226de131d17 100644
> > > > --- a/drivers/dax/bus.c
> > > > +++ b/drivers/dax/bus.c
> > > > @@ -294,13 +294,10 @@ static ssize_t available_size_show(struct device *dev,
> > > >                 struct device_attribute *attr, char *buf)
> > > >  {
> > > >         struct dax_region *dax_region = dev_get_drvdata(dev);
> > > > -       unsigned long long size;
> > > >  
> > > > -       device_lock(dev);
> > > > -       size = dax_region_avail_size(dax_region);
> > > > -       device_unlock(dev);
> > > > +       guard(device)(dev);
> > > 
> > > You have a valid device here, why are you locking it?  How can it go
> > > away?  And if it can, shouldn't you have a local lock for it, and not
> > > abuse the driver core lock?
> > 
> > Yes, this is a driver-core lock abuse written by someone who should have
> > known better. And yes, a local lock to protect the dax_region resource
> > tree should replace this. A new rwsem to synchronize all list walks
> > seems appropriate.
> 
> I see why _a_ lock is needed both here and in size_show() - the size
> calculations do a walk over discontiguous ranges, and we don't want the
> device to get reconfigured in the middle of that. A different local
> lock seems reasonable - however can that go as a separate cleanup that
> stands on its own?

Sure, but do not add a conversion to use guard(device) here, as that
will be pointless as you will just use a real lock instead.

> For this series, I'll add a cleanup to replace the sprintfs with
> sysfs_emit().

Why not have that be the first patch in the series?  Then add your local
lock and convert everything to use it instead of the device lock?

thanks,

greg k-h


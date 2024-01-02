Return-Path: <linux-kernel+bounces-14127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE1821820
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10451C21538
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C07D4429;
	Tue,  2 Jan 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qx56niNx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79020F5;
	Tue,  2 Jan 2024 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704181658; x=1735717658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EAl8v2EMp7z1bYG6wZjJbmelzzdeOCO0ej64a3nJYLU=;
  b=Qx56niNx+KUVB0B3whPzlprWbVp5NiwyMCD1v6spH9Q7zzZITUjfMpMW
   hUI3n9AXzrufVvJAaKQcEdkhHFeKTBvHVklS+o/XPvWWgcCs3gnmMgkb6
   DKAex+3RUhgDGtJRDCIpqnsXmjnbjPHuzLXxng6e+ZPjHKuJOV5buPyVM
   leYhzbyEOXKVeGZgzRdy8s8Tk/v1UoVKckLdqoK26fBGo+ESLAU8fGyuR
   Vp82FA2Z5SBZpxHbTEaRkl3uyW0SxX9/BEUCANeUKcBNSXQgiDd+qgSK5
   Jd4tvSewF888XO19RWlH9ma/KgA5W3glh/l3I8ep6AGW5Xlf9MXImwbBB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="4183748"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="4183748"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 23:47:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="772765494"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="772765494"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga007.jf.intel.com with SMTP; 01 Jan 2024 23:47:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Jan 2024 09:47:32 +0200
Date: Tue, 2 Jan 2024 09:47:32 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: RD Babiera <rdbabiera@google.com>, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	badhri@google.com, stable@vger.kernel.org,
	Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: Re: [PATCH v1] usb: typec: class: fix typec_altmode_put_partner to
 put plugs
Message-ID: <ZZO+HZjR6O1eSyjv@kuha.fi.intel.com>
References: <20231121203954.173364-2-rdbabiera@google.com>
 <ZY7mgMkoaZDZGua4@cae.in-ulm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY7mgMkoaZDZGua4@cae.in-ulm.de>

Hi Christian,

On Fri, Dec 29, 2023 at 04:32:16PM +0100, Christian A. Ehrhardt wrote:
> 
> Hi,
> 
> I found this mail in the archives after looking at a bug report
> that was bisected to the change that resulted from the following
> analysis:
> 
> https://lore.kernel.org/all/CAP-bSRb3SXpgo_BEdqZB-p1K5625fMegRZ17ZkPE1J8ZYgEHDg@mail.gmail.com/
> 
> AFAICS the analysis below is partially flawed
> 
> On Tue, Nov 21, 2023 at 08:39:55PM +0000, RD Babiera wrote:
> > When releasing an Alt Mode, typec_altmode_release called by a plug device
> > will not release the plug Alt Mode, meaning that a port will hold a
> > reference to a plug Alt Mode even if the port partner is unregistered.
> > As a result, typec_altmode_get_plug() can return an old plug altmode.
> > 
> > Currently, typec_altmode_put_partner does not raise issues
> > when unregistering a partner altmode. Looking at the current
> > implementation:
> > 
> > > static void typec_altmode_put_partner(struct altmode *altmode)
> > > {
> > >	struct altmode *partner = altmode->partner;
> > 
> > When called by the partner Alt Mode, then partner evaluates to the port's
> > Alt Mode. When called by the plug Alt Mode, this also evaluates to the
> > port's Alt Mode.
> > 
> > >	struct typec_altmode *adev;
> > >
> > >	if (!partner)
> > >		return;
> > >
> > >	adev = &partner->adev;
> > 
> > This always evaluates to the port's typec_altmode
> > 
> > >	if (is_typec_plug(adev->dev.parent)) {
> > >		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
> > >
> > >		partner->plug[plug->index] = NULL;
> > 
> > If the routine is called to put the plug's Alt mode and altmode refers to
> > the plug, then adev referring to the port can never be a typec_plug. If
> > altmode refers to the port, adev will always refer to the port partner,
> > which runs the block below.
> > 
> > >	} else {
> > >		partner->partner = NULL;
> > >	}
> > >	put_device(&adev->dev);
> > > }
> 
> So far everything is fine.
> 
> > When calling typec_altmode_set_partner, a registration always calls
> > get_device() on the port partner or the plug being registered,
> 
> This is wrong. It is the altmode of the plug or partner
> that holds a reference to the altmode of the port not the other
> way around. The port's altmode has (back) pointers to the altmodes
> of its partner and the cable plugs but these are weak references that
> do not contribute to the refcount.
> 
> > therefore
> > typec_altmode_put_partner should put_device() the same device. By changing
> 
> Thus this conclusion is wrong. The put_device() used to be correct.
> 
> > adev to altmode->adev, we make sure to put the correct device and properly
> > unregister plugs. The reason port partners are always properly
> > unregistered is because even when adev refers to the port, the port
> > partner gets nullified in the else block. The port device currently gets
> > put().
> 
> Please correct me if I missed something.

Thanks for checking this. Your analysis sounds correct to me.

RD, I think we need to revert the commmit. If you still see the original
problem, please prepare a new patch.

thanks,

-- 
heikki


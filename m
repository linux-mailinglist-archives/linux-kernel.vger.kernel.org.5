Return-Path: <linux-kernel+bounces-160412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311E8B3D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955E31C230B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D09158D92;
	Fri, 26 Apr 2024 16:53:50 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A751DDD6;
	Fri, 26 Apr 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150430; cv=none; b=kjz4KwnDYOl0xkvMeOEsJK6VRFOHZPo2pTXa8kry4LNwC1bABw357EQX/mDN3z8t0JbK66ptiZQpeeh9G1EWIXTPhRKU3VdTrWXJ6WeIcxWWI6ndni8IsLSs+QvYt+jm+KASlEMf57s/UMfDcaG28a09kJI4kJlo9XbYQGMGmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150430; c=relaxed/simple;
	bh=qBWR0niH5zgeEw2mYz3NYV00URwQJyobXGWPG0AH2zs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1wz7ObQMB/3Dsb/falXkVftVQfukWbxs+j9DLucVDHH1b/NOnAIryd0GK7uf0NaBWDoFfSrp/NNBryiusmx3C7uquD1LyPcHsEFo5HW+GnQTUoFVmpFjZF2i83RZtBBMDTxW1d7BB64d0SHiw5KElTE6HCJuPvtRfqYqr8NZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQzJL0WlTz6K6JG;
	Sat, 27 Apr 2024 00:51:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 33455140A70;
	Sat, 27 Apr 2024 00:53:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 17:53:42 +0100
Date: Fri, 26 Apr 2024 17:53:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Sreenivas Bagalkote
	<sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Harold Johnson <harold.johnson@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
	<linuxarm@huawei.com>, <linux-api@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <20240426175341.00002e67@Huawei.com>
In-Reply-To: <662bd36caae55_a96f2943f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240321174423.00007e0d@Huawei.com>
	<66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
	<20240410124517.000075f2@Huawei.com>
	<66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
	<20240425123344.000001a9@Huawei.com>
	<662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240425182605.00005f22@Huawei.com>
	<662aae2fe4887_a96f294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240426094550.00002e37@Huawei.com>
	<662bd36caae55_a96f2943f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Apr 2024 09:16:44 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > To give people an incentive to play the standards game we have to
> > provide an alternative.  Userspace libraries will provide some incentive
> > to standardize if we have enough vendors (we don't today - so they will
> > do their own libraries), but it is a lot easier to encourage if we
> > exercise control over the interface.  
> 
> Yes, and I expect you and I are not far off on what can be done
> here.
> 
> However, lets cut to a sentiment hanging over this discussion. Referring
> to vendor specific commands:
> 
>     "CXL spec has them for a reason and they need to be supported."
> 
> ...that is an aggressive "vendor specific first" sentiment that
> generates an aggressive "userspace drivers" reaction, because the best
> way to get around community discussions about what ABI makes sense is
> userspace drivers.
> 
> Now, if we can step back to where this discussion started, where typical
> Linux collaboration shines, and where I think you and I are more aligned
> than this thread would indicate, is "vendor specific last". Lets
> carefully consider the vendor specific commands that are candidates to
> be de facto cross vendor semantics if not de jure standards.
>

Agreed. I'd go a little further and say I generally have much more warm and
fuzzy feelings when what is a vendor defined command (today) maps to more
or less the same bit of code for a proposed standards ECN.

IP rules prevent us commenting on specific proposals, but there will be
things we review quicker and with a lighter touch vs others where we
ask lots of annoying questions about generality of the feature etc.
Given the effort we are putting in on the kernel side we all want CXL
to succeed and will do our best to encourage activities that make that
more likely. There are other standards bodies available... which may
make more sense for some features.

Command interfaces are not a good place to compete and maintain secrecy.
If vendors want to do that, then they don't get the pony of upstream
support. They get to convince distros to do a custom kernel build for them:
Good luck with that, some of those folk are 'blunt' in their responses to
such requests.

My proposal is we go forward with a bunch of the CXL spec defined commands
to show the 'how' and consider specific proposals for upstream support
of vendor defined commands on a case by case basis (so pretty much
what you say above). Maybe after a few are done we can formalize some
rules of thumb help vendors makes such proposals, though maybe some
will figure out it is a better and longer term solution to do 'standards
first development'.

I think we do need to look at the safety filtering of tunneled
commands but don't see that as a particularly tricky addition -
for the simple non destructive commands at least.

Jonathan



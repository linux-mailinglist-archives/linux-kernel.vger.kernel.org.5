Return-Path: <linux-kernel+bounces-108503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A53880B65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454E92836ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E8812E4A;
	Wed, 20 Mar 2024 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTb817C2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C28A3D;
	Wed, 20 Mar 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917134; cv=none; b=P9FfulcUvb7A2LxiVPdgnXDlBU7yAsFewttKQ6QA/IJTZhaYyIItqBVIEOQvpF7z20keN/5j+cwzvUCnJGwiLNRwdDRrpzi8Vzgw4wFGBt/8e+IkTsfNln72MsPRM4/xmDOOd10WoDacXjld+CeMrggRBTL6TOuyPaNY35//vJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917134; c=relaxed/simple;
	bh=fAgGUE2IUmexRk7WdnaZaJoJomUIOTguyBKLcuDXqqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z89b9wLabwh9N6YWryafUxw0a7L66GXkMnAl/x8KmYPWtQJkfDEzuBaN5Od2E51zJamtl5xw9+fw0kRvr95x1JS0jhgL2qH0IkjjwXf9cSMq2nlrAka86SB0DDEKt9OhCbV94cAI+fZF2A0tgRt8l0pBf2RqfFEbYFVw6X+Jq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTb817C2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710917133; x=1742453133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fAgGUE2IUmexRk7WdnaZaJoJomUIOTguyBKLcuDXqqg=;
  b=NTb817C2JsYVX76te40VZ7MGXXoztFLUbmrvHLypcGkMa7FDBIfrcctI
   0cPk2+Tegye4fsn91brImb5UzQUixK5W4SF1m/ygjtn74mmEfFXAPOONj
   tbGIZJ/+p9IEtfuQxT0pZIYumn4dmQK0+ejEQ0byhHxiwp1BLbefaX5H3
   qxTPedaBVgEmAVAdZYiHBUGp8uPGfYL2OiiEjzNbOGhEyZLH4KVse5csa
   c1xUW+51m5It3ty401RWVM4/HTcwHAXLfb1wCxg6jE6VD4AE/TAQcU8Gf
   +HWaaxynIUWZHxMEC5OOrddRGEj/8cI0jbRcpNHoTFt/zq+5STFGqIrgL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17229672"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="17229672"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 23:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="18782241"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 23:45:26 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 89E5F11F853;
	Wed, 20 Mar 2024 08:45:22 +0200 (EET)
Date: Wed, 20 Mar 2024 06:45:22 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/1] mei: vsc: Unregister interrupt handler for system
 suspend
Message-ID: <ZfqGAth743v4Slpx@kekkonen.localdomain>
References: <20240318080126.2813476-1-sakari.ailus@linux.intel.com>
 <2024031915-manhole-winnings-43d4@gregkh>
 <ZfltTgGANYs9uix5@kekkonen.localdomain>
 <2024031905-showpiece-coral-c76c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024031905-showpiece-coral-c76c@gregkh>

On Tue, Mar 19, 2024 at 12:51:34PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 19, 2024 at 10:47:42AM +0000, Sakari Ailus wrote:
> > Hi Greg,
> > 
> > On Tue, Mar 19, 2024 at 08:51:43AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Mar 18, 2024 at 10:01:26AM +0200, Sakari Ailus wrote:
> > > > Unregister the MEI VSC interrupt handler before system suspend and
> > > > re-register it at system resume time. This mirrors implementation of other
> > > > MEI devices.
> > > > 
> > > > This patch fixes the bug that causes continuous stream of MEI VSC errors
> > > > after system resume.
> > > > 
> > > > Fixes: 386a766c4169 ("mei: Add MEI hardware support for IVSC device")
> > > > Cc: stable@vger.kernel.org # for 6.8
> > > > Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > > > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  drivers/misc/mei/platform-vsc.c | 17 ++++++-
> > > >  drivers/misc/mei/vsc-tp.c       | 84 +++++++++++++++++++++++----------
> > > >  drivers/misc/mei/vsc-tp.h       |  3 ++
> > > >  3 files changed, 78 insertions(+), 26 deletions(-)
> > > 
> > > What is the git commit id of this in Linus's tree?
> > 
> > This one isn't in Linus's (or any other maintainer) tree yet.
> 
> Then why was it sent only for 6.8?  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.

Ah, I think I mistakenly included the stable@vger e-mail address in
distribution as the other patch was meant to be sent there. I'll resend
this.

-- 
Sakari Ailus


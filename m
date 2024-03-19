Return-Path: <linux-kernel+bounces-107413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF5B87FC19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987FC287396
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B39A5787B;
	Tue, 19 Mar 2024 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvl0muvH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692857334;
	Tue, 19 Mar 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845269; cv=none; b=LXnciQkcliL124PjJj2V8ckSxS+ZmTRNn/f8Dd7DaxcvXZDe4FiG3G4AO4dS5cEUHNyJSzTrxfJ1vT2R9T5BejyHsy5Hw7IbL99Jqs8s6B6nPMBHlhizILEIsToVRbZUlPdVOeljyqgRLrl748SD0tb+CIX6om+7B4drX9c5Z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845269; c=relaxed/simple;
	bh=lLyP/BNdCfw25smEMvk1Cgty/ReQCY2rURxRYbjQZwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmJGu1siIBKgcPlLyEC5U+nBWDga6KaRlvq22ZwbO0kBG8wRQFOWG/HfOzpDVNX86WsPhQ1acjiziw5w05Qh4Z3dTRZ3YgX4m2KUS25Wvej/sz/IOTH0IZS5IPuBAlexc0N3SfyiNotANzCIUOnnUWxl2eyLYFBKHKPvy8IZwgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvl0muvH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710845268; x=1742381268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lLyP/BNdCfw25smEMvk1Cgty/ReQCY2rURxRYbjQZwI=;
  b=lvl0muvHUBdaF+HYkX0lNUIxMgc01fXje8Myaf74ckQ9r+Q5Xpo8o/mu
   gRr02UTmJtutRd5SBMAtv6EpAmLBfG0Cj2IHZZ0samk3mScruF7lDAZvs
   vsr6Ablh7Ftcibja4b+5utLvBHmKGTmXIzrse9b9k/pargl4a4Im70cjU
   mnqa7+J4qXFg5986Lf+ZreHP9DuUNiUk56EsE6rPGn5Qy2AwmczYtI8bs
   TRjRDF10/ZEhck7U9wb/1C3ywQoJ4Ap0lPYmJ2scpxa+cfl1a2swPI9GO
   ObAGKQd39GQkXIH5ih+nFpcqxE61IUWDKg9yBpmU5o+91MnxJahVKkeZ6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="8648279"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="8648279"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 03:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="51206661"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 03:47:46 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6575C11F853;
	Tue, 19 Mar 2024 12:47:42 +0200 (EET)
Date: Tue, 19 Mar 2024 10:47:42 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/1] mei: vsc: Unregister interrupt handler for system
 suspend
Message-ID: <ZfltTgGANYs9uix5@kekkonen.localdomain>
References: <20240318080126.2813476-1-sakari.ailus@linux.intel.com>
 <2024031915-manhole-winnings-43d4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024031915-manhole-winnings-43d4@gregkh>

Hi Greg,

On Tue, Mar 19, 2024 at 08:51:43AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 18, 2024 at 10:01:26AM +0200, Sakari Ailus wrote:
> > Unregister the MEI VSC interrupt handler before system suspend and
> > re-register it at system resume time. This mirrors implementation of other
> > MEI devices.
> > 
> > This patch fixes the bug that causes continuous stream of MEI VSC errors
> > after system resume.
> > 
> > Fixes: 386a766c4169 ("mei: Add MEI hardware support for IVSC device")
> > Cc: stable@vger.kernel.org # for 6.8
> > Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/misc/mei/platform-vsc.c | 17 ++++++-
> >  drivers/misc/mei/vsc-tp.c       | 84 +++++++++++++++++++++++----------
> >  drivers/misc/mei/vsc-tp.h       |  3 ++
> >  3 files changed, 78 insertions(+), 26 deletions(-)
> 
> What is the git commit id of this in Linus's tree?

This one isn't in Linus's (or any other maintainer) tree yet.

-- 
Regards,

Sakari Ailus


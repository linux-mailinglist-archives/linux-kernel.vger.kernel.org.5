Return-Path: <linux-kernel+bounces-85645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB4D86B8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9DD285E04
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6795E08D;
	Wed, 28 Feb 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GP5azm86"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2F5E070;
	Wed, 28 Feb 2024 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149957; cv=none; b=FqYoc2daqMqdC67FeZTKX/c75qV1KVXOhdbKJeeNqRbjkr80Cyq8JdDPslOyV6N42MrhbMK89VDUAhmLcIfD1AqxSGq9sSALMymG+ZN0YRNqx3RHuBQZHJ6q23pUO2FX8dm5pnEZfLXJUori0VKMlRv9gV3a3e5Rk4iLzk33gX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149957; c=relaxed/simple;
	bh=fjreD3AvpuMZusL/02iZMWGJUUh6uW620cQWuM2ywis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxUWTWqO4KeE/bysdAXykGaKyyZRbBQRbeN0K4+/uCd99UhCwqvulPgkuvm5jw86pitALCgTVc8pJGMzhVmShtpLMm2CDA3iOdjG0vKD2CktsMOSkAusstHadJBlEyw7AgINIjwbL0QUmtNJKBOVeLxAuKpzr36fQoGGT6LNdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GP5azm86; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149956; x=1740685956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fjreD3AvpuMZusL/02iZMWGJUUh6uW620cQWuM2ywis=;
  b=GP5azm86lwKhjc+rKz8ScGyNfKXHDmg7eHOdVD/+hFxOHCTjzGlEnqgC
   sUwyTUNg05MKEMgwz4E60qiWAlA3kkjeg01hYP+l5a3NsgWnfBCfrRsTS
   +422Ozppx6zNg8bVI5/cIloVfFl0qLfldne58ON85LlYd+LzxYapnY2L1
   rW/6lBvCDfTIwoHGtWJsF0y6Bs7TNNpATc1LIWlgwTZggL6Wj/KYo07VB
   IhS2jVS21OPB9e8AMwrEfKYEzhywA9pNFWbX1Me6DKdPA1udQ19WA9/Z0
   JS5cDG0K6TjeA0INmCTGBiXA7Ikj2BckUe0ZFxY8uWDwVJrHedjn4L11X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14217961"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14217961"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913959763"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913959763"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:52:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfPyd-00000008Tvk-3ovK;
	Wed, 28 Feb 2024 21:52:27 +0200
Date: Wed, 28 Feb 2024 21:52:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jessica Yu <jeyu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH 2/4] dev_printk: Add and use dev_no_printk()
Message-ID: <Zd-O-6q3HcQewIrA@smile.fi.intel.com>
References: <cover.1709127473.git.geert+renesas@glider.be>
 <8583d54f1687c801c6cda8edddf2cf0344c6e883.1709127473.git.geert+renesas@glider.be>
 <Zd9vx2pM3Ds9-dzk@smile.fi.intel.com>
 <CAMuHMdVL0_8At_V7yRecZ5wk4RytaDXpRm2rNr+T+QMCU80tzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVL0_8At_V7yRecZ5wk4RytaDXpRm2rNr+T+QMCU80tzw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 08:33:19PM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 28, 2024 at 6:39 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Feb 28, 2024 at 03:00:03PM +0100, Geert Uytterhoeven wrote:

..

> > dev_printk()
> 
> I fully agree.  But the surrounding comments don't, so I gave in.

Is there any better justification to keep a technical debt?
I mean, the comment here can be better than existed ones, if you feel
uncomfortable with it, you can fix the rest in a separate patch.
Would it be a big deal? :-)

-- 
With Best Regards,
Andy Shevchenko




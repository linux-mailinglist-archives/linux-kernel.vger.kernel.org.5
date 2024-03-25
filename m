Return-Path: <linux-kernel+bounces-117056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300C688A680
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EFF2E24DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CD513DDB4;
	Mon, 25 Mar 2024 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFdVOqmg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A4213D281
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370932; cv=none; b=LChNZEkoUxRIh6kXpOaAlkdkfhkkdGZyOWP8u0y/zfSigi7IlLGDiwQSskGdatxwN5CVeAqg6CooMcdqCfVqXjkT7i2HVvVyEyh8iIgDPb9BPSVQu+7WJdqzh0aehKb92rYh33caL/P/r5Y9EKx69QIgC4JRXLMI26RMWOzAUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370932; c=relaxed/simple;
	bh=kBexTpdznufB8h8lB8GWs078OsFkYjqj8luVRzOqmnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT4IJF1Kh0DCmcCYoieeozivby05G+L8ViTSdoo9r1EAGfNoIBCfcpwFRCuvFUMrFveaFc/214+Q/i3x568qzE/Tfl3JorQnktvNqJaS/swQDdzwCahqi4JcjLxWN/3DuGAz476f3POn9uJNLXDx9kZxieyHqtb6aliuzjRW5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFdVOqmg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370931; x=1742906931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kBexTpdznufB8h8lB8GWs078OsFkYjqj8luVRzOqmnc=;
  b=YFdVOqmg9SulhOoNQC9j2fcF4JJLmJCR1MJcRSzFdLUY9f5xZLSlEFIx
   tpcUuY157Cmij3tdPFdw/9sy1Q+LyySYvuUNDPXbpEI68AZKf0XMVTCsZ
   wW9owFUW+cvRlH1/+KzftTbGoMiyCpxy0QsZXO6hbdmXjyKGM2JKUhvEn
   fG48Z6u21ZNqNnLhqHFl7ifDBt2UJtu+0LvcziQWoe1QBVIVnY/1igWIZ
   na3KJUlFzgqkYoowfGJIVdZfaq7gYXzWbXgsQd3mBGJQjHpI9jx/Evr6I
   BhQOSO2pbNou73F6SWu/HC43W3vOWVmfEV9fkVJOTpg6Cf4JvHRI+T4B7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6198768"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6198768"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914842445"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914842445"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:48:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rojkq-0000000FywC-2sqU;
	Mon, 25 Mar 2024 14:48:44 +0200
Date: Mon, 25 Mar 2024 14:48:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 1/1] x86/rtc: Remove unused intel-mid.h
Message-ID: <ZgFyrHCzVlwCn1gn@smile.fi.intel.com>
References: <20240305161024.1364098-1-andriy.shevchenko@linux.intel.com>
 <14750023-e5fb-45f7-9c28-9510ce5a5994@intel.com>
 <ZedI9vCoCf9KtHcr@smile.fi.intel.com>
 <0c7c00c0-3b4a-41b3-8664-9ea6ee7e0814@intel.com>
 <ZedKGoPoTgWfOVNO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZedKGoPoTgWfOVNO@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 05, 2024 at 06:36:43PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 05, 2024 at 08:34:59AM -0800, Dave Hansen wrote:
> > On 3/5/24 08:31, Andy Shevchenko wrote:

..

> > I'll stick this in the x86 queue.
> 
> Thank you!

Any updates here?

-- 
With Best Regards,
Andy Shevchenko




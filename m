Return-Path: <linux-kernel+bounces-166655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873B08B9DA0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AA71F22DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4915B542;
	Thu,  2 May 2024 15:38:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7469A15381F;
	Thu,  2 May 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664331; cv=none; b=k8ydzM+7vwHeOIhy626jTl2AZaQz25MlRHUE0zuBqG8tgxMKL4SmJTfHcm7r6iyMQWcAzoCW+0YeA3J1CnBO3+ve0+i1HUuMCCi4Lp8HDm3DSDScWqe5LwQ+/tOGV13WKUrdcKmGY4b4J1why3R8FeoZvb+X4LtoVXF2s4xbmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664331; c=relaxed/simple;
	bh=19JNsRFEKUX4aIFSbQgj18sRdjQzRL6sHrU6+0i+8y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXzyTxPziWlniXZWiJbMsEzym3ctyjlQuDOtXTOdh/3P22UGX1Nh8m3RZC8FwVv6hvKf9RZjTTj3ASmR3DkOOxHSJoMZQB/3wX84B2k+NQ4rp8oVBNa2Lf739VOUfJVokalQFMizVN1AdeCG0SrGx3UH9qibcas97N6mZ/yBm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: rkPEPQY7Tw6bHi1I5fkD9A==
X-CSE-MsgGUID: MStDGcttTDyjS32/h0OrLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="14247058"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14247058"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:38:50 -0700
X-CSE-ConnectionGUID: QvFjUOimSR+HemaZ6JTTjQ==
X-CSE-MsgGUID: iObttkVIQhOkVK/mU7eD0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50356399"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:38:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1s2YWD-00000003MgT-3p93;
	Thu, 02 May 2024 18:38:45 +0300
Date: Thu, 2 May 2024 18:38:45 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: "Hsin-Yu.Chen" <harry021633@gmail.com>, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] string: improve strlen performance
Message-ID: <ZjOzhc0o00njV_RT@smile.fi.intel.com>
References: <20240502141359.89567-1-harry021633@gmail.com>
 <CAHp75Vd9PibrQA=tgZLHuv-kDXana9rGcu5s_aPqyxW6tDBYGw@mail.gmail.com>
 <CAHp75Ve4BV7+C+XsNmmjCSupcL6PXe_9ZNMGAQXg9nqdMBFrqg@mail.gmail.com>
 <202405020809.C8973634BF@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202405020809.C8973634BF@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 08:10:32AM -0700, Kees Cook wrote:
> On Thu, May 02, 2024 at 06:03:04PM +0300, Andy Shevchenko wrote:
> > On Thu, May 2, 2024 at 5:59 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, May 2, 2024 at 5:14 PM Hsin-Yu.Chen <harry021633@gmail.com> wrote:
> > 
> > And on top of that, check what this code will do on the architectures
> > that do not support unaligned access. If everything is fine, mention
> > this in the commit message. Btw, your commit message needs
> > elaboration, e.g., pointing to the test case (which is absent in this
> > patch, I assume it's already in the kernel?) and step-by-step
> > instructions on how you got the mentioned results with details of the
> > hardware you used for that.
> 
> I might be worth looking at the implementation of strscpy(), which is
> doing similar multi-byte steps and handles unaligned access.

Right, we have a word-at-a-time.h or alike for this things.

-- 
With Best Regards,
Andy Shevchenko




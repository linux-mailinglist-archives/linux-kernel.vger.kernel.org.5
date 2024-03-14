Return-Path: <linux-kernel+bounces-102976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7892887B959
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A76B221B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111CF6BB28;
	Thu, 14 Mar 2024 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nnw0sE2w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572695CDD0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405258; cv=none; b=LRmwbXtCYQJ3/8A7Cp40oUxKe/St2PHfPcdsCMoMAfTDAlptH7FmjGpBMrZpU5NK/h1chwYmQYF74z0f4fcnj4h2cQSAJTpcEAbMzU+i67g/dUW/lw7H6yJKGQ4et7g2KEu6aLbqtS+W9/i4RYnCgG0v3fScBHGhRBzXJlQi3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405258; c=relaxed/simple;
	bh=qd4eqTBkHcwbLo7eSV2Kedg+vbWdERUbOG59W19P5oY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uDOLM4/9vjY5fX9w6NHvAB9CGPfmTZceCPhjE2VSjEe9H2EbkGkc3AFJW8iFEhxcSnDMH0ItER8bAcXvVsiWw3N4jsv+9n7zbZTLymIZaoOzlbOumKGf4LJU6uPbtqZ60iiAAPy0eoO1UPq77gkDr/jsW4BhYVCQBILzAnTRIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nnw0sE2w; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710405256; x=1741941256;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qd4eqTBkHcwbLo7eSV2Kedg+vbWdERUbOG59W19P5oY=;
  b=Nnw0sE2w5WgLU+U9KmeF5rShXpeSoUEeIQ57MOzzS6IRowS5H+7JEUNM
   gRy3xaxbna2fO0BYWYeBx6nF9q3hBUO6M6NLyORLR+dCy8DdYF4Ka5LUb
   XoBadCjDWwWVXdwi1F91+Mvqc43HOuZcJivvtO0K10mv0XKCVZB2cN/Ks
   XQ9xhVwcqUnEsOCR+NbnXg4CZ2RLKPv6laPCXd5rqt3NyK8lP9xMhevMd
   iZcobWkCx0jn4f8ZdAlPZ4T74zYDkaIG2aZDn9JvUJrRBvjar8gv/XtpS
   ksM/TeZYAIT5Xo1uk+IIrRhf7Ki/KNUDmLeyinfSq0gXRFIldNj85nQg5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="22669292"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="22669292"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 01:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="12669113"
Received: from rboza-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.139])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 01:34:13 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Dave Airlie <airlied@gmail.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: Animesh Manna <animesh.manna@intel.com>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm for 6.9-rc1
In-Reply-To: <CAPM=9twwZ-u7_8sRRRf5kRnuRa44ixzM8dHZUs6f5wLnQi90Zw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAPM=9twR+WnE3GGqyeh1cuGVmpADPTwDPK10625RP--rLrqkxA@mail.gmail.com>
 <CAHk-=wiTWLKkg0Hht4ofDTVsebD2Zq-m4UP-DsiZjM+w4b7qug@mail.gmail.com>
 <CAPM=9twwZ-u7_8sRRRf5kRnuRa44ixzM8dHZUs6f5wLnQi90Zw@mail.gmail.com>
Date: Thu, 14 Mar 2024 10:34:10 +0200
Message-ID: <87zfv1qkjh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 14 Mar 2024, Dave Airlie <airlied@gmail.com> wrote:
> On Thu, 14 Mar 2024 at 11:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Tue, 12 Mar 2024 at 21:07, Dave Airlie <airlied@gmail.com> wrote:
>> >
>> > I've done a trial merge into your tree from a few hours ago, there
>> > are definitely some slighty messy conflicts, I've pushed a sample
>> > branch here:
>>
>> I appreciate your sample merges since I like verifying my end result,
>> but I think your merge is wrong.
>>
>> I got two differences when I did the merge. The one in
>> intel_dp_detect() I think is just syntactic - I ended up placing the
>>
>>         if (!intel_dp_is_edp(intel_dp))
>>                 intel_psr_init_dpcd(intel_dp);
>>
>> differently than you did (I did it *after* the tunnel_detect()).
>>
>> I don't _think,_ that placement matters, but somebody more familiar
>> with the code should check it out. Added Animesh and Jani to the
>> participants.
>>
>> But I think your merge gets the TP_printk() for the xe_bo_move trace
>> event is actively wrong. You don't have the destination for the move
>> in the printk.
>>
>> Or maybe I got it wrong. Our merges end up _close_, but not identical.
>
> You are right, I lost a line there, I've repushed mine just for
> prosperity with that fixed.
>
> The other one I'm not sure on and will defer to the i915 maintainers
> if ordering matters.

I don't think the ordering matters, but Linus' solution matches what we
have in our -next, and has been tested.

BR,
Jani.


-- 
Jani Nikula, Intel


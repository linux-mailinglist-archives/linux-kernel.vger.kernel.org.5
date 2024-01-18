Return-Path: <linux-kernel+bounces-30469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46991831F11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6604D1C22B57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F32D619;
	Thu, 18 Jan 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0xsNEi2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1A2C6A6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602392; cv=none; b=ZYV/A0MfgtjaHoPipPr1yfOTNfRDih5g5KLFmHNsyuCISL0BqImPwzZ6ZzsNyDHYl1zs5DimkO8TVzDGxjQamVcC9K5Jn6NNzSOe60gIHGYzCYfOcAKiO6Is+nUoQLVPSyD3Fbws3ccCGj+CGmq/dy/uXM3EGW1uD/HK+V72QuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602392; c=relaxed/simple;
	bh=xg4EJKawJAl/z3H6srpfA4TM7W1Db5QEuGXGd57NC00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fp7Yxh4UmH4cWum73zGu7fKfAdCNN9M6H6Fg8fceRsxAKQI87XxMwtkyOWSnV0dARWi79G5iR3of5kOYm/BGNCliByg3s8oqJB5EE85eB+t/7fVaruxdyycSXaArx0MB5SpwxL1YK3ePVBT1GPhzB2XTFVGwNaSppk/MZHaxFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0xsNEi2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705602390; x=1737138390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xg4EJKawJAl/z3H6srpfA4TM7W1Db5QEuGXGd57NC00=;
  b=V0xsNEi2t6dUMTu0VBWZop+GnZlVKzRgfe7eCfdC/5uEdlXLP7z71Oiw
   mObjBFx1p6DkKSsNQDIuqGfEyoSsDDbS69tB2m4F7yuKB2ewo5E659oT+
   A7FeeJ/LTzbQig+ctmUrQX3Q+7o+Z8O5z+VILBCsNLqlLGfKLC4Xmunhx
   rS+N3JMVlsaBfXENat2KpF6f+jIVGw/83QZ7UDBYyBnP0a1BD37g28OyW
   /bFTqSsdwxSUcJhhJsTBXd3fEnlKO9GhE7n9L/KutaYSxgwNmf1xF31qq
   kBkJssxCB1XYUg3PgT80cM2cryW654moLI29NakypeUD+pecZ/5V4OL6g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7625448"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="7625448"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 10:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="908109398"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="908109398"
Received: from dfast-mobl.amr.corp.intel.com (HELO [10.251.13.41]) ([10.251.13.41])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 10:26:28 -0800
Message-ID: <54bcb902-0fab-4a53-8b8e-85b6e4484b03@intel.com>
Date: Thu, 18 Jan 2024 10:27:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: verify xstate buffer size according with
 requested features
Content-Language: en-US
To: Andrei Vagin <avagin@gmail.com>
Cc: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20240116234901.3238852-1-avagin@google.com>
 <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
 <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com>
 <b3e5456a-7113-4868-b8ce-020421e898ba@intel.com>
 <CANaxB-zQYC8=7frWGU2pRTDJrkVu0iR8QZCmUxSzGmBG-_b1cg@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CANaxB-zQYC8=7frWGU2pRTDJrkVu0iR8QZCmUxSzGmBG-_b1cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/17/24 23:59, Andrei Vagin wrote:
> On Wed, Jan 17, 2024 at 3:52 PM Dave Hansen <dave.hansen@intel.com> wrote:
..
>> "fx_sw" is actually a software-defined and software-only-consumed area
>> of the XSAVE buffer, thus the '_sw'.  Nothing in the '_sw' section tells
>> us how the hardware will behave.
> 
> I think you don't take into account the requested-feature bitmap (RFBM),
> which is the logical-and of edx:eax and XCR0. In our case, edx:eax
> is set to the value of fx_sw->xfeatures.

Ahh, I did miss that indeed.

Let's step back and look at what's in play:

1. fx_sw->xstate_size, which is eventually passed to
   fault_in_readable()
2. fx_sw->xfeatures
3. XSTATE_BV (aka. fpu->...->header.xfeatures)
4. What XRSTOR actually does, which is #2 OR'd with #3.
5. xstate_calculate_size(fx_sw->xfeatures)

The bug that you've reported here is essentially that the size passed to
fault_in_readable() doesn't match what XRSTOR actually does (#4).   Note
that today, fault_in_readable() may end up faulting in _too_ much memory
if there's a bit clear in XSTATE_BV.

The proposed fix adds the #5 calculation.  It's conservative because
fx_sw->xfeatures is represents a superset of what XRSTOR will actually
restore.  But now, instead of just faulting in too much memory, a
too-small fx_sw->xstate_size will end up zapping all the XSAVE state.

This is all freakishly complicated and changes a bunch of behavior.
It's way too much to be done in a patch with a 5-line commit message.

I suspect this needs some real refactoring.  I really think fx_sw should
remain unmodified after being copied in from userspace.  If you want to
start interpreting 'fx_sw->xstate_size' as the fault_in_readable() size,
then that needs to be a separate logical variable.

>>>> because the CPU knows where the fault happened.  It told us in CR2 and
>>>> all we have to do is plumb that back to fault_in_readable().
>>>
>>> I considered this option as well, but then I decided that this approach
>>> is better. The most important aspect is that it always rejects bad
>>> buffers, allowing a user space to detect an issue even when a fault
>>> isn't triggered. I believe proper handling of xrstor page faults could
>>> be a valuable additional improvement to this change. If we detect a
>>> fault outside of a provided buffer, we can print a warning to signal
>>> that check_xstate_in_sigframe is incomplete.
>>
>> I'm not really following the logic there.  What's the downside of taking
>> the fault?
> 
> Let's consider a scenario where someone messed up with an fpu state on a
> signal frame. With my approach, a mistake can be promptly detected.
> However, if we incorporate the page fault handling of xrstor, a mistake
> will only be identified if xrstor triggers a fault. In cases where a
> buffer is allocated in a large memory mapping, xrstor may silently read
> memory beyond the buffer. Next time, a page beyond a buffer might be
> swapped out, xrstore triggers a fault leading to application crashes.

I think that's an orthogonal problem really.

Fault loops are nasty.  There's a reason that the architecture provides
CR2 instead of depending on software to, for instance, figure out why
and how every instruction faulted.  It's easy to look into the past and
as the CPU where the fault happened.

On the other hand, we have XRSTOR.  Sure, it's _possible_ to look into
the future and figure out what memory XRSTOR will touch.  But, we
apparently stink at looking into the future (thus this bug).  Not
because we're stupid, but simply because looking into the future is hard.

I'd much rather fix the fault loop problem by looking into the past than
predicting the future.  The fault handling _must_ be correct or we get
hangs.

If we have nice, reliable fault handling and then decide that we've got
XRSTOR's running amok reading random memory all over the place that need
a nicer error message, then we can add that code to predict the future.
If our "predict the future" code goes wrong, then we lose an error
message -- not a big deal.


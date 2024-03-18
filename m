Return-Path: <linux-kernel+bounces-106448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A423C87EEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAF01C220A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23855789;
	Mon, 18 Mar 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vmoJpG9m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d6Ln3qGn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED595577A;
	Mon, 18 Mar 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782878; cv=none; b=TWYBn4Wo8TnMe73qB7FDIdyZq6ZhCSbMqFLArVMksZJSj5pC6yeWexMggrRRshPNCck8g1BJPZbAn4kt6nFdCLNVAGiTNFRfbcqcnArBAwTcYCu7Ay2C+FusmxFhJqXyB/USsqd/GbqhMEzPB05K58IbguXGp4ri29F9trx8+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782878; c=relaxed/simple;
	bh=UN23v0BZ2VfVus/rrnJ8TYGw2JtEYehk578g66wEgzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fbd2VM8ERY8iuB/A0uTXylKTKAM9Ii0QTlF7K1BVTv4O+JdzB64u4pjGs6/LtqD9B34/qFR1t6gBF5eYv0DKUBjTQ9OLxzMiVy2zCW2yelSMatH0d0ulzrBhuImIj39emM6gqFst5L6/e3JyWb1OV+LjRs7cGaqeJDF5CYmXc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vmoJpG9m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d6Ln3qGn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710782875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+tMsuxvlJH22JA6DrPUeQjaSBT/j9Gn1+cJU6UVla34=;
	b=vmoJpG9mCLFrTTR+qEyUewJQFa5E3yXC0uWs70LIjdCfxvJpC+rqGFHCBWyCoOMwJ6qHbL
	/b5wi+gSMHA3/wbr0ki8hAeDK0NsKNPOF1vIyupudW/iGSLeuK+S+uDkySTkEnwQotLOvT
	BFBK06ARHvSBS2IPpnCrSay8m4wT0FpGBvDt7ucT2TRiEMu+gK9rgQCY3zWfl3OuU5r4/w
	0E7k5BVtmigXrjZqTT5uLmOSbCiGD9U0j3FHwYBuiz+Ulc6H72LN2PHRMJ37um5mvruqAx
	43disVF5eAD5ITyD4QO93qQtgGQGZ+X5FDjd3KQCvNLM28lhOfhcAlhYLkUhCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710782875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+tMsuxvlJH22JA6DrPUeQjaSBT/j9Gn1+cJU6UVla34=;
	b=d6Ln3qGn6X1/GCxMeZB/182iIN5DU9cXjm+4+paBZgykXjYS3T1ClKTts0QVqJGrkLNgkL
	rfTi+FP+zCfgGFBw==
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>,
 x86@kernel.org, Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org, lkp@intel.com,
 oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
In-Reply-To: <877ci3j80k.ffs@tglx>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
 <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
 <877ci3j80k.ffs@tglx>
Date: Mon, 18 Mar 2024 18:27:55 +0100
Message-ID: <87le6fih5w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 16 2024 at 02:11, Thomas Gleixner wrote:
> On Fri, Mar 15 2024 at 16:23, Linus Torvalds wrote:
> The amount of subtle SMP=n fallout has been kinda exponentially
> increasing over the years and it's just putting burden on the wrong
> people. TBH, I'm tired of this nonsense.

And for the fun of it I hacked Kconfig to allow a SMP=y NR_CPUS=1 build
and checked the size of vmlinux:

                64-bit          32-bit
SMP, NCPUS=1    38438400        22110177
UP              38393703        21682041
Delta              44697          428076
                     0.1%              2%              

The UP savings are not really impressive...

Let me look what it actually takes to do that.

Thanks,

        tglx



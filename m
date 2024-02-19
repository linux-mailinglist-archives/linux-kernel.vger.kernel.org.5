Return-Path: <linux-kernel+bounces-72130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C9285AFC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5158DB2180B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062C56759;
	Mon, 19 Feb 2024 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="v9ptvqRu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368F56448
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708385317; cv=none; b=cXECXtHE1ZpXyNiuStjL3CBcP2BQnYm3urf/TW4Mjzhi6cvEpfIj8Vhc5mwPPnzpLvcQHWTKsc2kKdXWb2Gp0l1gv1ZhzxeaPTTYzpww3uYgD9TBB8+FQzVl5+rd4n3RwGchE6XcL3YoyMi3qWueotno0424CT4nAb38RkAeSs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708385317; c=relaxed/simple;
	bh=D/cO9LP1pgvPGg45aa5rjEQ2Z+xeQx9ZwyCMV1n4GMo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Zv5DhjYSziROJMG5QSmhnlzXPmh1vttm9wVPGkzIfL+Z/o0eb2be6Al/+g7cjw33Wi2qv33QuBATDn8RxziUbu5vHNtfTMe21kzINf8YHg7znRkKDrOoKp4irbhg+cycqQ7+pmqdNxtYDrrXT3TTsxZRWnM6+dH7uRZPVyxPsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=v9ptvqRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37C7C433F1;
	Mon, 19 Feb 2024 23:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708385317;
	bh=D/cO9LP1pgvPGg45aa5rjEQ2Z+xeQx9ZwyCMV1n4GMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=v9ptvqRuWoXWMVPNzEkXH2C0FIQ4s7jifgEfZOyc4JV28DRLHWLnpyY4Nrl8PvHxB
	 oqFsheI2HmJxA8B/vBgQzTZMC+kdLppJoGnjHvBHUC2EMcLsiQx0gpxYwLqvc3ygAk
	 em3IBe6v4BtXcFtIEodCW1lRQROoeZuP/5X0N1KM=
Date: Mon, 19 Feb 2024 15:28:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Marco Elver <elver@google.com>, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 glider@google.com, dvyukov@google.com, eugenis@google.com, Oscar Salvador
 <osalvador@suse.de>, Linux List Kernel Mailing
 <linux-kernel@vger.kernel.org>, Linux Memory Management List
 <linux-mm@kvack.org>
Subject: Re: regression/bisected commit
 773688a6cb24b0b3c2ba40354d883348a2befa38 make my system completely unusable
 under high load
Message-Id: <20240219152836.11d36709c594e66fe3037f2d@linux-foundation.org>
In-Reply-To: <91c50335-e7b6-4ae1-9dad-a0c990b52021@suse.cz>
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
	<CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
	<CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com>
	<CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com>
	<CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
	<CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
	<CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com>
	<CABXGCsM9BSD+SYFkvkYxmcrZL+aUfUb_M-rjNJhzb2cYHQr5ww@mail.gmail.com>
	<CANpmjNNXKiM0j4mR-Rr2KALhgz87=QjCOomEymNMWjtos=Z3Ug@mail.gmail.com>
	<CANpmjNOnbNw2fRL3_depaAgt81p-VpHh5_O_26kyxofjECgsFQ@mail.gmail.com>
	<CABXGCsPB-KEbE+SfymVmqfiomFVngFL2Je81Qyhw1F5_aZX-TQ@mail.gmail.com>
	<CABXGCsO5dcEuorLAXR3CFzDVyAWNk4_YfqCh=UJddfzpWF7hNg@mail.gmail.com>
	<CANpmjNPsdM2HrRFgEHYxX1seT2fbOFDuO6Ci-qF3X2y=9_PD1A@mail.gmail.com>
	<91c50335-e7b6-4ae1-9dad-a0c990b52021@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 19 Feb 2024 11:09:23 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 2/19/24 10:52, Marco Elver wrote:
> > On Mon, 19 Feb 2024 at 10:48, Mikhail Gavrilov
> > <mikhail.v.gavrilov@gmail.com> wrote:
> >>
> >> On Sat, Feb 3, 2024 at 1:14 AM Mikhail Gavrilov
> >> <mikhail.v.gavrilov@gmail.com> wrote:
> >> >
> >> > You are right.
> >> > Thanks for digging into it!
> >> >
> >>
> >> This [2] revert is still not merged at least I checked on 4f5e5092fdbf.
> >> Is there any plan to merge it or find another approach?
> >>
> >> [2] https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.com/
> > 
> > I think it's already in -mm and -next. It just takes time, which is a
> > good thing, after all we want to let -next testing confirm nothing is
> > wrong with it.
> > 
> > Andrew, is this planned for the next merge window or as a "hot fix"
> > for the current rc? Given it has the right "Fixes" tags it will make
> > it to stable kernels eventually, but I also think that the previous
> > "slow" version is almost unusable on big systems, so it may be
> > worthwhile considering the current rc.
> 
> Yeah it would be best to fix in 6.8 to prevent regressions.
> 

I'm all confused.

4434a56ec209 ("stackdepot: make fast paths lock-less again") was
mainlined for v6.8-rc3.

That patch Fixed: 108be8def46e ("lib/stackdepot: allow users to evict
stack traces") which was mainlined for v6.8-rc1, so 4434a56ec209 did
not need a cc:stable?



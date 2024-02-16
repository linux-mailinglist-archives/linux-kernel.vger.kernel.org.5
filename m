Return-Path: <linux-kernel+bounces-68471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53218857AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D5928616D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD45381A;
	Fri, 16 Feb 2024 10:52:03 +0000 (UTC)
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259AA1EA73
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080723; cv=none; b=udXs/T4tzRPCLLQdff25TjcyDEwcKJXp91Zl0rBPBpT14MWZ+uw53W5cv+ZExbWXmTQOC213vhxK3uu98I1iB0yS+rWNcbt+ME9IDnVH19RA6xHfJv6qacYkGBuKy4IXPh0eTd9WVKIWjIWuXx5y+POp2m2d6yq+qOC2Th6emf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080723; c=relaxed/simple;
	bh=abbIf03lUcClSEJqyuzm6ITM51kb8SzCiL98v7qTETU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/K70l58l/ENo1d1xpo5AoSe1VRU2wdq0MZcxZgNkjjO6wUJcwlw8uUtEUuxpPL3yLGD3etIiH9mBRj0OysYdrwPfHhzWCu2+JQwf187ir9pcUcEVUrW6JxDE+iqbMfo0Ax7z+pIPc21ICHnCsofC6dyK3piF8+qhzU5DV8xp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.24) with ESMTP
	id 65CF3E4300004350; Fri, 16 Feb 2024 18:51:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8475961048607
X-SMAIL-UIID: 47A789C0333140E1AF36F219A4107BDB-20240216-185149-1
From: Hillf Danton <hdanton@sina.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sven van Ashbrook <svenva@chromium.org>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-sound@vger.kernel.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
Date: Fri, 16 Feb 2024 18:51:35 +0800
Message-ID: <20240216105137.1242-1-hdanton@sina.com>
In-Reply-To: <87plwwiz6z.wl-tiwai@suse.de>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid> <20240215034528.240-1-hdanton@sina.com> <87h6iaf7di.wl-tiwai@suse.de> <CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com> <875xypk6d6.wl-tiwai@suse.de> <20240216043426.1218-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Feb 2024 09:35:32 +0100 Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 16 Feb 2024 05:34:24 +0100, Hillf Danton wrote:
> > On Thu, 15 Feb 2024 18:03:01 +0100 Takashi Iwai <tiwai@suse.de> wrote:
> > > So it sounds like that we should go back for __GFP_NORETRY in general
> > > for non-zero order allocations, not only the call you changed, as
> > > __GFP_RETRY_MAYFAIL doesn't guarantee the stuck.
> > > 
> > > How about the changes like below?
> > > 
> > > +/* default GFP bits for our allocations */
> > > +static gfp_t default_gfp(size_t size)
> > > +{
> > > +	/* don't allocate intensively for high-order pages */
> > > +	if (size > PAGE_SIZE)
> > > +		return GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY;
> > > +	else
> > > +		return GFP_KERNEL | __GFP_NOWARN | __GFP_RETRY_MAYFAIL;
> > > +}
> > 
> > Looks like an overdose because both __GFP_NORETRY and __GFP_RETRY_MAYFAIL
> > are checked in __alloc_pages_slowpath().
> 
> If the check there worked as expected, this shouldn't have been a
> problem, no?
> 
> The fact that we have to drop __GFP_RETRY_MAYFAIL indicates that the
> handling there doesn't suffice -- at least for the audio operation.

Dropping the retry gfp flag makes no sense without checking fallback in
sound allocation context in this thread, nor checking it without checking
the costly order in the page allocator.
OTOH page allocator will never work in every corner case particularly
where perfermance/response is expected given insanely heavy fragmentation
background.
Fragmentation [1] is not anything new, nor is it a cure to fiddle with a
couple flags.

[1] https://lore.kernel.org/lkml/20230418191313.268131-1-hannes@cmpxchg.org/


Return-Path: <linux-kernel+bounces-73445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8787785C2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411802846B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2576C9F;
	Tue, 20 Feb 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gJ/wHYZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C976C73
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450213; cv=none; b=VKBq28c47/DxrTFg1CC2voX5aB16BMala9dW1YzG8IxO+Am9wzTyuey/oUgKPJoJtW63dgcJeVTdMTkWX3BrR1F/vh6WOjZVk5G6IBsI5yc1DcAnYdX5065M2l8xHLpetTFuN4sj96LYGTmWSIynRDsE5/8J9QHXUYgpcl/Og6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450213; c=relaxed/simple;
	bh=k0FMmgNfs9nu8uShyqiykMfJCdKkwJauPu/9+oGhm/4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cEcZzhQ050MKPyiLMVwVTZ5G71qXX6c9fRKSczVX9buKD4cweT+P1FlJp1hRBqvRgMQPpvTN1DeMJ92snlbusK9Kq2/iuDFrwQ6zc4PPMVRi5JRbcsokuJgQOTioQx7UT7tG5g38vVOxETdVc+TMsmesfDog41gXNVenRnax5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gJ/wHYZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978A9C43390;
	Tue, 20 Feb 2024 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708450212;
	bh=k0FMmgNfs9nu8uShyqiykMfJCdKkwJauPu/9+oGhm/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gJ/wHYZWmjAnsS3He+umgyBGh3lXE7LqBO2wQar2CpQwcIZcUos0uNYS0uKR8dHok
	 l8oFMHm+egBkXULKDCa4uSFIEMkZN0ggf+as2JbayPk8eKMwiz3gILYnOZDwxxIzMR
	 9v1ALjYE+dDKjU6VWh3A7XyQWA/rhUe1Da4qLrdE=
Date: Tue, 20 Feb 2024 09:30:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>, Andrey
 Konovalov <andreyknvl@gmail.com>, glider@google.com, dvyukov@google.com,
 eugenis@google.com, Oscar Salvador <osalvador@suse.de>, Linux List Kernel
 Mailing <linux-kernel@vger.kernel.org>, Linux Memory Management List
 <linux-mm@kvack.org>
Subject: Re: regression/bisected commit
 773688a6cb24b0b3c2ba40354d883348a2befa38 make my system completely unusable
 under high load
Message-Id: <20240220093011.bf84486d704c3814079c2aa0@linux-foundation.org>
In-Reply-To: <CABXGCsOHswLa5rd_Q7kHDHESb=BtqB+F=LV7Wvv+qoRxrqCboA@mail.gmail.com>
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
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
	<20240219152836.11d36709c594e66fe3037f2d@linux-foundation.org>
	<7e31accb-db01-486f-afb8-18a3f5402d00@suse.cz>
	<CABXGCsOHswLa5rd_Q7kHDHESb=BtqB+F=LV7Wvv+qoRxrqCboA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 10:37:03 +0500 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> wrote:

> On Tue, Feb 20, 2024 at 4:50 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >
> > > I'm all confused.
> > >
> > > 4434a56ec209 ("stackdepot: make fast paths lock-less again") was
> > > mainlined for v6.8-rc3.
> >
> > Uh sorry, I just trusted the info that it's not merged and didn't verify
> > it myself. Yeah, I can see it is there.
> >
> 
> Wait, I am talk about these two patches which is not merged yet:
> [PATCH v2 1/2] stackdepot: use variable size records for non-evictable entries
> [PATCH v2 2/2] kasan: revert eviction of stack traces in generic mode
> https://lore.kernel.org/linux-mm/20240129100708.39460-1-elver@google.com/

A can move those into the 6.8-rc hotfixes queue, and it appears a
cc:stable will not be required.

However I'm not seeing anything in the changelogs to indicate that
we're fixing a dramatic performance regression, nor why that
regressions is occurring.



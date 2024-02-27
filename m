Return-Path: <linux-kernel+bounces-82936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B7868BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8533284960
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29DA136647;
	Tue, 27 Feb 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oAPOt3Uo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9227135A77;
	Tue, 27 Feb 2024 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025340; cv=none; b=YS8Mwhb1DTX/MvAt2aJuxKtUup5sF0zVOutvxICzRNqX9qfEoeh0civR0M/aGtZn4e8VyfdC6LoikmG2eOILSXrJRLjeqSLzQhQZisJGfIfYBUBVrsqlK8gcIxEMKGTpWFLFkRafvpgnkZU3G+UO5/u6WIi0ba/8aZVsoDhYxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025340; c=relaxed/simple;
	bh=d6n/XiSO0cqCTIB38U7027rr36u9/kKHZKWwKIAn5f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjyPmmS/zdtMhMXiqGEPD94O82wGcavUXYFNs0jetR8xRGMbpwHugyPKZKcqHhKT5NNjcf9groEXj35gYyhyfifOy/jjP7HEuHgjy9lsG7saV+/AKyxsqd0LKv2ZAxlOm0ma7+uyT9NRnS2dSmqDuQGkKnzz5fln9Vpkq+5Vo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oAPOt3Uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D64C433F1;
	Tue, 27 Feb 2024 09:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709025339;
	bh=d6n/XiSO0cqCTIB38U7027rr36u9/kKHZKWwKIAn5f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oAPOt3UosWKHdRV2DfFQKDnaqshe2zGhBOK9awT/1gZAwyb5dub6FgRg+tb0VQpsX
	 zeeqh/6SHrGlGh0Gg3Wmw0iQPGBBIiZD1Z/NRpO2BG8XaliI43ICg8h7zCrxEavDE0
	 8DeKrPDG+uo32HXHWDLyIXCu3kdyNJSsq2qx2KeU=
Date: Tue, 27 Feb 2024 10:15:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, rafael@kernel.org,
	pavel@ucw.cz, len.brown@intel.com,
	andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
	james@equiv.tech, broonie@kernel.org, james.clark@arm.com,
	masahiroy@kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
Message-ID: <2024022749-campus-multiply-d657@gregkh>
References: <20240223143833.1509961-1-guanyulin@google.com>
 <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com>
 <CAOuDEK3wP6zhEwgUn5zSedtwTYVFaJeBfeXkSg897EhpGP9=ig@mail.gmail.com>
 <3208c5b9-5286-48d1-81ab-cc3b2bc4303e@gmail.com>
 <CAOuDEK39Bdru5wAbxW-g2c=POgRxZwdQzPO5uNXP96AfSyA6pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuDEK39Bdru5wAbxW-g2c=POgRxZwdQzPO5uNXP96AfSyA6pw@mail.gmail.com>

On Tue, Feb 27, 2024 at 04:56:00PM +0800, Guan-Yu Lin wrote:
> On Tue, Feb 27, 2024 at 2:40 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 2/26/24 02:28, Guan-Yu Lin wrote:
> > > On Sat, Feb 24, 2024 at 2:20 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >>
> > >> On 2/23/24 06:38, Guan-Yu Lin wrote:
> > >>> In systems with a main processor and a co-processor, asynchronous
> > >>> controller management can lead to conflicts.  One example is the main
> > >>> processor attempting to suspend a device while the co-processor is
> > >>> actively using it. To address this, we introduce a new sysfs entry
> > >>> called "conditional_skip". This entry allows the system to selectively
> > >>> skip certain device power management state transitions. To use this
> > >>> feature, set the value in "conditional_skip" to indicate the type of
> > >>> state transition you want to avoid.  Please review /Documentation/ABI/
> > >>> testing/sysfs-devices-power for more detailed information.
> > >>
> > >> This looks like a poor way of dealing with a lack of adequate resource
> > >> tracking from Linux on behalf of the co-processor(s) and I really do not
> > >> understand how someone is supposed to use that in a way that works.
> > >>
> > >> Cannot you use a HW maintained spinlock between your host processor and
> > >> the co-processor such that they can each claim exclusive access to the
> > >> hardware and you can busy-wait until one or the other is done using the
> > >> device? How is your partitioning between host processor owned blocks and
> > >> co-processor(s) owned blocks? Is it static or is it dynamic?
> > >> --
> > >> Florian
> > >>
> > >
> > > This patch enables devices to selectively participate in system power
> > > transitions. This is crucial when multiple processors, managed by
> > > different operating system kernels, share the same controller. One
> > > processor shouldn't enforce the same power transition procedures on
> > > the controller – another processor might be using it at that moment.
> > > While a spinlock is necessary for synchronizing controller access, we
> > > still need to add the flexibility to dynamically customize power
> > > transition behavior for each device. And that's what this patch is
> > > trying to do.
> > > In our use case, the host processor and co-processor are managed by
> > > separate operating system kernels. This arrangement is static.
> >
> > OK, so now the question is whether the peripheral is entirely visible to
> > Linux, or is it entirely owned by the co-processor, or is there a
> > combination of both and the usage of the said device driver is dynamic
> > between Linux and your co-processor?
> >
> > A sysfs entry does not seem like the appropriate way to described which
> > states need to be skipped and which ones can remain under control of
> > Linux, you would have to use your firmware's description for that (ACPI,
> > Device Tree, etc.) such that you have a more comprehensive solution that
> > can span a bigger scope.
> > --
> > Florian
> >
> 
> We anticipate that control of the peripheral (e.g., controller) will
> be shared between operating system kernels. Each kernel will need its
> own driver for peripheral communication. To accommodate different
> tasks, the operating system managing the peripheral can change
> dynamically at runtime.

That sounds like a nightmare of control and handling, how are you going
to do any of that?  Where is the code for that?

> We dynamically select the operating system kernel controlling the
> target peripheral based on the task at hand, which looks more like a
> software behavior rather than hardware behavior to me. I agree that we
> might need a firmware description for "whether another operating
> system exists for this peripheral", but we also need to store the
> information about "whether another operating system is actively using
> this peripheral". To me, the latter one looks more like a sysfs entry
> rather than a firmware description as it's not determined statically.

So you want to download different firmware to the device depending on
"something".  What is going to control that "something"?  Is that coming
from the kernel, or from userspace?  If userspace, why is any of this an
issue and just load whatever firmware you decide at that point in time?
Why does the kernel care?

confused,

greg k-h


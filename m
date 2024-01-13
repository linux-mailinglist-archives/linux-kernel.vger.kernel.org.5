Return-Path: <linux-kernel+bounces-25343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1650E82CE03
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B982C1F222D8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661AA5678;
	Sat, 13 Jan 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le3Wx2T/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2815663;
	Sat, 13 Jan 2024 17:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8C8C433C7;
	Sat, 13 Jan 2024 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705167997;
	bh=0aCEhZFZIhna+PX3Z+MkI3nkB05GmNoXnwGBZrWka8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=le3Wx2T/O/pRlZfxR/qYM0M0IBrHkfmIZLEgmSzK6YDuaoJ+7gzL2eQ4EwrtNSC9v
	 6gvwGrsFyYd3OWK5bWyL9K4/miSlwf+U5T0JbZGNudFHYym+cqExYreMozkCKOcWtv
	 /bSwUYbZimmBvwzxuwY/p1PvCxFm37FgNRJC4tN4zbAXnlpsFvIZanUG8BjG3lRt2G
	 0hzixJiO/tmfeiu578B40n7idViC9A37Z+mJ6qw5HkNdtN20pG67eLrDFtlP9OqAue
	 C8LkWxgIZ5iHyt/VErYLoRMvp0mcim0OfvENjzD6paVaZwLn2PN+7zU58z+bYe6+cN
	 8mMQJgFyI9CWg==
Date: Sat, 13 Jan 2024 17:46:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jagath Jog J <jagathjog1996@gmail.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Subject: Re: iio: iio-trig-hrtimer bug on suspend/resume when used with
 bmi160 and bmi323
Message-ID: <20240113174351.47a20239@jic23-huawei>
In-Reply-To: <31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com>
References: <31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 23:35:01 +0100
Denis Benato <benato.denis96@gmail.com> wrote:

> Hello,
> 
> With this mail I am submitting bug report that is probably related to
> iio-trig-hrtimer but there is also the possibility for it to be
> specific to bmi160 and bmi323.
> 
> The described problem have been reproduced on my handheld PC (Asus
> RC71L) and in another handheld PC with two different gyroscope
> drivers: bmi323 (backported by me on v6.7, on RC71L) and bmi160.
> 
> My target hardware (RC71L that yeld to this discovery) has a bmi323
> chip that does not have any interrupt pins reaching the CPU, yet I
> need to fetch periodically data from said device, therefore I used
> iio-trig-hrtimer: created a trigger, set the device and trigger
> sampling frequencies, bound the trigger to the device and enabled
> buffer: data is being read and available over /dev/iio:device0.
> 
> While in this state if I suspend my handheld I receive (from dmesg)
> the warning reported below and at resume data is not coming out of
> the iio device and the hrtimer appears to not be working. If I create
> a new trigger and bind the new trigger to said iio device and
> re-enable buffer data does come out of /dev/iio:device0 once more,
> until the next sleep.
> 
> Since this is important to me I have taken the time to look at both
> drivers and iio-trig-hrtimer and I have identified three possible
> reasons:
> 
> 1) iio-trig-hrtimer won't work after suspend regardless of how it is
> used (this is what I believe is the cause)
me too.

> 2) iio-trig-hrtimer is stopped by the -ESHTDOWN returned by the
> function printing "Transfer while suspended", however that stack
> trace does not include function calls related to iio-trig-hrtimer and
> this seems less plausible 3) bmi160 and bmi323 appears to be similar
> and maybe are sharing a common bug with suspend (this is also why I
> have maintainers of those drivers in the recipient list)
> 
> Thanks for your time, patience and understanding,

Hi Denis,

I suspect this is the legacy of the platform I used to test the hrtimer
and similar triggers on never had working suspend and resume (we ripped
support for that board out of the kernel a while back now...)
Hence those paths were never tested by me and others may not have cared
about this particular case.

Anyhow, so I think what is going on is fairly simple.

There is no way for a driver to indicate to a trigger provided by a separate
module / hardware device that it should stop triggering data capture.
The driver in question doesn't block data capture when suspended, which
would be easy enough to add but doesn't feel like the right solution.

So my initial thought is that we should add suspend and resume callbacks to
iio_trigger_ops and call them manually from iio device drivers in their
suspend and resume callbacks.  These would simply pause whatever the
trigger source was so that no attempts are made to trigger the use of
the device when it is suspended.

It gets a little messy though as triggers can be shared between
multiple devices so we'd need to reference count suspend and resume
for the trigger to make sure we only resume once all consumers of
the trigger have said they are ready to cope with triggers again.

As mentioned, the alternative would be to block the triggers at ingress
to the bmi323 and bmi160 drivers.  There may be a helpful pm flag that could
be used but if not, then setting an is_suspended flag under the data->mutex
to avoid races. and reading it in the trigger_handler to decide whether
to talk to the device should work.

I'd kind of like the generic solution of actually letting the trigger
know, but not sure how much work it would turn out to be.  Either way there
are a lot of drivers to fix this problem in as in theory most triggers can
be used with most drivers that support buffered data capture.
There may also be fun corners where a hardware trigger from one IIO
device A is being used by another B and the suspend timing is such that B
finishing with the trigger results in A taking an action (in the try_reenable
callback) that could result in bus traffic.
That one is going to be much more fiddly to handle than the simpler case
you have run into.

Thanks for the detailed bug report btw.   To get it fixed a few
questions:
1) Are you happy to test proposed fixes?
2) Do you want to have a go at fixing it yourself? (I'd suggest trying
   the fix in the bmi323 driver first rather than looking at the other 
   solution)
   If we eventually implement the more general version, then a bmi323
   additional protection against this problem would not be a problem.

Clearly I'd like the answers to be yes to both questions, but up to you!

Jonathan




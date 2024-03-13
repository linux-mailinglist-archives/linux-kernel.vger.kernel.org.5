Return-Path: <linux-kernel+bounces-102345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939DB87B105
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052931F25AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F346E612;
	Wed, 13 Mar 2024 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K5lk+tMh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573306E5F8;
	Wed, 13 Mar 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353926; cv=none; b=LRsCXmMsrYRDuUu/D6pk2iBVr4xurarmvEk2PM8Vh3YIoyofVzxxo3CYGsyxgeOZ8FgH3/86QLKbQVIpNbWex0oqJA/DDXQy3bsOntWgWXESf0N9wtOD5XQA+GqjZsezXGJSkF/dDXQY1Kg1zbhSncCBWzBCDNaw6EM5JumjZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353926; c=relaxed/simple;
	bh=j4RkNzplLs9576Ucdv2wSRJ6anZyubu7F7JHevpn1lw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=V92iaEZyPCVHqsXEVedNe5E19iOpNYrasWCcjuG0QfpQ1djKzv+ntlAJDVcxp3NI0/lpOtvdvIWIDTxq0y2JcLIOl3iocR9l8Gw2nNlBqwMebvSYNjTFSlTImCi4Iygbhy8UfVQnIJQgbM8GkYzsNC9CkIDvV2gxrZcp9Uylcz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K5lk+tMh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=5+MK1q3QTmns8nfY5HZNCopdbKSZ21Tc/bjtiTp4oRc=; b=K5lk+tMhwdeSzTuJ8d27O76dee
	LV/ZWfmzaCs4Yd+dKhKZcaeWJhSopVXbW12MHQMbAf5n4Z/8fzhoC3B4ytSmOwv/neZhIFyo6UyU7
	lZfx3ZslUF/66yof/vxBqwaCGoHxIKvTznoGFJ++ui2YqcNV4cvTydHbD67YMZors0DbKNNm7m91N
	q2mZ5qO4G4IZD8Ib54JbbOAg1kMaO7wcm8iR/d6oDABlDQKAgcnLhWE0CZxGUjw/Y8RDj3XHW/K86
	Upi76UdV7rw8Dl6aSCwOSYbkFJOdRbmaoEgZ0+NwwZokgN4tOR1Z8b7g+KWydqaxV2C0W5H1XITGQ
	i3GwRkYQ==;
Received: from [2a00:23ee:1400:c5e0:79a9:c9e8:9823:feca] (helo=[IPv6:::1])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkTBS-00000005yG2-1ztJ;
	Wed, 13 Mar 2024 18:18:37 +0000
Date: Wed, 13 Mar 2024 18:18:31 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Peter Hilber <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, virtio-dev@lists.oasis-open.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
CC: "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "Ridoux, Julien" <ridouxj@amazon.com>
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
User-Agent: K-9 Mail for Android
In-Reply-To: <60607bcc-93c5-4a6f-832d-ea4dbd81178e@opensynergy.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com> <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org> <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com> <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org> <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com> <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org> <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com> <47bf0757de3268c420d2cd3bbffaf5897b67b661.camel@infradead.org> <60607bcc-93c5-4a6f-832d-ea4dbd81178e@opensynergy.com>
Message-ID: <89268C36-E8FB-4A17-8F81-1DED4BF47400@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

On 13 March 2024 17:50:48 GMT, Peter Hilber <peter=2Ehilber@opensynergy=2Ec=
om> wrote:
>On 13=2E03=2E24 13:45, David Woodhouse wrote:
>> Surely the whole point of this effort is to provide guests with precise
>> and *unambiguous* knowledge of what the time is?=20
>
>I would say, a fundamental point of this effort is to enable such
>implementations, and to detect if a device is promising to support this=
=2E
>
>Where we might differ is as to whether the Virtio clock *for every
>implementation* has to be *continuously* accurate w=2Er=2Et=2E a time sta=
ndard,
>or whether *for some implementations* it could be enough that all guests =
in
>the local system have the same, precise local notion of time, which might
>be off from the actual time standard=2E

That makes sense, but remember I don't just want {X, Y, Z} but *also* the =
error bounds of =C2=B1deltaY and =C2=B1deltaZ too=2E

So your example just boils down to "I'm calling it UTC, and it's really pr=
ecise, but we make no promises about its *accuracy*"=2E And that's fine=2E

>Also, cf=2E ptp_kvm, which AFAIU doesn't address leap seconds at all=2E=
=2E=2E

KVM is not an exemplar of good time practices=2E=20
Not in *any* respect :)

>With your described use case the UTC_SMEARED clock should of course not b=
e
>used=2E The UTC_SMEARED clock would get a distinct name through udev, lik=
e
>/dev/ptp_virtio_utc_smeared, so the incompatibility could at least be
>detected=2E

As long as it's clear to all concerned that this is fundamentally not usab=
le as an accurate time source, and is only for the local-sync case you desc=
ribed, sure=2E

>> Using UTC is bad enough, because for a UTC timestamp in the middle of a
>> leap second the guest can't know know *which* occurrence of that leap
>> second it is, so it might be wrong by a second=2E To resolve that
>> ambiguity needs a leap indicator and/or tai_offset field=2E
>
>I agree that virtio-rtc should communicate this=2E The question is, what
>exactly, and for which clock read request?

Are we now conflating software architecture (and Linux in particular) with=
 "hardware" design?

To a certain extent, as long as the virtio-rtc device is designed to expos=
e time precisely and unambiguously, it's less important if the Linux kernel=
 *today* can use that=2E Although of course we should strive for that=2E Le=
t's be=2E=2E=2Ewell, *unambiguous*, I suppose=2E=2E=2E that we've changed t=
opics to discuss that though=2E

>As for PTP clocks:
>
>- It doesn't fit into the ioctl PTP_SYS_OFFSET_PRECISE2=2E
>
>- The clock_adjtime(2) tai_offset and return value could be set (if
>  upstream will accept this)=2E Would this help? As discussed, user space
>  would need to interpret this (and currently no dynamic POSIX clock sets
>  this)=2E

Hm, maybe?


>>> I think I can add a SHOULD requirement which vaguely refers to vCPU 0,=
 or
>>> boot vCPU=2E But the Virtio device is not necessarily hosted by a hype=
rvisor,
>>> so the device might not even know which vCPUs there are=2E E=2Eg=2E th=
ere is even
>>> interest to make virtio-rtc work as part of the virtio-net device (whi=
ch
>>> might be implemented in hardware)=2E
>>=20
>> Sure, but those implementations aren't going to offer the TSC pairing
>> at all, are they?
>>=20
>
>They could offer an Intel ART pairing (some physical PTP NICs are already
>doing this, look for the convert_art_to_tsc() users)=2E

Right, but isn't that software's problem? The time pairing is defined agai=
nst the ART in that case=2E


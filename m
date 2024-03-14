Return-Path: <linux-kernel+bounces-103379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE6E87BEC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8539A286CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558D170CAF;
	Thu, 14 Mar 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dLRdWswQ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D646FE25;
	Thu, 14 Mar 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426005; cv=none; b=P5VJIsMh7CT8qeYi1K4msLLFxUHOVmKFisirj0qBdgSiygUXaldVNB65d+k2En4g/D7VbXuriAbynpmTJpy+DtTGtXSp5cMsXjM+eGq7FhIF3yLq5kNv4NQMuBCByy8rJ/sDcRGzWCADNAZQfFoVxwPx02rHSpDmTg0eX1mzeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426005; c=relaxed/simple;
	bh=4H7LF9xic1h2s2SK9pUmAgHDyT+hWOLMRCNt/9GcopY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OSzFzajXpESF+4xTt6nfLcuTvNZM98q5TGJ4DpT+cJ6uy75605MuY39vq6BXIIF/yAu7oEZ4a4OhxugzjJ4kg6ORAcOBAU0arO4G/37NZ56Qpwk7RtCIRJTCDmZZPcGjGf7VomMVKotvjSnpRusFH3OnpYsEROVhZ39qTgElXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dLRdWswQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4H7LF9xic1h2s2SK9pUmAgHDyT+hWOLMRCNt/9GcopY=; b=dLRdWswQiOdn/5ZfCwgv+BcmnZ
	MavcWDrKg+fI81HsMu1+QsmlnIPBKDANlNkB1KR5EtJ7BO4z1u7IGaG0yIysccG2EtBhhZFhThz3F
	IjOB5V9ptVMAEh/B2txmxf7iJMxnurWe5ZcTpmRCm5PxOB+KGvLb6+KAYa3FPrnSjsUPHj5OEFpf9
	7p36zwfWH/TwxECdok37fgJcWCNOjENsB7Jh67Vh7cG27X6nZ0qiJI4IlBiOB18pSh81SmGqedsVV
	Ee6cSi8b46TNWHIWEahZFqqzWgpZxovQjtef2HiEJHR9WXDFHhGxCGFgdWopQey/+57vXQy7TZ+ss
	gfMsib9g==;
Received: from [31.94.26.231] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rklw3-0000000AW6m-201T;
	Thu, 14 Mar 2024 14:19:56 +0000
Date: Thu, 14 Mar 2024 15:19:53 +0100
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
 "Ridoux, Julien" <ridouxj@amazon.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
User-Agent: K-9 Mail for Android
In-Reply-To: <2eb5a616-eeb3-446a-85fd-fff376c15f55@opensynergy.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com> <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org> <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com> <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org> <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com> <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org> <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com> <47bf0757de3268c420d2cd3bbffaf5897b67b661.camel@infradead.org> <60607bcc-93c5-4a6f-832d-ea4dbd81178e@opensynergy.com> <89268C36-E8FB-4A17-8F81-1DED4BF47400@infradead.org> <2eb5a616-eeb3-446a-85fd-fff376c15f55@opensynergy.com>
Message-ID: <9455F710-E38C-45DA-9883-EC034495ADEF@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 14 March 2024 11:13:37 CET, Peter Hilber <peter=2Ehilber@opensynergy=2Ec=
om> wrote:
>> To a certain extent, as long as the virtio-rtc device is designed to ex=
pose time precisely and unambiguously, it's less important if the Linux ker=
nel *today* can use that=2E Although of course we should strive for that=2E=
 Let's be=2E=2E=2Ewell, *unambiguous*, I suppose=2E=2E=2E that we've change=
d topics to discuss that though=2E
>>=20
>
>As Virtio is extensible (unlike hardware), my approach is to mostly speci=
fy
>only what also has a PoC user and a use case=2E

If we get memory-mapped (X, Y, Z, =C2=B1x, =C2=B1y) I'll have a user and a=
 use case on day one=2E Otherwise, as I said in my first response, I can go=
 do that as a separate device and decide that virtio_rtc doesn't meet our n=
eeds (especially for maintaining accuracy over LM)=2E

My main concern for virto_rtc is that we avoid *ambiguity*=2E Yes, I get t=
hat it's extensible but we don't want a v1=2E0 of the spec, implemented by =
various hypervisors, which still leaves guests not knowing what the actual =
time is=2E That would not be good=2E And even UTC without a leap second ind=
icator has that problem=2E


Return-Path: <linux-kernel+bounces-36110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34983839BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6632F1C24C32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126B4F88F;
	Tue, 23 Jan 2024 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EYCKNGPE"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C0D4F5FD;
	Tue, 23 Jan 2024 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047547; cv=none; b=qghYvUW/709f/nR0IGR5sIg6J4qawHQCXITDEpJu24tlJXDVPuaTHyGxvfPZUMDijcv0QHdtMpVEJv1H962iAOYQnxbKMd+brKoJk8x34iY0AJoGJmDsCyFUbvE/SzVKqCHTCvHKC1INlYvkKUc7J95UPLJy5TcbSwK0gEIBFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047547; c=relaxed/simple;
	bh=MntEIl33BbwzmYFNhMkgC2vX3QF+6CNeWuSo21tZvWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k/LLWq+WFXxLfT8AmbuKqi3wBkX6IPzvrcHj25ueA+8aWW7sKqPjyWbRnGnS7TXGx9hHq7hnXPNNsPVGzKGTkE0exodgOu4SxeVJtL6UIFr1KqfihzjOapgIho1Xr9Hi1xd1YIyH8MqRDIUb4XoDlN63fqfngxxux4VuZPPPgHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EYCKNGPE; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (c-98-53-138-11.hsd1.co.comcast.net [98.53.138.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 985127ABF;
	Tue, 23 Jan 2024 22:05:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 985127ABF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706047542; bh=AWWL4iYA+MZqL21ji1WtCk6P5p3u03ID/E92YUVOgO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EYCKNGPEAwo/Qk8IwS7+VpYCVc3Hr65d3C0czS27DE4do1pl9IyQYQgQKfI4KUWn2
	 8Ylazh4Pl4QutIaaKlpZ4DLaa77l3p0akGgJlZxEMVqPqHRe+sHemVyGZD/isxjtyb
	 cfFxNG/+Z7N25TTt+/ZyhXpS9t8pv4o3gEJZWvgHtM3hJOx04cPa5LsY7vtlezH+8/
	 p2I/WkaIQj3d+RsBf5QO2bVYi7wehzOVlYW5rQN92qe/ilKONZXOpza/NxokpEbc5v
	 +e18niA3NW5a2oS50ib2ogThj7yiO2WqTOARmPDh7E28ecz++NIGGjf0/TPiJ6Mjcr
	 CLiTy1k4sCnYQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Johannes Berg <johannes@sipsolutions.net>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, Mike Rapoport
 <rppt@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, Marco Elver <elver@google.com>, Alexander
 Potapenko <glider@google.com>, Shuah Khan <shuah@kernel.org>, Moritz
 Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Dipen Patel <dipenp@nvidia.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kernel-doc: Remove deprecated kernel-doc option
 'functions'
In-Reply-To: <c0fd30e8e6d175eab50d7d5212117107e5251e4d.camel@sipsolutions.net>
References: <20240122132820.46633-1-anna-maria@linutronix.de>
 <c0fd30e8e6d175eab50d7d5212117107e5251e4d.camel@sipsolutions.net>
Date: Tue, 23 Jan 2024 15:05:41 -0700
Message-ID: <87y1cfiu2y.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2024-01-22 at 14:28 +0100, Anna-Maria Behnsen wrote:
>
>> the kernel-doc option 'functions' is marked deprecated and is simply an
>> alias for 'identifiers'
>
> Is it actually a good idea though that it's deprecated and an alias?
>
> I mean, we have a problem today that sphinx/kernel-doc/whatever cannot
> deal with having both
>
>  - struct cfg80211_rx_assoc_resp
>  - cfg80211_rx_assoc_resp()
>
> I think at some point I found there's some kind of ticket open against
> that, and while I don't hope it will be fixed soon (and we renamed that
> struct because of it), maybe doing these changes will make it harder to
> eventually deal with such a thing?

So I feel like I'm missing something; the problem with Sphinx and
namespacing is separate from whether kernel-doc recognizes "-functions";
I don't think that taking out this support will make the other problem
any harder to solve.  Do you see something I'm not?

Thanks,

jon


Return-Path: <linux-kernel+bounces-122741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3688FC57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E97B246B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26FA657DC;
	Thu, 28 Mar 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="XQ2n2gcn";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="rxCmnk2t"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A904E1DA;
	Thu, 28 Mar 2024 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620134; cv=pass; b=oiAs+1rcRBoswlclcVMQQ+/rHd1Oj5h7JygC7aTFsJxSp2pbl+MwMSgWBSiG+dBXqfvg/pmvzVg0oUViDjmP3edak0FAj2rvq5l72VPdYdPMAzY01+cDbJ+tgdAuQe2AP0YfPbOQGdFZPX6INfKvirv+oHHECtaN7Gl0JMCxPWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620134; c=relaxed/simple;
	bh=rskF7u+e2al8EJcpAKqAmcnyEEtX2PvBsVLK8SfiCkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIoYNQ9RxZGmG2A2MYWdR94aUGjD0xcQlkj6gmaEyAoc4n0HLrezzsvrSSEsF5aogXIh0DUlY2EQDjphpwh6LrsZ/R9CslUiigGzatHhXxqugdkQmGBAY2msTPI5pYdfqUwey6SZ8fy4GEXGe7ifEajQHwQacufyxzxL86blr0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=XQ2n2gcn; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=rxCmnk2t; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1711619943; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Vl7gNUuAuvgu8jPJCoP8QItXVAhJ9n0IbrRbSXQ+fR3Ca90J5jAE2JUIXF5u8Tf9VT
    p0K2Lu2zz5XjDIyneFMpeBXKsXGQ3mdqQQAqbkpzPgwVWDagvEK1k0HWAlC0ks3JDw9j
    o3yswXzIflnc/ODmpqG/XduR+4fNcztsoxifGz8c58QA3DW64ko/8Y6iSU6Jp60o6buP
    mdsJh/wjcER/z7R9Qzk0frLHaE3axoS/QyRBcsfpwHxc45jWKeWAiqd3pUjJTdYsWHFf
    76IhfqhroA2Rxh13rV9Lt8JoIDNfV+QgGaF4IcpAVxv+/s8J2KUjGXc8j0I1HctgdvDv
    d5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1711619943;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5Go0D8hd2wxVnlLgqUtglFepqhG/In7hPQmk3c2N3kM=;
    b=frf7KO06h4E3gBHU79yBODujpThbzBIqmupIUTVnasdjyuWszr7i1BpA7sHm0GmxlQ
    k2EjmqWV2US5jr5hUVcXaQbRH9hJjeSR7k13MpkxFuAyyDvvvqsCpkzWB/ra+Kx3kQnz
    9PVofvJ+kC4B6bR3wXO6fA6NdNLVIGVdRPaLrTZ2/0DQRPqOrHmPsCKkEdCxpjq9eP+m
    bvo0S81AarYQ4FbdpEwXtlqSmbDTP4ChoSM49f/AX9kMkEKkQ3hv2qgoTUKckNgES8l7
    f52Hi57SFtNZ1SOBkPn97uHW3+pa6mXydQOQOunjCaxYOH+zmrIbGlsZuTfWgI/kTOdg
    ntVg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1711619943;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5Go0D8hd2wxVnlLgqUtglFepqhG/In7hPQmk3c2N3kM=;
    b=XQ2n2gcnGSDYVH24ZI38SJsDIa2clZga+TEwjVjP+1S4LSX2vyip+TsaPpB1mQM0Sc
    WJ/SIJJ91k2refGyBeoFmwN7KPyZ5sz+BGJfhLZHNY4E0ZwU0yW4np1EvQE/KMJtIP3S
    fTmzyCiQUWubI/NADQLFx3+JsLDKQdYy/lpg/POXPwtS+FGknE1PJVJs/9bN2xuKyh2R
    LGWOo0OIy8i5cjPE9iaSTTfShhnkTRYzZQf18iW+EtMdYka278OhZfwbwGdY4sGpM4Ld
    A1AAxRHvlp/vkzFGzpCImcl3NdN1S/sgv/To3LkrzZL5r0wmtyqlAMsgSaxKZi0u2cfA
    fHJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1711619942;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5Go0D8hd2wxVnlLgqUtglFepqhG/In7hPQmk3c2N3kM=;
    b=rxCmnk2t9eYVz3WjH9I+vkj5OlaZQAv6ZsMZwKDhYQqQWpd5k7c4r8Yp0LgiKRvPuw
    Y100NZyHMqw/rGEDwoBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z+P1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.2 SBL|AUTH)
    with ESMTPSA id Raf12502S9x2U4g
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 28 Mar 2024 10:59:02 +0100 (CET)
Date: Thu, 28 Mar 2024 10:58:56 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	Bjorn Andersson <andersson@kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rob Clark <robdclark@gmail.com>, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Message-ID: <ZgU_YDUhBeyS5wuh@gerhold.net>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org>
 <87a5mjz8s3.fsf@epam.com>
 <f4ebe819-9718-42c3-9874-037151587d0c@linaro.org>
 <cd549ee8-22dc-4bc4-af09-9c5c925ee03a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd549ee8-22dc-4bc4-af09-9c5c925ee03a@linaro.org>
Content-Transfer-Encoding: 7bit

On Wed, Mar 27, 2024 at 11:29:09PM +0000, Caleb Connolly wrote:
> On 27/03/2024 21:06, Konrad Dybcio wrote:
> > On 27.03.2024 10:04 PM, Volodymyr Babchuk wrote:
> >> Konrad Dybcio <konrad.dybcio@linaro.org> writes:
> >>> On 27.03.2024 9:09 PM, Volodymyr Babchuk wrote:
> >>>> It appears that hardware does not like cacheable accesses to this
> >>>> region. Trying to access this shared memory region as Normal Memory
> >>>> leads to secure interrupt which causes an endless loop somewhere in
> >>>> Trust Zone.
> >>>>
> >>>> The only reason it is working right now is because Qualcomm Hypervisor
> >>>> maps the same region as Non-Cacheable memory in Stage 2 translation
> >>>> tables. The issue manifests if we want to use another hypervisor (like
> >>>> Xen or KVM), which does not know anything about those specific
> >>>> mappings. This patch fixes the issue by mapping the shared memory as
> >>>> Write-Through. This removes dependency on correct mappings in Stage 2
> >>>> tables.
> >>>>
> >>>> I tested this on SA8155P with Xen.
> >>>>
> >>>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> >>>> ---
> >>>
> >>> Interesting..
> >>>
> >>> +Doug, Rob have you ever seen this on Chrome? (FYI, Volodymyr, chromebooks
> >>> ship with no qcom hypervisor)
> >>
> >> Well, maybe I was wrong when called this thing "hypervisor". All I know
> >> that it sits in hyp.mbn partition and all what it does is setup EL2
> >> before switching to EL1 and running UEFI.
> >>
> >> In my experiments I replaced contents of hyp.mbn with U-Boot, which gave
> >> me access to EL2 and I was able to boot Xen and then Linux as Dom0.
> > 
> > Yeah we're talking about the same thing. I was just curious whether
> > the Chrome folks have heard of it, or whether they have any changes/
> > workarounds for it.
> 
> Does Linux ever write to this region? Given that the Chromebooks don't
> seem to have issues with this (we have a bunch of them in pmOS and I'd
> be very very surprised if this was an issue there which nobody had tried
> upstreaming before) I'd guess the significant difference here is between
> booting Linux in EL2 (as Chromebooks do?) vs with Xen.
> 

FWIW: This old patch series from Stephen Boyd is closely related:
https://lore.kernel.org/linux-arm-msm/20190910160903.65694-1-swboyd@chromium.org/

> The main use case I have is to map the command-db memory region on
> Qualcomm devices with a read-only mapping. It's already a const marked
> pointer and the API returns const pointers as well, so this series
> makes sure that even stray writes can't modify the memory.

Stephen, what was the end result of that patch series? Mapping the
cmd-db read-only sounds cleaner than trying to be lucky with the right
set of cache flags.

Thanks,
Stephan


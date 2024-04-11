Return-Path: <linux-kernel+bounces-140110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779758A0B86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071E41F24113
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DEE142E61;
	Thu, 11 Apr 2024 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jySAA3fM"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9381411C7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824879; cv=none; b=SOyRWdR4sQ2pNENRt+qKKccr+jIJD8OaA/qM/ZA+WPXl3HGc2/6Z7cMC/IOTNrPT4lHA/VVb2cQpiqxO2Rb7fPSjpdr87hLmDK4OGrf/BuoAkVM4p/XCQyZkZAi8zqpIDWnsLH8q3L7qVct8REgtBzZ2i2UceBVPL3+yeufk9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824879; c=relaxed/simple;
	bh=7XwS40heuSzS08AOg3Ct0waSlqMddnC3kfgp/oSL++0=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npGRYI6z7hYugXgU19BHgSaNxqq1sqVvuyCXRGSAKx+kVB8ZuH6hqeK5MvRvUq8EzMzVRUfaTswPLNCoIVpE0ghbF8cU9HjIoG+VLMmLXszyxeOt5BNVdwD5U2Sucbc4Yq8ohZqplywDt/lmikAyYXMo6FgEYtFlFs9vIHFnm9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jySAA3fM; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61804067da0so41902267b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712824875; x=1713429675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qyLF4kgizvTFTCCpOZdjrYGVi6dVtt6usPwLnMza0Q=;
        b=jySAA3fM9sjmJc6KOy5wz+tA+U2JE4kRTTC2xOkKada4bLo5e0RXfUGIoPoVWfjoDl
         UMF65QwUah3QQkTMdpDY0AFOdQS/hgB+kQ7zhurNy9AWHeJI3irDbfW6zg15zcfgWFl3
         JvX/GqKsaFhl3fAODHi4KwVSZXmmGULqZXb6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824875; x=1713429675;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qyLF4kgizvTFTCCpOZdjrYGVi6dVtt6usPwLnMza0Q=;
        b=YTmNn8cucLFEHjjFe71NkBTdmNfJwUOTIXcZ+FAPCtff5ySnJ/8V9ctGEXW2uLUXcy
         2Z+YSyBpsX43ENmgz15IxfzTcJOpmLwEwzG6ab04pn4JAxyRW7sh/xCkuNsUCG0v6m+/
         xcjESalcluziANODEtCi4X3vAfZxoUarwn+b2F6/I7dQIWFqm2nah+oYE6KF8wDQHgDB
         C/OrtidFF52KOSNW6m6pgbc58ylJsDL/NUCYya+nPO6KSxk8L1Kd7NECnA1rJZ6mNmCo
         bBYZsh/6XkqALQ2/vulZyM1suiLaKDN1Bcf6jYJ1W4cxiXLxifCy++6ZWSiftON9anuS
         OQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC0nMMKWvjHN3Jn0XyfkaJ/aQrYbc5+ZyBUJ3TxeLCvGWsO0Cz5zTw30aXZQKDV8dqzunbqJ/UrMbk/7gEZm3NdWDwjUpYmrwDS17E
X-Gm-Message-State: AOJu0Yyh23qpuGRHTECgProZhjP1AOOJtKaKOfjssPjv/kvvbZqB2iNu
	j7PbLOkQ2fDmc0gnPqhcV5r6PXWxW9STQp1Y4c13dIQWWae1I31oAd4dnBNmmt1ocLpqukU+zkB
	VqUdRI6D9a4GbuYz03gCUi+5ztfGdZqoYDyTV
X-Google-Smtp-Source: AGHT+IGL4zM5jBbRWCJ3sWcug1eth1VghpvE74Gg+jytpS++vbIHeFuIe+Qgfzb0HLwMjL5frK037YhyOOmBSpJ0fAA=
X-Received: by 2002:a81:6fd7:0:b0:609:ff6d:cb87 with SMTP id
 k206-20020a816fd7000000b00609ff6dcb87mr4937781ywc.50.1712824875440; Thu, 11
 Apr 2024 01:41:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Apr 2024 01:41:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZheY-S5VY2AZD7V-@gerhold.net>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org> <87a5mjz8s3.fsf@epam.com>
 <f4ebe819-9718-42c3-9874-037151587d0c@linaro.org> <cd549ee8-22dc-4bc4-af09-9c5c925ee03a@linaro.org>
 <ZgU_YDUhBeyS5wuh@gerhold.net> <875xwo6f57.fsf@epam.com> <ZheY-S5VY2AZD7V-@gerhold.net>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Thu, 11 Apr 2024 01:41:14 -0700
Message-ID: <CAE-0n52CkvS4ir15E-dXamsPuLhEt+_v7d2J3uQqGz3d+xz8Yg@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
To: Stephan Gerhold <stephan@gerhold.net>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Rob Clark <robdclark@gmail.com>, Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"

Quoting Stephan Gerhold (2024-04-11 01:02:01)
> On Wed, Apr 10, 2024 at 10:12:37PM +0000, Volodymyr Babchuk wrote:
> > Stephan Gerhold <stephan@gerhold.net> writes:
> > > On Wed, Mar 27, 2024 at 11:29:09PM +0000, Caleb Connolly wrote:
> > >> On 27/03/2024 21:06, Konrad Dybcio wrote:
> > >> > On 27.03.2024 10:04 PM, Volodymyr Babchuk wrote:
> > >> >> Konrad Dybcio <konrad.dybcio@linaro.org> writes:
> > >> >>> On 27.03.2024 9:09 PM, Volodymyr Babchuk wrote:
> > >> >>>> It appears that hardware does not like cacheable accesses to this
> > >> >>>> region. Trying to access this shared memory region as Normal Memory
> > >> >>>> leads to secure interrupt which causes an endless loop somewhere in
> > >> >>>> Trust Zone.
> > >> >>>>
> > >> >>>> The only reason it is working right now is because Qualcomm Hypervisor
> > >> >>>> maps the same region as Non-Cacheable memory in Stage 2 translation
> > >> >>>> tables. The issue manifests if we want to use another hypervisor (like
> > >> >>>> Xen or KVM), which does not know anything about those specific
> > >> >>>> mappings. This patch fixes the issue by mapping the shared memory as
> > >> >>>> Write-Through. This removes dependency on correct mappings in Stage 2
> > >> >>>> tables.
> > >> >>>>
> > >> >>>> I tested this on SA8155P with Xen.
> > >> >>>>
> > >> >>>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> > >> >>>> ---
> > >> >>>
> > >> >>> Interesting..
> > >> >>>
> > >> >>> +Doug, Rob have you ever seen this on Chrome? (FYI, Volodymyr, chromebooks
> > >> >>> ship with no qcom hypervisor)

ChromeOS boots the kernel at EL2 on sc7180. But more importantly we
don't enable whichever xPU it is that you're running into.

> > >> >>
> > >> >> Well, maybe I was wrong when called this thing "hypervisor". All I know
> > >> >> that it sits in hyp.mbn partition and all what it does is setup EL2
> > >> >> before switching to EL1 and running UEFI.
> > >> >>
> > >> >> In my experiments I replaced contents of hyp.mbn with U-Boot, which gave
> > >> >> me access to EL2 and I was able to boot Xen and then Linux as Dom0.
> > >> >
> > >> > Yeah we're talking about the same thing. I was just curious whether
> > >> > the Chrome folks have heard of it, or whether they have any changes/
> > >> > workarounds for it.
> > >>
> > >> Does Linux ever write to this region? Given that the Chromebooks don't
> > >> seem to have issues with this (we have a bunch of them in pmOS and I'd
> > >> be very very surprised if this was an issue there which nobody had tried
> > >> upstreaming before) I'd guess the significant difference here is between
> > >> booting Linux in EL2 (as Chromebooks do?) vs with Xen.
> > >>
> > >
> > > FWIW: This old patch series from Stephen Boyd is closely related:
> > > https://urldefense.com/v3/__https://lore.kernel.org/linux-arm-msm/20190910160903.65694-1-swboyd@chromium.org/__;!!GF_29dbcQIUBPA!yGecMHGezwkDU9t7XATVTI80PNGjZdQV2xsYFTl6EhpMMsRf_7xryKx8mEVpmTwTcKMGaaWomtyvr05zFcmsf2Kk$
> > > [lore[.]kernel[.]org]
> > >
> > >> The main use case I have is to map the command-db memory region on
> > >> Qualcomm devices with a read-only mapping. It's already a const marked
> > >> pointer and the API returns const pointers as well, so this series
> > >> makes sure that even stray writes can't modify the memory.
> > >
> > > Stephen, what was the end result of that patch series? Mapping the
> > > cmd-db read-only sounds cleaner than trying to be lucky with the right
> > > set of cache flags.
> > >
> >
> > I checked the series, but I am afraid that I have no capacity to finish
> > this. Will it be okay to move forward with my patch? I understand that
> > this is not the best solution, but it is simple and it works. If this is
> > fine, I'll send v2 with all comments addressed.
> >
>
> My current understanding is that the important property here is to have
> a non-cacheable mapping, which is the case for both MEMREMAP_WT and
> MEMREMAP_WC, but not MEMREMAP_WB. Unfortunately, the MEMREMAP_RO option
> Stephen introduced is also a cacheable mapping, which still seems to
> trigger the issue in some cases. I'm not sure why a cache writeback
> still happens when the mapping is read-only and nobody writes anything.

Qualcomm knows for certain. It's not a cache writeback per my
recollection. I recall the problem always being that it's a speculative
access to xPU protected memory. If there's a cacheable mapping in the
non-secure page tables then it may be loaded at the bus with the
non-secure bit set (NS). Once the xPU sees that it reboots the system.

It used to be that we could never map secure memory regions in the
kernel. I suspect with EL2 the story changes slightly. The hypervisor is
the one mapping cmd-db at stage2, so any speculative access goes on the
bus as EL2 tagged, and thus "approved" by the xPU. Then if the
hypervisor sees EL1 (secure or non-secure) access cmd-db, it traps and
makes sure it can actually access that address. If not, the hypervisor
"panics" and reboots. Either way, EL1 can have a cacheable mapping and
EL2 can make sure the secrets are safe, while the cache never goes out
to the bus as anything besides EL2.

>
> You can also test it if you want. For a quick test,
>
> -       cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
> +       cmd_db_header = ioremap_prot(rmem->base, rmem->size, _PAGE_KERNEL_RO);
>
> should be (largely) equivalent to MEMREMAP_RO with Stephen's patch
> series. I asked Nikita to test this on SC7180 and it still seems to
> cause the crash.
>
> It seems to work only with a read-only non-cacheable mapping, e.g. with
>
> +       cmd_db_header = ioremap_prot(rmem->base, rmem->size,
>                                      ((PROT_NORMAL_NC & ~PTE_WRITE) | PTE_RDONLY));
>
> The lines I just suggested for testing are highly architecture-specific
> though so not usable for a proper patch. If MEMREMAP_RO does not solve
> the real problem here then the work to make an usable read-only mapping
> would go beyond just finishing Stephen's patch series, since one would
> need to introduce some kind of MEMREMAP_RO_NC flag that creates a
> read-only non-cacheable mapping.
>
> It is definitely easier to just change the driver to use the existing
> MEMREMAP_WC. Given the crash you found, the hardware/firmware seems to
> have a built-in write protection on most platforms anyway. :D
>

How is Xen mapping this protected memory region? It sounds like maybe
that should be mapped differently. Also, how is EL2 accessible on this
device?


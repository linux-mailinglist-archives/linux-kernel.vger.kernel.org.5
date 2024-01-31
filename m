Return-Path: <linux-kernel+bounces-46364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2018B843E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7829294CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA2778695;
	Wed, 31 Jan 2024 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPybSp19"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF2378681
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700995; cv=none; b=Di6AVK/8K7jWNgnL8Qnd90rQzVX46n+H5WwggaJNvD7/lQB2m/BQ3zBxNd/Gyws6LLecpepwWhXSQtLue15PWsCvgCTy35ihhBXluff1Wd0nbhRtkMrGN5ClUUcCoEZ/yN0apUDjbR062NoNyR/ctZzToo5mnYdnh5P3hWUvWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700995; c=relaxed/simple;
	bh=8bBrqoGXUoXunxWrBBVukpNZlsie+GruwlpfN6BU+rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0bf6ExqWQHgFEeJR4MJ3dD/BIpYb1LPBU3UC500hh8XkJ9l5NJikaOk/0q5DMMOKh/DuqE+DrICtX3diOLkNtY1MpdBmy0BV440tpKzut6EggZ+emE15y2M7laqIsbNl4d/Zmpl3OVYvmFpru1K42YuS9jziuAdjJD7SP8nM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TPybSp19; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-604123a7499so2566357b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706700992; x=1707305792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U5IhwNM7tfTpvKqa7glJYOtcilNz1jCteQqILZezCLE=;
        b=TPybSp19AALC454pk7nKCXzcyahAYl5eMiwZhfTRJ6WqT6fdG7BhlMHTHPw1yX9KKv
         u7wnBRkMg28aCn5rsiQs34mOCyv3jqlu5qoYjTG/plcBovefqtEScXjA0FOXTRLtR7NZ
         tZPe2/7kJDpW3qmeD5MY2s6P5AOTfZfHMzWet3wR/uzktF1UcdVqI4sElCOuH4/QRf9y
         cHbAnDps+ywRaWpxCSFfcV0EyHbCs8W3lpgc28+GwHqxaj5QGyjYPN5VRFvOrrqAV5Go
         57PjpmNvMiAxysJsskNfa8/Tl7mWNm872WgRbymlZ6dPCUTHjUdmNOAwaDioARLA0ApR
         AotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706700992; x=1707305792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5IhwNM7tfTpvKqa7glJYOtcilNz1jCteQqILZezCLE=;
        b=bufkJ8qmXwAc/ksZAXfUJCFfp+L8GJFVD4UWxU8Hr4qK5YMmVJqroRsShRDR/np3FY
         aYSiOmsMbikbGr8atT/YGVYU7x7ULcubBgydxU1kbVoHsVCMqCV20Pem24M+BcFS32Sj
         0Y81IiydOmk8SS+pO6YQ/eq3IntcoKv3N71N8fMKEssX20vGzNsIppXVttFZnnxJN1C8
         WKEERI6ds/J+vWzGbLd2kY5/AOGviOhWYZUpD16QGjGCFivqh/AT62Gs2ypcoT2hhXqZ
         nmFwHQ+OY+wj4ntoWAwKLg2MN1LPlJwgfv21f+FBi4Hy0QEo1/h1fEpPKQ5PO9JmL5wC
         WBEA==
X-Gm-Message-State: AOJu0YwC9JbIQZVlUMNMYYTfRnyDSMEAzX55Pc5IkTSYVt7yhHXdY5dt
	hI4PJu8AD6mdh9cibZOTkUEqcvMevYVkO4k/KMgBEh0FNIXKRC7w6F8Nkz3SsdXupENoTyZ+OGF
	DjdHu0Pq4q3LhheI6SDyfMHPvDXw6ovRJdLWKVA==
X-Google-Smtp-Source: AGHT+IFmIqeqgLzkIR9AOm0VrXhQ5wQxHfTj4frB8NKDDK1Ia01TNcVRwOvlCVx8Y5q/JVm0GQTe9FiP2HxXj9jwlh0=
X-Received: by 2002:a0d:d4ca:0:b0:603:ea88:6db1 with SMTP id
 w193-20020a0dd4ca000000b00603ea886db1mr1055807ywd.51.1706700992425; Wed, 31
 Jan 2024 03:36:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125191756.868860-1-cristian.marussi@arm.com>
 <CAPDyKFpqZf15DFWa8K6RRzSTX70chEVTV8zRgnJ3VStSq_d9UQ@mail.gmail.com> <ZblW5rt4UtK6KMJD@pluto>
In-Reply-To: <ZblW5rt4UtK6KMJD@pluto>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 31 Jan 2024 12:35:56 +0100
Message-ID: <CAPDyKFo_Hg1-hN4Mw0UZSMX2iHRpyKyzyd+Gh5xWn-+2x3Jskg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: Fix NULL dereference on scmi_perf_domain removal
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 21:07, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Tue, Jan 30, 2024 at 02:09:20PM +0100, Ulf Hansson wrote:
> > On Thu, 25 Jan 2024 at 20:18, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >
> > > On unloading of the scmi_perf_domain module got the below splat, when in
> > > the DT provided to the system under test the '#power-domain-cells' property
> > > was missing.
> > > Indeed, this particular setup causes the probe to bail out early without
> > > giving any error, so that, then, the removal code is run on unload, but
> > > without all the expected initialized structures in place.
> > >
> > > Add a check and bail out early on remove too.
> >
> > Thanks for spotting this!
> >
> > >
> > > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> > > Mem abort info:
> > >    ESR = 0x0000000096000004
> > >    EC = 0x25: DABT (current EL), IL = 32 bits
> > >    SET = 0, FnV = 0
> > >    EA = 0, S1PTW = 0
> > >    FSC = 0x04: level 0 translation fault
> > >  Data abort info:
> > >    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > >    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > >    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > >  user pgtable: 4k pages, 48-bit VAs, pgdp=00000001076e5000
> > >  [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
> > >  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > >  Modules linked in: scmi_perf_domain(-) scmi_module scmi_core
> > >  CPU: 0 PID: 231 Comm: rmmod Not tainted 6.7.0-00084-gb4b1f27d3b83-dirty #15
> > >  Hardware name: linux,dummy-virt (DT)
> > >  pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > >  pc : scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
> > >  lr : scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
> > >  sp : ffff80008393bc10
> > >  x29: ffff80008393bc10 x28: ffff0000875a8000 x27: 0000000000000000
> > >  x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> > >  x23: ffff00008030c090 x22: ffff00008032d490 x21: ffff80007b287050
> > >  x20: 0000000000000000 x19: ffff00008032d410 x18: 0000000000000000
> > >  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > >  x14: 8ba0696d05013a2f x13: 0000000000000000 x12: 0000000000000002
> > >  x11: 0101010101010101 x10: ffff00008510cff8 x9 : ffff800080a6797c
> > >  x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
> > >  x5 : 8080808000000000 x4 : 0000000000000020 x3 : 00000000553a3dc1
> > >  x2 : ffff0000875a8000 x1 : ffff0000875a8000 x0 : ffff800082ffa048
> > >  Call trace:
> > >   scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
> > >   scmi_dev_remove+0x28/0x40 [scmi_core]
> > >   device_remove+0x54/0x90
> > >   device_release_driver_internal+0x1dc/0x240
> > >   driver_detach+0x58/0xa8
> > >   bus_remove_driver+0x78/0x108
> > >   driver_unregister+0x38/0x70
> > >   scmi_driver_unregister+0x28/0x180 [scmi_core]
> > >   scmi_perf_domain_driver_exit+0x18/0xb78 [scmi_perf_domain]
> > >   __arm64_sys_delete_module+0x1a8/0x2c0
> > >   invoke_syscall+0x50/0x128
> > >   el0_svc_common.constprop.0+0x48/0xf0
> > >   do_el0_svc+0x24/0x38
> > >   el0_svc+0x34/0xb8
> > >   el0t_64_sync_handler+0x100/0x130
> > >   el0t_64_sync+0x190/0x198
> > >  Code: a90153f3 f9403c14 f9414800 955f8a05 (b9400a80)
> > >  ---[ end trace 0000000000000000 ]---
> > >
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > > I suppose the probe does NOT bail out with an error because this DT config has
> > > to be supported, right ?
> >
> > Actually, no. It's a mistake by me, the probe should bail out with an
> > error code.
> >
>
> Ok. I suppose any old platform like JUNO that missed this will have to
> update their DT to use the new scmi_perf_domain...well it should have
> anyway really, it is just that now it is silently failing.

I don't think it's failing. The old binding for SCMI perf (using
clock-cells) is still supported the way they were before, which is
only for cpufreq.

But, yes you are right, both the DT and the consumer driver would need
to be updated to support SCMI perf.

>
> > In fact, there is also one additional similar problem in probe, when
> > the number of perf-domains are zero. In that case, we should also
> > return an error code, rather than returning 0.
> >
> > Would you mind updating the patch to cover both problems - or if you
> > are too busy, just let me know and I can help out.
>
> No problem, I can do it next week, but regarding the zero domain case,
> I remember I used to do the same on regulator/voltage driver and bail out
> when no domains were found, but we were asked by some customer to support
> instead the very useless and funny case of zero domains for some of their
> testing setup scenarios .. i.e. allowing the driver to load with zero domains
> (and do nothing) and then unload cleanly avoiding harms while unloading ...)
>
> Thoughts about this ? Can fix as you prefer .

In my opinion, there is no point having a module/driver loaded to do
nothing. I would prefer to just return an error code.

Thanks for fixing this!

Kind regards
Uffe


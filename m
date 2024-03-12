Return-Path: <linux-kernel+bounces-100515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830098798FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7931F22A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E97F7B3C4;
	Tue, 12 Mar 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5HhDtJ9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF797D41F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261007; cv=none; b=P0tDcDvqMZuTwT8NnaCpVGtQFkzz7dQBZyIkuiaWgC+HdJoJ8HGYyqJYWzzGFDbz+uylgIu+pXG3LmRpcNmOYkDSUv3xUkTcmwc0euxF37q5E1uwvYOR5U73gzXGUS1wKzE8dKJHnx7+rOB1vb7R7JY2x5mg0r53PogdiREJhPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261007; c=relaxed/simple;
	bh=voI6BM7Xg+gxgp29LRdN7qMoQZMvfyadyO4Ee3+HXXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efXaxFak2Hd3mJ+ki3FlAe/4fKYkwIJBg+Bf9UEkgjmFJWqh/Kjc24JM6jFhOHtZ0yWsiOVQwELPm/V1wdo3PLyqarfA1IIP9FnP+h5AF2E6krSHyX7qbfuXkXpghGmIN/5EX/yvqLbtqLuwDHowzoBxaiMa8pLNjLfcG7UYcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o5HhDtJ9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso5950229a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710261004; x=1710865804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gHpoaQkUTsOKlYO7BK6ng/vC/jpGtZbtRyKMcMB6RC4=;
        b=o5HhDtJ96QkmhABW4WDYoY8OSdcvK8R5DjRjpEuQmrFZnTmilpPElqMA/h/cMfXc49
         ZCb5InFg1TOxjFEHvMKbhLNTPehpvswuOVaoDMNbVJj/agHN35AhiXH9w1GLOYBFKTp1
         ZUE38Z9KMo60wybaXPiE4Q8oKsVlRegwDYvgNQF4f6Tiz6JzBPqNjAFpgi3ISaUrnvX1
         XEF1PFvv6mr2NEvPao49F2f2BaC1aMtbmYAcWaqW+b69ms93QDGTWwctX6l3hSTSgIkI
         1+Im9rbbdCi5Khdvfj29NkVuDtgf7roEC5iyPZrMVvp5cj5ZIPzX1e8sNvnst6VpvyUn
         LETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710261004; x=1710865804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHpoaQkUTsOKlYO7BK6ng/vC/jpGtZbtRyKMcMB6RC4=;
        b=tpqeU8BO0XUbgjBDQeprnxHZLfOc4yBOTK0oQjdt5+6BVRYc0WeoaHoHTny2RNZsFq
         VEezGKlBg0iuqY1ncI3wbqdrXyo+4IjR5NKYCk7Y1Zr2Fix+TPEUjEcvs8GRrTH1+2QS
         R/u3IyI1OcjcZpbEwFEzalE3qStjvNU0F6gUVXFzouox2VDuN6TY0ihjrB5iPyYq2WLj
         CrRjwOiUN37bfBEBSJWZ8tyB8lOk9NPburcEoLrTu0VgQ3vQUofNvysemNW88C1wRMbG
         aQ5bhaeNbylWh8aBbLTV10Rf4lr+xk3WQzlKuQZhnewaxpHuCfJiiR75vlGBcM3B2VHn
         LDyw==
X-Forwarded-Encrypted: i=1; AJvYcCVznbKZ/JSo4bGToXre/Cw6avedWuQPvAwOtonUrLe9erxE2NhZyhhYCA8DxEMj14Ew+G83Zh2gP6QDuNQekzk25S72WyW1DRfFLqiJ
X-Gm-Message-State: AOJu0YyY/ez8eMcLd307+px7RKHG19fOMn+fuHj79MJ/mI/P0/ZF71jJ
	OyHR8vT4IvFivWl9Fstrc1rNIOyoofsxiHJncQchw5OPJoCgMoMOx8KgSk8VUSmzGexo4S7VpSu
	Tz0e2sUo2pjr+JR1ev+oyuOjjAdFEXboaXqHvaw==
X-Google-Smtp-Source: AGHT+IH2hS9XRvqL5knhChyf0ZETo2nzJkGpzFXximZGJZ92xXm/kUDPiNqpyTU4QvViMkNQu/SwUhNQL0HHRG43Y9M=
X-Received: by 2002:a50:9e44:0:b0:565:6e57:fa3d with SMTP id
 z62-20020a509e44000000b005656e57fa3dmr694945ede.10.1710261003938; Tue, 12 Mar
 2024 09:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-2-abdellatif.elkhlifi@arm.com> <ZeYWKVpeFm1+4mlT@p14s>
 <20240307194026.GA355455@e130802.arm.com> <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>
 <20240311114442.GA82865@e130802.arm.com>
In-Reply-To: <20240311114442.GA82865@e130802.arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 12 Mar 2024 10:29:52 -0600
Message-ID: <CANLsYkwReJvB1UWvR5TwtSs-w_VqU45kDSUzuQ0k+waetEn6Yw@mail.gmail.com>
Subject: Re: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Drew.Reed@arm.com, Adam.Johnston@arm.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 05:44, Abdellatif El Khlifi
<abdellatif.elkhlifi@arm.com> wrote:
>
> Hi Mathieu,
>
> On Fri, Mar 08, 2024 at 09:44:26AM -0700, Mathieu Poirier wrote:
> > On Thu, 7 Mar 2024 at 12:40, Abdellatif El Khlifi
> > <abdellatif.elkhlifi@arm.com> wrote:
> > >
> > > Hi Mathieu,
> > >
> > > > > +   do {
> > > > > +           state_reg = readl(priv->reset_cfg.state_reg);
> > > > > +           *rst_ack = EXTSYS_RST_ST_RST_ACK(state_reg);
> > > > > +
> > > > > +           if (*rst_ack == EXTSYS_RST_ACK_RESERVED) {
> > > > > +                   dev_err(dev, "unexpected RST_ACK value: 0x%x\n",
> > > > > +                           *rst_ack);
> > > > > +                   return -EINVAL;
> > > > > +           }
> > > > > +
> > > > > +           /* expected ACK value read */
> > > > > +           if ((*rst_ack & exp_ack) || (*rst_ack == exp_ack))
> > > >
> > > > I'm not sure why the second condition in this if() statement is needed.  As far
> > > > as I can tell the first condition will trigger and the second one won't be
> > > > reached.
> > >
> > > The second condition takes care of the following: exp_ack and  *rst_ack are both 0.
> > > This case happens when RST_REQ bit is cleared (meaning: No reset requested) and
> > > we expect the RST_ACK to be 00 afterwards.
> > >
> >
> > This is the kind of conditions that definitely deserve documentation.
> > Please split the conditions in two different if() statements and add a
> > comment to explain what is going on.
>
> Thanks, I'll address that.
>
> >
> > > > > +/**
> > > > > + * arm_rproc_load() - Load firmware to memory function for rproc_ops
> > > > > + * @rproc: pointer to the remote processor object
> > > > > + * @fw: pointer to the firmware
> > > > > + *
> > > > > + * Does nothing currently.
> > > > > + *
> > > > > + * Return:
> > > > > + *
> > > > > + * 0 for success.
> > > > > + */
> > > > > +static int arm_rproc_load(struct rproc *rproc, const struct firmware *fw)
> > > > > +{
> > > >
> > > > What is the point of doing rproc_of_parse_firmware() if the firmware image is
> > > > not loaded to memory?  Does the remote processor have some kind of default ROM
> > > > image to run if it doesn't find anything in memory?
> > >
> > > Yes, the remote processor has a default FW image already loaded by default.
> > >
> >
> > That too would have mandated a comment - otherwise people looking at
> > the code are left wondering, as I did.
> >
> > > rproc_boot() [1] and _request_firmware() [2] fail if there is no FW file in the filesystem or a filename
> > > provided.
> > >
> > > Please correct me if I'm wrong.
> >
> > You are correct, the remoteproc subsystem expects a firmware image to
> > be provided _and_ loaded into memory.  Providing a dummy image just to
> > get the remote processor booted is a hack, but simply because the
> > subsystem isn't tailored to handle this use case.  So I am left
> > wondering what the plans are for this driver, i.e is this a real
> > scenario that needs to be addressed or just an initial patchset to get
> > a foundation for the driver.
> >
> > In the former case we need to start talking about refactoring the
> > subsystem so that it properly handles remote processors that don't
> > need a firmware image.  In the latter case I'd rather see a patchset
> > where the firmware image is loaded into RAM.
>
> This is an initial patchset for allowing to turn on and off the remote processor.
> The FW is already loaded before the Corstone-1000 SoC is powered on and this
> is done through the FPGA board bootloader in case of the FPGA target. Or by the Corstone-1000 FVP model
> (emulator).
>

From the above I take it that booting with a preloaded firmware is a
scenario that needs to be supported and not just a temporary stage.

> The plan for the driver is as follows:
>
> Step 1: provide a foundation driver capable of turning the core on/off
>
> Step 2: provide mailbox support for comms
>
> Step 3: provide FW reload capability
>

What happens when a user wants to boot the remote processor with the
firmware provided on the file system rather than the one preloaded
into memory?  Furthermore, how do we account for scenarios where the
remote processor goes from running a firmware image on the file system
to the firmware image loaded by an external entity?  Is this a valid
scenario?

> Steps 2 & 3 are waiting for a HW update so the Cortex-A35 (running Linux) can share memory with
> the remote core.
>
> I'm happy to provide more explanation in the commit log to reflect this status.
>
> Is it OK that we go with step 1 as a foundation please ?
>

First let's clarify all the scenarios that need to be supported.  From
there I will advise on how to proceed and what modifications to the
subsystem's core should be made, if need be.

> Cheers
> Abdellatif


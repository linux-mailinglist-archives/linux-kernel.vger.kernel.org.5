Return-Path: <linux-kernel+bounces-44181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85580841E71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C411F26DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F2458ADD;
	Tue, 30 Jan 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fssUqAGu"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E315823F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604799; cv=none; b=k5JCrKAJCDpACBRMAfPIrRWOjHa4jvrJRf6YbXA2QIN4DzyUJxeExcwHahNOWmL8OS6AblLpMxcz0E1xv5v6Xx9ftxroeXMXfOz9NvF17Pk3d6quWl1EV6JOFs6suNdQvJC/KsxZIvXA6Nd+v6IKPqz/1YXQL7/uZXm9Y766w1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604799; c=relaxed/simple;
	bh=h1Xi9nzthy5gARefo2kIjSnt2E+iF/WlZ2VeOCiu5h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8Krcmchdv4JrUmyh1T5kG4qNRLKbyiD58NQ/r3fg0vzGf4BbKxDzJQV4sVSIvCEdI4Jkf4qdrSY54bjQzCHSuoQOFBkUCdfCKmpCvQPBN8Vmhsyvne0x1FD2zpuefwlSFqGltMtdSXRtYnMcKDNL1cSCEMOpDQE1CjWifYFjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=fssUqAGu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3169f46d73so74900466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706604795; x=1707209595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnipPguVBVsukMJPg/CHKERwnO897v8apmVfCnhET7A=;
        b=fssUqAGuDMCsLJCb8yTNPRwMeoKp5tqf0ulECLtT9uQj4SllWwQ7vQgsgG1K1VxFQX
         /3KYGWDWHifTpvLwQklNIK8FHXoVc+vmQ1jglQ8sy60bgTJ0whpUWrOq4vzrcGyebNtJ
         sSgYcRNmLI/GBma9TQdbyyoOrxF5gofvgzimw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604795; x=1707209595;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnipPguVBVsukMJPg/CHKERwnO897v8apmVfCnhET7A=;
        b=LaOt9LU3y/jBhIMRLv1+0FqYku3dWZleWUIF5lDPgFf9+EElguGLg8U1hFosJyZysM
         7LH5pyOZyfDB7Q4Xq7qY2/arLeqsUOanZ9+ImTZo+rfctP/GrBUeojLBBRj/4gB8Fw8K
         66WOgio2WoihJVLv34sPEFor0VTtJTvOkvIDzna8OcDl3etFWamYeLHISrTXGC8xIiJZ
         Gt2EUG3Nlzctb90gfpnCXFTG9zV0HpRClwXZZUo6/7hq9mJ5/7Aek6eb5STY9hzyPNaR
         0VkU9PqBe+9WZ/I3N+uLsWHEujskCi464e23k+ECk61t/lx2WyTWHuzvWRd3gMIbJ1Y0
         DZ5Q==
X-Gm-Message-State: AOJu0YwlzM4uxwBmx4c9sMAbWehJPBrkXXkQDsqX7ap+3Pz4LvGKJZtu
	tLDANq2d5Fuv23OoKdklB4BfutEYHyL9JfjS+EvBmCh/40wWTVCNZBu9u9stDKg=
X-Google-Smtp-Source: AGHT+IHAJVCMWLVPg/vYHMvDoQmMTWBgx+I9ToMH3Bmu5gVY3ZyclYukTdif33EwMWHJuhkwoBXIaA==
X-Received: by 2002:a17:906:6a02:b0:a31:234e:6a9c with SMTP id qw2-20020a1709066a0200b00a31234e6a9cmr7105187ejc.5.1706604795460;
        Tue, 30 Jan 2024 00:53:15 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id vk8-20020a170907cbc800b00a352afd952fsm4035463ejc.43.2024.01.30.00.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:53:14 -0800 (PST)
Date: Tue, 30 Jan 2024 09:53:13 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC 0/4] Support for Simulated Panels
Message-ID: <Zbi4-S49CWlUkO__@phenom.ffwll.local>
Mail-Followup-To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
References: <20240116-jz-test-sim-panel-v1-0-f9511f46c9c7@quicinc.com>
 <x6wi5xnihnbpqsujjfjfw3ft6njncruta5l3xa44pds5oxmdkw@mmvv4bciy65s>
 <87cyu0qn81.fsf@intel.com>
 <e1f10583-1d5b-fdac-24bf-098a0ba06241@quicinc.com>
 <hhmbghooegclx3jbsx2neryligk3mj77lq7gns5xegags5ltoz@acdu6hssqwlw>
 <99705d73-abcf-6d41-3d50-757e706cf1fc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99705d73-abcf-6d41-3d50-757e706cf1fc@quicinc.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Mon, Jan 29, 2024 at 11:05:12AM -0800, Abhinav Kumar wrote:
> <adding device tree maintainers to comment>
> 
> Hi Maxime
> 
> On 1/26/2024 4:45 AM, Maxime Ripard wrote:
> > On Wed, Jan 17, 2024 at 09:36:20AM -0800, Abhinav Kumar wrote:
> > > Hi Jani and Maxime
> > > 
> > > On 1/17/2024 2:16 AM, Jani Nikula wrote:
> > > > On Wed, 17 Jan 2024, Maxime Ripard <mripard@kernel.org> wrote:
> > > > > Hi,
> > > > > 
> > > > > On Tue, Jan 16, 2024 at 02:22:03PM -0800, Jessica Zhang wrote:
> > > > > > This series introduces a simulated MIPI DSI panel.
> > > > > > 
> > > > > > Currently, the only way to validate DSI connectors is with a physical
> > > > > > panel. Since obtaining physical panels for all possible DSI configurations
> > > > > > is logistically infeasible, introduce a way for DSI drivers to simulate a
> > > > > > panel.
> > > > > > 
> > > > > > This will be helpful in catching DSI misconfiguration bugs and catching
> > > > > > performance issues for high FPS panels that might not be easily
> > > > > > obtainable.
> > > > > > 
> > > > > > For now, the simulated panel driver only supports setting customized
> > > > > > modes via the panel_simlation.mode modparam. Eventually, we would like
> > > > > > to add more customizations (such as configuring DSC, dual DSI, etc.).
> > > > > 
> > > > > I think that it's more complicated than it needs to be.
> > > > 
> > > > Both too complicated and not complicated enough! :p
> > > 
> > > The end goal is to have a framework to be able to validate the display
> > > pipeline with MIPI panels of any resolution , DSC/non-DSC, different MIPI
> > > flags etc.
> > > 
> > > Historically, QC has been having an in-house framework to validate the
> > > panels in a simulated way as its logistically not possible to procure every
> > > panel from every vendor. This has been working pretty well but its not
> > > upstream yet. So we would like to work with the community to work on a model
> > > which works for everyone and this RFC was initiated with that in mind.
> > 
> > I think the goal was pretty clear. My point was more that there's no
> > reason it should be driver specific, and having a second path for it
> > doesn't really exert the actual panel path in the driver. I think a
> > separate driver would be better.
> > 
> 
> We can make this generic. That would be great actually. One option could be
> to move the modparam we have within the msm to the drm_of.c so that
> drm_of_find_panel_or_bridge shall return the sim panel if the modparam is
> passed to select a sim panel.

Yeah I think gluing this into drm_of_find_panel_or_bridge() would be
great, should help get other drivers on board and also help with
encouraging drivers to use panels/bridges correctly.

> So if we make this a compile time decision whether to use real panel or sim
> panel and just enable the appropriate config, we dont need the modparam and
> we can implement some policy in the drm_of to first check if sim panel is
> available and if not try the real panel then everything will just happen
> under-the-hood. But we thought that a modparam based switching might be
> convenient if users dont want to recompile the code to switch but will need
> to compile both the panels.

I think you can get to this point at runtime too:

- add a debugfs interface to your drm-sim-panel.ko driver. or maybe dt
  overlay or whatever is most convenient to configure the panel to be the
  sim one and not the real one

- load that drm-sim-panel.ko module first and configure it

- load the real driver

- some magic/heuristics/whatever in drm_of_find_panel_or_bridge to make
  sure things work.

Yes this breaks all built-in configs, but I also think trying to configure
a sim panel with modparams is going to be a lost cause, they're really
tricky. See also my comment below.

> > > There is simulation infrastructure in place in upstream for HDMI/DP in the
> > > form of chamelium based testing in IGT but no such fwk exists for DSI
> > > displays.
> > > 
> > > Different MIPI panels and resolutions test out not only the DSI controller
> > > but the entire display pipeline as based on resolution, compression and MIPI
> > > mode flags different parts of the pipeline can get exercised.
> > > 
> > > > > Why do we need to support (and switch to) both the actual and
> > > > > "simulated" panel?
> > > > > 
> > > 
> > > As per my discussion on IRC with the panel/bridge maintainers and DT
> > > maintainers, a simulation panel does not qualify for its own devicetree as
> > > its not a real hardware so we needed to come up with a way to have a module
> > > which can be attached to the encoder without its own bindings and
> > > devicetree. Thats what led to this RFC.
> > 
> > I still think it's worth trying, there's plenty of virtual drivers in
> > the DT already. But even then, DT policies shouldn't dictate general
> > framework design decisions: we have other ways to probe panels than
> > using the DT (by loading overlays, registering devices by hand, etc.). I
> > still think it would be a good idea to try though.
> > 
> 
> DT option would be great if accepted and will nicely solve the scalability
> issue of this as it desperately needs one.
> 
> I have absolutely no concerns and would be glad if it will be accepted.
> 
> Can the DT maintainers please comment if having a device tree for a
> simulation panel would work OR be considered because of the scalability of
> the number of panels which can be tried as Maxime wrote.
> 
> > > > > Wouldn't it be simpler if we had a vkms-like panel that we could either
> > > > > configure from DT or from debugfs that would just be registered the
> > > > > usual way and would be the only panel we register?
> > > > 
> > > 
> > > No, we need to have validate actual hardware pipeline with the simulated
> > > panel. With vkms, actual display pipeline will not be validated. With
> > > incorrect display pipeline misconfigurations arising from different panel
> > > combinations, this can easily be caught with any existing IGT CRC testing.
> > > In addition, all performance related bugs can also be easily caught by
> > > simulating high resolution displays.
> > 
> > That's not what I meant. What I meant was that something like a
> > user-configurable, generic, panel driver would be a good idea. Just like
> > vkms (with the debugfs patches) is for a full blown KMS device.
> > 
> 
> Let me respond for both this question and the one below from you/Jani.
> 
> Certainly having user-configurable information is a goal here. The end-goal
> is to make everything there in the existing panels such as below like I
> wrote:
> 
> 1) Display resolution with timings (drm_display_mode)
> 2) Compression/non-compression
> 3) Command mode/Video mode
> 4) MIPI mode flags
> 5) DCS commands for panel enable/disable and other panel sequences
> 6) Power-up/Power-down sequence for the panel
> 
> But, we also have to see what all is feasible today from the DRM fwk
> standpoint. There are some limitations about what is boot-time configurable
> using bootparams and what is runtime configurable (across a modeset) using
> debugfs.
> 
> 1) Today, everything part of struct mipi_dsi_device needs to be available at
> boot time from what I can see as we need that while calling
> mipi_dsi_attach(). So for that we went with boot-params.
> 
> 2) For the list of modes, we can move this to a debugfs like
> "populate_modes" which the client using a sim panel can call before picking
> a mode and triggering a commit.
> 
> But we need to have some default mode and configuration.

Uh, at the risk of sounding a bit like I'm just chasing the latest
buzzwords, but this sounds like something that's screaming for ebpf. Which
is also the plan we discussed for allowing vkms to simulate more complex
hardware eventually. Same design really:

- use configfs

- all the static stuff that needs to be fixed at panel registration time
  is going to be configfs files. That gives you a _lot_ more flexibility
  than trying to shoehoern everything into modparam. We've started that
  way for vkms, good for a first tech demo, not even close to good enough
  for a real testing/sim driver.

- all the runtime hooks that control the very specific DSI flows would be
  in ebpf. For common cases maybe you can implement some of the callbacks
  entire in the sim driver in C and configure it using configfs, but for
  anything really complex it's probably going to be ebpf.

  And there's just no way you can load ebpf over a modparam, so at that
  point we absolutely do have to have configfs (iirc you can load/attach
  ebpf to files in a fairly flexible way, so that should be doable with
  configfs - it's definitely the plan for vkms atomic_check constraints
  and stuff like that).

> This is where I am not totally sure of. On HDMI/DP sinks, we usually go with
> a default of 640x480 as that one is guaranteed to be supported across sinks.
> 
> For MIPI displays, we will have to agree on some default configuration then.
> 
> So, we can certainly add debugfs to make the runtime params but we need to
> start with some default during boot-up and move the others to debugfs.
> 
> With vkms, can you pls point us to the debugfs patches you are referring to?
> With the current vkms, very little is available which is debugfs
> configurable (overlay, writeback and cursor support).

It should actually be configfs. Unfortunately those patches haven't landed
(yet). I think this is the latest version, not sure why it's not moved
further:

https://lore.kernel.org/dri-devel/20230829053201.423261-1-brpol@chromium.org/

Cheers, Sima

> Ofcourse, all these concerns go away if DT option gets accepted.
> 
> > > > I get the idea of trying to test DSI code without panels, and looking at
> > > > the goals above, I think your vkms suggestion is going to fall short of
> > > > those goals.
> > > > 
> > > > However, my gut feeling is that creating a simulated panel to catch DSI
> > > > misconfiguration etc. is going to be insanely complicated, and this
> > > > series doesn't even scratch the surface.
> > > > 
> > > > I guess my questions are, what's the scope here really, are those goals
> > > > realistic, does more code already exist beyond this skeleton?
> > > > 
> > > 
> > > 
> > > This series is only a starting RFC to be able to validate any display mode.
> > > This would have to be extended to be able to customize different pieces of
> > > the panel. Lets talk about the customizable pieces:
> > > 
> > > 1) Display resolution with timings (drm_display_mode)
> > > 2) Compression/non-compression
> > > 3) Command mode/Video mode
> > > 4) MIPI mode flags
> > > 5) DCS commands for panel enable/disable and other panel sequences
> > > 6) Power-up/Power-down sequence for the panel
> > > 
> > > Without a physical panel, yes its hard to validate if anything is wrong with
> > > (4) OR (5), the display might not come up at all visually. But from our
> > > experience, thats only a small portion and the real benefit of this
> > > framework will actually be from the validation failures we will catch from
> > > (1) to (4).
> > > 
> > > This RFC only provides a way to customize (1) at the moment as we wanted to
> > > get some feedback from the community about the best way which will work for
> > > everyone to customize all these parameters.
> > > 
> > > We are willing to expand this series based on the generic way we agree on to
> > > customize other params.
> > > 
> > > Yes, debugfs is an option too. But typically MIPI displays need some
> > > parameters configured to attach the panel to the encoder. So perhaps we can
> > > boot the simulation panel with a default resolution passed through command
> > > line and then across a modeset switch (1) to (4).
> > 
> > I think Jani's feeling was that it was going to be super complicated
> > fairly fast so supporting more features would definitely help to get an
> > idea of where this is going.
> > 
> > Maxime

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


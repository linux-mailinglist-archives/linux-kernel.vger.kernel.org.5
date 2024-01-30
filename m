Return-Path: <linux-kernel+bounces-43871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084BA841A40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1DB1F29A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E6B3716E;
	Tue, 30 Jan 2024 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2/Am0aF"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B13715F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584274; cv=none; b=tDV/2Z6kGjfl1uSmNFA1k2C/+TDAK632dur/8HmUHMkrx5NljfzTCiFywYnGyHhEluibcYxzZLCeuBGNJqQdWJk0v6r9TbfM2GkQj9cueKioJVYrU9P2B8GTSuJwXXss4oKXMtwCMA+GDVls52Q5d9FlL7eD1Ixd6ucS9Ph4g+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584274; c=relaxed/simple;
	bh=TG54LtwdlHnVNXQwXhUYvNzdDhcxaYccKaLPRwPjkD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7CGHO6TetNERCwZ8rim0uilguX5avqnBHFUeA52QN5kIAucQmuyyVy8oDQQaMqHozLZ3tcnr+TWhNO+tPNCzhx0VKCNAK+3FQccVQsk6+KGBNqvG0jAzVCwd7SPLo84+jl4KOCCK+9ZLqjI3iq/3qMpwMGsLn06CJO5zMSaqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2/Am0aF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a99dc9085so92941cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706584271; x=1707189071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpUtGa+RyDe3NBtpf8CDDxf5fG++vVWLOt5Jnmjshpk=;
        b=O2/Am0aFaf/z0HaEO+jd9FAz4SgDPp+qNg1bFv2BA//cu/rFAFbix+w9BRkygwuLFv
         L9Pr2ZLZqN/qz/348BSYYwPaABBuz5vlfcivvHFx36YpHwIlil9rcSIToWaPseEojNmE
         RC8sSJ3WZ7j0rfu4+5oJtCNhGI6Uzkt1oG99oaTw86TW6LPEtL5K2iqVmlELhAJXyhvu
         6iTW5OYwQGI5TBt/BLMfcvTzvIKjVlgA2bJKW7W5PdFpJ9L0pSaQMiIkQVhOSdQYi2Gy
         NLR7D+uAoCSfqyaVtIH8EkYwcZQNGTIPPMYodHWxUafpcSoaofcKPcFY9H8EsDuUJsjj
         G1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584271; x=1707189071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpUtGa+RyDe3NBtpf8CDDxf5fG++vVWLOt5Jnmjshpk=;
        b=e4Y7gQ5cAs7xZmt/Uc56vMxqsmDM8UFKoKChHM+wd0b10ElLuUXF0vTTo+7FeGYwbo
         OveqpbUjP2tMYR4RG3/FDoA9Sxg+FpvZi6iHqFFCNG7qwGhL3U2n4FBR1ogIKrbjIVnO
         iTcrEa2rwc2sm3g36b+79iAN2rdxwm+Uy9a0U3B1Qi9amgMAvrk5za6UbJZGs9TLeKWP
         wS2r3VcyqGJpHdFCgiY9sb4G4Rr0ZdvWJHMQkltNCn9/rtiShFhvacIIyVgSmiFDO5yB
         SjYvEc0drHp7GbRMVEnhZ+qH+SIqWhJAuwTFjL4CLD+KdVV9VfkGpMGcoqL5G1TXriWr
         AT2Q==
X-Gm-Message-State: AOJu0Yzr3D5/IO+bOffChNzMKKpH/EpbLl7q6RZcnurL0B0OXkoSmSxb
	lU+OxNN5VRS3wCxAlh6OVdOW/TzL5qQvaI0GSk3SppUhkZI4VoYkDEXpR3xlbUa+yejVAoJ7Twc
	DkJolKc7p4oV+rZXqBfDvRAHt89RanMmX5Fp6
X-Google-Smtp-Source: AGHT+IGQ0gKUP6/bqbEfaUn6RsfoLkVeBTeo/xh3Ph2bvr+i4D9IdMHoHwzPSFPqEr6ABZfFjPy4X1qsZXDxFcUOOkQ=
X-Received: by 2002:ac8:7dd0:0:b0:42a:4857:6a7 with SMTP id
 c16-20020ac87dd0000000b0042a485706a7mr172271qte.28.1706584271050; Mon, 29 Jan
 2024 19:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124084636.1415652-1-xu.yang_2@nxp.com> <CAGETcx9h8gA8EenyR0B0OPa23uw_8dk-Kft8c8+F3StfpyMtaw@mail.gmail.com>
 <DU2PR04MB8822047A07680596415A61358C7A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
 <CAGETcx8HeseChCoOzOkUNf_LyXbVqgyisuHy_9U=PcP74NwV4A@mail.gmail.com> <DU2PR04MB8822693748725F85DC0CB86C8C792@DU2PR04MB8822.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB8822693748725F85DC0CB86C8C792@DU2PR04MB8822.eurprd04.prod.outlook.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 29 Jan 2024 19:10:33 -0800
Message-ID: <CAGETcx-1x1sXnOsPsPOJkrtRJTGzC4Tb5LqVBWCffV50NViXbQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] driver core: improve cycle detection on fwnode graph
To: Xu Yang <xu.yang_2@nxp.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:00=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Hi Saravana,
>
> >
> > On Wed, Jan 24, 2024 at 8:21=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wro=
te:
> > >
> > I think my confusion was because you use ----> in the opposite way to
> > what I have used for all my fw_devlink and cycle detection patches.
>
> Okay, I will follow the usage of "-->" later as yours.
>
> >
> > The part I was referring to is related to how driver/of/property.c has
> > node_not_dev set to true for pasrse_remote_endpoint.
> >
> > > >
> > > > 4. Has this actually caused an issue? If so, what is it? And give m=
e
> > > > an example in an upstream DT.
> > >
> > > Yes, there are two cycles (B.EP->A->C->B and B.EP->A/A.EP->B) in abov=
e
> > > example. But only one cycle (B.EP->A->C->B) is recognized.
> > >
> > > My real case as below:
> >
> > I think you still missed some details because usb3_phy0 seems
>
> One line is indeed missing in usb3_phy0.
>
> > irrelevant here. Can you just point me to the dts (not dtsi) file for
> > this platform in the kernel tree?
>
> This parts of dts is not in upstream kernel tree due to some reasons.
> Allow me to show the necessary parts as below again, you can also
> get the full dts file from the link I attached below:
>
> ---
> ptn5110: tcpc@50 {
>     compatible =3D "nxp,ptn5110";
>     ...
>
>     port {
>         typec_dr_sw: endpoint {
>             remote-endpoint =3D <&usb3_drd_sw>;
>         };
>     };
> };
>
> usb_dwc3_0: usb@38100000 {
>     compatible =3D "snps,dwc3";
>     phys =3D <&usb3_phy0>, <&usb3_phy0>;
>     ...
>
>     port {
>         usb3_drd_sw: endpoint {
>             remote-endpoint =3D <&typec_dr_sw>;
>         };
>     };
> };
>
> usb3_phy0: usb-phy@381f0040 {
>     compatible =3D "fsl,imx8mp-usb-phy";
>     vbus-power-supply =3D <&ptn5110>;
>
>     ...
> };
>
> > Also, can you change all the pr_debug and dev_dbg in
> > drivers/base/core.c to their info equivalent and boot up the system
> > and give me the logs? That'll be a lot easier for me to understand
> > your case.
>
> Thank you for willing to debug this issue.
> The boot log and dts file is under:
> https://drive.google.com/drive/folders/1hlkzg042q5_b5l59DCW2pECXRmTH4Vy_?=
usp=3Dsharing
>
> >
> > So let's say I see your logs and what you say is true, but you still
> > aren't telling me what's the problem you have because of this
> > incorrect cycle detection. What's breaking? Is something not allowed
> > to probe? If so, which one? What's supposed to be the right order of
> > probes?
> >
>
> Let me describe the issue again based on above log and dts:
>
>                     usb
>                   +-----+
>    tcpc           |     |
>   +-----+         |  +--|
>   |     |----------->|EP|
>   |--+  |         |  +--|
>   |EP|<-----------|     |
>   |--+  |         |  B  |
>   |     |         +-----+
>   |  A  |            |
>   +-----+            |
>      ^     +-----+   |
>      |     |     |   |
>      +-----|  C  |<--+
>            |     |
>            +-----+
>            usb-phy
>
> Node A (tcpc) will be populated as device 1-0050.
> Node B (usb) will be populated as device 38100000.usb.
> Node C (usb-phy) will be populated as device 381f0040.usb-phy.
>
> 1. Node C is populated as device C. But nodes A and B are still not
>    populated. When do cycle detection with device C, no cycle is found.
> 2. Node B is populated as device B. When do cycle detection with device
>    B, it found a fwnode link cycle B-->C-->A-->B.EP. Then, fwnode link
>    A-->B.EP, C-->A and B-->C are marked as cycle. The fwnode link B-->C
>    is converted to device link too.
> 3. Node A is populated as device A. When do cycle detection with device
>    A, it find C-->A is marked as cycle and convert it to device link. It
>    also find A-->B.EP is marked as cycle but will not convert it to devic=
e
>    link since node B.EP is not a device.
>
> Finally, fwnode link B-->C and C-->A is removed, A-->B.EP is only marked
> as cycle and B-->A.EP is neither been marked as cycle nor removed.
>
> So there are 2 cycles and only the first cycle is detected.
> 1. B-->C-->A-->B.EP--B
> 2. B-->A.EP--A-->B.EP--B
>
> In the end, device 38100000.usb (node B) is defered probe due to node B
> still has a supplier node A.EP.
> Device 1-0050 (node A) is also defered probe due to it depends on one dev=
ice
> which is created by 38100000.usb.
>
> The normal behavior is all of the devices can be successfully probed afte=
r two
> cycles are detected.
>

This took me several hours to debug this and I almost gave you the
"wrong" fix. A fix to create fwnode links between A --> and B --> A in
your example and remove EPs from the loop. But when typing up the
commit text, I realized what I was saying wasn't correct because this
cycle detection works fine if you don't have "C" in the example. Yet
again this bug comes down to my attempt to optimize some "unnecessary"
cycle detection logic that ended up being necessary.

Here's a test patch that I'm 99% sure will fix your issue. Please give
it a shot and let me know. After that, I need to run some more local
tests to make sure I'm not messing anything else up, clean up some
redundant logging, and then I can send a proper fix upstream.

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..75203ccc96f6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2060,7 +2060,6 @@ static int fw_devlink_create_devlink(struct device *c=
on,
         * SYNC_STATE_ONLY device links don't block probing and supports cy=
cles.
         * So cycle detection isn't necessary and shouldn't be done.
         */
-       if (!(flags & DL_FLAG_SYNC_STATE_ONLY)) {
                device_links_write_lock();
                if (__fw_devlink_relax_cycles(con, sup_handle)) {
                        __fwnode_link_cycle(link);
@@ -2069,7 +2068,6 @@ static int fw_devlink_create_devlink(struct device *c=
on,
                                 sup_handle);
                }
                device_links_write_unlock();
-       }

        if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
                sup_dev =3D fwnode_get_next_parent_dev(sup_handle);

Thanks,
Saravana


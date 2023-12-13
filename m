Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141D81192A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjLMQXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMQXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:23:33 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2E083
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:23:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c2c5a8150so65405425e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702484613; x=1703089413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsdEQAXsgtznujqAEAvqQItQWpAu92BPfR9s82X+6vY=;
        b=R522+d3Vdq5SRgszO+0NY/X9khJe276EPp3QT1/8ByctFNrKh/p3CCFy73yNVRce4s
         4RCW+PEO0TUeGAwhDXTO0tmODWmVS4FubQFd1VCuvvJLonZtFIs3yfonk4BFdx3GfTuy
         Nwml/ounwUGKjPtJP9Pq/Ehz87by623RPjtXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484613; x=1703089413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsdEQAXsgtznujqAEAvqQItQWpAu92BPfR9s82X+6vY=;
        b=cKx8wYIrmWogHREcHSeaE1sOrvDWuzFkpwvqnpjyXdl1LLa3n0THn81TNGcT6u4tLL
         v5/aFEnDhUFHZGaY7Ocu49ogHAoYDpXizz5lDJj4WOhvyLV3pJcqpH+tIioo9mcZtraK
         IEhQQpiccTFKcgrVU0BzSkCjjrHmFsfSfCcQpRCEEnTlO4CjC8/8RIznMIoKelsjGC13
         zR8xoL5Y/J7FFSLdLC/1U9JD/SWBUJf9T/040DgacjNVnT/OrYCUYBsXqobCO/Tspw65
         IviroS2NWopDWV6fvc9hO8kgmNjYssRp7HbP5BQNsCapN+V8MRNJK7DC6DDwyuiGDo92
         pfbg==
X-Gm-Message-State: AOJu0YyKgNiY1g1fvGFHP89zIjyNyXeaBgh1n6ogFOLg1U/Nr0BBsm4L
        QH5EgXbPFw77ugiy6Xy+7YVGbePB2zi4JYtNNZi50Qax
X-Google-Smtp-Source: AGHT+IEXztIrijW8cjoCLpw51Bf3U9o6ivfyf7EDIi41Z8pjSc+og3hPBIujuVpvYFPUPqNTq928cA==
X-Received: by 2002:a05:600c:501e:b0:40b:5e21:ec0d with SMTP id n30-20020a05600c501e00b0040b5e21ec0dmr4377342wmr.63.1702484612874;
        Wed, 13 Dec 2023 08:23:32 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id vb2-20020a170907d04200b00a1f72df5617sm7655076ejc.141.2023.12.13.08.23.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:23:32 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso74785e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:23:31 -0800 (PST)
X-Received: by 2002:a05:600c:5113:b0:40b:4221:4085 with SMTP id
 o19-20020a05600c511300b0040b42214085mr424914wms.1.1702484610953; Wed, 13 Dec
 2023 08:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20231207081801.4049075-1-treapking@chromium.org>
 <20231207081801.4049075-5-treapking@chromium.org> <CAD=FV=U6M5rpQXmjC+iGf0BGtiyjRAAcMfo4Fr3pDyYVp3m4aQ@mail.gmail.com>
 <fctpvshu5ychxketsf35jfg2qzi6i3nfup5hy7r7hzmmbpd2j4@xmsik3cycjlj>
 <CAD=FV=V=K9L=bJiNvFJ+K_DHUTPxA4WtukXA+E_VW6uihE8kdQ@mail.gmail.com> <cplpgkl5b3nrtdhxauleep6zo2rwic7h7fiwr4wnvrwk6uzxgw@dcgknug2gsaa>
In-Reply-To: <cplpgkl5b3nrtdhxauleep6zo2rwic7h7fiwr4wnvrwk6uzxgw@dcgknug2gsaa>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Dec 2023 08:23:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UiF9d5C=da64dj_JnGWuO_vGUg1hgzXSQd0x+pFpe23w@mail.gmail.com>
Message-ID: <CAD=FV=UiF9d5C=da64dj_JnGWuO_vGUg1hgzXSQd0x+pFpe23w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/panel-edp: Add some panels with conservative timings
To:     Maxime Ripard <mripard@kernel.org>,
        Pin-yen Lin <treapking@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 13, 2023 at 7:34=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> > > > Repeating my comments from v1 here too, since I expect this patch t=
o
> > > > sit on the lists for a little while:
> > > >
> > > >
> > > > This is OK w/ me, but it will need time on the mailing lists before
> > > > landing in case anyone else has opinions.
> > >
> > > Generally speaking, I'm not really a fan of big patches that dump
> > > whatever ChromeOS is doing ...
> > >
> > > > Specifical thoughts:
> > > >
> > > > * I at least feel fairly confident that this is OK since these pane=
ls
> > > > essentially booted without _any_ delays back on the old downstream
> > > > v4.19 kernel. Presumably the panels just had fairly robust timing
> > > > controllers and so worked OK, but it's better to get the timing mor=
e
> > > > correct.
> > >
> > > ... especially since you have to rely on the recollection of engineer=
s
> > > involved at the time and you have no real way to test and make things
> > > clearer anymore, and we have to take patches in that are handwavy "tr=
ust
> > > us, it's doing the right thing".
> > >
> > > I'd really prefer to have these patches sent as they are found out.
> >
> > It's probably not clear enough from the commit message, but this isn't
> > just a dump from downstream 4.19. What happened was:
> >
> > 1. Downstream chromeos-4.19 used the "little white lie" approach. They
> > all claimed a specific panel's compatible string even though there
> > were a whole pile of panels out there actually being used. Personally,
> > this was not something I was ever a fan of (and I wasn't personally
> > involved in this project), but it was the "state of the art" before
> > the generic panel-edp. Getting out of the "little white lie" situation
> > was why I spent so much time on the generic edp-panel solution
> > upstream.
> >
> > 2. These devices have now been uprevved to a newer kernel and I
> > believe that there were issues seen that necessitated a move to the
> > proper generic panel-edp code.
> >
> > 3. We are now getting field reports from our warning collector about a
> > whole pile of panels that are falling back to the "conservative"
> > timings, which means that they turn on/off much more slowly than they
> > should.
> >
> > Pin-yen made an attempt to search for panels data sheets that matched
> > up with the IDs that came in from the field reports but there were
> > some panels that he just couldn't find.
> >
> > So basically we're stuck. Options:
> >
> > 1. Leave customers who have these panels stuck with the hardware
> > behaving worse than it used to. This is not acceptable to me.
> >
> > 2. Land Pin-yen's patch as a downstream-only patch in ChromeOS. This
> > would solve the problem, but it would make me sad. If anyone ever
> > wants to take these old laptops and run some other Linux distribution
> > on them (and there are several that target old Chromebooks) then
> > they'd be again stuck with old timings.
> >
> > 3. Land a patch like this one that at least gets us into not such a bad=
 shape.
> >
> > While I don't love this patch (and that's why I made it clear that it
> > needs to spend time on the list), it seems better than the
> > alternatives. Do you have a proposal for something else? If not, can
> > you confirm you're OK with #3 given this explanation? ...and perhaps
> > more details in the commit message?
>
> I don't have a specific comment, it was more of a comment about the
> process itself, if you write down what's above in the commit message ...

Pin-yen: can you take a whack at summarizing some of the above in the
commit message and sending out a v3?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D4C7A73E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjITHWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjITHWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:22:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D469893;
        Wed, 20 Sep 2023 00:22:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so72705745e9.0;
        Wed, 20 Sep 2023 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695194544; x=1695799344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bhVmf9Xb0W3PnpeUv/b1V4dB6FaBxpZCDQFmYEoS+s=;
        b=FmOzVrqNOBSJZOXzZGu2uSrZgTnRVXHP2xxmrLSF0uzkHH/AWCCGlj7ZakwXoaUkmo
         OHRQAoKWL0yyaZIiDYmAYcr1fpgHw2GvcXfn7RAHYLWGDGITRA+zHpVLWb6l6Fg0kNNK
         tT3e7ZhfMdCaqbNADgLGDXUDrLsayjZiQzjnFqirlAZB5UqffvrAsBCnxb5gOYnoClv9
         cHJD1Qp2TgOQPp68uLwrUZr9pChr3Yor6E6Wr9C5FMc69MSiPUmpG19vVbCD26WuWtOQ
         TYyHHaadO5SscTnOMyjl5ljSTHwND63xX/SCgUcqxyOFcPJH6Qm3HOHS8qtSEopE5FXO
         aI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695194544; x=1695799344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bhVmf9Xb0W3PnpeUv/b1V4dB6FaBxpZCDQFmYEoS+s=;
        b=UG+wJgArIesCPR1I5rqpqxRKn16DbmCozlqAhifCI2RAcIk5KX8EB0sjAiOsbdkvFw
         x0hEQ8zygBLbY5n5sN0uRMyPHdtOKesawsAFIMtkWR0Xd2x+zQjJu6ZuBWXDahOXb+sG
         TjjB4ucYXjqJoVNDcW2eM+AlBOt5BGYIPoHxiim52YLqJ7Vi3z6iLWXBh/AQlUwO60zr
         Qtowx1/Dk6skBAW3yPXwoV4ja0vAmenMcnAsh5QXBB37BNQnNHkxTj4jlO8/eC4DQNca
         xkAolhWGfs25Qmq9XUHnnH99MIZHQoRdF4ilQi3+qAc94/OJVUbYAfmX8ZCS2cBmJdr6
         PxMw==
X-Gm-Message-State: AOJu0YxiohpDJ1QvDqHfuQt/rBioXqji5GNMP1fMHs+yaUIjdG0KsPR3
        FMm8adqX4L1anaFB8Gx0yK8=
X-Google-Smtp-Source: AGHT+IHhx4uy7+lhAAone/xKFAY7os8e9wsVKqyqvDOdNWqQ9Nb+5vwmAcbdDNQiKjqhnufHlkQO9Q==
X-Received: by 2002:a1c:f70f:0:b0:403:bb3:28c9 with SMTP id v15-20020a1cf70f000000b004030bb328c9mr1721441wmh.38.1695194543932;
        Wed, 20 Sep 2023 00:22:23 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d4a90000000b0031ffb51f6f9sm13119633wrq.30.2023.09.20.00.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:22:23 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     mripard@kernel.org
Cc:     abelvesa@kernel.org, bbara93@gmail.com, benjamin.bara@skidata.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        festevam@gmail.com, frank@oltmanns.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mturquette@baylibre.com, peng.fan@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        shawnguo@kernel.org
Subject: Re: [PATCH 06/13] clk: keep track if a clock is explicitly configured
Date:   Wed, 20 Sep 2023 09:22:16 +0200
Message-Id: <20230920072216.1737599-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pgnlrokdqqqclqvp4h2zk7iyq2jfncnvvwavovydovdmj3d2gf@kszpslmeswbr>
References: <pgnlrokdqqqclqvp4h2zk7iyq2jfncnvvwavovydovdmj3d2gf@kszpslmeswbr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime!

thanks for taking the time to look through :)

On Tue, 19 Sept 2023 at 09:07, Maxime Ripard <mripard@kernel.org> wrote:
> On Mon, Sep 18, 2023 at 12:40:02AM +0200, Benjamin Bara wrote:
> > From: Benjamin Bara <benjamin.bara@skidata.com>
> >
> > When we keep track if a clock has a given rate explicitly set by a
> > consumer, we can identify unintentional clock rate changes in an easy
> > way. This also helps during debugging, as one can see if a rate is set
> > by accident or due to a consumer-related change.
> >
> > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > ---
> >  drivers/clk/clk.c            | 25 +++++++++++++++++++++++++
> >  include/linux/clk-provider.h |  1 +
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 8f4f92547768..82c65ed432c5 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -70,6 +70,7 @@ struct clk_core {
> >       unsigned long           rate;
> >       unsigned long           req_rate;
> >       unsigned long           new_rate;
> > +     unsigned long           set_rate;
>
> This is pretty much what req_rate is supposed to be about. Why didn't it
> work in your case?

I picked this one to respond first because I think some of the
implemented stuff just workarounds the current req_rate behaviour.

Currently, I have two "problems" with it:
1. It's set during initialization[1]. In this phase, the *required* rate
   isn't known yet, so it should be 0 imo.
2. It's set during re-parenting[2,3]. Also here, just because we
   re-parent, the active consumer (which set the req_rate to a valid
   value) still requires the clock to have the same rate.

That is basically the reason why we have no info if the req_rate is
really "required" by a consumer or if it is just set because the parent
had it at some time. It's only usage is here[4], which IMO doesn't
really depends on the wrong behaviour I described above.

The respective sub-tree we talk about on the imx8mp looks like this (one
example for the the LVDS-only case):
video_pll1 (pll; 7x crtc rate - currently, rate is assigned via dt)
  video_pll1_bypass (mux; 7x crtc rate)
    video_pll1_out (gate; 7x crtc rate)
      media_ldb (divider; 7x crtc rate)
        media_ldb_root_clk (gate; 7x crtc rate)
      media_disp2_pix (divider; 1x crtc rate)
        media_disp2_pix_root_clk (gate; 1x crtc rate)
      media_disp1_pix (divider; unused for now)
        media_disp1_pix_root_clk (gate; unused for now)

The problem is that the panel driver sets media_disp1_pix_root_clk,
ldb-bridge driver sets media_ldb_root_clk. All the others have a
req_rate of the rate video_pll1 had when they got initialized or
re-parented.

My idea was, that when media_disp2_pix_root_clk is set to the CRTC rate,
IMO all clocks along the line (especially media_disp1_pix, which is
"seen" as child of the PLL, and the actual divider for
media_disp2_pix_root_clk) need to set their new rate as "required",
because the subtree below them relies on it. This might be a wrong
approach. It might be sufficient to have a req_rate only on the nodes
that actually require it. However, IMHO we need to make sure that *all*
required rates (especially the ones of leaves!) are respected after a
change. Meaning if we e.g. request video_pll1 to change again (this time
by media_ldb_root_clk), we have to ensure that media_disp2_pix_root_clk
has still the rate which has been set as req_rate before.

Ultimately, my trigger patch is also just a really bad workaround for a
new_rate != req_rate check, so I want to re-build the idea behind it
based on a differently defined req_rate. Need to take a deeper look on
that.

Thanks & regards
Benjamin

[1] https://elixir.bootlin.com/linux/v6.5.3/source/drivers/clk/clk.c#L3891
[2] https://elixir.bootlin.com/linux/v6.5.3/source/drivers/clk/clk.c#L2726
[3] https://elixir.bootlin.com/linux/v6.5.3/source/drivers/clk/clk.c#L2812
[4] https://elixir.bootlin.com/linux/v6.5.3/source/drivers/clk/clk.c#L2592

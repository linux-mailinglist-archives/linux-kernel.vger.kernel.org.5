Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AD7FC21C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbjK1Qz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjK1Qzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:55:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33BBD6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:56:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADB1C433C7;
        Tue, 28 Nov 2023 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701190560;
        bh=1/vAPR7lExHewwrt4YPc68Q6LJPmxu5gmOul2lvJVzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d+zuPUTIO3bYfTQI4QyUZ91Mlnlso/RZ3PL/AjXCTMjuDLetnv7buSrxhhqVxNuiD
         94MaNGJO4HeS4ANrmr0ROiio456pnMxdOgFCAeuhQb4ud1zj3djWrGPOjWPIxGEp/u
         Vi3fKOUMMH6q7yIn9dAuEQAXmZ6fsJVUQaGcglHMbasqSW8PS015GOEpyPVWRKv+OX
         b8Yn5iYoAPvqhVGz5fdZl1DWvOiL33R7bynp192P3e4I2ToVFhXKLWjh8bbtATVAsD
         7LWknf0Uc0xmWZBUP+R4EsmnqihPFkfbqF/N1AyhbFd+0UUuWVjosOVTX901N4+1UX
         R+8dfkg4hh3Bg==
MIME-Version: 1.0
Date:   Tue, 28 Nov 2023 17:55:53 +0100
From:   Michael Walle <mwalle@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
        dave.stevenson@raspberrypi.com, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        marijn.suijten@somainline.org, mripard@kernel.org,
        neil.armstrong@linaro.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, rfoss@kernel.org, sean@poorly.run,
        tzimmermann@suse.de, tony@atomide.com,
        alexander.stein@ew.tq-group.com
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
In-Reply-To: <CAA8EJpphwXoKnzDkY3cBqzsDZwdw+nze-Ev2toPBJm-2VJvY_g@mail.gmail.com>
References: <CAA8EJpozZkEswnioKjRCqBg4fcjVHFwGivoFNTNHVwyocKprQw@mail.gmail.com>
 <20231127160658.2164612-1-mwalle@kernel.org>
 <CAA8EJpphwXoKnzDkY3cBqzsDZwdw+nze-Ev2toPBJm-2VJvY_g@mail.gmail.com>
Message-ID: <dce76a6e1321a6374ad39125bead56b3@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> > DSI device lifetime has three different stages:
>> > 1. before the DSI link being powered up and clocking,
>> > 2. when the DSI link is in LP state (for the purpose of this question,
>> > this is the time between the DSI link being powered up and the video
>> > stream start)
>> > 3. when the DSI link is in HS state (while streaming the video).
>> 
>> It's not clear to me what (2) is. What is the state of the clock and
>> data lanes?
> 
> Clk an Data0 should be in the LP mode, ready for LP Data Transfer.

Then this is somehow missing
https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operation

   A DSI host should keep the PHY powered down until the pre_enable 
operation
   is called. All lanes are in an undefined idle state up to this point, 
and
   it must not be assumed that it is LP-11. pre_enable should initialise 
the
   PHY, set the data lanes to LP-11, and the clock lane to either LP-11 
or HS
   depending on the mode_flag MIPI_DSI_CLOCK_NON_CONTINUOUS.

So I don't think these three states are sufficient, see below, that 
there
should be at least four.

-michael

> 
> I don't think we support ULPS currently.
> 
> 
>> 
>> I'm facing similar issues with the tc358775 bridge. This bridge needs
>> to release its reset while both clock and data lanes are in LP-11 
>> mode.
>> But then it needs to be configured (via I2C) while the clock lane is
>> in enabled (HS mode), but the data lanes are still in LP-11 mode.
>> 
>> To me it looks like there is a fouth case then:
>> 1. unpowered
>> 2. DSI clock and data are in LP-11
>> 3. DSI clock is in HS and data are in LP-11
>> 4. DSI clock is in HS and data is in HS
>> 
>> (And of course the bridge needs continuous clock mode).
>> 
>> > Different DSI bridges have different requirements with respect to the
>> > code being executed at stages 1 and 2. For example several DSI-to-eDP
>> > bridges (ps8640, tc358767 require for the link to be quiet during
>> > reset time.
>> > The DSI-controlled bridges and DSI panels need to send some commands
>> > in stage 2, before starting up video
>> >
>> > In the DRM subsystem stage 3 naturally maps to the
>> > drm_bridge_funcs::enable, stage 1 also naturally maps to the
>> > drm_bridge_funcs::pre_enable. Stage 2 doesn't have its own place in
>> > the DRM call chain.
>> > Earlier we attempted to solve that using the pre_enable_prev_first,
>> > which remapped pre-enable callback execution order. However it has led
>> > us to the two issues. First, at the DSI host driver we do not know
>> > whether the panel / bridge were updated to use pre_enable_prev_first
>> > or not. Second, if the bridge has to perform steps during both stages
>> > 1 and 2, it can not do that.
>> >
>> > I'm trying to find a way to express the difference between stages 1
>> > and 2 in the generic code, so that we do not to worry about particular
>> > DSI host and DSI bridge / panel peculiarities when implementing the
>> > DSI host and/or DSI panel driver.
>> 
>> For now, I have a rather hacky ".dsi_lp11_notify" callback in
>> drm_bridge_funcs which is supposed to be called by the DSI host while 
>> the
>> clock and data lanes are in LP-11 mode. But that is rather an RFC and 
>> me
>> needing something to get the driver for this bridge working. Because 
>> it's
>> badly broken. FWIW, you can find my work-in-progress patches at
>> https://github.com/mwalle/linux/tree/feature-tc358775-fixes
>> 
>> -michael
>> 
> 
> 
> --
> With best wishes
> Dmitry

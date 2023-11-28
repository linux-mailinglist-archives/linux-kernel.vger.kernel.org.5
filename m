Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433B67FC9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbjK1Woa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjK1Wo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:44:29 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06E11998;
        Tue, 28 Nov 2023 14:44:35 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id BD9BF323;
        Tue, 28 Nov 2023 23:44:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1701211473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMdaszjmHghx02rDq1Oy91uT9YTXeu24D5SoecBFShI=;
        b=Bz6rbpsRlDLXQu7iPJGh4cDpMtvt9UH/JNiuHy0U5yvZwAec30mWSQjEnLdr+GG9ILGZHM
        Y+6/gZPCexw9YqoS+PALoNMdmVZNDDh8ytuMPxB9Zbf8e+JAQ0joYWk4JsbCSAsPFoCNvF
        4DY10E9QotmRPLrodIIigVD9YPSxHSfdhVVxYP/Yyqfk/4zNGh0jwPdW9jyucCephWpZ43
        6Wz3hG86neR4QQqKDc6J2gebUy7Ym9n69678zrQAdsL38S4QWCNFte+XE5ZmTVmodR6/FZ
        pKZm2XUmNApgbnyFJRioes5y9Dgl/8Oo2RvUr1YO8gQSLrgOT/3/6qNdbhHBGg==
MIME-Version: 1.0
Date:   Tue, 28 Nov 2023 23:44:33 +0100
From:   Michael Walle <michael@walle.cc>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Michael Walle <mwalle@kernel.org>,
        Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
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
In-Reply-To: <CAA8EJppAhfm4FK4z_B=h9+o7LScjCyUD0XvdzQCe6tjrRx5KbA@mail.gmail.com>
References: <CAA8EJpozZkEswnioKjRCqBg4fcjVHFwGivoFNTNHVwyocKprQw@mail.gmail.com>
 <20231127160658.2164612-1-mwalle@kernel.org>
 <CAA8EJpphwXoKnzDkY3cBqzsDZwdw+nze-Ev2toPBJm-2VJvY_g@mail.gmail.com>
 <dce76a6e1321a6374ad39125bead56b3@kernel.org>
 <CAA8EJpr9PDgSrTpP2-joQ09fxmJKZB1B+ESbDbMjkLNiqZ1m3A@mail.gmail.com>
 <14D9F495-425D-47FA-AD0D-F7299285936F@walle.cc>
 <CAA8EJpoYkH-0onMmNRk1iO5YeLN+5hpZMsfvtNo-7p6y2mjZwg@mail.gmail.com>
 <5eeade839ad3f71e8976965ce6cf3ed2@walle.cc>
 <CAA8EJppAhfm4FK4z_B=h9+o7LScjCyUD0XvdzQCe6tjrRx5KbA@mail.gmail.com>
Message-ID: <634164b4a8085770bd06134c1d328d8b@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm facing similar issues with the tc358775 bridge. This bridge needs
>> to release its reset while both clock and data lanes are in LP-11
>> mode.
>> But then it needs to be configured (via I2C) while the clock lane is
>> in enabled (HS mode), but the data lanes are still in LP-11 mode.
> 
> This is quite an interesting requirement. For example, I'm not 100%
> sure whether we can get that done on our (msm) hosts. I need to double
> check that.
> What frequency is expected on the CLK lane? Can it be an arbitrary
> frequency or it should be the same freq as the one used later for the
> video transfer?

I presume it has to be the same frequency as the video stream later.
That's a least what I have successfully tested.
The datasheet doesn't mention if a frequency switch is allowed on the
clock lane (which would need a brief switch to LP mode, I presume). I'd 
say
it's not allowed/supported as the bridge is very picky regarding the 
init
sequence in general.

I'm using the Mediatek DSI host, where that sequence is possible. I.e. 
you
just enable the clock and data lanes in continuous clock mode, but don't
enable the video stream, which should leave the data lanes in LP-11 
mode.

Sometimes you also have a command mode (instead of a video mode). And if
you don't send any commands, the data lanes are in LP-11 mode, too.

-michael

>> Therefore, for the correct init sequence is:
>> (1) dsi host enables lanes, that is clock and data are in lp-11
>> (2) dsi bridge driver releases reset of the bridge
>> (3) dsi host enables clock lane, leaves data lanes in lp-11
>> (4) dsi bridge driver configures the bridge
>> (5) dsi host enables the video stream
>> (6) dsi bridge enables the output port of the bridge

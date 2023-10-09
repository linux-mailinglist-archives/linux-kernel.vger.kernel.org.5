Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A27BD1EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 04:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344998AbjJICVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 22:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjJICVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 22:21:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B43BA4;
        Sun,  8 Oct 2023 19:21:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 246BA7E2;
        Mon,  9 Oct 2023 04:21:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696818075;
        bh=ot+x92A9imuYrYSeW7vRsep0XLo94ZWmYnGMxer6Ljw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GR6vFG/p2D8Clyfe14u8xUOaJWw2cDwjjZfn5LdsgPKw8eCQ/cwbs6rjn5hN5Dyw1
         TTrE7K83jX2w762UnHNKie2jN0Rcys7kpScvV+d8cONCOnl0odULCMvY8C76OG7rwY
         3yjoVagkaPjdysFXMrNqWdMWD6N7+6JBStCCQYwY=
Date:   Mon, 9 Oct 2023 05:21:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v6 0/3] media: i2c: Introduce driver for the TW9900 video
 decoder
Message-ID: <20231009022122.GH5121@pendragon.ideasonboard.com>
References: <cover.1696608809.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696608809.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 06:25:27PM +0200, Mehdi Djait wrote:
> Hello everyone,
> 
> This series is based on the fifth iteration of the series introducing the
> tw9900 driver: sent 29 Dec 2020 [1]
> 
> This is the version 6 of the series adding support for the Techwell
> TW9900 multi standard decoder. It's a pretty simple decoder compared to
> the TW9910, since it doesn't have a built-in scaler/crop engine.
> 
> Changes v5 => v6:
> - dropped .skip_top and .field in the supported_modes
> - added error handling for the i2c writes/reads
> - added the colorimetry information to fill_fmt
> - removed pm_runtime

It's not very nice to keep the chip powered up all the time :-(

> - added the g_input_status callback
> - dropped SECAM
> - dropped the non-standard PAL/NTSC variants
> 
> Any feedback is appreciated,
> 
> Mehdi Djait
> 
> media_tree, base-commit: 2c1bae27df787c9535e48cc27bbd11c3c3e0a235
> 
> [1] https://lore.kernel.org/linux-media/20210401070802.1685823-1-maxime.chevallier@bootlin.com/
> 
> Mehdi Djait (3):
>   dt-bindings: vendor-prefixes: Add techwell vendor prefix
>   media: dt-bindings: media: i2c: Add bindings for TW9900
>   media: i2c: Introduce a driver for the Techwell TW9900 decoder
> 
>  .../bindings/media/i2c/techwell,tw9900.yaml   |  61 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   6 +
>  drivers/media/i2c/Kconfig                     |  12 +
>  drivers/media/i2c/Makefile                    |   1 +
>  drivers/media/i2c/tw9900.c                    | 651 ++++++++++++++++++
>  6 files changed, 733 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
>  create mode 100644 drivers/media/i2c/tw9900.c

-- 
Regards,

Laurent Pinchart

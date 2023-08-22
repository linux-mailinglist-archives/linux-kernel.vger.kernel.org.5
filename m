Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3501878427F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjHVNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjHVNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B620F1A1;
        Tue, 22 Aug 2023 06:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47ACC6572A;
        Tue, 22 Aug 2023 13:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAA7C433C7;
        Tue, 22 Aug 2023 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692712485;
        bh=OZdk+L9lV/tUVafdBKQSUhvJ0WoEpL/rmRTFTm+vvng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apzzx2iRS7drX7IIQCP8qIt0eKye5QX1aSRRzQcePIv9xVzvqs0WcQVMUjCvHxcND
         Bkf+pVYdoPedujn1TuOq9bPh4wXU1isdkuJ7pzUGkETPkuVYczq7H/AziHyepJqdjc
         hSCk5pyNAjtlYOjXb/7x4JGzKGOzO/SpBXpj7E2ECKMwsti0cznxhzFu8AzBRbrzfa
         A7Eb2/76/0PKEyHMv7zwjTCzE3V0pCKAt4/vorhCud8vK9Zj2fZeCzXtKpJwmuvQmp
         bCRD1lmD3bHv788Ed/MG9prmcrKKcJciJWrASB8vXisoxyOnQ6lpgcwuN8vxghkzGp
         WpnyrEm6irNPw==
Date:   Tue, 22 Aug 2023 19:24:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sandor Yu <Sandor.yu@nxp.com>, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kernel@pengutronix.de,
        linux-imx@nxp.com, oliver.brown@nxp.com,
        alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v8 2/7] phy: Add HDMI configuration options
Message-ID: <ZOS+IQgFZYxN503B@matsya>
References: <20230808083243.3113192-1-Sandor.yu@nxp.com>
 <20230808083243.3113192-3-Sandor.yu@nxp.com>
 <c485b64e-3c83-4616-b8d8-76c2c7d56b0e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c485b64e-3c83-4616-b8d8-76c2c7d56b0e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-23, 13:05, Dmitry Baryshkov wrote:
> On 08/08/2023 11:32, Sandor Yu wrote:
> > Allow HDMI PHYs to be configured through the generic
> > functions through a custom structure added to the generic union.
> > 
> > The parameters added here are based on HDMI PHY
> > implementation practices.  The current set of parameters
> > should cover the potential users.
> > 
> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > ---
> >   include/linux/phy/phy-hdmi.h | 24 ++++++++++++++++++++++++
> >   include/linux/phy/phy.h      |  7 ++++++-
> >   2 files changed, 30 insertions(+), 1 deletion(-)
> >   create mode 100644 include/linux/phy/phy-hdmi.h
> 
> I think this looks good now, thank you!
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Should this go thru drm or phy...?

> 
> -- 
> With best wishes
> Dmitry

-- 
~Vinod

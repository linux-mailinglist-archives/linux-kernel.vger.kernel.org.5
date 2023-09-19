Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057347A56E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 03:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjISBRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 21:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISBRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:17:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA8119
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 18:17:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-986d8332f50so697421266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 18:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695086232; x=1695691032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PvRZLPqqTs6XU4Vq4LYbTofQlpvUuAuHUNr6aENGrRU=;
        b=WTYerc/E5udU4hOtkwT/FaGAmqBEFumqfXIjV6sNhL24g6U4snFs5trc7RurPo8RlD
         UHMWRKhkPstXws1LgenJmaE1GZ9dsfh6wMH2PGYZUGSHiNF5hqFCyIqopjrb1fdH+av2
         8AOJXrASZ0QMVSbucru0v7pk9llkme8dV5x2sHng2h+9bARQ9NedOnRp9fiCEIYu49WB
         fWuACLcxu19GKEbz+WTtFlZ/YUfqCsr+/E+t2h0kHPhya2uMaBuzqlZqOm6272WOxujz
         q4aNQFTHgTZglzuyXS7g1nm0E/9gWJKfNymy5Gt3OL9Js91aT0xqHJB/BS95blbg3Kj3
         FTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695086232; x=1695691032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvRZLPqqTs6XU4Vq4LYbTofQlpvUuAuHUNr6aENGrRU=;
        b=r6kS6Fci3B/wmDE/R5QzvYggIXclJTkkzJ2tPD9niPhopuTiJhUfIVdSnsAsiaBwu/
         Z66RBOQMYw0NgK0PHa6GawQl/aNkFAiwQdvNLw7iHLd+n96f7qC2UaeZIYh5hdUH7Hx0
         7QWKoLCmDq3kgB+5Jgs022s+9vF6dXSCbkRRzL8Nfso83VTyjttrfbsjTN7YrUg6+WJq
         VR9jCFYM9lh2iMhVogXpBfp/H5QR9c1X4cCoWFy0M2ycGRpnMzQORKdmZGXCPEf/4tMx
         cHxLuQfx35FtxE+r1jMOPOyCDN854KMQaAM20ZZuUQdu7AHNkDR+heeHMU3oQufwOEce
         03iQ==
X-Gm-Message-State: AOJu0Yw62TzvPPOFKBYAWMH5WvIk36IjEy1LioPcwo38hge7X2Pxl48P
        EeBBG4wm5eQpEqrTqemVdkl2fg==
X-Google-Smtp-Source: AGHT+IEA/aai0FCc2yuuCJiETggbIYU6gkj8QXBRxDW/fJIwmR3c2jahedHvJ0G0qQaBP1Nk8v23ag==
X-Received: by 2002:a17:907:7717:b0:9a5:cc73:a2a6 with SMTP id kw23-20020a170907771700b009a5cc73a2a6mr9189708ejc.14.1695086232647;
        Mon, 18 Sep 2023 18:17:12 -0700 (PDT)
Received: from p14s (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906714a00b00991e2b5a27dsm6989592ejj.37.2023.09.18.18.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 18:17:12 -0700 (PDT)
Date:   Mon, 18 Sep 2023 19:17:09 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Laura Nao <laura.nao@collabora.com>, tinghan.shen@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v17 00/14] Add support for MT8195 SCP 2nd core
Message-ID: <ZQj2lSl47qZQv8fX@p14s>
References: <ZQH2dG+l/dONUsyi@p14s>
 <20230918103141.126271-1-laura.nao@collabora.com>
 <CAGXv+5Esi=G0xgkP=+Bhf39Xs3gMN1PBzarxKBKduOjgwDijAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5Esi=G0xgkP=+Bhf39Xs3gMN1PBzarxKBKduOjgwDijAA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 06:44:25PM +0800, Chen-Yu Tsai wrote:
> On Mon, Sep 18, 2023 at 6:32 PM Laura Nao <laura.nao@collabora.com> wrote:
> >
> > > Other than patch 2 and 14, I have applied this set.  The remaining patches will
> > > have to be resent to Matthias.
> >
> > > Thanks,
> > > Mathieu
> >
> > Hello,
> >
> > With patch 2 missing, the SCP is not probed correctly anymore on asurada (MT8192) and kukui (MT8183). The mtk-scp driver relies on the existence of the `cros-ec-rpmsg` node in the dt to determine if the SCP is single or multicore. Without patch 2 the driver wrongly assumes the SCP on MT8192 and MT8183 are multicore, leading to the following errors during initialization:
> >
> > 10696 04:33:59.126671  <3>[   15.465714] platform 10500000.scp:cros-ec: invalid resource (null)
> > 10697 04:33:59.142855  <3>[   15.478560] platform 10500000.scp:cros-ec: Failed to parse and map sram memory
> > 10698 04:33:59.149650  <3>[   15.486121] mtk-scp 10500000.scp: Failed to initialize core 0 rproc
> >
> > The issue was caught by KernelCI, complete logs can be found here:
> > - asurada: https://storage.kernelci.org/next/master/next-20230914/arm64/defconfig+arm64-chromebook+videodec/gcc-10/lab-collabora/baseline-nfs-mt8192-asurada-spherion-r0.html
> > - kukui: https://storage.kernelci.org/next/master/next-20230914/arm64/defconfig+arm64-chromebook+videodec/gcc-10/lab-collabora/baseline-nfs-mt8183-kukui-jacuzzi-juniper-sku16.html
> >
> > Reporting the issue so that patch 2 and 14 can be resent and merged soon.
> 
> This being a backward incompatible DT binding change, maybe we should revert
> the node name change. Or, the driver could simply count the number of child
> nodes that have the "mediatek,rpmsg-name" property, which is required.
> 

You have a point.  Can someone send a patch that makes this patchset backward
compatible?  Please do so as quickly as possible to that it can go in the next
merge window with the rest of this feature.  Otherwize I'll have to back out the
whole thing.

Thanks,
Mathieu

> ChenYu

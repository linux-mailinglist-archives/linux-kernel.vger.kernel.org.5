Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765E477E89D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbjHPSYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345524AbjHPSYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:24:50 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999B1986
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:24:49 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bcf2fd5d69so6017102a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692210288; x=1692815088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH3CkbS+no8xu7xLg3uZvAz4wzema/itwp2Tc+c167Q=;
        b=llZD2J6325NRzggUheb32gJnMOi0s+ae4Wl7M+BJK9y4mft/TBWwNVki7sdnPSIBgP
         0sGjTfxBw+CvxYl8en56GwsG/rqZVEOY3cv2nvoXeWLsI3qQbzU1He0r4Xco2aHaObgD
         cq/JIfDJBlkJQsT0zsDGjsyj48B8MzOmd5EX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692210288; x=1692815088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vH3CkbS+no8xu7xLg3uZvAz4wzema/itwp2Tc+c167Q=;
        b=MfHcabQa3fjiwmNHNq7fR7xdwZPl2o69+q4v/bMuhfA1vQMDlVLSRaAOAIt4mGiUpY
         +a6TNn5S513XvzHYXw1yXDbvIo2riTduRjwruFZntDXUT04RJWp8fL1CkmbJ65FcvXWS
         b+4ye2L5VAGQ41MbBTYbThV2AObVAA9uQbuxPMjM6SyQ/eONn7UCzonznH1sHvPvak9Y
         fA3KNGUrXWtTxsFX4kWR0IsGN6Jj7F9Th3dBqXZDkNMyBusxk3l/DwjuUE292FK2i8p4
         8weBY1zS/2ltkMbmANRaIVNyVumujHwscK8c+gRGhVDLsi1PMvWJjiv+oYI8ZxWKTPs6
         ARGg==
X-Gm-Message-State: AOJu0YxzYIYP/ZwiF+lcjdKW8BaRVq09x4QncWBe1e7RKaNjoO27bOv0
        3G9zmJK2i9zcg8XtzogwIQw1HeihBN4244otdwCCUg==
X-Google-Smtp-Source: AGHT+IFhH83WvJtRVMVm2GAtVDT3sTRvuK+g1KkIMZB0RU5RRarSlXYvZLoA25e52zZYKSGVkqvK7p18o08QNZFd3O4=
X-Received: by 2002:a9d:7d13:0:b0:6b9:9129:dddf with SMTP id
 v19-20020a9d7d13000000b006b99129dddfmr2763929otn.16.1692210288472; Wed, 16
 Aug 2023 11:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230816104245.2676965-1-hsinyi@chromium.org> <6702bac712daab13698b9bb9ad81d49e@walle.cc>
 <5911201a-f703-abbd-3c7b-769f70df08a8@linaro.org> <80ec748f37f40ae5c3c3c5d1602681b3@walle.cc>
 <0011a25a-e096-73ac-9800-9d8e35efdc8b@linaro.org>
In-Reply-To: <0011a25a-e096-73ac-9800-9d8e35efdc8b@linaro.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 17 Aug 2023 02:24:22 +0800
Message-ID: <CAJMQK-jgcH-OBQox3fisr0M0gbhFnSvKWCHwos2mtiRH7t8kVA@mail.gmail.com>
Subject: Re: [PATCH v2,1/2] mtd: spi-nor: giga: gd25lq64c: Disable quad mode
 according to bus width
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 8:34=E2=80=AFPM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
>
>
> On 8/16/23 13:22, Michael Walle wrote:
> > Hi,
> >
> >>> like a fundamental problem and that commit 39d1e3340c73 ("mtd: spi-no=
r:
> >>> Fix clearing of QE bit on lock()/unlock()") is broken in that regard.
> >>
> >> what's wrong with the mentioned commit?
> >
> >         } else if (nor->params->quad_enable) {
> >                 /*
> >                  * If the Status Register 2 Read command (35h) is not
> >                  * supported, we should at least be sure we don't
> >                  * change the value of the SR2 Quad Enable bit.
> >                  *
> >                  * We can safely assume that when the Quad Enable metho=
d is
> >                  * set, the value of the QE bit is one, as a consequenc=
e of the
> >                  * nor->params->quad_enable() call.
> >                  *
> >                  * We can safely assume that the Quad Enable bit is pre=
sent in
> >                  * the Status Register 2 at BIT(1). According to the JE=
SD216
> >                  * revB standard, BFPT DWORDS[15], bits 22:20, the 16-b=
it
> >                  * Write Status (01h) command is available just for the=
 cases
> >                  * in which the QE bit is described in SR2 at BIT(1).
> >                  */
> >                 sr_cr[1] =3D SR2_QUAD_EN_BIT1;
> >         } else {
> >                 sr_cr[1] =3D 0;
> >         }
> >
> > "We can safely assume that when the Quad Enable method..". We cannot, i=
f we
> > don't have 4 I/O lines. The quad_enable is just the op how to do it, bu=
t not
> > *if* can do it. It seems to be missing the same check as the
> > spi_nor_quad_enable(). But I'm not sure if it's that simple.
> >
>
> I see. Then extending the if condition should do the trick, as
> spi_nor_write_16bit_sr_and_check() is called after setup. Something
> like:
>
> if (spi_nor_get_protocol_width(nor->read_proto) =3D=3D 4 &&
>     spi_nor_get_protocol_width(nor->write_proto) =3D=3D 4 &&
>     nor->params->quad_enable)
>
> Is this what Hsin-Yi is hitting?

Yes, it is. Adding these checks can solve the issue. The read out
width for both read and write is 1, which matches the default bus
width.

Thanks.

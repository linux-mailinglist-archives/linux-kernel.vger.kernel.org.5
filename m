Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13324760C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGYIBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjGYIAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:00:50 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C8310E6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:00:38 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34617b29276so14953695ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690272037; x=1690876837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQlid0H2jkWZz9fgcu7Ae/8sWUNA4lIusDDxBLqkgag=;
        b=D7zcjVWHISOKLg5CW3OV5+PRipG/tReoZSnpZoJTsmG/5xs2L5TZMxig2uenVh9aAb
         EC/IGcb49Q5JfZm30NjwuQhVlW1lGuQuagBPMvfva1QvMkZHEXfV9Kyj/BWTUHmM9MqN
         SkVFwczLrYHXRDqvnF1bR3jpFLfjPmtjujptw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690272037; x=1690876837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQlid0H2jkWZz9fgcu7Ae/8sWUNA4lIusDDxBLqkgag=;
        b=WNKuZkC/iBrplfebarQsJ+YEYmaa8SiCUwDhRMzSicH+upEjNu/9wf1sXhh669nKlC
         FhFVnssLi7uRtR5Udt0xezN2WbkY8s0Z3TTpQBHxbmEJReGmxfNzQ7ls1HnlEa4p5Egl
         R8vvhh7dY+ELQadqNPlP5yUaDUBwIeyh0mR4YJUjYzAbWmP9bZhks5J+iHDw40IuFJa5
         FHu+SHhKOpgona3Nc4VXt1b7sU0Pf323p3AglRCNWHfMrHnJetluoVKqNFI0dK73K2UP
         Iijd3zgXlIYuuqmaAYJotByi3sb9lgvfUivZ7Z1NB/QWNTQO4OfhcA33sECWBGInlDkJ
         vLeA==
X-Gm-Message-State: ABy/qLaW8WsdWt0TS6uy3cbel7Xy9Odi3PDsq8AYaOX1o6wHmeBg5cra
        psN2Fyco1cWhP3iZkIHpD5CYD80ryS07+ulyyfk=
X-Google-Smtp-Source: APBJJlFMclAGH5KNTL/odtFT/UdN6rf3T6+3rUQkfgWRnzF/mC/8rlxnauS3vBVJfnIdGTCK0/u3Zg==
X-Received: by 2002:a92:cdaf:0:b0:346:15f5:2667 with SMTP id g15-20020a92cdaf000000b0034615f52667mr1242225ild.4.1690272037434;
        Tue, 25 Jul 2023 01:00:37 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id j26-20020a02a69a000000b0042b39f1c3d2sm3516943jam.144.2023.07.25.01.00.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 01:00:36 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-785d738d3feso124679139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:00:36 -0700 (PDT)
X-Received: by 2002:a6b:8d82:0:b0:789:dcd1:8eb9 with SMTP id
 p124-20020a6b8d82000000b00789dcd18eb9mr1029181iod.6.1690272036013; Tue, 25
 Jul 2023 01:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230602090227.7264-1-yong.wu@mediatek.com>
In-Reply-To: <20230602090227.7264-1-yong.wu@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 25 Jul 2023 15:59:59 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhgkj5zh-Oa+OJjZKmkNMfG63+WjSefB2swybm29KxDXA@mail.gmail.com>
Message-ID: <CAC=S1nhgkj5zh-Oa+OJjZKmkNMfG63+WjSefB2swybm29KxDXA@mail.gmail.com>
Subject: Re: [PATCH v12 0/7] MT8188 IOMMU SUPPORT
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 5:03=E2=80=AFPM Yong Wu <yong.wu@mediatek.com> wrote=
:
>
> MT8188 have 3 IOMMU HWs. 2 IOMMU HW is for multimedia, and 1 IOMMU HW
> is for infra-master, like PCIe.
>
> About the 2 MM IOMMU HW, the connection could be something like this:
>
>         IOMMU(VDO)          IOMMU(VPP)
>            |                   |
>       SMI_COMMON(VDO)      SMI_COMMON(VPP)
>       ---------------     ----------------
>       |      |   ...      |      |     ...
>     larb0 larb2  ...    larb1 larb3    ...
>
> INFRA IOMMU does not have SMI, the master connects to IOMMU directly.
>
> Although multiple banks supported in MT8188, we only use one of them,
> which means PCIe is put in bank0 of INFRA IOMMU.
>
> So we have two pgtable for MT8188, specifically, these two MM IOMMU HW
> share a pgtable while INFRA IOMMU HW use a independent pgtable.
>
> Another change is that we add some SMC command for INFRA master to
> enable INFRA IOMMU in ATF considering security concerns.
>
> We also adjust the flow of mtk_iommu_config to reduce indention.

A friendly ping - this series was reviewed, but I'm not sure if it's
still on the radar today.
This can be cleanly applied on top of next-20230725.

To give more confidence, I also tested the basic multimedia and infra
functionalities on my MT8188 with this series, so

Tested-by: Fei Shao <fshao@chromium.org>

to the entire v12 series.

Regards,
Fei

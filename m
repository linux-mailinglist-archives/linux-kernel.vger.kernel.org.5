Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8267A5E40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjISJkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:40:05 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54250DA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:39:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-502d9ce31cbso9079009e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695116397; x=1695721197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN3B0w7/HP84BAXZ6ZgHwHAx1XejuMCTQ58AlHw/sJE=;
        b=kTMgS9lFidgmWcuNbZyVTu3Vf0UoTlfZPno2Mf0qh7NjGuY2mK8qwSIKCiSvw1cIGh
         /czSwKgwc4q1i9uIXzVR0A0EzwYHw8C5sgqs2zv/coE6kKfkx9ZaAGBxJpla+FyUwHbF
         y2etDZQ/dskfMzldErDbaIl7LoPpu8CrsYJyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116397; x=1695721197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN3B0w7/HP84BAXZ6ZgHwHAx1XejuMCTQ58AlHw/sJE=;
        b=m4LbRDZb1+EH0Ft1aavlfkvUdhtU1XLeFStObQUOCgtHu66p9HhumG89kHdWPjHyY2
         DCmmo2gS/O9ZJIq18DNrK/8TOX166NrtD1YJIzPafOQTUPGsx9H1K8EGLUqi4kEvuPmg
         VR7sRo7xSmdlwktwq6uBSwBv9aB/a/LNpWwDrQLAhxmkehRMyG3MW/X9oU2HvwmKTZ9z
         O0PBR+jcmqaVB9/Ye3qxegZZO3qB7GiFNAFPNt1bUGVd6EOZOeklkuyHWr1WIgSP86fY
         /LwO+vl/4rC7SRjXSKhrsiDlwJqgqykJ1mlyMXo21dFZRDmja2N7e7W8MQ90um5QFIwH
         5S2A==
X-Gm-Message-State: AOJu0YxrDegJoba4LgBtUVAp7OE0j2UwQJnnNr9sxXKlnZPWrps1rOV1
        PxAh8ps4tfS8s6lwC11SU7zF98yV0z44AIlQDDKVXg==
X-Google-Smtp-Source: AGHT+IFqnwQ+G7B5Wej3OwhKCTJI9z3d+kpmSDv6XfBmR30ewo2ZVTcCrIm4Xyl3NuT5C+WjSHQ/Hs6XVobN7thyGM0=
X-Received: by 2002:ac2:494f:0:b0:500:9a15:9054 with SMTP id
 o15-20020ac2494f000000b005009a159054mr9205021lfi.20.1695116397402; Tue, 19
 Sep 2023 02:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230919050305.3817347-1-wenst@chromium.org> <13843095-0906-804e-ffbe-36625ebe05cf@collabora.com>
In-Reply-To: <13843095-0906-804e-ffbe-36625ebe05cf@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 19 Sep 2023 17:39:46 +0800
Message-ID: <CAGXv+5GTW83DMtGDkPXPJ9hNzy4rD_GMQH65fNBzt0fUsdWFLA@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: mediatek: Detect single/multi core SCP with
 rpmsg-name property
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 5:26=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 19/09/23 07:03, Chen-Yu Tsai ha scritto:
> > In the just landed multi-core SCP work, detection of single/multi core
> > SCP is done by checking the immediate child node of the SCP complex
> > device node. In the original work this was done by matching the child
> > node's name. However the name wasn't previously standardized. This
> > resulted in breakage on MT8183 and MT8192 Chromebooks while the driver
> > side changes were picked up and the device tree changes were not picked
> > up.
> >
> > Instead, match against the "mediatek,rpmsg-name" property, which is
> > required to be present in the rpmsg sub-node. This makes the
> > aforementioned devices running old device trees working again.
> >
> > Reported-by: Laura Nao <laura.nao@collabora.com>
> > Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-=
core SCP")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > The patch is based on next-20230918 with a whole bunch of local patches
> > stacked on top. None of my local patches are related to remoteproc, so
> > it should be fine.
> >
> > I tested on both MT8183 Juniper and MT8192 Hayato and on both systems
> > the SCP successfully probed again.
>
> Instead of checking "mediatek,rpmsg-name", I think that a better way of c=
hecking if
> this is single or multi core is to count the number of cores...
>
> I've sent my own version of this, please check [1].

My version checks the structure of the device node, much like the original
code, just against a different property/node name. If it's multi-core,
there would be sub-nodes for each core, and the rpmsg property would be
under those.

Either way works. What we need right now is a quick fix to get things
working again. We can discuss how to make things better later.

Honestly I think it should just be based on the compatible string. However
the current design seems quite fragile. The driver probably can't handle
the core device nodes being out of order.


ChenYu

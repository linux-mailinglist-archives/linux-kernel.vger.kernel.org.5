Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1716C7A9FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjIUU1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjIUU1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:27:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB1914DC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:47:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32164a6af64so1086333f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695318455; x=1695923255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aBYYxm4V3k4FyEjLrLJ9/n/H90Md6QsttKISLF22a4=;
        b=ObrvCDPGycohSkh9xvZVoXnZ6hquPa7On30BlI/svia3aPWn4yvSBC7ytEjyzgbaQh
         ERL2knB1y2ng2xllaelBKchdvHD8yyx7wbFkj0XO6kzSaiBh686WAEFrWeozJhWHxpmf
         xKgH+PhxpiNbE2F2TsatS5y7kviIrhANSdeN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318455; x=1695923255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aBYYxm4V3k4FyEjLrLJ9/n/H90Md6QsttKISLF22a4=;
        b=ZV6z6baaPLBhfp2qNtO5Pti9HKR2HyvbhIKDqJQauRh9aKvvkRy7O5tJSxYIbQT/LO
         ++b869nmHfw29aIVVCvAk0/XiBrLc8zrOk3kvZRlVVm4mEDexSILo60W2W7jkJ21O4PM
         N7j7xg+YkLGIsAtwHa1r7wH091cxGHtDGQYtwohPRqzkMCubdRJp7uE7/HTf42LFzfsK
         zi+vr1XPey8N3FKysLvuJOIVhiHBuwLN7SCe8hKIQZUmet1xPxk/CSryhIlPagCsYT5b
         Lmk9Kyr9UMKZ6c1VyR0QMec4UAUJqm94AB6cYjwpHvZvyDSnspcxQrUWNX21kEWAKS20
         4CeQ==
X-Gm-Message-State: AOJu0YxjmVbDvILEuuLMIXILgGe7i/KiST8Q91PSs0X14soape39sS/a
        4lH+GlmRxzXLKBv2zP4w4Zme4Hog53CgQAzSKph+cqnSlrUcG/svYIM=
X-Google-Smtp-Source: AGHT+IGdIV8J7fxjUNbRUv5HJhGzBY+D1JG/lYO+jffLDerOCNDgsVdIhjbf+HuUVjEXXFJfi0crYYSdZkt0BFEhkOg=
X-Received: by 2002:a19:e051:0:b0:4ff:8863:be01 with SMTP id
 g17-20020a19e051000000b004ff8863be01mr3396045lfj.8.1695269389034; Wed, 20 Sep
 2023 21:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230919092336.51007-1-angelogioacchino.delregno@collabora.com> <20230920150332.318851-1-laura.nao@collabora.com>
In-Reply-To: <20230920150332.318851-1-laura.nao@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 21 Sep 2023 12:09:37 +0800
Message-ID: <CAGXv+5Hr1woRL5z6b4k6e+FQKaVyoUmP4vAt=RrEgjEwq8bUhw@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: mediatek: Refactor single core check and fix retrocompatibility
To:     Laura Nao <laura.nao@collabora.com>
Cc:     angelogioacchino.delregno@collabora.com, andersson@kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        matthias.bgg@gmail.com, tinghan.shen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:03=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> On 9/19/23 11:23, AngeloGioacchino Del Regno wrote:
> > In older devicetrees we had the ChromeOS EC in a node called "cros-ec"
> > instead of the newer "cros-ec-rpmsg", but this driver is now checking
> > only for the latter, breaking compatibility with those.
> >
> > Besides, we can check if the SCP is single or dual core by simply
> > walking through the children of the main SCP node and checking if
> > if there's more than one "mediatek,scp-core" compatible node.
> >
> > Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-=
core SCP")
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >   drivers/remoteproc/mtk_scp.c | 18 +++++++-----------
> >   1 file changed, 7 insertions(+), 11 deletions(-)
> >
>
> Tested on asurada (spherion) and jacuzzi (juniper). The issue was detecte=
d by KernelCI, so:
>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Tested-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on Hayato (MT8192) and Juniper (MT8183).

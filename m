Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6787ED2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjKOUpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjKOUpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:45:09 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A7319B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:45:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507bd64814fso85988e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700081103; x=1700685903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMCXFclGcLK2XWRhjGnvFkwVtcm+D581tPNKMzDFIwY=;
        b=hSpZ+jU+IBeNjYaFRGcsCE8XWFo3fR8K0+AXR3AQSTZRTGdKhet4jx/oOI4IAy+3XW
         FbSPK9xi11EjIxVGniCrGdgnrZPucHY1imnvLEouajFh/hKexxyDdch/ebAJOpYxabO4
         5PRJ9fcNHrxAw9OxjEuGLUvj/W60CzV7ThtvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700081103; x=1700685903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMCXFclGcLK2XWRhjGnvFkwVtcm+D581tPNKMzDFIwY=;
        b=CnJ+WczxkADoreAuuKPCoF8ZOsgdf5HDQqMfbE5m45ayCrBXJtYMMvD+ODrbfuYdoS
         GF5Fx7qo+0clZBIYYRuK7iliNkXxa2oV2Aiin2EYdyfTCV0AadnZTphofzchrNJ/Qc8h
         PEfhAgGdM2p7x6F+IJ0cixHh1DhF9SzX01ljBsryV45HYQjNPVBWf+UT8K3ae0c8nx5n
         A69tmaFBfo+7EwZwKOb1/zXPDrzDIVNyZsKM6vv15sEHLFW5ikbTNUtnCV792KKHjoSi
         JF1Sx4Zp2jJgpLhTttFNvKaKzDT+FIgJMAznGLGJcnSweoZaOy/P4/mJTnLnx64VDUel
         51mQ==
X-Gm-Message-State: AOJu0Ywy9FJ/zhMkKkxxOUqAQBL9Cg+hfkXZ+KKUZDkT7qHG88/1hUbT
        Aug8at84vO4tXxOOxy3SV8GdnWiguQqxZ8E2zzwVg/Xr
X-Google-Smtp-Source: AGHT+IELSiQVNmu4o4nnpPCPUeWqCEiSLxGIZUcVpP30pVMweOBRHbfyS4PflT2+UIytbh+KAnY7eA==
X-Received: by 2002:a05:6512:3da6:b0:50a:7868:d3c0 with SMTP id k38-20020a0565123da600b0050a7868d3c0mr376916lfv.23.1700081102803;
        Wed, 15 Nov 2023 12:45:02 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id u26-20020a50951a000000b0054386466f56sm7037501eda.60.2023.11.15.12.45.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 12:45:02 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-545557de8e6so3339a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:45:02 -0800 (PST)
X-Received: by 2002:a05:600c:3b23:b0:408:3727:92c5 with SMTP id
 m35-20020a05600c3b2300b00408372792c5mr11547wms.2.1700081081263; Wed, 15 Nov
 2023 12:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org> <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
 <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
 <CAD=FV=VUZy9DaZgKafSpXXopD5k8ExGSR97BjAqC5tupPoxNfQ@mail.gmail.com> <CAL_Jsq+puq20EWkQg1RTs2zfmh4DGbqz1krp+19c=wPXnLT5dA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+puq20EWkQg1RTs2zfmh4DGbqz1krp+19c=wPXnLT5dA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Nov 2023 12:44:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X-17COQ2-tycV1bSuCrGy7MJ88Un8nA-a-ODexvgi9TQ@mail.gmail.com>
Message-ID: <CAD=FV=X-17COQ2-tycV1bSuCrGy7MJ88Un8nA-a-ODexvgi9TQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
To:     Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 15, 2023 at 2:28=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> > So if we're searching the whole device tree for "failed-needs-probe"
> > then we need to figure out which devices are related to each other. If
> > a given board has second sources for MIPI panels, touchscreens, and
> > trackpads then we need to know which of the "failed-needs-probe"
> > devices are trackpads, which are touchscreens, and which are MIPI
> > panels. Do you have any suggestions for how we should do that? Maybe
> > it was in some other thread that I missed? I guess we could have a
> > board-specific table mapping (compatible + node name + reg) to a
> > class, but that feels awkward.
>
> Node name is supposed to correspond to device class, so why not use
> that (no path or unit-address.) and nothing else (well, besides
> "status")?

One problem is that I could imagine having two second source trackpads
that both have the same i2c address. That would give them the same
name, right? I guess you could maybe come up with some sort of suffix
rule? Like

trackpad-1@10 {
  compatible =3D "elan,blah";
  ret =3D <0x10>;
  status =3D "failed-needs-probe";
  ...
}
trackpad-2@10 {
  compatible =3D "goodix,gt7375p";
  ret =3D <0x10>;
  status =3D "failed-needs-probe";
  ...
}

Then I guess the class would be "trackpad"?


-Doug

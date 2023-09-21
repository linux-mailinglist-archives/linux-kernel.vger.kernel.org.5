Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE057A9AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjIUSrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjIUSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:47:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ED0EE855
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:46:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c012232792so22302971fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695322014; x=1695926814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGNO3fxjlHQ6BuBtNnDhbEjBaZDga+bo39FJcPPhcUQ=;
        b=gLtdpyfu5uB4UVBy+Bx6JsEvwaCK5CsYxt0yaKBRAzSqXryNRu3k3e2pavmCsjZu9Z
         nTh3Jj8WUMC7hQgu4HhjIufZPWIpNAZw2IvpkVmKLRyUxCNCKtGGj096aSJCFc0so1mc
         V43xkaV0MUFq+PaNvgg8Z0esTLdSJ2ObjAPtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322014; x=1695926814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGNO3fxjlHQ6BuBtNnDhbEjBaZDga+bo39FJcPPhcUQ=;
        b=Zo9Z7QE2POW1jszmdus1qaLYYBYgS1tHoQTLqlwKM8K/NRi91eyj1c5INMImoRWuV2
         2WUOdKE1vAB1Cn1tvuoeX+0opPm2n+n6duORG3uZejYTFmuLm7eg17NKGTaXpSGE5jkT
         RFwYry97MfjmNTUsa8Ui9F7yHHLCSAlmYjL7lL3gWWg3gszg5l9LnAtUyANQfjpjwUtz
         LsPbXuErTS9BGo53UKpyoNYDNA7KrsufK/1G7AnuiT9DUpXYt9IZWSnTScylI8auuOsQ
         vMxcDfTf0o9yoeKW0lE2CVr589Omlh5VI0xOnVBw870Ije1dYWMI7VEzZWy4wsclrih5
         H/OQ==
X-Gm-Message-State: AOJu0YySBI4Cq+N9eTptzvdKmqzizZjmCSABdO1D9ojWGFdhW0Tl+8bs
        y2Xlz9dQT1wEhUirAB2UbwLM2c//OMsoWLZkAKj3Sw==
X-Google-Smtp-Source: AGHT+IHPQRCiEs7r7vdL9iTIGnxq9/bu2WXx7KghfSpz+QKbRoEJ9XhdFeDypSMn8EuytZSKcQJLNA==
X-Received: by 2002:a2e:95d0:0:b0:2c0:1385:8c86 with SMTP id y16-20020a2e95d0000000b002c013858c86mr5593521ljh.25.1695322013930;
        Thu, 21 Sep 2023 11:46:53 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090614c400b00992b510089asm1435971ejc.84.2023.09.21.11.46.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:46:53 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso20315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:46:53 -0700 (PDT)
X-Received: by 2002:a05:600c:d3:b0:405:38d1:e146 with SMTP id
 u19-20020a05600c00d300b0040538d1e146mr59361wmm.4.1695322013017; Thu, 21 Sep
 2023 11:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234015.566018-1-dianders@chromium.org> <20230901163944.RFT.3.I10dbe099fb1059d304ba847d19fc45054f7ffe9f@changeid>
In-Reply-To: <20230901163944.RFT.3.I10dbe099fb1059d304ba847d19fc45054f7ffe9f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Sep 2023 11:46:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTDuvjD8t8amWg=4r8=z3EhnbVms1DcskmYNX8sG4-kw@mail.gmail.com>
Message-ID: <CAD=FV=VTDuvjD8t8amWg=4r8=z3EhnbVms1DcskmYNX8sG4-kw@mail.gmail.com>
Subject: Re: [RFT PATCH 3/6] drm/vc4: Call drm_atomic_helper_shutdown() at
 shutdown time
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     airlied@gmail.com, daniel@ffwll.ch, emma@anholt.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 1, 2023 at 4:40=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> Based on grepping through the source code these drivers appear to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This commit is only compile-time tested.
>
> Though this patch could be squashed into the patch ("drm: Call
> drm_atomic_helper_shutdown() at shutdown time for misc drivers"), I
> kept it separate to call attention to this driver. While writing this
> patch, I noticed that the bind() function is using "devm" and thus
> assumes it doesn't need to do much explicit error handling. That's
> actually a bug. As per kernel docs [1] "the lifetime of the aggregate
> driver does not align with any of the underlying struct device
> instances. Therefore devm cannot be used and all resources acquired or
> allocated in this callback must be explicitly released in the unbind
> callback". Fixing that is outside the scope of this commit.
>
> [1] https://docs.kernel.org/driver-api/component.html
>
>  drivers/gpu/drm/vc4/vc4_drv.c | 36 ++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)

Landed to drm-misc-next:

013d382d11a2 drm/vc4: Call drm_atomic_helper_shutdown() at shutdown time

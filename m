Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D147A7FA5B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjK0QIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjK0QIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:08:46 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11935A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:08:53 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cece20f006so22521537b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701101332; x=1701706132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0s3YKSI0CCDl7Ip7+d2J2fh8HjXs5+Z5vnehpex76E=;
        b=y2skP9HaOXZUJGy/escNLb/9LlASTDZoLPH48+dd705s0PBbkUhBqgMVWva5exeXdP
         BASoJSAELaeIDP+8rbliOLSjbiMRF52T5ArRaHzrFy2omQegZYAHLA//k1qzO80AYr29
         azYi66I0b2kCBsfZq06I+QmGGTuMVu3o2wduRXhJmZpb2+pWuSlo8bHmz5axf0FzPdHg
         fT/HVUHqM/PIKeZIvOnO3apE1erH1K0Fq/2PDDfS1as5LtJ2H2UThVmqT7CDjShgF1O9
         yetI4H1CxQvWWLTauw7hZWgrQ1MFtnZndALT3avLwo4DHB8HwhKb8ApYZ33BbLHaHGJ1
         gAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101332; x=1701706132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0s3YKSI0CCDl7Ip7+d2J2fh8HjXs5+Z5vnehpex76E=;
        b=AocnITOrwU9f3Mi1vXrzGlId6l75S4pcnf9Vcbjxyrp6p+hlHEs3kdTapSFClnRj/V
         WJcWim4gVIX2fde+6wpA/Wp6F6vJmJsCJEYWo+kCYOMIoCkBvZ1joOwFFPpC0hThpDQD
         /gsSjxsx1AEVORq8XzkZ7CVkpnYEMeFncLTe2UQ3z93RqFLA4n7vfCna3JzQrEo8n69B
         H9EFKeprOZU6niTbWyfhCf2+EbCYhJEtGEKookspj8mYw1Df7iNoDHUHTlXa0EdWFQs5
         RsR3SiFZXvwNUJWsFQ/SMhwNgXOLZq2O/kxdnnc9sFQ3ymmZEopUk8c1q9zzRWhyOEUQ
         rMNg==
X-Gm-Message-State: AOJu0YzYQsVQtY3xiiU1RrZ0Q2n/3OYX8abHrJAFbFhDXq3LTHdtJIhI
        k+lFb6Th7wphDkg0A92TsthPrjD2bfTDhI/JMt09XQ==
X-Google-Smtp-Source: AGHT+IFzV7gAuBBlDiQ5hhcXqWBkE8td2GRohFvyvwsIY5ZRT0pwgUEhXPC3sHKmGhubSogJiQBVdEnyKAqOWo2j9kc=
X-Received: by 2002:a0d:d756:0:b0:5c1:8075:5a80 with SMTP id
 z83-20020a0dd756000000b005c180755a80mr7766008ywd.30.1701101331996; Mon, 27
 Nov 2023 08:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20231123032615.3760488-1-victor.liu@nxp.com> <ZWSbKkgs8V4sdy8T@intel.com>
In-Reply-To: <ZWSbKkgs8V4sdy8T@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Nov 2023 17:08:40 +0100
Message-ID: <CACRpkdZG+8KPWGNcp1jGXnSodXqS0qXiwXDPqf1yqoDZw1aS8w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: panel: Check device dependency before
 managing device link
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mripard@kernel.org,
        neil.armstrong@linaro.org, ulf.hansson@linaro.org,
        rfoss@kernel.org, tzimmermann@suse.de, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, Laurent.pinchart@ideasonboard.com,
        andrzej.hajda@intel.com, angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 2:36=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:

> > +     panel_bridge->is_independent =3D !device_is_dependent(drm_dev->de=
v,
> > +                                                         panel->dev);
>
> This broke the build. Looks like device_is_dependent() is not even export=
ed.
> ERROR: modpost: "device_is_dependent" [drivers/gpu/drm/drm_kms_helper.ko]=
 undefined!

Yep Ying made a fix, I just applied and pushed it because it was obviously
correct.

> The recommended defconfigs in rerere-cache do seem to have CONFIG_DRM_KMS=
_HELPER=3Dm
> so this should have been caught before pushing. How did it slip through?

My neglect.

Neglect may have something to do with my desktop being 10 years+
old. Building random defconfigs on this machine takes so long time
that invariably other stuff has been pushed to the branch before
the compiles even complete.

Yeah I know. I should buy a better computer.

Yours,
Linus Walleij

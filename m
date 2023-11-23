Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BDD7F5829
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbjKWGZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKWGZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:25:08 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E44319E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:25:14 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507bd19eac8so657483e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700720712; x=1701325512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFOK9nMH1VcoZ2z6PVa19sLHI4+eJmqfxzPGi62CvS0=;
        b=ZJ+b2T8DGyVbqwkw5kJGCssL/MOqW9LCxy4ajmFbJQpyVUVuSkLlvRYzEqrnREiia6
         DL5Mqpn9NJdJUkUIIhmVsAupJ7E+/1DsdkPaRuTyWpurNAoQY28d3j+4+/4te182ZDmn
         gbRj86IR2M5dVAKsLK49sJszhzuaH/HuukDZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700720712; x=1701325512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFOK9nMH1VcoZ2z6PVa19sLHI4+eJmqfxzPGi62CvS0=;
        b=tSG9CaEx00QumCM4yx5fhRd5W7dPLDloQPUL0WC5j4025HxW3X3JWn3cZRK/wYAnjs
         iQSeF9ZAAQktJfqAe+FPB3hwc7R+rvPNU6hoA7S1pwRndwNv53zKVlPN/d82DEW/sxDO
         bbFmpVyMEVyzmUOH878pMhC3mAfi1R7W94yo7UMDh5PGInWICQcxYNMctRWPiYbsgPwu
         HhQ/tZa7V3Ny9/XA2u9eLgFAu7G3G1OrmlEvHU03O1SAYA6wuTrV28hvWd41LXhwdhgA
         GhFzWffnSeI7dbzk+cFlWvvNRdodtJHQXaCiPo/wbTZ3EZNe2A5IYuSTB2ajBkjzWe+x
         3DcQ==
X-Gm-Message-State: AOJu0Ywdsdgksag3O8lw9f2Z3X5Jx9DtEa8G792azxJroU7kWuJsMKtH
        XnhNvgh/tdUL1Yanum0NhA9PvGXfaZ5UJIxd6mo6dGBOlCJ6W57X7RA=
X-Google-Smtp-Source: AGHT+IFuPfRKfSodWyGjGtPPCFDTxGK/LY8CUSpBiO06DaoCkH39868TwRxSy06GbUtySSJqdraZ2vGVf5GKnhE/Gsg=
X-Received: by 2002:ac2:520f:0:b0:505:6c99:bd7c with SMTP id
 a15-20020ac2520f000000b005056c99bd7cmr2959574lfl.57.1700720712087; Wed, 22
 Nov 2023 22:25:12 -0800 (PST)
MIME-Version: 1.0
References: <CAKpemQKo2gigO44amj=eFUXgUnUeSmiOoTbS8GdXMx3O07N1vg@mail.gmail.com>
In-Reply-To: <CAKpemQKo2gigO44amj=eFUXgUnUeSmiOoTbS8GdXMx3O07N1vg@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 23 Nov 2023 14:25:01 +0800
Message-ID: <CAGXv+5E4TXrPmhb++r3vMGA4WoPc=covi7_=zgLLcOhGt9UBgg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] regulator: mt6358: Add output voltage fine tuning
 to variable LDOs
To:     Bret Joseph <bretjoseph@gmail.com>
Cc:     angelogioacchino.delregno@collabora.com, broonie@kernel.org,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        zhiyong.tao@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bret,

On Thu, Nov 16, 2023 at 12:52=E2=80=AFAM Bret Joseph <bretjoseph@gmail.com>=
 wrote:
>
> In mt6358-regulator.c
>
> static const struct regulator_ops mt6358_volt_table_ops =3D {
>     .list_voltage =3D regulator_list_voltage_pickable_linear_range,
>     .map_voltage =3D regulator_map_voltage_pickable_linear_range,
>     .set_voltage_sel =3D regulator_set_voltage_sel_pickable_regmap,
>     .get_voltage_sel =3D mt6358_get_buck_voltage_sel /*regulator_get_volt=
age_sel_pickable_regmap*/,
>     .set_voltage_time_sel =3D regulator_set_voltage_time_sel,
>     .enable =3D regulator_enable_regmap,
>     .disable =3D regulator_disable_regmap,
>     .is_enabled =3D regulator_is_enabled_regmap,
>     .get_status =3D mt6358_get_status,
> };
>
> the function [regulator_get_voltage_sel_pickable_regmap] causes a -EINVAL=
=E2=80=AC when registering
>
> vsim1 vusb vcamd vefuse vmch vcama1 vemc vmc vldo28 vsim2
>
> using [mt6358_get_buck_voltage_sel] results in a successful probe

Sure it will probe, but any values you read back will be bogus.

Can you provide a dump of /sys/kernel/debug/regulator/regulator_summary
and `grep ^1e..: /sys/kernel/debug/regmap/1000d000.pwrap/registers`,
and also any relevant logs?

ChenYu

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2DE799E82
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbjIJNcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjIJNcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:32:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7505CCD;
        Sun, 10 Sep 2023 06:32:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03EFC433C7;
        Sun, 10 Sep 2023 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694352761;
        bh=PgPxzf+jv/I7Wo+au5FUHpikY0c1DZYaiLrnMiVSbR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L6LTSWuimjFod3EYu9fASVN4ORFjSqrSKQLRk3uOvxdI0nNFVlXuAfUyP45kZc9Fm
         3xa9KHl67Zk/VeuA+q+D5sZZ5ViSnt3Cc97tkhiPyMxcaiPELjowrjJFq+7vSknWPz
         PDZP6dwqBkgrtT9LHwfu0U/fRGRl5eO1cHsOrcuZUi07/sVMa9/vMz2sDdcx7sYV4M
         vhVQW32yw++hWNyJpgBRnHN0CV3Uswn739HuaJWRHFhQ/rFJedwhBWhWFiWvtSXpy6
         NN3s5Xtz/Bn7IfA+WHO0oQPC8T6czUqtNZwRDEoNZw2BnG+6P+Q7G+mAbvlXCpsgVk
         aHqi1iCqA5otQ==
Date:   Sun, 10 Sep 2023 14:32:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH] iio: light: vcnl4000: Don't power on/off chip in config
Message-ID: <20230910143235.16a924bc@jic23-huawei>
In-Reply-To: <20230907-vcnl4000-pm-fix-v1-1-58a11c1d5a6c@axis.com>
References: <20230907-vcnl4000-pm-fix-v1-1-58a11c1d5a6c@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 12:53:14 +0200
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

Hi M=C3=A5rten,

Agree with your reasoning etc (and I guess you've triggered this for real)
so just a few patch description etc comments.

> After enabling/disabling interrupts on the vcnl4040 chip the als and/or
> ps sensor is powered on or off depending on the interrupt enable bits.
> This is made as a last step in write_event_config.
>=20
> But there is no reason to do this as the runtime PM handles the power
> state of the sensors. Interfering with this may impact sensor readings.
>=20

I think the following example could be clearer. I haven't checked
the naming of states in runtime pm, but a few things seem backwards to me.

> Consider the following:
>  1. Userspace makes sensor data reading which triggers 2000ms RPM resume
>     (sensor powered on) timeout
It triggers a timeout to do runtime suspend if no access in 2000ms, not res=
ume.

>  2. Userspace disables interrupts =3D> powers sensor off
>  3. Userspace reads sensor data =3D 0 because sensor is off and RPM didn't
>     power on the sensor as resume timeout is still active

suspend timeout hasn't yet run out, so the runtime pm subsystem thinks the
device is still powered up and doesn't need resuming.

>  4. RPM resume timeout passed
suspend timeout.=20

>=20
> Powering sensor off in (2) risks a time window of close to 2000ms where
> sensor data readings are disabled as in (3).
>=20
> Skip setting power state when writing new event config.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>

Fixes tag - probably 2 of them. One for the recent change that added
the || als_int part and one for wherever the bug originally came from
with comments to say why there are two fixes tags.

> ---
>  drivers/iio/light/vcnl4000.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 3a52b09c2823..fdf763a04b0b 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -1513,7 +1513,6 @@ static int vcnl4040_write_event_config(struct iio_d=
ev *indio_dev,
> =20
>  out:
>  	mutex_unlock(&data->vcnl4000_lock);
> -	data->chip_spec->set_power_state(data, data->ps_int || data->als_int);
This will need manual backporting as this line changed recently and I'm fai=
rly
sure the argument is equally valid for the older code.

> =20
>  	return ret;
>  }
>=20
> ---
> base-commit: 7ba2090ca64ea1aa435744884124387db1fac70f
> change-id: 20230907-vcnl4000-pm-fix-b58dc0dffb5c
>=20
> Best regards,


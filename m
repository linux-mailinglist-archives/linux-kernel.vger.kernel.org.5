Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E277D9A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346019AbjJ0Ngr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345978AbjJ0NgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:36:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B589D6A;
        Fri, 27 Oct 2023 06:36:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C3CC433C9;
        Fri, 27 Oct 2023 13:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698413762;
        bh=0xd7P4qYVmXOKMAZZhnxdTAzptuC3esnYUCmJULyCB8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kdr9xBX/kVeoUGv0I2qU4a9zqQb7P/6SbXYTGPU6CxbiOzYbxWkQHsNaJcRVFujoF
         U0hjXSHePCG+09skR+SGHmFydgCkUuZY96ngHKMSarHPmP4lK7aEyKKwrynYU8h+m3
         /KDNuGlLsUGWxuLTYPWb1urXHF1gbpyh/fg/VO/duWGc7gwk3R3HTLXe4EQm1s+avX
         rwvuSnqPM4cRF0x+eIWMH92xZAqAB0SV9bckKz3hNyaEVQ54L4FVj455UZBfleB6xd
         VQPXHbTEJ9XRX12x2214sI6LAkNjylDNAkUCvXSU7hoSSEdeAUCyMXys1HynEklUiu
         ciSQwbc2OTpRw==
Date:   Fri, 27 Oct 2023 14:36:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>, lars@metafoo.de,
        jean-baptiste.maneyrol@tdk.com, chenhuiz@axis.com,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: mapphone-mdm6600: fix an error code problem in
 inv_mpu6050_read_raw
Message-ID: <20231027143600.2dd74f78@jic23-huawei>
In-Reply-To: <bccca54f-5eb8-83ba-17ad-6cb312aa6ea5@nfschina.com>
References: <7f81d365-0440-de01-8be4-9c8d3ab9d69c@nfschina.com>
        <bccca54f-5eb8-83ba-17ad-6cb312aa6ea5@nfschina.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 23 Oct 2023 11:29:30 +0800
Su Hui <suhui@nfschina.com> wrote:

> On 2023/10/23 09:33, Su Hui wrote:
> > On 2023/10/20 23:55, Jonathan Cameron wrote: =20
> >> I'm not sure why inv_mpu6050_sensor_show() doesn't return
> >> the actual error code from the regmap_bulk_read() and instead=20
> >> replaces it
> >> with -EINVAL.=C2=A0 Given you are tidying up this related issues perha=
ps=20
> >> change
> >> that as well?
> >>
> >> static int inv_mpu6050_sensor_show(struct inv_mpu6050_state *st, int=20
> >> reg,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int axis, int *val)
> >> {
> >> =C2=A0=C2=A0=C2=A0=C2=A0int ind, result;
> >> =C2=A0=C2=A0=C2=A0=C2=A0__be16 d;
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0ind =3D (axis - IIO_MOD_X) * 2;
> >> =C2=A0=C2=A0=C2=A0=C2=A0result =3D regmap_bulk_read(st->map, reg + ind=
, &d, sizeof(d));
> >> =C2=A0=C2=A0=C2=A0=C2=A0if (result)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >> //Make this return result; =20
> >
> > Sure, I will tidy up this, Thanks for your suggestion! =20
>=20
> I'm not sure=C2=A0 whether the caller could handler this=C2=A0 when retur=
n=20
> 'result' rather than '-EINVAL'.
>=20
> This is not a big problem, maybe we shouldn't modify this code.

If the ultimate caller (userspace in this case) doesn't handle other
error codes it won't work with lots of other devices and is broken.

So I doubt any code is that fragile. If we get a report of a regression
we can look into whether it's sensible to resolve it.

So fine to change this, but could be a separate patch.

J
>=20
> Su Hui
>=20


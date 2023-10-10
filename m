Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93C7BF6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjJJJCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjJJJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:02:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D2A9;
        Tue, 10 Oct 2023 02:02:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260AEC433C9;
        Tue, 10 Oct 2023 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696928526;
        bh=72C0ZN0WQE7pBi1Wuy8CUeVQX+MYR/mu/Fga9E36idc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WQllbwYCMVDDXPg25og4dgKD0nFSfCQDh62zLSrTlzUruv+apvKswmyuPEknOuWfq
         ApwL2uocObUAWnxv/ZK8DVDagCDo7t+J+p8yBOlHbxuAouLTD9GcM88YWoUNPA+Y0e
         gTTygtQ4PahDjgq35ELj5duclTia+agT8ZI7UOvyWigXinUBjGbu2xWMhTmuU4nnZH
         y/O4sRdSHitxNxDUAnzS/BO4gVSjwnuES28RGtfOu3iYDfiCJpkCes7xGpjcNDqZOo
         2Lwjd/+oNAkZEdjr1PpslTZJNhSwO/IH9ImoO7vU0COpcxhWiwrAGajf3ZM9WYS10b
         yZnT0ilK7EjmA==
Date:   Tue, 10 Oct 2023 10:02:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <20231010100216.169f573f@jic23-huawei>
In-Reply-To: <CAM+2Eu+94awdDtC4RVuCe6Nq_QXj_A5-nv6=iuPLzgybHu1qSQ@mail.gmail.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
        <20230918080314.11959-3-jagathjog1996@gmail.com>
        <ZQggiuLyLGq/ekMS@smile.fi.intel.com>
        <CAM+2EuKXW+FsgY6rp=ugU03owJS6ReeWUNWOcMKiUfomiY_a2Q@mail.gmail.com>
        <CAM+2Eu+94awdDtC4RVuCe6Nq_QXj_A5-nv6=iuPLzgybHu1qSQ@mail.gmail.com>
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

On Sun, 8 Oct 2023 11:55:32 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hi Andy,
>=20
>=20
> On Wed, Sep 20, 2023 at 4:13=E2=80=AFAM Jagath Jog J <jagathjog1996@gmail=
.com> wrote:
> >
> > On Mon, Sep 18, 2023 at 3:34=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote: =20
> > >
> > > On Mon, Sep 18, 2023 at 01:33:14PM +0530, Jagath Jog J wrote: =20
> > > > The Bosch BMI323 is a 6-axis low-power IMU that provide measurement=
s for
> > > > acceleration, angular rate, and temperature. This sensor includes
> > > > motion-triggered interrupt features, such as a step counter, tap de=
tection,
> > > > and activity/inactivity interrupt capabilities.
> > > > =20
>=20
> ...
>=20
> > > > +static const struct attribute_group bmi323_event_attribute_group =
=3D {
> > > > +     .attrs =3D bmi323_event_attributes,
> > > > +}; =20
> > >
> > > ATTRIBUTE_GROUPS() ? =20
> >
> > Okay, I will use ATTRIBUTE_GROUPS. =20
>=20
> The ATTRIBUTE_GROUP(bmi323_event) macro will define two variables,
> bmi323_event_groups and bmi323_event_group. The event_attrs member
> of iio_info is of type struct attribute_group*, which means that
> bmi323_event_groups will remain unused. Since I am using a single
> event group, Can I keep it the same way?

Yes, don't use that macro as not appropriate in this case.


>=20
>=20
> Regards
> Jagath
>=20
> Jagath


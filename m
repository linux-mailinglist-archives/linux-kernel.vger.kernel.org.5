Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B117BA1EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjJEPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjJEPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:03:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A1C22CAD;
        Thu,  5 Oct 2023 07:37:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C7BC433CD;
        Thu,  5 Oct 2023 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696516652;
        bh=d5+bWfEGP0zzHGLVWG6rfcD81J5u9prc/EH+42gaTdg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a1pDpUJju0AcHm6fU/iQF79zZqsI1AxA1yGAzioSWGVAKnD1Xq9zeenOhE/5fKDqV
         TKboDLI/Y1gm20v/8EGW3Z8DJ8wYaTwvGs3CBZpm4mrRrI793gKRkF4+lkmX1tyl0g
         rkWCSi2pc2uFUOx4YMnDhTV8LwclzXzMDxM16SnneD7tqw7yTjIktegCKVtpRNKuYa
         3J910BSa05WkhnQgbyj6sxFKFDIfI5jb7ircIji5xhKhuAewSympDCGD2l2K58+fO5
         Ic3fROCGfH57hDvUwxWZ6OadV4I6ieHsffJLXw3Q2lQjI4spxxlqXpCx6sw5C31YBC
         4glJ/qqpq2v5w==
Date:   Thu, 5 Oct 2023 15:37:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 22/27] staging: iio: resolver: ad2s1210: convert LOS
 threshold to event attr
Message-ID: <20231005153736.2603dbbf@jic23-huawei>
In-Reply-To: <CAMknhBFKSqXvgOeRjGAOfURzndmxmCffdU6MUirEmfzKqwM_Kg@mail.gmail.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-22-fa4364281745@baylibre.com>
        <20230930164251.5c07723c@jic23-huawei>
        <CAMknhBFKSqXvgOeRjGAOfURzndmxmCffdU6MUirEmfzKqwM_Kg@mail.gmail.com>
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

On Mon, 2 Oct 2023 11:09:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Sat, Sep 30, 2023 at 10:42=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Fri, 29 Sep 2023 12:23:27 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> > =20
> > > From: David Lechner <david@lechnology.com>
> > >
> > > From: David Lechner <dlechner@baylibre.com>
> > >
> > > The AD2S1210 has a programmable threshold for the loss of signal (LOS)
> > > fault. This fault is triggered when either the sine or cosine input
> > > falls below the threshold voltage.
> > >
> > > This patch converts the custom device LOS threshold attribute to an
> > > event falling edge threshold attribute on a new monitor signal channe=
l.
> > > The monitor signal is an internal signal that combines the amplitudes
> > > of the sine and cosine inputs as well as the current angle and positi=
on
> > > output. This signal is used to detect faults in the input signals. =20
> >
> > Hmm. Looking forwards, I'm less sure that we should be shoving all these
> > error conditions onto one channel. Fundamentally we have
> > sine and cosine inputs. I think we should treat those as separate chann=
els
> > and include a third differential channel between them. =20
>=20
> At first, I did consider a differential channel as you suggested in
> v2. However, the datasheet is quite clear that the LOS and DOS faults
> (and only those faults) come from a signal it calls the "monitor
> signal". This signal is defined as:
>=20
>     Monitor =3D A1 * sin(theta)  * sin(phi) + A2 * cos(theta) * cos(phi)
>=20
> where A1 * sin(theta) is the the sine input, A2 * cos(theta) is the
> cosine input and phi is the position output. So mathematically
> speaking, there is no signal that is the difference between the two
> inputs. (See "Theory of Operation" section in the datasheet.)

Hmm. That's certainly a bit more complex than I expected.
Relying on the brief description led me astray.

It's related to the differences in the measured and  as if
theta =3D=3D phi and A1 =3D=3D A2 (ideal) then it will be A1.

I can see it's relevant to DOS, but not LOS.  The description of LOS
seems to overlap a number of different things unfortunately.



>=20
> But if we want to hide these internal details and don't care about a
> strict definition of "differential", then what is suggested below
> seems fine.

Probably best to introduce that monitor signal though we'll have
to be a bit vague about what it is which has the side effect that
anyone trying to understand what on earth these faults are is going
to be confused (having read the datasheet section a couple of times
I'm not 100% sure...)

>=20
> >
> > So this one becomes a double event (you need to signal it on both
> > cosine and sine channels).  The DOS overange is similar.
> > The DOS mismatch is a threshold on the differential channel giving
> >
> > events/in_altvoltage0_thresh_falling_value
> > events/in_altvoltage1_thresh_falling_value (these match)
> > events/in_altvoltage0_thresh_rising_value
> > events/in_altvoltage1_thresh_rising_value (matches previous which is fi=
ne)
> > events/in_altvoltage1-altvoltage0_mag_rising_value
> >
> > Does that work here?  Avoids smashing different types of signals togeth=
er.
> > We could even do the LOT as differential between two angle channels
> > (tracking one and measured one) but meh that's getting complex.>
> > Note this will rely on channel labels to make the above make any sense =
at all. =20
>=20
> I think this could be OK - I think what matters most is having some
> documentation that maps the faults and registers on the chip to the
> iio names. Where would the sine/cosine clipping fault fit in though? I
> got a bit too creative and used X_OR_Y to differentiate it (see
> discussion in "staging: iio: resolver: ad2s1210: implement fault
> events"). Strictly speaking, it should probably be a type: threshold,
> direction: either event on both the sine and cosine input channels
> (another double event) since it occurs if either of the signal exceeds
> the power or ground rail voltage. But we already have threshold rising
> and threshold falling on these channels with a different meaning. I
> guess it could call it magnitude instead of a threshold?

Tricky indeed.  Though I guess we only hit the clipping case after
LOS or DOS fires or if their thresholds are set too wide (is that
even possible?).  So it is useful to report it as we are already in
error? Or can we combine the cases by treating it as a cap on the
threshold controls for LOS and DOS?

Even when they aren't just there for error reporting, designers
seem to always come up with new create signals to use for event
detection and sometimes it's a real struggle to map them to
something general.

Jonathan



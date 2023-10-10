Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5897BF74F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjJJJ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJJJ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:29:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42066A7;
        Tue, 10 Oct 2023 02:29:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8835CC433C7;
        Tue, 10 Oct 2023 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696930146;
        bh=eFUd/n8o3VVFHQz6wd12ub7oPEuB2ug/zCfzJKYSH9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ajcUgIYOTXJUNpLXSOJ27Kmcw2PFHR1m12BzVFgzf5jt3qce+GYJJF1ZRnbbUwQDh
         Fo3unuFReI+9q5C1M2FLFOTjRYDooeKOjRrn+I22Zl4ReXzvqEGv1UBRoaJ+Cdg3UV
         S0vtnncZc6JxtJMohtX56hvQL53W8sbOYmRGW1r5BLYmFVVOGHw1Wi7MCNh77WpUsw
         7etyYuG54qu1EvQV+z/d7bNsagq0tmbBD6sbYV6n/3ufzssoMrjUnG4xV1bhgdYrXs
         nQZluMhd1hvANGPtY12EqCKZLDB6Yi5f0HImAV8mwdep58HaYNUp5R+5I+NDy3O8nQ
         cAhtNtmDSUiNg==
Date:   Tue, 10 Oct 2023 10:29:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dlechner@baylibre.com" <dlechner@baylibre.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "pmolloy@baylibre.com" <pmolloy@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "ahaslam@baylibre.com" <ahaslam@baylibre.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "david@lechnology.com" <david@lechnology.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 02/27] staging: iio: resolver: ad2s1210: fix use
 before initialization
Message-ID: <20231010102912.0b70c3e0@jic23-huawei>
In-Reply-To: <de527e3f87effe7e446b44d84e43aead26f9fdec.camel@axis.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-2-fa4364281745@baylibre.com>
        <1b366292-6e05-421e-914e-6d3457886238@kadam.mountain>
        <20231002101742.0000774b@Huawei.com>
        <de527e3f87effe7e446b44d84e43aead26f9fdec.camel@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 14:48:29 +0000
Vincent Whitchurch <Vincent.Whitchurch@axis.com> wrote:

Hi Vincent

Thanks for the update,

> On Mon, 2023-10-02 at 10:17 +0100, Jonathan Cameron wrote:
> > Hmm. What happened to roadtest?  I was hoping that would solve this sort
> > of issue by allowing simple testing of basic functionality... =20
>=20
> Roadtest is alive and well.  Several of my coworkers have been using it
> for development and testing of new drivers[0][1][2][3][4] and
> patches[5][6], and this has resulted in easier testing and refactoring
> during development, more robust code, and of course the ability to
> easily detect regressions after the patches are merged.
>=20
> [0] https://lore.kernel.org/lkml/20230323-add-opt4001-driver-v2-2-0bae039=
8669d@axis.com/
> [1] https://lore.kernel.org/lkml/d218a1bc75402b5ebd6e12a563f7315f83fe966c=
.1689753076.git.waqar.hameed@axis.com/
> [2] https://lore.kernel.org/lkml/7b856b74c4c0f8c6c539d7c692051c9203b103c0=
.1692699931.git.waqar.hameed@axis.com/
> [3] https://lore.kernel.org/lkml/20231002-rx8111-add-timestamp0-v1-1-3537=
27cf7f14@axis.com/
> [4] https://lore.kernel.org/lkml/20230502-tps6287x-driver-v3-2-e25140a023=
f5@axis.com/
> [5] https://lore.kernel.org/lkml/20221012102347.153201-1-chenhuiz@axis.co=
m/
> [6] https://lore.kernel.org/lkml/20220413114014.2204623-3-camel.guo@axis.=
com/
>=20
> In fact, by running our roadtests on newer kernels we have found
> numerous bugs[10][12][14] and regressions[7][8][9][11][15] in mainline,
> including subsystem-level issues affecting other drivers too.
>=20
> [7] https://lore.kernel.org/lkml/20230911-regulator-voltage-sel-v1-1-886e=
b1ade8d8@axis.com/
> [8] https://lore.kernel.org/lkml/20230918-power-uaf-v1-1-73c397178c42@axi=
s.com/
> [9] https://lore.kernel.org/lkml/20230829-tps-voltages-v1-1-7ba4f958a194@=
axis.com/
> [10] https://lore.kernel.org/lkml/20230613-genirq-nested-v3-1-ae58221143e=
b@axis.com/
> [11] https://lore.kernel.org/lkml/20220503114333.456476-1-camel.guo@axis.=
com/
> [12] https://lore.kernel.org/linux-iio/20220816080828.1218667-1-vincent.w=
hitchurch@axis.com/
> [13] https://lore.kernel.org/linux-iio/20220519091925.1053897-1-vincent.w=
hitchurch@axis.com/
> [14] https://lore.kernel.org/linux-iio/20220620144231.GA23345@axis.com/
> [15] https://lore.kernel.org/linux-spi/YxBX4bXG02E4lSUW@axis.com/
>=20
> (The above lists are not exhaustive.)
>=20

Great stuff!

> > Hope it is still headed for a new version / upstream! =20
>=20
> I pushed out an update with a squash of (most parts of) our internal
> version out to the following repo, it's based on v6.6-rc4.
>=20
>   https://github.com/vwax/linux/tree/roadtest/devel

Thanks.

>=20
> (There are currently 6 lines of --diff-filter=3DM against v6.6-rc4 on the
>  linked repo.  Two of those are from a patch which is posted and waiting
>  for review on the lists, and the rest are for enabling regmap debugfs
>  writes which are used from some of the newer tests.)
>=20
> Since roadtest itself does not require any patches to the kernel or any
> out-of-tree modules, the maintenance of the framework would not really
> be simplified by putting it in the upstream tree.  However, there is of
> course a potentially large benefit to the quality of many kinds of
> kernel drivers if roadtest gets used by others, and having it in-tree
> could facilitate that.  And it would potentially allow regressions like
> the ones we're finding to be caught _before_ they go in, since anyone
> can run the tests without special hardware.

Exactly  - my main interest is the dream of getting to the point where
new drivers typically also come with roadtest tests, with the aim that
they will be used for regression testing. For IIO I might lean on
/ ask nicely  few of the bigger contributors to add fairly comprehensive
tests for say one in 3 of their drivers, providing a canary for any
subsystem level problems that might sneak in. The stability gained for
those drivers might also prove it's own benefit to push people to add tests.
At somepoint in the longer term I might even make it a requirement for
upstreaming a new driver + slowly tackle the backlog of existing ones.
=46rom my experiments with it last year, this is a trivial burden fo

>=20
> The idea of having to maintain it in-tree and doing all the work that
> goes along with that (dealing with the expectations of maintainers,
> wrangling patches from mailing lists, etc), is something I personally
> have had a hard time warming up to, but I have some coworkers who may
> potentially be interested in that kind of work, so I wouldn't rule out
> another posting of the patch set targeting upstream sometime in the
> future.

I fully appreciate your concern.  I just really like roadtest and want
a smooth way to integrate using it with my upstream maintenance (and occasi=
onal
development) process...  I of course can't expect you to commit to anything
though - I'd be delighted if someone else wants to take this forwards but
that would be very much their decision to make!

Having not yet waded into the latest code, how 'stable' is it from the point
of view of modifications to tests?  I can rebase the ones I have out of tree
and see, but I'm after an assessment that incorporates what you are
planning to change in future.

I guess the nasty stuff is if you have a few hundred additional drivers
in the test set, any modification to the way they interact with the core
of roadtest becomes very painful to push into those tests.

One starting point would be to separate the tests directory from the
directories containing roadtest frameworks etc as that would help to
limit scope of responsibility.

If a potential upstream roadtest maintainer is primarily concerned about
review + handling of the actual tests, other than potentially letting in
some ugly code, I'd imagine any subsystem maintainer who opts into this
will take that burden on - perhaps with the occasional question heading
your way. I'd certainly not expect you to have to deal with high patch flows
and would ensure that didn't happen for any IIO tests (any review people
have time for is of course welcome!)

+CC a few maintainers of other subsystems who may be interested (I know
one of them is ;)

Jonathan

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC46A7D6C71
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344243AbjJYMzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjJYMzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:55:11 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE46AC;
        Wed, 25 Oct 2023 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1698238507; x=1698497707;
        bh=6lMF1JifW5huSVXWVFOd0HhrR0SzxrcAOage3NSxPW4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=UfETWEAZXEqJ4NovRWp4g+BBGNogT8gEA8DtuV9/dEn6wU8I+JggfcnlWb1AgUC27
         kETCGEIyFXKjSvFEjOz9hj8k7YL9vut8PlQUmOS/RvGI/FyoyfcvKkwlwcunYrQVPO
         eKLFhndpUvabDu0ZvE3rMISjptWkhBOX6yCNHXa62j7ic7SZOsy8Wjfg7ywuBk3NRE
         9foDObui7X5onbh1XygKlzNqpUUnqXfzZ2aS28L0U+2mYrIX8UhB34LMOC8Dp71dYR
         7/D5zqnO7b0I0msfWBIeB7N6ViMB35MF0969HegLSU0URVGoz5bpLQNQjGU0I7DSuK
         FiSVV8cRZdtQw==
Date:   Wed, 25 Oct 2023 12:54:44 +0000
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: fix connector type to be DisplayPort
Message-ID: <EeTPIPMpLMJf5ZaAnmfLL8a1MUy4DRxST6oU_-N44pa3XfyglLs_sWXdnOvjJLTzahjZhkRqWIO9TwXj4bhSKwBIUYkuIufXms2UjZ7MJjA=@emersion.fr>
In-Reply-To: <65f841ba-5b70-4cbe-98e0-3d53e5b7944c@linaro.org>
References: <20231010225229.77027-1-dmitry.baryshkov@linaro.org> <ZTkIpMWpxKzSE7gQ@hovoldconsulting.com> <NDl6Ye92jJDp3fm20AwcuUKWuP8tzQ9CyWGGRltZ_DxYgxep2DO8Wil0Nmsfmhp1j4vAp9Yu1duiHeQkjBG-bcAdFoW3ZbWxvVqrCEpQe_4=@emersion.fr> <65f841ba-5b70-4cbe-98e0-3d53e5b7944c@linaro.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 25th, 2023 at 14:45, Dmitry Baryshkov <dmitry.baryshk=
ov@linaro.org> wrote:

> On 25/10/2023 15:29, Simon Ser wrote:
>=20
> > On Wednesday, October 25th, 2023 at 14:22, Johan Hovold johan@kernel.or=
g wrote:
> >=20
> > > I was just going to post a patch fixing this after finally investigat=
ing
> > > why the DisplayPort outputs on the X13s were annoyingly identified as
> > > "Unknown20-1" and "Unknown20-2" instead of the expected "DP-1" and
> > > "DP-2".
> >=20
> > Note, ideally userspace should use drmModeGetConnectorTypeName() from
> > libdrm to figure out the proper name for a connector type. That way we
> > only need to update a single spot when adding a new connector type,
> > instead of patching a whole bunch of programs.
>=20
> X11 does its own thing. It further "renames" DP MST connectors. So on my
> laptop I end up with DP-1-1 in xrandr, but DP-3 in kernel.

Right. But that function only takes in a connector type enum as input,
and returns a string for the type only. It doesn't include the suffix
with the number.

IOW: xserver could use drmModeGetConnectorTypeName() and then append
"-2" or "-1-1" or whatever.

But with the current appetite for xserver development this is probably
not going to happen (and doesn't matter very much).

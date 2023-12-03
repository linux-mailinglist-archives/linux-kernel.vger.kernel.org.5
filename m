Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E680B8023A3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 13:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjLCMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 07:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 07:15:39 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F1BFE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 04:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1701605741; x=1701864941;
        bh=zeJoJaDEd/VJIzT04Xj0cuJGWNQ8PVAG6G1sblS0Nyw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=gzlNXqtxmiGejNIfLz4esavOMLl5pQMwwYqxpB6F06RkVWa7dI3Ipy7d5+RH1d3Xu
         5tHOtT5oO7Ya+pH2qxH/nmZVE21DQhJWuc+smqr0GtBdMh5vfwZF1kkCIJYevA4WAY
         E+7wVJ2bhKk06PAGYgHLlxZZ9tB7WmkOm7/67+KFbFiFJvKf78OY44GmVi7aSN0dMS
         cbpjNrEc+mzbir0n63jbEcTrwlSPqay9EB4jgT3epqZdb3+zplMiWXjE6Maq940gqC
         l4wIW6+AQa3MiBMwS/e7tOvEJ5n5+qJq06i9FDwK3FtHWBQq/wS5GYJlUuGcA4z3ff
         dDupDPAFHgLIg==
Date:   Sun, 03 Dec 2023 12:15:32 +0000
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        laurent.pinchart@ideasonboard.com, sebastian.wick@redhat.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sebastian Wick <sebastian@sebastianwick.net>
Subject: Re: (subset) [PATCH RFC v7 00/10] Support for Solid Fill Planes
Message-ID: <OiX1EToyQ0JBECS-Vs6IOw1vqLTt42PYkTlTCBhsPUi-VXC2UoLjkRfEW-OFucxsTqz93Q3IIXZZ3Lw_Lqs1dFt4YbuFSUGrKfDPnnKDCbw=@emersion.fr>
In-Reply-To: <170155324921.2215646.4829699354481827834.b4-ty@linaro.org>
References: <20231027-solid-fill-v7-0-780188bfa7b2@quicinc.com> <170155324921.2215646.4829699354481827834.b4-ty@linaro.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, December 2nd, 2023 at 22:41, Dmitry Baryshkov <dmitry.baryshko=
v@linaro.org> wrote:

> On Fri, 27 Oct 2023 15:32:50 -0700, Jessica Zhang wrote:
>=20
> > Some drivers support hardware that have optimizations for solid fill
> > planes. This series aims to expose these capabilities to userspace as
> > some compositors have a solid fill flag (ex. SOLID_COLOR in the Android
> > hardware composer HAL) that can be set by apps like the Android Gears
> > test app.
> >=20
> > In order to expose this capability to userspace, this series will:
> >=20
> > [...]
>=20
>=20
> Applied to drm-misc-next, thanks!

Where are the IGT and userspace for this uAPI addition? 

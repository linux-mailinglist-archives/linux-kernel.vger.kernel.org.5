Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3B67D2C79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjJWITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:19:20 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B455C4;
        Mon, 23 Oct 2023 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1698049156; x=1698308356;
        bh=WxADqybr844I3oyxhgF11CfEL7UzS7ZR4cFdELQGNvc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=U2RcwxLU7ur57UbIqCUc41rPeN8/K52RWTLgORhgJU5QCGJ7yuP/p1Xi0EqVjMKAW
         htgDguF11LRmmTvNhgmHoWbDlWHHq+nQnEHLaJAHT4svQzQszctKAuxU9jcXg88xeW
         /r2ObbAxjn+pX9LpZfk8L9RoxG1aw0Sj7i6a3cEfZXXbMmPTGUNkHqYZbxBv0yVjvM
         gbTu505EB44iV5R0BwC6vJmBbDIR8ChlOn9NLzI1ZWR4hajxOIzWT2zrQkcSw4/Usw
         EsgsAcaN63gmyTSJc7XKGcWmJi9D+KDCEIwpQtvoHTOf0n7dSJHFC02fFuln/MkBmO
         eYnQkIKLYP0Ig==
Date:   Mon, 23 Oct 2023 08:19:05 +0000
To:     Albert Esteve <aesteve@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     qemu-devel@nongnu.org, zackr@vmware.com, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@gmail.com>, banackm@vmware.com,
        Rob Clark <robdclark@gmail.com>, javierm@redhat.com,
        krastevm@vmware.com, spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mombasawalam@vmware.com,
        Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
Message-ID: <219B7sJmmuzo8lj-2i5F6y0pc8XM03X6NdxHUq_R76N71AcTptEPcpjKLO9Rutriw88YtJDRNqibuR-YICIkhPnrBnQSM-Uu9YCc2uZoOiM=@emersion.fr>
In-Reply-To: <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
References: <20231023074613.41327-1-aesteve@redhat.com> <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr> <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 23rd, 2023 at 10:14, Albert Esteve <aesteve@redhat.com> =
wrote:

> On Mon, Oct 23, 2023 at 9:55=E2=80=AFAM Simon Ser <contact@emersion.fr> w=
rote:
>=20
> > On Monday, October 23rd, 2023 at 09:46, Albert Esteve <aesteve@redhat.c=
om> wrote:
> >=20
> > > Link to the IGT test covering this patch (already merged):
> > > https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
> >=20
> > Hmm. IGT should not be merged before the kernel, because as long as the
> > kernel is not merged there might be some uAPI changes.
>=20
> Right, but uAPI header was not updated on the IGT side. As per suggestion=
 of the
> maintainers, I added a static variable that matches the definition on thi=
s patch:
> https://lists.freedesktop.org/archives/igt-dev/2023-August/058803.html
>=20
> +/**
> + * Clients which do set cursor hotspot and treat the cursor plane
> + * like a mouse cursor should set this property.
> + */
> +#define LOCAL_DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT=096
>=20
> Once this patch gets upstreamed, the localized definition will be removed=
,
> replaced by the real one.

What if this patch gets delayed and another patch using the same number
is merged into the kernel first? What if someone finds a design flaw in
the uAPI and it needs to be completely changed? The IGT test would then
be completely broken.

As a rule of thumb: never merge user-space patches before kernel. As
soon as the kernel part is merged, it's fine to locally copy definitions
if desirable.

> > > Mutter patch:
> > > https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
> >=20
> > Seems like this link is same as IGT? Copy-pasta fail maybe?
>=20
> Ah yes, my bad, this is the correct link:
> https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3337

Thanks!

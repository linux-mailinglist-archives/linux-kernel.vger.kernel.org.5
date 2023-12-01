Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3120B800758
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378050AbjLAJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378071AbjLAJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:43:10 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CE12D65
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1701423100; x=1701682300;
        bh=R40xwJ5ZXVWF75wuJrURSlyJ6mwzxYaMIF9gQCcOzTI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=MzFOy8KC7MDm3loAEnPVEYW2PETiOOlVVyJU8Kh0ujd4bm99RgBdlxscGMLUE3XJT
         LJgJ61e6Tj6rg0yyKRfAiFQg68tG+qVidn54rRuVTOU4ZtV317FI0W3q9L9ohBecFp
         WH/jJV3u/aU2t97/6r0pR9O2Dp+lY+YewIMP5a3W+vd+qdTxMESQkV5MDHmPsqZXu2
         Pr3+LaA5lgEzo+v32Z83dThcjI6Kp1H+axJqJ/wtPCpeDCviBxVVzzFNck5TjN8rXc
         WptADAIdXIMPCkHaKem7VulOrHMrA31kM3ndscdq9iQeEiu5D0XEw4Aeo3oEIctaSV
         sfljdjJL+JG1A==
Date:   Fri, 01 Dec 2023 09:31:23 +0000
To:     =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
        Daniel Stone <daniel@fooishbar.org>,
        =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH] drm/doc: Define KMS atomic state set
Message-ID: <40gonZRoP7FjDn_ugL_LpXsqwoSCZtypIe7jiWg0t8lkTx94-gESc60Cuu5eWxivJoZCNg3i-cUG9kNpKQZeYdCJPawDpTSIXivJ_t_a87E=@emersion.fr>
In-Reply-To: <20231130200740.53454-1-andrealmeid@igalia.com>
References: <20231130200740.53454-1-andrealmeid@igalia.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for writing these docs! A few comments below.

On Thursday, November 30th, 2023 at 21:07, Andr=C3=A9 Almeida <andrealmeid@=
igalia.com> wrote:

> +KMS atomic state
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +An atomic commit can change multiple KMS properties in an atomic fashion=
,
> +without ever applying intermediate or partial state changes.  Either the=
 whole
> +commit succeeds or fails, and it will never be applied partially. This i=
s the
> +fundamental improvement of the atomic API over the older non-atomic API =
which is
> +referred to as the "legacy API".  Applying intermediate state could unex=
pectedly
> +fail, cause visible glitches, or delay reaching the final state.
> +
> +An atomic commit can be flagged with DRM_MODE_ATOMIC_TEST_ONLY, which me=
ans the

It would be nice to link DRM_MODE_ATOMIC_TEST_ONLY to the actual docs here.
This can be done with markup such as:

    :c:macro:`DRM_MODE_ATOMIC_TEST_ONLY`

Same applies to other #defines.

> +complete state change is validated but not applied.  Userspace should us=
e this

I'd s/should/can/ here, because there are valid cases where user-space does=
n't
really need to test before applying. Applying a state first validates it in=
 the
kernel anwyays.

> +flag to validate any state change before asking to apply it. If validati=
on fails
> +for any reason, userspace should attempt to fall back to another, perhap=
s
> +simpler, final state.  This allows userspace to probe for various config=
urations
> +without causing visible glitches on screen and without the need to undo =
a
> +probing change.
> +
> +The changes recorded in an atomic commit apply on top the current KMS st=
ate in
> +the kernel. Hence, the complete new KMS state is the complete old KMS st=
ate with
> +the committed property settings done on top. The kernel will try to avoi=
d
> +no-operation changes, so it is safe for userspace to send redundant prop=
erty
> +settings.  However, not every situation allows for no-op changes, due to=
 the
> +need to acquire locks for some attributes. Userspace needs to be aware t=
hat some
> +redundant information might result in oversynchronization issues.  No-op=
eration
> +changes do not count towards actually needed changes, e.g.  setting MODE=
_ID to a
> +different blob with identical contents as the current KMS state shall no=
t be a
> +modeset on its own. As a special exception for VRR needs, explicitly set=
ting
> +FB_ID to its current value is not a no-op.

I'm not sure talking about FB_ID is the right thing to do here. There is
nothing special about FB_ID in particular. For instance, setting CRTC_ID to=
 the
same value as before has the same effect. Talking specifically about FB_ID =
here
can be surprising for user-space: reading these docs, I'd assume setting
CRTC_ID to the same value as before is a no-op, but in reality it's not.

Instead, I'd suggest explaining how referencing a plane/CRTC/connector in a=
n
atomic commit adds it to the new state, even if there are no effective prop=
erty
value changes.

> +A "modeset" is a change in KMS state that might enable, disable, or temp=
orarily
> +disrupt the emitted video signal, possibly causing visible glitches on s=
creen. A
> +modeset may also take considerably more time to complete than other kind=
s of
> +changes, and the video sink might also need time to adapt to the new sig=
nal
> +properties. Therefore a modeset must be explicitly allowed with the flag
> +DRM_MODE_ATOMIC_ALLOW_MODESET.  This in combination with
> +DRM_MODE_ATOMIC_TEST_ONLY allows userspace to determine if a state chang=
e is
> +likely to cause visible disruption on screen and avoid such changes when=
 end
> +users do not expect them.
> +
> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
> +effectively change only the FB_ID property on any planes. No-operation c=
hanges
> +are ignored as always. Changing any other property will cause the commit=
 to be
> +rejected. Each driver may relax this restriction if they have guarantees=
 that
> +such property change doesn't cause modesets. Userspace can use TEST_ONLY=
 commits
> +to query the driver about this.

This doesn't 100% match reality at the moment, because core DRM now rejects=
 any
async commit which changes FB_ID on a non-primary plane. And there is no wa=
y
for drivers to relax this currently.

I'm not sure this is a good place to state such a rule. In the end, it's th=
e
same as always: the kernel will reject commits it can't perform.
DRM_MODE_PAGE_FLIP_ASYNC does not need to be a special case here. Even when
changing only FB_ID, the kernel might reject the commit (e.g. i915 does in =
some
cases).

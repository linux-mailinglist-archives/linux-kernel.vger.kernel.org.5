Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F04791A6B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjIDPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbjIDPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:18:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C0CFD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B3561857
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 15:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922E6C433C7;
        Mon,  4 Sep 2023 15:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693840685;
        bh=Aiolu0deCHRlN8rPHQKBi2zyN7ouKZtnBFShwevMhxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9x8bQGTVSARatZFFu/5jaHsk3EWK4Dur19Y5p7VUP1DTBfbjvF7dXPJAIn2mkqON
         Ioxm3OSmQsmOaT4g57hRLaIqiICJChUrsi3JfrMRmQYvZZEAQG3xy8M4FxsCpF3uJp
         90A9W+xbrpd7k+LosLutIgUA6Rzn722UMYydakG1s5CHFq0cPJJcnV2x0undCMvcsk
         kppVV4DtRbDy1cdToy38Bw2fxz2ZJaJ2Er/CsKy0kKSY0hvxg4zTBZEfC0AH91BX9D
         uVBZd/U+PwA0cKeC+g2DVa5zPdb4ND+h3WQJJpKseBL67fEDeHVxHTxgxXiZ3yV4XC
         eH6JsKN6DWefA==
Date:   Mon, 4 Sep 2023 17:18:02 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 01/15] drm/armada: Call drm_atomic_helper_shutdown()
 at shutdown time
Message-ID: <usrnztprl7rjnm2t5bo72k6dsgfpy6zw6ezd33akua5zc3qsfu@iafn2r2mlcjo>
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.1.I3d5598bd73a59b5ded71430736c93f67dc5dea61@changeid>
 <ZPSsBhbekKY7VyDg@shell.armlinux.org.uk>
 <wi2j43vzk3t55xc6ylvbekxqybnc62fqpx7v277d5htcqxrtxf@qya4mbky2y7l>
 <ZPWNf51FrqBfyM1O@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZPWNf51FrqBfyM1O@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 08:55:43AM +0100, Russell King (Oracle) wrote:
> On Mon, Sep 04, 2023 at 09:36:10AM +0200, Maxime Ripard wrote:
> > On Sun, Sep 03, 2023 at 04:53:42PM +0100, Russell King (Oracle) wrote:
> > > On Fri, Sep 01, 2023 at 04:41:12PM -0700, Douglas Anderson wrote:
> > > > Based on grepping through the source code this driver appears to be
> > > > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > > > time. Among other things, this means that if a panel is in use that=
 it
> > > > won't be cleanly powered off at system shutdown time.
> > > >=20
> > > > The fact that we should call drm_atomic_helper_shutdown() in the ca=
se
> > > > of OS shutdown/restart comes straight out of the kernel doc "driver
> > > > instance overview" in drm_drv.c.
> > > >=20
> > > > This driver was fairly easy to update. The drm_device is stored in =
the
> > > > drvdata so we just have to make sure the drvdata is NULL whenever t=
he
> > > > device is not bound.
> > >=20
> > > ... and there I think you have a misunderstanding of the driver model.
> > > Please have a look at device_unbind_cleanup() which will be called if
> > > probe fails, or when the device is removed (in other words, when it is
> > > not bound to a driver.)
> > >=20
> > > Also, devices which aren't bound to a driver won't have their shutdown
> > > method called (because there is no driver currently bound to that
> > > device.) So, ->probe must have completed successfully, and ->remove
> > > must not have been called for that device.
> > >=20
> > > So, I think that all these dev_set_drvdata(dev, NULL) that you're
> > > adding are just asking for a kernel janitor to come along later and
> > > remove them because they serve no purpose... so best not introduce
> > > them in the first place.
> >=20
> > What would that hypothetical janitor clean up exactly? Code making sure
> > that there's no dangling pointer? Doesn't look very wise to me.
>=20
> How can there be a dangling pointer when the driver core removes the
> pointer for the driver in these cases?

You can still access that pointer from remove after the call to
component_del(). It's unlikely, sure, but the issue is still there.

> If I were to accept the argument that the driver core _might_ "forget"
> to NULL out this pointer, then that argument by extension also means
> that no one should make use of the devm_* stuff either, just in case
> the driver core forgets to release that stuff. Best have every driver
> manually release those resources.

It's funny that you go for that argument, because using devm is known to
be a design issue in KMS (and the rest of the kernel to some extent), so
yeah, I very much agree with you there.

> Nope, that doesn't work, because driver authors tend to write buggy
> cleanup paths.

And using devm is just as buggy for a KMS driver. We even discourage its
use in the documentation.

But really, I'm not sure what your point is there. Does devm lead to
bugs? Sure. Is it less buggy that manually unrolling an exit path by
hand? Probably. I seriously don't get the relation to some code clearing
a pointer after it's been freed though.

> There are janitors that go around removing this stuff, and janitorial
> patches tend to keep coming even if one says nak at any particular
> point... and yes, janitors do go around removing this unnecessary
> junk from drivers.
>=20
> You will find examples of this removal in commit
> ec3b1ce2ca34, 5cdade2d77dd, c7cb175bb1ef

Other people doing it doesn't make it right (or wrong). And really, I'm
not arguing that it's right, I'm saying that it's not wrong.

It's probably being over-cautious, especially in that driver, but it's
not wrong.

> Moreover:
>=20
> 7efb10383181
>=20
> is also removing unnecessary driver code. Testing for driver data being
> NULL when we know that a _successful_ probe has happened (because
> ->remove won't be called unless we were successful) and the probe
> always sets drvdata non-NULL is also useless code.

Again, I fail to see what the relationship is there.

> If ultimately you don't trust the driver model to do what it's been
> doing for more than the last decade, then I wonder whether you should
> be trusting the kernel to manage your hardware!

It's not the kernel driver model that I don't trust, it's C's (lack of)
memory safety and management. And like you said yourself, "driver
authors tend to write buggy"

> Anyway, I've said no to this patch for a driver that I'm marked as
> maintainer for, so at least do not make the changes I am objecting to
> to that driver. Thanks.

You're entitled to that opinion indeed.

Maxime

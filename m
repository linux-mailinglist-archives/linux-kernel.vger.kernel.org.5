Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8063791251
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbjIDHgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjIDHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37180FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7E360E07
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC303C433C7;
        Mon,  4 Sep 2023 07:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812973;
        bh=HFFWGiw/0uizFQtG50aI919dArfwrxeqsAuMKggc+5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4LlWGtoTssrh19alu6FCpRQEpibxXHAQar0iip3haPXS8+6V/gX5G9cnGzsK4+Eh
         3G0ATi5leP6ncrLHJS3g3p0UHpZp/1/ytMmibUUKHLr5RHqogPEmcD5/yrCrTtNOon
         b5hocdZASzjnhqe8c2yFVTr7j6aQTz0WUysn2Ru3JCluyXKyn33w99E6ANdL4AOPpE
         No2N5vfV7EKV/M/fKcjm7ulAdpJOKK+A7KITOTze6tTuSf0O3mibzZ2ruBGSaFCv6m
         WYVtFpH9yLcNt+u4FPI1ZvaAOAymhgSinFNLmapu7QV4QR8JlNaUSjxewJ9Tuf4E7p
         UD98lsz+2IRLw==
Date:   Mon, 4 Sep 2023 09:36:10 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 01/15] drm/armada: Call drm_atomic_helper_shutdown()
 at shutdown time
Message-ID: <wi2j43vzk3t55xc6ylvbekxqybnc62fqpx7v277d5htcqxrtxf@qya4mbky2y7l>
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.1.I3d5598bd73a59b5ded71430736c93f67dc5dea61@changeid>
 <ZPSsBhbekKY7VyDg@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZPSsBhbekKY7VyDg@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 04:53:42PM +0100, Russell King (Oracle) wrote:
> On Fri, Sep 01, 2023 at 04:41:12PM -0700, Douglas Anderson wrote:
> > Based on grepping through the source code this driver appears to be
> > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > time. Among other things, this means that if a panel is in use that it
> > won't be cleanly powered off at system shutdown time.
> >=20
> > The fact that we should call drm_atomic_helper_shutdown() in the case
> > of OS shutdown/restart comes straight out of the kernel doc "driver
> > instance overview" in drm_drv.c.
> >=20
> > This driver was fairly easy to update. The drm_device is stored in the
> > drvdata so we just have to make sure the drvdata is NULL whenever the
> > device is not bound.
>=20
> ... and there I think you have a misunderstanding of the driver model.
> Please have a look at device_unbind_cleanup() which will be called if
> probe fails, or when the device is removed (in other words, when it is
> not bound to a driver.)
>=20
> Also, devices which aren't bound to a driver won't have their shutdown
> method called (because there is no driver currently bound to that
> device.) So, ->probe must have completed successfully, and ->remove
> must not have been called for that device.
>=20
> So, I think that all these dev_set_drvdata(dev, NULL) that you're
> adding are just asking for a kernel janitor to come along later and
> remove them because they serve no purpose... so best not introduce
> them in the first place.

What would that hypothetical janitor clean up exactly? Code making sure
that there's no dangling pointer? Doesn't look very wise to me.

Maxime

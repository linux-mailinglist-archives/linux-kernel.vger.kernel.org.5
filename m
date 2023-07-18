Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521CC757F17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjGROLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjGROLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6B299
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B77C615AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368AEC433C9;
        Tue, 18 Jul 2023 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689689469;
        bh=GYbp7UBI7iFTj62OWBizSfS7AAbUCmizwOqllItI3GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAe2OAh/mqiuLhMH8IGw7Lw1rb0YhPtNNx6B00jbm3/jkNhe11cuVweGTIfPiXckP
         L80Rd9OIKDMi3xpqZZcvwdELCx/ARo5BQb/uSM4l/7bR6IFz0ViDVEw6KdL6md7bk2
         n55T4qHy6xa/2y+gr34KZuDC4BywyTdRs4u1CXS7gd99pn++N7mY+ub4j0YogNJrh7
         UUM6Nhct+qOi1KWf7WIu97FfsLPCn+C2Ih61uePShIFHDmnHAnxmVkpiy0ghL7Z3ad
         4HVOOOV+91J4FZ4FCZyyjcrZMJOqU+DnmYUF/S+mJ486RTfnCIxkmXrNbceBQ3FxP0
         lX8DG93xUUYog==
Date:   Tue, 18 Jul 2023 15:11:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 3/7] ASoC: Intel: avs: Move snd_hdac_i915_init to before
 probe_work.
Message-ID: <ce4da0ed-c938-49f7-be45-f65cbe1cbcc4@sirena.org.uk>
References: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com>
 <20230718084522.116952-4-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bEiL2V7XbHOmNFoV"
Content-Disposition: inline
In-Reply-To: <20230718084522.116952-4-maarten.lankhorst@linux.intel.com>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bEiL2V7XbHOmNFoV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 10:45:18AM +0200, Maarten Lankhorst wrote:
> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> the snd_hdac_i915_init into a workqueue. It's likely the whole workqueue
> can be destroyed, but I don't have the means to test this.

Acked-by: Mark Brown <broonie@kernel.org>

--bEiL2V7XbHOmNFoV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2nXYACgkQJNaLcl1U
h9CKMAf/V/cVn57TQ7LJoUtQJ3S1r4tnvZWxjgaI/8+N9nM3+NM4RMV9Zp4lJ2Ar
fB+bZ342dedQvTeGOAb59imgrhKAk85sMfuc/HjVtWZj4qe48tARXy0qjU+65uLa
aytmtp4J1vJQt1NzZxTXJRUZwI3KRWAafbvao8eXXVymugajOqmRVZGNQGlOfXBs
uO7YUUvxgsxCDSXRG+8MiNRgXgkKhp06dgTVPYt30gNSNCTfZ9LSXSc3K//dEw7w
Fsroa+d3HSIcWzoVeEK6dED/snChGRFcQIvgx1dAjRerFzeNNNEKoberi0cXbI44
0PXFN9Cm9PzExS0NFom01Q8+eagbMg==
=zpvD
-----END PGP SIGNATURE-----

--bEiL2V7XbHOmNFoV--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C467CDC64
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjJRM4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjJRM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:56:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E30109
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:56:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA518C433C8;
        Wed, 18 Oct 2023 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697633778;
        bh=RfajBlwcuXvS+TumbX+H26qssz1sCsAhi7MdYhWbndc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJVkvpwrSgXAy6qscSeVWxmppjv3m8n4+kX+4AHQ14KMDidYa9FDRWG1HZLJYOetF
         bjmQdZUNaS7DMv9iAYakN7DzObetRdzpsgVz5TlhdcmTvAoHhpRsO4VgW7zJRrTjvH
         JyX88p2CZz9M1iJQAcQ22FXKBwOOtTXdd4j1hBSY49tVOlX9COd0jkM+7WByoOpBCB
         WKnprgmC/NsbLe4ii21o2elYvR+OHBKVGJNMKKBHA8QMD15FVqPqP9RbuyNRizwID+
         1ESgcoh9BLGO68YjQlkoxeJRXAErVYY/mC5Wj1qGcqKlGqgI7+kFdvu8Yvs5p0bB7G
         qYnqMZ5nYBpkA==
Date:   Wed, 18 Oct 2023 13:56:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: wsa884x: allow sharing reset GPIO
Message-ID: <b7aeda24-d638-45b7-8e30-80d287f498f8@sirena.org.uk>
References: <20231018100055.140847-1-krzysztof.kozlowski@linaro.org>
 <3aa9e3a7-9417-44b4-87d8-fcf1a8b46daf@sirena.org.uk>
 <84f9f1c4-0627-4986-8160-b4ab99469b81@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SeEMerEnyAsMxP6P"
Content-Disposition: inline
In-Reply-To: <84f9f1c4-0627-4986-8160-b4ab99469b81@linaro.org>
X-Cookie: Santa Claus is watching!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SeEMerEnyAsMxP6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 18, 2023 at 02:38:00PM +0200, Krzysztof Kozlowski wrote:
> On 18/10/2023 14:35, Mark Brown wrote:

> > How do the speakers coordinate?

> They don't and that's the generic problem of many Linux drivers. Not
> only this one, but others as well.

> Device unbind (remove()) or runtime suspend of one speaker will affect
> other speaker. I don't think any other drivers solved this, because this
> is rather core's GPIO issue, thus I am not solving it here either. :(

I'd expect that the GPIO users should coordiante directly rather than
rely on the GPIO API to do the coordination for them - there aren't
enough semantics in the GPIO itself to do much more except possibly
provide discovery services (which would be nice).  Look at how the
regulator API manages multiple regulators sharing an enable GPIO for
example, it adds an additional layer of reference counting when it
identifies a shared GPIO.

--SeEMerEnyAsMxP6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUv1eoACgkQJNaLcl1U
h9Arjwf+MY/q21wh5tBoMbw8vn1r4Ag4O1t2M+4gxxtLbqzpaWKPc99mHcw04BMC
1ddMktsfr9bnWH0PBXYhrKahMdfDlXrotllyDtWS0i9hQUOhrgFKj0r4192NDc4q
do9drmxc8ikNhIP4AWqQTj0uLXEwRuHqj4gXnak6M0ScAi9cLYo0BvIBi/g8f+jY
U609DqfVDLVbntcAVB+b6j087AwW1drZ4cj2XV7TppJtUE1IWku3rlb95zm2jC0B
SwQI49ZkObNk2YiErX33Q9qmIitZbtgLvBR3DHsZHlBaswBT/IApJRnu1VOJsHX4
/56/6Ela2XeuYcFE3rPB0ExOstsO+g==
=lF0c
-----END PGP SIGNATURE-----

--SeEMerEnyAsMxP6P--

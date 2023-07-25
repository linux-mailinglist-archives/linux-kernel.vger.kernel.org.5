Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E527621C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGYSsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGYSsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:48:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F65019BD;
        Tue, 25 Jul 2023 11:48:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 102606187F;
        Tue, 25 Jul 2023 18:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAF4C433C8;
        Tue, 25 Jul 2023 18:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690310930;
        bh=9z2CWtq0/82nikIe8VRpzGysE+DOafYFGSKt9l+SuCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0a4NTYiM4BGqddHD7/pWxkRXurwZRZau2P37HaQKQqeOZRfW/HAn4BvZ6dLgs2Jn
         dh7MmqzJ5fc3ZSz48kne8GyKJk9RVr+aoXw5+roMfsHcTgs1RbpaftU9F7YwyZshur
         ln/CUGPyATvzDZvBNiVhSng63Fe9fLGfTGk+1L2G+SR3vORw2f/XukTdnButS8X11I
         X0n2qBHS49x3g94HPr6VI0Bb7tVNgbM7szsgx6ebkYdyg91MmUQbYXTSmz51QGk5c0
         q62/3XmVQhAKWKUFe0S6ZexcALqQJGz/HBWzM2P2n67WuMg+5waGrIBxPXTJn6fF+0
         jy6OjZLDt5/EA==
Date:   Tue, 25 Jul 2023 19:48:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add mem_ops to avoid PIO for
 badly sized reads
Message-ID: <217fc47d-1251-46c0-a4d3-637850c4365b@sirena.org.uk>
References: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
 <20230725110226.2.Id4a39804e01e4a06dae9b73fd2a5194c4c7ea453@changeid>
 <1e7225c2-3ac6-43d0-a1cc-e9a207d263d4@sirena.org.uk>
 <CAD=FV=Uw99A6w5J_x7QoMH6Vv_zsFaSHNFGQPcJYMT2dbdi_+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vFHetvp8i1y3Zldr"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Uw99A6w5J_x7QoMH6Vv_zsFaSHNFGQPcJYMT2dbdi_+Q@mail.gmail.com>
X-Cookie: Happiness is the greatest good.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vFHetvp8i1y3Zldr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2023 at 11:30:30AM -0700, Doug Anderson wrote:

> Note that it's pretty likely someone wouldn't use this SPI controller
> for anything other than SPI flash. While it's theoretically possible,
> the controller is intended for SPI flash (supports dual and quad SPI
> modes) and is only half duplex.

TBH most devices are half duplex so it's not *that* big a restriction,
and dual/quad mode are obviously attractive if you need to transfer
large quantities of data.

--vFHetvp8i1y3Zldr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTAGQwACgkQJNaLcl1U
h9Bgmwf/QpHF+jCh1WT5k6hBqHkPpJ19oOxC/K4jJZofJDC2wQmHja8H8emZadLV
486xKln3CSwEcDMoEoSZ/9ilmIMBmQ4SvEn9QUAhMk9WgNOaq4DBS82/4c0Zh1SJ
nSkYqjHJH6i7HeaXAkt0bbXpehqRmDkDiYV40ii1QU4PhzFYHKeOyQCs1RPKeWEz
dVmBW232IIXI8SeGG0UcKbIHq7/RhReKXOpUhV6uDI7V7danCExaCi7ILkbCb0x2
nrYMj5XzNq4uDErd+xiNsxCm/+qgte+20n0v6U99mIRBTfqL6nqN3zQQ/VCvV6yY
v+rKPA3UBJlGJGKZHwwv3n3KTyJVxA==
=amWv
-----END PGP SIGNATURE-----

--vFHetvp8i1y3Zldr--

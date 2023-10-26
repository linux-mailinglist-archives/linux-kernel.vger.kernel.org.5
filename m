Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87C7D86A2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjJZQWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:22:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C493;
        Thu, 26 Oct 2023 09:22:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAF8C433C8;
        Thu, 26 Oct 2023 16:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698337335;
        bh=YhIOe17rBsFx92icu86i0z8h7wfkdHRNvVBDLAsxWVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTNSNlCfcnhyCI9TLmB+NXrgO0wicfjUSdnLkqipoCS7XXEMtLBfjTb8aewSuJChO
         gnf74nrYeJcsbkqGWZVrN5iwz16vR7JtBceENBBGQqYBTDkE1umpU187es+YFRi00a
         iRf2q/l+7czaovZnHyxyk4/US7/8ISmRGtUHHa/dL5v6Vxdl3zsU9gj0jy94L0XnhE
         Yx16s5x9xsyfERkPGoSUPXjsEBCATOkMl2F0xFAr5jU+U9DtOYZiFfU+360YAusFRQ
         jij93bRcX4V7fzvTmut8uNU5GgQ3sG+kseQ8vwx1dI4BkNxePth0GDAlVBmfkC5EQ+
         8KsaZ4z8TV4Xw==
Date:   Thu, 26 Oct 2023 17:22:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH] regmap: Ensure range selector registers are updated
 after cache sync
Message-ID: <66c2f5d4-23de-4faf-a816-919516927f94@sirena.org.uk>
References: <20231026-regmap-fix-selector-sync-v1-1-633ded82770d@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yV82cCzg5Dy/7U2I"
Content-Disposition: inline
In-Reply-To: <20231026-regmap-fix-selector-sync-v1-1-633ded82770d@kernel.org>
X-Cookie: I'm also against BODY-SURFING!!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yV82cCzg5Dy/7U2I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 26, 2023 at 04:49:19PM +0100, Mark Brown wrote:
> When we sync the register cache we do so with the cache bypassed in order
> to avoid overhead from writing the synced values back into the cache. If
> the regmap has ranges and the selector register for those ranges is in a
> register which is cached this has the unfortunate side effect of meaning
> that the physical and cached copies of the selector register can be out of
> sync after a cache sync. The cache will have whatever the selector was when
> the sync started and the hardware will have the selector for the register
> that was synced last.

Given the nearness to the release I've dropped this into my CI and am
intending to just apply it as soon as that's done in the hopes that it
hits tomorrow's -next and gets a bit more coverage, it would be great if
you could confirm if this fixes the systems where you saw the original
issue.

--yV82cCzg5Dy/7U2I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU6kjMACgkQJNaLcl1U
h9CEYQf/Q5ULTgilPiDhR27I79FYeKwJKoonfpkYACVHM8Bg3ARdRNNVH0f1MSOH
WhcTfUdcMXzSdG4pPadQ+ah06DEJxF4iDAqL3AE2uNrxCx1o5qaWNFtUAyc7XAzo
ts2i3VU8CoqvtxtPf7V9I3QX/ah24O4x9TCbT5w2Hgf6wrObBBtHKBsH+ySG1ure
4nYIaFJVgHie/xv8vubBQckPi67fXS/vk/Si/dTPrdbpCZkYs6wyuRDeigPbtmDR
492txYn87M30vK6imwm/0UM8ECAlYbDyfY+yN0rAanOWNerbXoVV4CVBiGlf3h8N
FlIV8R77ikrSVbxSpvjL95IyyfesSw==
=DxNy
-----END PGP SIGNATURE-----

--yV82cCzg5Dy/7U2I--

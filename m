Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C18F762146
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjGYSYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGYSYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047A41FC1;
        Tue, 25 Jul 2023 11:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E11361862;
        Tue, 25 Jul 2023 18:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4461C433C8;
        Tue, 25 Jul 2023 18:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690309453;
        bh=WnZ1MywMJ9vsHmTwWNSt2lizDXojVU7oDoLa/kmN9kU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqGpAhZNTlIOpXKfZt/IhpyUjJVGynu7+sdfijWYrxoUBVn7xQJcqhC5ziPcA3ZkO
         9J19kV/+wKuu9KJN8UXPgtfDp+jwdjEdHkc+i5eOZnFD7z+EpmR9yrbkEE2M5NjaSO
         D2V0SqGwwyo5a6nn/UIqmRBZgo5dLzO178h0vjC2rBsrsoP5toThvJFjdSoKtix7LY
         momzFRNC1nYP/8w3RqHzInJHvOaSuSf3I7dAO4HLUgOG8tH4Bwqc9z3zO2X0L0vOFl
         482+9BTo0IiAlUMq90cLyi850nVYCzBJV5r8Nz8t/wi4jug0jY9sFLmR8XB/PNJ/Oc
         cYgEKJ7CnSUQQ==
Date:   Tue, 25 Jul 2023 19:24:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add mem_ops to avoid PIO for
 badly sized reads
Message-ID: <1e7225c2-3ac6-43d0-a1cc-e9a207d263d4@sirena.org.uk>
References: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
 <20230725110226.2.Id4a39804e01e4a06dae9b73fd2a5194c4c7ea453@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SVnmq4fcVsYJnkFF"
Content-Disposition: inline
In-Reply-To: <20230725110226.2.Id4a39804e01e4a06dae9b73fd2a5194c4c7ea453@changeid>
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


--SVnmq4fcVsYJnkFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2023 at 11:02:27AM -0700, Douglas Anderson wrote:
> In the patch ("spi: spi-qcom-qspi: Fallback to PIO for xfers that
> aren't multiples of 4 bytes") we detect reads that we can't handle
> properly and fallback to PIO mode. While that's correct behavior, we
> can do better by adding "spi_controller_mem_ops" for our
> controller. Once we do this then the caller will give us a transfer
> that's a multiple of 4-bytes so we can DMA.

This is more of an optimisation for the case where we're using flash -
if someone has hung some other hardware off the controller (which seems
reasonable enough if they don't need it for flash) then we'll not use
the mem_ops.

--SVnmq4fcVsYJnkFF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTAE0cACgkQJNaLcl1U
h9DQ8gf/blcWhskfPKyQA9bm9rMncitJHYBDO/9Dy0cZv3Gyau8BxK3roKUVteYh
OsuHjDHVSXNXb6P7dPrezAsdT0bJbryFAH3truRstqLVCkrHMsTY9IPz4LWMWDoZ
nPD+zIq46tKapKys7UM1RXQX4ai1A6Z1p2BPCHPAiQ1XVuo5dhlMOEsEdgevUSHj
Kcw740LFPDxNwH6O2zM4XQyokUtdG6ByTEuhxsRfVjWRrIjVfwA7XDGooqfGbNDf
c2gE3XMSTX8RQnAEPmlfagttfgf0KA/gEXAYjP/0MdsWNzfUgV28Oix+otUm1b1z
LCPFzyGSOqu4faNxjvoXYlrhhbJjrQ==
=XHPv
-----END PGP SIGNATURE-----

--SVnmq4fcVsYJnkFF--

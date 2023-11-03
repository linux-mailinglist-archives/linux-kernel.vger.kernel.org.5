Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF38B7E0324
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346641AbjKCMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjKCMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:47:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AF4CE;
        Fri,  3 Nov 2023 05:47:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C26C433C7;
        Fri,  3 Nov 2023 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699015652;
        bh=YO66OvhP/VVHPNNy7Ei4mXR0Rw9gNOGEAcE5AmCI8wY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3+lSdzOQRk80PA8gPgTD8xYIKG2lrOnNFtRDeVdlBfG63Aers/mg7I4t8mFTPi9Q
         CW1HnBwAVo9YkCAyWfuj/1gSvy5Xb/zEBmaJzP6A6SIjAvsnT+EbIILp50AteGyo+J
         x7Kjygt9tYFgMSXS0lLD3fzQ9mHYTi1SNtuZIuUCs2OP3DCiJjG+mPcYG9rpLITvil
         hg5/Q+j/yEl+kcDXT3r9WGsxD9dr5KHWeMNcgxx16JsodFE5M1EQF3B3sSZLXJXFQv
         3O40cmAJcRVf+aArbfvdPfkqLBpWosdJOdPeiABcl8HwXMDHfEFAFTA0DRnv0batA5
         Q2uePOM2ZK9bA==
Date:   Fri, 3 Nov 2023 12:47:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        quic_srichara@quicinc.com, qpic_varada@quicinc.com
Subject: Re: [RFC PATCH 4/5] spi: qpic: Add support for qpic spi nand driver
Message-ID: <b35b4184-d456-46f3-9268-8f0af2fbb4eb@sirena.org.uk>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
 <20231031120307.1600689-5-quic_mdalam@quicinc.com>
 <a1270a88-49a9-4bdb-89a9-ce6929f2294d@sirena.org.uk>
 <2b9e943a-198e-7999-b898-e7b2498a9ffa@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Op0au9/l1MW2X+EM"
Content-Disposition: inline
In-Reply-To: <2b9e943a-198e-7999-b898-e7b2498a9ffa@quicinc.com>
X-Cookie: He's dead, Jim.
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Op0au9/l1MW2X+EM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2023 at 04:50:54PM +0530, Md Sadre Alam wrote:
> On 10/31/2023 7:53 PM, Mark Brown wrote:
> > On Tue, Oct 31, 2023 at 05:33:06PM +0530, Md Sadre Alam wrote:

> > > +	ret = submit_descs(snandc);
> > > +	if (ret)
> > > +		dev_err(snandc->dev, "failure in sbumitting spiinit descriptor\n");
> > > +
> > > +	free_descs(snandc);

> > This seems to be doing a bit more than I would expect an init function
> > to, and it's very surprising to see the descriptors freed immediately
> > after something called a submit (which suggests that the descriptors are
> > still in flight).

> Our controller supports only bam mode , that means for writing/reading even
> single register we have to use bam.
> submit_descs() is synchronous so I/O is complete when it returns.
> Hence freeing the descriptor after it.

That seems like the BAM API is very confusing and error prone.

--Op0au9/l1MW2X+EM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVE69wACgkQJNaLcl1U
h9Dkugf/VsaUo4k4Z3jLIBAgzXGrzjlRrTxTxJyGu9jDAXZeMeTn2A2E+PgfGf5D
5ZxgLrmrSJLMsRGWIRe8MqKiyThyN2rOC/er/oJE8n4SZ+FicSBXPCdR6TPUKCsf
M5Rl4Vhq+rBRkArWp/Y5luoG9/pDCs5mhGbY1SKkaR06RvftMV7MHgWodxyn7U5G
iexZwY9I3IzkpkB85edqNl0Vh89vvsjPKptH8WZOuc+mF1dRZGc5dkXwgHAScxKr
I5dAQky8hSXYoMsialzHArWpIWjdmuMELn9CKMTLpQvwc7pUWkqIi4GGB1TuYWMB
LiPTinFMPGc2XD8XqtWCHNbTvA9BfQ==
=xTC+
-----END PGP SIGNATURE-----

--Op0au9/l1MW2X+EM--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244CF7D3621
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjJWMJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjJWMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:09:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B8E9;
        Mon, 23 Oct 2023 05:09:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF8FC433C7;
        Mon, 23 Oct 2023 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698062958;
        bh=RbWCwja07DafbippZrSFdtxJIN4etVdKpVKTGaVHeOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCQgdLn2jvYJjLXPeS1gYaEliMFLBxOWUWhSwgjHA0D4C8hoNQt8EYZHZWcM0g5tS
         UX4a954QZyVkkm7wHyxY2oy3s38ibn8iVQ6sXfUQUKDU88ix3eMeTiZ6vg5v919Mj0
         xCXFu5Hz2YNjKRX15nDZhQbsIcUT2DSEn+8xomMlJxiKpbt90OT6uF/MvNuMKXisHA
         iSeU3SO/7NFFYLw7yFMxNmd4NFPxg6c0neYuyeYAs5ez176Lel9SbpcwQFLm22aUZy
         9OV0IRSvHzfrdGxNK6kqstI4xwppDKUtJjgAY7hth4YNtBrF/uUAk/57fFjOzmUuBI
         JCPqAcQDacXuA==
Date:   Mon, 23 Oct 2023 13:09:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH RFC 1/2] regulator: core: Disable unused regulators with
 unknown status
Message-ID: <80307316-f55e-4540-9c5f-655844c3b3f4@sirena.org.uk>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SPN+lB5wKEJ80DqE"
Content-Disposition: inline
In-Reply-To: <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
X-Cookie: Never reveal your best argument.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SPN+lB5wKEJ80DqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 04, 2023 at 04:17:17PM +0200, Stephan Gerhold wrote:

> Instead of -EINVAL we could also use a different return code to indicate
> the initial status is unknown. Or maybe there is some other option that
> would be easier? This is working for me but I'm sending it as RFC to get
> more feedback. :)

The more normal thing here would be -EBUSY I think - -EINVAL kind of
indicates that the operation will never work while in reality it could
possibly work in future.  Though for the RPMH it's not really the case
that it ever supports readback, what it does is have it's own reference
counting in the driver.  Rather than doing this we should probably have
logic in the core which sees that the driver has a write operation but
no read operation and implements appropriate behaviour.

--SPN+lB5wKEJ80DqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU2YmcACgkQJNaLcl1U
h9DG1wf+NXfFlCEiYLkBH4eo1ZKPyDHhg/GfUj6L8qCoftmrX4MX5dd5FNe8MCOY
w+ikBTafNI0VXvZrRy6Hi/b6iUK7LSB3teuJn0ppE5gXUmKpdzm09W9Rmh4GPMva
SFkIgiYXL6ou15043YVm/h22qnISmsdgejTjDkocjhGLShocTS1h3wNDSLl5XdrX
lFLJXxZHrxGu2KXvMNZDozkG4z8AbYOoN3M2hDOLk1lC0vEr/ZaIQYnR4Oqp8n1p
SH3kG+TeIP91UeC7HXV25hiUwHximvgImM6sL9BtNkHAthrv5GGaeBAIwLrXLzIU
uW4/pT3PRGlB6jtuNqlGKx3e4NMa/A==
=Y0WM
-----END PGP SIGNATURE-----

--SPN+lB5wKEJ80DqE--

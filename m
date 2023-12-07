Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0088090A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443500AbjLGSte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjLGStc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:49:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C09FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:49:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AEAC433C7;
        Thu,  7 Dec 2023 18:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701974978;
        bh=G4FBhGeRjPfSe4SRYmpgsgCrzQXR6Aqo+2KCcRbRobQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+F/Q4ELRgdKHqdCpRV+87xwm+vbvnpZDmTFVGOhs4opqEMYwJGN3iYkq04XoyIF6
         nuW/lmUxZfmszDmbRoOmFF1RULLYV2tBePOTCCpI6FKfckDQx7WdWKqutNNyuU/CdT
         x/mXc6i85eiy0ijIN/5SLZ7cN8jAJ5sd+3AMIcHTVOBvk5oypznKYnoCMCqkKKwzi5
         9KSkFiBCwVSiQc5pOIcGmzNLgcm7xt8eEEdR1Sg8pIs+XB73nHxk2trPG/rfJ1MJgQ
         5y3K5OGDgqjvxM0H0NE1lHJDfXTeLlMuIiS1VrZ39LErtxzvut4wNlisUhCtIf5qh+
         J1rm2U4jQmmRQ==
Date:   Thu, 7 Dec 2023 18:49:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] regulator: event: Add regulator netlink event support
Message-ID: <1ddd9fb6-a746-423b-ac2f-63cf4627846c@sirena.org.uk>
References: <20231205105207.1262928-1-naresh.solanki@9elements.com>
 <46b1d303-8104-4298-bd43-a649634f5393@gmail.com>
 <CABqG17jwAw6zqy9FLtZ3ppwLT+3fAQ21bGfMr4Xt5eTDm-jQMw@mail.gmail.com>
 <70cbf708-72a6-4413-8181-99441f676d57@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QsttYYoTueuG4VIU"
Content-Disposition: inline
In-Reply-To: <70cbf708-72a6-4413-8181-99441f676d57@gmail.com>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QsttYYoTueuG4VIU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 03:29:18PM +0200, Matti Vaittinen wrote:
> On 12/7/23 14:39, Naresh Solanki wrote:

> > When I wrote the code, I kept in mind to make sure to receive all events
> > from regulators so that userspace application (in my case BMC
> > application which does power sequence) has regulator events information.
> > Hence I assumed that its upto userspace application to decide on corrective
> > action based on events of interest.

> I do also think it probably is. However, do you see cases where the action
> to be taken is a result of a hardware-design. Maybe in such cases the
> information like "critical under-voltage, please shut down the system" could
> originate from the board designer's drawing-table, end up in board
> device-tree, be read by the drivers/kernel and then be sent to a user-land
> with suitable severity information indicating that an action should be
> taken. I am just speculating if we could have a more generic user-space
> application which took care of this instead of always writing a
> system-specific user-space application.

That definitely seems doable (see also the discussion about emergency
shutdown) and also for other applications like providing a UI
representing what's going on.  I can imagine figuring out which
regulators supply a SD card slot and looking for errors from them for
example.  BMCs might have similar applications.

> Still, as I wrote, I am not sure this is too important. I don't know if any
> 'action' decisions can be done based on currently existing ERROR/WARNING
> severities - and the netlink message API can be later extended by adding new
> attributes. So, please treat my message just as a fuel for thought - I'm
> sure you have better insight to the use of these notifications than I do :)

It does feel like it's going to be up to the system/application how
severe an individual error will be.

> > Current implementation is such that all events will be sent.
> > But I agree with you that it is not something desired as sometimes
> > application might not be interested in all events.
> > Also I'm not sure on multicast group, as currently only one group
> > exist for regulator event & how adding additional group would help.

> Again, this might be my delusion :) Once upon a time I wrote a (downstream)
> netlink interface for sending certain specific purpose measurement results
> to the user-space. I have a faint memory from those days that it was
> possible to specify the multicast groups of interest at socket bind() -
> time. In this way "multiplexing" the messages would be done by kernel and
> user-space code could only listen the messages of interest? Maybe there are
> caveats I am not aware of though.

I guess that'd overlap with the use case above with UI for something
like a SD card, filtering on the regulator.

> Yes. These were my points to consider - but you / Mark are free to use your
> judgement on if this makes any sense or not. I am not confident enough these
> are necessary "features" to really push for them.

It does seem like they could be useful.

--QsttYYoTueuG4VIU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVyE70ACgkQJNaLcl1U
h9CmYwgAhsAYbshLwEvIBqzziKs1VvOdFbDHv5/LVkYc+fVUl5ikHskpeonhfvp9
ld+XTmPRnpAbP81h4TfR4YeZqDjWECed4pkzuBi2SBmzKlCL0JxrLESjX46AsCpP
PJrw22l1RjCvfMccdftL2dOhtv3aG+uiQx+l6gggaZpbRPzIUV1SczyCq/PF9JKv
iFCf2AWbbqXG0Y9sGueL3nilEO5ca0bWrJAVG4iKdch3QFEhiYCJe5OVLskFwSp5
WsBRZevLIEMCNGa2uno/1QcU5dXqk0WgjdsqDSrTxgZMpVjlrKtovUGz4KsCrZ+E
vrO7tIMILA96WfjW5Nq7O2bYkSfDUg==
=FEuo
-----END PGP SIGNATURE-----

--QsttYYoTueuG4VIU--

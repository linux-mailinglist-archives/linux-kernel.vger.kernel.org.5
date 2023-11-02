Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2737DF7F3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347658AbjKBQur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:50:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E9197
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:50:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423B9C433C7;
        Thu,  2 Nov 2023 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698943842;
        bh=O65CvmFj/uSkKEy0WcrjZ/zC6Z5PEe3jCXYxUB4rgn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqHOwunEfj3ryjn3rI1GdDY/gYn70gF6ZC03KbwHTXi6N5CK70qiIjUiS2jJmagO+
         mGkKrd1UBBPzbM/7W/qtjXC+d862hgPQvOg+hOpy9L0+M9KTbq4dI6tbxoKNyR/YLv
         e1YhPqRxjWrTRlvcjfWP/TJlfBjI8bXg3RzdD0l1vIQUwr4IoiP8RvFJHp4V9TNmH2
         3n13MvxcGb6EXxVqVoehw893dXopCRfTPcbR3Hy8FFufPuHa5lVX0n9hQ9xhc1UuTW
         Z3FQ2kC25lFLmHdRgZ4bWYBfHTzaB7MUUMVYxZf72qKNB/VjFFwQqIj/MgaddSst3A
         CmvPvkwQ1NaAQ==
Date:   Thu, 2 Nov 2023 16:50:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
Message-ID: <f5829ebc-b3ab-409b-9271-e066c08aec6e@sirena.org.uk>
References: <20231005133059.917577-1-naresh.solanki@9elements.com>
 <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk>
 <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
 <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk>
 <CABqG17h949R+3NFgA1MvPLZFc6zkBi+WRPSE9qP4fCBv5gdXHw@mail.gmail.com>
 <c2dd0533-3a60-4481-8621-86578e62aab6@sirena.org.uk>
 <CABqG17h0OnMD-L1vYkJobji+Z=QPuYrd=ra1d7DncAN0_TO23A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y4NRhtzLRrVeYR/J"
Content-Disposition: inline
In-Reply-To: <CABqG17h0OnMD-L1vYkJobji+Z=QPuYrd=ra1d7DncAN0_TO23A@mail.gmail.com>
X-Cookie: A is for Apple.
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y4NRhtzLRrVeYR/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 02, 2023 at 09:03:40PM +0530, Naresh Solanki wrote:
> On Thu, 2 Nov 2023 at 20:31, Mark Brown <broonie@kernel.org> wrote:

> > That's the opposite sense to what I was thinking of - we're reporting
> > voltage changes and enables to userspace rather than just errors.  My
> > concern here is that this could generate an awful lot of notificaitons
> > for normal operation on systems that don't use the uevents, I was
> > expecting this to be used for errors.  Could you remind me what the use
> > case is here, I think I might've got myself confused sorry?

> Sorry for confusion caused because I should first described my application
> requirements.
> Currently my application is interested in know regulator status i.e.,
> ENABLE, DISABLE or ERROR.
> Also events are needed specifically to get them logged like
> UNDER_VOLTAGE, OVER_CURRENT, REGULATION_OUT,
> OVER_TEMP.

Ah, right.  Everything except for the enable and disable there looks
like it should be OK since they should normally just not happen but the
enables and disables might get a bit frequent with runtime PM - not
*super* frequent like voltage scaling but enough that people could have
an issue with it.

Netlink feels like it might be a better fit?  Not really looked at the
kernel side of implementing that and how sensible that ends up looking.

--Y4NRhtzLRrVeYR/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVD010ACgkQJNaLcl1U
h9CQvAf+OUh1Bjk8QXBKZsuTgrsqaYL1dI10kSTfA9pcvbW0cY5VlRcvj9xPOKDf
zZ4QoBzWadi/awU7rfibV2j2hrOwlmtRVE+FgDQk4rGajTfO06YTbmBvjybW7NUS
H64d+uJ5WhwqYkH7xjmb8noqXX7Dv1/v67umU/jxPm9MjkVWdMRCl99WD62/qkW3
KT0B/rTKH6HeJ6fwIgkXV/Y/64V4TxYYdpfCyP4vLusHilhEWcxAUZDFemXKwCWI
yS8qtFQ7FCql2URysRGP9cXnGK2qw6oPY26dnqU8RkHqEmzFejoGEm9Sx9FaBik+
k/qT9BdbXCHbS9xdOa8fDjDOfGP9dA==
=8nPx
-----END PGP SIGNATURE-----

--Y4NRhtzLRrVeYR/J--

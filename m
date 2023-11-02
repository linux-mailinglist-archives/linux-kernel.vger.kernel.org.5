Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9673E7DEDDF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjKBIFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjKBIFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:05:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01619111;
        Thu,  2 Nov 2023 01:05:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b9a456798eso451105a12.3;
        Thu, 02 Nov 2023 01:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698912314; x=1699517114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qm047SCnALoyYPhnGrJPWTE0UoF+m8QEisH8xFHbuwA=;
        b=cdXMCMtzIXIr9ixN3j9KUm8CiBKYEg8wYHZH2VLgeZ8w6Ez0pjmsy4AZs+npdbzRLN
         uvXxqYRQh+2CffLoFltzlll9DhHcuIvL6MO9R6bNjLDpCRo6xFYFe275lzXsru8rdXzP
         OjL4cQ5K6BjibL62f8ycIgoZmmJSgDqJqE/00wrHPASZ/8H7i+Mp+s/ziVGnEttJZPsJ
         GOwm+o/gwix5dk/rkrc3jsxVeJgMrBEI0jUZ55SC70sqrsxyTxPEW7pWxCtu10vOpTXI
         pKyDf6eAdrSWEPBCznrBqnlZeo7GDraM4h5cZMlKUme+zFTpYYbyqEVyGo7Gq0I9zHkP
         yXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698912314; x=1699517114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm047SCnALoyYPhnGrJPWTE0UoF+m8QEisH8xFHbuwA=;
        b=ZyUc0PIsNQ0xsicL5PlmPmVqAMfevbH+8SKqzmfytkZPtBKPg/Wkv1MhwGy+dEEY3g
         7DHRa7pPnCH7zdDk2/Yz4WWhNnP6oaix026/Mi98cDBPn7pMQ1wlrWGM2Cd/iwclHIT5
         JSqRt8GbUiyjusQMvpwisl/GPgPO7tjoCuDvjH63N9q1wYX+6Duq09waRWIESxCS3yFr
         7G3x3b2zucqVZBJsShcJDPKfucwzAYMZM9rA9fNrtJDRoFLO0Iar22TfQderOpsMXC28
         1Op1iJju1yo1eZGp+Z1DvNhq2XLSkQo1VQjJmblMaN5CtTd3wnnkayuaZAWsThFq+0l4
         8y8A==
X-Gm-Message-State: AOJu0YwV9DmP7uLRAZvHqEa1/nobof9BHonuhpN1AGtqf3G9Yd9qdqRL
        opOFpVWgkOktX0Xf6SwmnlI=
X-Google-Smtp-Source: AGHT+IFIL6VIw66cK4zpLiHDgDf8OIP34pUNG8oTkJtXAdQZP0h9DhMj83aCFzRYsJSB7uHCcpIhXA==
X-Received: by 2002:a17:902:f682:b0:1cc:7d96:3fe7 with SMTP id l2-20020a170902f68200b001cc7d963fe7mr4181116plg.28.1698912314313;
        Thu, 02 Nov 2023 01:05:14 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902740a00b001c9bc811d59sm2484716pll.307.2023.11.02.01.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 01:05:13 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 32F169201A25; Thu,  2 Nov 2023 15:05:09 +0700 (WIB)
Date:   Thu, 2 Nov 2023 15:05:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Huang Rui <ray.huang@amd.com>, Meng Li <li.meng@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michele Della Guardia <micheledellaguardia@yahoo.it>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Fwd: Abnormal battery drain with kernel 6.5 (Ryzen 5500u)
Message-ID: <ZUNYNEnGC8cm6ALH@debian.me>
References: <bede02c1-ef90-8e30-aa8b-e6fae49a8ccf@gmail.com>
 <ZPql6tqBCnXJh64J@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bFrQyoCjDpyscnAV"
Content-Disposition: inline
In-Reply-To: <ZPql6tqBCnXJh64J@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bFrQyoCjDpyscnAV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 12:41:14PM +0800, Huang Rui wrote:
> On Fri, Sep 01, 2023 at 05:42:22PM +0800, Bagas Sanjaya wrote:
> > Hi,
> >=20
> > I notice a regression report on Bugzilla [1] that have been already han=
dled
> > there. Quoting from it:
> >=20
> > > After switching from 6.4.x kernel to 6.5 I experienced an abnormal ba=
ttery drain since my laptop is actually never idle.
> > > I accepted default CPUfreq to schedutil and AMD Processor P-State mod=
e is 3 (active).=20
> > >=20
> > > I expected a different behaviour, but am I missing something?
> > > In my boot configuration I had "amd_pstate.shared_mem=3D1" and tried =
to remove this switch, but did not affect my power consuption.
> > >=20
> > > Is there something changed from 6.4.x to 6.5 that requires a differen=
t configuration to get an optimal power consumption?
> > >=20
> > > Thanks a lot for your attention
> >=20
> > See Bugzilla for the full thread.
> >=20
> > Anyway, I'm adding it to regzbot:
> >=20
> > #regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cg=
i?id=3D217853
> >=20
>=20
> + Meng Li/Perry,
>=20
> May we know which CPU type are you using? Try "lscpu"?
>=20

Sorry for the replying just now.

The reporter (on Bugzilla) had bisected to commit c8afaa1b0f8bc9 ("locking:
remove spin_lock_prefetch"). Telling regzbot:

#regzbot introduced: c8afaa1b0f8bc9
#regzbot title: spin_lock_prefetch() removal causes abnormal battery drain =
on Ryzen 5500u

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--bFrQyoCjDpyscnAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUNYLwAKCRD2uYlJVVFO
owZYAQDsb6Cd0wndv9wWOxPcE7C6GSlUhC+p6Vc2i0w7Ge2crwD9FjZVdMAnD7jZ
aptnxPSv+I+4kMDvo/d32CBDN4MTXww=
=xS7j
-----END PGP SIGNATURE-----

--bFrQyoCjDpyscnAV--

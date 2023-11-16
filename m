Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDA7EE47B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjKPPgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjKPPgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:36:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD35195
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:36:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66805C433C8;
        Thu, 16 Nov 2023 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700148967;
        bh=6C/AOQWdfUU4GssUzzyFj3g9QVT/w7qFRNOlqS3TXuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BEJAVynUeohXm9vE0j4lxmkxs22+mduLhGWHLSixGxPbtfq3aMf+74bEl9cUNW077
         wnP2Gf7K3RYrEiHWA2FS3RWdS1XDV3IseFhmxVL20I6GNcjWFVuce4U6XvbfFtCFQQ
         B5oOlDaNQ9neSxDhV2NRByiOvZmGJL94L8mg/sw5gycFj6/dW0tgW3VhaIri/GHyEa
         ufg9P7qJDr67mP8Mp5aR7Jrbnp1haOE/JQAzP5Y8ldcwE0NjF6NzCK9U+Gu3YCnJ+T
         CmgnWtML24xN3hm6CWTQt1Sndds5hX61RuaixHI/0Fr3mFyaIhYwAmAu/X6hjDzsyG
         GQxSgiHoQrhjA==
Date:   Thu, 16 Nov 2023 15:35:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Pandey, Sunil K" <sunil.k.pandey@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Message-ID: <54d3bc9c-9890-49f0-9e9d-78ea4d0d7199@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
 <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
 <ZVXvptSmmJ6MQ0dY@arm.com>
 <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
 <ZVYfO/yqRtuRYaJA@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uQPPwN7Bpn582Rw8"
Content-Disposition: inline
In-Reply-To: <ZVYfO/yqRtuRYaJA@arm.com>
X-Cookie: micro:
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uQPPwN7Bpn582Rw8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2023 at 01:55:07PM +0000, Szabolcs.Nagy@arm.com wrote:
> The 11/16/2023 12:33, Mark Brown wrote:
> > On Thu, Nov 16, 2023 at 10:32:06AM +0000, Szabolcs.Nagy@arm.com wrote:

> > > i guess the tricky case is stack!=0 && shadow_stack_size==0:
> > > the user may want a new shadow stack with default size logic,
> > > or (with !CLONE_VM || CLONE_VFORK) wants to use the existing
> > > shadow stack from the parent.

> > If shadow_stack_size is 0 then we're into clone() behaviour and doing
> > the default/implicit handling which is to do exactly what the above
> > describes.

> to be clear does clone with flags==CLONE_VM|CLONE_VFORK always
> use the parent shadow stack independently of the stack argument?

!CLONE_VM rather than CLONE_VM but yes, that's what the clone() and
hence current clone3() behaviour is here.

> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

There are mechanisms for disabling this...

--uQPPwN7Bpn582Rw8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVWNtwACgkQJNaLcl1U
h9A8OAf+L47MiEGy1oAQUIl/rvLWqgZ8e3qktbrm7eRIk6aacjo+7k3qdr6L7EHh
EoHwrpV3QlU1LOlZUuorSIjpKhs1FbWxUZd1Ga9NIqOl9h58OAmTJPMyGKqj1O8V
SBPrXY79ObkfEOV2W9O9KzOlTAzHbbn2Jx2SwmetnkCeAaBeIm8tU9mU/mt45Xz3
cn7H9ZbgXHYl/NbV01v8nilfK/5r07B1iyghvD8Ojwbq2QC1gXrRd+a4jzfS8Sp0
23Nx/lWmpn6PPAGl6iAUjScyWBCuklVHxAwYq1ilPPIeN/AVQOuDJ5enoQuNJcUA
eCNt8qYz4y6MmEATAyUySV/IPaEGOg==
=JqPF
-----END PGP SIGNATURE-----

--uQPPwN7Bpn582Rw8--

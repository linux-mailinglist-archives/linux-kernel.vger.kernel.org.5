Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDF67F2311
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjKUBaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjKUBaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:30:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6B1BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:30:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A95C433C8;
        Tue, 21 Nov 2023 01:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700530202;
        bh=KB6C3AARW98gRsfl4vb5qYka+ApFHo2V74XpC+kmCbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mC/i3X0/F2o1u4iuo/Gjsn/e3Pl1hvwqaW/PLQLhqvoWZjWSd4rhoEMIPgLlnwj0X
         RIMfVoKxO7uMuZ6RQcZLtq0qeJW0twNYTBWwPpqZeaIBW8Rr/YNkIGeQ12LaxOC/gE
         NrCtRn3aGzV8/XZhXL4oMEF6MEG7cqZups9obN4s5G51y03rI0qEo0/3E3dIjW1l+7
         5iMRaU3aU7xDFH6LjI/V8641PKbhFGN5eBYlt9QpbaMx7XOKbKZks+nOOFWBJe6dPM
         UvyOCyNl8JPX3I2lO6/K2Zofnk6PPcpV6lMvqh1YUdfl4muEwI+lWo6IdoHYtZATMs
         N45FbINojK0hQ==
Date:   Tue, 21 Nov 2023 01:29:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Message-ID: <ZVwIFNdABN1b+qWC@finisterre.sirena.org.uk>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
 <c8bb9dd9-ae18-4fab-a664-6ec4b0cb2e30@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YQqyVgGJY78HPdNK"
Content-Disposition: inline
In-Reply-To: <c8bb9dd9-ae18-4fab-a664-6ec4b0cb2e30@linux.dev>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YQqyVgGJY78HPdNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 08:58:40AM +0800, Chengming Zhou wrote:
> On 2023/11/21 02:49, Mark Brown wrote:
> > On Thu, Nov 02, 2023 at 03:23:27AM +0000, chengming.zhou@linux.dev wrot=
e:

> > When we see problems we see RCU stalls while logging in, for example:

> > [   46.453323] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > [   46.459361] rcu: 	3-...0: (1 GPs behind) idle=3Ddef4/1/0x40000000 so=
ftirq=3D1304/1304 fqs=3D951
> > [   46.467669] rcu: 	(detected by 0, t=3D2103 jiffies, g=3D1161, q=3D49=
9 ncpus=3D4)
> > [   46.474472] Sending NMI from CPU 0 to CPUs 3:

> IIUC, here should print the backtrace of CPU 3, right? It looks like CPU =
3 is the cause,
> but we couldn't see what it's doing from the log.

AIUI yes, but it looks like we've just completely lost the CPU - there's
more attempts to talk to it visible in the log:

> > A full log for that run can be seen at:
> >=20
> >    https://validation.linaro.org/scheduler/job/4017095

but none of them appear to cause CPU 3 to respond.  Note that 32 bit ARM
is just using a regular IPI rather than something that's actually a NMI
so this isn't hugely out of the ordinary, I'd guess it's stuck with
interrupts masked.

--YQqyVgGJY78HPdNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVcCBEACgkQJNaLcl1U
h9BY3gf/Yva03binr9nZWNKW+uopqvbdwWrBq7OeqsCiZhC+0HySXIFBScCUneTJ
aggO36Ya9Yl7jtV0K9xShKamayOfpWQWOreEP+K1BDQnxdr6/z0i0lW4qT62Ix9c
agOVYX8IQxPaiSuoF7SELhMMvtuC1LkYoAFN9f9NtD3FpGCu2j6ZPv/h7njxUwHl
3omiMObUyuScdEs0O7Bg1SwEcRpVIBuS2ybIvy+rSp4ni8NHBkN/4f0fZZrACH5o
gIQ5PAwFXR0XHhOxWSWnQjfEa4q5M7+y2KRofmtT44OD/7st3xxdbWU33tvnSycK
NQZPR9zoGXInFDz1PsNwwABL1y7AbA==
=OEUv
-----END PGP SIGNATURE-----

--YQqyVgGJY78HPdNK--

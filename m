Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1C87C9CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 02:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjJPAjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 20:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPAjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 20:39:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B57A3;
        Sun, 15 Oct 2023 17:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697416789;
        bh=uMQbvIjuouaO5EGzgM4PNOQuYkMVGdAqBoduHHeSpCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LDOq5fit+FwXQxnr44oeM+8ktjtNAzDLGjXRNdYRzr5JBNMcCEwGQcdgxo31yYYpy
         Y0eWxdmyP//S8LfHUY+mFyXbVuxjGr2I4dP2FvBeAVFL4iuwVI4zFC5qO9ikhWQPCe
         J+dOIVHO7DsL/0p5iI6ahm8Mt9j7LeIwbMvn+WjfYIv9vuFixHaIoQCauU5pkrg8nu
         PgedOzlSgGejCNQrcEqN0N0H8Ng7kt5K+5VmNs1dZrEdxAswislPuBBaGAiRguL/rS
         8uC89OsBOn5Bp1ALMzn4poYxyW5UcdKW9Jr+PBbngbYC7JKSLG8KbZQwmJd/jvUVz2
         y4iZjcvkHzWbw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7ytX5H0wz4wc0;
        Mon, 16 Oct 2023 11:39:48 +1100 (AEDT)
Date:   Mon, 16 Oct 2023 11:39:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Lei, Jun" <jun.lei@amd.com>,
        "Dhere, Chaitanya" <Chaitanya.Dhere@amd.com>,
        "Zhuo, Qingqing" <qingqing.zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Roman Li <roman.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20231016113946.698ac2da@canb.auug.org.au>
In-Reply-To: <cc75c480-5359-465e-adab-46b418ec5d97@amd.com>
References: <20231010124357.5251e100@canb.auug.org.au>
        <cc75c480-5359-465e-adab-46b418ec5d97@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7nrd7C_Dkl+S6cV.1qwjW5z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7nrd7C_Dkl+S6cV.1qwjW5z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rodrigo,

On Tue, 10 Oct 2023 15:14:46 -0600 Rodrigo Siqueira Jordao <Rodrigo.Siqueir=
a@amd.com> wrote:
>
> I think I have a fix for that, but some things are unclear to me. I'm
> only able to see this issue when using allmodconfig. Additionally,
> when I inspected the function, it had a few local variables, not
> enough to explode the stack size fwiu. Is there any option in the
> allmodconfig that makes it easy to see this issue? Maybe something
> that I'm missing in my custom config file? Is it possible that
> allmodconfig enables some option that might increase the stack size?
> Perhaps the FPU flags from GCC include something else in the stack?
>=20
> Also, for investigating this issue, I'm considering the local
> variables, but as you can see from dml_core_mode_support, it has a
> few pointers. Am I missing something?

This could possibly be caused by inlining of other functions that are
static within the same file.

Other than that, I am also at a loss.
--=20
Cheers,
Stephen Rothwell

--Sig_/7nrd7C_Dkl+S6cV.1qwjW5z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUshlIACgkQAVBC80lX
0GzEcAf7Brd4wjIjt7a98lqXoWjzZquWlVyJt8kE+RCpj36GhluBDDlWkPnGlJPH
aW1Sz7enwR+5UmSoiyCUdPT47TXZl28Y6hnLtZEnxBKGKyCNcl/H/XWlYZBxzLMk
ZK3SpSAEyx3YvBIdmaJk6M3bDZy73bjtqPoxX1vWXIVy23SQxfEkaBcVb2AD2znR
j/OqBHVpqxg3GXMs+2+YZ3mEFOvumzhXbCloWkyP3YMV3JuOFgApgavU3I9At811
Z5Gl8oIkT08F8N1ZMCP9HgyFvnRRS/YdTISHMafMqhjb0uC1nqy2pohf0+eBjeEy
5MYiTUwfYSIyA69IOe3I8YnMX8kdDA==
=1KBH
-----END PGP SIGNATURE-----

--Sig_/7nrd7C_Dkl+S6cV.1qwjW5z--

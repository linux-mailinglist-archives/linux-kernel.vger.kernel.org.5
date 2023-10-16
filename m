Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F37C9CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 02:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJPAUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 20:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPAUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 20:20:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E957E95;
        Sun, 15 Oct 2023 17:20:12 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-564b6276941so2913880a12.3;
        Sun, 15 Oct 2023 17:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697415612; x=1698020412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7+oJHozaJp3ARwDpXhkbVM/mB5nFnC7YhE1nMQs+T4=;
        b=H5Lioq5qmpGifqA6SvWPci0idUCzLn1sTwxXBI44W7s7aACMgPxsIx9a/ZfaMdxJqq
         /gPD9xwnTamQLP/WUxu/D8hkV++dFwuRTLJoGRyrayzjMNXgxsRtS3AA7kjXAAgSidLR
         0z09wb4m6u038ZHU+uRICQZ6f8BGdRkWqx++ffMAUn75feSQmW7kTcN6yRAZ1bjcjTeW
         13VdwJG1vKrBDfOjdVnBEyD684YWvf+9G1CW5s7OEFKT+hZJUkXv4r+pNbWZYEphBHLS
         3VVP9IjDI8RLdBXSZkMP+ch8D2PWF9DrYNhLOrpG/8z8BurFT7P9jNoafqajv+swiJtO
         wXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697415612; x=1698020412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7+oJHozaJp3ARwDpXhkbVM/mB5nFnC7YhE1nMQs+T4=;
        b=kAuvRCrKLCVbErky284Rq36AmGHLIZbhGVLOn1yiB8zBXIX5y7jFOaFyV0LNPVa/RC
         C4j3yWvzIQkJKux/hx8QLcth2ECMOy9I+xjKV/aruy2SOFRu/N2Pg2n6tkXoaVvnmOLP
         yLoFdegkLDX6OCjuIDWjMTCyjT9QW3lsc91pQ/ys0ctH9f+am1Yw9su8475kr2Jqp2qx
         jDQMBFCDXfqxQI7N95fh5cXgy7jmgxsAN2yMb2ny5vJMnnDpvjtb6EkPqmXChPGuxyKO
         gg81pqFJ3ydLiGpk05E0R2erQ11SnkLn5nKA8fJ384BDPLG0A1qOmXhtaDfXbAWchQ1X
         2sQQ==
X-Gm-Message-State: AOJu0Yyjp6UVBYhjzWiZygBCiyJmHQ18i6ydKlhXlPOHERqcQNCPPeQ1
        5sXtLHh4otjJYft3v8OkNx0=
X-Google-Smtp-Source: AGHT+IH2laczeXL+VN9BrWY3NVZ8iTr+4c1jER2bvqsu4716PkKX0BkrL3EJtryJWJwyVs5iZp4OAg==
X-Received: by 2002:a05:6a20:7f95:b0:140:3aa:e2ce with SMTP id d21-20020a056a207f9500b0014003aae2cemr43344864pzj.42.1697415612184;
        Sun, 15 Oct 2023 17:20:12 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b001c44c8d857esm7208939plg.120.2023.10.15.17.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 17:20:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3520A801B59F; Mon, 16 Oct 2023 07:20:07 +0700 (WIB)
Date:   Mon, 16 Oct 2023 07:20:06 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Vladimir Smelhaus <vl.sm@email.cz>,
        Linux Netfilter <netfilter@vger.kernel.org>,
        coreteam@netfilter.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: Flowtables ignore timeout settings in recent kernels
Message-ID: <ZSyBtn8cplLWoNn-@debian.me>
References: <ughg4v$130b$1@ciao.gmane.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N2rAuLPZGqdFV0iZ"
Content-Disposition: inline
In-Reply-To: <ughg4v$130b$1@ciao.gmane.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N2rAuLPZGqdFV0iZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 15, 2023 at 09:56:14PM +0200, Vladimir Smelhaus wrote:
> Netfilter ignores the timeout settings for a flowtable
>=20
> # sysctl -a -r flowtable
> net.netfilter.nf_flowtable_tcp_timeout =3D 30
> net.netfilter.nf_flowtable_udp_timeout =3D 30
>=20
> Situation. A long udp connection (tunnel) with some data flowing through a
> router. The connection is sent to a flowtable on the router. It's a few
> packets per second, more here and there, a pause here and there, and so on
> over and over. The pauses are minimal and are also limited by the tunnel
> settings to be no longer than 25 seconds. Everything is satisfying to make
> the connection last continuously in the flowtable and not reappear in
> forward. However, the connection keeps dropping out of the flowtable. It
> stays in the flowtable (offloaded) for a second at most and then it is
> kicked out, back to forward.
>=20
> In an attached test script you can see counters that should be zero but a=
re not. If I watch the normal packet flow on a particular router, I can see=
 packets in the conntrack table that should be OFFLOAD as ASSURED.
>=20
> Tested in kernel 6.5.6. In an old(er) kernel 5.10 it works as expected.
>=20

Then please perform bisection to find a culprit that introduces your
regression (see Documentation/admin-guide/bug-bisect.rst in the kernel
sources for reference). Also, it'd been great if you also post the
reproducer script inline (within your email) instead, as some MUAs
(like mutt that I'm using now) may ignore the attachment.

Anyway, thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: v5.10..v6.5

--=20
An old man doll... just what I always wanted! - Clara

--N2rAuLPZGqdFV0iZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSyBsAAKCRD2uYlJVVFO
oxD9AQDAp/pXr+d44wTxEyg9copCJnaEVKIixfFsamXwbWpI/QD/W2ZAb9J8yPcv
V/en2pgBB1CgZDhm7JzlxcWUrsKROwM=
=u4d8
-----END PGP SIGNATURE-----

--N2rAuLPZGqdFV0iZ--

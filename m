Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED97D288A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjJWCak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJWCaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:30:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12741E6;
        Sun, 22 Oct 2023 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698028235;
        bh=qZJjRgkqAihMjDj50w/GfceBMY5Z5Kln43KCHKCvuKA=;
        h=Date:From:To:Cc:Subject:From;
        b=Os14L4HN6ukL18xTuXR/Hc0RCMCvTXtP0vOJ8rj4h5lSbxMnOo9pexPLoYrvY2ed8
         Bq1HPL57buvdLdWZonYHsxM+Y8oP3jO+geU98DbpzzJ8L6GqP+GwKyHbs+aRehTRh7
         IomLOfjeyabSnZruN1WqGm6QCrpuEBF4mDQUgW37VqPhxPrLb5MGUiQOaWa62gWV+i
         +DTpy3BD/cdXQW5s1irGGvqApoAt+wYiwkgyD7WaqblAIEh9hjjKi9uxRIEOo6161K
         Fr9L2PVZFY4GXwSiRod0jo0sLKdwisSjoBWqmzDyZuUeXwWBqPh8tyMIs8eb2O6RqJ
         xpbPH5LXt3w+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDK171mk9z4x5K;
        Mon, 23 Oct 2023 13:30:34 +1100 (AEDT)
Date:   Mon, 23 Oct 2023 13:30:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the ftrace tree
Message-ID: <20231023133033.5d54f393@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9jVAICtGFUlw30MeC.db.J_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9jVAICtGFUlw30MeC.db.J_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ftrace tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/kernel/setup-common.c:604:10: error: 'struct seq_buf' has no m=
ember named 'readpos'
  604 |         .readpos =3D 0,
      |          ^~~~~~~
arch/powerpc/kernel/setup-common.c:604:20: error: excess elements in struct=
 initializer [-Werror]
  604 |         .readpos =3D 0,
      |                    ^
arch/powerpc/kernel/setup-common.c:604:20: note: (near initialization for '=
ppc_hw_desc')
cc1: all warnings being treated as errors

Caused by commit

  d0ed46b60396 ("tracing: Move readpos from seq_buf to trace_seq")

I have used the ftrace tree from next-20231020 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/9jVAICtGFUlw30MeC.db.J_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU12skACgkQAVBC80lX
0GwYjQf+IMS1mUIck6bBw+EqX9dMQDTwJd8M2Qe2DhQuawIpvuTf7cJ8FvGQuszK
dIa9is5KFYu8iZMybf4/JecN5urzf8jAFvf51mJt1Cc+jIsxh9vCMQAG6R7nFSMb
wnIGZYZ/dwJJghAnTw3AiEy4/wUXxYiVi9vChoXZcmsfsqrtVBUrXs5d3XMQv3dY
gWlaIYuS9GiFsGTD1QMfcMJWouEHmGE7skiGRn26EkRKoXKPhlTqMqEikQ9ayXLH
0i/g6Pfb+vBgaEwwMBDBA9roXhhiT/KPNpVxoqHDKK9n359FE5t6dwlNaLwV1c2G
oWHNG1/OHQ3biSz+ufWvsK6Ge3bGVw==
=z2K5
-----END PGP SIGNATURE-----

--Sig_/9jVAICtGFUlw30MeC.db.J_--

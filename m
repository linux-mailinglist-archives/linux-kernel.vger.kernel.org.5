Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6D6755911
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGQBfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQBfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:35:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C6E4B;
        Sun, 16 Jul 2023 18:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689557701;
        bh=bnvwNZQU3ddiFMia+1TsCXAcGm8c4FN8Q+vD+CXPH0g=;
        h=Date:From:To:Cc:Subject:From;
        b=Kk+rnRhx+j77vI2IVPEmstHrcQQ+cpbU9t2QZJd4Wfc4nGa4BCYBX636b9b9pCX5d
         oEqeCtUSFVpt7oW05ar8y/Cy8xDj+clqqWtKiNI1kXI6FfLZug5ZdjlUt1ewh6GYox
         vIdhGO0dINYQDHB4ziuexsyUtqDLCJlNVMEvrWb7dXVRpsF4BVdo5BAE1KsfC26Co2
         l8VS7XrWRjMj/j6yQ9N7OsiIzwdwg70ESX+DeFwuBtiDPs0AXTj7O6VSbElB5oT4E5
         +rLWZ3hMPLC9x2v23MnfTBX1HaxVv1Ke+DLIlhH9FVX9XsajFPu+mhYm71GM2qWbXx
         tI6OVDDcMdJ2Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R44QC59JNz4whq;
        Mon, 17 Jul 2023 11:34:59 +1000 (AEST)
Date:   Mon, 17 Jul 2023 11:34:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the cgroup tree
Message-ID: <20230717113457.527d7483@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4bTzXuWvwl5z6X1ORQXeIYl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4bTzXuWvwl5z6X1ORQXeIYl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cgroup tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

kernel/cgroup/cgroup.c: In function 'cgroup_local_stat_show':
kernel/cgroup/cgroup.c:3699:15: error: implicit declaration of function 'cg=
roup_tryget_css'; did you mean 'cgroup_tryget'? [-Werror=3Dimplicit-functio=
n-declaration]
 3699 |         css =3D cgroup_tryget_css(cgrp, ss);
      |               ^~~~~~~~~~~~~~~~~
      |               cgroup_tryget
kernel/cgroup/cgroup.c:3699:13: warning: assignment to 'struct cgroup_subsy=
s_state *' from 'int' makes pointer from integer without a cast [-Wint-conv=
ersion]
 3699 |         css =3D cgroup_tryget_css(cgrp, ss);
      |             ^

Caused by commit

  d1d4ff5d11a5 ("cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED=
")

interacting with commit

  677ea015f231 ("sched: add throttled time stat for throttled children")

from the tip tree.

I have reverted commit d1d4ff5d11a5 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/4bTzXuWvwl5z6X1ORQXeIYl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS0msIACgkQAVBC80lX
0GyvawgAljw5cf9eWDqP6vP6up0CFVJ4JssGbh/NxoRlgRK2+flCbqGDBLSskun3
6r0mkoUckgE0QK4VnFOET8f9pEuLOQ6mT2QzfVjJ2LbzjpK0smFjG6NHuNAH7Vob
6Bg6wVNl81zbebO4ArFvH+Lc1xw8TnEeRHpb7pSVBMcpNXRE52EIrD8SUTiRsh7P
FcDZlLGrgwxbI0h7ksWaItsMNdbaThkJ3ou4GVqhbBbtEvj90GzQ2NAi4D+mflxz
mN9RsEAKQQYxnRaKsge5GRneSwJnLwZQUU3YMkhRd3QSMT6dgTFrmDXy71cTPLsu
Au22zSCGmQjHA0VEVL4YxzdmKFowcg==
=Hq1K
-----END PGP SIGNATURE-----

--Sig_/4bTzXuWvwl5z6X1ORQXeIYl--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179637FFEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377188AbjK3WrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjK3WrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:47:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074410FC;
        Thu, 30 Nov 2023 14:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701384428;
        bh=8dLRpQZRJvy3YV8A/Ir3qriNVtOM2tI73+ACdhrr2rQ=;
        h=Date:From:To:Cc:Subject:From;
        b=lTSJ9oqeFzhFT3UE4ncKxNBoPrnAkqRQ29/P6OKM5MMD+PWU/8iK2IkAZT6ZaBbtN
         RwE0ImCLsnrNOaiWrjLebU74Gi4JoF4X4zTYE3UBgU5ODRiiclwVyozQhzqyLTJoj/
         q37lEhASL3BGtk9QwshjU+k9N4ukFGVnZDKBHR6GsdDJZ3F0Yks8mS9hjkqLMaABJD
         GmoOg6f4oT9JKjP0EvkXqw6oUHEO1DDh8oF4ksVtrlpZkhw3zY/8LWJwJk0URcQYJS
         pVQ1UDJh/7J6YUb0Lqk1b7O7NoJh+gUQZKJeKO25l7OjlbvSmdqIvNvsff7Pi/5xU/
         6OhwYAKEF73KA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ShBCH3Jthz4xjd;
        Fri,  1 Dec 2023 09:47:07 +1100 (AEDT)
Date:   Fri, 1 Dec 2023 09:47:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: linux-next: manual merge of the bpf-next tree with the net-next
 tree
Message-ID: <20231201094705.1ee3cab8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g7K.f..gJSgW3O55nsC/Hs7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g7K.f..gJSgW3O55nsC/Hs7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  Documentation/netlink/specs/netdev.yaml

between commit:

  839ff60df3ab ("net: page_pool: add nlspec for basic access to page pools")
(and a few following)

from the net-next tree and commit:

  48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/netlink/specs/netdev.yaml
index 20f75b7d3240,00439bcbd2e3..000000000000
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@@ -86,112 -97,11 +97,117 @@@ attribute-sets
               See Documentation/networking/xdp-rx-metadata.rst for more de=
tails.
          type: u64
          enum: xdp-rx-metadata
+       -
+         name: xsk-features
+         doc: Bitmask of enabled AF_XDP features.
+         type: u64
+         enum: xsk-flags
 +  -
 +    name: page-pool
 +    attributes:
 +      -
 +        name: id
 +        doc: Unique ID of a Page Pool instance.
 +        type: uint
 +        checks:
 +          min: 1
 +          max: u32-max
 +      -
 +        name: ifindex
 +        doc: |
 +          ifindex of the netdev to which the pool belongs.
 +          May be reported as 0 if the page pool was allocated for a netdev
 +          which got destroyed already (page pools may outlast their netde=
vs
 +          because they wait for all memory to be returned).
 +        type: u32
 +        checks:
 +          min: 1
 +          max: s32-max
 +      -
 +        name: napi-id
 +        doc: Id of NAPI using this Page Pool instance.
 +        type: uint
 +        checks:
 +          min: 1
 +          max: u32-max
 +      -
 +        name: inflight
 +        type: uint
 +        doc: |
 +          Number of outstanding references to this page pool (allocated
 +          but yet to be freed pages). Allocated pages may be held in
 +          socket receive queues, driver receive ring, page pool recycling
 +          ring, the page pool cache, etc.
 +      -
 +        name: inflight-mem
 +        type: uint
 +        doc: |
 +          Amount of memory held by inflight pages.
 +      -
 +        name: detach-time
 +        type: uint
 +        doc: |
 +          Seconds in CLOCK_BOOTTIME of when Page Pool was detached by
 +          the driver. Once detached Page Pool can no longer be used to
 +          allocate memory.
 +          Page Pools wait for all the memory allocated from them to be fr=
eed
 +          before truly disappearing. "Detached" Page Pools cannot be
 +          "re-attached", they are just waiting to disappear.
 +          Attribute is absent if Page Pool has not been detached, and
 +          can still be used to allocate new memory.
 +  -
 +    name: page-pool-info
 +    subset-of: page-pool
 +    attributes:
 +      -
 +        name: id
 +      -
 +        name: ifindex
 +  -
 +    name: page-pool-stats
 +    doc: |
 +      Page pool statistics, see docs for struct page_pool_stats
 +      for information about individual statistics.
 +    attributes:
 +      -
 +        name: info
 +        doc: Page pool identifying information.
 +        type: nest
 +        nested-attributes: page-pool-info
 +      -
 +        name: alloc-fast
 +        type: uint
 +        value: 8 # reserve some attr ids in case we need more metadata la=
ter
 +      -
 +        name: alloc-slow
 +        type: uint
 +      -
 +        name: alloc-slow-high-order
 +        type: uint
 +      -
 +        name: alloc-empty
 +        type: uint
 +      -
 +        name: alloc-refill
 +        type: uint
 +      -
 +        name: alloc-waive
 +        type: uint
 +      -
 +        name: recycle-cached
 +        type: uint
 +      -
 +        name: recycle-cache-full
 +        type: uint
 +      -
 +        name: recycle-ring
 +        type: uint
 +      -
 +        name: recycle-ring-full
 +        type: uint
 +      -
 +        name: recycle-released-refcnt
 +        type: uint
 =20
  operations:
    list:

--Sig_/g7K.f..gJSgW3O55nsC/Hs7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVpEOkACgkQAVBC80lX
0GwfMgf/Y1kROolstfCuDvnjO6ADIeEc3IKBtmKNgjjIf0T3bTeb/ZLxhDym70hg
Lfs7Y5AajYBZHPmkt147kNgi+99LvhhL1Ggx2AINKJe6m4rSagoU6RLxg5ywgFO6
VBPU5V614OYM3w6U4cHzeC3mqBpU1CuJcKvm2hzi0IC1V2QXqK65LOgaQltmhfsC
T5KLuJCSWv+5jmFhijMfFrH4Pxv1XHbLHLID3Ko8kls+cvfcWPQLl9NToswXwfVA
AY6cbrWtGOhPAaYgDTP+uCsjc5G+02wlViKPgUfWYIg+7PGouL11pMkPWgfLToY/
LqxId7JLp6rU2KMdDhWVS/v1ija0Zw==
=oTgY
-----END PGP SIGNATURE-----

--Sig_/g7K.f..gJSgW3O55nsC/Hs7--

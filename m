Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0483077C911
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjHOICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjHOIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:01:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F11984;
        Tue, 15 Aug 2023 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692086504;
        bh=ZX+DKBNcQQA96+iZBsOLmnrHPJfNYbnO+Mt+UG52F6I=;
        h=Date:From:To:Cc:Subject:From;
        b=SKkHT2uyEY221tuT5QZFJBWGZt+mb58bqyouVZUAUyqgjrSvtpTLafA5c4dD/DUVz
         83tGkHZeBbywBhGedT0pUIe/yZgcI/mKffqUNhkQKAGbqPWxNdE4sV9nKU6OU+XmEL
         N21YFL8gnTkui9r7F8oqksuw1h5NL4eQDQui8m2TYS1dAoE/1HVrX+8AN3jawFnpXQ
         kimMVLatr6YS43vyFZcBhmTetREmsrAPrKjjiIP7pc1oHCSbg5kG2TqKLM6hO1fB5E
         PPwHWgCJBvXwMJ3d2iJEg+tikIIgu/G4CAP7uayCEjYBDTa9ZExOM+auCmkgElRMSJ
         KPBUhifQZVrYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ3d32YJQz4wbP;
        Tue, 15 Aug 2023 18:01:43 +1000 (AEST)
Date:   Tue, 15 Aug 2023 18:01:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>, Gavin Li <gavinl@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: linux-next: manual merge of the vhost tree with the net-next tree
Message-ID: <20230815180142.07a89703@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u_Dq3HKYyRlWpZq3vluuvn4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u_Dq3HKYyRlWpZq3vluuvn4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/net/virtio_net.c

between commit:

  308d7982dcdc ("virtio_net: extract interrupt coalescing settings to a str=
ucture")

from the net-next tree and commit:

  1a08d66726dc ("virtio_net: merge dma operations when filling mergeable bu=
ffers")

from the vhost tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/virtio_net.c
index edfd5d8833e4,c9cab3f966db..000000000000
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@@ -127,11 -126,14 +127,19 @@@ static const struct virtnet_stat_desc v
  #define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
  #define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
 =20
 +struct virtnet_interrupt_coalesce {
 +	u32 max_packets;
 +	u32 max_usecs;
 +};
 +
+ /* The dma information of pages allocated at a time. */
+ struct virtnet_rq_dma {
+ 	dma_addr_t addr;
+ 	u32 ref;
+ 	u16 len;
+ 	u16 need_sync;
+ };
+=20
  /* Internal representation of a send virtqueue */
  struct send_queue {
  	/* Virtqueue associated with this send _queue */

--Sig_/u_Dq3HKYyRlWpZq3vluuvn4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbMOYACgkQAVBC80lX
0GzvYgf5AR9fianxz6eRpHoXvFZXzXlDJhXOfJBRsXWIRDpKRtzhDVDFtVZY2VYE
d8CQCx3GRLv0WtoN3MMX3bGyZwBVA4AFwxQAEqjbUvOsfVoupzajc4BGGEcM8Mja
HX2aRO7NVZ/JEFhC38pKz4RqmDfdju9ziVSLVVLtPvCNpXde1oQrTXT75wnrpD4n
dcRHtkY13HrCp+72zOGExQnpvSXC5Q5VGxG2TnwQaCxdXVCPZAhwGmrGlhH7sYFE
yETSHDL8J/FMP6Itpgk6kLrJcXCSWQHGCICma9Hmv1HkceFW2mxk5e+cQpZSraK+
BtjkX4dFiXz4WBVPtubJCuYMhNi9PA==
=IAI9
-----END PGP SIGNATURE-----

--Sig_/u_Dq3HKYyRlWpZq3vluuvn4--

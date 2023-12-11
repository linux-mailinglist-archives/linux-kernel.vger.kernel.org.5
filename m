Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9480BE67
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 01:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjLKAAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 19:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKAAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 19:00:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E8E4;
        Sun, 10 Dec 2023 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702252825;
        bh=tbae79Omvl8ykcHGOoBf4uvnrHXq+QXZq14ZKRwbxdA=;
        h=Date:From:To:Cc:Subject:From;
        b=IXECbGYV2+JpQxsGnt3DwxFy4f+/2dwLs4N7mhsSb4rk/Xm3QybDSJGciI3d+aNDa
         sSPThwNT708SC9LBPKC+TvLGe3vj46XZ0hB6kSuBAbX8FFsTk8HTrUp10aLccZ+tDA
         jpqDNzAXJGasTO8+bEZN+zkc0iWuV5BFyYepSDzdA27SPTsaKL+sYAMB7JXTTNhZsE
         ZZuS+4zJdlhjvsTO6k6yDccd5SpIa4+/u1TfEOcwactJ8fOpkQx81IpucZNNA+lqE8
         1WdSkP0scP38fXQSD+T5s9Pksmg5fnDdKrSP198/jTHJg3p9AQ2H3uF+foOqlwntd4
         62DhPawivk73A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpMMF21S8z4wdC;
        Mon, 11 Dec 2023 11:00:24 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 11:00:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Randy Schacher <stuart.schacher@broadcom.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20231211110022.27926ad9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k9n=Atmk6W3UJwIqYeIs6e5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k9n=Atmk6W3UJwIqYeIs6e5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/broadcom/bnxt/bnxt.c

between commit:

  c13e268c0768 ("bnxt_en: Fix HWTSTAMP_FILTER_ALL packet timestamp logic")

from the net tree and commits:

  c2f8063309da ("bnxt_en: Refactor RX VLAN acceleration logic.")
  a7445d69809f ("bnxt_en: Add support for new RX and TPA_START completion t=
ypes for P7")
  1c7fd6ee2fe4 ("bnxt_en: Rename some macros for the P5 chips")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 579eebb6fc56,92a54113f872..000000000000
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@@ -1759,21 -1823,65 +1825,79 @@@ static void bnxt_deliver_skb(struct bnx
  	napi_gro_receive(&bnapi->napi, skb);
  }
 =20
 +static bool bnxt_rx_ts_valid(struct bnxt *bp, u32 flags,
 +			     struct rx_cmp_ext *rxcmp1, u32 *cmpl_ts)
 +{
 +	u32 ts =3D le32_to_cpu(rxcmp1->rx_cmp_timestamp);
 +
 +	if (BNXT_PTP_RX_TS_VALID(flags))
 +		goto ts_valid;
 +	if (!bp->ptp_all_rx_tstamp || !ts || !BNXT_ALL_RX_TS_VALID(flags))
 +		return false;
 +
 +ts_valid:
 +	*cmpl_ts =3D ts;
 +	return true;
 +}
 +
+ static struct sk_buff *bnxt_rx_vlan(struct sk_buff *skb, u8 cmp_type,
+ 				    struct rx_cmp *rxcmp,
+ 				    struct rx_cmp_ext *rxcmp1)
+ {
+ 	__be16 vlan_proto;
+ 	u16 vtag;
+=20
+ 	if (cmp_type =3D=3D CMP_TYPE_RX_L2_CMP) {
+ 		__le32 flags2 =3D rxcmp1->rx_cmp_flags2;
+ 		u32 meta_data;
+=20
+ 		if (!(flags2 & cpu_to_le32(RX_CMP_FLAGS2_META_FORMAT_VLAN)))
+ 			return skb;
+=20
+ 		meta_data =3D le32_to_cpu(rxcmp1->rx_cmp_meta_data);
+ 		vtag =3D meta_data & RX_CMP_FLAGS2_METADATA_TCI_MASK;
+ 		vlan_proto =3D htons(meta_data >> RX_CMP_FLAGS2_METADATA_TPID_SFT);
+ 		if (eth_type_vlan(vlan_proto))
+ 			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
+ 		else
+ 			goto vlan_err;
+ 	} else if (cmp_type =3D=3D CMP_TYPE_RX_L2_V3_CMP) {
+ 		if (RX_CMP_VLAN_VALID(rxcmp)) {
+ 			u32 tpid_sel =3D RX_CMP_VLAN_TPID_SEL(rxcmp);
+=20
+ 			if (tpid_sel =3D=3D RX_CMP_METADATA1_TPID_8021Q)
+ 				vlan_proto =3D htons(ETH_P_8021Q);
+ 			else if (tpid_sel =3D=3D RX_CMP_METADATA1_TPID_8021AD)
+ 				vlan_proto =3D htons(ETH_P_8021AD);
+ 			else
+ 				goto vlan_err;
+ 			vtag =3D RX_CMP_METADATA0_TCI(rxcmp1);
+ 			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
+ 		}
+ 	}
+ 	return skb;
+ vlan_err:
+ 	dev_kfree_skb(skb);
+ 	return NULL;
+ }
+=20
+ static enum pkt_hash_types bnxt_rss_ext_op(struct bnxt *bp,
+ 					   struct rx_cmp *rxcmp)
+ {
+ 	u8 ext_op;
+=20
+ 	ext_op =3D RX_CMP_V3_HASH_TYPE(bp, rxcmp);
+ 	switch (ext_op) {
+ 	case EXT_OP_INNER_4:
+ 	case EXT_OP_OUTER_4:
+ 	case EXT_OP_INNFL_3:
+ 	case EXT_OP_OUTFL_3:
+ 		return PKT_HASH_TYPE_L4;
+ 	default:
+ 		return PKT_HASH_TYPE_L3;
+ 	}
+ }
+=20
  /* returns the following:
   * 1       - 1 packet successfully received
   * 0       - successful TPA_START, packet not completed yet
@@@ -2022,8 -2131,10 +2148,8 @@@ static int bnxt_rx_pkt(struct bnxt *bp
  		}
  	}
 =20
 -	if (unlikely((flags & RX_CMP_FLAGS_ITYPES_MASK) =3D=3D
 -		     RX_CMP_FLAGS_ITYPE_PTP_W_TS) || bp->ptp_all_rx_tstamp) {
 +	if (bnxt_rx_ts_valid(bp, flags, rxcmp1, &cmpl_ts)) {
- 		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+ 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 -			u32 cmpl_ts =3D le32_to_cpu(rxcmp1->rx_cmp_timestamp);
  			u64 ns, ts;
 =20
  			if (!bnxt_get_rx_ts_p5(bp, &ts, cmpl_ts)) {

--Sig_/k9n=Atmk6W3UJwIqYeIs6e5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2URYACgkQAVBC80lX
0GzGxQf/QBEbLuULUlSJqBkroT+0Cb3KGPBo+LqRcRYDOzws7UCmEWvCOBRaKLs8
rgZAihg+Onmwft6GCYOyXRu85lGv8/yHjUWqy+jGHktnzcsXuyWfgpuF4xiofarV
z9uLwmbHLzNwadyZGJEkCtSMxEKzFMTRm/UUAeOBkupkT6k4O1GS9FhOVLq2GQfd
gbhhO9AKZvtO8bvqsqQzeLWhuHLsasrC6WlAqeJUiNPKV5cukEtMStSZsJ8y7ydT
PlLj+kKpoPpYr4zJTJ55e1CB9gXeNxtAv0qFoo+G27XHgBWlOBdy2mICB9DKohDT
T9crxmz/4ksqPCtE/Xi5GL6U1s2bWw==
=spIZ
-----END PGP SIGNATURE-----

--Sig_/k9n=Atmk6W3UJwIqYeIs6e5--

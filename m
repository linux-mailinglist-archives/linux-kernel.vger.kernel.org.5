Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B436777C48E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjHOAiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjHOAh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:37:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416C793;
        Mon, 14 Aug 2023 17:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692059872;
        bh=TLQVjY3kxE2Np30YiLY3zv14XDCrBIX0I1ZNA+WIP5w=;
        h=Date:From:To:Cc:Subject:From;
        b=rkzMLqtHuBx6OZizRyf68NlrUy9vyA4jGebOuctXuEcHJY7h+yQKjFqmyqzVKieGK
         pGvCGJQr/azZBlfSalTVDV6vGhKm8kBWKnuybUwd96gpliNdZHFDswtS8Dk+04jZOS
         sKK1ORiR036NU7RVT4dPwqMBlMT6YDn/f+XJgEs6UIUtWFC5bZB0U8kywR/ZSSQsI2
         1pcXsEdpRh71628FjBqQh6msP5U438Pxji+LXG56TodIXatsG9O8V2h8B5qCBXXzaQ
         S/EwQotBrIzLI64DtB8nEDwV4drN7o8IaM4LD7n8jjBb3xUG4L4MPPs1M4mkTHa06F
         vXgY/pu69oqcA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPsmv1Rmxz4wxQ;
        Tue, 15 Aug 2023 10:37:50 +1000 (AEST)
Date:   Tue, 15 Aug 2023 10:37:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: linux-next: manual merge of the scmi tree with the arm-soc tree
Message-ID: <20230815103750.18868b76@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BU.atDI/bh.fAiIJlX58WK9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BU.atDI/bh.fAiIJlX58WK9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scmi tree got a conflict in:

  drivers/firmware/arm_scmi/perf.c

between commit:

  31c7c1397a33 ("firmware: arm_scmi: Add v3.2 perf level indexing mode supp=
ort")

from the arm-soc tree and commit:

  3453de1ec6e4 ("firmware: arm_scmi: Fixup perf power-cost/microwatt suppor=
t")

from the scmi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/firmware/arm_scmi/perf.c
index c0cd556fbaae,b887d57aa446..000000000000
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@@ -1092,20 -833,13 +1094,18 @@@ static int scmi_perf_protocol_init(cons
  	for (domain =3D 0; domain < pinfo->num_domains; domain++) {
  		struct perf_dom_info *dom =3D pinfo->dom_info + domain;
 =20
 -		scmi_perf_domain_attributes_get(ph, domain, dom, version);
 -		scmi_perf_describe_levels_get(ph, domain, dom);
 +		dom->id =3D domain;
 +		scmi_perf_domain_attributes_get(ph, dom, version);
 +		scmi_perf_describe_levels_get(ph, dom, version);
 =20
  		if (dom->perf_fastchannels)
 -			scmi_perf_domain_init_fc(ph, domain, &dom->fc_info);
 +			scmi_perf_domain_init_fc(ph, dom->id, &dom->fc_info);
  	}
 =20
 +	ret =3D devm_add_action_or_reset(ph->dev, scmi_perf_xa_destroy, pinfo);
 +	if (ret)
 +		return ret;
 +
- 	pinfo->version =3D version;
-=20
  	return ph->set_priv(ph, pinfo);
  }
 =20

--Sig_/BU.atDI/bh.fAiIJlX58WK9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTayN4ACgkQAVBC80lX
0GyB3Af/bz5tOoFaw/i1eD5zkYGHEsh+wkWyQmnuk9lcP/y0B9vaXCoO9MIe+L6l
k9Dr8FV0Glu4ou/ozufHBbYSRSDfi+Pxs2V53W9kQpl2U73ZOEnINSYnB1wOJuFy
AQM8p0LHBpw9lo73XtvzZHFow+e2lu8KphimNet/wPLg0B5suzPSY3gYogSBkk1Y
AWISgB8y5MpbVpQhBlcP5AOWjlszRDsZ57MM3i8cwtv8DrK+7b6HsHARp01do5PL
cIRi96vp1xLZ1pC98RsQ7B0gt32yM6GAHoTIQCgQg7LFUAa/lZU1Li4Ayd8sESQO
wmgdpxpMYxgdfTl6aAQcj8H15Yvlyg==
=hpvU
-----END PGP SIGNATURE-----

--Sig_/BU.atDI/bh.fAiIJlX58WK9--

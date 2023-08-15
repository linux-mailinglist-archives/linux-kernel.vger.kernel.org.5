Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2604477C7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjHOGfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjHOGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:34:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03FD13E;
        Mon, 14 Aug 2023 23:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692081290;
        bh=zOsdhsWdpmUHHBTY+AKscWDMXaNRLsSBvK1Nf9BQFpg=;
        h=Date:From:To:Cc:Subject:From;
        b=UCt2KZdtyl8cCZwPZku3BTzitATbq0vmDbaO0UHyodR3OdtuUBkqPQ6dS5mdYHtmF
         mdOVKsQl42b3gGwAneMFS7U+puwuRYY/EG6UnfbsDfLdAj7XRnd2J1UEAvW51VELSa
         Ja/NX8NP9vRDq2OphmfFcpwE/S40tscL4tFp0aDfYMXIiALspbfrcxuW/a+8G0mA7W
         kRW4zFcXn/gz8MBe4iPVp3BdHDoYfYoJssRPyLqWhQ/fPqXSsKlYMX35QsT1HZymp8
         8ZMsmaD10UhBpUo0wgNEEf7HqzONFKWHKN7UULVbKtY6QdjHBx9BFemiZ14KVGiUeV
         6E17v6nATgq/A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ1hp0SC1z4wb8;
        Tue, 15 Aug 2023 16:34:50 +1000 (AEST)
Date:   Tue, 15 Aug 2023 16:34:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kvm-x86 tree with the kvm-riscv
 tree
Message-ID: <20230815163449.411914ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HIRzb6fS+X_EzwOaLMt+MZY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HIRzb6fS+X_EzwOaLMt+MZY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  tools/testing/selftests/kvm/include/test_util.h

between commit:

  dfaf20af7649 ("KVM: arm64: selftests: Replace str_with_index with strdup_=
printf")

from the kvm-riscv tree and commit:

  e5119382499c ("KVM: selftests: Add guest_snprintf() to KVM selftests")

from the kvm-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/kvm/include/test_util.h
index 7e0182f837b5,7a5907da1719..000000000000
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@@ -186,6 -185,7 +185,9 @@@ static inline uint32_t atoi_non_negativ
  	return num;
  }
 =20
 +char *strdup_printf(const char *fmt, ...) __attribute__((format(printf, 1=
, 2), nonnull(1)));
 +
+ int guest_vsnprintf(char *buf, int n, const char *fmt, va_list args);
+ int guest_snprintf(char *buf, int n, const char *fmt, ...);
+=20
  #endif /* SELFTEST_KVM_TEST_UTIL_H */

--Sig_/HIRzb6fS+X_EzwOaLMt+MZY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbHIkACgkQAVBC80lX
0GwbRwf+PsKP+Ljf4pYAtG4elV6mo55KPoLjfB90x6y6TrVJISwSM2251yUa7EAX
4G/2Wf2tNken8iqakL4Hg2XrchonTDRnC57VYGScnQSK0m4QhKxDCDHlYJOBpW5C
g0xgqw5LmoyyhWC3ILpPu8QOsGiyvG6v0Tol9pfCHMP+YmAtp/e/XDDTlYS3nbo1
HoU1t0BS4lzuqjmb1kN2lPM+zdJw3yccTgHPOX2rLj+x8z90WdHegBds613zY85C
7JVrLMbRoZ/BbX768uz0EwtePnS4oQMsH3KFVjh3jeehimhHR6qum0U9pt4AyS95
7WrxdWhc3ZQqZ2nHDn41kiz6Fb8agg==
=L2cl
-----END PGP SIGNATURE-----

--Sig_/HIRzb6fS+X_EzwOaLMt+MZY--

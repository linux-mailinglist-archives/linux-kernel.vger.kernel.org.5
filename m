Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570387DB222
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 03:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjJ3CsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 22:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3CsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 22:48:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5926BD;
        Sun, 29 Oct 2023 19:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698634088;
        bh=2WPF2meFlfmuU5Z/7Pvyd5wbBkWFy41KCxzeBwEo1tQ=;
        h=Date:From:To:Cc:Subject:From;
        b=KvTHyXDt+80+z/tTMTSfjcnv702x1HfYRbMx2blLRG6T+/7nvBtp9eQqEC7NSiDFO
         u4uZHG2hWK5hESMoR1CIIl9tc69mwQuL+kNi2IQtW+oJjl4rJj+BFPRJTlJ2IJFJW9
         rVMAw5mh2iwJ1Czpb7ck+YfyECPPnN9flZv5knGhxuAS2EElkxP6Sl3O5cYh/JySYk
         LY8LnGYNEIDS3tiY+QRmSkSkBE9dJITOBuxDFe0mcZYG1EchtJUozE0wvsd4+Hpumh
         hQ9jj3llfAwwZMX404T8c8392CXHF8AxvQpGUefEkVdVckbWuCsVSTuU8BKSycMjQ9
         ZebTPLF5CsMrA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJd474M69z4wd6;
        Mon, 30 Oct 2023 13:48:07 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 13:48:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kvm-x86 tree
Message-ID: <20231030134806.24510492@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=izap_lC71SbQQAr.14+Lg7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=izap_lC71SbQQAr.14+Lg7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvm-x86 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

arch/x86/kvm/../../../virt/kvm/guest_memfd.c: In function 'kvm_gmem_get_fil=
e':
arch/x86/kvm/../../../virt/kvm/guest_memfd.c:280:35: error: passing argumen=
t 1 of 'get_file_rcu' from incompatible pointer type [-Werror=3Dincompatibl=
e-pointer-types]
  280 |         if (file && !get_file_rcu(file))
      |                                   ^~~~
      |                                   |
      |                                   struct file *
In file included from include/linux/backing-dev.h:13,
                 from arch/x86/kvm/../../../virt/kvm/guest_memfd.c:2:
include/linux/fs.h:1046:47: note: expected 'struct file **' but argument is=
 of type 'struct file *'
 1046 | struct file *get_file_rcu(struct file __rcu **f);
      |                           ~~~~~~~~~~~~~~~~~~~~^

Caused by commit

  fcbef1e5e5d2 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific=
 backing memory")

interacting with commit

  0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")

from the vfs-brauner tree.

I have applied the following merg resolution patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 30 Oct 2023 13:35:38 +1100
Subject: [PATCH] fix up for "KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory"

interacting with "file: convert to SLAB_TYPESAFE_BY_RCU"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 virt/kvm/guest_memfd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 94bc478c26f3..7f62abe3df9e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -276,9 +276,7 @@ static struct file *kvm_gmem_get_file(struct kvm_memory=
_slot *slot)
=20
 	rcu_read_lock();
=20
-	file =3D rcu_dereference(slot->gmem.file);
-	if (file && !get_file_rcu(file))
-		file =3D NULL;
+	file =3D get_file_rcu(&slot->gmem.file);
=20
 	rcu_read_unlock();
=20
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/=izap_lC71SbQQAr.14+Lg7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU/GWYACgkQAVBC80lX
0Gx3+wf7BKet6jwuZD6OIeoGxca2iODMrjF0dwy5NByUMnIqpeSqPfLJYRqJSXwu
VXYfwS6uJrryq5YzYZ/PNcawmflIcP7o8wt803R1fm7l27MH33rkMCNzFFbYoZME
BVyrPcMSWZYh4ymW3jAbUGlLIBkZbOLbaEuTu6PYax458a8C2LxQyTRTWlxPlwCZ
lTtssW4pMMXVi9cF/61ysTcBsJaiVzQQ+or4B2iAQjRx9ERqDt9sZ08SwpvW7IXf
NIA5HIkQslLY8qGA0Y2o/v0OEUOvZOGXRXe2WB9Jxz5hUXdTvfmSWUksU9ImOEh1
OA1ooHgbubKcrPBKR4jfq4YPduA6qw==
=u7y9
-----END PGP SIGNATURE-----

--Sig_/=izap_lC71SbQQAr.14+Lg7--

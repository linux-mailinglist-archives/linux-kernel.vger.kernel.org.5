Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF87DB202
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 03:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjJ3CLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 22:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3CLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 22:11:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EDDC0;
        Sun, 29 Oct 2023 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698631891;
        bh=Zg+6p8Hbrzqr5Y/RcCEa316dOJl3zufMPpyqbOtROy0=;
        h=Date:From:To:Cc:Subject:From;
        b=C6E9XV7nKvHEnIRyv6AEXHkwjbhcDDrzpE6/baSGChIeXH7Y10N/5+1FHCdQw/8on
         jSb6yJn25wpDgbFTc0dPPHDveJm4nZKz52q+Wjz3n4N8kP5LWkFJwSvtCTWk660+qD
         uU2lGDud6sV+6EOzzk9gKgLMlfDkWV47tHvO9/H+lvoL4PkTqyzVPPMgeE2EJeoh58
         GP++lXgJ9UvV5wq0/F+bPhbZ6/mYq1svLC7Hr0sBQOYh2lS/gq6RPz4ty5AO00crqG
         eBF8b6ZYbgirP2wYrfQkUpMMBVht8ntLH2qeU85k2kmb1DyKis5a+nE8Va3rGgvMie
         lCM4xaJbO0fFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJcFr6Wsdz4wcX;
        Mon, 30 Oct 2023 13:11:28 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 13:11:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Jing Zhang <jingzhangos@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tianrui Zhao <zhaotianrui@loongson.cn>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
Subject: linux-next: manual merge of the kvm-x86 tree with the loongarch,
 kvm-arm trees
Message-ID: <20231030131127.214b979e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.rw+.h8Y8M7Hz.d/xLWaYKV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.rw+.h8Y8M7Hz.d/xLWaYKV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  include/uapi/linux/kvm.h

between commits:

  b37e6b680e3a ("LoongArch: KVM: Add kvm related header files")
  3f9cd0ca8484 ("KVM: arm64: Allow userspace to get the writable masks for =
feature ID registers")

from the loongarch, kvm-arm trees and commits:

  8e555bf388af ("KVM: Introduce KVM_SET_USER_MEMORY_REGION2")
  3291e34c9986 ("KVM: Add KVM_EXIT_MEMORY_FAULT exit to report faults to us=
erspace")
  e82df88abb18 ("KVM: Introduce per-page memory attributes")
  fcbef1e5e5d2 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific=
 backing memory")
  7e63404f9cd5 ("KVM: x86: Add support for "protected VMs" that can utilize=
 private memory")

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

diff --cc include/uapi/linux/kvm.h
index 211b86de35ac,5b5820d19e71..000000000000
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@@ -264,7 -278,7 +278,8 @@@ struct kvm_xen_exit=20
  #define KVM_EXIT_RISCV_SBI        35
  #define KVM_EXIT_RISCV_CSR        36
  #define KVM_EXIT_NOTIFY           37
 -#define KVM_EXIT_MEMORY_FAULT     38
 +#define KVM_EXIT_LOONGARCH_IOCSR  38
++#define KVM_EXIT_MEMORY_FAULT     39
 =20
  /* For KVM_EXIT_INTERNAL_ERROR */
  /* Emulate instruction failed. */
@@@ -1200,7 -1214,11 +1222,12 @@@ struct kvm_ppc_resize_hpt=20
  #define KVM_CAP_COUNTER_OFFSET 227
  #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
  #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
 -#define KVM_CAP_USER_MEMORY2 230
 -#define KVM_CAP_MEMORY_FAULT_INFO 231
 -#define KVM_CAP_MEMORY_ATTRIBUTES 232
 -#define KVM_CAP_GUEST_MEMFD 233
 -#define KVM_CAP_VM_TYPES 234
 +#define KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES 230
++#define KVM_CAP_USER_MEMORY2 231
++#define KVM_CAP_MEMORY_FAULT_INFO 232
++#define KVM_CAP_MEMORY_ATTRIBUTES 233
++#define KVM_CAP_GUEST_MEMFD 234
++#define KVM_CAP_VM_TYPES 235
 =20
  #ifdef KVM_CAP_IRQ_ROUTING
 =20

--Sig_/.rw+.h8Y8M7Hz.d/xLWaYKV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU/EM8ACgkQAVBC80lX
0GwSJQf/W+183M1qg4+V9CaLTEtyWLcwPisCXmEGYq5+nPIHldMocRcd7VD7Yc8y
+qXRNDbGIUlRlyIXGFiE+Q0LMlipRA6fB7jKYeSmVJG74H0MBvfxJz43eeggfVeh
KNciQW/b6/81xPBACqarNgcQxSUIOuJ2y1YcbDQFHL6i3HH+qn8budmMW94t3Few
skKF2H1mjOI7BCJHH4pDffusR+39ArsIQgqjTrC6turYV0SX+WnXmEkavC96Zw4U
eLVM6wixiwUhnVA85J1cEpwFTa4g4pGIEa1lGhs/9Yf2pX1RALj0p8NpYoFngL1+
RTq7oQUP83V0bCClQsp/Lobm4t2JWw==
=WIHv
-----END PGP SIGNATURE-----

--Sig_/.rw+.h8Y8M7Hz.d/xLWaYKV--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9637783682
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjHUXzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjHUXzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:55:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18513E;
        Mon, 21 Aug 2023 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692662139;
        bh=D7cysqJUdxEabQucfhKj8eQuyrVbcsTOyOAjVa1RXzA=;
        h=Date:From:To:Cc:Subject:From;
        b=LH5JPbNM0vOi7aMV3ND0unkuIsYzJaiux8V3b90uwn+rGDKQ9tlrtLHKdKhxMa1N9
         yD54ak7ZgUVk62xdijXgxJBle3q0AI6IxCFrKEC8e5XRjKiL1xheo8NFY82vHUzVgQ
         XzTIMVZljKExRn/QbZqJTk/Hgp0IjoC+2RBZMJB5FTRMITPAl4aMADWCi5Gjj06T9K
         rmA4wQyB3JNXDeqE8zKNIEWLo/N6VFF8usXHqgCKPKGK4t5nTOa6fjz2crI6h/8M+C
         EAf1QtmjRTJb9COTrbkP+Ds1fT05hzjhgrIR4rqvgidjT6Cmyj875hDYbrzNVzErsQ
         rN2QV+rULv9jw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RV8Vy6wqbz4wZJ;
        Tue, 22 Aug 2023 09:55:38 +1000 (AEST)
Date:   Tue, 22 Aug 2023 09:55:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230822095537.500047f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2z+KtNqgbzpgh41lXutc3lf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2z+KtNqgbzpgh41lXutc3lf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build
(powerpc_ppc64_defconfig) failed like this:

In file included from include/trace/trace_events.h:27,
                 from include/trace/define_trace.h:102,
                 from fs/xfs/xfs_trace.h:4428,
                 from fs/xfs/xfs_trace.c:45:
include/linux/pgtable.h:8:25: error: initializer element is not constant
    8 | #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)
      |                         ^
include/trace/stages/init.h:20:31: note: in definition of macro 'TRACE_DEFI=
NE_ENUM'
   20 |                 .eval_value =3D a                         \
      |                               ^
fs/xfs/./xfs_trace.h:805:19: note: in expansion of macro 'PMD_ORDER'
  805 | TRACE_DEFINE_ENUM(PMD_ORDER);
      |                   ^~~~~~~~~
include/linux/pgtable.h:8:25: note: (near initialization for '__TRACE_SYSTE=
M_PMD_ORDER.eval_value')
    8 | #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)
      |                         ^
include/trace/stages/init.h:20:31: note: in definition of macro 'TRACE_DEFI=
NE_ENUM'
   20 |                 .eval_value =3D a                         \
      |                               ^
fs/xfs/./xfs_trace.h:805:19: note: in expansion of macro 'PMD_ORDER'
  805 | TRACE_DEFINE_ENUM(PMD_ORDER);
      |                   ^~~~~~~~~
include/linux/pgtable.h:9:25: error: initializer element is not constant
    9 | #define PUD_ORDER       (PUD_SHIFT - PAGE_SHIFT)
      |                         ^
include/trace/stages/init.h:20:31: note: in definition of macro 'TRACE_DEFI=
NE_ENUM'
   20 |                 .eval_value =3D a                         \
      |                               ^
fs/xfs/./xfs_trace.h:806:19: note: in expansion of macro 'PUD_ORDER'
  806 | TRACE_DEFINE_ENUM(PUD_ORDER);
      |                   ^~~~~~~~~
include/linux/pgtable.h:9:25: note: (near initialization for '__TRACE_SYSTE=
M_PUD_ORDER.eval_value')
    9 | #define PUD_ORDER       (PUD_SHIFT - PAGE_SHIFT)
      |                         ^
include/trace/stages/init.h:20:31: note: in definition of macro 'TRACE_DEFI=
NE_ENUM'
   20 |                 .eval_value =3D a                         \
      |                               ^
fs/xfs/./xfs_trace.h:806:19: note: in expansion of macro 'PUD_ORDER'
  806 | TRACE_DEFINE_ENUM(PUD_ORDER);
      |                   ^~~~~~~~~
fs/xfs/./xfs_trace.h: In function 'trace_raw_output_xfs_filemap_fault':
include/linux/pgtable.h:8:25: error: initializer element is not constant
    8 | #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)
      |                         ^
include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_=
EVENT_CLASS'
  203 |         trace_event_printf(iter, print);                           =
     \
      |                                  ^~~~~
include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
   45 |                              PARAMS(print));                   \
      |                              ^~~~~~
fs/xfs/./xfs_trace.h:811:1: note: in expansion of macro 'TRACE_EVENT'
  811 | TRACE_EVENT(xfs_filemap_fault,
      | ^~~~~~~~~~~
fs/xfs/./xfs_trace.h:826:9: note: in expansion of macro 'TP_printk'
  826 |         TP_printk("dev %d:%d ino 0x%llx %s write_fault %d",
      |         ^~~~~~~~~
fs/xfs/./xfs_trace.h:829:19: note: in expansion of macro '__print_symbolic'
  829 |                   __print_symbolic(__entry->order,
      |                   ^~~~~~~~~~~~~~~~
fs/xfs/./xfs_trace.h:831:27: note: in expansion of macro 'PMD_ORDER'
  831 |                         { PMD_ORDER,    "PMD" },
      |                           ^~~~~~~~~
include/linux/pgtable.h:8:25: note: (near initialization for 'symbols[1].ma=
sk')
    8 | #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)
      |                         ^
include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_=
EVENT_CLASS'
  203 |         trace_event_printf(iter, print);                           =
     \
      |                                  ^~~~~
include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
   45 |                              PARAMS(print));                   \
      |                              ^~~~~~
fs/xfs/./xfs_trace.h:811:1: note: in expansion of macro 'TRACE_EVENT'
  811 | TRACE_EVENT(xfs_filemap_fault,
      | ^~~~~~~~~~~
fs/xfs/./xfs_trace.h:826:9: note: in expansion of macro 'TP_printk'
  826 |         TP_printk("dev %d:%d ino 0x%llx %s write_fault %d",
      |         ^~~~~~~~~
fs/xfs/./xfs_trace.h:829:19: note: in expansion of macro '__print_symbolic'
  829 |                   __print_symbolic(__entry->order,
      |                   ^~~~~~~~~~~~~~~~
fs/xfs/./xfs_trace.h:831:27: note: in expansion of macro 'PMD_ORDER'
  831 |                         { PMD_ORDER,    "PMD" },
      |                           ^~~~~~~~~
include/linux/pgtable.h:9:25: error: initializer element is not constant
    9 | #define PUD_ORDER       (PUD_SHIFT - PAGE_SHIFT)
      |                         ^
include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_=
EVENT_CLASS'
  203 |         trace_event_printf(iter, print);                           =
     \
      |                                  ^~~~~
include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
   45 |                              PARAMS(print));                   \
      |                              ^~~~~~
fs/xfs/./xfs_trace.h:811:1: note: in expansion of macro 'TRACE_EVENT'
  811 | TRACE_EVENT(xfs_filemap_fault,
      | ^~~~~~~~~~~
fs/xfs/./xfs_trace.h:826:9: note: in expansion of macro 'TP_printk'
  826 |         TP_printk("dev %d:%d ino 0x%llx %s write_fault %d",
      |         ^~~~~~~~~
fs/xfs/./xfs_trace.h:829:19: note: in expansion of macro '__print_symbolic'
  829 |                   __print_symbolic(__entry->order,
      |                   ^~~~~~~~~~~~~~~~
fs/xfs/./xfs_trace.h:832:27: note: in expansion of macro 'PUD_ORDER'
  832 |                         { PUD_ORDER,    "PUD" }),
      |                           ^~~~~~~~~
include/linux/pgtable.h:9:25: note: (near initialization for 'symbols[2].ma=
sk')
    9 | #define PUD_ORDER       (PUD_SHIFT - PAGE_SHIFT)
      |                         ^
include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_=
EVENT_CLASS'
  203 |         trace_event_printf(iter, print);                           =
     \
      |                                  ^~~~~
include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
   45 |                              PARAMS(print));                   \
      |                              ^~~~~~
fs/xfs/./xfs_trace.h:811:1: note: in expansion of macro 'TRACE_EVENT'
  811 | TRACE_EVENT(xfs_filemap_fault,
      | ^~~~~~~~~~~
fs/xfs/./xfs_trace.h:826:9: note: in expansion of macro 'TP_printk'
  826 |         TP_printk("dev %d:%d ino 0x%llx %s write_fault %d",
      |         ^~~~~~~~~
fs/xfs/./xfs_trace.h:829:19: note: in expansion of macro '__print_symbolic'
  829 |                   __print_symbolic(__entry->order,
      |                   ^~~~~~~~~~~~~~~~
fs/xfs/./xfs_trace.h:832:27: note: in expansion of macro 'PUD_ORDER'
  832 |                         { PUD_ORDER,    "PUD" }),
      |                           ^~~~~~~~~

Caused by commit

  b8088235e872 ("mm: remove enum page_entry_size")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/2z+KtNqgbzpgh41lXutc3lf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTj+XkACgkQAVBC80lX
0Gyh9wf8DjilA0C679EsCsfhZ8WsE4hVWHAFICAwAv4A44FVnnmO+JHJ6G7FqOBM
LsP7Uu0kCE32XgHCQe4Xr1HBeGI+k6lAE0KKo13wlDrG2pewyZ3NXrVHfQ9Y5Q+I
OpEPvJ+CeEGnXJ50F4L8fp720vMK7Bf0GcICE4Hljj66o7ykf3sBlwEV0FlZ6vYz
/7ta2PmhTtISTJoSmIKqxS/YrImYn1OV57mSJx5jwCBo96pFX4h92e50mLYZxswz
gPGjcU0DJJh5ouZGejD4w/Oe/qWrtj+tTekxYCxJOF4g77H7DFTwBlvQr7aiojoL
jaEh1/TK48GRNXjnLkEUNbLX54CV4A==
=xSfW
-----END PGP SIGNATURE-----

--Sig_/2z+KtNqgbzpgh41lXutc3lf--

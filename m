Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75592800AA7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378793AbjLAMQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378775AbjLAMQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:16:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38E0D4A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701433016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3wADyBhF6SxYwwEhu+UTNIQaMrv6w6ZPgb5PhCFPVck=;
        b=jCSuwBuW4v02RRmCwx9W+BmeDXhh48zMGpoAN9CHMRXjZHkzbZAi770cboM7HbsB0esMHz
        y80Y+k15tiX1axGjF9ZRxoZwmAzNQQIPAkMRvz+svpbUK7JpvSoEVRbnYQr1kBAv0ZC1TQ
        ogYcUzEfWz0tnV6D9z54d55lIlCMkXk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-BEOKfIs3MdGIRbXd6BGwzw-1; Fri, 01 Dec 2023 07:16:49 -0500
X-MC-Unique: BEOKfIs3MdGIRbXd6BGwzw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4239f7f5304so5630601cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 04:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701433009; x=1702037809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wADyBhF6SxYwwEhu+UTNIQaMrv6w6ZPgb5PhCFPVck=;
        b=QmR9ZYe6tNX3q6waSqYZfDjxK5qsidR2pvawtALTznqXHgw9QVaUPesBxKFCBGiUrp
         WVEm9WG1idfxdYXLCYQeK89MzOVBoL3ApJkkHJSYVPQ7tUw02nSz9rG3RF/lU2lRk0bK
         zbXnxjbxd5fHyVwhY8/Uq62PR+mT2HbLT0fTwwVUICChcIEfiwX4UlMApzahXFPQIxQC
         hxOUJFSECrspAzaBLhBqsMo5vablj4Q3Gn0iCkyntY4t/NT0TTzA4o4WxVqEYT8UuIbt
         jk26WPfze6zVoIF1Afz6U0KgmUClw1aiAJdixPLpxhzZHsBrlIJVHjGr56o7Q2RglsR3
         Ey8Q==
X-Gm-Message-State: AOJu0YwoOWCF98qDVxaLCyG6YnPSIfP4Pmn/PKUzSO3F2hn6DgyH/osj
        NmGcA/+yRX7+R0CdvDvDkAnR58dcHV3XIbfYVkEb98qQBkz34goG8pK8GULHZcg36pIejOuOXa6
        BCsTrvM10pW49u+fLk5tkgWKY
X-Received: by 2002:a05:622a:1b20:b0:412:d46:a8c3 with SMTP id bb32-20020a05622a1b2000b004120d46a8c3mr5061418qtb.2.1701433009402;
        Fri, 01 Dec 2023 04:16:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOKUh0bJnTYVDuGGaIa2Q5dJ6Vl5QIVqa19paRlwTxGBPUzEBUaTntRc/BHYswfkbUeCaqKQ==
X-Received: by 2002:a05:622a:1b20:b0:412:d46:a8c3 with SMTP id bb32-20020a05622a1b2000b004120d46a8c3mr5061386qtb.2.1701433009048;
        Fri, 01 Dec 2023 04:16:49 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id b19-20020ac87553000000b00423b8a53641sm1426528qtr.29.2023.12.01.04.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:16:48 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        NeilBrown <neilb@suse.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Philipp Stanner <pstanner@redhat.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 0/4] Regather scattered PCI-Code
Date:   Fri,  1 Dec 2023 13:16:18 +0100
Message-ID: <20231201121622.16343-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sooooooooo. I reworked v1.

Please review this carefully, the IO-Ranges are obviously a bit tricky,
as is the build-system / ifdef-ery.

Arnd has suggested that architectures defining a custom inb() need their
own iomem_is_ioport(), as well. I've grepped for inb() and found the
following list of archs that define their own:
  - alpha
  - arm
  - m68k <--
  - parisc
  - powerpc
  - sh
  - sparc
  - x86 <--

All of those have their own definitons of pci_iounmap(). Therefore, they
don't need our generic version in the first place and, thus, also need
no iomem_is_ioport().
The two exceptions are x86 and m68k. The former uses lib/iomap.c through
CONFIG_GENERIC_IOMAP, as Arnd pointed out in the previous discussion
(thus, CONFIG_GENERIC_IOMAP is not really generic in this regard).

So as I see it, only m68k WOULD need its own custom definition of
iomem_is_ioport(). But as I understand it it doesn't because it uses the
one from asm-generic/pci_iomap.h ??

I wasn't entirely sure how to deal with the address ranges for the
generic implementation in asm-generic/io.h. It's marked with a TODO.
Input appreciated.

I removed the guard around define pci_iounmap in asm-generic/io.h. An
alternative would be to have it be guarded by CONFIG_GENERIC_IOMAP and
CONFIG_GENERIC_PCI_IOMAP, both. Without such a guard, there is no
collision however, because generic pci_iounmap() from
drivers/pci/iomap.c will only get pulled in when
CONFIG_GENERIC_PCI_IOMAP is actually set.

I cross-built this for a variety of architectures, including the usual
suspects (s390, m68k). So far successfully. But let's see what Intel's
robots say :O

P.

Changes in v2:
- Replace patch 4, previously extending the comment about pci_iounmap()
  in lib/iomap.c, with a patch that moves pci_iounmap() from that file
  to drivers/pci/iomap.c, creating a unified version there. (Arnd)
- Implement iomem_is_ioport() as a new helper in asm-generic/io.h and
  lib/iomap.c. (Arnd)
- Move the build rule in drivers/pci/Makefile for iomap.o under the
  guard of #if PCI. This had to be done because when just checking for
  GENERIC_PCI_IOMAP being defined, the functions don't disappear, which
  was the case previously in lib/pci_iomap.c, where the entire file was
  made empty if PCI was not set by the guard #ifdef PCI. (Intel's Bots)
- Rephares all patches' commit messages a little bit.


Original cover letter:

Hi!

So it seems that since ca. 2007 the PCI code has been scattered a bit.
PCI's devres code, which is only ever used by users of the entire
PCI-subsystem anyways, resides in lib/devres.c and is guarded by an
ifdef PCI, just as the content of lib/pci_iomap.c is.

It, thus, seems reasonable to move all of that.

As I were at it, I moved as much of the devres-specific code from pci.c
to devres.c, too. The only exceptions are four functions that are
currently difficult to move. More information about that can be read
here [1].

I noticed these scattered files while working on (new) PCI-specific
devres functions. If we can get this here merged, I'll soon send another
patch series that addresses some API-inconsistencies and could move the
devres-part of the four remaining functions.

I don't want to do that in this series as this here is only about moving
code, whereas the next series would have to actually change API
behavior.

I successfully (cross-)built this for x86, x86_64, AARCH64 and ARM
(allyesconfig). I booted a kernel with it on x86_64, with a Fedora
desktop environment as payload. The OS came up fine

I hope this is OK. If we can get it in, we'd soon have a very
consistent PCI API again.

Regards,
P.


Philipp Stanner (4):
  lib: move pci_iomap.c to drivers/pci/
  lib: move pci-specific devres code to drivers/pci/
  pci: move devres code from pci.c to devres.c
  lib, pci: unify generic pci_iounmap()

 drivers/pci/Kconfig                    |   5 +
 drivers/pci/Makefile                   |   3 +-
 drivers/pci/devres.c                   | 450 +++++++++++++++++++++++++
 lib/pci_iomap.c => drivers/pci/iomap.c |  43 +--
 drivers/pci/pci.c                      | 249 --------------
 drivers/pci/pci.h                      |  24 ++
 include/asm-generic/io.h               |  37 +-
 lib/Kconfig                            |   3 -
 lib/Makefile                           |   1 -
 lib/devres.c                           | 208 +-----------
 lib/iomap.c                            |  16 +-
 11 files changed, 536 insertions(+), 503 deletions(-)
 create mode 100644 drivers/pci/devres.c
 rename lib/pci_iomap.c => drivers/pci/iomap.c (75%)

-- 
2.43.0


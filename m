Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6366C801C59
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 12:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjLBLOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 06:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBLOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 06:14:38 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C9818C;
        Sat,  2 Dec 2023 03:14:44 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9d44b2919so23531431fa.0;
        Sat, 02 Dec 2023 03:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701515682; x=1702120482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=561K0BGyTpooesF2vZY7Mwtnl+lVJGMkg+53gB719DA=;
        b=FaUFa9erQ7Ict85AIxpET66VyIydaW/JREiX/mJWAGUw8VU0wDYCN2l7L0RQDZ9KPY
         bG7YhIHrelmkgG4c2BXTOf0VCFb1ou9gGkuloecbuZHz6dfkFrsd3ABXzsUizFtjguir
         jQm2v+IcKyN68aEGLt104v+kyuNeGANJMSgiIIBDaYLAgeLxj+LSuK/6TYNJGRmlFT6Q
         dkfvwwSNY9++kjqtsykHOQ+Q2Wb3fcds7+bClxis9q4DK2yQI9Hu1040aNyzCmLuwViC
         bTUhL0AxLaHQyTqotDKr4D9aX1Zrg8ANG4lbvUtb0kCQJbQrVYssOZWiJRnnz7LyFRpy
         ur4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701515682; x=1702120482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=561K0BGyTpooesF2vZY7Mwtnl+lVJGMkg+53gB719DA=;
        b=MR9a5Dimov7qKviCaJsSkyEg8P3AvSu7UdTWdscS3leoCsAjmTaHmALyvDVddIPTXT
         YKrMLxLgsBGkGEykTGddJMH2uTpbMjcqBtJuFmtbRp9MDGcrPnlaf7+cw0KniX5wg/EB
         Pq1O6SRpa1PcctYh/vDO+pklVSrNdJlMuJimrQH/1zT0C6QZQa+t4WFq3/db074zjd/h
         pUAkahYSeY5kjqQyWn97FSqtvsfwgqktvetPQTdv/Jsakh+T6btxjm72Z46X9WQ2TAL0
         IvaioUhdebjN+4/ipKEdMF/g7x2woEbCAbAfKbA7Zybeu0HwXPb8w+n8vH9zeP91P6p9
         0O8g==
X-Gm-Message-State: AOJu0YyaFaMYL7/OGtzHfDehvx5iZgMupITViDXJNp0xZuusKxakVMcs
        W5ayvE/NA8YctmTkrUESZ1o=
X-Google-Smtp-Source: AGHT+IFtuPcs03pVDSegSsFJqR+qgrSu6Yoe7feFmO2GJ9vLYffSE/RHhkzKJ7/saKHyb7BYEvMagA==
X-Received: by 2002:a2e:2414:0:b0:2c9:f4af:fb9c with SMTP id k20-20020a2e2414000000b002c9f4affb9cmr238456ljk.22.1701515682230;
        Sat, 02 Dec 2023 03:14:42 -0800 (PST)
Received: from localhost ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id i7-20020a2ea367000000b002c72bc28b3bsm700722ljn.52.2023.12.02.03.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 03:14:41 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Baoquan He <bhe@redhat.com>, Chao-ying Fu <cfu@wavecomp.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] MIPS: mm: Fix some memory-related issues
Date:   Sat,  2 Dec 2023 14:14:17 +0300
Message-ID: <20231202111430.18059-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just recently I've rebased my MIPS32-related work from kernel 6.5-rc4 onto
the latest kernel 6.7-rc1 and immediately got into a bootup-time
mm-related bug (see patches 3-4 in this series). After fixing it I decided
it was time to submit for review the generic MIPS code fixes which I have
been collecting in my local repo for the last year. I was going to submit
them a bit later after I finished working on a patchset with my SoC
arch-specific changes, but since it was getting bigger and bigger, it
turned to be reasonable to spill out the generic part of series right away
especially seeing it might get to be useful in the most recent kernel.

So this series starts with the MIPS-specific dmi_early_remap()
implementation fix. It is utilized by the DMI driver in the framework of
the dmi_setup() method, which is called at the very early boot stage - in
setup_arch((). No VM and slab available at that stage which is required
for the ioremap_cache() to properly work. Thus it was a mistake to have
the dmi_early_remap() macro-function defined as ioremap_cache(). It should
have been ioremap() in first place.

After that goes a fix for the high-memory zone PFNs calculation procedure
on MIPS. It turned out that after some not that recent commit the
IO-memory or just non-memory PFNs got to the high-memory even though they
were directly reachable, thus should have been left in the normal zone.

Then a series of fixes for the recently discovered mm-bug is presented.
Any attempt to re-map the IO-memory with the cached attribute caused the
bootup procedure to crash with the "Unhandled kernel unaligned access"
message. After some digging I found out that the problem was in the
uninitialized IO-memory pages. Please see the patch "mips: Fix max_mapnr
being uninitialized on early stages" description for the detailed
explanation of the problem and suggested fix.

After that goes a patch which adds the slab availability check into the
ioremap_prot() method. Indeed VM mapping performs the slab allocation in
the framework of the get_vm_area() method. Thus any other than uncached
IO-remappings must be proceeded only at the stages when slab is available.
A similar fix was just recently added to the generic version of
ioremap_prot() in the framework of commit a5f616483110 ("mm/ioremap: add
slab availability checking in ioremap_prot").

The patchset is closed with a small improvement which sets the MIPS
board/machine name to the dump-stack module in order to print
arch-personalized oopses in the same way as it's done on ARM, ARM64,
RISC-V, etc.

That's it for today.) Thanks for review in advance. Any tests are very
welcome.

Link: https://lore.kernel.org/linux-mips/20231122182419.30633-1-fancer.lancer@gmail.com/
Changelog v2:
- Drop the patches:
  [PATCH 5/7] mm/mm_init.c: Extend init unavailable range doc info
  [PATCH 6/7] mm/mm_init.c: Append '\n' to the unavailable ranges log-message
  since they have been picked up by Andrew. (@Andrew)
- Replace ioremap_uc() with using ioremap() due to having the former one
  deprecated. (@Arnd)
- Add a new patch:
  [PATCH v2 5/6] mips: mm: add slab availability checking in ioremap_prot
  picked up from the generic ioremap_prot() implementation.
- Extend early DMI mem remapping patch log with a note regarding the unsynched
  caches concern. (@Jiaxun)

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: Aleksandar Rikalo <arikalo@gmail.com>
Cc: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao-ying Fu <cfu@wavecomp.com>
Cc: Yinglu Yang <yangyinglu@loongson.cn>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (6):
  mips: dmi: Fix early remap on MIPS32
  mips: Fix incorrect max_low_pfn adjustment
  mips: Fix max_mapnr being uninitialized on early stages
  mips: Optimize max_mapnr init procedure
  mips: mm: add slab availability checking in ioremap_prot
  mips: Set dump-stack arch description

 arch/mips/include/asm/dmi.h |  2 +-
 arch/mips/kernel/prom.c     |  2 ++
 arch/mips/kernel/setup.c    |  4 ++--
 arch/mips/mm/init.c         | 16 +++++++++-------
 arch/mips/mm/ioremap.c      |  4 ++++
 5 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.42.1


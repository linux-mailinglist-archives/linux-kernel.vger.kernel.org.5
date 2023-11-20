Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F347F1FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjKTWAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjKTWAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D071DCB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700517604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oA/MReMENGME90F/W03bez9d20d3Hm8W5WtwK1MjIOQ=;
        b=OIbDiAeFoXWBJkiTT4Z79jm/2Py2kz71imxvsO5nOQsNC+HTihRSX21/auiAysLuokG0zJ
        omkIwE5RTqOwGIIIGCHVhjA/invm7juATERoju3CLS/U1zDpy4F+GDnYzplk1RNRVvGdVZ
        xHbX+ax1d24KjX+dynZ+FIyQ3YQZkyw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-_JxfJc6CNn6V2zrSTvJWCA-1; Mon, 20 Nov 2023 17:00:02 -0500
X-MC-Unique: _JxfJc6CNn6V2zrSTvJWCA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6755f01ca7dso13029386d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700517602; x=1701122402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oA/MReMENGME90F/W03bez9d20d3Hm8W5WtwK1MjIOQ=;
        b=Dx+3pBQy8Zc37+BZQ7etHijFW8WuC1kguzijTY/RLHRk13AMpiBGH/aCl7zJQcKZkd
         9jlQlV/rur1My5k1dkz9vN6eaPctjOZhvYrrsHxL7Uk0Rep6hzQWwyLGC62Bynh1DAqx
         etntRs8hgLkNBKC3VW32mjuim16AnIPsfH2DXGy1JNe0DLgm/4Cxe81jsEYn989L4l3u
         G2Kyqxtfb9evZBts6QTOB0fwuqbvjA0kWEd+YTWcDhXEbnGG0usGZxHOloK0BFqaQCRM
         ctrJeYdL+k/OCXhWmbhKm+1AKW0Ey82WWNaqikK1JVwdPblnwefjo9DeR66HuZ7ZJnDv
         yLdA==
X-Gm-Message-State: AOJu0Ywk8KwF+f9Mhi0vJKwfCz94QSmSyRjK9ebjMTn1qNOpTEFolRm3
        XOLEr/THdHhkG1SNVErURLk2sisppA6KJuYNsqCaRdzZmJOG52Of7gsE2/pe0YuMUkDLOU1KR/Z
        T+Q88iawL37sXx1Bof+dH16v/
X-Received: by 2002:a05:6214:76a:b0:679:d92e:3915 with SMTP id f10-20020a056214076a00b00679d92e3915mr4464233qvz.6.1700517602285;
        Mon, 20 Nov 2023 14:00:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2cPaXvk02xjS9PSNBCsY1AIobgVcOVGaCj4dyFYAj777vhrd+5qp4n0siM1HRkrv0dpUL4Q==
X-Received: by 2002:a05:6214:76a:b0:679:d92e:3915 with SMTP id f10-20020a056214076a00b00679d92e3915mr4464214qvz.6.1700517602018;
        Mon, 20 Nov 2023 14:00:02 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32dd:2700:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id 3-20020ad45ba3000000b00677fb918337sm2762398qvq.53.2023.11.20.13.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:00:01 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Auger <eric.auger@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        NeilBrown <neilb@suse.de>, Philipp Stanner <pstanner@redhat.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/4] Regather scattered PCI-Code
Date:   Mon, 20 Nov 2023 22:59:42 +0100
Message-ID: <20231120215945.52027-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

So it seems that since ca. 2007 the PCI code has been scattered a bit.
PCI's devres code, which is only ever used by users of the entire
PCI-subsystem anyways, resides in lib/devres.c and is guarded by an
#ifdef PCI, just as the content of lib/pci_iomap.c is.

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

[1] https://lore.kernel.org/all/84be1049e41283cf8a110267646320af9ffe59fe.camel@redhat.com/


Philipp Stanner (4):
  lib: move pci_iomap.c to drivers/pci/
  lib: move pci-specific devres code to drivers/pci/
  pci: move devres code from pci.c to devres.c
  lib/iomap.c: improve comment about pci anomaly

 drivers/pci/Kconfig                    |   3 +
 drivers/pci/Makefile                   |   3 +-
 drivers/pci/devres.c                   | 449 +++++++++++++++++++++++++
 lib/pci_iomap.c => drivers/pci/iomap.c |   3 -
 drivers/pci/pci.c                      | 249 --------------
 drivers/pci/pci.h                      |  24 ++
 lib/Kconfig                            |   3 -
 lib/Makefile                           |   1 -
 lib/devres.c                           | 208 +-----------
 lib/iomap.c                            |  13 +-
 10 files changed, 490 insertions(+), 466 deletions(-)
 create mode 100644 drivers/pci/devres.c
 rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)

-- 
2.41.0


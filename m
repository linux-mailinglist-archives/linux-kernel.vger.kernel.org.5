Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430A5811232
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378945AbjLMM77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjLMM75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:59:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7392D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702472399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wFCv+0tZaZnz6YeZzK8hxOwjz0J3Dsh5vJIVe/dhdnE=;
        b=L5rvBkq7WhtTSAr5d60UpyQkuONVIJszllE9YfmiaablMmK19b5Of86TWIgU+CBxQQVrE0
        iU769KPoCmTn9+BWqI3OP83FfRYe6lyvJIMrAN8wGULRwSc0x+VN5xW5Xn6fOochAoayWx
        h/idZuqlyQMGsCasW7MA5WfSNyUzzHM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-WZIFZUgBOQSZYC2uqgNcAg-1; Wed, 13 Dec 2023 07:59:57 -0500
X-MC-Unique: WZIFZUgBOQSZYC2uqgNcAg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c26711881so13097995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472396; x=1703077196;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFCv+0tZaZnz6YeZzK8hxOwjz0J3Dsh5vJIVe/dhdnE=;
        b=TzrZkZRfsO20zn/VFa9ORl511d0oZJY69svGYH7pdBb6zTpVelR8Zk/ABdnRQJDYME
         CCaVQd/y48NkFqt73La05j3xYF3lbWfyowQMk+5Bpd5Gv7zHlHL9pWDZv3OtqeU+lZM9
         0X+/Bfil6ShiQ/UQiBVQRrPbE1HGFyrC24xYn/HUIsKyfhZTjciiPh3DM+glXK4fO0Zs
         CXf2ClnYIulechXX1ddMjzZqAy7C3J+RrbvFV536S4B5Gxbnpq99P0R9p2f40vl6PNFS
         8t35TT/Xl/i3AOTPogC6jk2wrc7KCX7MBK6o1tRUtEt/zIeIQCqS/o81uBciNnRUy3q3
         JhlA==
X-Gm-Message-State: AOJu0YxQ/YJQfSK/tFVRb0BgkoYt7jO4QkarES7LKJzTOOwpnoRc8VwI
        vBTNWBEQj1JLrwAiLQGtpdntmM77oeITahbX8t3BPozL/L49UxXn33Q5/ueg+p5bMgJh/xl86YK
        oSCfKGWQF+9IzFIgk9FHxT0JC
X-Received: by 2002:a05:600c:511a:b0:40b:516a:3856 with SMTP id o26-20020a05600c511a00b0040b516a3856mr9749094wms.1.1702472396622;
        Wed, 13 Dec 2023 04:59:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwXql9nJbq7x4v2uy9r9nzvBcsRQ6cZzXgBsR4vsn2vk2qU4KbpFlHbt/UWL+c1VfSst1fYA==
X-Received: by 2002:a05:600c:511a:b0:40b:516a:3856 with SMTP id o26-20020a05600c511a00b0040b516a3856mr9749062wms.1.1702472396246;
        Wed, 13 Dec 2023 04:59:56 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b0033609584b9dsm13081881wrq.74.2023.12.13.04.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:59:55 -0800 (PST)
Message-ID: <74219796e91675c533daea6a2a6afc6d06fb7461.camel@redhat.com>
Subject: Further cleanups for pci_iounmap() and lib/iomap.c discussion
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        NeilBrown <neilb@suse.de>, John Sanpe <sanpeqf@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Yury Norov <yury.norov@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org
Date:   Wed, 13 Dec 2023 13:59:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hola,

This is a discussion about whether we want to move lib/iomap.c and
remove the remaining pci_io(un)map() definition of s390.

That would be followup work on our pci_iounmap() cleanup [1] that was
discussed here [2] (but is not yet merged).


The summary from the last discussions was:
 * GENERIC_IOMAP is not generic anymore, but x86-specific
 * All (?) archs should be able to use generic pci_iounmap()


I've been looking into GENERIC_IOMAP a bit and am unsure whether that's
true. Notably, powerpc seems to do something with it; see
platforms/Kconfig:

config PPC_INDIRECT_PIO
bool
select GENERIC_IOMAP


I've had a few ideas, but don't really want to pursue them until we had
a discussion about it:
   1. If GENERIC_IOMAP is really x86-specific, that should mean that we
      could move lib/iomap.c to x86 completely, since that file is only
      built when that symbol is defined.
   2. If it's moved to x86, the question arises whether it's possible
      to provide exact variants for lib/iomap.c's PIO_* constants. The
      comment above them in that file hint at those being just rough
      estimates ("assuming that all the low addresses are always PIO").
   3. To really just have one pci_iounmap(), we'd have to jump into
      s390 and replace its pci_iounmap(), which might be a bad idea
      since it also has its own pci_iomap().


So my tendency would be to leave s390 alone, figure out what's going on
with powerpc and then, if possible, move lib/iomap.c to x86 and
consequently have the second "generic" definition of iomem_is_ioport()
from asm-generic/iomap.h removed.

Ideas?

P.


[1] https://lore.kernel.org/all/20231213104922.13894-1-pstanner@redhat.com/
[2] https://lore.kernel.org/all/619ea619-29e4-42fb-9b27-1d1a32e0ee66@app.fa=
stmail.com/


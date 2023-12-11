Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2989380C3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjLKJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjLKJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:10:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3FF2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702285841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3H2rKzNGhPd5aG+amaV+RsXWG/q4mDryaGgazG1R5k=;
        b=goTdSFJJ4vGzxpA7yS2dsDwoOf/IBW2PrHDRxd3r3NfqGtCrPTnTsjy9HqieTlbpXBOVun
        BJxqT3KcGEUDkk3FGzkh1PQUZ8MeFqyYpjbN76LMWTDkaZ93JPSQn3qLDnavPrE4r1hYIP
        2wIjUAbUF5yxiYM6ZAKljNVnxo9/WjE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-7k3BtasXNIGeNUyNQiTfDg-1; Mon, 11 Dec 2023 04:10:34 -0500
X-MC-Unique: 7k3BtasXNIGeNUyNQiTfDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F258833944;
        Mon, 11 Dec 2023 09:10:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B74A11C060AF;
        Mon, 11 Dec 2023 09:10:32 +0000 (UTC)
Date:   Mon, 11 Dec 2023 17:10:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        loongarch@lists.linux.dev, kexec@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        akpm@linux-foundation.org, eric_devolder@yahoo.com,
        sfr@canb.auug.org.au, ignat@cloudflare.com
Subject: Re: [PATCH 0/5] kexec: fix the incorrect ifdeffery and dependency of
 CONFIG_KEXEC
Message-ID: <ZXbSBdalhEWPtUn0@MiWiFi-R3L-srv>
References: <20231208073036.7884-1-bhe@redhat.com>
 <ZXLI748b85be459B@fedora>
 <CAMuHMdWAaM+eJtiVbXXBO0xOmpqhrOiCO5itNsNdTiOxRXVtVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWAaM+eJtiVbXXBO0xOmpqhrOiCO5itNsNdTiOxRXVtVw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 at 09:25am, Geert Uytterhoeven wrote:
> Hi Baoquan,
> 
> On Fri, Dec 8, 2023 at 8:43 AM Baoquan He <bhe@redhat.com> wrote:
> > Forgot adding kexec to CC, add it now.
> >
> > On 12/08/23 at 03:30pm, Baoquan He wrote:
> > > The select of KEXEC for CRASH_DUMP in kernel/Kconfig.kexec will be
> > > dropped, then compiling errors will be triggered if below config
> > > items are set:
> > >
> > > ===
> > > CONFIG_CRASH_CORE=y
> > > CONFIG_KEXEC_CORE=y
> > > CONFIG_CRASH_DUMP=y
> > > ===
> > >
> > > E.g on mips, below link error are seen:
> > > --------------------------------------------------------------------
> > > mipsel-linux-ld: kernel/kexec_core.o: in function `kimage_free':
> > > kernel/kexec_core.c:(.text+0x2200): undefined reference to `machine_kexec_cleanup'
> > > mipsel-linux-ld: kernel/kexec_core.o: in function `__crash_kexec':
> > > kernel/kexec_core.c:(.text+0x2480): undefined reference to `machine_crash_shutdown'
> > > mipsel-linux-ld: kernel/kexec_core.c:(.text+0x2488): undefined reference to `machine_kexec'
> > > mipsel-linux-ld: kernel/kexec_core.o: in function `kernel_kexec':
> > > kernel/kexec_core.c:(.text+0x29b8): undefined reference to `machine_shutdown'
> > > mipsel-linux-ld: kernel/kexec_core.c:(.text+0x29c0): undefined reference to `machine_kexec'
> > > --------------------------------------------------------------------
> > >
> > > Here, change the incorrect dependency of building kexec_core related object
> > > files, and the ifdeffery on architectures from CONFIG_KEXEC to
> > > CONFIG_KEXEC_CORE.
> > >
> > > Testing:
> > > ========
> > > Passed on mips and loognarch with the LKP reproducer.
> > >
> > > Baoquan He (5):
> > >   loongarch, kexec: change dependency of object files
> > >   m68k, kexec: fix the incorrect ifdeffery and build dependency of
> > >     CONFIG_KEXEC
> > >   mips, kexec: fix the incorrect ifdeffery and dependency of
> > >     CONFIG_KEXEC
> > >   sh, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
> > >   x86, kexec: fix the wrong ifdeffery CONFIG_KEXEC
> 
> I understand this series is v3 of "[PATCH v2] kexec_core: change
> dependency of object files"? As this series does not contain a
> changelog, can you please summarize what was changed?
> Thanks!

Oh, sorry for the confusion.

You are right, I should have taken this as v3 and posted to avoid
confusion.

I add below change log for this series, not sure if it's clearer than
before. E.g for m68k, the <asm/kexec.h> is included in <linux/kexec.h>.
The old ifdeffery CONFIG_KEXEC will cause those definitions in
asm/kexec.h unseen if CONFIG_KEXEC is unset. See
KEXEC_SOURCE_MEMORY_LIMIT, it's needed in kernel/kexec_core.c.

Changelog:
------------
v2->v3:
- Change the incorrect ifdeffery CONFIG_KEXEC in arch. Since select of
  KEXEC for CRASH_DUMP in kernel/Kconfig.kexec is dropped, people can
  set below config items dependently of CONFIG_KEXEC. Then those
  KEXEC_CORE or CRASH_CORE related codes compiling will report error.

  ===
  CONFIG_CRASH_CORE=y
  CONFIG_KEXEC_CORE=y
  CONFIG_CRASH_DUMP=y
  ===
- Change the incorrect ifdeffery CONFIG_KEXEC in get_cmdline_acpi_rsdp()
  of x86 because kexec_file_load needs that too.

v1->v2:
- V1 only includes fix on loongarch. Add m68k, mips, sh fix in v2 too.


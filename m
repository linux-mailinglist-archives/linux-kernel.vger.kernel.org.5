Return-Path: <linux-kernel+bounces-112873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37993887F4F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EB01C20939
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25CF1D69E;
	Sun, 24 Mar 2024 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gTe2mtS6"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10691DDBC
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711317419; cv=none; b=Tl3/zO2uy1Pq483pBssGN8CklV5xcdeAHPGF8X3Ham6dSpl1aHdq2JbdjDGN+qCwRma7Ndlwxx6pWDM1ARQ/YrhqRCN5/DM1IUEgv7tXt7zwtq3//zO2zfXX/LDLdsDGw3aUXo7gSE479onGsIaJiW8HwEbwddvJU9EwRo1bcbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711317419; c=relaxed/simple;
	bh=EPCd0ysFywOYCmchneoXt0yanPLqNqiELvtLC696SpA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=C1NMrNUGGsTYI36kifRb20mCiXzzuk9OT7dnt6Akdbb3GIZgNWIW0QT8DkT2R6vohadR+YDds+t5mj+HSbctP1Q/SU6Xxtj7T6HPZ5FKWfyAgT+7o3gvQCcCVS9PiW45K9RoDdqyOednMRcCTuqDfHb3Pm5EAOhNyRF7nmzuFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gTe2mtS6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4749eecff7so113982466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711317415; x=1711922215; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mVqDdz/pe2+2gxWHsoecwPiEjqwfDyiRcYDZ64ngRhw=;
        b=gTe2mtS6kUlr5DKCSWhaUj5UVmNR+VmGAfu5fWboWLCqEC5hYp0G22OQNjrf1Ejs6v
         5ixgFR7E4WaCJYFT/LW/o7hUlGQ9/W52YCORIjJXivVUTJxqZFDQTBH1SjZwfMA/febe
         cv39IGoE+aGG0E8ywTkKWOkizJOhrmoza6O6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711317415; x=1711922215;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVqDdz/pe2+2gxWHsoecwPiEjqwfDyiRcYDZ64ngRhw=;
        b=mbfQHQe0e4wFo9g2vnoZ8VhbaB6trGc/MvGsrT0jbghrBxfk5L0cSoKaf1nz0iGS0a
         bXDc7t8S4406YzVEplmLRP/DnrrJjrtEDXbK7skBe3HGQmUvAMMakgqD8oXkYe9mewf+
         PDBBV5RRTxZJMVMUW6dYeNENyHmJr53WWSIAQ1SIkKEYBstYTHWb8PTtnNzDjO5Vx0KX
         h5ZRkNG0W6JGOuFIWkA0iMEH++kp8KvPJLqqnbVyEEWWRPU89qUZv6adcDwuVKxrZjxq
         unFF5DEz2wPXEm4IqsVlsN4lC9cdLPAskZRHyYlzK8/jms1BKRwaUDQROpzTNmINjnLd
         FjwA==
X-Gm-Message-State: AOJu0YzhFL6X+SOCVKlqxvzhi0lZ7R4PeQSWz3ofFnVPp+AdfxdFJdeL
	+FfPp62mg/a6bwY7oLyXo8U74WvGRUZKWZWS1CwlCLGdmwT7d7bwlybW7/xmvoBR1HdIwlllRMR
	Mva85yg==
X-Google-Smtp-Source: AGHT+IHt0CJuG+O+BFZTIGz3w8HZHbL38AxYnCh5V5gkR8ib5SMmneXpe3x+sEvVG+yuJshKZ/pCeA==
X-Received: by 2002:a17:906:f2c6:b0:a47:42a2:a73e with SMTP id gz6-20020a170906f2c600b00a4742a2a73emr3647890ejb.46.1711317414876;
        Sun, 24 Mar 2024 14:56:54 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906170400b00a473abcb9fdsm2364216eje.90.2024.03.24.14.56.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 14:56:54 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56be4efb63fso2640312a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:56:54 -0700 (PDT)
X-Received: by 2002:a17:906:8408:b0:a46:d522:e698 with SMTP id
 n8-20020a170906840800b00a46d522e698mr3200497ejx.43.1711317413831; Sun, 24 Mar
 2024 14:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Mar 2024 14:56:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOw_13JuuX4khpn4K+n09cRG3EBQWufAPBWoa0GLLQ0A@mail.gmail.com>
Message-ID: <CAHk-=wgOw_13JuuX4khpn4K+n09cRG3EBQWufAPBWoa0GLLQ0A@mail.gmail.com>
Subject: Linux 6.9-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So two weeks have passed, the merge window is over, and v6.9-rc1 is
tagged and pushed out.

This merge window looks to be fairly normal. If you look at the diffs,
you'd think that the bulk of all the changes are AMD GPU header files
again, and you'd not be entirely wrong. About 40% of the whole 6.9rc1
patch is indeed just the auto-generated AMD GPU definitions. I wish
this was unusual, but it's a pattern.

Anyway, while that is a lot of the actual changes by pure line
numbers, it's all just basically noise and not meaningful in the big
picture.

In contrast, what _is_ meaningful is a couple of very core updates.
The timer subsystem had a fairly big rewrite, to have per-cpu timer
wheels to improve performance of timers, which can be a big deal
particularly for networking. The other fairly notable core update is
to the workqueue subsystem, where one notable addition is for BH
workqueue support. That's notable mainly because it means we finally
have a way away from tasklets. The tasklet interface has basically
been deprecated for a long while, but we've never really had any good
alternatives (with threaded interrupt handlers being one suggested
use-case, but not realistic in many cases).

The core updates should be entirely invisible to users, as they don't
involve any semantic changes, just expanded capabilities. Of course,
being somewhat big changes, they did cause a few issues, but we've
hopefully already caught all the big deals.

Anyway, there's obviously also all the usual updates, and even when
you ignore the recurring AMD header drop more than half of actual
patch is - as usual - various driver updates all over. And all the
other usual suspects: architecture updates, various filesystems (old
ntfs core removal might be worth noting), core networking, VM and
kernel. And tooling and documentation.

Please commence testing,

           Linus

---

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Amir Goldstein (1):
    overlayfs fixes

Andreas Larsson (1):
    sparc updates

Andrew Morton (2):
    MM updates
    non-MM updates

Andy Shevchenko (1):
    auxdisplay updates

Ard Biesheuvel (3):
    EFI updates
    EFI fix
    EFI fixes

Arnd Bergmann (6):
    SoC device tree updates
    ARM SoC driver updates
    ARM SoC code updates
    ARM defconfig updates
    asm-generic updates
    more ARM SoC updates

Bartosz Golaszewski (1):
    gpio updates

Bjorn Andersson (3):
    remoteproc updates
    rpmsg updates
    hwspinlock updates

Bjorn Helgaas (1):
    PCI updates

Boqun Feng (1):
    RCU updates

Borislav Petkov (7):
    RAS fixlet
    x86 cpu update
    x86 MTRR update
    resource control updates
    x86 SEV updates
    misc x86 fixes
    EDAC updates

Casey Schaufler (1):
    smack updates

Catalin Marinas (2):
    arm64 updates
    arm64 fixes

Chandan Babu (2):
    xfs updates
    xfs fixes

Christian Brauner (8):
    misc vfs updates
    ntfs update
    iomap updates
    pdfd updates
    file locking updates
    block handle updates
    vfs uuid updates
    vfs fixes

Christoph Hellwig (2):
    dma-mapping updates
    dma-mapping fixes

Chuck Lever (1):
    nfsd updates

Damien Le Moal (1):
    zonefs update

Dan Williams (1):
    CXL updates

Dave Airlie (2):
    drm updates
    drm fixes

Dave Hansen (4):
    x86 mm updates
    x86 tdx update
    x86 RFDS mitigation
    x86 APIC fixup

Dave Jiang (1):
    libnvdimm updates

David Sterba (3):
    btrfs updates
    affs update
    btrfs fix

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    PCMCIA updates

Eric Biggers (2):
    fscrypt updates
    fsverity update

Eric Van Hensbergen (1):
    9p updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    USB / Thunderbolt updates
    tty / serial driver updates
    staging driver updates
    char/misc and other driver subsystem updates
    driver core updates

Guenter Roeck (1):
    hwmon updates

Heiko Carstens (2):
    s390 updates
    more s390 updates

Helge Deller (2):
    parisc architecture updates and fixes
    fbdev updates

Herbert Xu (1):
    crypto updates

Huacai Chen (1):
    LoongArch updates

Ilpo J=C3=A4rvinen (1):
    x86 platform driver updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (10):
    locking updates
    scheduler updates
    x86 asm updates
    x86 build updates
    x86 cleanups
    core x86 updates
    x86 boot updates
    x86 perf event fixes
    timer fix
    irq fix

Jaegeuk Kim (1):
    f2fs update

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (2):
    fsnotify updates
    ext2, isofs, udf, and quota updates

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (5):
    io_uring updates
    block updates
    block fixes
    more io_uring updates
    more block updates

Jiri Kosina (1):
    HID updates

Joel Granados (1):
    sysctl updates

Joerg Roedel (1):
    iommu updates

John Paul Adrian Glaubitz (1):
    sh updates

Jonathan Corbet (2):
    documentation updates
    more documentation updates

Juergen Gross (1):
    xen updates

Julia Lawall (1):
    coccinelle update

Kees Cook (5):
    pstore updates
    execve updates
    hardening updates
    seccomp updates
    more hardening updates

Kent Overstreet (2):
    bcachefs updates
    bcachefs fixes

Lee Jones (3):
    MFD updates
    backlight updates
    LED updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (1):
    modules updates

Mark Brown (5):
    regmap updates
    regulator updates
    spi updates
    regulator fix
    spi fixes

Masahiro Yamada (1):
    Kbuild updates

Masami Hiramatsu (1):
    probes updates

Mauro Carvalho Chehab (1):
    media updates

Michael Ellerman (2):
    powerpc updates
    more powerpc updates

Michael Tsirkin (1):
    virtio updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock updates

Miguel Ojeda (2):
    compiler attributes update
    Rust updates

Mike Marshall (1):
    orangefs updates

Mike Snitzer (4):
    device mapper updates
    device mapper BH workqueue conversion
    device mapper VDO target
    device mapper fixes

Miklos Szeredi (1):
    fuse updates

Miquel Raynal (1):
    MTD updates

Namhyung Kim (1):
    perf tools updates

Namjae Jeon (1):
    exfat updates

Niklas Cassel (2):
    ata updates
    ata fix

Palmer Dabbelt (1):
    RISC-V updates

Paolo Bonzini (1):
    kvm updates

Paul Moore (4):
    audit updates
    selinux updates
    lsm updates
    lsm fixes

Petr Mladek (1):
    printk updates

Rafael Wysocki (6):
    power management updates
    ACPI updates
    thermal control updates
    more thermal control updates
    more ACPI updates
    more power management updates

Richard Weinberger (1):
    UBI and UBIFS updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    HSI updates
    power supply and reset updates

Shuah Khan (2):
    kselftest update
    KUnit updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (1):
    clk updates

Steve French (3):
    smb client updates
    smb server updates
    smb client fixes

Steven Rostedt (4):
    tracing updates
    tracing updates
    ktest updates
    trace tool updates

Takashi Iwai (3):
    sound updates
    sound fixes
    more sound fixes

Takashi Sakamoto (1):
    firewire updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (3):
    workqueue updates
    workqueue BH conversions
    cgroup updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (14):
    irq updates
    MSI updates
    cpu core updates
    clocksource updates
    timer updates
    x86 APIC updates
    x86 FRED support
    x86 entry update
    core entry fix
    irq fixes
    more clocksource updates
    timer fixes
    scheduler doc clarification
    x86 fixes

Trond Myklebust (1):
    NFS client updates

Tzung-Bi Shih (1):
    chrome platform firmware updates

Ulf Hansson (2):
    MMC updates
    pmdomain updates

Uwe Kleine-K=C3=B6nig (2):
    pwm updates
    siox updates

Vinod Koul (3):
    soundwire updates
    dmaengine updates
    phy updates

Vlastimil Babka (1):
    slab updates

Wei Liu (1):
    hyperv updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    more i2c updates

Yury Norov (1):
    bitmap updates


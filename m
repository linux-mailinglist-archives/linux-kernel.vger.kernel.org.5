Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC47E93B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjKMAr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjKMAr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:47:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52031991
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:47:23 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507cee17b00so5143679e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699836442; x=1700441242; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2QVBRxAfRnVSUR3H7LWGWH5YQRmfDoozxroE46eXLnk=;
        b=gHh+yXaA9VBC0WgEysV6dUSbW4v1IgSwgGOnJWl/DdygDrZB3V10QwYHzElJ5lYV1V
         k7CKKH5hzmoeFlrn0PeT0G6Y6vcPLYVagwvFg24RP/q5p7ndr9E19t0vrn511MSzm/DB
         +5/R2pfoqfKPI4vdKLxWPHsfLu6XuVQbbVlB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699836442; x=1700441242;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QVBRxAfRnVSUR3H7LWGWH5YQRmfDoozxroE46eXLnk=;
        b=JY2WSrAgzOw7P3x6xVusY2nXPCtbpkDXDaxwqQL+bhkGjl1yKg+ZQIDXaibd3RY3c0
         x6kpbPRLc3ykVJIrkYQlZuctd9OkTeEouAG+blMeq9BXj6ucUzlD52CPhEtV5uYzlzUd
         0VgHq2/lxV4Di+QI5a9xPEkIylJ4nt3MeTEB1T5aC+6Nmggf3qcgDBUAOgMN76K0fYaJ
         3W0ERyCtqGfvcNyd0QeZJf7Na1/1jdrATQvAsmKp9z+fHL2zpegUdWBdUlwUCXpfwU9s
         805dOPv2FtSOydX2hQckwKipCJkFfbbyr0GBgS2gPOoi9T6anJVVJlni8g55NYR82v5T
         X4eA==
X-Gm-Message-State: AOJu0YzVyvfayZsRQ/KYn4gDgX1JwHD2o31hjyHt0WVTnwMzBUfD4Q+t
        y1p2xMdOWcWfqo82+4ldnwPV9ww5T9lRiw5yEohfKLoY
X-Google-Smtp-Source: AGHT+IHt1E5yObYOWmgl9rx8WIVvdc84Y6roYz4lJEWYRNRGClZDqa65oX18D+Ckn8/9L3pwvVWQLw==
X-Received: by 2002:a05:6512:291:b0:507:a66f:55e2 with SMTP id j17-20020a056512029100b00507a66f55e2mr3425320lfp.10.1699836441631;
        Sun, 12 Nov 2023 16:47:21 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id lg7-20020a170906f88700b00977eec7b7e8sm3173558ejb.68.2023.11.12.16.47.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:47:21 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so6447985a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:47:21 -0800 (PST)
X-Received: by 2002:aa7:d353:0:b0:53d:e139:64a5 with SMTP id
 m19-20020aa7d353000000b0053de13964a5mr3608309edr.27.1699836440816; Sun, 12
 Nov 2023 16:47:20 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Nov 2023 16:47:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whuO0zmuxp_yorYFWdcrALpqjRPhWkmEy+7wcCnnDcPNA@mail.gmail.com>
Message-ID: <CAHk-=whuO0zmuxp_yorYFWdcrALpqjRPhWkmEy+7wcCnnDcPNA@mail.gmail.com>
Subject: Linux 6.7-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So here we are, two weeks after the merge window opened, and 6.7-rc1
is out, and the merge window is closed.

In number of commits, this is the biggest merge window we've ever had,
with 15.4k non-merge commits. That is quite a bit bigger than the
previous biggest releases (4.9, 5.8 and 5.13) that all weighted in at
about 14.2k non-merge commits.

Now, part of that is obviously the bcachefs merge, which brought in a
lot of commits because it included the full history. But 6.7 is pretty
big in other ways too, with

 12678 files changed, 838819 insertions(+), 280754 deletions(-)

which is also bigger than those historically big releases. And that's
not due to bcachefs, that's actually mainly due to ia64 removal and a
lot of GPU support (notably lots of AMD GPU header files again - lots
and lots of lines, but there's support for new nvidia cards too).

But there's changes all over, even if they may not stand out quite as
much in the diffstats or the commit numbers.

Below is my merge log, which gives a hint of the big picture changes,

                  Linus

---

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Amir Goldstein (1):
    overlayfs updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (2):
    MM updates
    non-MM updates

Ard Biesheuvel (1):
    EFI update

Arnd Bergmann (5):
    SoC DT updates
    SoC driver updates
    ARM defconfig updates
    ARM SoC code updates
    ia64 removal and asm-generic updates

Bartosz Golaszewski (2):
    gpio updates
    gpio/pinctrl updates

Bjorn Andersson (2):
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (1):
    pci updates

Borislac Petkov (1):
    x86 microcode loading updates

Borislav Petkov (7):
    EDAC updates
    x86 RAS updates
    x86 hw mitigation updates
    x86 resource control updates
    x86 cpuid updates
    x86 platform updates
    x86 fpu fixlet

Catalin Marinas (2):
    arm64 updates
    arm64 fixes

Chandan Babu (1):
    xfs updates

Christian Brauner (8):
    vfs superblock updates
    autofs mount api updates
    misc vfs updates
    iov_iter updates
    vfs xattr updates
    vfs inode time accessor updates
    iomap maintainership rotation
    vfs fanotify fsid updates

Christoph Hellwig (2):
    dma-mapping updates
    dma-mapping fixes

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI update

Damien Le Moal (2):
    ATA updates
    ata fixes

Dan Williams (2):
    unified attestation reporting
    CXL (Compute Express Link) updates

Daniel Thompson (1):
    kgdb updates

Daniel Vetter (1):
    drm fixes

Dave Airlie (3):
    drm updates
    drm nouveau GSP support
    more drm updates

Dave Hansen (1):
    x86 TDX updates

Dave Kleikamp (1):
    jfs updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dipen Patel (1):
    hte/timestamp updates

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    PCMCIA updates

Dominique Martinet (1):
    9p updates

Eric Biggers (1):
    fscrypt updates

Frederic Weisbecker (2):
    RCU updates
    RCU fixes

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    char/misc updates
    driver core updates
    staging driver updates
    tty and serial updates
    USB/Thunderbolt updates

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Helge Deller (3):
    parisc updates
    fbdev fixes and cleanups
    parisc architecture fixes

Herbert Xu (2):
    crypto updates
    crypto fixes

Huacai Chen (1):
    LoongArch updates

Ilpo J=C3=A4rvinen (1):
    x86 platform driver updates

Ilya Dryomov (1):
    ceph updates

Info Molnar (1):
    locking updates

Ingo Molnar (10):
    scheduler updates
    objtool updates
    performance event updates
    x86 header file cleanup
    x86 boot updates
    x86 assembly code updates
    x86 entry updates
    x86 irq fix
    x86 mm handling updates
    x86 build update

Ira Weiny (1):
    libnvdimm updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (3):
    networking updates
    more networking updates
    networking fixes

James Bottomley (1):
    SCSI updates

Jan Kara (2):
    ext2, udf, and quota updates
    fsnotify update

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (2):
    iommufd updates
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (6):
    io_uring updates
    io_uring {get,set}sockopt support
    io_uring futex support
    block updates
    block fixes
    io_uring fixes

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

John Johansen (1):
    apparmor updates

John Paul Adrian Glaubitz (1):
    sh updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (3):
    hardening updates
    pstore updates
    execve updates

Kent Overstreet (2):
    initial bcachefs updates
    more bcachefs updates

Lee Jones (3):
    MFD updates
    backlight updates
    LED updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (2):
    sysctl updates
    modules updates

Mark Brown (5):
    regmap updates
    regulator updates
    spi updates
    regmap fix
    spi fixes

Masahiro Yamada (1):
    Kbuild updates

Masami Hiramatsu (3):
    bootconfig updates
    probes updates
    probes fixes

Mauro Carvalho Chehab (1):
    media updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock updates

Miguel Ojeda (1):
    rust updates

Mike Rapoport (1):
    memblock update

Mike Snitzer (1):
    device mapper updates

Mimi Zohar (1):
    integrity updates

Miquel Raynal (1):
    mtd updates

Namhyung Kim (1):
    perf tools updates

Namjae Jeon (2):
    exfat updates
    exfat updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Bonzini (1):
    kvm updates

Paul McKenney (3):
    nolibc updates
    Linux Kernel Memory Model updates
    CSD lock update

Paul Moore (4):
    audit update
    selinux updates
    LSM updates
    lsm updates

Petr Mladek (2):
    livepatching update
    printk updates

Rafael Wysocki (5):
    thermal control updates
    ACPI updates
    power management updates
    ACPI fix
    more power management updates

Richard Weinberger (1):
    UBI and UBIFS updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    kunit updates
    kselftest updates

Stephen Boyd (1):
    clk driver updates

Steve French (4):
    smb server updates
    smb client updates
    smb server fixes
    smb client fixes

Steven Rostedt (2):
    tracing tools updates
    tracing updates

Takashi Iwai (2):
    sound updates
    sound fixes

Takashi Sakamoto (1):
    firewire update

Ted Ts'o (1):
    ext4 updates

Tejun Heo (3):
    workqueue rust bindings
    workqueue update
    cgroup updates

Thierry Reding (2):
    pwm updates
    pwm fixes

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (6):
    core updates
    irq updates
    SMP and CPU hotplug updates
    timer updates
    x86 APIC updates
    x86 core updates

Trond Myklebust (1):
    NFS client updates

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (3):
    MMC updates
    pmdomain updates
    MMC fixes

Vasily Gorbik (2):
    s390 updates
    more s390 updates

Vinod Koul (3):
    dmaengine updates
    generic phy updates
    soundwire updates

Vlastimil Babka (1):
    slab updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    more i2c updates

Yury Norov (1):
    bitmap updates

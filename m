Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C4C79A0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 01:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjIJXyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 19:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjIJXyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 19:54:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84F18C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 16:54:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500cfb168c6so6231641e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 16:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694390054; x=1694994854; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=giTJk4xwaBZNqIQxXlhjCEhhBeYf9ZJqsgT4zuCVOOM=;
        b=FK/w+f4gsUaXelBXnGFzTp4arcf2WYjm98z1owiLpYPwVA3YD1ngxvf22TXfQmFHFf
         03b0HNNe9XtZ5tsbTPzz8zkbd4fq0JBuMDO/+H5IGrCcFXtqbtMtssa3kIwqL4InUjnP
         gSrZIQ4oe0m/4jlqyMEIze8qooAIQfkHTOCBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694390054; x=1694994854;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giTJk4xwaBZNqIQxXlhjCEhhBeYf9ZJqsgT4zuCVOOM=;
        b=uMPIU9qfV7gbdunxYO6xfv1aNA7cdOZGV3nC3SglAcr/v0VbxB2h+44ccMNan90mXo
         Ihp65HylCuGp4m2clt6BLgdALtORW09UGF+t79TacmtwKztt7hkpNN1oIBMMhQ8U+Qx0
         SSyTo3qCZsl0zkxbbQk9M8aX82MJVf+wHEqd7wPI/3xfuc8izHqrRyNFAyvedkmgysGQ
         SB6jhpfyDXiQ84EaWMNXwIn9A4UmupIJ1vXM6/4a19mzOTt2aRKNs6kuwKNc4a0HumgM
         4x0W5pzTNtpjsBHpI5JJZHR/S24yMn5oIg6zSuMnX7yH3Wgk8lhIhjnBJko9kabKk2EV
         v8EQ==
X-Gm-Message-State: AOJu0Yzd/01yKEXcEz9OOUdiK99vP2W4GiQqxoyiEChkTQB4dJVEwJGO
        K8YcFSuXVLggLgyjPS0G/HMcRvIHpmzkitJml1ZtCw==
X-Google-Smtp-Source: AGHT+IEffGG45j7gZBfQUsSNWkEGNQr6xVnbU8QL/9SRbXDMBZNkBSpOw2s5fe77g0gHR5p1jVyy3g==
X-Received: by 2002:a05:6512:280d:b0:500:a60d:c677 with SMTP id cf13-20020a056512280d00b00500a60dc677mr6590598lfb.59.1694390053852;
        Sun, 10 Sep 2023 16:54:13 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id d1-20020a50fb01000000b005224f840130sm3825155edq.60.2023.09.10.16.54.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 16:54:13 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9a9f139cd94so384199666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 16:54:13 -0700 (PDT)
X-Received: by 2002:a17:906:32c3:b0:9a5:a701:2b90 with SMTP id
 k3-20020a17090632c300b009a5a7012b90mr6673811ejk.40.1694390052749; Sun, 10 Sep
 2023 16:54:12 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Sep 2023 16:53:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
Message-ID: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
Subject: Linux 6.6-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here we are, two weeks later, and the merge window is closed.

All the stats for 6.6 look fairly normal so far - as always, the bulk
of the patch is drivers (a bit of everything, but networking and gpu
are the two biggest areas), with arch updates coming in as a notable
second, and then we have tooling and documentation.

There's obviously core kernel updates too (filesystem updates,
networking, core VM updates etc) but yeah, all the hardware support -
whether drivers or CPUs - tends to just dwarf all the core changes in
the diffstat.

And as always, there are way too many individual changes - or even
developers - to list for the merge window. We've got 12k+ commits from
1700+ individual developers,  And 800+ merges to tie it all together.
All that is actually quite normal, this seems to be shaping up to be
neither a very small nor a particularly large release.

So below is just my "merge log" which gives some flavor of what got
merged, but does not delve into the details. For those, you'd have to
go to the actual git tree.

Please do give it all a whirl,

                     Linus

---

Adrian Glaubitz (1):
    sh updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Amir Goldstein (1):
    overlayfs updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (4):
    MM updates
    non-MM updates
    more MM updates
    misc fixes

Anna Schumaker (1):
    NFS client updates

Ard Biesheuvel (1):
    EFI updates

Arnaldo Carvalho de Melo (1):
    perf tools updates

Arnd Bergmann (4):
    ARM SoC driver updates
    ARM defconfig updates
    ARM SoC cleanups
    ARM devicetree updates

Bartosz Golaszewski (2):
    gpio updates
    gpio fix

Benjamin Tissoires (1):
    HID updates

Bjorn Andersson (3):
    hwspinlock updates
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (2):
    PCI updates
    PCI fixes

Borislav Petkov (5):
    x86 boot updates
    misc x86 updates
    x86 RAS updates
    x86 SEV updates
    x86 microcode loading updates

Casey Schaufler (1):
    smack updates

Chandan Babu (1):
    xfs updates

Christian Brauner (10):
    mount API updates
    vfs timestamp updates
    libfs and tmpfs updates
    misc vfs updates
    superblock updates
    fchmodat2 system call
    autofs fixes
    procfs fixes
    superblock fixes
    more superblock follow-on fixes

Christoph Hellwig (2):
    dma-mapping updates
    dma-mapping fixes

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI updates

Damien Le Moal (1):
    ata updates

Darrick Wong (1):
    iomap updates

Dave Airlie (3):
    drm updates
    drm fixes
    drm ci scripts

Dave Hansen (4):
    x86 mm updates
    x86 apic updates
    x86 shadow stack support
    x86 fixes

Dave Jiang (1):
    nvdimm updates

Dave Kleikamp (1):
    jfs updates

David Sterba (2):
    affs updates
    btrfs updates

David Teigland (1):
    dlm updates

Dennis Zhou (1):
    percpu updates

Dmitry Torokhov (1):
    input updates

Eric Biggers (2):
    fscrypt update
    fsverity updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (6):
    USB / Thunderbolt / PHY driver updates
    staging driver updates
    tty/serial driver updates
    driver core updates
    char/misc driver updates
    driver symbol lookup fix

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Guo Ren (2):
    arch/csky updates
    arch/csky fix

Gustavo A (1):
    flexible-array updates

Hans de Goede (1):
    x86 platform driver updates

Heiko Carstens (2):
    s390 updates
    more s390 updates

Helge Deller (2):
    parisc architecture updates
    fbdev updates

Herbert Xu (2):
    crypto updates
    crypto fix

Huacai Chen (1):
    LoongArch updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (10):
    locking update
    perf event updates
    scheduler updates
    misc x86 cleanups
    scheduler fixes
    CPU hotplug fix
    timer fix
    x86 selftest fix
    x86 perf event fix
    x86 fixes

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (1):
    networking updates

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (2):
    ext2, quota, and udf updates
    fsnotify update

Jarkko Sakkinen (2):
    tpm updates
    more tpm updates

Jason Gunthorpe (2):
    iommufd updates
    rdma updates

Jassi Brar (1):
    mailbox updates

Jeff Layton (1):
    file locking updates

Jens Axboe (4):
    io_uring updates
    block updates
    io_uring fixes
    block fixes

Joerg Roedel (1):
    iommu updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (4):
    pstore updates
    seccomp updates
    hardening updates
    pstore fix

Lee Jones (3):
    NFD updates
    LED updates
    backlight updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (2):
    modules updates
    sysctl updates

Mark Brown (5):
    regmap updates
    regulator updates
    spi updates
    spi fixes
    regulator fixes

Masahiro Yamada (1):
    Kbuild updates

Masami Hiramatsu (1):
    probes updates

Matthew Wilcox (1):
    xarray fixes

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    xtensa updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock updates

Miguel Ojeda (2):
    rust updates
    auxdisplay update

Miklos Szeredi (1):
    fuse updates

Mimi Zohar (1):
    integrity subsystem updates

Miquel Raynal (1):
    MTD updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Abeni (1):
    networking updates

Paolo Bonzini (1):
    kvm updates

Paul McKenney (4):
    RCU updates
    smp_call_function torture-test updates
    CSD lock updates
    clocksource watchdog updates

Paul Moore (3):
    audit updates
    selinux updates
    LSM updates

Petr Mladek (2):
    printk updates
    printk fix

Rafael Wysocki (7):
    ACPI updates
    power management updates
    thermal control updates
    more thermal control updates
    more power management updates
    power management fix
    more thermal control updates

Richard Weinberger (1):
    UML updates

Rob Herring (3):
    devicetree updates
    devicetree include cleanups
    more devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    power supply and reset updates
    HSI update

Shuah Khan (3):
    Kselftest updates
    kunit updates
    nolibc updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (1):
    clk subsystem updates

Steve French (4):
    smb client updates
    smb server updates
    smb server update
    smb client fixes

Steven Rostedt (2):
    tracing updates
    more tracing updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    cgroup updates
    workqueue updates

Tetsuo Handa (1):
    tomoyo updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (5):
    core entry code update
    irq updates
    CPU hotplug updates
    x86 core updates
    clocksource/clockevent driver updates

Tony Luck (1):
    intel EDAC fixes

Tzung-Bi Shih (2):
    chrome platform updates
    chrome platform firmware update

Ulf Hansson (2):
    MMC updates
    ARM SoC generic power domain driver updates

Vineet Gupta (1):
    ARC updates

Vinod Koul (3):
    soundwire updates
    phy updates
    dmaengine updates

Vlastimil Babka (1):
    slab updates

Wei Liu (1):
    hyperv updates

Will Deacon (2):
    arm64 updates
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

Return-Path: <linux-kernel+bounces-32201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 974D183581C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAF5281F73
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF41F38F87;
	Sun, 21 Jan 2024 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ORs2HL8L"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF538F80
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705875851; cv=none; b=QQvTq6g4iYrDjg62arLkbOZc/Bqx//1tDrPETaO/lzkzXU0ok1UWc2hX+XyA46vbiJfGADD++E8ew5LoV4S9JzVgTCxca++YYymRtcA9iRsEC/ca5RteRfdwDCiJ75GuGsKXkQRxsQctET7p63s6pE26WlHfHwcrZcrKy7wEHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705875851; c=relaxed/simple;
	bh=dDa7C4QodUYbmIZJtAlK/HScrkg/lesQ4vI02/cljBc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lUli3OP9fKrpmcgahETPmdz38WFJwj5gMwrutBHA+y/kOX1/AAAwzqELQD8vyzwS0N89PJ8u2ekj7CVoN29YrUcPzKdFmuADhB3PwWY9F9W5GlXRrki2PCKa4LK+7CtN3HWx8L5iT8vmGMaFYKzEqQXDdJN4YX7rY345ZNvkPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ORs2HL8L; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50f1c524010so2020150e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 14:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705875847; x=1706480647; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iamfUYmIh3/KxPOhtvGIyneJhbVYXx6PKYDWghiAEHs=;
        b=ORs2HL8Le5kJFV1rbeU0YJcbK/T3Iz/2yGYGJ0k2KR+jX+ytCvVwlZRsFESCn4YuYp
         garkFNhhLXZKPnmCi8fIWrUTpcgyZho7nO7s+oefvVPqbCwxMr6m/kCcsLRL5ybs9TF4
         PUZjkfkzvILf9JWlyG3dlgrPj/muZE1D3Ume8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705875847; x=1706480647;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iamfUYmIh3/KxPOhtvGIyneJhbVYXx6PKYDWghiAEHs=;
        b=jJyj6zm/5CfVe3IIZn2WXEsxVQYin57c77K6b7yIknpM3OStuFym6FPAPIL/cHx1Ga
         mM1T8PoVuEkt6iYjoHPXRhAuxWs+TBqN6xmB4SU8E/9WApIZLzs6GYDo3+ejlgw8HEyq
         bRkpjH/EFJoNka57seC1/Y9eyHTgwBpDpiDYUmVhvTLhsvqKha5yFDKWlB8ZOMxCiplr
         1j3n4xWc3JX/qED2TD1pHK6QmxX0h6Q11NN/pGdwgzGqgW1HmoBUMTsiW5PYZZeRQ2Ip
         CW4R2mUEbhEr5Wsjy2/YtT35xIBrz3Z1Cw1tFftcZW6w2opHxPxy0rKjsEIR9dyzoFej
         PLLg==
X-Gm-Message-State: AOJu0Yw5sBfaISlaZ7Cgc7WrhG6V6iCZQbGDZ3U/iTW8jMCMocMd13sD
	iiX1l/V9Iw/CiP2vubxAQDabGuGqbOs2lmsCg6xaNV4TAcNGBkyQwha7G2eCrUnqZgx9rNasBjv
	5tnV+Vw==
X-Google-Smtp-Source: AGHT+IHE/2c8BRioo2t2s4Pg5Igtn40d8P/WqP7S0H18h7L7TBXtP6ZpFG0Vw1MTF7w358FB0HLtBw==
X-Received: by 2002:a05:6512:52b:b0:50f:96b:8caa with SMTP id o11-20020a056512052b00b0050f096b8caamr510288lfc.198.1705875847125;
        Sun, 21 Jan 2024 14:24:07 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24c4b000000b0050e8223688fsm1755432lfk.30.2024.01.21.14.24.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 14:24:06 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cdeb80fdfdso26667221fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 14:24:06 -0800 (PST)
X-Received: by 2002:a2e:9f44:0:b0:2cc:a65e:ec65 with SMTP id
 v4-20020a2e9f44000000b002cca65eec65mr500201ljk.12.1705875845987; Sun, 21 Jan
 2024 14:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 14:23:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiB4iHTtfZKiy5pC24uOjun4fbj4kSX0=ZnGsOXadMf6g@mail.gmail.com>
Message-ID: <CAHk-=wiB4iHTtfZKiy5pC24uOjun4fbj4kSX0=ZnGsOXadMf6g@mail.gmail.com>
Subject: Linux 6.8-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So this wasn't the most pleasant merge window, but most of the
unpleasantness was entirely unrelated to the code base and almost
entirely related to nasty weather. Just a few technical hiccups. And
after a very big 6.7 release, 6.8 looks to actually be smaller than
average, although not really all that significantly so.

And while maybe a bit smaller than usual (I blame the holidays),
things generally look pretty normal. The bulk is driver updates (GPU
and networking drivers are the big areas as always, but there's a bit
of everything), but we've also got a fair chunk of filesystem updates
(mainly core vfs, bcachefs, xfs and btrfs) and obviously all the usual
arch updates.

The rest is all over: docs, tooling, core kernel, mm and networking.
My mergelog below gives some kind of high-level overview.

Let the testing and calming down begin,

                 Linus

--

Al Viro (6):
    minixfs updates
    rename updates
    dcache updates
    misc filesystem updates
    nfsctl update
    bcachefs locking fix

Alex Williamson (1):
    VFIO updates

Alexander Gordeev (2):
    s390 updates
    more s390 updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Amir Goldstein (1):
    overlayfs updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    MM updates
    non-MM updates
    misc hotfixes

Aneesh Kumar (1):
    powerpc fixes

Anna Schumaker (1):
    nfs client updates

Ard Biesheuvel (1):
    EFI updates

Arnaldo Carvalho de Melo (1):
    perf tools updates

Arnd Bergmann (5):
    asm-generic cleanups
    SoC DT updates
    SoC driver updates
    ARM SoC code updates
    ARM SoC defconfig updates

Bartosz Golaszewski (2):
    gpio updates
    gpio fixes

Bjorn Andersson (3):
    rpmsg updates
    remoteproc updates
    hwspinlock updates

Bjorn Helgaas (1):
    pci updates

Borislav Petkov (7):
    EDAC updates
    x86 microcode updates
    misc x86 updates
    x86 paravirt updates
    x86 SEV updates
    x86 cpu feature updates
    x86 RAS updates

Chandan Babu (2):
    xfs updates
    xfs fix

Christian Brauner (8):
    misc vfs updates
    vfs super updates
    vfs mount updates
    vfs rw updates
    vfs cachefiles updates
    vfs iov_iter cleanups
    vfs fixes
    netfs updates

Christoph Hellwig (2):
    dma-mapping updates
    dma-mapping fixes

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI updates

Damien Le Moal (1):
    ata updates

Dan Williams (1):
    CXL (Compute Express Link) updates

Daniel Thompson (1):
    kgdb update

Dave Airlie (3):
    drm updates
    drm fixes
    more drm fixes

Dave Hansen (2):
    x86 SGX updates
    x86 TDX updates

David Howells (1):
    afs updates

David Kleikamp (1):
    jfs updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dennis Zhou (1):
    percpu updates

Dmitry Torokhov (1):
    input updates

Eric Biggers (2):
    fscrypt updates
    fscrypt fix

Gabriel Krisman Bertazi (1):
    unicode updates

Gao Xiang (2):
    erofs updates
    erofs fixes

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    char/misc and other driver updates
    driver core updates
    staging driver updates
    tty / serial updates
    USB / Thunderbolt updates

Guenter Roeck (2):
    hwmon updates
    hwmonfix

Hans de Goede (1):
    x86 platform driver updates

Helge Deller (3):
    fbdev updates
    parisc updates
    fbdev fix

Herbert Xu (1):
    crypto updates

Huacai Chen (1):
    LoongArch updates

Ilya Dryomov (1):
    ceph updates

Ingo Molar (1):
    locking updates

Ingo Molnar (16):
    x86 apic updates
    x86 asm updates
    x86 boot updates
    x86 build updates
    x86 cleanups
    x86 core updates
    x86 entry updates
    objtool fixlet
    debugobject update
    generic syscall updates
    CPU hotplug updates
    timer subsystem updates
    irq subsystem updates
    performance events updates
    scheduler updates
    scheduler fix

Ira Weiny (1):
    libnvdimm updates

Jaegeuk Kim (1):
    f2fs update

Jakub Kicinski (1):
    networking fixes

James Bottomley (2):
    SCSI updates
    SCSI updates

Jan Kara (2):
    small quota cleanup
    fsnotify updates

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (2):
    rdma updates
    iommufd updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (4):
    block updates
    io_uring updates
    io_uring fixes
    block fixes

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

Johan Hovold (1):
    GNSS updates

John Johansen (1):
    AppArmor updates

John Paul Adrian Glaubitz (1):
    sh updates

Jonathan Corbet (2):
    documentation update
    documentation fixes

Juergen Gross (1):
    xen updates

Julia Lawall (1):
    coccinelle updates

Kees Cook (3):
    pstore updates
    hardening updates
    strlcpy removal

Kent Overstreet (4):
    bcachefs updates
    header cleanups
    header fix
    more bcachefs updates

Lee Jones (3):
    mfd updates
    LED updates
    backlight updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (2):
    sysctl updates
    module updates

Mark Brown (4):
    regmap updates
    regulator updates
    spi updates
    spi fix

Masahiro Yamada (1):
    Kbuild updates

Masami Hiramatsu (1):
    probes update

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    Xtensa updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Micka=C3=ABl Sala=C3=BCn (1):
    Landlock updates

Miguel Ojeda (3):
    Rust updates
    clang-format updates
    auxdisplay update

Mike Rapoport (1):
    memblock update

Mimi Zohar (1):
    integrity updates

Miquel Raynal (1):
    mtd updates

Namjae Jeon (1):
    exfat updates

Neeraj Upadhyay (1):
    RCU updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Abeni (1):
    networking updates

Paolo Bonzini (1):
    kvm updates

Paul Moore (3):
    audit updates
    selinux updates
    security module updates

Rafael Wysocki (6):
    ACPI updates
    thermal control updates
    power management updates
    more power management updates
    more ACPI updates
    more thermal control updates

Richard Weinberger (2):
    UBI and UBIFS updates
    UML updates

Rob Herring (2):
    devicetree updates
    devicetree header detangling

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    HSI update
    power supply and reset updates

Shuah Khan (3):
    nolibc updates
    KUnit updates
    kselftest update

Stephen Boyd (1):
    clk updates

Steve French (4):
    smb client fixes
    smb server updates
    more smb server updates
    smb client updates

Steven Rostedt (2):
    tracing updates
    eventfs updates

Takashi Iwai (2):
    sound updates
    sound fixes

Takashi Sakamoto (1):
    firewire updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (1):
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (1):
    timer updates

Tzung-Bi Shih (2):
    chrome platform updates
    chrome platform firmware updates

Ulf Hansson (2):
    pmdomain updates
    MMC updates

Uwe Kleine-K=C3=B6nig (1):
    pwm fixes

Vinod Koul (3):
    soundwire updates
    phy updates
    dmaengine updates

Vlastimil Babka (1):
    slab updates

Will Deacon (2):
    arm64 updates
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates


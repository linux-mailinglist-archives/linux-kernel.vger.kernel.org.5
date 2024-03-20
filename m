Return-Path: <linux-kernel+bounces-108447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42689880AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E5C283963
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0F614A8F;
	Wed, 20 Mar 2024 05:31:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCFC11CA0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710912664; cv=none; b=QBwJHMk9zQvdYJEWuwJRqhmh1s3DnqZ6Tj9f/88Ws45p39U6tjbyxLNx1CqOeCHTiMvbsgq8CpKdRwq3jtKcBdJoFH+EDHF/kiZbS30SnGv54g9sks1Ps6U1xnO6W3xPMm0vgBKSFFAn4HaHkvDRSpd2cTGVyrGFIy9cQhNmijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710912664; c=relaxed/simple;
	bh=qux7m2HmnN35cFkp5idfkUCHyS/DCT5fjVvJTty+4RE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KOuPebiZk1RCJN62zi6qfMSUKBQAniWILdb5OwzbLXzXrFq6MbCqjA0p0/5S1frxR/ybVeDb2f7uSc/Ko1FApTQbaZ+hruL8dECbKaE23QYQp8rdT/C8K9bHrUfVprACRwwf9zqoNnmuUyH+4NS0mv/Z6ldh4Buy7lzxF4a50Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3684bee9c40so4802475ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710912662; x=1711517462;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiWuqLxt0R2fFrfQ9gUNrwhU9imvo9Ur2mxOz6a3cqo=;
        b=VC4KzCVXNmGSXdvJqNOGeSZ5qMYLVKc80eU0EfT3ymnu6rPLrCIt24HkiFGoEct2lY
         tcMvGXcV1WtDTfN8PBkbkMNlB4bLGthPHVETJU4kfUQqsByAAZLIdDPfVbBCVOA8eI6Q
         EU1+Ra7EDJmdh9I1x+LaHwnLWpHj2bBZKVWIlTqSNBHL8LCsi2/g8OaOVeN13nACJAWy
         ZT/Ksxb46l2nxyjG0ZzepHvBEsX7I9ZvGr60aFvya21EXDwpohqX3NvB+vyxNOnLQUxN
         KDCYtWvMBzDHL2ihH/xYkPGABNv0cwjoqc0S7asWIijovrNv2QnNE8pqWaN//YjTxe8C
         UBTA==
X-Forwarded-Encrypted: i=1; AJvYcCV6tXuxU/UTg6xaEsIoA2GLkaZDtWE8cT8CMHBltnJtl9TZaJsU2nr+c+bMGvTCftMf06nQRsdC/LHPh0kWAnLsG2+OWr2/e3vqLI49
X-Gm-Message-State: AOJu0YzP25Uvl1SY55NgP2YNUSpjoF7yrJ0gUcT/45fBKEp0Sw9MS+eV
	tVqpllP/cMF89+91va693Uv8ZzWBOxpfe69oUwBWK7rtqOmFVw5c730ObP5zK2OLSGi0apBTOZn
	MuuPTz6IpuqsvGydFog3KTZpFb6fvpfU2ilyAsE8B7iUSdaA543oimmo=
X-Google-Smtp-Source: AGHT+IFpq2YgC8raP0x54yKDY5xg0XECS9zmji+NkuKFCv0CY4q/EaG/NP9KXFH8rEThEkfEgYY1F44hNnPXSD3wHgDcxeBOgGpj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c952:0:b0:366:923d:ed3c with SMTP id
 i18-20020a92c952000000b00366923ded3cmr43541ilq.3.1710912662016; Tue, 19 Mar
 2024 22:31:02 -0700 (PDT)
Date: Tue, 19 Mar 2024 22:31:02 -0700
In-Reply-To: <942261f7289a391d3baf7ec9a754bc0447960264@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007632a2061410e501@google.com>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
To: eric.vanhensbergen@linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

can't ssh into the instance



failed to run ["ssh" "-p" "22" "-F" "/dev/null" "-o" "UserKnownHostsFile=3D=
/dev/null" "-o" "IdentitiesOnly=3Dyes" "-o" "BatchMode=3Dyes" "-o" "StrictH=
ostKeyChecking=3Dno" "-o" "ConnectTimeout=3D10" "root@10.128.1.150" "pwd"]:=
 exit status 255
ssh: connect to host 10.128.1.150 port 22: Connection timed out
Pseudo-terminal will not be allocated because stdin is not a terminal.
Warning: Permanently added '[us-central1-ssh-serialport.googleapis.com]:960=
0' (RSA) to the list of known hosts.
SeaBIOS (version 1.8.2-google)
Total RAM Size =3D 0x0000000200000000 =3D 8192 MiB
CPUs found: 2     Max CPUs supported: 2
SeaBIOS (version 1.8.2-google)
Machine UUID 98244c28-997c-d970-fe51-cafe56332c7d
found virtio-scsi at 0:3
virtio-scsi vendor=3D'Google' product=3D'PersistentDisk' rev=3D'1' type=3D0=
 removable=3D0
virtio-scsi blksize=3D512 sectors=3D4194304 =3D 2048 MiB
drive 0x000f27c0: PCHS=3D0/0/0 translation=3Dlba LCHS=3D520/128/63 s=3D4194=
304
Sending Seabios boot VM event.
Booting from Hard Disk 0...
[    0.000000][    T0] Linux version 6.8.0-rc1-syzkaller-00012-g22ffa13a3c0=
1 (syzkaller@syzkaller) (Debian clang version 15.0.6, GNU ld (GNU Binutils =
for Debian) 2.40) #0 SMP PREEMPT_DYNAMIC now
[    0.000000][    T0] Command line: BOOT_IMAGE=3D/boot/bzImage root=3D/dev=
/sda1 console=3DttyS0
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbf=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009fff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000ffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000bfffcff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x00000000bfffd000-0x00000000bffffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffbc000-0x00000000fffffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000023ffffff=
f] usable
[    0.000000][    T0] printk: legacy bootconsole [earlyser0] enabled
[    0.000000][    T0] ERROR: earlyprintk=3D earlyser already used
[    0.000000][    T0] ERROR: earlyprintk=3D earlyser already used
[    0.000000][    T0] ****************************************************=
******
[    0.000000][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTIC=
E   **
[    0.000000][    T0] **                                                  =
    **
[    0.000000][    T0] ** This system shows unhashed kernel memory addresse=
s   **
[    0.000000][    T0] ** via the console, logs, and other interfaces. This=
    **
[    0.000000][    T0] ** might reduce the security of your system.        =
    **
[    0.000000][    T0] **                                                  =
    **
[    0.000000][    T0] ** If you see this message and you are not debugging=
    **
[    0.000000][    T0] ** the kernel, report this immediately to your syste=
m   **
[    0.000000][    T0] ** administrator!                                   =
    **
[    0.000000][    T0] **                                                  =
    **
[    0.000000][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTIC=
E   **
[    0.000000][    T0] ****************************************************=
******
[    0.000000][    T0] Malformed early option 'vsyscall'
[    0.000000][    T0] nopcid: PCID feature disabled
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] APIC: serialport: Connected to syzkaller.us-central1=
-c.ci-upstream-kmsan-gce-root-test-job-parallel-2 port 1 (session ID: e82a3=
602d26a155e10b97c8dc3c12b799a7d6f28c67e66690b6dd1b4d8c33ae3, active connect=
ions: 1).
Static calls initialized
[    0.000000][    T0] SMBIOS 2.4 present.
[    0.000000][    T0] DMI: Google Google Compute Engine/Google Compute Eng=
ine, BIOS Google 02/29/2024
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000006][    T0] kvm-clock: using sched offset of 5937164965 cycles
[    0.001237][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max=
_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.004814][    T0] tsc: Detected 2200.220 MHz processor
[    0.014663][    T0] last_pfn =3D 0x240000 max_arch_pfn =3D 0x400000000
[    0.015844][    T0] MTRR map: 4 entries (3 fixed + 1 variable; max 19), =
built from 8 variable MTRRs
[    0.017132][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP=
  UC- WT =20
[    0.018305][    T0] last_pfn =3D 0xbfffd max_arch_pfn =3D 0x400000000
[    0.026836][    T0] found SMP MP-table at [mem 0x000f2a80-0x000f2a8f]
[    0.027980][    T0] Using GB pages for direct mapping
[    0.033174][    T0] ACPI: Early table checksum verification disabled
[    0.034898][    T0] ACPI: RSDP 0x00000000000F2800 000014 (v00 Google)
[    0.036101][    T0] ACPI: RSDT 0x00000000BFFFFFA0 000038 (v01 Google GOO=
GRSDT 00000001 GOOG 00000001)
[    0.037818][    T0] ACPI: FACP 0x00000000BFFFF330 0000F4 (v02 Google GOO=
GFACP 00000001 GOOG 00000001)
[    0.040688][    T0] ACPI: DSDT 0x00000000BFFFD8C0 001A64 (v01 Google GOO=
GDSDT 00000001 GOOG 00000001)
[    0.042664][    T0] ACPI: FACS 0x00000000BFFFD880 000040
[    0.043578][    T0] ACPI: FACS 0x00000000BFFFD880 000040
[    0.044351][    T0] ACPI: SRAT 0x00000000BFFFFE60 0000C8 (v03 Google GOO=
GSRAT 00000001 GOOG 00000001)
[    0.046684][    T0] ACPI: APIC 0x00000000BFFFFDB0 000076 (v05 Google GOO=
GAPIC 00000001 GOOG 00000001)
[    0.048111][    T0] ACPI: SSDT 0x00000000BFFFF430 000980 (v01 Google GOO=
GSSDT 00000001 GOOG 00000001)
[    0.049684][    T0] ACPI: WAET 0x00000000BFFFFE30 000028 (v01 Google GOO=
GWAET 00000001 GOOG 00000001)
[    0.051316][    T0] ACPI: Reserving FACP table memory at [mem 0xbffff330=
-0xbffff423]
[    0.052796][    T0] ACPI: Reserving DSDT table memory at [mem 0xbfffd8c0=
-0xbffff323]
[    0.054251][    T0] ACPI: Reserving FACS table memory at [mem 0xbfffd880=
-0xbfffd8bf]
[    0.057326][    T0] ACPI: Reserving FACS table memory at [mem 0xbfffd880=
-0xbfffd8bf]
[    0.058824][    T0] ACPI: Reserving SRAT table memory at [mem 0xbffffe60=
-0xbfffff27]
[    0.060203][    T0] ACPI: Reserving APIC table memory at [mem 0xbffffdb0=
-0xbffffe25]
[    0.061415][    T0] ACPI: Reserving SSDT table memory at [mem 0xbffff430=
-0xbffffdaf]
[    0.062677][    T0] ACPI: Reserving WAET table memory at [mem 0xbffffe30=
-0xbffffe57]
[    0.064154][    T0] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.065317][    T0] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.066315][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.067376][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.068405][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x23ffffff=
f]
[    0.069822][    T0] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00=
100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.072881][    T0] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x10=
0000000-0x23fffffff] -> [mem 0x00000000-0x23fffffff]
[    0.074935][    T0] Faking node 0 at [mem 0x0000000000000000-0x000000013=
fffffff] (5120MB)
[    0.076263][    T0] Faking node 1 at [mem 0x0000000140000000-0x000000023=
fffffff] (4096MB)
[    0.078438][    T0] NODE_DATA(0) allocated [mem 0x13fffa000-0x13fffffff]
[    0.080018][    T0] NODE_DATA(1) allocated [mem 0x23fff7000-0x23fffcfff]
[    0.104240][    T0] Zone ranges:
[    0.104983][    T0]   DMA      [mem 0x0000000000001000-0x0000000000fffff=
f]
[    0.106799][    T0]   DMA32    [mem 0x0000000001000000-0x00000000fffffff=
f]
[    0.107775][    T0]   Normal   [mem 0x0000000100000000-0x000000023ffffff=
f]
[    0.109311][    T0]   Device   empty
[    0.109927][    T0] Movable zone start for each node
[    0.111401][    T0] Early memory node ranges
[    0.112665][    T0]   node   0: [mem 0x0000000000001000-0x000000000009ef=
ff]
[    0.113948][    T0]   node   0: [mem 0x0000000000100000-0x00000000bfffcf=
ff]
[    0.115931][    T0]   node   0: [mem 0x0000000100000000-0x000000013fffff=
ff]
[    0.117551][    T0]   node   1: [mem 0x0000000140000000-0x000000023fffff=
ff]
[    0.118915][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x00000=
0013fffffff]
[    0.120744][    T0] Initmem setup node 1 [mem 0x0000000140000000-0x00000=
0023fffffff]
[    0.122511][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.124062][    T0] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.255653][    T0] On node 0, zone Normal: 3 pages in unavailable range=
s
[    0.389510][    T0] ACPI: PM-Timer IO Port: 0xb008
[    0.390772][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.391910][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000=
, GSI 0-23
[    0.393482][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high=
 level)
[    0.394556][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)
[    0.395755][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 hi=
gh level)
[    0.396841][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 hi=
gh level)
[    0.398015][    T0] ACPI: Using ACPI (MADT) for SMP configuration inform=
ation
[    0.399103][    T0] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.400346][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
000000-0x00000fff]
[    0.401793][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
09f000-0x0009ffff]
[    0.402955][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
0a0000-0x000effff]
[    0.404185][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
0f0000-0x000fffff]
[    0.406414][    T0] PM: hibernation: Registered nosave memory: [mem 0xbf=
ffd000-0xbfffffff]
[    0.407862][    T0] PM: hibernation: Registered nosave memory: [mem 0xc0=
000000-0xfffbbfff]
[    0.409210][    T0] PM: hibernation: Registered nosave memory: [mem 0xff=
fbc000-0xffffffff]
[    0.410396][    T0] [mem 0xc0000000-0xfffbbfff] available for PCI device=
s
[    0.411464][    T0] Booting paravirtualized kernel on KVM
[    0.412453][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.414424][    T0] setup_percpu: NR_CPUS:8 nr_cpumask_bits:2 nr_cpu_ids=
:2 nr_node_ids:2
[    0.416586][    T0] percpu: Embedded 176 pages/cpu s683016 r8192 d29688 =
u1048576
[    0.418172][    T0] Kernel command line: earlyprintk=3Dserial net.ifname=
s=3D0 sysctl.kernel.hung_task_all_cpu_backtrace=3D1 ima_policy=3Dtcb nf-con=
ntrack-ftp.ports=3D20000 nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.p=
orts=3D20000 nf-conntrack-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000=
 binder.debug_mask=3D0 rcupdate.rcu_expedited=3D1 rcupdate.rcu_cpu_stall_cp=
utime=3D1 no_hash_pointers page_owner=3Don sysctl.vm.nr_hugepages=3D4 sysct=
l.vm.nr_overcommit_hugepages=3D4 secretmem.enable=3D1 sysctl.max_rcu_stall_=
to_panic=3D1 msr.allow_writes=3Doff coredump_filter=3D0xffff root=3D/dev/sd=
a console=3DttyS0 vsyscall=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 sp=
ec_store_bypass_disable=3Dprctl nopcid vivid.n_devs=3D16 vivid.multiplanar=
=3D1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=3D16 rose.rose_ndevs=3D1=
6 smp.csd_lock_timeout=3D100000 watchdog_thresh=3D55 workqueue.watchdog_thr=
esh=3D140 sysctl.net.core.netdev_unregister_timeout_secs=3D140 dummy_hcd.nu=
m=3D8 kmsan.panic=3D1 BOOT_IMAGE=3D/boot/bzImage root=3D/dev/sda1 console=
=3DttyS0
[    0.438759][    T0] Unknown kernel command line parameters "page_owner=
=3Don spec_store_bypass_disable=3Dprctl watchdog_thresh=3D55 BOOT_IMAGE=3D/=
boot/bzImage", will be passed to user space.
[    0.441672][    T0] random: crng init done
[    0.442824][    T0] Fallback order for Node 0: 0 1=20
[    0.442869][    T0] Fallback order for Node 1: 1 0=20
[    0.442885][    T0] Built 2 zonelists, mobility grouping on.  Total page=
s: 2055933
[    0.445747][    T0] Policy zone: Normal
[    0.446410][    T0] mem auto-init: stack:off, heap alloc:off, heap free:=
off
[    0.746915][    T0] stackdepot: allocating hash table via alloc_large_sy=
stem_hash
[    0.748679][    T0] stackdepot hash table entries: 524288 (order: 11, 83=
88608 bytes, linear)
[    0.753267][    T0] software IO TLB: area num 2.
[    0.852827][    T0] Memory: 2290736K/8388204K available (237568K kernel =
code, 9701K rwdata, 18212K rodata, 36392K init, 2524K bss, 1508228K reserve=
d, 0K cma-reserved)
[    0.857739][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPU=
s=3D2, Nodes=3D2
[    0.859241][    T0] Kernel/User page tables isolation: enabled
[    0.860598][    T0] Starting KernelMemorySanitizer
[    0.861422][    T0] ATTENTION: KMSAN is a debugging tool! Do not use it =
on production machines!


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build716133879=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at d615901c7
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd615901c739a765329b688494cee2f8e1b5037cb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240314-145638'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd615901c739a765329b688494cee2f8e1b5037cb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240314-145638'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd615901c739a765329b688494cee2f8e1b5037cb -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240314-145638'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"d615901c739a765329b688494cee2f8e1b=
5037cb\"



Tested on:

commit:         22ffa13a fs/9p: fix uninitialized values during inode ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.g=
it b4/fix-evict-uninitialized-value
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfdd94870bd28165=
1
dashboard link: https://syzkaller.appspot.com/bug?extid=3Deb83fe1cce5833cd6=
6a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.


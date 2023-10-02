Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14407B4B85
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjJBGfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjJBGfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:35:13 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2958BB7
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:35:09 -0700 (PDT)
Received: from [192.168.0.185] (ip5f5ae81f.dynamic.kabel-deutschland.de [95.90.232.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 77A6A61E5FE01;
        Mon,  2 Oct 2023 08:35:00 +0200 (CEST)
Message-ID: <2f44867c-fd9a-4206-949d-54bb036a0337@molgen.mpg.de>
Date:   Mon, 2 Oct 2023 08:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Boot time delays and issues on Dell Latitude 5430 Chromebook
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Steven,


I saw your great talk *The Resurrection of Ureadahead and Speeding up 
the Boot Process and Preloading Applications* [1], and wanted to share 
my findings with the Dell Latitude 5430 Chromebook 
(google/brya/var/crota) running ChromeOS. The login screen is visible 
after around six seconds, which is great compared to other GNU/Linux 
laptop/desktop devices, and probably similar to Microsoft Windows and 
Apple devices. (One second boot time would still be very nice – 0.5 s 
firmware plus 0.5 s Linux/userspace. Systems (CPUs, SSDs) get faster and 
faster, but power-on to graphical login does not.)

### Firmware (unrelated to Linux)

coreboot based firmware takes 1.1 seconds until loading the Linux kernel.¹

```
  990:CSME ROM started execution                        0
  944:CSE sent 'Boot Stall Done' to PMC                 71,000
  945:CSE started to handle ICC configuration           71,000 (0)
  946:CSE sent 'Host BIOS Prep Done' to PMC             73,000 (2,000)
  947:CSE received 'CPU Reset Done Ack sent' from PMC   191,000 (118,000)
    0:1st timestamp                                     226,794 (35,794)
[…]
1101:jumping to kernel                                 1,142,626 (17,740)

Total Time: 1,142,591
```

Cf *google/brya/var/crota: selfboot jump reached after 1.2 s* [2] with a 
different longer run with more details.

### Linux kernel

I created bug #217962 in the Linux Kernel Bugzilla [3] and attached the 
logs there.

This is:

     [    0.000000] Linux version 5.15.124-20278-ga3eed51cfa07 
(chrome-bot@chromeos-release-builder-us-central1-b-x32-14-mesv) 
(Chromium OS 17.0_pre496208_p20230501-r16 clang version 17.0.0 
(/mnt/host/source/src/third_party/llvm-project 
98f5a340975bc00197c57e39eb4ca26e2da0e8a2), LLD 17.0.0) #1 SMP PREEMPT 
Wed Sep 27 18:36:41 PDT 2023

I am listing delays of several tens milliseconds.

All CPUs are brought up after 136 ms. No idea, if Thomas’ work on 
parallel CPU bringup, added to Linux 6.5-rc1 [4], has a positive effect 
on a 12 thread system.

```
[    0.035501] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
[…]
[    0.042149] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.085764] Memory: 16159744K/16617488K available (16396K kernel 
code, 2407K rwdata, 7444K rodata, 1904K init, 912K bss, 457484K 
reserved, 0K cma-reserved)
[    0.086049] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
[    0.086063] ftrace: allocating 53568 entries in 210 pages
[    0.098541] ftrace: allocated 210 pages with 4 groups
[…]
[    0.117600] x86: Booting SMP configuration:
[    0.117600] .... node  #0, CPUs:        #1  #2  #3  #4
[…]
[    0.125757]   #5  #6  #7  #8  #9 #10 #11
[    0.136741] smp: Brought up 1 node, 12 CPUs
```

Linux points out a problem with MTRR settings:

```
[    0.138790] PCI: Using configuration type 1 for base access
[    0.138909] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.138909] mtrr: probably your BIOS does not setup all CPUs.
[    0.138909] mtrr: corrected configuration.
[    0.140504] kprobes: kprobe jump-optimization is enabled. All kprobes 
are optimized if possible.
```

Linux mentions an ACPI error:

```
[    0.141312] ACPI BIOS Error (bug): Failure creating named object 
[\_SB.MPTS], AE_ALREADY_EXISTS (20210730/dswload2-327)
[    0.141317] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog 
(20210730/psobject-220)
[    0.141319] ACPI: Skipping parse of AML opcode: OpcodeName 
unavailable (0x0014)
```

There is a 160 ms delay in ACPI PR00/PR01 power resource logs:

```
[    0.144968] ACPI: PM: Power Resource [RTD3]
[    0.145246] ACPI: PM: Power Resource [PR00]
[    0.308776] ACPI: PM: Power Resource [PR01]
[    0.313974] ACPI: PM: Power Resource [TBT0]
[    0.313981] ACPI: PM: Power Resource [TBT1]
[    0.313989] ACPI: PM: Power Resource [D3C]
[    0.339780] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
```

Another 68 ms delay:

```
[    0.352921] PCI: Using ACPI for IRQ routing
[    0.410211] PCI: pci_cache_line_size set to 64 bytes
```

Another 52 ms jump between Thunderbolt and RAPL PMU message:

```
[    0.432117] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.432118] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.432119] software IO TLB: mapped [mem 
0x000000006e865000-0x0000000076865000] (128MB)
[    0.432129] ACPI: bus type thunderbolt registered
[    0.432140] pci 0000:00:0d.2: attach allowed to drvr thunderbolt 
[internal device]
[    0.483161] pci 0000:00:0d.3: attach allowed to drvr thunderbolt 
[internal device]
[    0.535970] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 
655360 ms ovfl timer
[    0.535972] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    0.535972] RAPL PMU: hw unit of domain package 2^-14 Joules
[    0.535973] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    0.535973] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    0.539576] kvm: already loaded the other module
[    0.539578] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x23fa772cf26, max_idle_ns: 440795269835 ns
[    0.539591] clocksource: Switched to clocksource tsc
```

A 100 ms delay between the cr50_i2c message and intel-lpss message:

```
[    0.570925] i2c_designware i2c_designware.1: using ACPI for GPIO lookup
[    0.570925] acpi device:17: GPIO: looking up scl-gpios
[    0.570926] acpi device:17: GPIO: looking up scl-gpio
[    0.570926] i2c_designware i2c_designware.1: using lookup tables for 
GPIO lookup
[    0.570927] i2c_designware i2c_designware.1: No GPIO consumer scl found
[    0.574609] cr50_i2c i2c-GOOG0005:00: cr50 TPM 2.0 (i2c 0x50 irq 77 
id 0x28)
[    0.682100] pci 0000:00:15.2: attach allowed to drvr intel-lpss 
[internal device]
[    0.693828] intel-lpss 0000:00:15.2: enabling device (0000 -> 0002)

[    0.697641] pci 0000:00:19.0: attach allowed to drvr intel-lpss 
[internal device]
[    0.709862] intel-lpss 0000:00:19.0: enabling device (0000 -> 0002)

[    0.713679] pci 0000:00:1e.3: attach allowed to drvr intel-lpss 
[internal device]
[    0.726207] idma64 idma64.7: Found Intel integrated DMA 64-bit
[    0.729180] pci 0000:01:00.0: attach allowed to drvr nvme [internal 
device]
```

A 60 ms delay before the elan_i2c log message:

```
[    0.790747] device-mapper: init: waiting for all devices to be 
available before creating mapped devices
[    0.792551] cros-ec-spi spi-PRP0001:00: Chrome EC device registered
[    0.859111] elan_i2c i2c-ELAN0000:00: Elan Touchpad: Module ID: 
0x0136, Firmware: 0x0002, Sample: 0x0004, IAP: 0x0003
[    0.859466] input: Elan Touchpad as 
/devices/pci0000:00/0000:00:19.1/i2c_designware.5/i2c-14/i2c-ELAN0000:00/input/input4
```

HuC firmware authentication seems to take 16 ms:

```
[    0.868703] i915 0000:00:02.0: [drm] HuC firmware 
i915/tgl_huc_7.9.3.bin version 7.9.3
[    0.884332] i915 0000:00:02.0: [drm] HuC authenticated
```

A warning, and  init is run after 917 ms. The audit message is shown 
after a delay of 26 ms:

```
[    0.893505] Warning: unable to open an initial console.
[    0.896843] EXT4-fs (dm-0): mounting ext2 file system using the ext4 
subsystem
[    0.897851] EXT4-fs (dm-0): mounted filesystem without journal. Opts: 
(null). Quota mode: none.
[    0.897877] VFS: Mounted root (ext2 filesystem) readonly on device 254:0.
[    0.898928] devtmpfs: mounted
[    0.912316] Freeing unused kernel image (initmem) memory: 1904K
[…]
[    0.917145] Run /sbin/init as init process
[…]
[    0.917151]     xdomain=0
[    0.943534] audit: type=1404 audit(1696062844.825:2): enforcing=1 
old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 
lsm=selinux res=1
```

100 ms pass in the part below:

```
[    0.974761] usb 3-6: new high-speed USB device number 2 using xhci_hcd
[    0.993260] audit: type=1403 audit(1696062844.875:3): auid=4294967295 
ses=4294967295 lsm=selinux res=1
[    1.033591] SELinux:  Context u:object_r:cros_run_pvm_opt:s0 is not 
valid (left unmapped).
[    1.033629] SELinux:  Context u:object_r:cros_run_pvm_opt_pita:s0 is 
not valid (left unmapped).
[    1.034703] audit: type=1400 audit(1696062844.916:4): avc:  granted { 
execute } for  pid=242 comm="sh" name="crash_reporter" dev="dm-0" 
ino=18252 scontext=u:r:cros_init_scripts:s0 
tcontext=u:object_r:cros_crash_reporter_exec:s0 tclass=file
[    1.064252] loop0: detected capacity change from 0 to 1184
[    1.076327] udevd[258]: starting version 225
```

30 ms pass before the USB Webcam device is found, and 60 ms before 
frecon prints a message:

```
[    1.077015] LoadPin: security-policy pinned 
obj="/opt/google/dlc/_trusted_verity_digests" pid=252 
cmdline="chromeos_startup"
[    1.079053] NMI watchdog: Enabled. Permanently consumes one hw-PMU 
counter.
[    1.112522] usb 3-6: New USB device found, idVendor=0c45, 
idProduct=6a1b, bcdDevice=15.11
[    1.112530] usb 3-6: New USB device strings: Mfr=2, Product=1, 
SerialNumber=0
[    1.112533] usb 3-6: Product: Integrated_Webcam_FHD
[    1.112535] usb 3-6: Manufacturer: CKFLF10T0954203AE620
[    1.175154] frecon[536]: Frecon using drm driver i915, version 1.6, 
date(20201103), desc(Intel Graphics) using atomic
[    1.182147] i915 0000:00:02.0: [drm] Finished loading DMC firmware 
i915/adlp_dmc_ver2_16.bin (v2.16)
```

The USB Bluetooth device and Bluetooth stack also takes some time:

```
[    1.233804] usb 3-10: new full-speed USB device number 3 using xhci_hcd
[    1.361528] usb 3-10: New USB device found, idVendor=8087, 
idProduct=0033, bcdDevice= 0.00
[    1.361542] usb 3-10: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[    1.379121] EXT4-fs (dm-5): mounted filesystem with ordered data 
mode. Opts: commit=600,discard. Quota mode: journalled.
[    1.379567] EXT4-fs (nvme0n1p8): mounted filesystem without journal. 
Opts: . Quota mode: none.
[    1.382850] usb 3-6: GPIO lookup for consumer privacy
[    1.382853] usb 3-6: using ACPI for GPIO lookup
[    1.382855] acpi device:2f: GPIO: looking up privacy-gpios
[    1.382857] acpi device:2f: GPIO: looking up privacy-gpio
[    1.382858] usb 3-6: using lookup tables for GPIO lookup
[    1.382859] usb 3-6: No GPIO consumer privacy found
[    1.382860] usb 3-6: Found UVC 1.00 device Integrated_Webcam_FHD 
(0c45:6a1b)
[    1.391519] usbcore: registered new interface driver uvcvideo
[    1.406142] EXT4-fs (dm-5): re-mounted. Opts: . Quota mode: journalled.
[    1.434031] Bluetooth: bt_init() Core ver 2.22
```

ext4 shows a warning, and the audit system logs something 60 ms after 
that. Then init kills process 711, and cros-ec-sensorhup also logs a 
warning(?):

```
[    1.443140] Bluetooth: btintel_prepare_fw_download_tlv() hci0: Found 
device firmware: intel/ibt-0040-0041.sfi
[    1.532713] frecon[536]: Frecon using drm driver i915, version 1.6, 
date(20201103), desc(Intel Graphics) using atomic
[    1.674258] EXT4-fs (dm-7): mounted filesystem with ordered data 
mode. Opts: discard,commit=600. Quota mode: none.
[    1.675920] EXT4-fs warning (device dm-7): ext4_resize_fs:1975: can't 
read last block, resize aborted
[    1.740241] audit: type=1400 audit(1696062845.622:5): avc:  granted { 
execute } for  pid=702 comm="chromeos_startu" name="crash_reporter" 
dev="dm-0" ino=18252 scontext=u:r:chromeos_startup:s0 
tcontext=u:object_r:cros_crash_reporter_exec:s0 tclass=file
[    1.758349] SELinux:  Context u:object_r:cros_modemfwd_file:s0 is not 
valid (left unmapped).
[    1.894270] init: console-ttyS0 main process (711) killed by TERM signal
[    1.955529] usbcore: registered new interface driver r8152
[    1.957885] cros-ec-sensorhub cros-ec-sensorhub.2.auto: no info for 
EC sensor 0 : -22/3
[    2.055032] Intel(R) Wireless WiFi driver for Linux
```

Is that something, Chromium OS cares about and going to look into? My 
gut feeling would say, it’d be a good idea, to move to a newer Linux 
kernel, like 6.1 or 6.6-rc4 first to not analyze already fixed issues. 
Can newer Linux kernels be tested?

What would be your preference, on how to proceed? I bought the Dell 
Chromebook with Chrome OS enterprise to also financially support the 
project.


Kind regards,

Paul


¹ This makes the one second goal moot already.

[1]: https://www.youtube.com/watch?v=HwdWKMxM83E
[2]: 
https://mail.coreboot.org/hyperkitty/list/coreboot@coreboot.org/thread/PVXOCXACTUS5EE3O75QRAH6GIG4MK6I5/
     "google/brya/var/crota: selfboot jump reached after 1.2 s"
[3]: https://bugzilla.kernel.org/show_bug.cgi?id=217962
[4]: 
https://lore.kernel.org/all/168778151245.3634408.4606396781291833683.tglx@vps.praguecc.cz/

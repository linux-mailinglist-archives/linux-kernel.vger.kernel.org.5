Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D8F78BEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjH2HJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjH2HJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:09:03 -0400
X-Greylist: delayed 2036 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 00:08:59 PDT
Received: from torres.zugschlus.de (torres.zugschlus.de [IPv6:2a01:238:42bc:a101::2:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F561A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:08:59 -0700 (PDT)
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
        (envelope-from <mh+linux-kernel@zugschlus.de>)
        id 1qasJZ-002NE5-1h
        for linux-kernel@vger.kernel.org;
        Tue, 29 Aug 2023 08:35:01 +0200
Date:   Tue, 29 Aug 2023 08:35:01 +0200
From:   Marc Haber <mh+linux-kernel@zugschlus.de>
To:     linux-kernel@vger.kernel.org
Subject: Linux 6.5 speed regression, boot VERY slow with anything systemd
 related
Message-ID: <ZO2RlYCDl8kmNHnN@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am always quickly upgrading my fleet to new stable kernels. So I
updated my 9 test machines yesterday and found that one of those test
machines gets abysmally slow after the kernel has finshed the early boot
sequence and control is handed over to systemd.

The boot eventually finishes, but it takes like 50 minutes instead of 30
seconds to get the machine to attach to the network, start up sshd and
to show a login prompt. The machine is a KVM/QEMU VM running on an APU
host ("AMD GX-412TC SOC"). The host is still on 6.4.12, is NOT under
memory or IO pressure, and on the host it looks like the VM is just
taking about 10 % of a single core and happily chugging away.

Others of my test machines are KVM VMs running on different, more
powerful hosts, and those are booting 6.5 just fine, so I guess that the
issue is somehow caused by the APU host. I have upgraded a second VM on
the host in question to Linux 6.5 and that VM exhibits the same
behavior.

This is the tail of the boot messages of the VM on the serial console,
and I am attaching the entirety of the messages under the signature:
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
sr 0:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
cdrom: Uniform CD-ROM driver Revision: 3.20
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
usb 1-1: new high-speed USB device number 2 using ehci-pci
virtio-pci 0000:00:08.0: virtio_pci: leaving for legacy driver
usb 1-1: New USB device found, idVendor=0627, idProduct=0001, bcdDevice= 0.00
usb 1-1: New USB device strings: Mfr=1, Product=3, SerialNumber=5
usb 1-1: Product: QEMU USB Tablet
usb 1-1: Manufacturer: QEMU
virtio-pci 0000:00:09.0: virtio_pci: leaving for legacy driver
usb 1-1: SerialNumber: 42
input: QEMU QEMU USB Tablet as /devices/pci0000:00/0000:00:05.7/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input4
hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v0.01 Mouse [QEMU QEMU USB Tablet] on usb-0000:00:05.7-1/input0
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
virtio-pci 0000:00:0a.0: virtio_pci: leaving for legacy driver
virtio_blk virtio2: 1/0/0 default/read/poll queues
virtio_blk virtio2: [vda] 8388608 512-byte logical blocks (4.29 GB/4.00 GiB)
 vda: vda1 vda2
virtio_blk virtio4: 1/0/0 default/read/poll queues
virtio_net virtio0 ens3: renamed from eth0
virtio_blk virtio4: [vdb] 1048576 512-byte logical blocks (537 MB/512 MiB)
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... done.
Begin: Will now check root file system ... fsck from util-linux 2.38.1
[/sbin/fsck.ext4 (1) -- /dev/vda2] fsck.ext4 -a -C0 /dev/vda2
ronde-root: clean, 41578/262144 files, 405761/1048315 blocks
done.
EXT4-fs (vda2): mounted filesystem 3af5627c-4ed5-4f35-b0b3-60be041708cb ro with ordered data mode. Quota mode: none.
done.
Begin: Running /scripts/local-bottom ... done.
Begin: Running /scripts/init-bottom ... done.
systemd[1]: Inserted module 'autofs4'
random: crng init done
systemd[1]: systemd 252.12-1~deb12u1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
systemd[1]: Detected virtualization kvm.
systemd[1]: Detected architecture x86-64.

Welcome to Debian GNU/Linux 12 (bookworm)!

systemd[1]: Hostname set to <ronde>.
systemd[1]: Queued start job for default target graphical.target.
systemd[1]: Created slice system-getty.slice - Slice /system/getty.

this is the point when things are slowing down horribly, the system is sitting for like 30 seconds for each line.

[  OK  ] Created slice system-getty.slice - Slice /system/getty.systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.

[  OK  ] Created slice system-modpr…lice - Slice /system/modprobe.systemd[1]: Created slice system-radiator.slice - Slice /system/radiator.

[  OK  ] Created slice system-radia…lice - Slice /system/radiator.systemd[1]: Created slice system-serial\x2dgetty.slice - Slice /system/serial-getty.

[  OK  ] Created slice system-seria… - Slice /system/serial-getty.systemd[1]: Created slice user.slice - User and Session Slice.

[  OK  ] Created slice user.slice - User and Session Slice.systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.

[  OK  ] Started systemd-ask-passwo…quests to Console Directory Watch.systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.

[  OK  ] Started systemd-ask-passwo… Requests to Wall Directory Watch.systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.

[  OK  ] Set up automount proc-sys-…rmats File System Automount Point.systemd[1]: Reached target cryptsetup.target - Local Encrypted Volumes.

This looks like systemd is waiting for something to time out, since the
delay is about 30 seconds (as exactly as I can sit tight with a
stopwatch). Going back to kernel 6.4.12 things are fixed immediately.

The VMs in question are running debian bookworm with systemd 252.

When the machine eventually allows a log in, systemctl --failed says
"Failed to query system state: Message recipient disconnected from
message bus without replying", but this fixes itself after another half
an hour or so.

What would you recommend doing to fix this?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

Return-Path: <linux-kernel+bounces-39249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8400A83CD7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC2AB219BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C70F1386B7;
	Thu, 25 Jan 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=danm.net header.i=@danm.net header.b="aJh5JDbJ"
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467063173A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214696; cv=none; b=JUzAatwlR8R67yBTM4h3Cv0o2U3WXaWjw+G9rX09nqiiYbHfNCma277Bz4daR73cVU5B+u3L6AQpgDM0yNLe3WOwSDWJuT+6WjLMdibW4r3I+lXQYQgjGGsk/8yE3M/EI97eJFQU7mJ+jZh2GSbYMIATrE4GL1Tr6w1wCWFR6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214696; c=relaxed/simple;
	bh=KWuEujiSwqfI9VRi73BNOvRpzoPAj0GpZY8VezN3LxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmOMtqAZsap3wWQbYO6CUNXqb2wMMG2j7cEe6NIE1r5WGS4EUpU84nbcfXvr0Z8UbKaBbaw4D/MdKxh0UtF60pw9vG5AmdwSRwoueEsdH3M3RPzed5M7K+Ti0VgIOrkio+DnELCG+9d7wdpxMdAB82euu2knoBufVkEe/jzOZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=aJh5JDbJ; arc=none smtp.client-ip=17.58.23.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1706214693; bh=/j0HbCIzQFJ1o2zcBtU0oIK4Sy7C8oAXHLvwWd9NmCg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=aJh5JDbJAYpllHhe3U70Qyajj8nTerjzp3dpdE8ULAToVvrrS17KVIm4lBrbe11j9
	 5IPOGyZZM8RjfTnwwN1tPo1V+2A5p3gqko8Ab3X7AfuSvFm9bsQnY2Pff5Ydd3hi4r
	 qW4RyL1rn7foQFOA3vJpXppzh3j2li1gH1Nj0W2v9mlFtuTEu9jm/FSDCbXtJ4KW4f
	 hktjOCeDEVBcgZSQEooLyYf+IQoC0X3LxhQPAQ7YzU3eMPGoEb9rt86cmGGTxUtmaV
	 pwJSZz3reawGgCmoRDdS2rdxgNVjG0TrQvpJ/7lv6ApJ/hLPGAJJWd9nWD1+GIHVSC
	 UeYF7ecfGdCAA==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id 32CE06E0313;
	Thu, 25 Jan 2024 20:31:31 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: junxiao.bi@oracle.com
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	song@kernel.org,
	stable@vger.kernel.org,
	yukuai1@huaweicloud.com
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Thu, 25 Jan 2024 13:31:30 -0700
Message-ID: <20240125203130.28187-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2ef7d741-3df8-402a-967f-53ec77c73e2c@oracle.com>
References: <2ef7d741-3df8-402a-967f-53ec77c73e2c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RNTrmQdBS5Qfo15Th5-QehqZSBxNJh4d
X-Proofpoint-ORIG-GUID: RNTrmQdBS5Qfo15Th5-QehqZSBxNJh4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_12,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1030
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401250148

Hi Junxiao,

I first noticed this problem the next day after I had upgraded some
machines to the 6.7.1 kernel. One of the machines is a backup server.
Just a few hours after the upgrade to 6.7.1, it started running its
overnight backup jobs. Those backup jobs hung part way through. When I
tried to check on the backups in the morning, I found the server
mostly unresponsive. I could SSH in but most shell commands would just
hang. I was able to run top and see that the md0_raid5 kernel thread
was using 100% CPU. I tried to reboot the server, but it wasn't able
to successfully shutdown and eventually I had to hard reset it.

The next day, the same sequence of events occurred on that server
again when it tried to run its backup jobs. Then the following day, I
experienced another hang on a different machine, with a similar RAID-5
configuration. That time I was scp'ing a large file to a virtual
machine whose image was stored on the RAID-5 array. Part way through
the transfer scp reported that the transfer had stalled. I checked top
on that machine and found once again that the md0_raid5 kernel thread
was using 100% CPU.

Yesterday I created a fresh Fedora 39 VM for the purposes of
reproducing this problem in a different environment (the other two
machines are both Gentoo servers running v6.7 kernels straight from
the stable trees with a custom kernel configuration). I am able to
reproduce the problem on Fedora 39 running both the v6.6.13 stable
tree kernel code and the Fedora 39 6.6.13 distribution kernel.

On this Fedora 39 VM, I created a 1GiB LVM volume to use as the RAID-5
journal from space on the "boot" disk. Then I attached 3 additional
100 GiB virtual disks and created the RAID-5 from those 3 disks and
the write-journal device. I then created a new LVM volume group from
the md0 array and created one LVM logical volume named "data", using
all but 64GiB of the available VG space. I then created an ext4 file
system on the "data" volume, mounted it, and used "dd" to copy 1MiB
blocks from /dev/urandom to a file on the "data" file system, and just
let it run. Eventually "dd" hangs and top shows that md0_raid5 is
using 100% CPU.

Here is an example command I just ran, which has hung after writing
4.1 GiB of random data to the array:

test@localhost:~$ dd if=/dev/urandom bs=1M of=/data/random.dat status=progress
4410310656 bytes (4.4 GB, 4.1 GiB) copied, 324 s, 13.6 MB/s

Top shows md0_raid5 using 100% CPU and dd in the "D" state:

top - 19:10:07 up 14 min,  1 user,  load average: 7.00, 5.93, 3.30
Tasks: 246 total,   2 running, 244 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us, 12.5 sy,  0.0 ni, 37.5 id, 50.0 wa,  0.0 hi,  0.0 si,  0.0 st 
MiB Mem :   1963.4 total,     81.6 free,    490.7 used,   1560.2 buff/cache     
MiB Swap:   1963.0 total,   1962.5 free,      0.5 used.   1472.7 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
    993 root      20   0       0      0      0 R  99.9   0.0   7:19.08 md0_raid5
   1461 root      20   0       0      0      0 I   0.0   0.0   0:00.17 kworker/1+
     18 root      20   0       0      0      0 I   0.0   0.0   0:00.12 rcu_preem+
   1071 systemd+  20   0   16240   7480   6712 S   0.0   0.4   0:00.22 systemd-o+
   1136 root      20   0  504124  27960  27192 S   0.0   1.4   0:00.26 rsyslogd
      1 root      20   0   75356  27884  10456 S   0.0   1.4   0:01.48 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd
..
   1417 test      20   0  222668   3120   2096 D   0.0   0.2   0:10.45 dd

The dd process stack shows this:

test@localhost:~$ sudo cat /proc/1417/stack
[<0>] do_get_write_access+0x266/0x3f0
[<0>] jbd2_journal_get_write_access+0x5f/0x80
[<0>] __ext4_journal_get_write_access+0x74/0x170
[<0>] ext4_reserve_inode_write+0x61/0xc0
[<0>] __ext4_mark_inode_dirty+0x78/0x240
[<0>] ext4_dirty_inode+0x5b/0x80
[<0>] __mark_inode_dirty+0x57/0x390
[<0>] generic_update_time+0x4e/0x60
[<0>] file_modified+0xa1/0xb0
[<0>] ext4_buffered_write_iter+0x54/0x100
[<0>] vfs_write+0x23b/0x420
[<0>] ksys_write+0x6f/0xf0
[<0>] do_syscall_64+0x5d/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8

I have run that dd test in the VM several times (I have to power cycle
the VM in between tests since each time it hangs it won't successfully
reboot). I also tested creating a LVM snapshot of the "data" LV while
the "dd" is running and from the few runs I've done it seems it might
reproduce more easily when the LVM snapshot exists (the snapshot would
act as a write amplifier since it is performing a copy-on-write
operation when dd is writing to the data LV and perhaps that helps to
induce the problem). However, the backup server I mentioned above does
not utilize LVM snapshots, so I know that an LVM snapshot isn't
required to cause the problem.

Below I will include a (hopefully) complete description of how this VM
is configured which might aid in efforts to reproduce the problem.

I hope this helps to undertand the nature of the problem, and may be
of assistance in diagnosing or reproducing the issue.

-- Dan


test@localhost:~$ ls -ld /sys/block/sd*
lrwxrwxrwx. 1 root root 0 Jan 25 19:59 /sys/block/sda -> ../devices/pci0000:00/0000:00:02.2/0000:03:00.0/virtio2/host6/target6:0:0/6:0:0:0/block/sda
lrwxrwxrwx. 1 root root 0 Jan 25 19:59 /sys/block/sdb -> ../devices/pci0000:00/0000:00:02.2/0000:03:00.0/virtio2/host6/target6:0:0/6:0:0:4/block/sdb
lrwxrwxrwx. 1 root root 0 Jan 25 19:59 /sys/block/sdc -> ../devices/pci0000:00/0000:00:02.2/0000:03:00.0/virtio2/host6/target6:0:0/6:0:0:3/block/sdc
lrwxrwxrwx. 1 root root 0 Jan 25 19:59 /sys/block/sdd -> ../devices/pci0000:00/0000:00:02.2/0000:03:00.0/virtio2/host6/target6:0:0/6:0:0:2/block/sdd
lrwxrwxrwx. 1 root root 0 Jan 25 19:59 /sys/block/sde -> ../devices/pci0000:00/0000:00:02.2/0000:03:00.0/virtio2/host6/target6:0:0/6:0:0:1/block/sde




test@localhost:~$ sudo fdisk -l /dev/sd[a,b,c,d,e]
Disk /dev/sda: 32 GiB, 34359738368 bytes, 67108864 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 3B52A5A1-29BD-436B-8145-EEF27D9EFC97

Device        Start      End  Sectors Size Type
/dev/sda1      2048     4095     2048   1M BIOS boot
/dev/sda2      4096  2101247  2097152   1G Linux filesystem
/dev/sda3   2101248 14678015 12576768   6G Linux LVM
/dev/sda4  14678016 16777215  2099200   1G Linux LVM
/dev/sda5  16777216 67106815 50329600  24G Linux LVM


Disk /dev/sdb: 32 GiB, 34359738368 bytes, 67108864 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdc: 100 GiB, 107374182400 bytes, 209715200 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdd: 100 GiB, 107374182400 bytes, 209715200 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sde: 100 GiB, 107374182400 bytes, 209715200 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes




test@localhost:~$ cat /proc/mdstat
Personalities : [raid6] [raid5] [raid4] 
md0 : active raid5 dm-1[0](J) sdd[4] sde[3] sdc[1]
      209711104 blocks super 1.2 level 5, 512k chunk, algorithm 2 [3/3] [UUU]
      
unused devices: <none>




test@localhost:~$ sudo pvs
  PV         VG      Fmt  Attr PSize   PFree
  /dev/md0   array   lvm2 a--  199.99g    0 
  /dev/sda3  sysvg   lvm2 a--   <6.00g    0 
  /dev/sda4  journal lvm2 a--    1.00g    0 
  /dev/sda5  sysvg   lvm2 a--  <24.00g    0 
  /dev/sdb   sysvg   lvm2 a--  <32.00g    0 




test@localhost:~$ sudo vgs
  VG      #PV #LV #SN Attr   VSize   VFree 
  array     1   1   0 wz--n- 199.99g 63.99g
  journal   1   1   0 wz--n-   1.00g     0 
  sysvg     3   1   0 wz--n- <61.99g     0 




test@localhost:~$ sudo lvs
  LV      VG      Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  data    array   -wi-ao---- 136.00g                                                    
  journal journal -wi-ao----   1.00g                                                    
  root    sysvg   -wi-ao---- <61.99g                                                    




test@localhost:~$ sudo blkid
/dev/mapper/journal-journal: UUID="3e3379f6-ef7a-6bd4-adc1-1c00e328a556" UUID_SUB="446d19c8-d56c-6938-a82f-ff8d52ba1772" LABEL="localhost.localdomain:0" TYPE="linux_raid_member"
/dev/sdd: UUID="3e3379f6-ef7a-6bd4-adc1-1c00e328a556" UUID_SUB="5ab8d465-102a-d333-b1fa-012bd73d7cf5" LABEL="localhost.localdomain:0" TYPE="linux_raid_member"
/dev/sdb: UUID="Gj7d9g-LgcN-LLVl-iv37-DFZy-U0mz-s5nt3e" TYPE="LVM2_member"
/dev/md0: UUID="LcJ3i3-8Gfc-vs1g-ZNZc-8m0G-bPI3-l87W4X" TYPE="LVM2_member"
/dev/mapper/sysvg-root: LABEL="sysroot" UUID="22b0112a-6f38-41d6-921e-2492a19008f0" BLOCK_SIZE="512" TYPE="xfs"
/dev/sde: UUID="3e3379f6-ef7a-6bd4-adc1-1c00e328a556" UUID_SUB="171616cc-ce88-94be-affe-00933b8a7a30" LABEL="localhost.localdomain:0" TYPE="linux_raid_member"
/dev/sdc: UUID="3e3379f6-ef7a-6bd4-adc1-1c00e328a556" UUID_SUB="6d28b122-c1b6-973d-f8df-0834756581f0" LABEL="localhost.localdomain:0" TYPE="linux_raid_member"
/dev/sda4: UUID="ceH3kP-hljE-T6q4-W2qI-Iutm-Vf2N-Uz4omD" TYPE="LVM2_member" PARTUUID="2ed40d4b-f8b2-4c86-b8ca-61216a0c3f48"
/dev/sda2: UUID="c2192edb-0767-464b-9c3a-29d2d8e11c6e" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="effdb052-4887-4571-84df-5c5df132d702"
/dev/sda5: UUID="MEAcyI-qQwk-shwO-Y8qv-EFGa-ggpm-t6NhAV" TYPE="LVM2_member" PARTUUID="343aa231-9f62-46e2-b412-66640d153840"
/dev/sda3: UUID="yKUg0d-XqD2-5IEA-GFkd-6kDc-jVLz-cntwkj" TYPE="LVM2_member" PARTUUID="0dfa0e2d-f467-4e26-b013-9c965ed5a95c"
/dev/zram0: LABEL="zram0" UUID="5087ad0b-ec76-4de7-bbeb-7f39dd1ae318" TYPE="swap"
/dev/mapper/array-data: UUID="fcb29d49-5546-487f-9620-18afb0eeee90" BLOCK_SIZE="4096" TYPE="ext4"
/dev/sda1: PARTUUID="93d0bf6a-463d-4a2a-862f-0a4026964d54"




test@localhost:~$ lsblk -i
NAME                MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
sda                   8:0    0   32G  0 disk  
|-sda1                8:1    0    1M  0 part  
|-sda2                8:2    0    1G  0 part  /boot
|-sda3                8:3    0    6G  0 part  
| `-sysvg-root      253:0    0   62G  0 lvm   /
|-sda4                8:4    0    1G  0 part  
| `-journal-journal 253:1    0    1G  0 lvm   
|   `-md0             9:0    0  200G  0 raid5 
|     `-array-data  253:3    0  136G  0 lvm   /data
`-sda5                8:5    0   24G  0 part  
  `-sysvg-root      253:0    0   62G  0 lvm   /
sdb                   8:16   0   32G  0 disk  
`-sysvg-root        253:0    0   62G  0 lvm   /
sdc                   8:32   0  100G  0 disk  
`-md0                 9:0    0  200G  0 raid5 
  `-array-data      253:3    0  136G  0 lvm   /data
sdd                   8:48   0  100G  0 disk  
`-md0                 9:0    0  200G  0 raid5 
  `-array-data      253:3    0  136G  0 lvm   /data
sde                   8:64   0  100G  0 disk  
`-md0                 9:0    0  200G  0 raid5 
  `-array-data      253:3    0  136G  0 lvm   /data
zram0               252:0    0  1.9G  0 disk  [SWAP]




test@localhost:~$ findmnt --ascii
TARGET                         SOURCE                 FSTYPE      OPTIONS
/                              /dev/mapper/sysvg-root xfs         rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota
|-/dev                         devtmpfs               devtmpfs    rw,nosuid,seclabel,size=4096k,nr_inodes=245904,mode=755,inode64
| |-/dev/hugepages             hugetlbfs              hugetlbfs   rw,nosuid,nodev,relatime,seclabel,pagesize=2M
| |-/dev/mqueue                mqueue                 mqueue      rw,nosuid,nodev,noexec,relatime,seclabel
| |-/dev/shm                   tmpfs                  tmpfs       rw,nosuid,nodev,seclabel,inode64
| `-/dev/pts                   devpts                 devpts      rw,nosuid,noexec,relatime,seclabel,gid=5,mode=620,ptmxmode=000
|-/sys                         sysfs                  sysfs       rw,nosuid,nodev,noexec,relatime,seclabel
| |-/sys/fs/selinux            selinuxfs              selinuxfs   rw,nosuid,noexec,relatime
| |-/sys/kernel/debug          debugfs                debugfs     rw,nosuid,nodev,noexec,relatime,seclabel
| |-/sys/kernel/tracing        tracefs                tracefs     rw,nosuid,nodev,noexec,relatime,seclabel
| |-/sys/fs/fuse/connections   fusectl                fusectl     rw,nosuid,nodev,noexec,relatime
| |-/sys/kernel/security       securityfs             securityfs  rw,nosuid,nodev,noexec,relatime
| |-/sys/fs/cgroup             cgroup2                cgroup2     rw,nosuid,nodev,noexec,relatime,seclabel,nsdelegate,memory_recursiveprot
| |-/sys/fs/pstore             pstore                 pstore      rw,nosuid,nodev,noexec,relatime,seclabel
| |-/sys/fs/bpf                bpf                    bpf         rw,nosuid,nodev,noexec,relatime,mode=700
| `-/sys/kernel/config         configfs               configfs    rw,nosuid,nodev,noexec,relatime
|-/proc                        proc                   proc        rw,nosuid,nodev,noexec,relatime
| `-/proc/sys/fs/binfmt_misc   systemd-1              autofs      rw,relatime,fd=34,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=8800
|   `-/proc/sys/fs/binfmt_misc binfmt_misc            binfmt_misc rw,nosuid,nodev,noexec,relatime
|-/run                         tmpfs                  tmpfs       rw,nosuid,nodev,seclabel,size=402112k,nr_inodes=819200,mode=755,inode64
| `-/run/user/1000             tmpfs                  tmpfs       rw,nosuid,nodev,relatime,seclabel,size=201056k,nr_inodes=50264,mode=700,uid=1000,gid=1000,inode64
|-/tmp                         tmpfs                  tmpfs       rw,nosuid,nodev,seclabel,nr_inodes=1048576,inode64
|-/boot                        /dev/sda2              ext4        rw,relatime,seclabel
|-/data                        /dev/mapper/array-data ext4        rw,relatime,seclabel,stripe=256
`-/var/lib/nfs/rpc_pipefs      sunrpc                 rpc_pipefs  rw,relatime




(On virtual machine host)
$ sudo virsh dumpxml raid5-test-Fedora-Server-39-x86_64
<domain type='kvm' id='48'>
  <name>raid5-test-Fedora-Server-39-x86_64</name>
  <uuid>abb4cad1-35a4-4209-9da1-01e1cf3463da</uuid>
  <metadata>
    <libosinfo:libosinfo xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
      <libosinfo:os id="http://fedoraproject.org/fedora/38"/>
    </libosinfo:libosinfo>
  </metadata>
  <memory unit='KiB'>2097152</memory>
  <currentMemory unit='KiB'>2097152</currentMemory>
  <vcpu placement='static'>8</vcpu>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch='x86_64' machine='pc-q35-8.0'>hvm</type>
    <boot dev='hd'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <vmport state='off'/>
  </features>
  <cpu mode='host-passthrough' check='none' migratable='on'/>
  <clock offset='utc'>
    <timer name='rtc' tickpolicy='catchup'/>
    <timer name='pit' tickpolicy='delay'/>
    <timer name='hpet' present='no'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <pm>
    <suspend-to-mem enabled='no'/>
    <suspend-to-disk enabled='no'/>
  </pm>
  <devices>
    <emulator>/usr/bin/qemu-system-x86_64</emulator>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/raid5-test-Fedora-Server-39-x86_64.qcow2' index='5'/>
      <backingStore/>
      <target dev='sda' bus='scsi'/>
      <alias name='scsi0-0-0-0'/>
      <address type='drive' controller='0' bus='0' target='0' unit='0'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/raid5-test-Fedora-Server-39-x86_64-raid-1.qcow2' index='4'/>
      <backingStore/>
      <target dev='sdb' bus='scsi'/>
      <alias name='scsi0-0-0-1'/>
      <address type='drive' controller='0' bus='0' target='0' unit='1'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/raid5-test-Fedora-Server-39-x86_64-raid-2.qcow2' index='3'/>
      <backingStore/>
      <target dev='sdc' bus='scsi'/>
      <alias name='scsi0-0-0-2'/>
      <address type='drive' controller='0' bus='0' target='0' unit='2'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/raid5-test-Fedora-Server-39-x86_64-raid-3.qcow2' index='2'/>
      <backingStore/>
      <target dev='sdd' bus='scsi'/>
      <alias name='scsi0-0-0-3'/>
      <address type='drive' controller='0' bus='0' target='0' unit='3'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/raid5-test-Fedora-Server-39-x86_64-1.qcow2' index='1'/>
      <backingStore/>
      <target dev='sde' bus='scsi'/>
      <alias name='scsi0-0-0-4'/>
      <address type='drive' controller='0' bus='0' target='0' unit='4'/>
    </disk>
    <controller type='usb' index='0' model='qemu-xhci' ports='15'>
      <alias name='usb'/>
      <address type='pci' domain='0x0000' bus='0x02' slot='0x00' function='0x0'/>
    </controller>
    <controller type='pci' index='0' model='pcie-root'>
      <alias name='pcie.0'/>
    </controller>
    <controller type='pci' index='1' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='1' port='0x10'/>
      <alias name='pci.1'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0' multifunction='on'/>
    </controller>
    <controller type='pci' index='2' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='2' port='0x11'/>
      <alias name='pci.2'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x1'/>
    </controller>
    <controller type='pci' index='3' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='3' port='0x12'/>
      <alias name='pci.3'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x2'/>
    </controller>
    <controller type='pci' index='4' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='4' port='0x13'/>
      <alias name='pci.4'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x3'/>
    </controller>
    <controller type='pci' index='5' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='5' port='0x14'/>
      <alias name='pci.5'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x4'/>
    </controller>
    <controller type='pci' index='6' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='6' port='0x15'/>
      <alias name='pci.6'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x5'/>
    </controller>
    <controller type='pci' index='7' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='7' port='0x16'/>
      <alias name='pci.7'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x6'/>
    </controller>
    <controller type='pci' index='8' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='8' port='0x17'/>
      <alias name='pci.8'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x7'/>
    </controller>
    <controller type='pci' index='9' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='9' port='0x18'/>
      <alias name='pci.9'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0' multifunction='on'/>
    </controller>
    <controller type='pci' index='10' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='10' port='0x19'/>
      <alias name='pci.10'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x1'/>
    </controller>
    <controller type='pci' index='11' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='11' port='0x1a'/>
      <alias name='pci.11'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x2'/>
    </controller>
    <controller type='pci' index='12' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='12' port='0x1b'/>
      <alias name='pci.12'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x3'/>
    </controller>
    <controller type='pci' index='13' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='13' port='0x1c'/>
      <alias name='pci.13'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x4'/>
    </controller>
    <controller type='pci' index='14' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='14' port='0x1d'/>
      <alias name='pci.14'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x5'/>
    </controller>
    <controller type='scsi' index='0' model='virtio-scsi'>
      <alias name='scsi0'/>
      <address type='pci' domain='0x0000' bus='0x03' slot='0x00' function='0x0'/>
    </controller>
    <controller type='sata' index='0'>
      <alias name='ide'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1f' function='0x2'/>
    </controller>
    <controller type='virtio-serial' index='0'>
      <alias name='virtio-serial0'/>
      <address type='pci' domain='0x0000' bus='0x04' slot='0x00' function='0x0'/>
    </controller>
    <interface type='network'>
      <mac address='52:54:00:01:a7:85'/>
      <source network='default' portid='2f054bc0-bdd3-4431-9a7f-f57c84313f0d' bridge='virbr0'/>
      <target dev='vnet47'/>
      <model type='virtio'/>
      <alias name='net0'/>
      <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
    </interface>
    <serial type='pty'>
      <source path='/dev/pts/9'/>
      <target type='isa-serial' port='0'>
        <model name='isa-serial'/>
      </target>
      <alias name='serial0'/>
    </serial>
    <console type='pty' tty='/dev/pts/9'>
      <source path='/dev/pts/9'/>
      <target type='serial' port='0'/>
      <alias name='serial0'/>
    </console>
    <channel type='unix'>
      <source mode='bind' path='/run/libvirt/qemu/channel/48-raid5-test-Fedora-Se/org.qemu.guest_agent.0'/>
      <target type='virtio' name='org.qemu.guest_agent.0' state='connected'/>
      <alias name='channel0'/>
      <address type='virtio-serial' controller='0' bus='0' port='1'/>
    </channel>
    <channel type='spicevmc'>
      <target type='virtio' name='com.redhat.spice.0' state='disconnected'/>
      <alias name='channel1'/>
      <address type='virtio-serial' controller='0' bus='0' port='2'/>
    </channel>
    <input type='tablet' bus='usb'>
      <alias name='input0'/>
      <address type='usb' bus='0' port='1'/>
    </input>
    <input type='mouse' bus='ps2'>
      <alias name='input1'/>
    </input>
    <input type='keyboard' bus='ps2'>
      <alias name='input2'/>
    </input>
    <graphics type='spice' port='5902' autoport='yes' listen='127.0.0.1'>
      <listen type='address' address='127.0.0.1'/>
      <image compression='off'/>
    </graphics>
    <sound model='ich9'>
      <alias name='sound0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1b' function='0x0'/>
    </sound>
    <audio id='1' type='spice'/>
    <video>
      <model type='virtio' heads='1' primary='yes'/>
      <alias name='video0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x0'/>
    </video>
    <redirdev bus='usb' type='spicevmc'>
      <alias name='redir0'/>
      <address type='usb' bus='0' port='2'/>
    </redirdev>
    <redirdev bus='usb' type='spicevmc'>
      <alias name='redir1'/>
      <address type='usb' bus='0' port='3'/>
    </redirdev>
    <watchdog model='itco' action='reset'>
      <alias name='watchdog0'/>
    </watchdog>
    <memballoon model='virtio'>
      <stats period='5'/>
      <alias name='balloon0'/>
      <address type='pci' domain='0x0000' bus='0x05' slot='0x00' function='0x0'/>
    </memballoon>
    <rng model='virtio'>
      <backend model='random'>/dev/urandom</backend>
      <alias name='rng0'/>
      <address type='pci' domain='0x0000' bus='0x06' slot='0x00' function='0x0'/>
    </rng>
  </devices>
  <seclabel type='dynamic' model='dac' relabel='yes'>
    <label>+77:+77</label>
    <imagelabel>+77:+77</imagelabel>
  </seclabel>
</domain>


Return-Path: <linux-kernel+bounces-54383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F31084AE9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A35D1C2134E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D7C128837;
	Tue,  6 Feb 2024 07:04:38 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF8128803;
	Tue,  6 Feb 2024 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203049; cv=none; b=qgmzIuJQjIxrx5iX6F7BdxcELGgnPzdvw48ecXQbtFo2tPnPyUZ9iVKwwuUY1szG8qq0kYQgU/zmQXZy3+3Hp2vrdzb7MJZQ6R7FDQJH6tYQ6l++QzCCxWw0ZzWtlGT6jnrxeFKNrlmaefnMPPzy0Au59Qpq/myC91KUqNNqM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203049; c=relaxed/simple;
	bh=SZ2iu4bcwpODq54MJErXLQIzgA6iTGNsMNyyToB/daw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZFknWkHWNY+30dyiux7l65qnYjEqDe6uGdcHWXundJOrmj9hLcShP6Cdfu/Hc9fn/qri8/jMPXjcRz/RM/f49ONVLl2/TRXIfLN/vOtI2r0JMQL3F22tuEVz0RmJwbyRdXCTZiiYBCGpTOHchsNubq1gBSNr/4PhwEcYQSO9mU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TTZ36315Xz4f3kFt;
	Tue,  6 Feb 2024 15:03:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BA0D61A027B;
	Tue,  6 Feb 2024 15:03:34 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RHD2cFlE6KHDA--.28611S3;
	Tue, 06 Feb 2024 15:03:33 +0800 (CST)
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
To: Benjamin Marzinski <bmarzins@redhat.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, xni@redhat.com,
 blazej.kucman@linux.intel.com, agk@redhat.com, snitzer@kernel.org,
 dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com,
 neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <Zb2wxIpf7uYV6Vya@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <528ce926-6f17-c1ea-8e77-c7d5d7f56022@huaweicloud.com>
 <ZcE4mGXCDwjqBXgf@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <1fdbfcf8-1ee9-4079-e84e-6e2c1121491b@huaweicloud.com>
 <ZcGuRIrZJaEtXjPh@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7b948d27-2ae0-499c-5841-bd28a546197b@huaweicloud.com>
Date: Tue, 6 Feb 2024 15:03:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcGuRIrZJaEtXjPh@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RHD2cFlE6KHDA--.28611S3
X-Coremail-Antispam: 1UD129KBjvAXoWkXFykCw47AryxWFWxtFWkZwb_yoWDuw15Go
	ZxCr4I9ayjgr45urnFyF4fG3yfAwnIvF4UXr48Wr4Fka17JF4qkr9ava17Xw1IqasYq347
	u3Z8trW3AF47tw1xn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5P7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/06 11:57, Benjamin Marzinski 写道:
> On Tue, Feb 06, 2024 at 09:36:18AM +0800, Yu Kuai wrote:
>> Hi!
>>
>> 在 2024/02/06 3:35, Benjamin Marzinski 写道:
>>> Could you run the test with something like
>>>
>>> # make check_local T=lvconvert-repair-raid.sh VERBOSE=1 > out 2>&1
>>>
>>> and post the output.
>>
>> Attached is the output from my VM.
> 
> Instead of running the tests from the lvm2 git repo, if you run
> 
> # make -C test install
> 
> to install the tests, and then create a results directory and run the
> test from there, do you still see the error in the 6.6 kernel?
> 
> # make ~/results
> # cd ~/results
> # lvm2-testsuite --only lvconvert-repair-raid.sh

I tried this and test result is still the same. :(

Thanks,
Kuai

> 
> Running the tests this way will test the installed lvm2 binaries on your
> system, instead of the ones in the lvm2 git repo. They may be compiled
> differently.
> 
> -Ben
> 
>>
>> Thanks,
>> Kuai
>>
>>>
>>> -Ben
> 
>> make -C libdm device-mapper
>> make[1]: Entering directory '/mnt/test/lvm2/libdm'
>> make[1]: Nothing to be done for 'device-mapper'.
>> make[1]: Leaving directory '/mnt/test/lvm2/libdm'
>> make -C conf device-mapper
>> make[1]: Entering directory '/mnt/test/lvm2/conf'
>> make[1]: Nothing to be done for 'device-mapper'.
>> make[1]: Leaving directory '/mnt/test/lvm2/conf'
>> make -C daemons device-mapper
>> make[1]: Entering directory '/mnt/test/lvm2/daemons'
>> make[1]: Nothing to be done for 'device-mapper'.
>> make[1]: Leaving directory '/mnt/test/lvm2/daemons'
>> make -C include device-mapper
>> make[1]: Entering directory '/mnt/test/lvm2/include'
>> make[1]: Nothing to be done for 'device-mapper'.
>> make[1]: Leaving directory '/mnt/test/lvm2/include'
>> make -C lib device-mapper
>> make[1]: Entering directory '/mnt/test/lvm2/lib'
>> make[1]: Nothing to be done for 'device-mapper'.
>> make[1]: Leaving directory '/mnt/test/lvm2/lib'
>> make -C libdaemon device-mapper
>> make[1]: Entering directory '/mnt/test/lvm2/libdaemon'
>> make[1]: Nothing to be done for 'device-mapper'.
>> make[1]: Leaving directory '/mnt/test/lvm2/libdaemon'
>> make -C man device-mapper
>> make[1]: Entering directory '/mnt/test/lvm2/man'
>> make[1]: Nothing to be done for 'device-mapper'.
>> make[1]: Leaving directory '/mnt/test/lvm2/man'
>> make -C scripts device-mapper
>> make[1]: Entering directory '/mnt/test/lvm2/scripts'
>> make[1]: Nothing to be done for 'device-mapper'.
>> make[1]: Leaving directory '/mnt/test/lvm2/scripts'
>> make -C tools device-mapper
>> make[1]: Entering directory '/mnt/test/lvm2/tools'
>> make[1]: Nothing to be done for 'device-mapper'.
>> make[1]: Leaving directory '/mnt/test/lvm2/tools'
>> make -C include
>> make[1]: Entering directory '/mnt/test/lvm2/include'
>> make[1]: Nothing to be done for 'all'.
>> make[1]: Leaving directory '/mnt/test/lvm2/include'
>> make -C libdaemon
>> make[1]: Entering directory '/mnt/test/lvm2/libdaemon'
>> make -C client device-mapper
>> make[2]: Entering directory '/mnt/test/lvm2/libdaemon/client'
>> make[2]: Nothing to be done for 'device-mapper'.
>> make[2]: Leaving directory '/mnt/test/lvm2/libdaemon/client'
>> make -C client
>> make[2]: Entering directory '/mnt/test/lvm2/libdaemon/client'
>> make[2]: Nothing to be done for 'all'.
>> make[2]: Leaving directory '/mnt/test/lvm2/libdaemon/client'
>> make[1]: Leaving directory '/mnt/test/lvm2/libdaemon'
>> make -C lib
>> make[1]: Entering directory '/mnt/test/lvm2/lib'
>> make[1]: Nothing to be done for 'all'.
>> make[1]: Leaving directory '/mnt/test/lvm2/lib'
>> make -C tools
>> make[1]: Entering directory '/mnt/test/lvm2/tools'
>> make[1]: Nothing to be done for 'all'.
>> make[1]: Leaving directory '/mnt/test/lvm2/tools'
>> make -C daemons
>> make[1]: Entering directory '/mnt/test/lvm2/daemons'
>> make[1]: Nothing to be done for 'all'.
>> make[1]: Leaving directory '/mnt/test/lvm2/daemons'
>> make -C test check_local
>> make[1]: Entering directory '/mnt/test/lvm2/test'
>> VERBOSE=1 ./lib/runner \
>> 	--testdir . --outdir results \
>> 	--flavours ndev-vanilla --only lvconvert-repair-raid.sh --skip @
>> running 1 tests
>>
>> [ 0:01.044] Library version:   1.02.198-git (2023-11-21)
>> [ 0:01.044] Driver version:    4.48.0
>> [ 0:01.044] Kernel is Linux fedora 6.8.0-rc1+ #991 SMP PREEMPT_DYNAMIC Tue Feb  6 09:01:00 CST 2024 x86_64 x86_64 x86_64 GNU/Linux
>> [ 0:01.191] Selinux mode is Disabled.
>> [ 0:01.262]                total        used        free      shared  buff/cache   available
>> [ 0:01.327] Mem:            6753         477        4298           0        1977        6007
>> [ 0:01.327] Swap:              0           0           0
>> [ 0:01.327] Filesystem      Size  Used Avail Use% Mounted on
>> [ 0:01.380] /dev/root        20G   11G  9.4G  54% /
>> [ 0:01.380] devtmpfs        3.3G     0  3.3G   0% /dev
>> [ 0:01.380] tmpfs           3.3G     0  3.3G   0% /dev/shm
>> [ 0:01.380] tmpfs           1.4G  944K  1.4G   1% /run
>> [ 0:01.380] tmpfs           4.0M     0  4.0M   0% /sys/fs/cgroup
>> [ 0:01.380] tmpfs           3.3G     0  3.3G   0% /tmp
>> [ 0:01.380] modules          14T   12T  2.8T  81% /tmp/modules
>> [ 0:01.380] tmpfs           676M     0  676M   0% /run/user/0
>> [ 0:01.380] /dev/nvme0n1     10G  6.1G  4.0G  61% /mnt/test
>> [ 0:01.380] @TESTDIR=/mnt/test/LVMTEST14057.I4CHaFJWdP
>> [ 0:01.386] @PREFIX=LVMTEST14057
>> [ 0:01.386] ## LVMCONF: activation {
>> [ 0:01.700] ## LVMCONF:     checks = 1
>> [ 0:01.700] ## LVMCONF:     monitoring = 0
>> [ 0:01.700] ## LVMCONF:     polling_interval = 1
>> [ 0:01.700] ## LVMCONF:     raid_region_size = 512
>> [ 0:01.700] ## LVMCONF:     retry_deactivation = 1
>> [ 0:01.700] ## LVMCONF:     snapshot_autoextend_percent = 50
>> [ 0:01.700] ## LVMCONF:     snapshot_autoextend_threshold = 50
>> [ 0:01.700] ## LVMCONF:     udev_rules = 1
>> [ 0:01.700] ## LVMCONF:     udev_sync = 1
>> [ 0:01.700] ## LVMCONF:     verify_udev_operations = 1
>> [ 0:01.700] ## LVMCONF: }
>> [ 0:01.700] ## LVMCONF: allocation {
>> [ 0:01.700] ## LVMCONF:     vdo_slab_size_mb = 128
>> [ 0:01.700] ## LVMCONF:     wipe_signatures_when_zeroing_new_lvs = 0
>> [ 0:01.700] ## LVMCONF:     zero_metadata = 0
>> [ 0:01.700] ## LVMCONF: }
>> [ 0:01.700] ## LVMCONF: backup {
>> [ 0:01.700] ## LVMCONF:     archive = 0
>> [ 0:01.700] ## LVMCONF:     backup = 0
>> [ 0:01.700] ## LVMCONF: }
>> [ 0:01.700] ## LVMCONF: devices {
>> [ 0:01.700] ## LVMCONF:     cache_dir = "/mnt/test/LVMTEST14057.I4CHaFJWdP/etc"
>> [ 0:01.700] ## LVMCONF:     default_data_alignment = 1
>> [ 0:01.700] ## LVMCONF:     dir = "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev"
>> [ 0:01.700] ## LVMCONF:     filter = "a|.*|"
>> [ 0:01.700] ## LVMCONF:     global_filter = [ "a|/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057.*pv[0-9_]*$|", "r|.*|" ]
>> [ 0:01.700] ## LVMCONF:     md_component_detection = 0
>> [ 0:01.700] ## LVMCONF:     scan = "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev"
>> [ 0:01.700] ## LVMCONF:     sysfs_scan = 1
>> [ 0:01.700] ## LVMCONF:     use_devicesfile = 0
>> [ 0:01.700] ## LVMCONF:     write_cache_state = 0
>> [ 0:01.700] ## LVMCONF: }
>> [ 0:01.700] ## LVMCONF: dmeventd {
>> [ 0:01.700] ## LVMCONF:     executable = "/mnt/test/lvm2/test/lib/dmeventd"
>> [ 0:01.700] ## LVMCONF: }
>> [ 0:01.700] ## LVMCONF: global {
>> [ 0:01.700] ## LVMCONF:     abort_on_internal_errors = 1
>> [ 0:01.700] ## LVMCONF:     cache_check_executable = "/usr/sbin/cache_check"
>> [ 0:01.700] ## LVMCONF:     cache_dump_executable = "/usr/sbin/cache_dump"
>> [ 0:01.700] ## LVMCONF:     cache_repair_executable = "/usr/sbin/cache_repair"
>> [ 0:01.700] ## LVMCONF:     cache_restore_executable = "/usr/sbin/cache_restore"
>> [ 0:01.700] ## LVMCONF:     detect_internal_vg_cache_corruption = 1
>> [ 0:01.700] ## LVMCONF:     etc = "/mnt/test/LVMTEST14057.I4CHaFJWdP/etc"
>> [ 0:01.700] ## LVMCONF:     fallback_to_local_locking = 0
>> [ 0:01.700] ## LVMCONF:     fsadm_executable = "/mnt/test/lvm2/test/lib/fsadm"
>> [ 0:01.700] ## LVMCONF:     library_dir = "/mnt/test/LVMTEST14057.I4CHaFJWdP/lib"
>> [ 0:01.700] ## LVMCONF:     locking_dir = "/mnt/test/LVMTEST14057.I4CHaFJWdP/var/lock/lvm"
>> [ 0:01.700] ## LVMCONF:     locking_type=1
>> [ 0:01.700] ## LVMCONF:     notify_dbus = 0
>> [ 0:01.700] ## LVMCONF:     si_unit_consistency = 1
>> [ 0:01.700] ## LVMCONF:     thin_check_executable = "/usr/sbin/thin_check"
>> [ 0:01.700] ## LVMCONF:     thin_dump_executable = "/usr/sbin/thin_dump"
>> [ 0:01.700] ## LVMCONF:     thin_repair_executable = "/usr/sbin/thin_repair"
>> [ 0:01.700] ## LVMCONF:     thin_restore_executable = "/usr/sbin/thin_restore"
>> [ 0:01.700] ## LVMCONF:     use_lvmlockd = 0
>> [ 0:01.700] ## LVMCONF:     use_lvmpolld = 0
>> [ 0:01.700] ## LVMCONF: }
>> [ 0:01.700] ## LVMCONF: log {
>> [ 0:01.700] ## LVMCONF:     activation = 1
>> [ 0:01.700] ## LVMCONF:     file = "/mnt/test/LVMTEST14057.I4CHaFJWdP/debug.log"
>> [ 0:01.700] ## LVMCONF:     indent = 1
>> [ 0:01.700] ## LVMCONF:     level = 9
>> [ 0:01.700] ## LVMCONF:     overwrite = 1
>> [ 0:01.700] ## LVMCONF:     syslog = 0
>> [ 0:01.700] ## LVMCONF:     verbose = 0
>> [ 0:01.700] ## LVMCONF: }
>> [ 0:01.700] <======== Processing test: "lvconvert-repair-raid.sh" ========>
>> [ 0:01.759]
>> [ 0:01.759] aux have_raid 1 3 0 || skip
>> [ 0:01.759] #lvconvert-repair-raid.sh:18+ aux have_raid 1 3 0
>> [ 0:01.760] modprobe: FATAL: Module dm-raid not found in directory /lib/modules/6.8.0-rc1+
>> [ 0:02.020] aux raid456_replace_works || skip
>> [ 0:02.255] #lvconvert-repair-raid.sh:19+ aux raid456_replace_works
>> [ 0:02.255]
>> [ 0:02.381] aux lvmconf 'allocation/maximise_cling = 0' \
>> [ 0:02.381] 	    'allocation/mirror_logs_require_separate_pvs = 1' \
>> [ 0:02.381] 	    'activation/raid_fault_policy = "allocate"'
>> [ 0:02.381] #lvconvert-repair-raid.sh:21+ aux lvmconf 'allocation/maximise_cling = 0' 'allocation/mirror_logs_require_separate_pvs = 1' 'activation/raid_fault_policy = "allocate"'
>> [ 0:02.383] ## LVMCONF: activation {
>> [ 0:02.668] ## LVMCONF:     checks = 1
>> [ 0:02.668] ## LVMCONF:     monitoring = 0
>> [ 0:02.668] ## LVMCONF:     polling_interval = 1
>> [ 0:02.668] ## LVMCONF:     raid_fault_policy = "allocate"
>> [ 0:02.668] ## LVMCONF:     raid_region_size = 512
>> [ 0:02.668] ## LVMCONF:     retry_deactivation = 1
>> [ 0:02.668] ## LVMCONF:     snapshot_autoextend_percent = 50
>> [ 0:02.668] ## LVMCONF:     snapshot_autoextend_threshold = 50
>> [ 0:02.668] ## LVMCONF:     udev_rules = 1
>> [ 0:02.668] ## LVMCONF:     udev_sync = 1
>> [ 0:02.668] ## LVMCONF:     verify_udev_operations = 1
>> [ 0:02.668] ## LVMCONF: }
>> [ 0:02.668] ## LVMCONF: allocation {
>> [ 0:02.668] ## LVMCONF:     maximise_cling = 0
>> [ 0:02.668] ## LVMCONF:     mirror_logs_require_separate_pvs = 1
>> [ 0:02.668] ## LVMCONF:     vdo_slab_size_mb = 128
>> [ 0:02.668] ## LVMCONF:     wipe_signatures_when_zeroing_new_lvs = 0
>> [ 0:02.668] ## LVMCONF:     zero_metadata = 0
>> [ 0:02.668] ## LVMCONF: }
>> [ 0:02.668] ## LVMCONF: backup {
>> [ 0:02.668] ## LVMCONF:     archive = 0
>> [ 0:02.668] ## LVMCONF:     backup = 0
>> [ 0:02.668] ## LVMCONF: }
>> [ 0:02.668] ## LVMCONF: devices {
>> [ 0:02.668] ## LVMCONF:     cache_dir = "/mnt/test/LVMTEST14057.I4CHaFJWdP/etc"
>> [ 0:02.668] ## LVMCONF:     default_data_alignment = 1
>> [ 0:02.668] ## LVMCONF:     dir = "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev"
>> [ 0:02.668] ## LVMCONF:     filter = "a|.*|"
>> [ 0:02.668] ## LVMCONF:     global_filter = [ "a|/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057.*pv[0-9_]*$|", "r|.*|" ]
>> [ 0:02.668] ## LVMCONF:     md_component_detection = 0
>> [ 0:02.668] ## LVMCONF:     scan = "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev"
>> [ 0:02.668] ## LVMCONF:     sysfs_scan = 1
>> [ 0:02.668] ## LVMCONF:     use_devicesfile = 0
>> [ 0:02.668] ## LVMCONF:     write_cache_state = 0
>> [ 0:02.668] ## LVMCONF: }
>> [ 0:02.668] ## LVMCONF: dmeventd {
>> [ 0:02.668] ## LVMCONF:     executable = "/mnt/test/lvm2/test/lib/dmeventd"
>> [ 0:02.668] ## LVMCONF: }
>> [ 0:02.668] ## LVMCONF: global {
>> [ 0:02.668] ## LVMCONF:     abort_on_internal_errors = 1
>> [ 0:02.668] ## LVMCONF:     cache_check_executable = "/usr/sbin/cache_check"
>> [ 0:02.668] ## LVMCONF:     cache_dump_executable = "/usr/sbin/cache_dump"
>> [ 0:02.668] ## LVMCONF:     cache_repair_executable = "/usr/sbin/cache_repair"
>> [ 0:02.668] ## LVMCONF:     cache_restore_executable = "/usr/sbin/cache_restore"
>> [ 0:02.668] ## LVMCONF:     detect_internal_vg_cache_corruption = 1
>> [ 0:02.668] ## LVMCONF:     etc = "/mnt/test/LVMTEST14057.I4CHaFJWdP/etc"
>> [ 0:02.668] ## LVMCONF:     fallback_to_local_locking = 0
>> [ 0:02.668] ## LVMCONF:     fsadm_executable = "/mnt/test/lvm2/test/lib/fsadm"
>> [ 0:02.668] ## LVMCONF:     library_dir = "/mnt/test/LVMTEST14057.I4CHaFJWdP/lib"
>> [ 0:02.668] ## LVMCONF:     locking_dir = "/mnt/test/LVMTEST14057.I4CHaFJWdP/var/lock/lvm"
>> [ 0:02.668] ## LVMCONF:     locking_type=1
>> [ 0:02.668] ## LVMCONF:     notify_dbus = 0
>> [ 0:02.668] ## LVMCONF:     si_unit_consistency = 1
>> [ 0:02.668] ## LVMCONF:     thin_check_executable = "/usr/sbin/thin_check"
>> [ 0:02.668] ## LVMCONF:     thin_dump_executable = "/usr/sbin/thin_dump"
>> [ 0:02.668] ## LVMCONF:     thin_repair_executable = "/usr/sbin/thin_repair"
>> [ 0:02.668] ## LVMCONF:     thin_restore_executable = "/usr/sbin/thin_restore"
>> [ 0:02.668] ## LVMCONF:     use_lvmlockd = 0
>> [ 0:02.668] ## LVMCONF:     use_lvmpolld = 0
>> [ 0:02.668] ## LVMCONF: }
>> [ 0:02.668] ## LVMCONF: log {
>> [ 0:02.668] ## LVMCONF:     activation = 1
>> [ 0:02.668] ## LVMCONF:     file = "/mnt/test/LVMTEST14057.I4CHaFJWdP/debug.log"
>> [ 0:02.668] ## LVMCONF:     indent = 1
>> [ 0:02.668] ## LVMCONF:     level = 9
>> [ 0:02.668] ## LVMCONF:     overwrite = 1
>> [ 0:02.668] ## LVMCONF:     syslog = 0
>> [ 0:02.668] ## LVMCONF:     verbose = 0
>> [ 0:02.668] ## LVMCONF: }
>> [ 0:02.668]
>> [ 0:02.736] aux prepare_vg 8 80
>> [ 0:02.736] #lvconvert-repair-raid.sh:25+ aux prepare_vg 8 80
>> [ 0:02.736] ## preparing loop device....ok (/dev/loop0)
>> [ 0:03.729] 6,2025,1276311398,-;loop0: detected capacity change from 0 to 1316864
>> [ 0:03.729] ## preparing 8 devices...ok
>> [ 0:04.038] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14114: bash
>> [ 0:04.142]   Physical volume "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1" successfully created.
>> [ 0:04.400]   Physical volume "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2" successfully created.
>> [ 0:04.402]   Physical volume "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3" successfully created.
>> [ 0:04.413]   Physical volume "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4" successfully created.
>> [ 0:04.416]   Physical volume "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5" successfully created.
>> [ 0:04.420]   Physical volume "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6" successfully created.
>> [ 0:04.424]   Physical volume "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7" successfully created.
>> [ 0:04.427]   Physical volume "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8" successfully created.
>> [ 0:04.441]   WARNING: This metadata update is NOT backed up.
>> [ 0:04.473]   Volume group "LVMTEST14057vg" successfully created
>> [ 0:04.474] get_devs
>> [ 0:04.647] #lvconvert-repair-raid.sh:26+ get_devs
>> [ 0:04.647] #utils:270+ local 'IFS=
>> [ 0:04.647] '
>> [ 0:04.647] #utils:271+ DEVICES=($(<DEVICES))
>> [ 0:04.648] #utils:272+ export DEVICES
>> [ 0:04.664]
>> [ 0:04.664] offset=$(get first_extent_sector "$dev1")
>> [ 0:04.664] ##lvconvert-repair-raid.sh:28+ get first_extent_sector /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 0:04.676] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14178: bash
>> [ 0:04.855] #lvconvert-repair-raid.sh:28+ offset=2048
>> [ 0:05.159]
>> [ 0:05.159] function delay
>> [ 0:05.159] {
>> [ 0:05.159] 	for d in "${DEVICES[@]}"; do
>> [ 0:05.159] 		aux delay_dev "$d" 0 $1 "$offset"
>> [ 0:05.163] 	done
>> [ 0:05.163] }
>> [ 0:05.163]
>> [ 0:05.163] # It's possible small raid arrays do have problems with reporting in-sync.
>> [ 0:05.163] # So try bigger size
>> [ 0:05.163] RAID_SIZE=32
>> [ 0:05.163] #lvconvert-repair-raid.sh:39+ RAID_SIZE=32
>> [ 0:05.163]
>> [ 0:05.163] # Fast sync and repair afterwards
>> [ 0:05.163] delay 0
>> [ 0:05.163] #lvconvert-repair-raid.sh:42+ delay 0
>> [ 0:05.163] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:05.163] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 0 0 2048
>> [ 0:05.163] modprobe: FATAL: Module dm-delay not found in directory /lib/modules/6.8.0-rc1+
>> [ 0:05.465] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:05.829] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 0 0 2048
>> [ 0:05.829] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:06.158] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 0 0 2048
>> [ 0:06.158] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:06.457] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 0 0 2048
>> [ 0:06.457] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:06.728] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 0 0 2048
>> [ 0:06.729] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:07.052] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 0 0 2048
>> [ 0:07.052] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:07.280] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 0 0 2048
>> [ 0:07.281] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:07.591] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 0 0 2048
>> [ 0:07.592]
>> [ 0:07.860] # RAID1 transient failure check
>> [ 0:07.860] lvcreate --type raid1 -m 1 -L $RAID_SIZE -n $lv1 $vg "$dev1" "$dev2"
>> [ 0:07.861] #lvconvert-repair-raid.sh:45+ lvcreate --type raid1 -m 1 -L 32 -n LV1 LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 0:07.862] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:07.964]   Logical volume "LV1" created.
>> [ 0:08.654]   WARNING: This metadata update is NOT backed up.
>> [ 0:08.654] 6,2026,1281121054,-;device-mapper: raid: Superblocks created for new raid set
>> [ 0:08.654] 6,2027,1281233598,-;md/raid1:mdX: not clean -- starting background reconstruction
>> [ 0:08.654] 6,2028,1281233612,-;md/raid1:mdX: active with 2 out of 2 mirrors
>> [ 0:08.654] 4,2029,1281312061,-;mdX: bitmap file is out of date, doing full recovery
>> [ 0:08.654] aux wait_for_sync $vg $lv1
>> [ 0:08.814] #lvconvert-repair-raid.sh:46+ aux wait_for_sync LVMTEST14057vg LV1
>> [ 0:08.814] 6,2030,1281361046,-;md: resync of RAID array mdX
>> [ 0:08.814] LVMTEST14057vg/LV1 (raid1) is not in-sync     0 65536 raid raid1 2 aa 21120/65536 resync 0 0 -
>> [ 0:09.008] LVMTEST14057vg/LV1 (raid1) is not in-sync     0 65536 raid raid1 2 aa 33792/65536 resync 0 0 -
>> [ 0:09.344] LVMTEST14057vg/LV1 (raid1) is not in-sync     0 65536 raid raid1 2 aa 54912/65536 resync 0 0 -
>> [ 0:09.709] LVMTEST14057vg/LV1 (raid1) is in-sync     0 65536 raid raid1 2 AA 65536/65536 idle 0 0 -
>> [ 0:10.074] 6,2031,1282556628,-;md: mdX: resync done.
>> [ 0:10.074] # enforce replacing live rimage leg with error target
>> [ 0:10.091] dmsetup remove -f $vg-${lv1}_rimage_1 || true
>> [ 0:10.091] #lvconvert-repair-raid.sh:48+ dmsetup remove -f LVMTEST14057vg-LV1_rimage_1
>> [ 0:10.091] device-mapper: remove ioctl on LVMTEST14057vg-LV1_rimage_1  failed: Device or resource busy
>> [ 0:10.145] Command failed.
>> [ 0:10.145] #lvconvert-repair-raid.sh:48+ true
>> [ 0:10.149] # let it notice there is problem
>> [ 0:10.149] echo a > "$DM_DEV_DIR/$vg/$lv1"
>> [ 0:10.149] #lvconvert-repair-raid.sh:50+ echo a
>> [ 0:10.150] check grep_dmsetup status $vg-$lv1 AD
>> [ 0:10.188] #lvconvert-repair-raid.sh:51+ check grep_dmsetup status LVMTEST14057vg-LV1 AD
>> [ 0:10.188] 3,2032,1282850590,-;md/raid1:mdX: dm-11: rescheduling sector 0
>> [ 0:10.188] 2,2033,1282853769,-;md/raid1:mdX: Disk failure on dm-11, disabling device.\x0amd/raid1:mdX: Operation continuing on 1 devices.
>> [ 0:10.188] 6,2034,1282856957,-;md/raid1:mdX: redirecting sector 0 to other mirror: dm-9
>> [ 0:10.188] 0 65536 raid raid1 2 AD 65536/65536 idle 0 0 -
>> [ 0:10.295] lvconvert -y --repair $vg/$lv1 "$dev3"
>> [ 0:10.326] #lvconvert-repair-raid.sh:52+ lvconvert -y --repair LVMTEST14057vg/LV1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:10.326] File descriptor 6 (/dev/pts/0) leaked on lvm invocation.3,2035,1283053290,-;Buffer I/O error on dev dm-11, logical block 8176, async page read
>> [ 0:10.429]  Parent PID 14057: bash
>> [ 0:10.432]   Faulty devices in LVMTEST14057vg/LV1 successfully replaced.
>> [ 0:11.849] 6,2036,1283304339,-;device-mapper: raid: Device 1 specified for rebuild; clearing superblock
>> [ 0:11.849] 6,2037,1283427015,-;md/raid1:mdX: active with 1 out of 2 mirrors
>> [ 0:11.849] 6,2038,1283689069,-;md: recovery of RAID array mdX
>> [ 0:11.849] 6,2039,1284092665,-;md/raid1:mdX: active with 1 out of 2 mirrors
>> [ 0:11.849] 6,2040,1284153859,-;md: mdX: recovery interrupted.
>> [ 0:11.849] 6,2041,1284490869,-;md: recovery of RAID array mdX
>> [ 0:11.849]   WARNING: This metadata update is NOT backed up.
>> [ 0:11.876] lvs -a -o+devices $vg
>> [ 0:12.024] #lvconvert-repair-raid.sh:53+ lvs -a -o+devices LVMTEST14057vg
>> [ 0:12.024] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:12.121]   LV             VG             Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert Devices
>> [ 0:12.238]   LV1            LVMTEST14057vg rwi-a-r---  32.00m                                    70.90            LV1_rimage_0(0),LV1_rimage_1(0)
>> [ 0:12.238]   [LV1_rimage_0] LVMTEST14057vg iwi-aor---  32.00m                                                     /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1(1)
>> [ 0:12.239]   [LV1_rimage_1] LVMTEST14057vg Iwi-aor---  32.00m                                                     /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3(1)
>> [ 0:12.240]   [LV1_rmeta_0]  LVMTEST14057vg ewi-aor--- 512.00k                                                     /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1(0)
>> [ 0:12.240]   [LV1_rmeta_1]  LVMTEST14057vg ewi-aor--- 512.00k                                                     /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3(0)
>> [ 0:12.240] aux wait_for_sync $vg $lv1
>> [ 0:12.370] #lvconvert-repair-raid.sh:54+ aux wait_for_sync LVMTEST14057vg LV1
>> [ 0:12.370] LVMTEST14057vg/LV1 (raid1) is in-sync     0 65536 raid raid1 2 AA 65536/65536 idle 0 0 -
>> [ 0:12.576] 6,2042,1285213278,-;md: mdX: recovery done.
>> [ 0:12.576] # Raid should have fixed device
>> [ 0:12.604] check grep_dmsetup status $vg-$lv1 AA
>> [ 0:12.604] #lvconvert-repair-raid.sh:56+ check grep_dmsetup status LVMTEST14057vg-LV1 AA
>> [ 0:12.604] 0 65536 raid raid1 2 AA 65536/65536 idle 0 0 -
>> [ 0:12.710] check lv_on $vg ${lv1}_rimage_1 "$dev3"
>> [ 0:12.758] #lvconvert-repair-raid.sh:57+ check lv_on LVMTEST14057vg LV1_rimage_1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:12.758] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14404: bash
>> [ 0:13.026] lvremove -ff $vg/$lv1
>> [ 0:13.552] #lvconvert-repair-raid.sh:58+ lvremove -ff LVMTEST14057vg/LV1
>> [ 0:13.552] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:13.678]   Logical volume "LV1" successfully removed.
>> [ 0:14.171]   WARNING: This metadata update is NOT backed up.
>> [ 0:14.175]
>> [ 0:14.321]
>> [ 0:14.321] # RAID1 dual-leg single replace after initial sync
>> [ 0:14.321] lvcreate --type raid1 -m 1 -L $RAID_SIZE -n $lv1 $vg "$dev1" "$dev2"
>> [ 0:14.321] #lvconvert-repair-raid.sh:62+ lvcreate --type raid1 -m 1 -L 32 -n LV1 LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 0:14.322] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:14.476]   Logical volume "LV1" created.
>> [ 0:15.138] 6,2043,1287599313,-;device-mapper: raid: Superblocks created for new raid set
>> [ 0:15.138] 6,2044,1287698868,-;md/raid1:mdX: not clean -- starting background reconstruction
>> [ 0:15.138] 6,2045,1287698881,-;md/raid1:mdX: active with 2 out of 2 mirrors
>> [ 0:15.138] 4,2046,1287727072,-;mdX: bitmap file is out of date, doing full recovery
>> [ 0:15.138] 6,2047,1287780946,-;md: resync of RAID array mdX
>> [ 0:15.138]   WARNING: This metadata update is NOT backed up.
>> [ 0:15.140] aux wait_for_sync $vg $lv1
>> [ 0:15.277] #lvconvert-repair-raid.sh:63+ aux wait_for_sync LVMTEST14057vg LV1
>> [ 0:15.277] LVMTEST14057vg/LV1 (raid1) is not in-sync     0 65536 raid raid1 2 aa 29568/65536 resync 0 0 -
>> [ 0:15.438] LVMTEST14057vg/LV1 (raid1) is not in-sync     0 65536 raid raid1 2 aa 42240/65536 resync 0 0 -
>> [ 0:15.794] LVMTEST14057vg/LV1 (raid1) is not in-sync     0 65536 raid raid1 2 aa 63360/65536 resync 0 0 -
>> [ 0:16.154] 6,2048,1288837762,-;md: mdX: resync done.
>> [ 0:16.155] LVMTEST14057vg/LV1 (raid1) is in-sync     0 65536 raid raid1 2 AA 65536/65536 idle 0 0 -
>> [ 0:16.543] aux disable_dev "$dev2"
>> [ 0:16.561] #lvconvert-repair-raid.sh:64+ aux disable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 0:16.561] Disabling device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 (250:1)
>> [ 0:17.218] lvconvert -y --repair $vg/$lv1
>> [ 0:17.288] #lvconvert-repair-raid.sh:65+ lvconvert -y --repair LVMTEST14057vg/LV1
>> [ 0:17.288] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:17.389]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:17.470]   WARNING: VG LVMTEST14057vg is missing PV TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD (last written to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2).
>> [ 0:17.470] 3,2049,1290104377,-;Buffer I/O error on dev dm-1, logical block 20464, async page read
>> [ 0:17.470]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:17.471]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:17.476]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:18.401] 6,2050,1290261781,-;device-mapper: raid: Device 1 specified for rebuild; clearing superblock
>> [ 0:18.401] 6,2051,1290382665,-;md/raid1:mdX: active with 1 out of 2 mirrors
>> [ 0:18.401] 3,2052,1290506357,-;md: super_written gets error=-5
>> [ 0:18.401] 2,2053,1290507447,-;md/raid1:mdX: Disk failure on dm-11, disabling device.\x0amd/raid1:mdX: Operation continuing on 1 devices.
>> [ 0:18.401] 6,2054,1290660928,-;md: recovery of RAID array mdX
>> [ 0:18.402]   Faulty devices in LVMTEST14057vg/LV1 successfully replaced.
>> [ 0:19.001] 6,2055,1291294554,-;md/raid1:mdX: active with 1 out of 2 mirrors
>> [ 0:19.001] 6,2056,1291350860,-;md: mdX: recovery interrupted.
>> [ 0:19.001] 6,2057,1291620843,-;md: recovery of RAID array mdX
>> [ 0:19.002]   WARNING: This metadata update is NOT backed up.
>> [ 0:19.031] vgreduce --removemissing $vg
>> [ 0:19.161] #lvconvert-repair-raid.sh:66+ vgreduce --removemissing LVMTEST14057vg
>> [ 0:19.161] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:19.261]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:19.332]   WARNING: VG LVMTEST14057vg is missing PV TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD (last written to [unknown]).6,2058,1291998352,-;md: mdX: recovery done.
>> [ 0:19.332]
>> [ 0:19.333]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:19.334]   WARNING: This metadata update is NOT backed up.
>> [ 0:19.362]   Wrote out consistent volume group LVMTEST14057vg.
>> [ 0:19.362] aux enable_dev "$dev2"
>> [ 0:19.523] #lvconvert-repair-raid.sh:67+ aux enable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 0:19.523] vgck --updatemetadata $vg
>> [ 0:19.858] #lvconvert-repair-raid.sh:68+ vgck --updatemetadata LVMTEST14057vg
>> [ 0:19.858] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:19.965]   WARNING: ignoring metadata seqno 8 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 for seqno 11 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 for VG LVMTEST14057vg.
>> [ 0:20.028]   WARNING: Inconsistent metadata found for VG LVMTEST14057vg.
>> [ 0:20.031]   See vgck --updatemetadata to correct inconsistency.
>> [ 0:20.032]   WARNING: outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 seqno 8 has been removed in current VG LVMTEST14057vg seqno 11.
>> [ 0:20.032]   See vgck --updatemetadata to clear outdated metadata.
>> [ 0:20.032]   WARNING: wiping mda on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 0:20.035]   WARNING: wiping header on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 0:20.036]   WARNING: This metadata update is NOT backed up.
>> [ 0:20.074] vgextend $vg "$dev2"
>> [ 0:20.285] #lvconvert-repair-raid.sh:69+ vgextend LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 0:20.285] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:20.418]   Volume group "LVMTEST14057vg" successfully extended
>> [ 0:20.562]   WARNING: This metadata update is NOT backed up.
>> [ 0:20.562] lvremove -ff $vg/$lv1
>> [ 0:20.683] #lvconvert-repair-raid.sh:70+ lvremove -ff LVMTEST14057vg/LV1
>> [ 0:20.683] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:20.789]   Logical volume "LV1" successfully removed.
>> [ 0:21.289]   WARNING: This metadata update is NOT backed up.
>> [ 0:21.294]
>> [ 0:21.459] # Delayed sync to allow for repair during rebuild
>> [ 0:21.459] delay 50
>> [ 0:21.459] #lvconvert-repair-raid.sh:73+ delay 50
>> [ 0:21.460] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:21.460] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 0 50 2048
>> [ 0:21.460] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:21.786] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 0 50 2048
>> [ 0:21.786] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:22.106] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 0 50 2048
>> [ 0:22.106] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:22.449] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 0 50 2048
>> [ 0:22.449] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:22.709] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 0 50 2048
>> [ 0:22.709] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:22.995] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 0 50 2048
>> [ 0:22.995] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:23.269] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 0 50 2048
>> [ 0:23.269] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:23.507] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 0 50 2048
>> [ 0:23.507]
>> [ 0:23.827] # RAID1 triple-leg single replace during initial sync
>> [ 0:23.827] lvcreate --type raid1 -m 2 -L $RAID_SIZE -n $lv1 $vg "$dev1" "$dev2" "$dev3"
>> [ 0:23.827] #lvconvert-repair-raid.sh:76+ lvcreate --type raid1 -m 2 -L 32 -n LV1 LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:23.827] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:23.934]   Logical volume "LV1" created.
>> [ 0:25.624] 3,2059,1297185203,-;debugfs: Directory 'bio-296' with parent 'slab' already present!
>> [ 0:25.624] 3,2060,1297188667,-;debugfs: Directory 'bio-144' with parent 'slab' already present!
>> [ 0:25.624] 6,2061,1297300268,-;device-mapper: raid: Superblocks created for new raid set
>> [ 0:25.624] 6,2062,1297428794,-;md/raid1:mdX: not clean -- starting background reconstruction
>> [ 0:25.624] 6,2063,1297428807,-;md/raid1:mdX: active with 3 out of 3 mirrors
>> [ 0:25.624] 6,2064,1297440848,-;dm-14: detected capacity change from 0 to 65536
>> [ 0:25.624] 4,2065,1297749662,-;mdX: bitmap file is out of date, doing full recovery
>> [ 0:25.624] 6,2066,1298263961,-;md: resync of RAID array mdX
>> [ 0:25.624]   WARNING: This metadata update is NOT backed up.
>> [ 0:25.625] aux disable_dev "$dev2" "$dev3"
>> [ 0:25.794] #lvconvert-repair-raid.sh:77+ aux disable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:25.794] Disabling device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 (250:1)
>> [ 0:26.129] Disabling device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 (250:2)
>> [ 0:26.309] 3,2067,1298919723,-;md: super_written gets error=-5
>> [ 0:26.309] 2,2068,1298920326,-;md/raid1:mdX: Disk failure on dm-11, disabling device.\x0amd/raid1:mdX: Operation continuing on 2 devices.
>> [ 0:26.309] # FIXME 2016/11/04 AGK: Disabled next line as it fails to guarantee it is not already in sync.
>> [ 0:26.391] #not lvconvert -y --repair $vg/$lv1
>> [ 0:26.391] aux wait_for_sync $vg $lv1
>> [ 0:26.391] #lvconvert-repair-raid.sh:80+ aux wait_for_sync LVMTEST14057vg LV1
>> [ 0:26.391] 3,2069,1299026397,-;Buffer I/O error on dev dm-1, logical block 20464, async page read
>> [ 0:26.391] 3,2070,1299068631,-;md: super_written gets error=-5
>> [ 0:26.391] 2,2071,1299070029,-;md/raid1:mdX: Disk failure on dm-13, disabling device.\x0amd/raid1:mdX: Operation continuing on 1 devices.
>> [ 0:26.391] LVMTEST14057vg/LV1 (raid1) is not in-sync     0 65536 raid raid1 3 aDD 4224/65536 resync 0 0 -
>> [ 0:26.550] 3,2072,1299153501,-;Buffer I/O error on dev dm-2, logical block 20464, async page read
>> [ 0:26.550] LVMTEST14057vg/LV1 (raid1) is not in-sync     0 65536 raid raid1 3 ADD 8448/65536 idle 0 0 -
>> [ 0:26.868] 6,2073,1299404092,-;md: mdX: resync interrupted.
>> [ 0:26.868] LVMTEST14057vg/LV1 (raid1) is not in-sync     0 65536 raid raid1 3 ADD 8448/65536 idle 0 0 -
>> [ 0:27.285] LVMTEST14057vg/LV1 (raid1) is in-sync     0 65536 raid raid1 3 ADD 65536/65536 idle 0 0 -
>> [ 0:27.674] 6,2074,1300065963,-;md: resync of RAID array mdX
>> [ 0:27.674] 6,2075,1300074488,-;md: mdX: resync done.
>> [ 0:27.675] lvconvert -y --repair $vg/$lv1
>> [ 0:27.692] #lvconvert-repair-raid.sh:81+ lvconvert -y --repair LVMTEST14057vg/LV1
>> [ 0:27.693] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:27.799]   WARNING: Couldn't find device with uuid 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr.
>> [ 0:27.878]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:27.878]   WARNING: VG LVMTEST14057vg is missing PV 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr (last written to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3).
>> [ 0:27.880]   WARNING: VG LVMTEST14057vg is missing PV TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD (last written to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2).
>> [ 0:27.880]   WARNING: Couldn't find device with uuid 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr.
>> [ 0:27.880]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:27.880]   WARNING: Couldn't find device with uuid 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr.
>> [ 0:27.889]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:27.889]   WARNING: Couldn't find device with uuid 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr.
>> [ 0:29.712]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:29.712] 6,2076,1300685876,-;device-mapper: raid: Device 1 specified for rebuild; clearing superblock
>> [ 0:29.712] 6,2077,1300685888,-;device-mapper: raid: Device 2 specified for rebuild; clearing superblock
>> [ 0:29.712] 6,2078,1300813208,-;md/raid1:mdX: active with 1 out of 3 mirrors
>> [ 0:29.712] 6,2079,1301986712,-;md: recovery of RAID array mdX
>> [ 0:29.712]   Faulty devices in LVMTEST14057vg/LV1 successfully replaced.
>> [ 0:31.547] 6,2080,1302595843,-;md/raid1:mdX: active with 1 out of 3 mirrors
>> [ 0:31.547] 6,2081,1302839006,-;md: mdX: recovery interrupted.
>> [ 0:31.547]   WARNING: This metadata update is NOT backed up.
>> [ 0:31.591] vgreduce --removemissing $vg
>> [ 0:31.712] #lvconvert-repair-raid.sh:82+ vgreduce --removemissing LVMTEST14057vg
>> [ 0:31.712] 6,2082,1304314665,-;md: recovery of RAID array mdX
>> [ 0:31.712] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:31.803]   WARNING: Couldn't find device with uuid 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr.
>> [ 0:31.912]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:31.913]   WARNING: VG LVMTEST14057vg is missing PV 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr (last written to [unknown]).
>> [ 0:31.914]   WARNING: VG LVMTEST14057vg is missing PV TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD (last written to [unknown]).
>> [ 0:31.914]   WARNING: Couldn't find device with uuid 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr.
>> [ 0:31.918]   WARNING: Couldn't find device with uuid TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD.
>> [ 0:31.918]   WARNING: This metadata update is NOT backed up.
>> [ 0:31.935]   Wrote out consistent volume group LVMTEST14057vg.
>> [ 0:31.935] aux enable_dev "$dev2" "$dev3"
>> [ 0:32.120] #lvconvert-repair-raid.sh:83+ aux enable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:32.120] vgck --updatemetadata $vg
>> [ 0:32.737] #lvconvert-repair-raid.sh:84+ vgck --updatemetadata LVMTEST14057vg
>> [ 0:32.737] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:32.828]   WARNING: ignoring metadata seqno 16 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 for seqno 19 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 for VG LVMTEST14057vg.
>> [ 0:32.889]   WARNING: ignoring metadata seqno 16 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 for seqno 19 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 for VG LVMTEST14057vg.
>> [ 0:32.890]   WARNING: Inconsistent metadata found for VG LVMTEST14057vg.
>> [ 0:32.892]   See vgck --updatemetadata to correct inconsistency.
>> [ 0:32.892]   WARNING: outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 seqno 16 has been removed in current VG LVMTEST14057vg seqno 19.
>> [ 0:32.892]   See vgck --updatemetadata to clear outdated metadata.
>> [ 0:32.892]   WARNING: outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 seqno 16 has been removed in current VG LVMTEST14057vg seqno 19.
>> [ 0:32.892]   WARNING: wiping mda on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 0:32.893]   WARNING: wiping header on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 0:32.895]   WARNING: wiping mda on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:32.896]   WARNING: wiping header on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:32.898]   WARNING: This metadata update is NOT backed up.
>> [ 0:32.927] vgextend $vg "$dev2" "$dev3"
>> [ 0:33.143] #lvconvert-repair-raid.sh:85+ vgextend LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:33.143] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:33.240]   Volume group "LVMTEST14057vg" successfully extended
>> [ 0:33.535]   WARNING: This metadata update is NOT backed up.
>> [ 0:33.536] lvremove -ff $vg/$lv1
>> [ 0:33.734] #lvconvert-repair-raid.sh:86+ lvremove -ff LVMTEST14057vg/LV1
>> [ 0:33.734] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:33.835]   Logical volume "LV1" successfully removed.
>> [ 0:35.460]   WARNING: This metadata update is NOT backed up.
>> [ 0:35.460] 6,2083,1306686328,-;md: mdX: recovery interrupted.
>> [ 0:35.460] 6,2084,1307270376,-;dm-14: detected capacity change from 0 to 65536
>> [ 0:35.460]
>> [ 0:35.625]
>> [ 0:35.625] # Larger RAID size possible for striped RAID
>> [ 0:35.625] RAID_SIZE=64
>> [ 0:35.625] #lvconvert-repair-raid.sh:90+ RAID_SIZE=64
>> [ 0:35.626]
>> [ 0:35.626] # Fast sync and repair afterwards
>> [ 0:35.626] delay 0
>> [ 0:35.626] #lvconvert-repair-raid.sh:93+ delay 0
>> [ 0:35.626] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:35.626] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 0 0 2048
>> [ 0:35.626] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:35.929] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 0 0 2048
>> [ 0:35.929] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:36.234] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 0 0 2048
>> [ 0:36.234] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:36.513] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 0 0 2048
>> [ 0:36.513] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:36.801] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 0 0 2048
>> [ 0:36.803] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:37.077] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 0 0 2048
>> [ 0:37.077] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:37.368] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 0 0 2048
>> [ 0:37.369] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:37.668] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 0 0 2048
>> [ 0:37.668] # RAID5 single replace after initial sync
>> [ 0:38.085] lvcreate --type raid5 -i 2 -L $RAID_SIZE -n $lv1 $vg "$dev1" "$dev2" "$dev3"
>> [ 0:38.085] #lvconvert-repair-raid.sh:95+ lvcreate --type raid5 -i 2 -L 64 -n LV1 LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:38.085] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:38.187]   Using default stripesize 64.00 KiB.
>> [ 0:38.215]   Logical volume "LV1" created.
>> [ 0:38.958] 6,2085,1311432720,-;device-mapper: raid: Superblocks created for new raid set
>> [ 0:38.958] 5,2086,1311539598,-;md/raid:mdX: not clean -- starting background reconstruction
>> [ 0:38.958] 6,2087,1311539906,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 0:38.959] 6,2088,1311539916,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 0:38.959] 6,2089,1311539923,-;md/raid:mdX: device dm-13 operational as raid disk 2
>> [ 0:38.959] 6,2090,1311567998,-;md/raid:mdX: raid level 5 active with 3 out of 3 devices, algorithm 2
>> [ 0:38.959] 3,2091,1311568122,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 0:38.959] 3,2092,1311569124,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 0:38.959] 4,2093,1311599398,-;mdX: bitmap file is out of date, doing full recovery
>> [ 0:38.959]   WARNING: This metadata update is NOT backed up.
>> [ 0:38.959] aux wait_for_sync $vg $lv1
>> [ 0:39.113] 6,2094,1311661426,-;md: resync of RAID array mdX
>> [ 0:39.114] #lvconvert-repair-raid.sh:96+ aux wait_for_sync LVMTEST14057vg LV1
>> [ 0:39.118] LVMTEST14057vg/LV1 (raid5_ls) is not in-sync     0 131072 raid raid5_ls 3 aaa 4104/65536 resync 0 0 -
>> [ 0:39.301] LVMTEST14057vg/LV1 (raid5_ls) is not in-sync     0 131072 raid raid5_ls 3 aaa 12312/65536 resync 0 0 -
>> [ 0:39.702] LVMTEST14057vg/LV1 (raid5_ls) is not in-sync     0 131072 raid raid5_ls 3 aaa 24624/65536 resync 0 0 -
>> [ 0:40.059] LVMTEST14057vg/LV1 (raid5_ls) is not in-sync     0 131072 raid raid5_ls 3 aaa 32832/65536 resync 0 0 -
>> [ 0:40.454] LVMTEST14057vg/LV1 (raid5_ls) is not in-sync     0 131072 raid raid5_ls 3 aaa 45144/65536 resync 0 0 -
>> [ 0:40.877] LVMTEST14057vg/LV1 (raid5_ls) is not in-sync     0 131072 raid raid5_ls 3 aaa 57456/65536 resync 0 0 -
>> [ 0:41.307] LVMTEST14057vg/LV1 (raid5_ls) is in-sync     0 131072 raid raid5_ls 3 AAA 65536/65536 idle 0 0 -
>> [ 0:41.712] 6,2095,1314243663,-;md: mdX: resync done.
>> [ 0:41.712] aux disable_dev "$dev3"
>> [ 0:41.724] #lvconvert-repair-raid.sh:97+ aux disable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:41.725] Disabling device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 (250:2)
>> [ 0:42.146] vgreduce --removemissing -f $vg
>> [ 0:42.232] #lvconvert-repair-raid.sh:98+ vgreduce --removemissing -f LVMTEST14057vg
>> [ 0:42.232] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:42.357] 3,2096,1315007912,-;Buffer I/O error on dev dm-2, logical block 20464, async page read
>> [ 0:42.357]   WARNING: Couldn't find device with uuid 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr.
>> [ 0:42.432]   WARNING: VG LVMTEST14057vg is missing PV 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr (last written to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3).
>> [ 0:42.433]   WARNING: Couldn't find device with uuid 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr.
>> [ 0:42.435]   WARNING: Couldn't find device with uuid 5U7odl-nmAh-2KTo-ttOK-jIKO-ftyd-MGDphr.
>> [ 0:42.438]   3,2097,1315248434,-;md: super_written gets error=-5
>> [ 0:42.731] 2,2098,1315249069,-;md/raid:mdX: Disk failure on dm-13, disabling device.
>> [ 0:42.731] 2,2099,1315249707,-;md/raid:mdX: Operation continuing on 2 devices.
>> [ 0:42.731] 3,2100,1315353167,-;device-mapper: raid: Failed to read superblock of device at position 2
>> [ 0:42.731] WARNING: This metadata update is NOT backed up.
>> [ 0:42.741]   Wrote out consistent volume group LVMTEST14057vg.
>> [ 0:42.741] lvconvert -y --repair $vg/$lv1
>> [ 0:42.947] #lvconvert-repair-raid.sh:99+ lvconvert -y --repair LVMTEST14057vg/LV1
>> [ 0:42.947] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:43.109]   Faulty devices in LVMTEST14057vg/LV1 successfully replaced.
>> [ 0:44.503] 6,2101,1315941200,-;device-mapper: raid: Device 2 specified for rebuild; clearing superblock
>> [ 0:44.503] 6,2102,1316100173,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 0:44.503] 6,2103,1316100191,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 0:44.503] 6,2104,1316122349,-;md/raid:mdX: raid level 5 active with 2 out of 3 devices, algorithm 2
>> [ 0:44.503] 3,2105,1316122807,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 0:44.503] 3,2106,1316123822,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 0:44.503] 6,2107,1316290966,-;md: recovery of RAID array mdX
>> [ 0:44.503] 6,2108,1316774212,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 0:44.503] 6,2109,1316774231,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 0:44.503] 6,2110,1316795482,-;md/raid:mdX: raid level 5 active with 2 out of 3 devices, algorithm 2
>> [ 0:44.503] 3,2111,1316796267,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 0:44.503] 3,2112,1316797246,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 0:44.503] 6,2113,1316854580,-;md: mdX: recovery interrupted.
>> [ 0:44.503] 6,2114,1317080884,-;md: recovery of RAID array mdX
>> [ 0:44.503]   WARNING: This metadata update is NOT backed up.
>> [ 0:44.561] aux enable_dev "$dev3"
>> [ 0:44.714] #lvconvert-repair-raid.sh:100+ aux enable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:44.718] vgck --updatemetadata $vg
>> [ 0:44.976] #lvconvert-repair-raid.sh:101+ vgck --updatemetadata LVMTEST14057vg
>> [ 0:44.981] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:45.105]   WARNING: ignoring metadata seqno 24 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 for seqno 28 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 for VG LVMTEST14057vg.
>> [ 0:45.176]   WARNING: Inconsistent metadata found for VG LVMTEST14057vg.
>> [ 0:45.178]   See vgck --updatemetadata to correct inconsistency.
>> [ 0:45.178]   WARNING: outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 seqno 24 has been removed in current VG LVMTEST14057vg seqno 28.
>> [ 0:45.178]   See vgck --updatemetadata to clear outdated metadata.
>> [ 0:45.178]   WARNING: wiping mda on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:45.180]   WARNING: wiping header on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:45.182]   WARNING: This metadata update is NOT backed up.
>> [ 0:45.198] pvcreate -yff "$dev3"
>> [ 0:45.360] #lvconvert-repair-raid.sh:102+ pvcreate -yff /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:45.360] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:45.477]   Physical volume "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3" successfully created.
>> [ 0:45.671] vgextend $vg "$dev3"
>> [ 0:45.831] #lvconvert-repair-raid.sh:103+ vgextend LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:45.831] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:45.964]   Volume group "LVMTEST14057vg" successfully extended
>> [ 0:46.177]   WARNING: This metadata update is NOT backed up.
>> [ 0:46.177] lvremove -ff $vg/$lv1
>> [ 0:46.367] #lvconvert-repair-raid.sh:104+ lvremove -ff LVMTEST14057vg/LV1
>> [ 0:46.367] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:46.517]   Logical volume "LV1" successfully removed.
>> [ 0:47.581] 6,2115,1319401197,-;md: mdX: recovery interrupted.
>> [ 0:47.581] 6,2116,1319601848,-;dm-14: detected capacity change from 0 to 131072
>> [ 0:47.581]   WARNING: This metadata update is NOT backed up.
>> [ 0:47.593]
>> [ 0:47.753] # Delayed sync to allow for repair during rebuild
>> [ 0:47.753] delay 60
>> [ 0:47.753] #lvconvert-repair-raid.sh:107+ delay 60
>> [ 0:47.753] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:47.755] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 0 60 2048
>> [ 0:47.755] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:48.090] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 0 60 2048
>> [ 0:48.090] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:48.347] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 0 60 2048
>> [ 0:48.347] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:48.707] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 0 60 2048
>> [ 0:48.707] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:49.026] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 0 60 2048
>> [ 0:49.026] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:49.325] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 0 60 2048
>> [ 0:49.325] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:49.613] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 0 60 2048
>> [ 0:49.613] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 0:49.923] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 0 60 2048
>> [ 0:49.923]
>> [ 0:50.224] # RAID5 single replace during initial sync
>> [ 0:50.224] lvcreate --type raid5 -i 2 -L $RAID_SIZE -n $lv1 $vg "$dev1" "$dev2" "$dev3"
>> [ 0:50.224] #lvconvert-repair-raid.sh:110+ lvcreate --type raid5 -i 2 -L 64 -n LV1 LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:50.224] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:50.343]   Using default stripesize 64.00 KiB.
>> [ 0:50.367]   Logical volume "LV1" created.
>> [ 0:52.432] 3,2117,1323766313,-;debugfs: Directory 'bio-296' with parent 'slab' already present!
>> [ 0:52.432] 3,2118,1323770665,-;debugfs: Directory 'bio-144' with parent 'slab' already present!
>> [ 0:52.432] 6,2119,1323880318,-;device-mapper: raid: Superblocks created for new raid set
>> [ 0:52.432] 5,2120,1323987508,-;md/raid:mdX: not clean -- starting background reconstruction
>> [ 0:52.432] 6,2121,1323987811,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 0:52.432] 6,2122,1323987821,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 0:52.432] 6,2123,1323987828,-;md/raid:mdX: device dm-13 operational as raid disk 2
>> [ 0:52.432] 6,2124,1324009447,-;md/raid:mdX: raid level 5 active with 3 out of 3 devices, algorithm 2
>> [ 0:52.433] 3,2125,1324009615,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 0:52.433] 3,2126,1324010611,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 0:52.433] 4,2127,1324331655,-;mdX: bitmap file is out of date, doing full recovery
>> [ 0:52.433] 6,2128,1324993361,-;md: resync of RAID array mdX
>> [ 0:52.433]   WARNING: This metadata update is NOT backed up.
>> [ 0:52.434] aux disable_dev "$dev3"
>> [ 0:52.575] #lvconvert-repair-raid.sh:111+ aux disable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:52.575] Disabling device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 (250:2)
>> [ 0:52.992] # FIXME: there is quite big sleep on several 'status' read retries
>> [ 0:53.069] # so over 3sec - it may actually finish full sync
>> [ 0:53.069] # Use 'should' for this test result.
>> [ 0:53.069] should not lvconvert -y --repair $vg/$lv1
>> [ 0:53.069] #lvconvert-repair-raid.sh:115+ should not lvconvert -y --repair LVMTEST14057vg/LV1
>> [ 0:53.069] 3,2129,1325765996,-;md: super_written gets error=-5
>> [ 0:53.070] 2,2130,1325767289,-;md/raid:mdX: Disk failure on dm-13, disabling device.
>> [ 0:53.070] 2,2131,1325768973,-;md/raid:mdX: Operation continuing on 2 devices.
>> [ 0:53.070] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 15234: not
>> [ 0:53.185]   WARNING: Couldn't find device with uuid AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck.3,2132,1325902592,-;Buffer I/O error on dev dm-2, logical block 20464, async page read
>> [ 0:53.243]
>> [ 0:53.243]   WARNING: VG LVMTEST14057vg is missing PV AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck (last written to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3).
>> [ 0:53.244]   WARNING: Couldn't find device with uuid AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck.
>> [ 0:53.248]   Unable to replace devices in LVMTEST14057vg/LV1 while it is not in-sync.
>> [ 0:53.251]   Failed to replace faulty devices in LVMTEST14057vg/LV1.
>> [ 0:53.252] aux wait_for_sync $vg $lv1
>> [ 0:53.463] #lvconvert-repair-raid.sh:116+ aux wait_for_sync LVMTEST14057vg LV1
>> [ 0:53.463] LVMTEST14057vg/LV1 (raid5_ls) is not in-sync     0 131072 raid raid5_ls 3 AAD 8208/65536 idle 0 0 -
>> [ 0:53.706] 6,2133,1326305477,-;md: mdX: resync interrupted.
>> [ 0:53.706] LVMTEST14057vg/LV1 (raid5_ls) is not in-sync     0 131072 raid raid5_ls 3 AAD 8208/65536 idle 0 0 -
>> [ 0:54.064] LVMTEST14057vg/LV1 (raid5_ls) is in-sync     0 131072 raid raid5_ls 3 AAD 65536/65536 idle 0 0 -
>> [ 0:54.463] 6,2134,1327029574,-;md: resync of RAID array mdX
>> [ 0:54.463] 6,2135,1327029620,-;md: mdX: resync done.
>> [ 0:54.463] lvconvert -y --repair $vg/$lv1
>> [ 0:54.482] #lvconvert-repair-raid.sh:117+ lvconvert -y --repair LVMTEST14057vg/LV1
>> [ 0:54.482] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:54.606]   WARNING: Couldn't find device with uuid AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck.
>> [ 0:54.677]   WARNING: VG LVMTEST14057vg is missing PV AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck (last written to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3).
>> [ 0:54.677]   WARNING: Couldn't find device with uuid AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck.
>> [ 0:54.678]   WARNING: Couldn't find device with uuid AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck.
>> [ 0:54.684]   WARNING: Couldn't find device with uuid AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck.
>> [ 0:56.390] 6,2136,1327479870,-;device-mapper: raid: Device 2 specified for rebuild; clearing superblock
>> [ 0:56.390] 6,2137,1327599452,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 0:56.391] 6,2138,1327599469,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 0:56.391] 6,2139,1327627129,-;md/raid:mdX: raid level 5 active with 2 out of 3 devices, algorithm 2
>> [ 0:56.391] 3,2140,1327627831,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 0:56.391] 3,2141,1327629157,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 0:56.391] 6,2142,1328898793,-;md: recovery of RAID array mdX
>> [ 0:56.391]   Faulty devices in LVMTEST14057vg/LV1 successfully replaced.
>> [ 0:58.353] 6,2143,1329232632,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 0:58.353] 6,2144,1329232657,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 0:58.353] 6,2145,1329247960,-;md/raid:mdX: raid level 5 active with 2 out of 3 devices, algorithm 2
>> [ 0:58.353] 4,2146,1329254131,-;mdX: bitmap file is out of date (10 < 11) -- forcing full recovery
>> [ 0:58.353] 3,2147,1329255292,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 0:58.354] 3,2148,1329256693,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 0:58.354] 6,2149,1329374042,-;md: mdX: recovery interrupted.
>> [ 0:58.354] 4,2150,1330481126,-;mdX: bitmap file is out of date, doing full recovery
>> [ 0:58.354]   WARNING: This metadata update is NOT backed up.
>> [ 0:58.396] 6,2151,1331068314,-;md: recovery of RAID array mdX
>> [ 0:58.396] vgreduce --removemissing $vg
>> [ 0:58.540] #lvconvert-repair-raid.sh:118+ vgreduce --removemissing LVMTEST14057vg
>> [ 0:58.541] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:58.663]   WARNING: Couldn't find device with uuid AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck.
>> [ 0:58.728]   WARNING: VG LVMTEST14057vg is missing PV AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck (last written to [unknown]).
>> [ 0:58.728]   WARNING: Couldn't find device with uuid AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck.
>> [ 0:58.730]   WARNING: This metadata update is NOT backed up.
>> [ 0:58.760]   Wrote out consistent volume group LVMTEST14057vg.
>> [ 0:58.760] aux enable_dev "$dev3"
>> [ 0:58.971] #lvconvert-repair-raid.sh:119+ aux enable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:58.971] vgck --updatemetadata $vg
>> [ 0:59.350] #lvconvert-repair-raid.sh:120+ vgck --updatemetadata LVMTEST14057vg
>> [ 0:59.350] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:59.482]   WARNING: ignoring metadata seqno 33 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 for seqno 36 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 for VG LVMTEST14057vg.
>> [ 0:59.534]   WARNING: Inconsistent metadata found for VG LVMTEST14057vg.
>> [ 0:59.541]   See vgck --updatemetadata to correct inconsistency.
>> [ 0:59.541]   WARNING: outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 seqno 33 has been removed in current VG LVMTEST14057vg seqno 36.
>> [ 0:59.541]   See vgck --updatemetadata to clear outdated metadata.
>> [ 0:59.541]   WARNING: wiping mda on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:59.543]   WARNING: wiping header on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:59.559]   WARNING: This metadata update is NOT backed up.
>> [ 0:59.578] vgextend $vg "$dev3"
>> [ 0:59.733] #lvconvert-repair-raid.sh:121+ vgextend LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 0:59.733] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 0:59.884]   Volume group "LVMTEST14057vg" successfully extended
>> [ 1:00.116]   WARNING: This metadata update is NOT backed up.
>> [ 1:00.116] lvremove -ff $vg/$lv1
>> [ 1:00.224] #lvconvert-repair-raid.sh:122+ lvremove -ff LVMTEST14057vg/LV1
>> [ 1:00.224] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 1:00.343]   Logical volume "LV1" successfully removed.
>> [ 1:02.329] 6,2152,1333181226,-;md: mdX: recovery interrupted.
>> [ 1:02.330] 6,2153,1333871935,-;dm-14: detected capacity change from 0 to 131072
>> [ 1:02.330]   WARNING: This metadata update is NOT backed up.
>> [ 1:02.334]
>> [ 1:02.464] # Fast sync and repair afterwards
>> [ 1:02.464] delay 0
>> [ 1:02.464] #lvconvert-repair-raid.sh:125+ delay 0
>> [ 1:02.464] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:02.464] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 0 0 2048
>> [ 1:02.465] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:02.807] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 0 0 2048
>> [ 1:02.807] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:03.153] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 0 0 2048
>> [ 1:03.153] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:03.489] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 0 0 2048
>> [ 1:03.489] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:03.819] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 0 0 2048
>> [ 1:03.819] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:04.099] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 0 0 2048
>> [ 1:04.099] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:04.366] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 0 0 2048
>> [ 1:04.366] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:04.729] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 0 0 2048
>> [ 1:04.729]
>> [ 1:05.076] # RAID6 double replace after initial sync
>> [ 1:05.076] lvcreate --type raid6 -i 3 -L $RAID_SIZE -n $lv1 $vg \
>> [ 1:05.076]     "$dev1" "$dev2" "$dev3" "$dev4" "$dev5"
>> [ 1:05.076] #lvconvert-repair-raid.sh:128+ lvcreate --type raid6 -i 3 -L 64 -n LV1 LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:05.077] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 1:05.200]   Using default stripesize 64.00 KiB.
>> [ 1:05.223]   Rounding size 64.00 MiB (128 extents) up to stripe boundary size 64.50 MiB (129 extents).
>> [ 1:05.283]   Logical volume "LV1" created.
>> [ 1:06.311]   WARNING: This metadata update is NOT backed up.
>> [ 1:06.311] 6,2154,1338663197,-;device-mapper: raid: Superblocks created for new raid set
>> [ 1:06.311] 5,2155,1338767068,-;md/raid:mdX: not clean -- starting background reconstruction
>> [ 1:06.311] 6,2156,1338767440,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 1:06.311] 6,2157,1338767451,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 1:06.311] 6,2158,1338767458,-;md/raid:mdX: device dm-13 operational as raid disk 2
>> [ 1:06.311] 6,2159,1338767465,-;md/raid:mdX: device dm-15 operational as raid disk 3
>> [ 1:06.311] 6,2160,1338767472,-;md/raid:mdX: device dm-17 operational as raid disk 4
>> [ 1:06.311] 6,2161,1338782379,-;md/raid:mdX: raid level 6 active with 5 out of 5 devices, algorithm 8
>> [ 1:06.312] 3,2162,1338782504,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 1:06.312] 3,2163,1338783474,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 1:06.312] 4,2164,1338822872,-;mdX: bitmap file is out of date, doing full recovery
>> [ 1:06.312] 6,2165,1338870932,-;md: resync of RAID array mdX
>> [ 1:06.312] aux wait_for_sync $vg $lv1
>> [ 1:06.475] #lvconvert-repair-raid.sh:130+ aux wait_for_sync LVMTEST14057vg LV1
>> [ 1:06.475] LVMTEST14057vg/LV1 (raid6_zr) is not in-sync     0 132096 raid raid6_zr 5 aaaaa 5520/44032 resync 0 0 -
>> [ 1:06.648] LVMTEST14057vg/LV1 (raid6_zr) is not in-sync     0 132096 raid raid6_zr 5 aaaaa 8280/44032 resync 0 0 -
>> [ 1:06.989] LVMTEST14057vg/LV1 (raid6_zr) is not in-sync     0 132096 raid raid6_zr 5 aaaaa 16560/44032 resync 0 0 -
>> [ 1:07.407] LVMTEST14057vg/LV1 (raid6_zr) is not in-sync     0 132096 raid raid6_zr 5 aaaaa 22080/44032 resync 0 0 -
>> [ 1:07.792] LVMTEST14057vg/LV1 (raid6_zr) is not in-sync     0 132096 raid raid6_zr 5 aaaaa 27600/44032 resync 0 0 -
>> [ 1:08.194] LVMTEST14057vg/LV1 (raid6_zr) is not in-sync     0 132096 raid raid6_zr 5 aaaaa 33120/44032 resync 0 0 -
>> [ 1:08.597] LVMTEST14057vg/LV1 (raid6_zr) is not in-sync     0 132096 raid raid6_zr 5 aaaaa 38640/44032 resync 0 0 -
>> [ 1:09.006] LVMTEST14057vg/LV1 (raid6_zr) is in-sync     0 132096 raid raid6_zr 5 AAAAA 44032/44032 idle 0 0 -
>> [ 1:09.436] 6,2166,1341901914,-;md: mdX: resync done.
>> [ 1:09.436] aux disable_dev "$dev4" "$dev5"
>> [ 1:09.452] #lvconvert-repair-raid.sh:131+ aux disable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:09.453] Disabling device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 (250:3)
>> [ 1:09.869] Disabling device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 (250:4)
>> [ 1:09.990] lvconvert -y --repair $vg/$lv1
>> [ 1:10.076] 3,2167,1342752522,-;Buffer I/O error on dev dm-3, logical block 20464, async page read
>> [ 1:10.076] #lvconvert-repair-raid.sh:132+ lvconvert -y --repair LVMTEST14057vg/LV1
>> [ 1:10.076] File descriptor 6 (/dev/pts/0) leaked on lvm invocation.3,2168,1342825803,-;Buffer I/O error on dev dm-4, logical block 20464, async page read
>> [ 1:10.167]  Parent PID 14057: bash
>> [ 1:10.168]   WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:10.258]   WARNING: Couldn't find device with uuid yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU.
>> [ 1:10.258]   WARNING: VG LVMTEST14057vg is missing PV KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh (last written to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4).
>> [ 1:10.258]   WARNING: VG LVMTEST14057vg is missing PV yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU (last written to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5).
>> [ 1:10.258]   WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:10.260]   WARNING: Couldn't find device with uuid yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU.
>> [ 1:10.260]   WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:10.268]   WARNING: Couldn't find device with uuid yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU.
>> [ 1:10.268]   6,2169,1343066171,-;device-mapper: raid: Device 3 specified for rebuild; clearing superblock
>> [ 1:11.941] 6,2170,1343066185,-;device-mapper: raid: Device 4 specified for rebuild; clearing superblock
>> [ 1:11.941] 6,2171,1343186463,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 1:11.941] 6,2172,1343186478,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 1:11.941] 6,2173,1343186486,-;md/raid:mdX: device dm-13 operational as raid disk 2
>> [ 1:11.941] 6,2174,1343232741,-;md/raid:mdX: raid level 6 active with 3 out of 5 devices, algorithm 8
>> [ 1:11.942] 3,2175,1343241035,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 1:11.942] 3,2176,1343242027,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 1:11.942] 3,2177,1343483803,-;md: super_written gets error=-5
>> [ 1:11.942] 2,2178,1343484871,-;md/raid:mdX: Disk failure on dm-15, disabling device.
>> [ 1:11.942] 2,2179,1343485511,-;md/raid:mdX: Operation continuing on 4 devices.
>> [ 1:11.942] 3,2180,1343486972,-;md: super_written gets error=-5
>> [ 1:11.942] 2,2181,1343487504,-;md/raid:mdX: Disk failure on dm-17, disabling device.
>> [ 1:11.942] 2,2182,1343488132,-;md/raid:mdX: Operation continuing on 3 devices.
>> [ 1:11.942] 6,2183,1343919421,-;md: recovery of RAID array mdX
>> [ 1:11.942] WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:11.944]   WARNING: Couldn't find device with uuid yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU.
>> [ 1:11.944]   Faulty devices in LVMTEST14057vg/LV1 successfully replaced.
>> [ 1:12.751] 6,2184,1344805700,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 1:12.752] 6,2185,1344805719,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 1:12.752] 6,2186,1344805726,-;md/raid:mdX: device dm-13 operational as raid disk 2
>> [ 1:12.752] 6,2187,1344820868,-;md/raid:mdX: raid level 6 active with 3 out of 5 devices, algorithm 8
>> [ 1:12.752] 3,2188,1344821374,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 1:12.752] 3,2189,1344822377,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 1:12.752] 6,2190,1344916074,-;md: mdX: recovery interrupted.
>> [ 1:12.752] 6,2191,1345300828,-;md: recovery of RAID array mdX
>> [ 1:12.752]   WARNING: This metadata update is NOT backed up.
>> [ 1:12.812] vgreduce --removemissing $vg
>> [ 1:13.008] #lvconvert-repair-raid.sh:133+ vgreduce --removemissing LVMTEST14057vg
>> [ 1:13.008] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 1:13.122]   WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:13.204]   WARNING: Couldn't find device with uuid yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU.
>> [ 1:13.205]   WARNING: VG LVMTEST14057vg is missing PV KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh (last written to [unknown]).
>> [ 1:13.206]   WARNING: VG LVMTEST14057vg is missing PV yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU (last written to [unknown]).
>> [ 1:13.206]   WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:13.221]   WARNING: Couldn't find device with uuid yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU.
>> [ 1:13.221]   WARNING: This metadata update is NOT backed up.
>> [ 1:13.227]   Wrote out consistent volume group LVMTEST14057vg.
>> [ 1:13.228] aux enable_dev "$dev4" "$dev5"
>> [ 1:13.403] #lvconvert-repair-raid.sh:134+ aux enable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:13.403] vgck --updatemetadata $vg
>> [ 1:13.939] #lvconvert-repair-raid.sh:135+ vgck --updatemetadata LVMTEST14057vg
>> [ 1:13.939] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 1:14.043]   WARNING: ignoring metadata seqno 41 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 for seqno 44 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 for VG LVMTEST14057vg.
>> [ 1:14.143]   WARNING: ignoring metadata seqno 41 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 for seqno 44 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 for VG LVMTEST14057vg.
>> [ 1:14.144]   WARNING: Inconsistent metadata found for VG LVMTEST14057vg.
>> [ 1:14.149]   See vgck --updatemetadata to correct inconsistency.
>> [ 1:14.149]   WARNING: outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 seqno 41 has been removed in current VG LVMTEST14057vg seqno 44.
>> [ 1:14.149]   See vgck --updatemetadata to clear outdated metadata.
>> [ 1:14.149]   WARNING: outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 seqno 41 has been removed in current VG LVMTEST14057vg seqno 44.
>> [ 1:14.149]   WARNING: wiping mda on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4
>> [ 1:14.152]   WARNING: wiping header on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4
>> [ 1:14.154]   WARNING: wiping mda on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:14.155]   WARNING: wiping header on outdated PV /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:14.155]   WARNING: This metadata update is NOT backed up.
>> [ 1:14.221] vgextend $vg "$dev4" "$dev5"
>> [ 1:14.382] #lvconvert-repair-raid.sh:136+ vgextend LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:14.382] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 1:14.506]   Volume group "LVMTEST14057vg" successfully extended
>> [ 1:14.846]   WARNING: This metadata update is NOT backed up.
>> [ 1:14.846] lvremove -ff $vg/$lv1
>> [ 1:14.994] #lvconvert-repair-raid.sh:137+ lvremove -ff LVMTEST14057vg/LV1
>> [ 1:14.995] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 1:15.088]   Logical volume "LV1" successfully removed.
>> [ 1:16.467] 6,2192,1347971448,-;md: mdX: recovery interrupted.
>> [ 1:16.467] 6,2193,1348091518,-;dm-18: detected capacity change from 0 to 132096
>> [ 1:16.467]   WARNING: This metadata update is NOT backed up.
>> [ 1:16.478]
>> [ 1:16.600] # Delayed sync to allow for repair during rebuild
>> [ 1:16.600] delay 50
>> [ 1:16.600] #lvconvert-repair-raid.sh:140+ delay 50
>> [ 1:16.601] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:16.601] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 0 50 2048
>> [ 1:16.601] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:16.940] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 0 50 2048
>> [ 1:16.940] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:17.219] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 0 50 2048
>> [ 1:17.219] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:17.492] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 0 50 2048
>> [ 1:17.492] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:17.804] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 0 50 2048
>> [ 1:17.804] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:18.172] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 0 50 2048
>> [ 1:18.173] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:18.445] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 0 50 2048
>> [ 1:18.445] #lvconvert-repair-raid.sh:32+ for d in "${DEVICES[@]}"
>> [ 1:18.745] #lvconvert-repair-raid.sh:33+ aux delay_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 0 50 2048
>> [ 1:18.745]
>> [ 1:19.057] # RAID6 single replace after initial sync
>> [ 1:19.057] lvcreate --type raid6 -i 3 -L $RAID_SIZE -n $lv1 $vg \
>> [ 1:19.057]     "$dev1" "$dev2" "$dev3" "$dev4" "$dev5"
>> [ 1:19.057] #lvconvert-repair-raid.sh:143+ lvcreate --type raid6 -i 3 -L 64 -n LV1 LVMTEST14057vg /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:19.057] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 14057: bash
>> [ 1:19.218]   Using default stripesize 64.00 KiB.
>> [ 1:19.242]   Rounding size 64.00 MiB (128 extents) up to stripe boundary size 64.50 MiB (129 extents).
>> [ 1:19.323]   Logical volume "LV1" created.
>> [ 1:21.584]   WARNING: This metadata update is NOT backed up.
>> [ 1:21.584] 3,2194,1352999605,-;debugfs: Directory 'bio-296' with parent 'slab' already present!
>> [ 1:21.585] 6,2195,1353160076,-;device-mapper: raid: Superblocks created for new raid set
>> [ 1:21.585] 5,2196,1353252344,-;md/raid:mdX: not clean -- starting background reconstruction
>> [ 1:21.585] 6,2197,1353252714,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 1:21.585] 6,2198,1353252724,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 1:21.585] 6,2199,1353252731,-;md/raid:mdX: device dm-13 operational as raid disk 2
>> [ 1:21.585] 6,2200,1353252738,-;md/raid:mdX: device dm-15 operational as raid disk 3
>> [ 1:21.585] 6,2201,1353252745,-;md/raid:mdX: device dm-17 operational as raid disk 4
>> [ 1:21.585] 6,2202,1353270247,-;md/raid:mdX: raid level 6 active with 5 out of 5 devices, algorithm 8
>> [ 1:21.585] 3,2203,1353270366,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 1:21.585] 3,2204,1353271482,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 1:21.586] 6,2205,1353282458,-;md: resync of RAID array mdX
>> [ 1:21.586] 6,2206,1353282481,-;md: mdX: resync done.
>> [ 1:21.586] 4,2207,1353667724,-;mdX: bitmap file is out of date, doing full recovery
>> [ 1:21.586] aux disable_dev "$dev4"
>> [ 1:21.742] #lvconvert-repair-raid.sh:145+ aux disable_dev /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4
>> [ 1:21.742] Disabling device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 (250:3)
>> [ 1:22.135] not lvconvert -y --repair $vg/$lv1
>> [ 1:22.202] #lvconvert-repair-raid.sh:146+ not lvconvert -y --repair LVMTEST14057vg/LV1
>> [ 1:22.202] File descriptor 6 (/dev/pts/0) leaked on lvm invocation. Parent PID 15859: not
>> [ 1:22.372] 3,2208,1354982730,-;Buffer I/O error on dev dm-3, logical block 20464, async page read
>> [ 1:22.372]   WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:22.440]   WARNING: VG LVMTEST14057vg is missing PV KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh (last written to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4).
>> [ 1:22.440]   WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:22.442]   WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:22.449]   6,2209,1355228170,-;device-mapper: raid: Device 3 specified for rebuild; clearing superblock
>> [ 1:24.297] 6,2210,1355355934,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 1:24.297] 6,2211,1355355951,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 1:24.297] 6,2212,1355355958,-;md/raid:mdX: device dm-13 operational as raid disk 2
>> [ 1:24.297] 6,2213,1355355965,-;md/raid:mdX: device dm-17 operational as raid disk 4
>> [ 1:24.297] 6,2214,1355368557,-;md/raid:mdX: raid level 6 active with 4 out of 5 devices, algorithm 8
>> [ 1:24.298] 3,2215,1355369058,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 1:24.298] 3,2216,1355370045,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 1:24.298] 3,2217,1355516877,-;md: super_written gets error=-5
>> [ 1:24.298] 2,2218,1355518177,-;md/raid:mdX: Disk failure on dm-15, disabling device.
>> [ 1:24.298] 2,2219,1355519167,-;md/raid:mdX: Operation continuing on 4 devices.
>> [ 1:24.298] 6,2220,1356782405,-;md: recovery of RAID array mdX
>> [ 1:24.298] WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:24.299]   Faulty devices in LVMTEST14057vg/LV1 successfully replaced.
>> [ 1:26.081] 6,2221,1357201132,-;md/raid:mdX: device dm-9 operational as raid disk 0
>> [ 1:26.081] 6,2222,1357201168,-;md/raid:mdX: device dm-11 operational as raid disk 1
>> [ 1:26.081] 6,2223,1357201189,-;md/raid:mdX: device dm-13 operational as raid disk 2
>> [ 1:26.081] 6,2224,1357201208,-;md/raid:mdX: device dm-17 operational as raid disk 4
>> [ 1:26.081] 6,2225,1357225585,-;md/raid:mdX: raid level 6 active with 4 out of 5 devices, algorithm 8
>> [ 1:26.081] 3,2226,1357226866,-;device-mapper: raid: raid456 discard support disabled due to discard_zeroes_data uncertainty.
>> [ 1:26.081] 3,2227,1357228199,-;device-mapper: raid: Set dm-raid.devices_handle_discard_safely=Y to override.
>> [ 1:26.081] 6,2228,1357352679,-;md: mdX: recovery interrupted.
>> [ 1:26.082] 6,2229,1358771010,-;md: recovery of RAID array mdX
>> [ 1:26.082]   WARNING: This metadata update is NOT backed up.
>> [ 1:26.117] set +vx; STACKTRACE; set -vx
>> [ 1:26.291] ##lvconvert-repair-raid.sh:146+ set +vx
>> [ 1:26.291] ## - /mnt/test/lvm2/test/shell/lvconvert-repair-raid.sh:146
>> [ 1:26.291] ## 1 STACKTRACE() called from /mnt/test/lvm2/test/shell/lvconvert-repair-raid.sh:146
>> [ 1:26.291] ## ERROR: The test started dmeventd (14314) unexpectedly.
>> [ 1:26.544] <======== Debug log debug.log_DEBUG_15860_135428 ========>
>> [ 1:27.494] ## DEBUG0: 01:25:00.400622 none[15860] config/config.c:1508  log/debug_classes not found in config: defaulting to debug_classes = [ "memory", "devices", "io", "activation", "allocation", "metadata", "cache", "locking", "lvmpolld", "dbus" ]
>> [ 1:27.557] ## DEBUG0: 01:25:00.400795 none[15860] commands/toolcontext.c:433  Setting log debug classes to 2031
>> [ 1:27.557] ## DEBUG0: 01:25:00.400848 none[15860] config/config.c:1508  log/debug_file_fields not found in config: defaulting to debug_file_fields = [ "time", "command", "fileline", "message" ]
>> [ 1:27.557] ## DEBUG0: 01:25:00.400878 none[15860] config/config.c:1508  log/debug_output_fields not found in config: defaulting to debug_output_fields = [ "time", "command", "fileline", "message" ]
>> [ 1:27.557] ## DEBUG0: 01:25:00.400904 none[15860] config/config.c:1508  log/journal not found in config: defaulting to journal = [ ]
>> [ 1:27.557] ## DEBUG0: 01:25:00.400926 none[15860] commands/toolcontext.c:359  log/journal contains a value which is not a string.  Ignoring.
>> [ 1:27.557] ## DEBUG0: 01:25:00.400951 none[15860] commands/toolcontext.c:445  Logging initialised at Tue Feb  6 01:25:00 2024
>> [ 1:27.557] ## DEBUG0: 01:25:00.401055 none[15860] device_mapper/libdm-config.c:1085  config/checks not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.401081 none[15860] device_mapper/libdm-config.c:1085  config/abort_on_errors not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.401104 none[15860] device_mapper/libdm-config.c:1085  config/checks not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.401419 none[15860] device_mapper/libdm-config.c:1013  global/umask not found in config: defaulting to 63
>> [ 1:27.557] ## DEBUG0: 01:25:00.401445 none[15860] commands/toolcontext.c:671  Set umask from 0022 to 0077
>> [ 1:27.557] ## DEBUG0: 01:25:00.401494 none[15860] device_mapper/libdm-config.c:986  devices/device_id_sysfs_dir not found in config: defaulting to "/sys/"
>> [ 1:27.557] ## DEBUG0: 01:25:00.401519 none[15860] device_mapper/libdm-config.c:986  devices/external_device_info_source not found in config: defaulting to "none"
>> [ 1:27.557] ## DEBUG0: 01:25:00.401543 none[15860] device_mapper/libdm-config.c:986  global/proc not found in config: defaulting to "/proc"
>> [ 1:27.557] ## DEBUG0: 01:25:00.402099 none[15860] device_mapper/libdm-config.c:1085  global/activation not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.402149 none[15860] device_mapper/libdm-config.c:1085  activation/auto_set_activation_skip not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.402173 none[15860] device_mapper/libdm-config.c:986  activation/readahead not found in config: defaulting to "auto"
>> [ 1:27.557] ## DEBUG0: 01:25:00.402199 none[15860] device_mapper/libdm-config.c:1085  devices/issue_discards not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.402223 none[15860] misc/lvm-globals.c:203  LVM activation checks enabled
>> [ 1:27.557] ## DEBUG0: 01:25:00.402246 none[15860] device_mapper/libdm-config.c:1085  activation/use_linear_target not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.402269 none[15860] device_mapper/libdm-config.c:986  activation/missing_stripe_filler not found in config: defaulting to "error"
>> [ 1:27.557] ## DEBUG0: 01:25:00.402294 none[15860] device_mapper/libdm-config.c:1085  global/metadata_read_only not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.402317 none[15860] device_mapper/libdm-config.c:1013  devices/pv_min_size not found in config: defaulting to 2048
>> [ 1:27.557] ## DEBUG0: 01:25:00.402340 none[15860] device_mapper/libdm-config.c:1085  metadata/check_pv_device_sizes not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.402362 none[15860] device_mapper/libdm-config.c:1085  global/event_activation not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.402386 none[15860] device_mapper/libdm-config.c:986  global/units not found in config: defaulting to "r"
>> [ 1:27.557] ## DEBUG0: 01:25:00.402409 none[15860] device_mapper/libdm-config.c:1085  report/binary_values_as_numeric not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.402432 none[15860] device_mapper/libdm-config.c:1085  report/mark_hidden_devices not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.402454 none[15860] device_mapper/libdm-config.c:1085  global/suffix not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.402477 none[15860] device_mapper/libdm-config.c:986  report/list_item_separator not found in config: defaulting to ","
>> [ 1:27.557] ## DEBUG0: 01:25:00.402500 none[15860] device_mapper/libdm-config.c:986  report/time_format not found in config: defaulting to "%Y-%m-%d %T %z"
>> [ 1:27.557] ## DEBUG0: 01:25:00.402553 none[15860] device_mapper/libdm-config.c:1085  report/two_word_unknown_device not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.402631 none[15860] device_mapper/libdm-config.c:986  global/system_id_source not found in config: defaulting to "none"
>> [ 1:27.557] ## DEBUG0: 01:25:00.402656 none[15860] device_mapper/libdm-config.c:1085  devices/device_ids_refresh not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.402717 none[15860] config/config.c:1508  devices/device_ids_refresh_checks not found in config: defaulting to device_ids_refresh_checks = [ "product_uuid", "hostname" ]
>> [ 1:27.557] ## DEBUG0: 01:25:00.402836 none[15860] device_mapper/libdm-config.c:1013  global/io_memory_size not found in config: defaulting to 8192
>> [ 1:27.557] ## DEBUG0: 01:25:00.402882 none[15860] device_mapper/libdm-config.c:986  config/profile_dir not found in config: defaulting to "/mnt/test/LVMTEST14057.I4CHaFJWdP/etc/profile"
>> [ 1:27.557] ## DEBUG0: 01:25:00.404050 none[15860] device_mapper/libdm-config.c:1085  global/use_aio not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.404165 none[15860] device/dev-cache.c:1224  devices/preferred_names not found in config: using built-in preferences
>> [ 1:27.557] ## DEBUG0: 01:25:00.404190 none[15860] device_mapper/libdm-config.c:1085  devices/obtain_device_list_from_udev not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.404216 none[15860] config/config.c:1511  Setting devices/scan to scan = [ "/mnt/test/LVMTEST14057.I4CHaFJWdP/dev" ]
>> [ 1:27.557] ## DEBUG0: 01:25:00.404289 none[15860] device_mapper/libdm-config.c:1013  activation/reserved_stack not found in config: defaulting to 64
>> [ 1:27.557] ## DEBUG0: 01:25:00.404336 none[15860] device_mapper/libdm-config.c:1013  activation/reserved_memory not found in config: defaulting to 8192
>> [ 1:27.557] ## DEBUG0: 01:25:00.404361 none[15860] device_mapper/libdm-config.c:1013  activation/process_priority not found in config: defaulting to -18
>> [ 1:27.557] ## DEBUG0: 01:25:00.404432 none[15860] metadata/vg.c:65  Allocated VG #orphans_lvm2 at 0x5624633141f0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.404481 none[15860] format_text/format-text.c:2646  Initialised format: lvm2
>> [ 1:27.557] ## DEBUG0: 01:25:00.404526 none[15860] striped/striped.c:245  Initialised segtype: linear
>> [ 1:27.557] ## DEBUG0: 01:25:00.404550 none[15860] striped/striped.c:245  Initialised segtype: striped
>> [ 1:27.557] ## DEBUG0: 01:25:00.404572 none[15860] zero/zero.c:99  Initialised segtype: zero
>> [ 1:27.557] ## DEBUG0: 01:25:00.404595 none[15860] error/errseg.c:105  Initialised segtype: error
>> [ 1:27.557] ## DEBUG0: 01:25:00.404617 none[15860] snapshot/snapshot.c:274  Initialised segtype: snapshot
>> [ 1:27.557] ## DEBUG0: 01:25:00.404640 none[15860] mirror/mirrored.c:539  Initialised segtype: mirror
>> [ 1:27.557] ## DEBUG0: 01:25:00.404662 none[15860] raid/raid.c:694  Initialised segtype: raid0
>> [ 1:27.557] ## DEBUG0: 01:25:00.404693 none[15860] raid/raid.c:694  Initialised segtype: raid0_meta
>> [ 1:27.557] ## DEBUG0: 01:25:00.404734 none[15860] raid/raid.c:694  Initialised segtype: raid1
>> [ 1:27.557] ## DEBUG0: 01:25:00.404758 none[15860] raid/raid.c:694  Initialised segtype: raid10
>> [ 1:27.557] ## DEBUG0: 01:25:00.404780 none[15860] raid/raid.c:694  Initialised segtype: raid10_near
>> [ 1:27.557] ## DEBUG0: 01:25:00.404803 none[15860] raid/raid.c:694  Initialised segtype: raid4
>> [ 1:27.557] ## DEBUG0: 01:25:00.404825 none[15860] raid/raid.c:694  Initialised segtype: raid5
>> [ 1:27.557] ## DEBUG0: 01:25:00.404848 none[15860] raid/raid.c:694  Initialised segtype: raid5_n
>> [ 1:27.557] ## DEBUG0: 01:25:00.404870 none[15860] raid/raid.c:694  Initialised segtype: raid5_la
>> [ 1:27.557] ## DEBUG0: 01:25:00.404892 none[15860] raid/raid.c:694  Initialised segtype: raid5_ls
>> [ 1:27.557] ## DEBUG0: 01:25:00.404914 none[15860] raid/raid.c:694  Initialised segtype: raid5_ra
>> [ 1:27.557] ## DEBUG0: 01:25:00.404937 none[15860] raid/raid.c:694  Initialised segtype: raid5_rs
>> [ 1:27.557] ## DEBUG0: 01:25:00.404959 none[15860] raid/raid.c:694  Initialised segtype: raid6
>> [ 1:27.557] ## DEBUG0: 01:25:00.404981 none[15860] raid/raid.c:694  Initialised segtype: raid6_n_6
>> [ 1:27.557] ## DEBUG0: 01:25:00.405003 none[15860] raid/raid.c:694  Initialised segtype: raid6_nc
>> [ 1:27.557] ## DEBUG0: 01:25:00.405026 none[15860] raid/raid.c:694  Initialised segtype: raid6_nr
>> [ 1:27.557] ## DEBUG0: 01:25:00.405048 none[15860] raid/raid.c:694  Initialised segtype: raid6_zr
>> [ 1:27.557] ## DEBUG0: 01:25:00.405070 none[15860] raid/raid.c:694  Initialised segtype: raid6_ls_6
>> [ 1:27.557] ## DEBUG0: 01:25:00.405092 none[15860] raid/raid.c:694  Initialised segtype: raid6_rs_6
>> [ 1:27.557] ## DEBUG0: 01:25:00.405114 none[15860] raid/raid.c:694  Initialised segtype: raid6_la_6
>> [ 1:27.557] ## DEBUG0: 01:25:00.405137 none[15860] raid/raid.c:694  Initialised segtype: raid6_ra_6
>> [ 1:27.557] ## DEBUG0: 01:25:00.405159 none[15860] thin/thin.c:825  Initialised segtype: thin-pool
>> [ 1:27.557] ## DEBUG0: 01:25:00.405182 none[15860] thin/thin.c:825  Initialised segtype: thin
>> [ 1:27.557] ## DEBUG0: 01:25:00.405205 none[15860] cache_segtype/cache.c:837  Initialised segtype: cache-pool
>> [ 1:27.557] ## DEBUG0: 01:25:00.405253 none[15860] cache_segtype/cache.c:851  Initialised segtype: cache
>> [ 1:27.557] ## DEBUG0: 01:25:00.405331 none[15860] vdo/vdo.c:638  Initialised segtypes: vdo, vdo-pool.
>> [ 1:27.557] ## DEBUG0: 01:25:00.405356 none[15860] writecache/writecache.c:389  Initialised segtype: writecache
>> [ 1:27.557] ## DEBUG0: 01:25:00.405379 none[15860] integrity/integrity.c:339  Initialised segtype: integrity
>> [ 1:27.557] ## DEBUG0: 01:25:00.405403 none[15860] device_mapper/libdm-config.c:1013  backup/retain_days not found in config: defaulting to 30
>> [ 1:27.557] ## DEBUG0: 01:25:00.405426 none[15860] device_mapper/libdm-config.c:1013  backup/retain_min not found in config: defaulting to 10
>> [ 1:27.557] ## DEBUG0: 01:25:00.405468 none[15860] device_mapper/libdm-config.c:986  backup/archive_dir not found in config: defaulting to "/mnt/test/LVMTEST14057.I4CHaFJWdP/etc/archive"
>> [ 1:27.557] ## DEBUG0: 01:25:00.405534 none[15860] device_mapper/libdm-config.c:986  backup/backup_dir not found in config: defaulting to "/mnt/test/LVMTEST14057.I4CHaFJWdP/etc/backup"
>> [ 1:27.557] ## DEBUG0: 01:25:00.410253 none[15860] device_mapper/libdm-config.c:1085  log/command_names not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.410473 lvconvert[15860] lvmcmdline.c:3178  Version: 2.03.24(2)-git (2023-11-21)
>> [ 1:27.557] ## DEBUG0: 01:25:00.410500 lvconvert[15860] lvmcmdline.c:3179  Parsing: lvconvert -y --repair LVMTEST14057vg/LV1
>> [ 1:27.557] ## DEBUG0: 01:25:00.410531 lvconvert[15860] lvmcmdline.c:2046  Recognised command lvconvert_repair (id 47 / enum 25).
>> [ 1:27.557] ## DEBUG0: 01:25:00.410910 lvconvert[15860] filters/filter-regex.c:248  Regex filter initialised.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411000 lvconvert[15860] filters/filter-regex.c:248  Regex filter initialised.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411024 lvconvert[15860] filters/filter-type.c:61  LVM type filter initialised.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411047 lvconvert[15860] filters/filter-deviceid.c:66  deviceid filter initialised.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411126 lvconvert[15860] filters/filter-sysfs.c:99  Sysfs filter initialised.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411152 lvconvert[15860] device_mapper/libdm-config.c:1085  devices/scan_lvs not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.411174 lvconvert[15860] filters/filter-usable.c:144  Usable device filter initialised (scan_lvs 0).
>> [ 1:27.557] ## DEBUG0: 01:25:00.411197 lvconvert[15860] device_mapper/libdm-config.c:1085  devices/multipath_component_detection not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.411220 lvconvert[15860] filters/filter-mpath.c:87  mpath filter initialised.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411243 lvconvert[15860] filters/filter-partitioned.c:68  Partitioned filter initialised.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411265 lvconvert[15860] filters/filter-signature.c:88  signature filter initialised.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411289 lvconvert[15860] device_mapper/libdm-config.c:1085  devices/fw_raid_component_detection not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.411311 lvconvert[15860] filters/filter-composite.c:98  Composite filter initialised.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411334 lvconvert[15860] device_mapper/libdm-config.c:1085  devices/ignore_suspended_devices not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.411357 lvconvert[15860] device_mapper/libdm-config.c:1085  devices/ignore_lvm_mirrors not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.411399 lvconvert[15860] filters/filter-persistent.c:187  Persistent filter initialised.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411424 lvconvert[15860] device_mapper/libdm-config.c:1085  devices/scan_lvs not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.411448 lvconvert[15860] device_mapper/libdm-config.c:1085  devices/allow_mixed_block_sizes not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.411471 lvconvert[15860] device_mapper/libdm-config.c:986  devices/hints not found in config: defaulting to "all"
>> [ 1:27.557] ## DEBUG0: 01:25:00.411496 lvconvert[15860] device_mapper/libdm-config.c:986  activation/activation_mode not found in config: defaulting to "degraded"
>> [ 1:27.557] ## DEBUG0: 01:25:00.411520 lvconvert[15860] device_mapper/libdm-config.c:1085  metadata/record_lvs_history not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.411543 lvconvert[15860] device_mapper/libdm-config.c:986  devices/search_for_devnames not found in config: defaulting to "all"
>> [ 1:27.557] ## DEBUG0: 01:25:00.411568 lvconvert[15860] lvmcmdline.c:3253  DEGRADED MODE. Incomplete RAID LVs will be processed.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411627 lvconvert[15860] lvmcmdline.c:3259  Processing command: lvconvert -y --repair LVMTEST14057vg/LV1
>> [ 1:27.557] ## DEBUG0: 01:25:00.411652 lvconvert[15860] lvmcmdline.c:3260  Command pid: 15860
>> [ 1:27.557] ## DEBUG0: 01:25:00.411712 lvconvert[15860] lvmcmdline.c:3261  System ID:
>> [ 1:27.557] ## DEBUG0: 01:25:00.411736 lvconvert[15860] lvmcmdline.c:3264  O_DIRECT will be used
>> [ 1:27.557] ## DEBUG0: 01:25:00.411762 lvconvert[15860] device_mapper/libdm-config.c:1085  global/wait_for_locks not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.411784 lvconvert[15860] locking/locking.c:141  File locking settings: readonly:0 sysinit:0 ignorelockingfailure:0 global/metadata_read_only:0 global/wait_for_locks:1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.411837 lvconvert[15860] device_mapper/libdm-config.c:1085  global/prioritise_write_locks not found in config: defaulting to 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.411939 lvconvert[15860] device_mapper/libdm-config.c:986  devices/md_component_checks not found in config: defaulting to "auto"
>> [ 1:27.557] ## DEBUG0: 01:25:00.411963 lvconvert[15860] lvmcmdline.c:3080  Using md_component_checks auto use_full_md_check 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.411986 lvconvert[15860] device_mapper/libdm-config.c:986  devices/multipath_wwids_file not found in config: defaulting to "/etc/multipath/wwids"
>> [ 1:27.557] ## DEBUG0: 01:25:00.412139 lvconvert[15860] device/dev-mpath.c:254  multipath wwids read 4 from /etc/multipath/wwids
>> [ 1:27.557] ## DEBUG0: 01:25:00.412313 lvconvert[15860] device_mapper/libdm-config.c:986  report/output_format not found in config: defaulting to "basic"
>> [ 1:27.557] ## DEBUG0: 01:25:00.412340 lvconvert[15860] device_mapper/libdm-config.c:1085  log/report_command_log not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.412367 lvconvert[15860] cache/lvmcache.c:1603  lvmcache label scan begin
>> [ 1:27.557] ## DEBUG0: 01:25:00.412389 lvconvert[15860] label/label.c:1262  Finding devices to scan
>> [ 1:27.557] ## DEBUG0: 01:25:00.412984 lvconvert[15860] device/dev-cache.c:1196  Creating list of system devices.
>> [ 1:27.557] ## DEBUG0: 01:25:00.413709 lvconvert[15860] device/dev-cache.c:754  Found dev 250:18 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/LVMTEST14057vg/LV1 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.413776 lvconvert[15860] device/dev-cache.c:754  Found dev 7:0 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop0 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.413835 lvconvert[15860] device/dev-cache.c:754  Found dev 7:1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop1 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.413898 lvconvert[15860] device/dev-cache.c:754  Found dev 7:2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop2 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.413973 lvconvert[15860] device/dev-cache.c:754  Found dev 7:3 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop3 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414032 lvconvert[15860] device/dev-cache.c:754  Found dev 7:4 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop4 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414090 lvconvert[15860] device/dev-cache.c:754  Found dev 7:5 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop5 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414151 lvconvert[15860] device/dev-cache.c:754  Found dev 7:6 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop6 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414209 lvconvert[15860] device/dev-cache.c:754  Found dev 7:7 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop7 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414521 lvconvert[15860] device/dev-cache.c:754  Found dev 250:0 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414582 lvconvert[15860] device/dev-cache.c:754  Found dev 250:1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414641 lvconvert[15860] device/dev-cache.c:754  Found dev 250:2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414736 lvconvert[15860] device/dev-cache.c:754  Found dev 250:3 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414798 lvconvert[15860] device/dev-cache.c:754  Found dev 250:4 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414870 lvconvert[15860] device/dev-cache.c:754  Found dev 250:5 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414929 lvconvert[15860] device/dev-cache.c:754  Found dev 250:6 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.414987 lvconvert[15860] device/dev-cache.c:754  Found dev 250:7 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415047 lvconvert[15860] device/dev-cache.c:779  Found dev 250:18 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1 - new alias.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415128 lvconvert[15860] device/dev-cache.c:754  Found dev 250:9 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_0 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415216 lvconvert[15860] device/dev-cache.c:754  Found dev 250:11 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_1 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415288 lvconvert[15860] device/dev-cache.c:754  Found dev 250:13 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_2 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415348 lvconvert[15860] device/dev-cache.c:754  Found dev 250:15 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_3 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415407 lvconvert[15860] device/dev-cache.c:754  Found dev 250:17 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_4 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415504 lvconvert[15860] device/dev-cache.c:754  Found dev 250:8 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_0 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415565 lvconvert[15860] device/dev-cache.c:754  Found dev 250:10 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_1 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415623 lvconvert[15860] device/dev-cache.c:754  Found dev 250:12 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_2 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415688 lvconvert[15860] device/dev-cache.c:754  Found dev 250:14 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_3 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415760 lvconvert[15860] device/dev-cache.c:754  Found dev 250:16 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_4 - new.
>> [ 1:27.557] ## DEBUG0: 01:25:00.415856 lvconvert[15860] label/label.c:1338  Filtering devices to scan (nodata)
>> [ 1:27.557] ## DEBUG0: 01:25:00.416294 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop0: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.417864 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm version   [ opencount flush ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.417969 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:0) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.418122 lvconvert[15860] device/dev-io.c:120  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1: size is 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.418167 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.418191 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.418216 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop1: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.418303 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:1) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.418568 lvconvert[15860] device/dev-io.c:120  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2: size is 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.418704 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.418734 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.418750 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop2: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.418835 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:2) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.418978 lvconvert[15860] device/dev-io.c:120  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3: size is 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.419022 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.419046 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.419070 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop3: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.419150 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:3) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.419197 lvconvert[15860] activate/dev_manager.c:809  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4: Error device LVMTEST14057pv4 not usable.
>> [ 1:27.557] ## DEBUG0: 01:25:00.419249 lvconvert[15860] filters/filter-usable.c:95  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4: Skipping unusable device.
>> [ 1:27.557] ## DEBUG0: 01:25:00.419274 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop4: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.419360 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:4) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.419492 lvconvert[15860] device/dev-io.c:120  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5: size is 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.419534 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.419558 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.419582 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop5: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.419661 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:5) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.419799 lvconvert[15860] device/dev-io.c:120  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6: size is 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.419843 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.419867 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.419891 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop6: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.419986 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:6) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420114 lvconvert[15860] device/dev-io.c:120  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7: size is 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.420158 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.420182 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.420206 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/loop7: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420286 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:7) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420414 lvconvert[15860] device/dev-io.c:120  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8: size is 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.420457 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.420481 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.420531 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_0: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420557 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_0: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420581 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_1: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420605 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_1: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420629 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_2: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420653 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_2: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420677 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_3: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420709 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_3: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420733 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_4: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420801 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_4: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420827 lvconvert[15860] filters/filter-regex.c:199  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/LVMTEST14057vg/LV1: Skipping (regex)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420850 lvconvert[15860] label/label.c:1356  Filtering devices to scan done (nodata)
>> [ 1:27.557] ## DEBUG0: 01:25:00.420882 lvconvert[15860] label/label.c:835  Checking fd limit for num_devs 7 want 39 soft 65535 hard 65535
>> [ 1:27.557] ## DEBUG0: 01:25:00.420905 lvconvert[15860] label/label.c:640  Scanning 7 devices for VG info
>> [ 1:27.557] ## DEBUG0: 01:25:00.421009 lvconvert[15860] label/label.c:568  open /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 ro di 0 fd 5
>> [ 1:27.557] ## DEBUG0: 01:25:00.421832 lvconvert[15860] label/label.c:568  open /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 ro di 1 fd 6
>> [ 1:27.557] ## DEBUG0: 01:25:00.422579 lvconvert[15860] label/label.c:568  open /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 ro di 2 fd 7
>> [ 1:27.557] ## DEBUG0: 01:25:00.423342 lvconvert[15860] label/label.c:568  open /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 ro di 3 fd 8
>> [ 1:27.557] ## DEBUG0: 01:25:00.424088 lvconvert[15860] label/label.c:568  open /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 ro di 4 fd 9
>> [ 1:27.557] ## DEBUG0: 01:25:00.424851 lvconvert[15860] label/label.c:568  open /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 ro di 5 fd 10
>> [ 1:27.557] ## DEBUG0: 01:25:00.425592 lvconvert[15860] label/label.c:568  open /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 ro di 6 fd 11
>> [ 1:27.557] ## DEBUG0: 01:25:00.426316 lvconvert[15860] label/label.c:679  Scanning submitted 7 reads
>> [ 1:27.557] ## DEBUG0: 01:25:00.426367 lvconvert[15860] label/label.c:713  Processing data from device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 250:0 di 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.426463 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:0) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.426534 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.426562 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.426588 lvconvert[15860] label/label.c:311  Found label at sector 1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.426611 lvconvert[15860] cache/lvmcache.c:2499  Found PVID KGKo8r5nBBUF0yOVekDNBwdXHTul1HQy on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.426636 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1: now in VG #orphans_lvm2 #orphans_lvm2
>> [ 1:27.557] ## DEBUG0: 01:25:00.426662 lvconvert[15860] format_text/text_label.c:538  Scanning /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 mda1 summary.
>> [ 1:27.557] ## DEBUG0: 01:25:00.426699 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.426727 lvconvert[15860] format_text/import.c:57  Reading metadata summary from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 220672 size 5898 (+0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.427901 lvconvert[15860] format_text/format-text.c:1575  Found metadata summary on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 220672 size 5898 for VG LVMTEST14057vg
>> [ 1:27.557] ## DEBUG0: 01:25:00.427944 lvconvert[15860] cache/lvmcache.c:1941  lvmcache adding vginfo for LVMTEST14057vg lQw2ng-FY0B-bmyz-g1PY-qfGt-GLNL-Hm8szC
>> [ 1:27.557] ## DEBUG0: 01:25:00.427969 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1: now in VG LVMTEST14057vg lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC
>> [ 1:27.557] ## DEBUG0: 01:25:00.427992 lvconvert[15860] cache/lvmcache.c:1862  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1: VG LVMTEST14057vg: set VGID to lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC.
>> [ 1:27.557] ## DEBUG0: 01:25:00.428014 lvconvert[15860] cache/lvmcache.c:2218  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 mda1 VG LVMTEST14057vg set seqno 49 checksum f1a3ef92 mda_size 5898
>> [ 1:27.557] ## DEBUG0: 01:25:00.428067 lvconvert[15860] cache/lvmcache.c:2056  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1: VG LVMTEST14057vg: set creation host to fedora.
>> [ 1:27.557] ## DEBUG0: 01:25:00.428091 lvconvert[15860] format_text/text_label.c:566  Found metadata seqno 49 in mda1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.428115 lvconvert[15860] label/label.c:713  Processing data from device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 250:1 di 1
>> [ 1:27.557] ## DEBUG0: 01:25:00.428221 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:1) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.428281 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.428307 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.428443 lvconvert[15860] label/label.c:311  Found label at sector 1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.428551 lvconvert[15860] cache/lvmcache.c:2499  Found PVID TfPnvTXdxsqRMnu01cMTTa8Pm1EmtnnD on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.428577 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2: now in VG #orphans_lvm2 #orphans_lvm2
>> [ 1:27.557] ## DEBUG0: 01:25:00.428601 lvconvert[15860] format_text/text_label.c:538  Scanning /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 mda1 summary.
>> [ 1:27.557] ## DEBUG0: 01:25:00.428624 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.428649 lvconvert[15860] format_text/format-text.c:1550  Skipping read of already known VG metadata with matching mda checksum on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.428672 lvconvert[15860] format_text/format-text.c:1575  Found metadata summary on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 139264 size 5898 for VG LVMTEST14057vg
>> [ 1:27.557] ## DEBUG0: 01:25:00.428708 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2: now in VG LVMTEST14057vg lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC
>> [ 1:27.557] ## DEBUG0: 01:25:00.428733 lvconvert[15860] format_text/text_label.c:566  Found metadata seqno 49 in mda1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.428760 lvconvert[15860] label/label.c:713  Processing data from device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 250:2 di 2
>> [ 1:27.557] ## DEBUG0: 01:25:00.428847 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:2) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.428899 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.428924 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.428949 lvconvert[15860] label/label.c:311  Found label at sector 1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.428971 lvconvert[15860] cache/lvmcache.c:2499  Found PVID AYf3Vepu0jhNhnxcq7SnbPekA58P01Ck on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.428995 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3: now in VG #orphans_lvm2 #orphans_lvm2
>> [ 1:27.557] ## DEBUG0: 01:25:00.429018 lvconvert[15860] format_text/text_label.c:538  Scanning /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 mda1 summary.
>> [ 1:27.557] ## DEBUG0: 01:25:00.429040 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.429065 lvconvert[15860] format_text/format-text.c:1550  Skipping read of already known VG metadata with matching mda checksum on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.429087 lvconvert[15860] format_text/format-text.c:1575  Found metadata summary on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 62976 size 5898 for VG LVMTEST14057vg
>> [ 1:27.557] ## DEBUG0: 01:25:00.429138 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3: now in VG LVMTEST14057vg lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC
>> [ 1:27.557] ## DEBUG0: 01:25:00.429161 lvconvert[15860] format_text/text_label.c:566  Found metadata seqno 49 in mda1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.429184 lvconvert[15860] label/label.c:713  Processing data from device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 250:4 di 3
>> [ 1:27.557] ## DEBUG0: 01:25:00.429265 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:4) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.429314 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.429339 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.429363 lvconvert[15860] label/label.c:311  Found label at sector 1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.429386 lvconvert[15860] cache/lvmcache.c:2499  Found PVID yT23m1WG8Ixw0d8BCseGkGr6YE3ITFWU on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.429409 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5: now in VG #orphans_lvm2 #orphans_lvm2
>> [ 1:27.557] ## DEBUG0: 01:25:00.429432 lvconvert[15860] format_text/text_label.c:538  Scanning /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 mda1 summary.
>> [ 1:27.557] ## DEBUG0: 01:25:00.429455 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.429479 lvconvert[15860] format_text/format-text.c:1550  Skipping read of already known VG metadata with matching mda checksum on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5.
>> [ 1:27.557] ## DEBUG0: 01:25:00.429501 lvconvert[15860] format_text/format-text.c:1575  Found metadata summary on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 19456 size 5898 for VG LVMTEST14057vg
>> [ 1:27.557] ## DEBUG0: 01:25:00.429524 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5: now in VG LVMTEST14057vg lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC
>> [ 1:27.557] ## DEBUG0: 01:25:00.429547 lvconvert[15860] format_text/text_label.c:566  Found metadata seqno 49 in mda1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.429569 lvconvert[15860] label/label.c:713  Processing data from device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 250:5 di 4
>> [ 1:27.557] ## DEBUG0: 01:25:00.429650 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:5) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.429707 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.429732 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.429756 lvconvert[15860] label/label.c:311  Found label at sector 1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.429779 lvconvert[15860] cache/lvmcache.c:2499  Found PVID ZBD1DCklu6jpwLq4crlGATcOhSOlCnI9 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.429802 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6: now in VG #orphans_lvm2 #orphans_lvm2
>> [ 1:27.557] ## DEBUG0: 01:25:00.429826 lvconvert[15860] format_text/text_label.c:538  Scanning /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 mda1 summary.
>> [ 1:27.557] ## DEBUG0: 01:25:00.429848 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.429872 lvconvert[15860] format_text/format-text.c:1550  Skipping read of already known VG metadata with matching mda checksum on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6.
>> [ 1:27.557] ## DEBUG0: 01:25:00.429919 lvconvert[15860] format_text/format-text.c:1575  Found metadata summary on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 220672 size 5898 for VG LVMTEST14057vg
>> [ 1:27.557] ## DEBUG0: 01:25:00.429943 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6: now in VG LVMTEST14057vg lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC
>> [ 1:27.557] ## DEBUG0: 01:25:00.429966 lvconvert[15860] format_text/text_label.c:566  Found metadata seqno 49 in mda1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.429988 lvconvert[15860] label/label.c:713  Processing data from device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 250:6 di 5
>> [ 1:27.557] ## DEBUG0: 01:25:00.430070 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:6) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.430118 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.430143 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.430167 lvconvert[15860] label/label.c:311  Found label at sector 1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.430189 lvconvert[15860] cache/lvmcache.c:2499  Found PVID wwuazHRbpMlybeGMg5QdwjqGhGQE2Vu6 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.430213 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7: now in VG #orphans_lvm2 #orphans_lvm2
>> [ 1:27.557] ## DEBUG0: 01:25:00.430236 lvconvert[15860] format_text/text_label.c:538  Scanning /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 mda1 summary.
>> [ 1:27.557] ## DEBUG0: 01:25:00.430258 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.430282 lvconvert[15860] format_text/format-text.c:1550  Skipping read of already known VG metadata with matching mda checksum on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7.
>> [ 1:27.557] ## DEBUG0: 01:25:00.430304 lvconvert[15860] format_text/format-text.c:1575  Found metadata summary on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 220672 size 5898 for VG LVMTEST14057vg
>> [ 1:27.557] ## DEBUG0: 01:25:00.430327 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7: now in VG LVMTEST14057vg lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC
>> [ 1:27.557] ## DEBUG0: 01:25:00.430350 lvconvert[15860] format_text/text_label.c:566  Found metadata seqno 49 in mda1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.430372 lvconvert[15860] label/label.c:713  Processing data from device /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 250:7 di 6
>> [ 1:27.557] ## DEBUG0: 01:25:00.430453 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status   (250:7) [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.430500 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.430525 lvconvert[15860] filters/filter-persistent.c:131  filter caching good /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.430549 lvconvert[15860] label/label.c:311  Found label at sector 1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.430571 lvconvert[15860] cache/lvmcache.c:2499  Found PVID 0R10Ru2WdfdkfenkeOFReER2NddtU49n on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.430595 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8: now in VG #orphans_lvm2 #orphans_lvm2
>> [ 1:27.557] ## DEBUG0: 01:25:00.430618 lvconvert[15860] format_text/text_label.c:538  Scanning /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 mda1 summary.
>> [ 1:27.557] ## DEBUG0: 01:25:00.430640 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.430696 lvconvert[15860] format_text/format-text.c:1550  Skipping read of already known VG metadata with matching mda checksum on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8.
>> [ 1:27.557] ## DEBUG0: 01:25:00.430719 lvconvert[15860] format_text/format-text.c:1575  Found metadata summary on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 220672 size 5898 for VG LVMTEST14057vg
>> [ 1:27.557] ## DEBUG0: 01:25:00.430742 lvconvert[15860] cache/lvmcache.c:2022  lvmcache /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8: now in VG LVMTEST14057vg lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC
>> [ 1:27.557] ## DEBUG0: 01:25:00.430764 lvconvert[15860] format_text/text_label.c:566  Found metadata seqno 49 in mda1 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.430787 lvconvert[15860] label/label.c:748  Scanned devices: read errors 0 process errors 0 failed 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.430810 lvconvert[15860] cache/lvmcache.c:1711  lvmcache label scan done
>> [ 1:27.557] ## DEBUG0: 01:25:00.430832 lvconvert[15860] toollib.c:4077  Obtaining the complete list of VGs before processing their LVs
>> [ 1:27.557] ## DEBUG0: 01:25:00.430856 lvconvert[15860] toollib.c:3934  Processing VG LVMTEST14057vg lQw2ng-FY0B-bmyz-g1PY-qfGt-GLNL-Hm8szC
>> [ 1:27.557] ## DEBUG0: 01:25:00.430886 lvconvert[15860] misc/lvm-flock.c:229  Locking /mnt/test/LVMTEST14057.I4CHaFJWdP/var/lock/lvm/V_LVMTEST14057vg WB
>> [ 1:27.557] ## DEBUG0: 01:25:00.430909 lvconvert[15860] misc/lvm-flock.c:113  _do_flock /mnt/test/LVMTEST14057.I4CHaFJWdP/var/lock/lvm/V_LVMTEST14057vg:aux WB
>> [ 1:27.557] ## DEBUG0: 01:25:00.431506 lvconvert[15860] misc/lvm-flock.c:113  _do_flock /mnt/test/LVMTEST14057.I4CHaFJWdP/var/lock/lvm/V_LVMTEST14057vg WB
>> [ 1:27.557] ## DEBUG0: 01:25:00.432005 lvconvert[15860] misc/lvm-flock.c:47  _undo_flock /mnt/test/LVMTEST14057.I4CHaFJWdP/var/lock/lvm/V_LVMTEST14057vg:aux
>> [ 1:27.557] ## DEBUG0: 01:25:00.432372 lvconvert[15860] metadata/metadata.c:4650  Reading VG LVMTEST14057vg lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC
>> [ 1:27.557] ## DEBUG0: 01:25:00.432499 lvconvert[15860] label/label.c:1898  reopen writable /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 di 0 prev 5 fd 12
>> [ 1:27.557] ## DEBUG0: 01:25:00.432617 lvconvert[15860] label/label.c:1898  reopen writable /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 di 1 prev 6 fd 5
>> [ 1:27.557] ## DEBUG0: 01:25:00.432744 lvconvert[15860] label/label.c:1898  reopen writable /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 di 2 prev 7 fd 6
>> [ 1:27.557] ## DEBUG0: 01:25:00.432858 lvconvert[15860] label/label.c:1898  reopen writable /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 di 3 prev 8 fd 7
>> [ 1:27.557] ## DEBUG0: 01:25:00.432974 lvconvert[15860] label/label.c:1898  reopen writable /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 di 4 prev 9 fd 8
>> [ 1:27.557] ## DEBUG0: 01:25:00.433093 lvconvert[15860] label/label.c:1898  reopen writable /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 di 5 prev 10 fd 9
>> [ 1:27.557] ## DEBUG0: 01:25:00.433213 lvconvert[15860] label/label.c:1898  reopen writable /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 di 6 prev 11 fd 10
>> [ 1:27.557] ## DEBUG0: 01:25:00.433243 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.452439 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.453648 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.454797 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.455970 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.457122 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.457979 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.459054 lvconvert[15860] metadata/metadata.c:4621  Rescan skipped - unchanged offset 216576 checksum f1a3ef92.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459272 lvconvert[15860] metadata/metadata.c:4800  Reading VG LVMTEST14057vg metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.459299 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.459326 lvconvert[15860] format_text/import.c:153  Reading metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 220672 size 5898 (+0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.459474 lvconvert[15860] metadata/vg.c:65  Allocated VG LVMTEST14057vg at 0x562463b71a20.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459628 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459657 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459690 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459716 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459759 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459784 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459808 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459832 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459856 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459880 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459904 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459935 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[0] on LV LVMTEST14057vg/LV1_rmeta_0:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459959 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.459982 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[0] on LV LVMTEST14057vg/LV1_rimage_0:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460004 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460027 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[1] on LV LVMTEST14057vg/LV1_rmeta_1:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460050 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460072 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[1] on LV LVMTEST14057vg/LV1_rimage_1:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460095 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460118 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[2] on LV LVMTEST14057vg/LV1_rmeta_2:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460141 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460163 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[2] on LV LVMTEST14057vg/LV1_rimage_2:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460186 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460209 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[3] on LV LVMTEST14057vg/LV1_rmeta_3:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460231 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460254 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[3] on LV LVMTEST14057vg/LV1_rimage_3:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460277 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460300 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[4] on LV LVMTEST14057vg/LV1_rmeta_4:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460322 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460370 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[4] on LV LVMTEST14057vg/LV1_rimage_4:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460394 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.460500 lvconvert[15860] format_text/format-text.c:442  Found metadata text at 220672 off 216576 size 5898 VG LVMTEST14057vg on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.460525 lvconvert[15860] metadata/metadata.c:4800  Reading VG LVMTEST14057vg metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.460566 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.460611 lvconvert[15860] format_text/import.c:153  Reading metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 139264 size 5898 (+0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.461818 lvconvert[15860] format_text/import.c:173  Skipped parsing metadata on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.461859 lvconvert[15860] format_text/format-text.c:442  Found metadata text at 139264 off 135168 size 5898 VG LVMTEST14057vg on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.461884 lvconvert[15860] metadata/metadata.c:4800  Reading VG LVMTEST14057vg metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.461907 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.461934 lvconvert[15860] format_text/import.c:153  Reading metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 62976 size 5898 (+0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.461976 lvconvert[15860] format_text/import.c:173  Skipped parsing metadata on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.461999 lvconvert[15860] format_text/format-text.c:442  Found metadata text at 62976 off 58880 size 5898 VG LVMTEST14057vg on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.462021 lvconvert[15860] metadata/metadata.c:4800  Reading VG LVMTEST14057vg metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.462044 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.462099 lvconvert[15860] format_text/import.c:153  Reading metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 19456 size 5898 (+0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.462142 lvconvert[15860] format_text/import.c:173  Skipped parsing metadata on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.462164 lvconvert[15860] format_text/format-text.c:442  Found metadata text at 19456 off 15360 size 5898 VG LVMTEST14057vg on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.462187 lvconvert[15860] metadata/metadata.c:4800  Reading VG LVMTEST14057vg metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.462209 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.462234 lvconvert[15860] format_text/import.c:153  Reading metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 220672 size 5898 (+0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.463402 lvconvert[15860] format_text/import.c:173  Skipped parsing metadata on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.463443 lvconvert[15860] format_text/format-text.c:442  Found metadata text at 220672 off 216576 size 5898 VG LVMTEST14057vg on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.463467 lvconvert[15860] metadata/metadata.c:4800  Reading VG LVMTEST14057vg metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.463491 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.463553 lvconvert[15860] format_text/import.c:153  Reading metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 220672 size 5898 (+0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.464821 lvconvert[15860] format_text/import.c:173  Skipped parsing metadata on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.464869 lvconvert[15860] format_text/format-text.c:442  Found metadata text at 220672 off 216576 size 5898 VG LVMTEST14057vg on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.464894 lvconvert[15860] metadata/metadata.c:4800  Reading VG LVMTEST14057vg metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.464917 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.464944 lvconvert[15860] format_text/import.c:153  Reading metadata from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 220672 size 5898 (+0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.465991 lvconvert[15860] format_text/import.c:173  Skipped parsing metadata on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.466033 lvconvert[15860] format_text/format-text.c:442  Found metadata text at 220672 off 216576 size 5898 VG LVMTEST14057vg on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.466232 lvconvert[15860] metadata/metadata.c:3558  WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:27.557] ## DEBUG0: 01:25:00.466260 lvconvert[15860] cache/lvmcache.c:2362  lvmcache_update_vg LVMTEST14057vg for info /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.466301 lvconvert[15860] cache/lvmcache.c:2362  lvmcache_update_vg LVMTEST14057vg for info /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.466334 lvconvert[15860] cache/lvmcache.c:2362  lvmcache_update_vg LVMTEST14057vg for info /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.466355 lvconvert[15860] cache/lvmcache.c:2362  lvmcache_update_vg LVMTEST14057vg for info /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.466381 lvconvert[15860] cache/lvmcache.c:2362  lvmcache_update_vg LVMTEST14057vg for info /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.466404 lvconvert[15860] cache/lvmcache.c:2362  lvmcache_update_vg LVMTEST14057vg for info /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.466426 lvconvert[15860] cache/lvmcache.c:2356  lvmcache_update_vg LVMTEST14057vg no info for KsNO3kFBmuddrJhf2JMj3ey8mMmLppWh missing
>> [ 1:27.557] ## DEBUG0: 01:25:00.466452 lvconvert[15860] cache/lvmcache.c:2362  lvmcache_update_vg LVMTEST14057vg for info /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.466483 lvconvert[15860] device_mapper/libdm-config.c:1013  metadata/lvs_history_retention_time not found in config: defaulting to 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.466634 lvconvert[15860] metadata/metadata.c:5037  WARNING: VG LVMTEST14057vg is missing PV KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh (last written to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv4).
>> [ 1:27.557] ## DEBUG0: 01:25:00.466663 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 0:      0      1: LV1_rmeta_0(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466697 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 1:      1     43: LV1_rimage_0(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466725 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466748 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 0:      0    158: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466768 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 0:      0    158: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466794 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 0:      0    158: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466848 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 0:      0      1: LV1_rmeta_1(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466873 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 1:      1     43: LV1_rimage_1(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466896 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466919 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 0:      0      1: LV1_rmeta_2(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466942 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 1:      1     43: LV1_rimage_2(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466965 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.466987 lvconvert[15860] metadata/pv_manip.c:413  [unknown] 0:      0      1: LV1_rmeta_3(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.467013 lvconvert[15860] metadata/pv_manip.c:413  [unknown] 1:      1     43: LV1_rimage_3(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.467030 lvconvert[15860] metadata/pv_manip.c:413  [unknown] 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.467054 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 0:      0      1: LV1_rmeta_4(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.467077 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 1:      1     43: LV1_rimage_4(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.467100 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.467129 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.467152 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.467175 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.467198 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.467220 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.467243 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.467266 lvconvert[15860] device/dev-io.c:96  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5: using cached size 163840 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.467294 lvconvert[15860] metadata/vg.c:65  Allocated VG LVMTEST14057vg at 0x562463b7ba50.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467427 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467457 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467482 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467499 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467544 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467570 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467594 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467620 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467647 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467671 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467700 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467761 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[0] on LV LVMTEST14057vg/LV1_rmeta_0:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467787 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467812 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[0] on LV LVMTEST14057vg/LV1_rimage_0:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467846 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467871 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[1] on LV LVMTEST14057vg/LV1_rmeta_1:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467891 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467912 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[1] on LV LVMTEST14057vg/LV1_rimage_1:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467936 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467959 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[2] on LV LVMTEST14057vg/LV1_rmeta_2:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.467982 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468005 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[2] on LV LVMTEST14057vg/LV1_rimage_2:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468028 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468052 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[3] on LV LVMTEST14057vg/LV1_rmeta_3:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468075 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468098 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[3] on LV LVMTEST14057vg/LV1_rimage_3:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468121 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468144 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[4] on LV LVMTEST14057vg/LV1_rmeta_4:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468167 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468191 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[4] on LV LVMTEST14057vg/LV1_rimage_4:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468214 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468701 lvconvert[15860] metadata/metadata.c:3558  WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468802 lvconvert[15860] format_text/import.c:240  There are 1 physical volumes missing.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468831 lvconvert[15860] toollib.c:3404  Adding LVMTEST14057vg/LV1 to the list of LVs to be processed.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468857 lvconvert[15860] toollib.c:3479  Processing LV LV1 in VG LVMTEST14057vg.
>> [ 1:27.557] ## DEBUG0: 01:25:00.468883 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.557] ## DEBUG0: 01:25:00.468909 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.468950 lvconvert[15860] activate/activate.c:920  Checking transient status for LV LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.469064 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469123 lvconvert[15860] raid/raid.c:463  Raid transient status raid6_zr 5 AAAAA 44032/44032 idle 0 0 -.
>> [ 1:27.557] ## DEBUG0: 01:25:00.469153 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469175 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469244 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469269 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469302 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469326 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469359 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469383 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469416 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469440 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469473 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469497 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469530 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469554 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469587 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469611 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469644 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469668 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469711 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469736 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469773 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469797 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469832 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469901 lvconvert[15860] activate/dev_manager.c:1546  Checking raid status for volume LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.469931 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.557] ## DEBUG0: 01:25:00.469955 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.469987 lvconvert[15860] activate/activate.c:1096  Checking raid sync_action for LV LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.470013 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.470060 lvconvert[15860] activate/dev_manager.c:1546  Checking raid status for volume LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.470088 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.557] ## DEBUG0: 01:25:00.470111 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.470144 lvconvert[15860] activate/activate.c:1025  Checking raid device health for LV LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.470169 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.470216 lvconvert[15860] activate/dev_manager.c:1546  Checking raid status for volume LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.470245 lvconvert[15860] metadata/lv.c:569  LV1_rimage_0 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.470269 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_0 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.470292 lvconvert[15860] metadata/lv.c:569  LV1_rimage_1 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.470315 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_1 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.470337 lvconvert[15860] metadata/lv.c:569  LV1_rimage_2 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.470360 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_2 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.470383 lvconvert[15860] metadata/lv.c:569  LV1_rimage_4 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.470406 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_4 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.470455 lvconvert[15860] metadata/lv.c:569  LV1_rimage_0 is on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.470479 lvconvert[15860] metadata/lv.c:569  LV1_rimage_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.470502 lvconvert[15860] metadata/lv.c:569  LV1_rimage_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.470525 lvconvert[15860] metadata/lv.c:569  LV1_rimage_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.470547 lvconvert[15860] metadata/lv.c:569  LV1_rimage_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.470570 lvconvert[15860] metadata/lv.c:569  LV1_rimage_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.470593 lvconvert[15860] metadata/lv.c:569  LV1_rimage_0 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.470616 lvconvert[15860] metadata/lv.c:569  LV1_rimage_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.470639 lvconvert[15860] metadata/lv.c:569  LV1_rimage_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.470661 lvconvert[15860] metadata/lv.c:569  LV1_rimage_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.470693 lvconvert[15860] metadata/lv.c:569  LV1_rimage_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.470716 lvconvert[15860] metadata/lv.c:569  LV1_rimage_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.470739 lvconvert[15860] metadata/lv.c:569  LV1_rimage_1 is on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.470781 lvconvert[15860] metadata/lv.c:569  LV1_rimage_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.470805 lvconvert[15860] metadata/lv.c:569  LV1_rimage_1 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.470827 lvconvert[15860] metadata/lv.c:569  LV1_rimage_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.470850 lvconvert[15860] metadata/lv.c:569  LV1_rimage_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.470873 lvconvert[15860] metadata/lv.c:569  LV1_rimage_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.470895 lvconvert[15860] metadata/lv.c:569  LV1_rimage_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.470918 lvconvert[15860] metadata/lv.c:569  LV1_rimage_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.470941 lvconvert[15860] metadata/lv.c:569  LV1_rimage_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.470964 lvconvert[15860] metadata/lv.c:569  LV1_rimage_2 is on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.470987 lvconvert[15860] metadata/lv.c:569  LV1_rimage_2 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.471009 lvconvert[15860] metadata/lv.c:569  LV1_rimage_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.471032 lvconvert[15860] metadata/lv.c:569  LV1_rimage_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.471055 lvconvert[15860] metadata/lv.c:569  LV1_rimage_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.471078 lvconvert[15860] metadata/lv.c:569  LV1_rimage_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.471100 lvconvert[15860] metadata/lv.c:569  LV1_rimage_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.471123 lvconvert[15860] metadata/lv.c:569  LV1_rimage_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.471146 lvconvert[15860] metadata/lv.c:569  LV1_rimage_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.471168 lvconvert[15860] metadata/lv.c:569  LV1_rimage_4 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.471191 lvconvert[15860] metadata/lv.c:569  LV1_rimage_4 is on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.471214 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_0 is on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.471237 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.471260 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.471282 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.471305 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.471328 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.471350 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_0 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.471373 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_0 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.471396 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.471418 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.471441 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.471464 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.471487 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_1 is on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.471527 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.471551 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_1 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.471573 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_1 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.471596 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.471619 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.471641 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.471664 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.471695 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.471718 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_2 is on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.471741 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_2 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.471764 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_2 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.471787 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.471809 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.557] ## DEBUG0: 01:25:00.471832 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7
>> [ 1:27.557] ## DEBUG0: 01:25:00.471855 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8
>> [ 1:27.557] ## DEBUG0: 01:25:00.471878 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.471900 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_4 is not on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.471923 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_4 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.471946 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_4 is on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.471976 lvconvert[15860] metadata/lv_manip.c:3742  Adjusted allocation request to 44 logical extents. Existing size 0. New size 44.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472053 lvconvert[15860] metadata/lv_manip.c:3745  Mirror log of 1 extents of size 1024 sectors needed for region size 512.00 KiB.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472081 lvconvert[15860] metadata/pv_map.c:53  Allowing allocation on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 start PE 0 length 158
>> [ 1:27.557] ## DEBUG0: 01:25:00.472103 lvconvert[15860] metadata/pv_map.c:53  Allowing allocation on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 start PE 0 length 158
>> [ 1:27.557] ## DEBUG0: 01:25:00.472126 lvconvert[15860] metadata/pv_map.c:53  Allowing allocation on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 start PE 0 length 158
>> [ 1:27.557] ## DEBUG0: 01:25:00.472149 lvconvert[15860] metadata/lv_manip.c:2569  Parallel PVs at LE 0 length 129: /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 [unknown] /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.472172 lvconvert[15860] metadata/lv_manip.c:3448  Trying allocation using contiguous policy.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472195 lvconvert[15860] metadata/lv_manip.c:3047  Areas to be sorted and filled sequentially.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472217 lvconvert[15860] metadata/lv_manip.c:2959  Still need 44 total extents from 474 remaining (0 positional slots):
>> [ 1:27.557] ## DEBUG0: 01:25:00.472240 lvconvert[15860] metadata/lv_manip.c:2963    1 (1 data/0 parity) parallel areas of 43 extents each
>> [ 1:27.557] ## DEBUG0: 01:25:00.472262 lvconvert[15860] metadata/lv_manip.c:2966    1 metadata area of 1 extents each
>> [ 1:27.557] ## DEBUG0: 01:25:00.472304 lvconvert[15860] metadata/lv_manip.c:2611  Considering allocation area 0 as /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 start PE 0 length 44 leaving 114.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472329 lvconvert[15860] metadata/lv_manip.c:2611  Considering allocation area 1 as /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 start PE 0 length 44 leaving 114.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472351 lvconvert[15860] metadata/lv_manip.c:2611  Considering allocation area 2 as /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 start PE 0 length 44 leaving 114.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472373 lvconvert[15860] metadata/lv_manip.c:3187  Sorting 3 areas
>> [ 1:27.557] ## DEBUG0: 01:25:00.472396 lvconvert[15860] metadata/lv_manip.c:2175  Allocating parallel metadata area 0 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 start PE 0 length 1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472419 lvconvert[15860] metadata/lv_manip.c:2193  Allocating parallel area 0 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 start PE 1 length 43.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472446 lvconvert[15860] metadata/lv_manip.c:7343  Creating logical volume LV1_rmeta_5
>> [ 1:27.557] ## DEBUG0: 01:25:00.472580 lvconvert[15860] metadata/lv_manip.c:7494  LV LV1_rmeta_5 in VG LVMTEST14057vg is now visible.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472609 lvconvert[15860] metadata/lv_manip.c:7343  Creating logical volume LV1_rimage_5
>> [ 1:27.557] ## DEBUG0: 01:25:00.472711 lvconvert[15860] metadata/lv_manip.c:7494  LV LV1_rimage_5 in VG LVMTEST14057vg is now visible.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472741 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm status  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount noflush enablechecks ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.472792 lvconvert[15860] activate/dev_manager.c:1546  Checking raid status for volume LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472813 lvconvert[15860] metadata/raid_manip.c:3025  Extracting 1 image from LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472842 lvconvert[15860] metadata/lv.c:569  LV1_rimage_4 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.472865 lvconvert[15860] metadata/lv.c:569  LV1_rmeta_4 is not on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.472887 lvconvert[15860] metadata/lv.c:569  LV1_rimage_3 is on [unknown]
>> [ 1:27.557] ## DEBUG0: 01:25:00.472911 lvconvert[15860] metadata/raid_manip.c:2878  Extracting image components LVMTEST14057vg/LV1_rimage_3 and LVMTEST14057vg/LV1_rmeta_3 from LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472933 lvconvert[15860] metadata/lv_manip.c:7494  LV LV1_rimage_3 in VG LVMTEST14057vg is now visible.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472955 lvconvert[15860] metadata/lv_manip.c:7494  LV LV1_rmeta_3 in VG LVMTEST14057vg is now visible.
>> [ 1:27.557] ## DEBUG0: 01:25:00.472976 lvconvert[15860] metadata/lv_manip.c:896  LVMTEST14057vg/LV1:0 is no longer a user of LVMTEST14057vg/LV1_rimage_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473003 lvconvert[15860] metadata/lv_manip.c:896  LVMTEST14057vg/LV1:0 is no longer a user of LVMTEST14057vg/LV1_rmeta_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473030 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3_extracted [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV].
>> [ 1:27.557] ## DEBUG0: 01:25:00.473053 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473089 lvconvert[15860] activate/activate.c:462  activation/volume_list configuration setting not defined: Checking only host tags for LVMTEST14057vg/LV1_rmeta_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473112 lvconvert[15860] activate/activate.c:2602  Activating LVMTEST14057vg/LV1_rmeta_3 read-only.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473136 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV].
>> [ 1:27.557] ## DEBUG0: 01:25:00.473159 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473191 lvconvert[15860] activate/activate.c:2617  LV LVMTEST14057vg/LV1_rmeta_3 is already active.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473215 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3_extracted [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H].
>> [ 1:27.557] ## DEBUG0: 01:25:00.473260 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473299 lvconvert[15860] activate/activate.c:462  activation/volume_list configuration setting not defined: Checking only host tags for LVMTEST14057vg/LV1_rimage_3.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473323 lvconvert[15860] activate/activate.c:2602  Activating LVMTEST14057vg/LV1_rimage_3 read-only.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473346 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H].
>> [ 1:27.557] ## DEBUG0: 01:25:00.473372 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473408 lvconvert[15860] activate/activate.c:2617  LV LVMTEST14057vg/LV1_rimage_3 is already active.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473432 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[3] on LV LVMTEST14057vg/LV1_rmeta_5:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473454 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_5.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473477 lvconvert[15860] metadata/lv_manip.c:7504  LV LV1_rmeta_5 in VG LVMTEST14057vg is now hidden.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473500 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[3] on LV LVMTEST14057vg/LV1_rimage_5:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473519 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_5.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473539 lvconvert[15860] metadata/lv_manip.c:7504  LV LV1_rimage_5 in VG LVMTEST14057vg is now hidden.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473561 lvconvert[15860] metadata/lv_manip.c:7986  Updating logical volume LVMTEST14057vg/LV1 on disk(s) (origin only).
>> [ 1:27.557] ## DEBUG0: 01:25:00.473584 lvconvert[15860] metadata/metadata.c:2927  Writing metadata for VG LVMTEST14057vg.
>> [ 1:27.557] ## DEBUG0: 01:25:00.473609 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 0:      0      1: LV1_rmeta_0(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473657 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 1:      1     43: LV1_rimage_0(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473701 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473726 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 0:      0      1: LV1_rmeta_5(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473742 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 1:      1     43: LV1_rimage_5(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473766 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473789 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 0:      0    158: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473811 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 0:      0    158: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473829 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 0:      0      1: LV1_rmeta_1(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473852 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 1:      1     43: LV1_rimage_1(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473874 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473898 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 0:      0      1: LV1_rmeta_2(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473921 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 1:      1     43: LV1_rimage_2(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473945 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.473988 lvconvert[15860] metadata/pv_manip.c:413  [unknown] 0:      0      1: LV1_rmeta_3_extracted(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.474007 lvconvert[15860] metadata/pv_manip.c:413  [unknown] 1:      1     43: LV1_rimage_3_extracted(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.474032 lvconvert[15860] metadata/pv_manip.c:413  [unknown] 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.474052 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 0:      0      1: LV1_rmeta_4(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.474073 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 1:      1     43: LV1_rimage_4(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.474094 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 2:     44    114: NULL(0:0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.474134 lvconvert[15860] mm/memlock.c:609  Unlock: Memlock counters: prioritized:0 locked:0 critical:0 daemon:0 suspended:0
>> [ 1:27.557] ## DEBUG0: 01:25:00.474160 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.474507 lvconvert[15860] metadata/vg.c:65  Allocated VG LVMTEST14057vg at 0x562463b911b0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474597 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474624 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_3_extracted.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474648 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_3_extracted.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474672 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474707 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474731 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474755 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474779 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474803 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474827 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474869 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474895 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_5.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474919 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_5.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474948 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[0] on LV LVMTEST14057vg/LV1_rmeta_0:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474971 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.474995 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[0] on LV LVMTEST14057vg/LV1_rimage_0:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475017 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475040 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[1] on LV LVMTEST14057vg/LV1_rmeta_1:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475063 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475086 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[1] on LV LVMTEST14057vg/LV1_rimage_1:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475109 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475131 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[2] on LV LVMTEST14057vg/LV1_rmeta_2:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475154 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475177 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[2] on LV LVMTEST14057vg/LV1_rimage_2:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475218 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_2.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475242 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[3] on LV LVMTEST14057vg/LV1_rmeta_5:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475265 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_5.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475288 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[3] on LV LVMTEST14057vg/LV1_rimage_5:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475310 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_5.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475333 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[4] on LV LVMTEST14057vg/LV1_rmeta_4:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475356 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475379 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[4] on LV LVMTEST14057vg/LV1_rimage_4:0.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475401 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_4.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475634 lvconvert[15860] metadata/metadata.c:3558  WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475663 lvconvert[15860] format_text/import.c:240  There are 1 physical volumes missing.
>> [ 1:27.557] ## DEBUG0: 01:25:00.475719 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 50 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.557] ## DEBUG0: 01:25:00.475743 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 50 new metadata start align from 222474 to 222720 (+246)
>> [ 1:27.557] ## DEBUG0: 01:25:00.475765 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 50 metadata area location old start 216576 last 222473 size 5898 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.475788 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 50 metadata area location new start 222720 last 228875 size 6156 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.475810 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 50 metadata disk location start 226816 size 6156 last 232971
>> [ 1:27.557] ## DEBUG0: 01:25:00.475832 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 50 metadata last align from 232971 to 233471 (+500)
>> [ 1:27.557] ## DEBUG0: 01:25:00.475859 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 50 metadata write at 226816 size 6656 (wrap 0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.478128 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.478172 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 50 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.557] ## DEBUG0: 01:25:00.478197 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 50 new metadata start align from 141066 to 141312 (+246)
>> [ 1:27.557] ## DEBUG0: 01:25:00.478226 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 50 metadata area location old start 135168 last 141065 size 5898 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.478244 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 50 metadata area location new start 141312 last 147467 size 6156 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.478270 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 50 metadata disk location start 145408 size 6156 last 151563
>> [ 1:27.557] ## DEBUG0: 01:25:00.478295 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 50 metadata last align from 151563 to 152063 (+500)
>> [ 1:27.557] ## DEBUG0: 01:25:00.482279 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 50 metadata write at 145408 size 6656 (wrap 0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.484636 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.484694 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 50 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.557] ## DEBUG0: 01:25:00.484754 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 50 new metadata start align from 64778 to 65024 (+246)
>> [ 1:27.557] ## DEBUG0: 01:25:00.484778 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 50 metadata area location old start 58880 last 64777 size 5898 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.484801 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 50 metadata area location new start 65024 last 71179 size 6156 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.484823 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 50 metadata disk location start 69120 size 6156 last 75275
>> [ 1:27.557] ## DEBUG0: 01:25:00.484845 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 50 metadata last align from 75275 to 75775 (+500)
>> [ 1:27.557] ## DEBUG0: 01:25:00.484873 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 50 metadata write at 69120 size 6656 (wrap 0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.486943 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.486989 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 50 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.557] ## DEBUG0: 01:25:00.487014 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 50 new metadata start align from 21258 to 21504 (+246)
>> [ 1:27.557] ## DEBUG0: 01:25:00.487036 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 50 metadata area location old start 15360 last 21257 size 5898 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.487059 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 50 metadata area location new start 21504 last 27659 size 6156 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.487081 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 50 metadata disk location start 25600 size 6156 last 31755
>> [ 1:27.557] ## DEBUG0: 01:25:00.487103 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 50 metadata last align from 31755 to 32255 (+500)
>> [ 1:27.557] ## DEBUG0: 01:25:00.487131 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 50 metadata write at 25600 size 6656 (wrap 0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.489556 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.489702 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 50 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.557] ## DEBUG0: 01:25:00.489728 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 50 new metadata start align from 222474 to 222720 (+246)
>> [ 1:27.557] ## DEBUG0: 01:25:00.489751 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 50 metadata area location old start 216576 last 222473 size 5898 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.489773 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 50 metadata area location new start 222720 last 228875 size 6156 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.489795 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 50 metadata disk location start 226816 size 6156 last 232971
>> [ 1:27.557] ## DEBUG0: 01:25:00.489817 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 50 metadata last align from 232971 to 233471 (+500)
>> [ 1:27.557] ## DEBUG0: 01:25:00.489845 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 50 metadata write at 226816 size 6656 (wrap 0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.491874 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.491922 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 50 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.557] ## DEBUG0: 01:25:00.491946 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 50 new metadata start align from 222474 to 222720 (+246)
>> [ 1:27.557] ## DEBUG0: 01:25:00.491969 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 50 metadata area location old start 216576 last 222473 size 5898 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.491991 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 50 metadata area location new start 222720 last 228875 size 6156 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.492062 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 50 metadata disk location start 226816 size 6156 last 232971
>> [ 1:27.557] ## DEBUG0: 01:25:00.492086 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 50 metadata last align from 232971 to 233471 (+500)
>> [ 1:27.557] ## DEBUG0: 01:25:00.492114 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 50 metadata write at 226816 size 6656 (wrap 0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.494196 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.494250 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 50 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.557] ## DEBUG0: 01:25:00.494279 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 50 new metadata start align from 222474 to 222720 (+246)
>> [ 1:27.557] ## DEBUG0: 01:25:00.494306 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 50 metadata area location old start 216576 last 222473 size 5898 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.494333 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 50 metadata area location new start 222720 last 228875 size 6156 wrap 0
>> [ 1:27.557] ## DEBUG0: 01:25:00.494360 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 50 metadata disk location start 226816 size 6156 last 232971
>> [ 1:27.557] ## DEBUG0: 01:25:00.494386 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 50 metadata last align from 232971 to 233471 (+500)
>> [ 1:27.557] ## DEBUG0: 01:25:00.494419 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 50 metadata write at 226816 size 6656 (wrap 0)
>> [ 1:27.557] ## DEBUG0: 01:25:00.496547 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.496601 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 mda header at 4096 (used).
>> [ 1:27.557] ## DEBUG0: 01:25:00.496630 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 216576 size 5898 slot1 offset 222720 size 6156.
>> [ 1:27.557] ## DEBUG0: 01:25:00.496661 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.557] ## DEBUG0: 01:25:00.497568 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.497609 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 mda header at 4096 (used).
>> [ 1:27.557] ## DEBUG0: 01:25:00.497637 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 135168 size 5898 slot1 offset 141312 size 6156.
>> [ 1:27.557] ## DEBUG0: 01:25:00.497667 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.557] ## DEBUG0: 01:25:00.499039 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.499191 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 mda header at 4096 (used).
>> [ 1:27.557] ## DEBUG0: 01:25:00.499222 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 58880 size 5898 slot1 offset 65024 size 6156.
>> [ 1:27.557] ## DEBUG0: 01:25:00.499252 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.557] ## DEBUG0: 01:25:00.500147 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.500200 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 mda header at 4096 (used).
>> [ 1:27.557] ## DEBUG0: 01:25:00.500229 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 15360 size 5898 slot1 offset 21504 size 6156.
>> [ 1:27.557] ## DEBUG0: 01:25:00.500260 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.557] ## DEBUG0: 01:25:00.501179 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.501232 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 mda header at 4096 (used).
>> [ 1:27.557] ## DEBUG0: 01:25:00.501261 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 216576 size 5898 slot1 offset 222720 size 6156.
>> [ 1:27.557] ## DEBUG0: 01:25:00.501292 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.557] ## DEBUG0: 01:25:00.502195 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.502248 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 mda header at 4096 (used).
>> [ 1:27.557] ## DEBUG0: 01:25:00.502277 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 216576 size 5898 slot1 offset 222720 size 6156.
>> [ 1:27.557] ## DEBUG0: 01:25:00.502308 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.557] ## DEBUG0: 01:25:00.503267 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 4096
>> [ 1:27.557] ## DEBUG0: 01:25:00.503336 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 mda header at 4096 (used).
>> [ 1:27.557] ## DEBUG0: 01:25:00.503375 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 216576 size 5898 slot1 offset 222720 size 6156.
>> [ 1:27.557] ## DEBUG0: 01:25:00.503415 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.557] ## DEBUG0: 01:25:00.504316 lvconvert[15860] mm/memlock.c:641  Entering prioritized section (locking for suspend).
>> [ 1:27.557] ## DEBUG0: 01:25:00.504383 lvconvert[15860] mm/memlock.c:504  Raised task priority 0 -> -18.
>> [ 1:27.557] ## DEBUG0: 01:25:00.504427 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.557] ## DEBUG0: 01:25:00.504469 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.504716 lvconvert[15860] device/dev-io.c:153  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1: read_ahead is 256 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.504796 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1
>> [ 1:27.557] ## DEBUG0: 01:25:00.504971 lvconvert[15860] device/dev-io.c:153  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2: read_ahead is 256 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.505043 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2
>> [ 1:27.557] ## DEBUG0: 01:25:00.505214 lvconvert[15860] device/dev-io.c:153  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3: read_ahead is 256 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.505285 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3
>> [ 1:27.557] ## DEBUG0: 01:25:00.505455 lvconvert[15860] device/dev-io.c:153  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5: read_ahead is 256 sectors
>> [ 1:27.557] ## DEBUG0: 01:25:00.505527 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5
>> [ 1:27.557] ## DEBUG0: 01:25:00.505574 lvconvert[15860] activate/dev_manager.c:3888  Creating PRELOAD tree for LVMTEST14057vg/LV1.
>> [ 1:27.557] ## DEBUG0: 01:25:00.505618 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.557] ## DEBUG0: 01:25:00.505657 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.505849 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:18) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.506056 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.506263 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:4) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.506710 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.506795 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:15) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.506866 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:3) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.506940 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:14) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.507017 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.507124 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:2) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.507203 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.507280 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.507357 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:1) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.507434 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.507511 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.507617 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:0) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.507708 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.508031 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real].
>> [ 1:27.557] ## DEBUG0: 01:25:00.508075 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.508129 lvconvert[15860] activate/dev_manager.c:839  Skipping checks for old devices without LVM- dm uuid prefix (kernel vsn 6 >= 3).
>> [ 1:27.557] ## DEBUG0: 01:25:00.508167 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow].
>> [ 1:27.557] ## DEBUG0: 01:25:00.508205 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.508257 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf].
>> [ 1:27.557] ## DEBUG0: 01:25:00.508295 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.509010 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real].
>> [ 1:27.557] ## DEBUG0: 01:25:00.509169 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.509221 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow].
>> [ 1:27.557] ## DEBUG0: 01:25:00.509259 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.509309 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG].
>> [ 1:27.557] ## DEBUG0: 01:25:00.509389 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.509443 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real].
>> [ 1:27.557] ## DEBUG0: 01:25:00.509481 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.509530 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow].
>> [ 1:27.557] ## DEBUG0: 01:25:00.509568 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.509617 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW].
>> [ 1:27.557] ## DEBUG0: 01:25:00.509655 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.509721 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real].
>> [ 1:27.557] ## DEBUG0: 01:25:00.509760 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.509810 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow].
>> [ 1:27.557] ## DEBUG0: 01:25:00.509847 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.509897 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR].
>> [ 1:27.557] ## DEBUG0: 01:25:00.509935 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.509987 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510024 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.510073 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510111 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.510160 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510198 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.510250 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510318 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.510368 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510406 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.510455 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510493 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.510545 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510583 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.510631 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510669 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.510729 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510767 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.510815 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510853 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.557] ## DEBUG0: 01:25:00.510901 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow].
>> [ 1:27.557] ## DEBUG0: 01:25:00.510938 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.510987 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g].
>> [ 1:27.591] ## DEBUG0: 01:25:00.511024 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.511073 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.511111 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.511159 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.511197 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.511275 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn].
>> [ 1:27.591] ## DEBUG0: 01:25:00.511314 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.511367 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.511405 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.511454 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.511491 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.511540 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s].
>> [ 1:27.591] ## DEBUG0: 01:25:00.511585 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.511642 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.511686 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.511736 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.511774 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.511825 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.511864 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.511901 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.511939 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports raid6 segment type for LVMTEST14057vg/LV1
>> [ 1:27.591] ## DEBUG0: 01:25:00.511975 lvconvert[15860] activate/activate.c:517  Getting target version for raid
>> [ 1:27.591] ## DEBUG0: 01:25:00.512012 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm versions   [ opencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.512128 lvconvert[15860] activate/activate.c:552  Found raid target v1.15.1.
>> [ 1:27.591] ## DEBUG0: 01:25:00.512168 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_0 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.512206 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.512242 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.512278 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_0
>> [ 1:27.591] ## DEBUG0: 01:25:00.512314 lvconvert[15860] activate/activate.c:517  Getting target version for linear
>> [ 1:27.591] ## DEBUG0: 01:25:00.512350 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm versions   [ opencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.512451 lvconvert[15860] activate/activate.c:552  Found linear target v1.4.0.
>> [ 1:27.591] ## DEBUG0: 01:25:00.512519 lvconvert[15860] activate/activate.c:517  Getting target version for striped
>> [ 1:27.591] ## DEBUG0: 01:25:00.512558 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm versions   [ opencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.512659 lvconvert[15860] activate/activate.c:552  Found striped target v1.6.0.
>> [ 1:27.591] ## DEBUG0: 01:25:00.512835 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_0 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:00.512875 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_0 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.512913 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.512949 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.512986 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_0
>> [ 1:27.591] ## DEBUG0: 01:25:00.513134 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_0 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:00.513173 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_1 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.513210 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.513246 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.513282 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_1
>> [ 1:27.591] ## DEBUG0: 01:25:00.513485 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_1 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:00.513526 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_1 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.513564 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.513600 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.513631 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_1
>> [ 1:27.591] ## DEBUG0: 01:25:00.513749 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_1 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:00.513779 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_2 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.513807 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.513834 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.513861 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_2
>> [ 1:27.591] ## DEBUG0: 01:25:00.513969 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_2 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:00.513998 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_2 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.514025 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.514052 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.514079 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_2
>> [ 1:27.591] ## DEBUG0: 01:25:00.514204 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_2 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:00.514234 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_5 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.514263 lvconvert[15860] device_mapper/libdm-deptree.c:637  Not matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.514313 lvconvert[15860] device_mapper/libdm-deptree.c:637  Not matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.514343 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_5
>> [ 1:27.591] ## DEBUG0: 01:25:00.514456 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:5) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.514633 lvconvert[15860] device/dev-io.c:153  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6: read_ahead is 256 sectors
>> [ 1:27.591] ## DEBUG0: 01:25:00.514697 lvconvert[15860] device/dev-io.c:466  Closed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6
>> [ 1:27.591] ## DEBUG0: 01:25:00.514726 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_5 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:00.514754 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_5 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.514782 lvconvert[15860] device_mapper/libdm-deptree.c:637  Not matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.514809 lvconvert[15860] device_mapper/libdm-deptree.c:637  Not matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.514838 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_5
>> [ 1:27.591] ## DEBUG0: 01:25:00.514950 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_5 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:00.514979 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_4 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.515007 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515034 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515061 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_4
>> [ 1:27.591] ## DEBUG0: 01:25:00.515182 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_4 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:00.515211 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_4 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.515239 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515266 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515294 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_4
>> [ 1:27.591] ## DEBUG0: 01:25:00.515400 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_4 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:00.515432 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515461 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515489 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515517 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515545 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515573 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515600 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515629 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515688 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515719 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515749 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_4 (250:17).
>> [ 1:27.591] ## DEBUG0: 01:25:00.515779 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:17): 0 44032 linear 250:4 3072
>> [ 1:27.591] ## DEBUG0: 01:25:00.515810 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.515870 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_4 (250:17) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:00.515900 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_4 (250:16).
>> [ 1:27.591] ## DEBUG0: 01:25:00.515929 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:16): 0 1024 linear 250:4 2048
>> [ 1:27.591] ## DEBUG0: 01:25:00.515959 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.516013 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_4 (250:16) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:00.516044 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_2 (250:13).
>> [ 1:27.591] ## DEBUG0: 01:25:00.516072 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:13): 0 44032 linear 250:2 3072
>> [ 1:27.591] ## DEBUG0: 01:25:00.516101 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.516155 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_2 (250:13) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:00.516185 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_2 (250:12).
>> [ 1:27.591] ## DEBUG0: 01:25:00.516213 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:12): 0 1024 linear 250:2 2048
>> [ 1:27.591] ## DEBUG0: 01:25:00.516241 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.516295 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_2 (250:12) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:00.516324 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_1 (250:11).
>> [ 1:27.591] ## DEBUG0: 01:25:00.516352 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:11): 0 44032 linear 250:1 3072
>> [ 1:27.591] ## DEBUG0: 01:25:00.516381 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.516435 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_1 (250:11) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:00.516465 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_1 (250:10).
>> [ 1:27.591] ## DEBUG0: 01:25:00.516493 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:10): 0 1024 linear 250:1 2048
>> [ 1:27.591] ## DEBUG0: 01:25:00.516521 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.516575 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_1 (250:10) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:00.516605 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_0 (250:9).
>> [ 1:27.591] ## DEBUG0: 01:25:00.516633 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:9): 0 44032 linear 250:0 3072
>> [ 1:27.591] ## DEBUG0: 01:25:00.516662 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.516728 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_0 (250:9) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:00.516758 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_0 (250:8).
>> [ 1:27.591] ## DEBUG0: 01:25:00.516809 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:8): 0 1024 linear 250:0 2048
>> [ 1:27.591] ## DEBUG0: 01:25:00.516838 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.516892 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_0 (250:8) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:00.516922 lvconvert[15860] device_mapper/libdm-deptree.c:2211  Creating LVMTEST14057vg-LV1_rmeta_5
>> [ 1:27.591] ## DEBUG0: 01:25:00.516951 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm create LVMTEST14057vg-LV1_rmeta_5 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g [ noopencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.518580 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_5 (250:19).
>> [ 1:27.591] ## DEBUG0: 01:25:00.518715 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:19): 0 1024 linear 250:5 2048
>> [ 1:27.591] ## DEBUG0: 01:25:00.518747 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:19) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.518812 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm reload   (250:19) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.524653 lvconvert[15860] device_mapper/libdm-deptree.c:3281  Table size changed from 0 to 1024 for LVMTEST14057vg-LV1_rmeta_5 (250:19).
>> [ 1:27.591] ## DEBUG0: 01:25:00.524706 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_5 (250:19).
>> [ 1:27.591] ## DEBUG0: 01:25:00.524734 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:19) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.528889 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_5: Stacking NODE_ADD (250,19) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:00.529030 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_5: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.529065 lvconvert[15860] device_mapper/libdm-deptree.c:2211  Creating LVMTEST14057vg-LV1_rimage_5
>> [ 1:27.591] ## DEBUG0: 01:25:00.529099 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm create LVMTEST14057vg-LV1_rimage_5 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z [ noopencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.530951 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_5 (250:20).
>> [ 1:27.591] ## DEBUG0: 01:25:00.530990 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:20): 0 44032 linear 250:5 3072
>> [ 1:27.591] ## DEBUG0: 01:25:00.531036 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:20) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.531110 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm reload   (250:20) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.548724 lvconvert[15860] device_mapper/libdm-deptree.c:3281  Table size changed from 0 to 44032 for LVMTEST14057vg-LV1_rimage_5 (250:20).
>> [ 1:27.591] ## DEBUG0: 01:25:00.548867 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_5 (250:20).
>> [ 1:27.591] ## DEBUG0: 01:25:00.548897 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:20) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.549385 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_5: Stacking NODE_ADD (250,20) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:00.549423 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_5: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.549455 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1 (250:18).
>> [ 1:27.591] ## DEBUG0: 01:25:00.549483 lvconvert[15860] device_mapper/libdm-deptree.c:2495  Getting target version for raid
>> [ 1:27.591] ## DEBUG0: 01:25:00.549512 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm versions   [ opencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.549601 lvconvert[15860] device_mapper/libdm-deptree.c:2512  Found raid target v1.15.1.
>> [ 1:27.591] ## DEBUG0: 01:25:00.549638 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:18): 0 132096 raid raid6_zr 5 128 rebuild 3 region_size 1024 5 250:8 250:9 250:10 250:11 250:12 250:13 250:19 250:20 250:16 250:17
>> [ 1:27.591] ## DEBUG0: 01:25:00.549721 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:18) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.549797 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1818  reload 250:18 diff params for type raid
>> [ 1:27.591] ## DEBUG0: 01:25:00.549829 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1820  reload params1 raid6_zr 5 128 rebuild 3 region_size 1024 5 250:8 250:9 250:10 250:11 250:12 250:13 250:19 250:20 250:16 250:17
>> [ 1:27.591] ## DEBUG0: 01:25:00.549857 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1821  reload params2 raid6_zr 3 128 region_size 1024 5 250:8 250:9 250:10 250:11 250:12 250:13 250:14 250:15 250:16 250:17
>> [ 1:27.591] ## DEBUG0: 01:25:00.549889 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm reload   (250:18) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.700512 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H].
>> [ 1:27.591] ## DEBUG0: 01:25:00.700632 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.700686 lvconvert[15860] activate/dev_manager.c:3888  Creating PRELOAD tree for LVMTEST14057vg/LV1_rimage_3_extracted.
>> [ 1:27.591] ## DEBUG0: 01:25:00.700714 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3_extracted [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H].
>> [ 1:27.591] ## DEBUG0: 01:25:00.700738 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.700776 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:15) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.700865 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:3) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.700917 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3_extracted-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.700942 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.700975 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3_extracted-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.700998 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.701030 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_3_extracted to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.701054 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.701079 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.701102 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_3_extracted
>> [ 1:27.591] ## DEBUG0: 01:25:00.701129 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-missing_0_0].
>> [ 1:27.591] ## DEBUG0: 01:25:00.701153 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-missing_0_0 [ opencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.701183 lvconvert[15860] device_mapper/libdm-deptree.c:637  Not matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-missing_0_0 in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.701207 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-missing_0_0 in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.701255 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_3_extracted is 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.701280 lvconvert[15860] device_mapper/libdm-deptree.c:2211  Creating LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0
>> [ 1:27.591] ## DEBUG0: 01:25:00.701305 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm create LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-missing_0_0 [ noopencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.702232 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0 (250:21).
>> [ 1:27.591] ## DEBUG0: 01:25:00.702265 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:21): 0 44032 error
>> [ 1:27.591] ## DEBUG0: 01:25:00.702291 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:21) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.702342 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm reload   (250:21) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.712034 lvconvert[15860] device_mapper/libdm-deptree.c:3281  Table size changed from 0 to 44032 for LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0 (250:21).
>> [ 1:27.591] ## DEBUG0: 01:25:00.712146 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0 (250:21).
>> [ 1:27.591] ## DEBUG0: 01:25:00.712176 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:21) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.712655 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0: Stacking NODE_ADD (250,21) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:00.712708 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_3 (250:15).
>> [ 1:27.591] ## DEBUG0: 01:25:00.712735 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:15): 0 44032 linear 250:21 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.712762 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:15) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.712822 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1818  reload 250:15 diff params for type linear
>> [ 1:27.591] ## DEBUG0: 01:25:00.712846 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1820  reload params1 250:21 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.712869 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1821  reload params2 250:3 3072
>> [ 1:27.591] ## DEBUG0: 01:25:00.712893 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm reload   (250:15) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.714037 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV].
>> [ 1:27.591] ## DEBUG0: 01:25:00.714068 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.714107 lvconvert[15860] activate/dev_manager.c:3888  Creating PRELOAD tree for LVMTEST14057vg/LV1_rmeta_3_extracted.
>> [ 1:27.591] ## DEBUG0: 01:25:00.714134 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3_extracted [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV].
>> [ 1:27.591] ## DEBUG0: 01:25:00.714158 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.714193 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:14) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.714246 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:3) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.714295 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3_extracted-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.714321 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.714352 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3_extracted-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.714402 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.714435 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_3_extracted to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:00.714460 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.714484 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.714507 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_3_extracted
>> [ 1:27.591] ## DEBUG0: 01:25:00.714533 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-missing_0_0].
>> [ 1:27.591] ## DEBUG0: 01:25:00.714557 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-missing_0_0 [ opencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.714587 lvconvert[15860] device_mapper/libdm-deptree.c:637  Not matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-missing_0_0 in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.714612 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-missing_0_0 in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:00.714636 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_3_extracted is 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.714661 lvconvert[15860] device_mapper/libdm-deptree.c:2211  Creating LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0
>> [ 1:27.591] ## DEBUG0: 01:25:00.714694 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm create LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-missing_0_0 [ noopencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.719190 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0 (250:22).
>> [ 1:27.591] ## DEBUG0: 01:25:00.719299 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:22): 0 1024 error
>> [ 1:27.591] ## DEBUG0: 01:25:00.719320 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:22) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.719374 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm reload   (250:22) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.748563 lvconvert[15860] device_mapper/libdm-deptree.c:3281  Table size changed from 0 to 1024 for LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0 (250:22).
>> [ 1:27.591] ## DEBUG0: 01:25:00.748676 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0 (250:22).
>> [ 1:27.591] ## DEBUG0: 01:25:00.748713 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:22) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.749097 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0: Stacking NODE_ADD (250,22) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:00.749130 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_3 (250:14).
>> [ 1:27.591] ## DEBUG0: 01:25:00.749156 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:14): 0 1024 linear 250:22 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.749183 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:14) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.749240 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1818  reload 250:14 diff params for type linear
>> [ 1:27.591] ## DEBUG0: 01:25:00.749265 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1820  reload params1 250:22 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.749288 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1821  reload params2 250:3 2048
>> [ 1:27.591] ## DEBUG0: 01:25:00.749312 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm reload   (250:14) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.750470 lvconvert[15860] activate/activate.c:2169  Requiring flush for LV LVMTEST14057vg/LV1.
>> [ 1:27.591] ## DEBUG0: 01:25:00.750499 lvconvert[15860] mm/memlock.c:638  Entering critical section (suspending).
>> [ 1:27.591] ## DEBUG0: 01:25:00.750522 lvconvert[15860] mm/memlock.c:598  Lock:   Memlock counters: prioritized:1 locked:0 critical:1 daemon:0 suspended:0
>> [ 1:27.591] ## DEBUG0: 01:25:00.793546 lvconvert[15860] mm/memlock.c:532  Locking memory
>> [ 1:27.591] ## DEBUG0: 01:25:00.793673 lvconvert[15860] device_mapper/libdm-config.c:1085  activation/use_mlockall not found in config: defaulting to 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.795090 lvconvert[15860] mm/memlock.c:311  mlock        216KiB 56246274e000 - 562462784000 r--p 00000000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.591] ## DEBUG0: 01:25:00.795343 lvconvert[15860] mm/memlock.c:311  mlock       1356KiB 562462784000 - 5624628d7000 r-xp 00036000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.591] ## DEBUG0: 01:25:00.796241 lvconvert[15860] mm/memlock.c:311  mlock        768KiB 5624628d7000 - 562462997000 r--p 00189000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.591] ## DEBUG0: 01:25:00.796889 lvconvert[15860] mm/memlock.c:311  mlock         44KiB 562462997000 - 5624629a2000 r--p 00248000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.591] ## DEBUG0: 01:25:00.796976 lvconvert[15860] mm/memlock.c:311  mlock        248KiB 5624629a2000 - 5624629e0000 rw-p 00253000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.591] ## DEBUG0: 01:25:00.797268 lvconvert[15860] mm/memlock.c:311  mlock       2716KiB 5624629e0000 - 562462c87000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.798108 lvconvert[15860] mm/memlock.c:311  mlock      19208KiB 5624632e7000 - 5624645a9000 rw-p 00000000 00:00 0                          [heap]
>> [ 1:27.591] ## DEBUG0: 01:25:00.813688 lvconvert[15860] mm/memlock.c:311  mlock         16KiB 7f05f8c48000 - 7f05f8c4c000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.813885 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgpg-error.so.' matches '7f05f8c4c000-7f05f8c50000 r--p 00000000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.813917 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgpg-error.so.' matches '7f05f8c50000-7f05f8c66000 r-xp 00004000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.813942 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgpg-error.so.' matches '7f05f8c66000-7f05f8c6f000 r--p 0001a000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.813966 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8c6f000-7f05f8c70000 ---p 00023000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0 : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.813991 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgpg-error.so.' matches '7f05f8c70000-7f05f8c71000 r--p 00023000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814016 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgpg-error.so.' matches '7f05f8c71000-7f05f8c72000 rw-p 00024000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814040 lvconvert[15860] mm/memlock.c:311  mlock          8KiB 7f05f8c72000 - 7f05f8c74000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.814095 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libdl-' matches '7f05f8c74000-7f05f8c76000 r--p 00000000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814121 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libdl-' matches '7f05f8c76000-7f05f8c78000 r-xp 00002000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814146 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libdl-' matches '7f05f8c78000-7f05f8c79000 r--p 00004000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814170 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libdl-' matches '7f05f8c79000-7f05f8c7a000 r--p 00004000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814195 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8c7a000 - 7f05f8c7b000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.814273 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libpcre2-' matches '7f05f8c7b000-7f05f8c7d000 r--p 00000000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814301 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libpcre2-' matches '7f05f8c7d000-7f05f8ce8000 r-xp 00002000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814326 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libpcre2-' matches '7f05f8ce8000-7f05f8d0f000 r--p 0006d000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814349 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8d0f000-7f05f8d10000 ---p 00094000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1 : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814374 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libpcre2-' matches '7f05f8d10000-7f05f8d11000 r--p 00094000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814399 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libpcre2-' matches '7f05f8d11000-7f05f8d12000 rw-p 00095000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814425 lvconvert[15860] mm/memlock.c:311  mlock         28KiB 7f05f8d12000 - 7f05f8d19000 r--p 00000000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.814493 lvconvert[15860] mm/memlock.c:311  mlock         60KiB 7f05f8d19000 - 7f05f8d28000 r-xp 00007000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.814580 lvconvert[15860] mm/memlock.c:311  mlock         16KiB 7f05f8d28000 - 7f05f8d2c000 r--p 00016000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.814642 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8d2c000-7f05f8d2d000 ---p 0001a000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.814669 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8d2d000 - 7f05f8d2e000 r--p 0001a000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.814731 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8d2e000 - 7f05f8d2f000 rw-p 0001b000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.814782 lvconvert[15860] mm/memlock.c:311  mlock         16KiB 7f05f8d2f000 - 7f05f8d33000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.814883 lvconvert[15860] mm/memlock.c:311  mlock         12KiB 7f05f8d33000 - 7f05f8d36000 r--p 00000000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.591] ## DEBUG0: 01:25:00.814935 lvconvert[15860] mm/memlock.c:311  mlock         72KiB 7f05f8d36000 - 7f05f8d48000 r-xp 00003000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.591] ## DEBUG0: 01:25:00.815039 lvconvert[15860] mm/memlock.c:311  mlock         12KiB 7f05f8d48000 - 7f05f8d4b000 r--p 00015000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.591] ## DEBUG0: 01:25:00.815096 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8d4b000-7f05f8d4c000 ---p 00018000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1 : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815123 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8d4c000 - 7f05f8d4d000 r--p 00018000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.591] ## DEBUG0: 01:25:00.815175 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8d4d000 - 7f05f8d4e000 rw-p 00019000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.591] ## DEBUG0: 01:25:00.815227 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgcrypt.so.' matches '7f05f8d4e000-7f05f8d5c000 r--p 00000000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815253 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgcrypt.so.' matches '7f05f8d5c000-7f05f8e42000 r-xp 0000e000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815277 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgcrypt.so.' matches '7f05f8e42000-7f05f8e7f000 r--p 000f4000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815320 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8e7f000-7f05f8e80000 ---p 00131000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3 : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815346 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgcrypt.so.' matches '7f05f8e80000-7f05f8e83000 r--p 00131000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815370 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgcrypt.so.' matches '7f05f8e83000-7f05f8e89000 rw-p 00134000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815394 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8e89000 - 7f05f8e8a000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.815523 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libcap.so.' matches '7f05f8e8a000-7f05f8e8c000 r--p 00000000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815550 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libcap.so.' matches '7f05f8e8c000-7f05f8e90000 r-xp 00002000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815574 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libcap.so.' matches '7f05f8e90000-7f05f8e92000 r--p 00006000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815598 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libcap.so.' matches '7f05f8e92000-7f05f8e93000 r--p 00007000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815622 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libcap.so.' matches '7f05f8e93000-7f05f8e94000 rw-p 00008000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815646 lvconvert[15860] mm/memlock.c:311  mlock          8KiB 7f05f8e94000 - 7f05f8e96000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.815709 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblz4.so.' matches '7f05f8e96000-7f05f8e99000 r--p 00000000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815773 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblz4.so.' matches '7f05f8e99000-7f05f8eb5000 r-xp 00003000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815797 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblz4.so.' matches '7f05f8eb5000-7f05f8eb8000 r--p 0001f000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815822 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblz4.so.' matches '7f05f8eb8000-7f05f8eb9000 r--p 00021000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815846 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8eb9000 - 7f05f8eba000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.815956 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libzstd.so.' matches '7f05f8eba000-7f05f8ebf000 r--p 00000000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.815985 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libzstd.so.' matches '7f05f8ebf000-7f05f8f9f000 r-xp 00005000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816010 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libzstd.so.' matches '7f05f8f9f000-7f05f8fad000 r--p 000e5000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816034 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8fad000-7f05f8fae000 ---p 000f3000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0 : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816059 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libzstd.so.' matches '7f05f8fae000-7f05f8faf000 r--p 000f3000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816084 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libzstd.so.' matches '7f05f8faf000-7f05f8fb0000 rw-p 000f4000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816129 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblzma.so.' matches '7f05f8fb0000-7f05f8fb3000 r--p 00000000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816154 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblzma.so.' matches '7f05f8fb3000-7f05f8fce000 r-xp 00003000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816179 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblzma.so.' matches '7f05f8fce000-7f05f8fd9000 r--p 0001e000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816202 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8fd9000-7f05f8fda000 ---p 00029000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5 : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816226 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblzma.so.' matches '7f05f8fda000-7f05f8fdb000 r--p 00029000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816250 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8fdb000 - 7f05f8fdc000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.816361 lvconvert[15860] mm/memlock.c:311  mlock         12KiB 7f05f8fdc000 - 7f05f8fdf000 r--p 00000000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.816414 lvconvert[15860] mm/memlock.c:311  mlock         16KiB 7f05f8fdf000 - 7f05f8fe3000 r-xp 00003000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.816476 lvconvert[15860] mm/memlock.c:311  mlock          8KiB 7f05f8fe3000 - 7f05f8fe5000 r--p 00007000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.816542 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8fe5000 - 7f05f8fe6000 r--p 00008000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.816594 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8fe6000 - 7f05f8fe7000 rw-p 00009000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.816646 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libtinfo.so.' matches '7f05f8fe7000-7f05f8ff5000 r--p 00000000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816673 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libtinfo.so.' matches '7f05f8ff5000-7f05f9003000 r-xp 0000e000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816708 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libtinfo.so.' matches '7f05f9003000-7f05f9011000 r--p 0001c000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816734 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libtinfo.so.' matches '7f05f9011000-7f05f9015000 r--p 00029000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816759 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libtinfo.so.' matches '7f05f9015000-7f05f9016000 rw-p 0002d000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.816785 lvconvert[15860] mm/memlock.c:311  mlock        152KiB 7f05f9016000 - 7f05f903c000 r--p 00000000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.816925 lvconvert[15860] mm/memlock.c:311  mlock       1332KiB 7f05f903c000 - 7f05f9189000 r-xp 00026000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.817881 lvconvert[15860] mm/memlock.c:311  mlock        304KiB 7f05f9189000 - 7f05f91d5000 r--p 00173000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.818138 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f91d5000-7f05f91d6000 ---p 001bf000 fd:00 16807954                   /usr/lib64/libc-2.33.so : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.818166 lvconvert[15860] mm/memlock.c:311  mlock         12KiB 7f05f91d6000 - 7f05f91d9000 r--p 001bf000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.818225 lvconvert[15860] mm/memlock.c:311  mlock         12KiB 7f05f91d9000 - 7f05f91dc000 rw-p 001c2000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.818305 lvconvert[15860] mm/memlock.c:311  mlock         44KiB 7f05f91dc000 - 7f05f91e7000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.820379 lvconvert[15860] mm/memlock.c:311  mlock         60KiB 7f05f91e7000 - 7f05f91f6000 r--p 00000000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.820555 lvconvert[15860] mm/memlock.c:311  mlock        616KiB 7f05f91f6000 - 7f05f9290000 r-xp 0000f000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.821153 lvconvert[15860] mm/memlock.c:311  mlock        608KiB 7f05f9290000 - 7f05f9328000 r--p 000a9000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.821650 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f9328000-7f05f9329000 ---p 00141000 fd:00 16807958                   /usr/lib64/libm-2.33.so : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.821677 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f9329000 - 7f05f932a000 r--p 00141000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.821738 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f932a000 - 7f05f932b000 rw-p 00142000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.591] ## DEBUG0: 01:25:00.821790 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libselinux.so.' matches '7f05f932b000-7f05f9331000 r--p 00000000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.821817 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libselinux.so.' matches '7f05f9331000-7f05f934b000 r-xp 00006000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.821842 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libselinux.so.' matches '7f05f934b000-7f05f9352000 r--p 00020000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.821866 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f9352000-7f05f9353000 ---p 00027000 fd:00 16808421                   /usr/lib64/libselinux.so.1 : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.821891 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libselinux.so.' matches '7f05f9353000-7f05f9354000 r--p 00027000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.821916 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libselinux.so.' matches '7f05f9354000-7f05f9355000 rw-p 00028000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.821940 lvconvert[15860] mm/memlock.c:311  mlock          8KiB 7f05f9355000 - 7f05f9357000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.822076 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f9357000 - 7f05f9358000 r--p 00000000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.591] ## DEBUG0: 01:25:00.822127 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f9358000 - 7f05f9359000 r-xp 00001000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.591] ## DEBUG0: 01:25:00.822174 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f9359000 - 7f05f935a000 r--p 00002000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.591] ## DEBUG0: 01:25:00.822233 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f935a000 - 7f05f935b000 r--p 00002000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.591] ## DEBUG0: 01:25:00.822283 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f935b000 - 7f05f935c000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.822388 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libblkid.so.' matches '7f05f935c000-7f05f9363000 r--p 00000000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822414 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libblkid.so.' matches '7f05f9363000-7f05f9382000 r-xp 00007000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822438 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libblkid.so.' matches '7f05f9382000-7f05f938b000 r--p 00026000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822461 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f938b000-7f05f938c000 ---p 0002f000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0 : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822508 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libblkid.so.' matches '7f05f938c000-7f05f9390000 r--p 0002f000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822533 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libblkid.so.' matches '7f05f9390000-7f05f9391000 rw-p 00033000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822559 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libsystemd.so.' matches '7f05f9391000-7f05f93a3000 r--p 00000000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822584 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libsystemd.so.' matches '7f05f93a3000-7f05f9424000 r-xp 00012000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822609 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libsystemd.so.' matches '7f05f9424000-7f05f944f000 r--p 00093000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822634 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libsystemd.so.' matches '7f05f944f000-7f05f9453000 r--p 000bd000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822659 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libsystemd.so.' matches '7f05f9453000-7f05f9454000 rw-p 000c1000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822688 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f9454000 - 7f05f9455000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.822803 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libreadline.so.' matches '7f05f9455000-7f05f946b000 r--p 00000000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822831 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libreadline.so.' matches '7f05f946b000-7f05f9499000 r-xp 00016000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822856 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libreadline.so.' matches '7f05f9499000-7f05f94a3000 r--p 00044000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822880 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libreadline.so.' matches '7f05f94a3000-7f05f94a6000 r--p 0004d000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822905 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libreadline.so.' matches '7f05f94a6000-7f05f94ac000 rw-p 00050000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.822929 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f94ac000 - 7f05f94ad000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.823035 lvconvert[15860] mm/memlock.c:311  mlock         20KiB 7f05f94b4000 - 7f05f94b9000 rw-s 00000000 00:10 42259                      /[aio] (deleted)
>> [ 1:27.591] ## DEBUG0: 01:25:00.823094 lvconvert[15860] mm/memlock.c:311  mlock          8KiB 7f05f94b9000 - 7f05f94bb000 rw-p 00000000 00:00 0
>> [ 1:27.591] ## DEBUG0: 01:25:00.823149 lvconvert[15860] mm/memlock.c:283  mlock default filter '/ld-2.' matches '7f05f94bb000-7f05f94bc000 r--p 00000000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.823175 lvconvert[15860] mm/memlock.c:283  mlock default filter '/ld-2.' matches '7f05f94bc000-7f05f94e1000 r-xp 00001000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.823199 lvconvert[15860] mm/memlock.c:283  mlock default filter '/ld-2.' matches '7f05f94e1000-7f05f94eb000 r--p 00026000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.823222 lvconvert[15860] mm/memlock.c:283  mlock default filter '/ld-2.' matches '7f05f94eb000-7f05f94ed000 r--p 0002f000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.823246 lvconvert[15860] mm/memlock.c:283  mlock default filter '/ld-2.' matches '7f05f94ed000-7f05f94ef000 rw-p 00031000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.823289 lvconvert[15860] mm/memlock.c:311  mlock        136KiB 7ffdb806e000 - 7ffdb8090000 rw-p 00000000 00:00 0                          [stack]
>> [ 1:27.591] ## DEBUG0: 01:25:00.823628 lvconvert[15860] mm/memlock.c:311  mlock         16KiB 7ffdb813c000 - 7ffdb8140000 r--p 00000000 00:00 0                          [vvar]
>> [ 1:27.591] ## DEBUG0: 01:25:00.823661 lvconvert[15860] mm/memlock.c:273  mlock ignore filter '[vdso]' matches '7ffdb8140000-7ffdb8142000 r-xp 00000000 00:00 0                          [vdso]': Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.823694 lvconvert[15860] mm/memlock.c:266  mlock area unreadable ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall] : Skipping.
>> [ 1:27.591] ## DEBUG0: 01:25:00.823717 lvconvert[15860] mm/memlock.c:397  Locked 28921856 bytes
>> [ 1:27.591] ## DEBUG0: 01:25:00.823749 lvconvert[15860] activate/dev_manager.c:3888  Creating SUSPEND tree for LVMTEST14057vg/LV1.
>> [ 1:27.591] ## DEBUG0: 01:25:00.823777 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.591] ## DEBUG0: 01:25:00.823804 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.823849 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:18) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.823912 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.823964 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:4) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824014 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824063 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:15) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824111 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:3) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824158 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:14) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824205 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824254 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:2) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824302 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824351 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824399 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:1) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824448 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824497 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824545 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:0) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824594 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824644 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.824670 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824711 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.824735 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824788 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf].
>> [ 1:27.591] ## DEBUG0: 01:25:00.824812 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824845 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.824869 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824900 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.824923 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.824955 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG].
>> [ 1:27.591] ## DEBUG0: 01:25:00.824978 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825010 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825033 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825064 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825087 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825118 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825142 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825174 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825197 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825227 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825251 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825281 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825305 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825337 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825378 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825410 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825434 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825465 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825488 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825521 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825544 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825574 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825598 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825629 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825652 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825692 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825716 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825747 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825770 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825801 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825824 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825857 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825880 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825911 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.825934 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.825983 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV].
>> [ 1:27.591] ## DEBUG0: 01:25:00.826008 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.826040 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.826064 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.826094 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.826118 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.826149 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn].
>> [ 1:27.591] ## DEBUG0: 01:25:00.826172 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.826204 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.826228 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.826259 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.826282 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.826313 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s].
>> [ 1:27.591] ## DEBUG0: 01:25:00.826336 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.826368 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real].
>> [ 1:27.591] ## DEBUG0: 01:25:00.826392 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.826422 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:00.826445 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.826477 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:18) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:00.826508 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1 (250:18) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:00.826532 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:18) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.378657 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 1
>> [ 1:27.591] ## DEBUG0: 01:25:01.379109 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:17) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.379219 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rimage_4 (250:17) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:01.379288 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:17) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.388809 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 2
>> [ 1:27.591] ## DEBUG0: 01:25:01.389183 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:16) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.389287 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rmeta_4 (250:16) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:01.389355 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:16) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.390167 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 3
>> [ 1:27.591] ## DEBUG0: 01:25:01.390246 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:15) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.390316 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rimage_3 (250:15) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:01.390362 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:15) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.391226 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 4
>> [ 1:27.591] ## DEBUG0: 01:25:01.391285 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:14) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.391349 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rmeta_3 (250:14) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:01.391393 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:14) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.392292 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 5
>> [ 1:27.591] ## DEBUG0: 01:25:01.392405 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:13) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.392508 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rimage_2 (250:13) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:01.392576 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:13) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.393285 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 6
>> [ 1:27.591] ## DEBUG0: 01:25:01.393346 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:12) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.393408 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rmeta_2 (250:12) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:01.393452 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:12) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.394209 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 7
>> [ 1:27.591] ## DEBUG0: 01:25:01.394246 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:11) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.394288 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rimage_1 (250:11) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:01.394318 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:11) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.395079 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 8
>> [ 1:27.591] ## DEBUG0: 01:25:01.395120 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:10) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.395162 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rmeta_1 (250:10) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:01.395192 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:10) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.395943 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 9
>> [ 1:27.591] ## DEBUG0: 01:25:01.396018 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:9) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.396061 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rimage_0 (250:9) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:01.396091 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:9) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.396842 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 10
>> [ 1:27.591] ## DEBUG0: 01:25:01.396883 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:8) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.396924 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rmeta_0 (250:8) with device flush
>> [ 1:27.591] ## DEBUG0: 01:25:01.396954 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:8) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.397666 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 11
>> [ 1:27.591] ## DEBUG0: 01:25:01.397734 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 4096
>> [ 1:27.591] ## DEBUG0: 01:25:01.397773 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 mda header at 4096 (used).
>> [ 1:27.591] ## DEBUG0: 01:25:01.397802 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 222720 size 6156 slot1 offset 0 size 0.
>> [ 1:27.591] ## DEBUG0: 01:25:01.397836 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.591] ## DEBUG0: 01:25:01.399305 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 4096
>> [ 1:27.591] ## DEBUG0: 01:25:01.399635 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 mda header at 4096 (used).
>> [ 1:27.591] ## DEBUG0: 01:25:01.399731 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 141312 size 6156 slot1 offset 0 size 0.
>> [ 1:27.591] ## DEBUG0: 01:25:01.399803 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.591] ## DEBUG0: 01:25:01.401111 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 4096
>> [ 1:27.591] ## DEBUG0: 01:25:01.401216 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 mda header at 4096 (used).
>> [ 1:27.591] ## DEBUG0: 01:25:01.401282 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 65024 size 6156 slot1 offset 0 size 0.
>> [ 1:27.591] ## DEBUG0: 01:25:01.401353 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.591] ## DEBUG0: 01:25:01.402671 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 4096
>> [ 1:27.591] ## DEBUG0: 01:25:01.402804 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 mda header at 4096 (used).
>> [ 1:27.591] ## DEBUG0: 01:25:01.402872 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 21504 size 6156 slot1 offset 0 size 0.
>> [ 1:27.591] ## DEBUG0: 01:25:01.402942 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.591] ## DEBUG0: 01:25:01.404262 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 4096
>> [ 1:27.591] ## DEBUG0: 01:25:01.404367 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 mda header at 4096 (used).
>> [ 1:27.591] ## DEBUG0: 01:25:01.404435 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 222720 size 6156 slot1 offset 0 size 0.
>> [ 1:27.591] ## DEBUG0: 01:25:01.404505 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.591] ## DEBUG0: 01:25:01.405755 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 4096
>> [ 1:27.591] ## DEBUG0: 01:25:01.405838 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 mda header at 4096 (used).
>> [ 1:27.591] ## DEBUG0: 01:25:01.405902 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 222720 size 6156 slot1 offset 0 size 0.
>> [ 1:27.591] ## DEBUG0: 01:25:01.405971 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.591] ## DEBUG0: 01:25:01.407063 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 4096
>> [ 1:27.591] ## DEBUG0: 01:25:01.407143 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 50 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 mda header at 4096 (used).
>> [ 1:27.591] ## DEBUG0: 01:25:01.407207 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 222720 size 6156 slot1 offset 0 size 0.
>> [ 1:27.591] ## DEBUG0: 01:25:01.407275 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.591] ## DEBUG0: 01:25:01.408171 lvconvert[15860] metadata/vg.c:80  Freeing VG LVMTEST14057vg at 0x562463b7ba50.
>> [ 1:27.591] ## DEBUG0: 01:25:01.408252 lvconvert[15860] metadata/lv_manip.c:8008  Updating logical volume LVMTEST14057vg/LV1 in kernel.
>> [ 1:27.591] ## DEBUG0: 01:25:01.408483 lvconvert[15860] activate/activate.c:2311  Resuming LV LVMTEST14057vg/LV1 if active.
>> [ 1:27.591] ## DEBUG0: 01:25:01.408763 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.591] ## DEBUG0: 01:25:01.408836 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.408952 lvconvert[15860] activate/dev_manager.c:3888  Creating ACTIVATE tree for LVMTEST14057vg/LV1.
>> [ 1:27.591] ## DEBUG0: 01:25:01.409023 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.591] ## DEBUG0: 01:25:01.409088 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.409186 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:18) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.409349 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.409486 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:4) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.409622 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.409776 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:15) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.409909 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:3) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.410028 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:14) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.410156 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.410288 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:2) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.410421 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.410554 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.410698 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:1) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.410834 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.410968 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.411164 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:0) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.411300 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.411436 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.411506 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.411595 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.411654 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.411755 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf].
>> [ 1:27.591] ## DEBUG0: 01:25:01.411821 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.411912 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.411977 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.412062 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.412126 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.412213 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG].
>> [ 1:27.591] ## DEBUG0: 01:25:01.412278 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.412367 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.412428 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.412514 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.412578 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.412663 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW].
>> [ 1:27.591] ## DEBUG0: 01:25:01.412745 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.412835 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.412901 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.413035 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.413088 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.413168 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR].
>> [ 1:27.591] ## DEBUG0: 01:25:01.413234 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.413313 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.413368 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.413430 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.413478 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.413541 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS].
>> [ 1:27.591] ## DEBUG0: 01:25:01.413588 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.413654 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.413716 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.413780 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.413827 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.413890 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT].
>> [ 1:27.591] ## DEBUG0: 01:25:01.413937 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.414003 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.414051 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.414113 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.414160 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.414260 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z].
>> [ 1:27.591] ## DEBUG0: 01:25:01.414310 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.414377 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:20) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.414475 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:5) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.414573 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.414623 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.414694 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.414743 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.414806 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g].
>> [ 1:27.591] ## DEBUG0: 01:25:01.414853 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.414920 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:19) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.415016 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.415066 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.415129 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.415176 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.415238 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn].
>> [ 1:27.591] ## DEBUG0: 01:25:01.415286 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.415351 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.415399 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.415460 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.415507 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.415570 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s].
>> [ 1:27.591] ## DEBUG0: 01:25:01.415654 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.415736 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real].
>> [ 1:27.591] ## DEBUG0: 01:25:01.415785 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.415846 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow].
>> [ 1:27.591] ## DEBUG0: 01:25:01.415893 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.415956 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.416005 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.416052 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.416099 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports raid6 segment type for LVMTEST14057vg/LV1
>> [ 1:27.591] ## DEBUG0: 01:25:01.416146 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_0 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.416192 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.416238 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.416284 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_0
>> [ 1:27.591] ## DEBUG0: 01:25:01.416496 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_0 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:01.416547 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_0 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.416594 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.416639 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.416693 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_0
>> [ 1:27.591] ## DEBUG0: 01:25:01.416884 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_0 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:01.416933 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_1 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.416980 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.417025 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.417071 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_1
>> [ 1:27.591] ## DEBUG0: 01:25:01.417262 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_1 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:01.417312 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_1 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.417359 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.417405 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.417451 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_1
>> [ 1:27.591] ## DEBUG0: 01:25:01.417679 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_1 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:01.417738 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_2 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.417786 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.417831 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.417877 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_2
>> [ 1:27.591] ## DEBUG0: 01:25:01.418064 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_2 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:01.418113 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_2 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.418160 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.418206 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.418252 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_2
>> [ 1:27.591] ## DEBUG0: 01:25:01.418642 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_2 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:01.418850 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_5 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.418900 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.418946 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.418992 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_5
>> [ 1:27.591] ## DEBUG0: 01:25:01.419179 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_5 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:01.419228 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_5 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.419275 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.419320 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.419366 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_5
>> [ 1:27.591] ## DEBUG0: 01:25:01.419552 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_5 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:01.419601 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_4 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.419648 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.419707 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.419754 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_4
>> [ 1:27.591] ## DEBUG0: 01:25:01.419943 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_4 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:01.419993 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_4 to dtree
>> [ 1:27.591] ## DEBUG0: 01:25:01.420040 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420085 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420131 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_4
>> [ 1:27.591] ## DEBUG0: 01:25:01.420365 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_4 is 256
>> [ 1:27.591] ## DEBUG0: 01:25:01.420421 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420470 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420517 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420564 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420612 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420659 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420718 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420767 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420814 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420862 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.591] ## DEBUG0: 01:25:01.420912 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_4 (250:17).
>> [ 1:27.591] ## DEBUG0: 01:25:01.420963 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:17): 0 44032 linear 250:4 3072
>> [ 1:27.591] ## DEBUG0: 01:25:01.421017 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.421122 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_4 (250:17) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:01.421173 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_4 (250:16).
>> [ 1:27.591] ## DEBUG0: 01:25:01.421221 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:16): 0 1024 linear 250:4 2048
>> [ 1:27.591] ## DEBUG0: 01:25:01.421270 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.421363 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_4 (250:16) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:01.421414 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_2 (250:13).
>> [ 1:27.591] ## DEBUG0: 01:25:01.421461 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:13): 0 44032 linear 250:2 3072
>> [ 1:27.591] ## DEBUG0: 01:25:01.421510 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.421603 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_2 (250:13) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:01.421653 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_2 (250:12).
>> [ 1:27.591] ## DEBUG0: 01:25:01.421713 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:12): 0 1024 linear 250:2 2048
>> [ 1:27.591] ## DEBUG0: 01:25:01.421762 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.421855 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_2 (250:12) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:01.421906 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_1 (250:11).
>> [ 1:27.591] ## DEBUG0: 01:25:01.421954 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:11): 0 44032 linear 250:1 3072
>> [ 1:27.591] ## DEBUG0: 01:25:01.422043 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.422138 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_1 (250:11) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:01.422189 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_1 (250:10).
>> [ 1:27.591] ## DEBUG0: 01:25:01.422236 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:10): 0 1024 linear 250:1 2048
>> [ 1:27.591] ## DEBUG0: 01:25:01.422285 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.422377 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_1 (250:10) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:01.422428 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_0 (250:9).
>> [ 1:27.591] ## DEBUG0: 01:25:01.422475 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:9): 0 44032 linear 250:0 3072
>> [ 1:27.591] ## DEBUG0: 01:25:01.422523 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.422616 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_0 (250:9) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:01.422666 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_0 (250:8).
>> [ 1:27.591] ## DEBUG0: 01:25:01.422726 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:8): 0 1024 linear 250:0 2048
>> [ 1:27.591] ## DEBUG0: 01:25:01.422775 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.422867 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_0 (250:8) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:01.422917 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_5 (250:19).
>> [ 1:27.591] ## DEBUG0: 01:25:01.422964 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:19): 0 1024 linear 250:5 2048
>> [ 1:27.591] ## DEBUG0: 01:25:01.423013 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:19) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.423105 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_5 (250:19) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:01.423155 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_5 (250:20).
>> [ 1:27.591] ## DEBUG0: 01:25:01.423202 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:20): 0 44032 linear 250:5 3072
>> [ 1:27.591] ## DEBUG0: 01:25:01.423250 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:20) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.423342 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_5 (250:20) identical table reload.
>> [ 1:27.591] ## DEBUG0: 01:25:01.423396 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_4 (250:17).
>> [ 1:27.591] ## DEBUG0: 01:25:01.423446 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:17) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.424093 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_4: Stacking NODE_ADD (250,17) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:01.424173 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_4: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.424227 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 10
>> [ 1:27.591] ## DEBUG0: 01:25:01.424274 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_4 (250:16).
>> [ 1:27.591] ## DEBUG0: 01:25:01.424321 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:16) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.424795 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_4: Stacking NODE_ADD (250,16) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:01.424849 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_4: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.424895 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 9
>> [ 1:27.591] ## DEBUG0: 01:25:01.424984 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_3 (250:15).
>> [ 1:27.591] ## DEBUG0: 01:25:01.425034 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:15) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.426507 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_3: Stacking NODE_ADD (250,15) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:01.426549 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_3: Stacking NODE_READ_AHEAD 0 (flags=0)
>> [ 1:27.591] ## DEBUG0: 01:25:01.426578 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 8
>> [ 1:27.591] ## DEBUG0: 01:25:01.426618 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_3 (250:14).
>> [ 1:27.591] ## DEBUG0: 01:25:01.426658 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:14) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.439663 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_3: Stacking NODE_ADD (250,14) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:01.439867 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_3: Stacking NODE_READ_AHEAD 0 (flags=0)
>> [ 1:27.591] ## DEBUG0: 01:25:01.439911 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 7
>> [ 1:27.591] ## DEBUG0: 01:25:01.439953 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_2 (250:13).
>> [ 1:27.591] ## DEBUG0: 01:25:01.439996 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:13) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.440430 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_2: Stacking NODE_ADD (250,13) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:01.440478 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_2: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.440519 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 6
>> [ 1:27.591] ## DEBUG0: 01:25:01.440558 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_2 (250:12).
>> [ 1:27.591] ## DEBUG0: 01:25:01.440599 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:12) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.440990 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_2: Stacking NODE_ADD (250,12) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:01.441034 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_2: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.441073 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 5
>> [ 1:27.591] ## DEBUG0: 01:25:01.441112 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_1 (250:11).
>> [ 1:27.591] ## DEBUG0: 01:25:01.441153 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:11) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.441519 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_1: Stacking NODE_ADD (250,11) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:01.441562 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_1: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.441601 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 4
>> [ 1:27.591] ## DEBUG0: 01:25:01.441640 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_1 (250:10).
>> [ 1:27.591] ## DEBUG0: 01:25:01.441687 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:10) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.442074 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_1: Stacking NODE_ADD (250,10) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:01.442117 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_1: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.442156 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 3
>> [ 1:27.591] ## DEBUG0: 01:25:01.442195 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_0 (250:9).
>> [ 1:27.591] ## DEBUG0: 01:25:01.442236 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:9) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.442601 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_0: Stacking NODE_ADD (250,9) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:01.442702 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_0: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.442744 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 2
>> [ 1:27.591] ## DEBUG0: 01:25:01.442783 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_0 (250:8).
>> [ 1:27.591] ## DEBUG0: 01:25:01.442823 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:8) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.443207 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_0: Stacking NODE_ADD (250,8) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:01.443252 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_0: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:01.443291 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 1
>> [ 1:27.591] ## DEBUG0: 01:25:01.443331 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1 (250:18).
>> [ 1:27.591] ## DEBUG0: 01:25:01.443371 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:18) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:02.059771 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1: Stacking NODE_ADD (250,18) 0:0 0600 [verify_udev]
>> [ 1:27.591] ## DEBUG0: 01:25:02.059906 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1: Stacking NODE_READ_AHEAD 1280 (flags=1)
>> [ 1:27.591] ## DEBUG0: 01:25:02.059933 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 0
>> [ 1:27.591] ## DEBUG0: 01:25:02.059976 lvconvert[15860] activate/dev_manager.c:3888  Creating CLEAN tree for LVMTEST14057vg/LV1.
>> [ 1:27.591] ## DEBUG0: 01:25:02.060008 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.591] ## DEBUG0: 01:25:02.060035 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:02.060082 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:18) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:02.060144 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.591] ## DEBUG0: 01:25:02.060196 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:4) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060246 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060295 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:20) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060344 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:5) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060392 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:19) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060440 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060489 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:2) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060537 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060586 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060635 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:1) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060692 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060741 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060791 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:0) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060840 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060933 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.060960 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.060993 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061017 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061050 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061074 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061107 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061131 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061161 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061185 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061216 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061239 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061271 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061295 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061326 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061349 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061380 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061403 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061435 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061459 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061490 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061532 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061564 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061587 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061619 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061643 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061674 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061706 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061738 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061762 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061794 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061818 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061849 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061872 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061903 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061927 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.061959 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.061982 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062013 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062036 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062067 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062090 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062141 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062165 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062196 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062219 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062250 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062274 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062306 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062330 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062360 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062383 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062414 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062437 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062469 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062493 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062523 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062546 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062577 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062600 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062632 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062656 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062694 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.062737 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.062773 lvconvert[15860] mm/memlock.c:651  Leaving critical section (resumed).
>> [ 1:27.618] ## DEBUG0: 01:25:02.062797 lvconvert[15860] mm/memlock.c:653  Leaving section (unlocking on resume).
>> [ 1:27.618] ## DEBUG0: 01:25:02.062823 lvconvert[15860] activate/activate.c:2429  Deactivating LVMTEST14057vg/LV1_rmeta_3_extracted.
>> [ 1:27.618] ## DEBUG0: 01:25:02.062846 lvconvert[15860] activate/fs.c:493  Syncing device names
>> [ 1:27.618] ## DEBUG0: 01:25:02.062868 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_5: Processing NODE_ADD (250,19) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.063565 lvconvert[15860] device_mapper/libdm-common.c:1090  Created /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_5
>> [ 1:27.618] ## DEBUG0: 01:25:02.063595 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_5: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.064143 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rmeta_5 (250:19): read ahead is 256
>> [ 1:27.618] ## DEBUG0: 01:25:02.064229 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rmeta_5: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.618] ## DEBUG0: 01:25:02.064253 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_5: Processing NODE_ADD (250,20) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.064896 lvconvert[15860] device_mapper/libdm-common.c:1090  Created /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_5
>> [ 1:27.618] ## DEBUG0: 01:25:02.064924 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_5: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.065420 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rimage_5 (250:20): read ahead is 256
>> [ 1:27.618] ## DEBUG0: 01:25:02.065503 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rimage_5: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.618] ## DEBUG0: 01:25:02.065527 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0: Processing NODE_ADD (250,21) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.065986 lvconvert[15860] device_mapper/libdm-common.c:1090  Created /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0
>> [ 1:27.618] ## DEBUG0: 01:25:02.066013 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0: Processing NODE_ADD (250,22) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.066439 lvconvert[15860] device_mapper/libdm-common.c:1090  Created /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0
>> [ 1:27.618] ## DEBUG0: 01:25:02.066465 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_4: Processing NODE_ADD (250,17) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.066527 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_4: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.066899 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rimage_4 (250:17): read ahead is 256
>> [ 1:27.618] ## DEBUG0: 01:25:02.066980 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rimage_4: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.618] ## DEBUG0: 01:25:02.067004 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_4: Processing NODE_ADD (250,16) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.067065 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_4: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.067394 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rmeta_4 (250:16): read ahead is 256
>> [ 1:27.618] ## DEBUG0: 01:25:02.067467 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rmeta_4: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.618] ## DEBUG0: 01:25:02.067491 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_3: Processing NODE_ADD (250,15) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.067552 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_3: Processing NODE_READ_AHEAD 0 (flags=0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.067645 lvconvert[15860] device_mapper/libdm-common.c:1300  LVMTEST14057vg-LV1_rimage_3 (250:15): Setting read ahead to 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.068021 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_3: Processing NODE_ADD (250,14) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.068085 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_3: Processing NODE_READ_AHEAD 0 (flags=0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.068109 lvconvert[15860] device_mapper/libdm-common.c:1300  LVMTEST14057vg-LV1_rmeta_3 (250:14): Setting read ahead to 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.068536 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_2: Processing NODE_ADD (250,13) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.068697 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_2: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.069032 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rimage_2 (250:13): read ahead is 256
>> [ 1:27.618] ## DEBUG0: 01:25:02.069107 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rimage_2: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.618] ## DEBUG0: 01:25:02.069131 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_2: Processing NODE_ADD (250,12) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.069192 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_2: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.069519 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rmeta_2 (250:12): read ahead is 256
>> [ 1:27.618] ## DEBUG0: 01:25:02.069595 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rmeta_2: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.618] ## DEBUG0: 01:25:02.069619 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_1: Processing NODE_ADD (250,11) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.069679 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_1: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.070010 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rimage_1 (250:11): read ahead is 256
>> [ 1:27.618] ## DEBUG0: 01:25:02.070085 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rimage_1: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.618] ## DEBUG0: 01:25:02.070109 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_1: Processing NODE_ADD (250,10) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.070168 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_1: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.070493 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rmeta_1 (250:10): read ahead is 256
>> [ 1:27.618] ## DEBUG0: 01:25:02.070567 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rmeta_1: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.618] ## DEBUG0: 01:25:02.070591 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_0: Processing NODE_ADD (250,9) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.070650 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_0: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.070985 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rimage_0 (250:9): read ahead is 256
>> [ 1:27.618] ## DEBUG0: 01:25:02.071060 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rimage_0: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.618] ## DEBUG0: 01:25:02.071084 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_0: Processing NODE_ADD (250,8) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.071144 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_0: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.071469 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rmeta_0 (250:8): read ahead is 256
>> [ 1:27.618] ## DEBUG0: 01:25:02.071543 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rmeta_0: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.618] ## DEBUG0: 01:25:02.071567 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1: Processing NODE_ADD (250,18) 0:0 0600 [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.071654 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1: Processing NODE_READ_AHEAD 1280 (flags=1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.071986 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1 (250:18): read ahead is 768
>> [ 1:27.618] ## DEBUG0: 01:25:02.072063 lvconvert[15860] device_mapper/libdm-common.c:1300  LVMTEST14057vg-LV1 (250:18): Setting read ahead to 1280
>> [ 1:27.618] ## DEBUG0: 01:25:02.072520 lvconvert[15860] activate/fs.c:202  Removing /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/LVMTEST14057vg/LV1
>> [ 1:27.618] ## DEBUG0: 01:25:02.072839 lvconvert[15860] activate/fs.c:212  Linking /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/LVMTEST14057vg/LV1 -> /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1
>> [ 1:27.618] ## DEBUG0: 01:25:02.073355 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3_extracted [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV].
>> [ 1:27.618] ## DEBUG0: 01:25:02.073510 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV [ opencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.073551 lvconvert[15860] mm/memlock.c:641  Entering prioritized section (deactivating).
>> [ 1:27.618] ## DEBUG0: 01:25:02.073577 lvconvert[15860] activate/dev_manager.c:3888  Creating DEACTIVATE tree for LVMTEST14057vg/LV1_rmeta_3_extracted.
>> [ 1:27.618] ## DEBUG0: 01:25:02.073603 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3_extracted [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV].
>> [ 1:27.618] ## DEBUG0: 01:25:02.073628 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.073666 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:14) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.073738 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:22) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.073788 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3_extracted-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.073814 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.073846 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3_extracted-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.073870 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.073903 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:14) [ opencount flush ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.073935 lvconvert[15860] device_mapper/libdm-deptree.c:1026  Removing LVMTEST14057vg-LV1_rmeta_3 (250:14)
>> [ 1:27.618] ## DEBUG0: 01:25:02.073959 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm remove   (250:14) [ noopencount flush retryremove ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.121432 lvconvert[15860] device_mapper/libdm-common.c:1490  LVMTEST14057vg-LV1_rmeta_3: Stacking NODE_DEL [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.121661 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:22) [ opencount flush ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.121748 lvconvert[15860] device_mapper/libdm-deptree.c:1026  Removing LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0 (250:22)
>> [ 1:27.618] ## DEBUG0: 01:25:02.121789 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm remove   (250:22) [ noopencount flush retryremove ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.160133 lvconvert[15860] device_mapper/libdm-common.c:1490  LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0: Stacking NODE_DEL [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.160504 lvconvert[15860] mm/memlock.c:653  Leaving section (deactivated).
>> [ 1:27.618] ## DEBUG0: 01:25:02.160572 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3_extracted [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV].
>> [ 1:27.618] ## DEBUG0: 01:25:02.160740 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUbogWutx8vGQwuoA7wXYT05aroySanZV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.160854 lvconvert[15860] device_mapper/libdm-config.c:1085  devices/issue_discards not found in config: defaulting to 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.160927 lvconvert[15860] activate/activate.c:2429  Deactivating LVMTEST14057vg/LV1_rimage_3_extracted.
>> [ 1:27.618] ## DEBUG0: 01:25:02.160983 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3_extracted [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H].
>> [ 1:27.618] ## DEBUG0: 01:25:02.161044 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H [ opencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.161138 lvconvert[15860] mm/memlock.c:641  Entering prioritized section (deactivating).
>> [ 1:27.618] ## DEBUG0: 01:25:02.161199 lvconvert[15860] activate/dev_manager.c:3888  Creating DEACTIVATE tree for LVMTEST14057vg/LV1_rimage_3_extracted.
>> [ 1:27.618] ## DEBUG0: 01:25:02.161250 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3_extracted [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H].
>> [ 1:27.618] ## DEBUG0: 01:25:02.161310 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.161410 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:15) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.161559 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:21) [ opencount flush ]   [16384] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.161705 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3_extracted-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-real].
>> [ 1:27.618] ## DEBUG0: 01:25:02.161756 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.161826 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3_extracted-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-cow].
>> [ 1:27.618] ## DEBUG0: 01:25:02.161888 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.161971 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:15) [ opencount flush ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.162044 lvconvert[15860] device_mapper/libdm-deptree.c:1026  Removing LVMTEST14057vg-LV1_rimage_3 (250:15)
>> [ 1:27.618] ## DEBUG0: 01:25:02.162106 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm remove   (250:15) [ noopencount flush retryremove ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.259372 lvconvert[15860] device_mapper/libdm-common.c:1490  LVMTEST14057vg-LV1_rimage_3: Stacking NODE_DEL [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.259557 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:21) [ opencount flush ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.259619 lvconvert[15860] device_mapper/libdm-deptree.c:1026  Removing LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0 (250:21)
>> [ 1:27.618] ## DEBUG0: 01:25:02.259658 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm remove   (250:21) [ noopencount flush retryremove ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.299294 lvconvert[15860] device_mapper/libdm-common.c:1490  LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0: Stacking NODE_DEL [verify_udev]
>> [ 1:27.618] ## DEBUG0: 01:25:02.299485 lvconvert[15860] mm/memlock.c:653  Leaving section (deactivated).
>> [ 1:27.618] ## DEBUG0: 01:25:02.299529 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3_extracted [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H].
>> [ 1:27.618] ## DEBUG0: 01:25:02.299571 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCrNBezxsdYKD1fE9iaEgsIfNlX99kqt4H [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.618] ## DEBUG0: 01:25:02.299635 lvconvert[15860] device_mapper/libdm-config.c:1085  devices/issue_discards not found in config: defaulting to 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.299763 lvconvert[15860] metadata/lv_manip.c:7986  Updating logical volume LVMTEST14057vg/LV1 on disk(s) (origin only).
>> [ 1:27.618] ## DEBUG0: 01:25:02.299803 lvconvert[15860] metadata/metadata.c:2927  Writing metadata for VG LVMTEST14057vg.
>> [ 1:27.618] ## DEBUG0: 01:25:02.299844 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 0:      0      1: LV1_rmeta_0(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.299883 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 1:      1     43: LV1_rimage_0(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.299920 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 2:     44    114: NULL(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.299957 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 0:      0      1: LV1_rmeta_3(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.299994 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 1:      1     43: LV1_rimage_3(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300030 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 2:     44    114: NULL(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300066 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 0:      0    158: NULL(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300102 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 0:      0    158: NULL(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300139 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 0:      0      1: LV1_rmeta_1(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300171 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 1:      1     43: LV1_rimage_1(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300207 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 2:     44    114: NULL(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300243 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 0:      0      1: LV1_rmeta_2(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300280 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 1:      1     43: LV1_rimage_2(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300316 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 2:     44    114: NULL(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300349 lvconvert[15860] metadata/pv_manip.c:413  [unknown] 0:      0    158: NULL(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300392 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 0:      0      1: LV1_rmeta_4(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300428 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 1:      1     43: LV1_rimage_4(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300464 lvconvert[15860] metadata/pv_manip.c:413  /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 2:     44    114: NULL(0:0)
>> [ 1:27.618] ## DEBUG0: 01:25:02.300533 lvconvert[15860] mm/memlock.c:609  Unlock: Memlock counters: prioritized:1 locked:1 critical:0 daemon:0 suspended:0
>> [ 1:27.618] ## DEBUG0: 01:25:02.300570 lvconvert[15860] mm/memlock.c:568  Unlocking memory
>> [ 1:27.618] ## DEBUG0: 01:25:02.301703 lvconvert[15860] mm/memlock.c:311  munlock        216KiB 56246274e000 - 562462784000 r--p 00000000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.618] ## DEBUG0: 01:25:02.301991 lvconvert[15860] mm/memlock.c:311  munlock       1356KiB 562462784000 - 5624628d7000 r-xp 00036000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.618] ## DEBUG0: 01:25:02.302606 lvconvert[15860] mm/memlock.c:311  munlock        768KiB 5624628d7000 - 562462997000 r--p 00189000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.618] ## DEBUG0: 01:25:02.303081 lvconvert[15860] mm/memlock.c:311  munlock         44KiB 562462997000 - 5624629a2000 r--p 00248000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.618] ## DEBUG0: 01:25:02.303190 lvconvert[15860] mm/memlock.c:311  munlock        248KiB 5624629a2000 - 5624629e0000 rw-p 00253000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.618] ## DEBUG0: 01:25:02.303462 lvconvert[15860] mm/memlock.c:311  munlock       2716KiB 5624629e0000 - 562462c87000 rw-p 00000000 00:00 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.304143 lvconvert[15860] mm/memlock.c:311  munlock      19208KiB 5624632e7000 - 5624645a9000 rw-p 00000000 00:00 0                          [heap]
>> [ 1:27.618] ## DEBUG0: 01:25:02.309953 lvconvert[15860] mm/memlock.c:311  munlock         16KiB 7f05f8c48000 - 7f05f8c4c000 rw-p 00000000 00:00 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.310107 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgpg-error.so.' matches '7f05f8c4c000-7f05f8c50000 r--p 00000000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310140 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgpg-error.so.' matches '7f05f8c50000-7f05f8c66000 r-xp 00004000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310169 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgpg-error.so.' matches '7f05f8c66000-7f05f8c6f000 r--p 0001a000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310197 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8c6f000-7f05f8c70000 ---p 00023000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0 : Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310226 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgpg-error.so.' matches '7f05f8c70000-7f05f8c71000 r--p 00023000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310255 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgpg-error.so.' matches '7f05f8c71000-7f05f8c72000 rw-p 00024000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310284 lvconvert[15860] mm/memlock.c:311  munlock          8KiB 7f05f8c72000 - 7f05f8c74000 rw-p 00000000 00:00 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.310337 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libdl-' matches '7f05f8c74000-7f05f8c76000 r--p 00000000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310368 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libdl-' matches '7f05f8c76000-7f05f8c78000 r-xp 00002000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310397 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libdl-' matches '7f05f8c78000-7f05f8c79000 r--p 00004000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310426 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libdl-' matches '7f05f8c79000-7f05f8c7a000 r--p 00004000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310454 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8c7a000 - 7f05f8c7b000 rw-p 00000000 00:00 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.310506 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libpcre2-' matches '7f05f8c7b000-7f05f8c7d000 r--p 00000000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310538 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libpcre2-' matches '7f05f8c7d000-7f05f8ce8000 r-xp 00002000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310568 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libpcre2-' matches '7f05f8ce8000-7f05f8d0f000 r--p 0006d000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310596 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8d0f000-7f05f8d10000 ---p 00094000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1 : Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310626 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libpcre2-' matches '7f05f8d10000-7f05f8d11000 r--p 00094000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310655 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libpcre2-' matches '7f05f8d11000-7f05f8d12000 rw-p 00095000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310694 lvconvert[15860] mm/memlock.c:311  munlock         28KiB 7f05f8d12000 - 7f05f8d19000 r--p 00000000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.618] ## DEBUG0: 01:25:02.310787 lvconvert[15860] mm/memlock.c:311  munlock         60KiB 7f05f8d19000 - 7f05f8d28000 r-xp 00007000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.618] ## DEBUG0: 01:25:02.310860 lvconvert[15860] mm/memlock.c:311  munlock         16KiB 7f05f8d28000 - 7f05f8d2c000 r--p 00016000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.618] ## DEBUG0: 01:25:02.310911 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8d2c000-7f05f8d2d000 ---p 0001a000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so : Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.310943 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8d2d000 - 7f05f8d2e000 r--p 0001a000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.618] ## DEBUG0: 01:25:02.310996 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8d2e000 - 7f05f8d2f000 rw-p 0001b000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.618] ## DEBUG0: 01:25:02.311048 lvconvert[15860] mm/memlock.c:311  munlock         16KiB 7f05f8d2f000 - 7f05f8d33000 rw-p 00000000 00:00 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.311109 lvconvert[15860] mm/memlock.c:311  munlock         12KiB 7f05f8d33000 - 7f05f8d36000 r--p 00000000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.618] ## DEBUG0: 01:25:02.311161 lvconvert[15860] mm/memlock.c:311  munlock         72KiB 7f05f8d36000 - 7f05f8d48000 r-xp 00003000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.618] ## DEBUG0: 01:25:02.311240 lvconvert[15860] mm/memlock.c:311  munlock         12KiB 7f05f8d48000 - 7f05f8d4b000 r--p 00015000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.618] ## DEBUG0: 01:25:02.311288 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8d4b000-7f05f8d4c000 ---p 00018000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1 : Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311321 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8d4c000 - 7f05f8d4d000 r--p 00018000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.618] ## DEBUG0: 01:25:02.311374 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8d4d000 - 7f05f8d4e000 rw-p 00019000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.618] ## DEBUG0: 01:25:02.311426 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgcrypt.so.' matches '7f05f8d4e000-7f05f8d5c000 r--p 00000000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311457 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgcrypt.so.' matches '7f05f8d5c000-7f05f8e42000 r-xp 0000e000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311486 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgcrypt.so.' matches '7f05f8e42000-7f05f8e7f000 r--p 000f4000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311514 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8e7f000-7f05f8e80000 ---p 00131000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3 : Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311543 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgcrypt.so.' matches '7f05f8e80000-7f05f8e83000 r--p 00131000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311573 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgcrypt.so.' matches '7f05f8e83000-7f05f8e89000 rw-p 00134000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311601 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8e89000 - 7f05f8e8a000 rw-p 00000000 00:00 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.311652 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libcap.so.' matches '7f05f8e8a000-7f05f8e8c000 r--p 00000000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311687 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libcap.so.' matches '7f05f8e8c000-7f05f8e90000 r-xp 00002000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311717 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libcap.so.' matches '7f05f8e90000-7f05f8e92000 r--p 00006000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311769 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libcap.so.' matches '7f05f8e92000-7f05f8e93000 r--p 00007000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311799 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libcap.so.' matches '7f05f8e93000-7f05f8e94000 rw-p 00008000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311828 lvconvert[15860] mm/memlock.c:311  munlock          8KiB 7f05f8e94000 - 7f05f8e96000 rw-p 00000000 00:00 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.311885 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblz4.so.' matches '7f05f8e96000-7f05f8e99000 r--p 00000000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311916 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblz4.so.' matches '7f05f8e99000-7f05f8eb5000 r-xp 00003000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311946 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblz4.so.' matches '7f05f8eb5000-7f05f8eb8000 r--p 0001f000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.311975 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblz4.so.' matches '7f05f8eb8000-7f05f8eb9000 r--p 00021000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.312004 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8eb9000 - 7f05f8eba000 rw-p 00000000 00:00 0
>> [ 1:27.618] ## DEBUG0: 01:25:02.312057 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libzstd.so.' matches '7f05f8eba000-7f05f8ebf000 r--p 00000000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.312089 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libzstd.so.' matches '7f05f8ebf000-7f05f8f9f000 r-xp 00005000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.312119 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libzstd.so.' matches '7f05f8f9f000-7f05f8fad000 r--p 000e5000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.312147 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8fad000-7f05f8fae000 ---p 000f3000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0 : Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.312178 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libzstd.so.' matches '7f05f8fae000-7f05f8faf000 r--p 000f3000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.312208 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libzstd.so.' matches '7f05f8faf000-7f05f8fb0000 rw-p 000f4000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.312238 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblzma.so.' matches '7f05f8fb0000-7f05f8fb3000 r--p 00000000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.312267 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblzma.so.' matches '7f05f8fb3000-7f05f8fce000 r-xp 00003000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.618] ## DEBUG0: 01:25:02.312297 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblzma.so.' matches '7f05f8fce000-7f05f8fd9000 r--p 0001e000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.312324 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8fd9000-7f05f8fda000 ---p 00029000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.312354 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblzma.so.' matches '7f05f8fda000-7f05f8fdb000 r--p 00029000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.312382 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8fdb000 - 7f05f8fdc000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.312435 lvconvert[15860] mm/memlock.c:311  munlock         12KiB 7f05f8fdc000 - 7f05f8fdf000 r--p 00000000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.312514 lvconvert[15860] mm/memlock.c:311  munlock         16KiB 7f05f8fdf000 - 7f05f8fe3000 r-xp 00003000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.312577 lvconvert[15860] mm/memlock.c:311  munlock          8KiB 7f05f8fe3000 - 7f05f8fe5000 r--p 00007000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.312632 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8fe5000 - 7f05f8fe6000 r--p 00008000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.312693 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8fe6000 - 7f05f8fe7000 rw-p 00009000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.312747 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libtinfo.so.' matches '7f05f8fe7000-7f05f8ff5000 r--p 00000000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.312779 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libtinfo.so.' matches '7f05f8ff5000-7f05f9003000 r-xp 0000e000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.312809 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libtinfo.so.' matches '7f05f9003000-7f05f9011000 r--p 0001c000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.312839 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libtinfo.so.' matches '7f05f9011000-7f05f9015000 r--p 00029000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.312869 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libtinfo.so.' matches '7f05f9015000-7f05f9016000 rw-p 0002d000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.312901 lvconvert[15860] mm/memlock.c:311  munlock        152KiB 7f05f9016000 - 7f05f903c000 r--p 00000000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.312996 lvconvert[15860] mm/memlock.c:311  munlock       1332KiB 7f05f903c000 - 7f05f9189000 r-xp 00026000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.313468 lvconvert[15860] mm/memlock.c:311  munlock        304KiB 7f05f9189000 - 7f05f91d5000 r--p 00173000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.313602 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f91d5000-7f05f91d6000 ---p 001bf000 fd:00 16807954                   /usr/lib64/libc-2.33.so : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.313635 lvconvert[15860] mm/memlock.c:311  munlock         12KiB 7f05f91d6000 - 7f05f91d9000 r--p 001bf000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.313700 lvconvert[15860] mm/memlock.c:311  munlock         12KiB 7f05f91d9000 - 7f05f91dc000 rw-p 001c2000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.313758 lvconvert[15860] mm/memlock.c:311  munlock         44KiB 7f05f91dc000 - 7f05f91e7000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.313835 lvconvert[15860] mm/memlock.c:311  munlock         60KiB 7f05f91e7000 - 7f05f91f6000 r--p 00000000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.313914 lvconvert[15860] mm/memlock.c:311  munlock        616KiB 7f05f91f6000 - 7f05f9290000 r-xp 0000f000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.314253 lvconvert[15860] mm/memlock.c:311  munlock        608KiB 7f05f9290000 - 7f05f9328000 r--p 000a9000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.314463 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f9328000-7f05f9329000 ---p 00141000 fd:00 16807958                   /usr/lib64/libm-2.33.so : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.314496 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f9329000 - 7f05f932a000 r--p 00141000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.314548 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f932a000 - 7f05f932b000 rw-p 00142000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.314601 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libselinux.so.' matches '7f05f932b000-7f05f9331000 r--p 00000000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.314655 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libselinux.so.' matches '7f05f9331000-7f05f934b000 r-xp 00006000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.314697 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libselinux.so.' matches '7f05f934b000-7f05f9352000 r--p 00020000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.314726 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f9352000-7f05f9353000 ---p 00027000 fd:00 16808421                   /usr/lib64/libselinux.so.1 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.314755 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libselinux.so.' matches '7f05f9353000-7f05f9354000 r--p 00027000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.314785 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libselinux.so.' matches '7f05f9354000-7f05f9355000 rw-p 00028000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.314814 lvconvert[15860] mm/memlock.c:311  munlock          8KiB 7f05f9355000 - 7f05f9357000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.314873 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f9357000 - 7f05f9358000 r--p 00000000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.314926 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f9358000 - 7f05f9359000 r-xp 00001000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.314977 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f9359000 - 7f05f935a000 r--p 00002000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.315029 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f935a000 - 7f05f935b000 r--p 00002000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.315080 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f935b000 - 7f05f935c000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.315132 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libblkid.so.' matches '7f05f935c000-7f05f9363000 r--p 00000000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315162 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libblkid.so.' matches '7f05f9363000-7f05f9382000 r-xp 00007000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315190 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libblkid.so.' matches '7f05f9382000-7f05f938b000 r--p 00026000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315218 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f938b000-7f05f938c000 ---p 0002f000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315247 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libblkid.so.' matches '7f05f938c000-7f05f9390000 r--p 0002f000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315275 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libblkid.so.' matches '7f05f9390000-7f05f9391000 rw-p 00033000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315306 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libsystemd.so.' matches '7f05f9391000-7f05f93a3000 r--p 00000000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315336 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libsystemd.so.' matches '7f05f93a3000-7f05f9424000 r-xp 00012000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315366 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libsystemd.so.' matches '7f05f9424000-7f05f944f000 r--p 00093000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315396 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libsystemd.so.' matches '7f05f944f000-7f05f9453000 r--p 000bd000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315449 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libsystemd.so.' matches '7f05f9453000-7f05f9454000 rw-p 000c1000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315479 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f9454000 - 7f05f9455000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.315534 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libreadline.so.' matches '7f05f9455000-7f05f946b000 r--p 00000000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315566 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libreadline.so.' matches '7f05f946b000-7f05f9499000 r-xp 00016000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315596 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libreadline.so.' matches '7f05f9499000-7f05f94a3000 r--p 00044000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315625 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libreadline.so.' matches '7f05f94a3000-7f05f94a6000 r--p 0004d000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315655 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libreadline.so.' matches '7f05f94a6000-7f05f94ac000 rw-p 00050000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315692 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f94ac000 - 7f05f94ad000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.315747 lvconvert[15860] mm/memlock.c:311  munlock         20KiB 7f05f94b4000 - 7f05f94b9000 rw-s 00000000 00:10 42259                      /[aio] (deleted)
>> [ 1:27.629] ## DEBUG0: 01:25:02.315782 lvconvert[15860] mm/memlock.c:311  munlock          8KiB 7f05f94b9000 - 7f05f94bb000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.315835 lvconvert[15860] mm/memlock.c:283  munlock default filter '/ld-2.' matches '7f05f94bb000-7f05f94bc000 r--p 00000000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315865 lvconvert[15860] mm/memlock.c:283  munlock default filter '/ld-2.' matches '7f05f94bc000-7f05f94e1000 r-xp 00001000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315893 lvconvert[15860] mm/memlock.c:283  munlock default filter '/ld-2.' matches '7f05f94e1000-7f05f94eb000 r--p 00026000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315922 lvconvert[15860] mm/memlock.c:283  munlock default filter '/ld-2.' matches '7f05f94eb000-7f05f94ed000 r--p 0002f000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315950 lvconvert[15860] mm/memlock.c:283  munlock default filter '/ld-2.' matches '7f05f94ed000-7f05f94ef000 rw-p 00031000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.315979 lvconvert[15860] mm/memlock.c:311  munlock        136KiB 7ffdb806e000 - 7ffdb8090000 rw-p 00000000 00:00 0                          [stack]
>> [ 1:27.629] ## DEBUG0: 01:25:02.316110 lvconvert[15860] mm/memlock.c:311  munlock         16KiB 7ffdb813c000 - 7ffdb8140000 r--p 00000000 00:00 0                          [vvar]
>> [ 1:27.629] ## DEBUG0: 01:25:02.316145 lvconvert[15860] mm/memlock.c:273  munlock ignore filter '[vdso]' matches '7ffdb8140000-7ffdb8142000 r-xp 00000000 00:00 0                          [vdso]': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.316174 lvconvert[15860] mm/memlock.c:266  munlock area unreadable ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall] : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.316200 lvconvert[15860] mm/memlock.c:397  Unlocked 28921856 bytes
>> [ 1:27.629] ## DEBUG0: 01:25:02.316323 lvconvert[15860] mm/memlock.c:518  Restoring original task priority 0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323268 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.323550 lvconvert[15860] metadata/vg.c:65  Allocated VG LVMTEST14057vg at 0x562463b9d1b0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323623 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323651 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323676 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323711 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_1.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323735 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_1.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323759 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_2.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323787 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_2.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323811 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_4.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323835 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_4.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323859 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rmeta_3.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323883 lvconvert[15860] format_text/import_vsn1.c:631  Importing logical volume LVMTEST14057vg/LV1_rimage_3.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323915 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[0] on LV LVMTEST14057vg/LV1_rmeta_0:0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323939 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323962 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[0] on LV LVMTEST14057vg/LV1_rimage_0:0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.323985 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324008 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[1] on LV LVMTEST14057vg/LV1_rmeta_1:0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324031 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_1.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324054 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[1] on LV LVMTEST14057vg/LV1_rimage_1:0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324077 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_1.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324100 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[2] on LV LVMTEST14057vg/LV1_rmeta_2:0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324123 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_2.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324146 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[2] on LV LVMTEST14057vg/LV1_rimage_2:0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324169 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_2.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324192 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[3] on LV LVMTEST14057vg/LV1_rmeta_3:0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324215 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_3.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324237 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[3] on LV LVMTEST14057vg/LV1_rimage_3:0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324263 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_3.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324286 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[4] on LV LVMTEST14057vg/LV1_rmeta_4:0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324309 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rmeta_4.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324331 lvconvert[15860] metadata/lv_manip.c:1329  Stack LVMTEST14057vg/LV1:0[4] on LV LVMTEST14057vg/LV1_rimage_4:0.
>> [ 1:27.629] ## DEBUG0: 01:25:02.324354 lvconvert[15860] metadata/lv_manip.c:870  Adding LVMTEST14057vg/LV1:0 as an user of LVMTEST14057vg/LV1_rimage_4.
>> [ 1:27.629] ## DEBUG0: 01:25:02.326014 lvconvert[15860] metadata/metadata.c:3558  WARNING: Couldn't find device with uuid KsNO3k-FBmu-ddrJ-hf2J-Mj3e-y8mM-mLppWh.
>> [ 1:27.629] ## DEBUG0: 01:25:02.326724 lvconvert[15860] format_text/import.c:240  There are 1 physical volumes missing.
>> [ 1:27.629] ## DEBUG0: 01:25:02.326957 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 51 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.629] ## DEBUG0: 01:25:02.327026 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 51 new metadata start align from 228876 to 229376 (+500)
>> [ 1:27.629] ## DEBUG0: 01:25:02.327089 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 51 metadata area location old start 222720 last 228875 size 6156 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.327151 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 51 metadata area location new start 229376 last 234912 size 5537 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.327213 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 51 metadata disk location start 233472 size 5537 last 239008
>> [ 1:27.629] ## DEBUG0: 01:25:02.327274 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 51 metadata last align from 239008 to 239103 (+95)
>> [ 1:27.629] ## DEBUG0: 01:25:02.327337 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 51 metadata write at 233472 size 5632 (wrap 0)
>> [ 1:27.629] ## DEBUG0: 01:25:02.330090 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.330229 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 51 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.629] ## DEBUG0: 01:25:02.330256 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 51 new metadata start align from 147468 to 147968 (+500)
>> [ 1:27.629] ## DEBUG0: 01:25:02.330280 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 51 metadata area location old start 141312 last 147467 size 6156 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.330303 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 51 metadata area location new start 147968 last 153504 size 5537 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.330327 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 51 metadata disk location start 152064 size 5537 last 157600
>> [ 1:27.629] ## DEBUG0: 01:25:02.330355 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 51 metadata last align from 157600 to 157695 (+95)
>> [ 1:27.629] ## DEBUG0: 01:25:02.330382 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 51 metadata write at 152064 size 5632 (wrap 0)
>> [ 1:27.629] ## DEBUG0: 01:25:02.334771 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.334822 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 51 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.629] ## DEBUG0: 01:25:02.334856 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 51 new metadata start align from 71180 to 71680 (+500)
>> [ 1:27.629] ## DEBUG0: 01:25:02.334888 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 51 metadata area location old start 65024 last 71179 size 6156 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.334920 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 51 metadata area location new start 71680 last 77216 size 5537 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.334951 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 51 metadata disk location start 75776 size 5537 last 81312
>> [ 1:27.629] ## DEBUG0: 01:25:02.334982 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 51 metadata last align from 81312 to 81407 (+95)
>> [ 1:27.629] ## DEBUG0: 01:25:02.335014 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 51 metadata write at 75776 size 5632 (wrap 0)
>> [ 1:27.629] ## DEBUG0: 01:25:02.336157 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.336202 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 51 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.629] ## DEBUG0: 01:25:02.336235 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 51 new metadata start align from 27660 to 28160 (+500)
>> [ 1:27.629] ## DEBUG0: 01:25:02.336267 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 51 metadata area location old start 21504 last 27659 size 6156 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.336409 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 51 metadata area location new start 28160 last 33696 size 5537 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.336447 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 51 metadata disk location start 32256 size 5537 last 37792
>> [ 1:27.629] ## DEBUG0: 01:25:02.336479 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 51 metadata last align from 37792 to 37887 (+95)
>> [ 1:27.629] ## DEBUG0: 01:25:02.336506 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 51 metadata write at 32256 size 5632 (wrap 0)
>> [ 1:27.629] ## DEBUG0: 01:25:02.337571 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.337612 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 51 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.629] ## DEBUG0: 01:25:02.337919 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 51 new metadata start align from 228876 to 229376 (+500)
>> [ 1:27.629] ## DEBUG0: 01:25:02.338010 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 51 metadata area location old start 222720 last 228875 size 6156 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.338539 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 51 metadata area location new start 229376 last 234912 size 5537 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.338735 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 51 metadata disk location start 233472 size 5537 last 239008
>> [ 1:27.629] ## DEBUG0: 01:25:02.338774 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 51 metadata last align from 239008 to 239103 (+95)
>> [ 1:27.629] ## DEBUG0: 01:25:02.338809 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 51 metadata write at 233472 size 5632 (wrap 0)
>> [ 1:27.629] ## DEBUG0: 01:25:02.339965 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.340008 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 51 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.629] ## DEBUG0: 01:25:02.340033 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 51 new metadata start align from 228876 to 229376 (+500)
>> [ 1:27.629] ## DEBUG0: 01:25:02.340051 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 51 metadata area location old start 222720 last 228875 size 6156 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.340075 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 51 metadata area location new start 229376 last 234912 size 5537 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.340091 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 51 metadata disk location start 233472 size 5537 last 239008
>> [ 1:27.629] ## DEBUG0: 01:25:02.340114 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 51 metadata last align from 239008 to 239103 (+95)
>> [ 1:27.629] ## DEBUG0: 01:25:02.340137 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 51 metadata write at 233472 size 5632 (wrap 0)
>> [ 1:27.629] ## DEBUG0: 01:25:02.341977 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.342023 lvconvert[15860] format_text/format-text.c:663  VG LVMTEST14057vg seqno 51 metadata write to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 mda_start 4096 mda_size 1044480 mda_last 1048575
>> [ 1:27.629] ## DEBUG0: 01:25:02.342047 lvconvert[15860] format_text/format-text.c:372  VG LVMTEST14057vg 51 new metadata start align from 228876 to 229376 (+500)
>> [ 1:27.629] ## DEBUG0: 01:25:02.342070 lvconvert[15860] format_text/format-text.c:778  VG LVMTEST14057vg 51 metadata area location old start 222720 last 228875 size 6156 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.342092 lvconvert[15860] format_text/format-text.c:785  VG LVMTEST14057vg 51 metadata area location new start 229376 last 234912 size 5537 wrap 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.342115 lvconvert[15860] format_text/format-text.c:871  VG LVMTEST14057vg 51 metadata disk location start 233472 size 5537 last 239008
>> [ 1:27.629] ## DEBUG0: 01:25:02.342170 lvconvert[15860] format_text/format-text.c:910  VG LVMTEST14057vg 51 metadata last align from 239008 to 239103 (+95)
>> [ 1:27.629] ## DEBUG0: 01:25:02.342195 lvconvert[15860] format_text/format-text.c:958  VG LVMTEST14057vg 51 metadata write at 233472 size 5632 (wrap 0)
>> [ 1:27.629] ## DEBUG0: 01:25:02.343488 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.343534 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:02.343559 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 222720 size 6156 slot1 offset 229376 size 5537.
>> [ 1:27.629] ## DEBUG0: 01:25:02.343584 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:02.344359 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.344398 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:02.344423 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 141312 size 6156 slot1 offset 147968 size 5537.
>> [ 1:27.629] ## DEBUG0: 01:25:02.344450 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:02.345228 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.345272 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:02.345296 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 65024 size 6156 slot1 offset 71680 size 5537.
>> [ 1:27.629] ## DEBUG0: 01:25:02.345323 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:02.345737 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.345767 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:02.345790 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 21504 size 6156 slot1 offset 28160 size 5537.
>> [ 1:27.629] ## DEBUG0: 01:25:02.345815 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:02.346327 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.346357 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:02.346380 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 222720 size 6156 slot1 offset 229376 size 5537.
>> [ 1:27.629] ## DEBUG0: 01:25:02.346405 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:02.346964 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.346993 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:02.347016 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 222720 size 6156 slot1 offset 229376 size 5537.
>> [ 1:27.629] ## DEBUG0: 01:25:02.347041 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:02.347576 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:02.347631 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata precommit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:02.347655 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata precommit slot0 offset 222720 size 6156 slot1 offset 229376 size 5537.
>> [ 1:27.629] ## DEBUG0: 01:25:02.347688 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:02.348221 lvconvert[15860] mm/memlock.c:641  Entering prioritized section (locking for suspend).
>> [ 1:27.629] ## DEBUG0: 01:25:02.348262 lvconvert[15860] mm/memlock.c:504  Raised task priority 0 -> -18.
>> [ 1:27.629] ## DEBUG0: 01:25:02.348290 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.629] ## DEBUG0: 01:25:02.348456 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.348583 lvconvert[15860] activate/dev_manager.c:3888  Creating PRELOAD tree for LVMTEST14057vg/LV1.
>> [ 1:27.629] ## DEBUG0: 01:25:02.348611 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.629] ## DEBUG0: 01:25:02.348631 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.348667 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:18) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.348743 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.348794 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:4) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.348842 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.348889 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:20) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.348937 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:5) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.348985 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:19) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349033 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349079 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:2) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349127 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349175 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349223 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:1) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349270 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349311 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349354 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:0) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349399 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349442 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.349464 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349496 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.349545 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349573 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf].
>> [ 1:27.629] ## DEBUG0: 01:25:02.349597 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349630 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.349653 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349677 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.349712 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349744 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG].
>> [ 1:27.629] ## DEBUG0: 01:25:02.349767 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349799 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.349822 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349852 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.349876 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349906 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW].
>> [ 1:27.629] ## DEBUG0: 01:25:02.349930 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.349962 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.349986 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350017 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350061 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350098 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350123 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350173 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350198 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350223 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350245 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350276 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350300 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350332 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350356 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350389 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350413 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350444 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350463 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350496 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350519 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350543 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350566 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350597 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350616 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350647 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350673 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350719 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350761 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350794 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350817 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350849 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350873 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350898 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350921 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.350952 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn].
>> [ 1:27.629] ## DEBUG0: 01:25:02.350975 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.351006 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.351030 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.351061 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.351084 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.351115 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s].
>> [ 1:27.629] ## DEBUG0: 01:25:02.351139 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.351170 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.351195 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.351225 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.351244 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.351275 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.351306 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.351348 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.351370 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports raid6 segment type for LVMTEST14057vg/LV1
>> [ 1:27.629] ## DEBUG0: 01:25:02.351392 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_0 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.351413 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.351435 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.351458 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_0
>> [ 1:27.629] ## DEBUG0: 01:25:02.351566 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_0 is 256
>> [ 1:27.629] ## DEBUG0: 01:25:02.351590 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_0 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.351614 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.351637 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.351660 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_0
>> [ 1:27.629] ## DEBUG0: 01:25:02.351762 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_0 is 256
>> [ 1:27.629] ## DEBUG0: 01:25:02.351787 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_1 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.351810 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.351833 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.351856 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_1
>> [ 1:27.629] ## DEBUG0: 01:25:02.351949 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_1 is 256
>> [ 1:27.629] ## DEBUG0: 01:25:02.351980 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_1 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.352009 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.352033 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.352056 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_1
>> [ 1:27.629] ## DEBUG0: 01:25:02.352149 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_1 is 256
>> [ 1:27.629] ## DEBUG0: 01:25:02.352172 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_2 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.352195 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.352218 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.352240 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_2
>> [ 1:27.629] ## DEBUG0: 01:25:02.352325 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_2 is 256
>> [ 1:27.629] ## DEBUG0: 01:25:02.352351 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_2 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.352392 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.352419 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.352461 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_2
>> [ 1:27.629] ## DEBUG0: 01:25:02.352555 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_2 is 256
>> [ 1:27.629] ## DEBUG0: 01:25:02.352580 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_3 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.352604 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.352627 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.352650 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_3
>> [ 1:27.629] ## DEBUG0: 01:25:02.352757 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_3 is 256
>> [ 1:27.629] ## DEBUG0: 01:25:02.352783 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_3 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.352807 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.352829 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.352853 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_3
>> [ 1:27.629] ## DEBUG0: 01:25:02.352937 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_3 is 256
>> [ 1:27.629] ## DEBUG0: 01:25:02.352958 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_4 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.352982 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.353005 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.353028 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_4
>> [ 1:27.629] ## DEBUG0: 01:25:02.353122 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_4 is 256
>> [ 1:27.629] ## DEBUG0: 01:25:02.353147 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_4 to dtree
>> [ 1:27.629] ## DEBUG0: 01:25:02.353170 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.353192 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.353231 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_4
>> [ 1:27.629] ## DEBUG0: 01:25:02.353327 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_4 is 256
>> [ 1:27.629] ## DEBUG0: 01:25:02.353355 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.353619 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.353714 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.353994 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.354075 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.354101 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.354125 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.354189 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.354215 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.354240 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.629] ## DEBUG0: 01:25:02.354267 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_4 (250:17).
>> [ 1:27.629] ## DEBUG0: 01:25:02.354538 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:17): 0 44032 linear 250:4 3072
>> [ 1:27.629] ## DEBUG0: 01:25:02.354621 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.354991 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_4 (250:17) identical table reload.
>> [ 1:27.629] ## DEBUG0: 01:25:02.355069 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_4 (250:16).
>> [ 1:27.629] ## DEBUG0: 01:25:02.355097 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:16): 0 1024 linear 250:4 2048
>> [ 1:27.629] ## DEBUG0: 01:25:02.355124 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.355187 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_4 (250:16) identical table reload.
>> [ 1:27.629] ## DEBUG0: 01:25:02.355213 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_5 (250:20).
>> [ 1:27.629] ## DEBUG0: 01:25:02.355237 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:20): 0 44032 linear 250:5 3072
>> [ 1:27.629] ## DEBUG0: 01:25:02.355261 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:20) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.355309 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_5 (250:20) identical table reload.
>> [ 1:27.629] ## DEBUG0: 01:25:02.355334 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_5 (250:19).
>> [ 1:27.629] ## DEBUG0: 01:25:02.355357 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:19): 0 1024 linear 250:5 2048
>> [ 1:27.629] ## DEBUG0: 01:25:02.355382 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:19) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.355621 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_5 (250:19) identical table reload.
>> [ 1:27.629] ## DEBUG0: 01:25:02.355713 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_2 (250:13).
>> [ 1:27.629] ## DEBUG0: 01:25:02.355742 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:13): 0 44032 linear 250:2 3072
>> [ 1:27.629] ## DEBUG0: 01:25:02.355770 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.355831 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_2 (250:13) identical table reload.
>> [ 1:27.629] ## DEBUG0: 01:25:02.356093 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_2 (250:12).
>> [ 1:27.629] ## DEBUG0: 01:25:02.356173 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:12): 0 1024 linear 250:2 2048
>> [ 1:27.629] ## DEBUG0: 01:25:02.356202 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.356266 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_2 (250:12) identical table reload.
>> [ 1:27.629] ## DEBUG0: 01:25:02.356294 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_1 (250:11).
>> [ 1:27.629] ## DEBUG0: 01:25:02.356318 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:11): 0 44032 linear 250:1 3072
>> [ 1:27.629] ## DEBUG0: 01:25:02.356343 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.356596 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_1 (250:11) identical table reload.
>> [ 1:27.629] ## DEBUG0: 01:25:02.356661 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_1 (250:10).
>> [ 1:27.629] ## DEBUG0: 01:25:02.356704 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:10): 0 1024 linear 250:1 2048
>> [ 1:27.629] ## DEBUG0: 01:25:02.356729 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.356776 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_1 (250:10) identical table reload.
>> [ 1:27.629] ## DEBUG0: 01:25:02.356801 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_0 (250:9).
>> [ 1:27.629] ## DEBUG0: 01:25:02.356825 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:9): 0 44032 linear 250:0 3072
>> [ 1:27.629] ## DEBUG0: 01:25:02.356849 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.356888 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_0 (250:9) identical table reload.
>> [ 1:27.629] ## DEBUG0: 01:25:02.356990 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_0 (250:8).
>> [ 1:27.629] ## DEBUG0: 01:25:02.357017 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:8): 0 1024 linear 250:0 2048
>> [ 1:27.629] ## DEBUG0: 01:25:02.357042 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.357088 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_0 (250:8) identical table reload.
>> [ 1:27.629] ## DEBUG0: 01:25:02.357113 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1 (250:18).
>> [ 1:27.629] ## DEBUG0: 01:25:02.357138 lvconvert[15860] device_mapper/libdm-deptree.c:2495  Getting target version for raid
>> [ 1:27.629] ## DEBUG0: 01:25:02.357161 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm versions   [ opencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.357336 lvconvert[15860] device_mapper/libdm-deptree.c:2512  Found raid target v1.15.1.
>> [ 1:27.629] ## DEBUG0: 01:25:02.357369 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:18): 0 132096 raid raid6_zr 3 128 region_size 1024 5 250:8 250:9 250:10 250:11 250:12 250:13 250:19 250:20 250:16 250:17
>> [ 1:27.629] ## DEBUG0: 01:25:02.357395 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:18) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.357449 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1818  reload 250:18 diff params for type raid
>> [ 1:27.629] ## DEBUG0: 01:25:02.357473 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1820  reload params1 raid6_zr 3 128 region_size 1024 5 250:8 250:9 250:10 250:11 250:12 250:13 250:19 250:20 250:16 250:17
>> [ 1:27.629] ## DEBUG0: 01:25:02.357496 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:1821  reload params2 raid6_zr 5 128 rebuild 3 region_size 1024 5 250:8 250:9 250:10 250:11 250:12 250:13 250:19 250:20 250:16 250:17
>> [ 1:27.629] ## DEBUG0: 01:25:02.357521 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm reload   (250:18) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.558117 lvconvert[15860] activate/activate.c:2169  Requiring flush for LV LVMTEST14057vg/LV1.
>> [ 1:27.629] ## DEBUG0: 01:25:02.558270 lvconvert[15860] mm/memlock.c:638  Entering critical section (suspending).
>> [ 1:27.629] ## DEBUG0: 01:25:02.558305 lvconvert[15860] mm/memlock.c:598  Lock:   Memlock counters: prioritized:1 locked:0 critical:1 daemon:0 suspended:0
>> [ 1:27.629] ## DEBUG0: 01:25:02.577379 lvconvert[15860] mm/memlock.c:532  Locking memory
>> [ 1:27.629] ## DEBUG0: 01:25:02.577498 lvconvert[15860] device_mapper/libdm-config.c:1085  activation/use_mlockall not found in config: defaulting to 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.578562 lvconvert[15860] mm/memlock.c:311  mlock        216KiB 56246274e000 - 562462784000 r--p 00000000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.629] ## DEBUG0: 01:25:02.578905 lvconvert[15860] mm/memlock.c:311  mlock       1356KiB 562462784000 - 5624628d7000 r-xp 00036000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.629] ## DEBUG0: 01:25:02.579787 lvconvert[15860] mm/memlock.c:311  mlock        768KiB 5624628d7000 - 562462997000 r--p 00189000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.629] ## DEBUG0: 01:25:02.580349 lvconvert[15860] mm/memlock.c:311  mlock         44KiB 562462997000 - 5624629a2000 r--p 00248000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.629] ## DEBUG0: 01:25:02.580465 lvconvert[15860] mm/memlock.c:311  mlock        248KiB 5624629a2000 - 5624629e0000 rw-p 00253000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.629] ## DEBUG0: 01:25:02.580742 lvconvert[15860] mm/memlock.c:311  mlock       2716KiB 5624629e0000 - 562462c87000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.581377 lvconvert[15860] mm/memlock.c:311  mlock      19212KiB 5624632e7000 - 5624645aa000 rw-p 00000000 00:00 0                          [heap]
>> [ 1:27.629] ## DEBUG0: 01:25:02.587835 lvconvert[15860] mm/memlock.c:311  mlock         16KiB 7f05f8c48000 - 7f05f8c4c000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.587903 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgpg-error.so.' matches '7f05f8c4c000-7f05f8c50000 r--p 00000000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.587930 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgpg-error.so.' matches '7f05f8c50000-7f05f8c66000 r-xp 00004000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.587955 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgpg-error.so.' matches '7f05f8c66000-7f05f8c6f000 r--p 0001a000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.587978 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8c6f000-7f05f8c70000 ---p 00023000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588003 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgpg-error.so.' matches '7f05f8c70000-7f05f8c71000 r--p 00023000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588027 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgpg-error.so.' matches '7f05f8c71000-7f05f8c72000 rw-p 00024000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588051 lvconvert[15860] mm/memlock.c:311  mlock          8KiB 7f05f8c72000 - 7f05f8c74000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.588103 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libdl-' matches '7f05f8c74000-7f05f8c76000 r--p 00000000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588130 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libdl-' matches '7f05f8c76000-7f05f8c78000 r-xp 00002000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588154 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libdl-' matches '7f05f8c78000-7f05f8c79000 r--p 00004000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588178 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libdl-' matches '7f05f8c79000-7f05f8c7a000 r--p 00004000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588202 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8c7a000 - 7f05f8c7b000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.588252 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libpcre2-' matches '7f05f8c7b000-7f05f8c7d000 r--p 00000000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588279 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libpcre2-' matches '7f05f8c7d000-7f05f8ce8000 r-xp 00002000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588304 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libpcre2-' matches '7f05f8ce8000-7f05f8d0f000 r--p 0006d000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588458 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8d0f000-7f05f8d10000 ---p 00094000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588573 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libpcre2-' matches '7f05f8d10000-7f05f8d11000 r--p 00094000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588609 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libpcre2-' matches '7f05f8d11000-7f05f8d12000 rw-p 00095000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588659 lvconvert[15860] mm/memlock.c:311  mlock         28KiB 7f05f8d12000 - 7f05f8d19000 r--p 00000000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.588745 lvconvert[15860] mm/memlock.c:311  mlock         60KiB 7f05f8d19000 - 7f05f8d28000 r-xp 00007000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.588832 lvconvert[15860] mm/memlock.c:311  mlock         16KiB 7f05f8d28000 - 7f05f8d2c000 r--p 00016000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.588880 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8d2c000-7f05f8d2d000 ---p 0001a000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.588910 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8d2d000 - 7f05f8d2e000 r--p 0001a000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.588962 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8d2e000 - 7f05f8d2f000 rw-p 0001b000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.589012 lvconvert[15860] mm/memlock.c:311  mlock         16KiB 7f05f8d2f000 - 7f05f8d33000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.589074 lvconvert[15860] mm/memlock.c:311  mlock         12KiB 7f05f8d33000 - 7f05f8d36000 r--p 00000000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.589125 lvconvert[15860] mm/memlock.c:311  mlock         72KiB 7f05f8d36000 - 7f05f8d48000 r-xp 00003000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.589220 lvconvert[15860] mm/memlock.c:311  mlock         12KiB 7f05f8d48000 - 7f05f8d4b000 r--p 00015000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.589269 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8d4b000-7f05f8d4c000 ---p 00018000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589296 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8d4c000 - 7f05f8d4d000 r--p 00018000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.589346 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8d4d000 - 7f05f8d4e000 rw-p 00019000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.589397 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgcrypt.so.' matches '7f05f8d4e000-7f05f8d5c000 r--p 00000000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589423 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgcrypt.so.' matches '7f05f8d5c000-7f05f8e42000 r-xp 0000e000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589448 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgcrypt.so.' matches '7f05f8e42000-7f05f8e7f000 r--p 000f4000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589471 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8e7f000-7f05f8e80000 ---p 00131000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589496 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgcrypt.so.' matches '7f05f8e80000-7f05f8e83000 r--p 00131000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589520 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libgcrypt.so.' matches '7f05f8e83000-7f05f8e89000 rw-p 00134000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589543 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8e89000 - 7f05f8e8a000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.589593 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libcap.so.' matches '7f05f8e8a000-7f05f8e8c000 r--p 00000000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589618 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libcap.so.' matches '7f05f8e8c000-7f05f8e90000 r-xp 00002000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589662 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libcap.so.' matches '7f05f8e90000-7f05f8e92000 r--p 00006000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589695 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libcap.so.' matches '7f05f8e92000-7f05f8e93000 r--p 00007000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589720 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libcap.so.' matches '7f05f8e93000-7f05f8e94000 rw-p 00008000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589744 lvconvert[15860] mm/memlock.c:311  mlock          8KiB 7f05f8e94000 - 7f05f8e96000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.589802 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblz4.so.' matches '7f05f8e96000-7f05f8e99000 r--p 00000000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589828 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblz4.so.' matches '7f05f8e99000-7f05f8eb5000 r-xp 00003000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589852 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblz4.so.' matches '7f05f8eb5000-7f05f8eb8000 r--p 0001f000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589877 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblz4.so.' matches '7f05f8eb8000-7f05f8eb9000 r--p 00021000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589901 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8eb9000 - 7f05f8eba000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.589952 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libzstd.so.' matches '7f05f8eba000-7f05f8ebf000 r--p 00000000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.589980 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libzstd.so.' matches '7f05f8ebf000-7f05f8f9f000 r-xp 00005000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590006 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libzstd.so.' matches '7f05f8f9f000-7f05f8fad000 r--p 000e5000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590029 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8fad000-7f05f8fae000 ---p 000f3000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590054 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libzstd.so.' matches '7f05f8fae000-7f05f8faf000 r--p 000f3000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590080 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libzstd.so.' matches '7f05f8faf000-7f05f8fb0000 rw-p 000f4000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590104 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblzma.so.' matches '7f05f8fb0000-7f05f8fb3000 r--p 00000000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590128 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblzma.so.' matches '7f05f8fb3000-7f05f8fce000 r-xp 00003000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590153 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblzma.so.' matches '7f05f8fce000-7f05f8fd9000 r--p 0001e000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590176 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f8fd9000-7f05f8fda000 ---p 00029000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590201 lvconvert[15860] mm/memlock.c:283  mlock default filter '/liblzma.so.' matches '7f05f8fda000-7f05f8fdb000 r--p 00029000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590244 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8fdb000 - 7f05f8fdc000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.590299 lvconvert[15860] mm/memlock.c:311  mlock         12KiB 7f05f8fdc000 - 7f05f8fdf000 r--p 00000000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.590351 lvconvert[15860] mm/memlock.c:311  mlock         16KiB 7f05f8fdf000 - 7f05f8fe3000 r-xp 00003000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.590413 lvconvert[15860] mm/memlock.c:311  mlock          8KiB 7f05f8fe3000 - 7f05f8fe5000 r--p 00007000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.590468 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8fe5000 - 7f05f8fe6000 r--p 00008000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.590519 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f8fe6000 - 7f05f8fe7000 rw-p 00009000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.590570 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libtinfo.so.' matches '7f05f8fe7000-7f05f8ff5000 r--p 00000000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590597 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libtinfo.so.' matches '7f05f8ff5000-7f05f9003000 r-xp 0000e000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590622 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libtinfo.so.' matches '7f05f9003000-7f05f9011000 r--p 0001c000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590648 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libtinfo.so.' matches '7f05f9011000-7f05f9015000 r--p 00029000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590673 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libtinfo.so.' matches '7f05f9015000-7f05f9016000 rw-p 0002d000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.590707 lvconvert[15860] mm/memlock.c:311  mlock        152KiB 7f05f9016000 - 7f05f903c000 r--p 00000000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.590846 lvconvert[15860] mm/memlock.c:311  mlock       1332KiB 7f05f903c000 - 7f05f9189000 r-xp 00026000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.591736 lvconvert[15860] mm/memlock.c:311  mlock        304KiB 7f05f9189000 - 7f05f91d5000 r--p 00173000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.591965 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f91d5000-7f05f91d6000 ---p 001bf000 fd:00 16807954                   /usr/lib64/libc-2.33.so : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.591992 lvconvert[15860] mm/memlock.c:311  mlock         12KiB 7f05f91d6000 - 7f05f91d9000 r--p 001bf000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.592050 lvconvert[15860] mm/memlock.c:311  mlock         12KiB 7f05f91d9000 - 7f05f91dc000 rw-p 001c2000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.592107 lvconvert[15860] mm/memlock.c:311  mlock         44KiB 7f05f91dc000 - 7f05f91e7000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.592193 lvconvert[15860] mm/memlock.c:311  mlock         60KiB 7f05f91e7000 - 7f05f91f6000 r--p 00000000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.592287 lvconvert[15860] mm/memlock.c:311  mlock        616KiB 7f05f91f6000 - 7f05f9290000 r-xp 0000f000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.592813 lvconvert[15860] mm/memlock.c:311  mlock        608KiB 7f05f9290000 - 7f05f9328000 r--p 000a9000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.593235 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f9328000-7f05f9329000 ---p 00141000 fd:00 16807958                   /usr/lib64/libm-2.33.so : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593262 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f9329000 - 7f05f932a000 r--p 00141000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.593313 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f932a000 - 7f05f932b000 rw-p 00142000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.629] ## DEBUG0: 01:25:02.593387 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libselinux.so.' matches '7f05f932b000-7f05f9331000 r--p 00000000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593414 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libselinux.so.' matches '7f05f9331000-7f05f934b000 r-xp 00006000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593439 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libselinux.so.' matches '7f05f934b000-7f05f9352000 r--p 00020000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593462 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f9352000-7f05f9353000 ---p 00027000 fd:00 16808421                   /usr/lib64/libselinux.so.1 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593487 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libselinux.so.' matches '7f05f9353000-7f05f9354000 r--p 00027000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593512 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libselinux.so.' matches '7f05f9354000-7f05f9355000 rw-p 00028000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593536 lvconvert[15860] mm/memlock.c:311  mlock          8KiB 7f05f9355000 - 7f05f9357000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.593591 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f9357000 - 7f05f9358000 r--p 00000000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.593640 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f9358000 - 7f05f9359000 r-xp 00001000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.593696 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f9359000 - 7f05f935a000 r--p 00002000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.593745 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f935a000 - 7f05f935b000 r--p 00002000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.629] ## DEBUG0: 01:25:02.593794 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f935b000 - 7f05f935c000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.593844 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libblkid.so.' matches '7f05f935c000-7f05f9363000 r--p 00000000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593870 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libblkid.so.' matches '7f05f9363000-7f05f9382000 r-xp 00007000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593894 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libblkid.so.' matches '7f05f9382000-7f05f938b000 r--p 00026000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593917 lvconvert[15860] mm/memlock.c:266  mlock area unreadable 7f05f938b000-7f05f938c000 ---p 0002f000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0 : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593941 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libblkid.so.' matches '7f05f938c000-7f05f9390000 r--p 0002f000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593965 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libblkid.so.' matches '7f05f9390000-7f05f9391000 rw-p 00033000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.593990 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libsystemd.so.' matches '7f05f9391000-7f05f93a3000 r--p 00000000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594015 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libsystemd.so.' matches '7f05f93a3000-7f05f9424000 r-xp 00012000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594040 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libsystemd.so.' matches '7f05f9424000-7f05f944f000 r--p 00093000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594085 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libsystemd.so.' matches '7f05f944f000-7f05f9453000 r--p 000bd000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594111 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libsystemd.so.' matches '7f05f9453000-7f05f9454000 rw-p 000c1000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594135 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f9454000 - 7f05f9455000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.594188 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libreadline.so.' matches '7f05f9455000-7f05f946b000 r--p 00000000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594215 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libreadline.so.' matches '7f05f946b000-7f05f9499000 r-xp 00016000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594240 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libreadline.so.' matches '7f05f9499000-7f05f94a3000 r--p 00044000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594265 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libreadline.so.' matches '7f05f94a3000-7f05f94a6000 r--p 0004d000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594289 lvconvert[15860] mm/memlock.c:283  mlock default filter '/libreadline.so.' matches '7f05f94a6000-7f05f94ac000 rw-p 00050000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594313 lvconvert[15860] mm/memlock.c:311  mlock          4KiB 7f05f94ac000 - 7f05f94ad000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.594365 lvconvert[15860] mm/memlock.c:311  mlock         20KiB 7f05f94b4000 - 7f05f94b9000 rw-s 00000000 00:10 42259                      /[aio] (deleted)
>> [ 1:27.629] ## DEBUG0: 01:25:02.594407 lvconvert[15860] mm/memlock.c:311  mlock          8KiB 7f05f94b9000 - 7f05f94bb000 rw-p 00000000 00:00 0
>> [ 1:27.629] ## DEBUG0: 01:25:02.594460 lvconvert[15860] mm/memlock.c:283  mlock default filter '/ld-2.' matches '7f05f94bb000-7f05f94bc000 r--p 00000000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594485 lvconvert[15860] mm/memlock.c:283  mlock default filter '/ld-2.' matches '7f05f94bc000-7f05f94e1000 r-xp 00001000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594509 lvconvert[15860] mm/memlock.c:283  mlock default filter '/ld-2.' matches '7f05f94e1000-7f05f94eb000 r--p 00026000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594532 lvconvert[15860] mm/memlock.c:283  mlock default filter '/ld-2.' matches '7f05f94eb000-7f05f94ed000 r--p 0002f000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594556 lvconvert[15860] mm/memlock.c:283  mlock default filter '/ld-2.' matches '7f05f94ed000-7f05f94ef000 rw-p 00031000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594580 lvconvert[15860] mm/memlock.c:311  mlock        136KiB 7ffdb806e000 - 7ffdb8090000 rw-p 00000000 00:00 0                          [stack]
>> [ 1:27.629] ## DEBUG0: 01:25:02.594753 lvconvert[15860] mm/memlock.c:311  mlock         16KiB 7ffdb813c000 - 7ffdb8140000 r--p 00000000 00:00 0                          [vvar]
>> [ 1:27.629] ## DEBUG0: 01:25:02.594785 lvconvert[15860] mm/memlock.c:273  mlock ignore filter '[vdso]' matches '7ffdb8140000-7ffdb8142000 r-xp 00000000 00:00 0                          [vdso]': Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594809 lvconvert[15860] mm/memlock.c:266  mlock area unreadable ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall] : Skipping.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594832 lvconvert[15860] mm/memlock.c:397  Locked 28925952 bytes
>> [ 1:27.629] ## DEBUG0: 01:25:02.594862 lvconvert[15860] activate/dev_manager.c:3888  Creating SUSPEND tree for LVMTEST14057vg/LV1.
>> [ 1:27.629] ## DEBUG0: 01:25:02.594889 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.629] ## DEBUG0: 01:25:02.594935 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.594980 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:18) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595042 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595093 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:4) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595143 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595191 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:20) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595239 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:5) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595287 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:19) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595335 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595383 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:2) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595431 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595478 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595525 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:1) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595573 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595621 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595669 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:0) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595725 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595775 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.595801 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595834 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.595857 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595891 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf].
>> [ 1:27.629] ## DEBUG0: 01:25:02.595914 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.595947 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.595971 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596002 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596025 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596077 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596101 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596133 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596157 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596187 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596211 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596242 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596265 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596298 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596321 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596352 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596376 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596407 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596430 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596462 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596486 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596516 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596540 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596570 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596594 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596626 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596669 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596711 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596735 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596766 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596790 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596823 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596846 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596877 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596901 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596932 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z].
>> [ 1:27.629] ## DEBUG0: 01:25:02.596955 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.596988 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597011 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597042 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_5-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597065 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597096 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597120 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597152 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597176 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597206 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_5-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597248 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597280 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597304 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597336 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597360 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597390 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597414 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597444 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597468 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597500 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597524 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597554 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:02.597578 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597610 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:18) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:02.597642 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1 (250:18) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:02.597666 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:18) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.637981 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 1
>> [ 1:27.629] ## DEBUG0: 01:25:03.638535 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:17) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.638934 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rimage_4 (250:17) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:03.639006 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:17) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.640999 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 2
>> [ 1:27.629] ## DEBUG0: 01:25:03.641103 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:16) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.641204 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rmeta_4 (250:16) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:03.641272 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:16) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.643333 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 3
>> [ 1:27.629] ## DEBUG0: 01:25:03.643521 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:20) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.643626 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rimage_5 (250:20) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:03.643722 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:20) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.645568 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 4
>> [ 1:27.629] ## DEBUG0: 01:25:03.645673 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:19) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.645798 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rmeta_5 (250:19) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:03.645867 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:19) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.647493 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 5
>> [ 1:27.629] ## DEBUG0: 01:25:03.647572 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:13) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.647663 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rimage_2 (250:13) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:03.647751 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:13) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.649547 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 6
>> [ 1:27.629] ## DEBUG0: 01:25:03.649852 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:12) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.649947 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rmeta_2 (250:12) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:03.650013 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:12) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.651575 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 7
>> [ 1:27.629] ## DEBUG0: 01:25:03.651651 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:11) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.651865 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rimage_1 (250:11) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:03.651934 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:11) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.653796 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 8
>> [ 1:27.629] ## DEBUG0: 01:25:03.653900 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:10) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.653999 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rmeta_1 (250:10) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:03.654060 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:10) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.655560 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 9
>> [ 1:27.629] ## DEBUG0: 01:25:03.655631 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:9) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.655731 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rimage_0 (250:9) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:03.655792 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:9) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.657299 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 10
>> [ 1:27.629] ## DEBUG0: 01:25:03.657368 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info   (250:8) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.657448 lvconvert[15860] device_mapper/libdm-deptree.c:1383  Suspending LVMTEST14057vg-LV1_rmeta_0 (250:8) with device flush
>> [ 1:27.629] ## DEBUG0: 01:25:03.657507 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm suspend   (250:8) [ noopencount flush skiplockfs ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.659010 lvconvert[15860] device_mapper/libdm-common.c:279  Suspended device counter increased to 11
>> [ 1:27.629] ## DEBUG0: 01:25:03.659347 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:03.659421 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv1 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:03.659478 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 229376 size 5537 slot1 offset 0 size 0.
>> [ 1:27.629] ## DEBUG0: 01:25:03.659542 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:03.661253 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:03.661348 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv2 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:03.661408 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 147968 size 5537 slot1 offset 0 size 0.
>> [ 1:27.629] ## DEBUG0: 01:25:03.661471 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:03.662953 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:03.663048 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv3 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:03.663108 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 71680 size 5537 slot1 offset 0 size 0.
>> [ 1:27.629] ## DEBUG0: 01:25:03.663171 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:03.664564 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:03.664658 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv5 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:03.664746 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 28160 size 5537 slot1 offset 0 size 0.
>> [ 1:27.629] ## DEBUG0: 01:25:03.664811 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:03.666232 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:03.666327 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv6 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:03.666388 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 229376 size 5537 slot1 offset 0 size 0.
>> [ 1:27.629] ## DEBUG0: 01:25:03.666451 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:03.667944 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:03.668039 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv7 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:03.668099 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 229376 size 5537 slot1 offset 0 size 0.
>> [ 1:27.629] ## DEBUG0: 01:25:03.668163 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:03.670060 lvconvert[15860] format_text/format-text.c:196  Reading mda header sector from /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 at 4096
>> [ 1:27.629] ## DEBUG0: 01:25:03.670346 lvconvert[15860] format_text/format-text.c:1107  VG LVMTEST14057vg metadata commit seq 51 on /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057pv8 mda header at 4096 (used).
>> [ 1:27.629] ## DEBUG0: 01:25:03.670410 lvconvert[15860] format_text/format-text.c:1115  VG LVMTEST14057vg metadata commit slot0 offset 229376 size 5537 slot1 offset 0 size 0.
>> [ 1:27.629] ## DEBUG0: 01:25:03.670536 lvconvert[15860] device/bcache.c:236  Limit write at 0 len 131072 to len 4608
>> [ 1:27.629] ## DEBUG0: 01:25:03.671794 lvconvert[15860] metadata/vg.c:80  Freeing VG LVMTEST14057vg at 0x562463b911b0.
>> [ 1:27.629] ## DEBUG0: 01:25:03.671859 lvconvert[15860] metadata/lv_manip.c:8008  Updating logical volume LVMTEST14057vg/LV1 in kernel.
>> [ 1:27.629] ## DEBUG0: 01:25:03.671916 lvconvert[15860] activate/activate.c:2311  Resuming LV LVMTEST14057vg/LV1 if active.
>> [ 1:27.629] ## DEBUG0: 01:25:03.671977 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.629] ## DEBUG0: 01:25:03.672041 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.672146 lvconvert[15860] activate/dev_manager.c:3888  Creating ACTIVATE tree for LVMTEST14057vg/LV1.
>> [ 1:27.629] ## DEBUG0: 01:25:03.672209 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.629] ## DEBUG0: 01:25:03.672268 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.672357 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:18) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.672495 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.672617 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:4) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.672759 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.672878 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:20) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.672996 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:5) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.673114 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:19) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.673232 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.673350 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:2) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.673469 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.673586 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.673720 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:1) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.673841 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.673960 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.674077 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:0) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.674196 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.674316 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real].
>> [ 1:27.629] ## DEBUG0: 01:25:03.674379 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.674458 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:03.674516 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.674652 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf].
>> [ 1:27.629] ## DEBUG0: 01:25:03.674721 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.674790 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real].
>> [ 1:27.629] ## DEBUG0: 01:25:03.674838 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.674900 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:03.674948 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.675010 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG].
>> [ 1:27.629] ## DEBUG0: 01:25:03.675058 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.675123 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real].
>> [ 1:27.629] ## DEBUG0: 01:25:03.675170 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.675232 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:03.675279 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.675341 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW].
>> [ 1:27.629] ## DEBUG0: 01:25:03.675388 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.675454 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real].
>> [ 1:27.629] ## DEBUG0: 01:25:03.675502 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.675565 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:03.675612 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.675675 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR].
>> [ 1:27.629] ## DEBUG0: 01:25:03.675733 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.675799 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real].
>> [ 1:27.629] ## DEBUG0: 01:25:03.675886 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.675951 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:03.675999 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.676061 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS].
>> [ 1:27.629] ## DEBUG0: 01:25:03.676109 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.676175 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real].
>> [ 1:27.629] ## DEBUG0: 01:25:03.676223 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.676285 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:03.676332 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.676395 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT].
>> [ 1:27.629] ## DEBUG0: 01:25:03.676442 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.676508 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real].
>> [ 1:27.629] ## DEBUG0: 01:25:03.676557 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.676619 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow].
>> [ 1:27.629] ## DEBUG0: 01:25:03.676666 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.676743 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z].
>> [ 1:27.629] ## DEBUG0: 01:25:03.676791 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.629] ## DEBUG0: 01:25:03.676857 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real].
>> [ 1:27.655] ## DEBUG0: 01:25:03.676905 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.676967 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:03.677014 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.677115 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g].
>> [ 1:27.655] ## DEBUG0: 01:25:03.677164 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.677231 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real].
>> [ 1:27.655] ## DEBUG0: 01:25:03.677279 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.677341 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:03.677388 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.677451 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn].
>> [ 1:27.655] ## DEBUG0: 01:25:03.677498 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.677564 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real].
>> [ 1:27.655] ## DEBUG0: 01:25:03.677611 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.677673 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:03.677732 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.677795 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s].
>> [ 1:27.655] ## DEBUG0: 01:25:03.677842 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.677908 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real].
>> [ 1:27.655] ## DEBUG0: 01:25:03.677956 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.678017 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:03.678064 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.678128 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.678176 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.678223 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.678270 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports raid6 segment type for LVMTEST14057vg/LV1
>> [ 1:27.655] ## DEBUG0: 01:25:03.678532 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_0 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.678741 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.678790 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.678837 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_0
>> [ 1:27.655] ## DEBUG0: 01:25:03.679052 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_0 is 256
>> [ 1:27.655] ## DEBUG0: 01:25:03.679103 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_0 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.679151 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.679196 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.679243 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_0
>> [ 1:27.655] ## DEBUG0: 01:25:03.679432 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_0 is 256
>> [ 1:27.655] ## DEBUG0: 01:25:03.679482 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_1 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.679529 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.679575 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.679621 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_1
>> [ 1:27.655] ## DEBUG0: 01:25:03.679823 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_1 is 256
>> [ 1:27.655] ## DEBUG0: 01:25:03.679873 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_1 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.679921 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.679967 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.680013 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_1
>> [ 1:27.655] ## DEBUG0: 01:25:03.680200 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_1 is 256
>> [ 1:27.655] ## DEBUG0: 01:25:03.680250 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_2 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.680297 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.680343 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.680389 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_2
>> [ 1:27.655] ## DEBUG0: 01:25:03.680575 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_2 is 256
>> [ 1:27.655] ## DEBUG0: 01:25:03.680625 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_2 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.680672 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.680729 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.680776 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_2
>> [ 1:27.655] ## DEBUG0: 01:25:03.681006 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_2 is 256
>> [ 1:27.655] ## DEBUG0: 01:25:03.681056 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_3 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.681104 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.681149 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.681196 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_3
>> [ 1:27.655] ## DEBUG0: 01:25:03.681384 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_3 is 256
>> [ 1:27.655] ## DEBUG0: 01:25:03.681433 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_3 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.681480 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.681526 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.681572 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_3
>> [ 1:27.655] ## DEBUG0: 01:25:03.681770 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_3 is 256
>> [ 1:27.655] ## DEBUG0: 01:25:03.681820 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rimage_4 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.681868 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.681913 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.681960 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rimage_4
>> [ 1:27.655] ## DEBUG0: 01:25:03.682146 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rimage_4 is 256
>> [ 1:27.655] ## DEBUG0: 01:25:03.682196 lvconvert[15860] activate/dev_manager.c:3395  Adding new LV LVMTEST14057vg/LV1_rmeta_4 to dtree
>> [ 1:27.655] ## DEBUG0: 01:25:03.682243 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.682289 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.682335 lvconvert[15860] activate/dev_manager.c:3296  Checking kernel supports striped segment type for LVMTEST14057vg/LV1_rmeta_4
>> [ 1:27.655] ## DEBUG0: 01:25:03.682523 lvconvert[15860] metadata/metadata.c:2113  Calculated readahead of LV LV1_rmeta_4 is 256
>> [ 1:27.655] ## DEBUG0: 01:25:03.682578 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.682627 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.682675 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.682734 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.682782 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.682829 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.682877 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.682924 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.683011 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.683060 lvconvert[15860] device_mapper/libdm-deptree.c:605  Matched uuid LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn in deptree.
>> [ 1:27.655] ## DEBUG0: 01:25:03.683111 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_4 (250:17).
>> [ 1:27.655] ## DEBUG0: 01:25:03.683161 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:17): 0 44032 linear 250:4 3072
>> [ 1:27.655] ## DEBUG0: 01:25:03.683214 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.683319 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_4 (250:17) identical table reload.
>> [ 1:27.655] ## DEBUG0: 01:25:03.683371 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_4 (250:16).
>> [ 1:27.655] ## DEBUG0: 01:25:03.683419 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:16): 0 1024 linear 250:4 2048
>> [ 1:27.655] ## DEBUG0: 01:25:03.683468 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.683561 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_4 (250:16) identical table reload.
>> [ 1:27.655] ## DEBUG0: 01:25:03.683612 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_5 (250:20).
>> [ 1:27.655] ## DEBUG0: 01:25:03.683660 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:20): 0 44032 linear 250:5 3072
>> [ 1:27.655] ## DEBUG0: 01:25:03.683724 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:20) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.683819 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_5 (250:20) identical table reload.
>> [ 1:27.655] ## DEBUG0: 01:25:03.683869 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_5 (250:19).
>> [ 1:27.655] ## DEBUG0: 01:25:03.683917 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:19): 0 1024 linear 250:5 2048
>> [ 1:27.655] ## DEBUG0: 01:25:03.683966 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:19) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.684059 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_5 (250:19) identical table reload.
>> [ 1:27.655] ## DEBUG0: 01:25:03.684109 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_2 (250:13).
>> [ 1:27.655] ## DEBUG0: 01:25:03.684157 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:13): 0 44032 linear 250:2 3072
>> [ 1:27.655] ## DEBUG0: 01:25:03.684206 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.684275 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_2 (250:13) identical table reload.
>> [ 1:27.655] ## DEBUG0: 01:25:03.684313 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_2 (250:12).
>> [ 1:27.655] ## DEBUG0: 01:25:03.684348 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:12): 0 1024 linear 250:2 2048
>> [ 1:27.655] ## DEBUG0: 01:25:03.684384 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.684452 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_2 (250:12) identical table reload.
>> [ 1:27.655] ## DEBUG0: 01:25:03.684489 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_1 (250:11).
>> [ 1:27.655] ## DEBUG0: 01:25:03.684525 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:11): 0 44032 linear 250:1 3072
>> [ 1:27.655] ## DEBUG0: 01:25:03.684561 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.684628 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_1 (250:11) identical table reload.
>> [ 1:27.655] ## DEBUG0: 01:25:03.684665 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_1 (250:10).
>> [ 1:27.655] ## DEBUG0: 01:25:03.684711 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:10): 0 1024 linear 250:1 2048
>> [ 1:27.655] ## DEBUG0: 01:25:03.684776 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.684847 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_1 (250:10) identical table reload.
>> [ 1:27.655] ## DEBUG0: 01:25:03.684884 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rimage_0 (250:9).
>> [ 1:27.655] ## DEBUG0: 01:25:03.684920 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:9): 0 44032 linear 250:0 3072
>> [ 1:27.655] ## DEBUG0: 01:25:03.684955 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.685023 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rimage_0 (250:9) identical table reload.
>> [ 1:27.655] ## DEBUG0: 01:25:03.685061 lvconvert[15860] device_mapper/libdm-deptree.c:3231  Loading table for LVMTEST14057vg-LV1_rmeta_0 (250:8).
>> [ 1:27.655] ## DEBUG0: 01:25:03.685096 lvconvert[15860] device_mapper/libdm-deptree.c:3173  Adding target to (250:8): 0 1024 linear 250:0 2048
>> [ 1:27.655] ## DEBUG0: 01:25:03.685131 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm table   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.685200 lvconvert[15860] device_mapper/libdm-deptree.c:3266  Suppressed LVMTEST14057vg-LV1_rmeta_0 (250:8) identical table reload.
>> [ 1:27.655] ## DEBUG0: 01:25:03.685240 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_4 (250:17).
>> [ 1:27.655] ## DEBUG0: 01:25:03.685277 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:17) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.685740 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_4: Stacking NODE_ADD (250,17) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.685788 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_4: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.685831 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 10
>> [ 1:27.655] ## DEBUG0: 01:25:03.685867 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_4 (250:16).
>> [ 1:27.655] ## DEBUG0: 01:25:03.685900 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:16) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.686245 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_4: Stacking NODE_ADD (250,16) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.686284 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_4: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.686318 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 9
>> [ 1:27.655] ## DEBUG0: 01:25:03.686354 lvconvert[15860] device_mapper/libdm-deptree.c:1297  Renaming LVMTEST14057vg-LV1_rimage_5 (250:20) to LVMTEST14057vg-LV1_rimage_3
>> [ 1:27.655] ## DEBUG0: 01:25:03.686391 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm rename LVMTEST14057vg-LV1_rimage_5  LVMTEST14057vg-LV1_rimage_3 [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.687059 lvconvert[15860] device_mapper/libdm-common.c:1493  LVMTEST14057vg-LV1_rimage_5: Stacking NODE_RENAME to LVMTEST14057vg-LV1_rimage_3 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.687098 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_3 (250:20).
>> [ 1:27.655] ## DEBUG0: 01:25:03.687134 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:20) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.687455 lvconvert[15860] device_mapper/libdm-common.c:1490  LVMTEST14057vg-LV1_rimage_3: Unstacking NODE_DEL [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.687493 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_3: Stacking NODE_ADD (250,20) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.687527 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_3: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.687561 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 8
>> [ 1:27.655] ## DEBUG0: 01:25:03.687597 lvconvert[15860] device_mapper/libdm-deptree.c:1297  Renaming LVMTEST14057vg-LV1_rmeta_5 (250:19) to LVMTEST14057vg-LV1_rmeta_3
>> [ 1:27.655] ## DEBUG0: 01:25:03.687632 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm rename LVMTEST14057vg-LV1_rmeta_5  LVMTEST14057vg-LV1_rmeta_3 [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.688256 lvconvert[15860] device_mapper/libdm-common.c:1493  LVMTEST14057vg-LV1_rmeta_5: Stacking NODE_RENAME to LVMTEST14057vg-LV1_rmeta_3 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.688296 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_3 (250:19).
>> [ 1:27.655] ## DEBUG0: 01:25:03.688500 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:19) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.688986 lvconvert[15860] device_mapper/libdm-common.c:1490  LVMTEST14057vg-LV1_rmeta_3: Unstacking NODE_DEL [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.689026 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_3: Stacking NODE_ADD (250,19) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.689062 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_3: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.689097 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 7
>> [ 1:27.655] ## DEBUG0: 01:25:03.689132 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_2 (250:13).
>> [ 1:27.655] ## DEBUG0: 01:25:03.689168 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:13) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.689526 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_2: Stacking NODE_ADD (250,13) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.689566 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_2: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.689600 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 6
>> [ 1:27.655] ## DEBUG0: 01:25:03.689635 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_2 (250:12).
>> [ 1:27.655] ## DEBUG0: 01:25:03.689671 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:12) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.690040 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_2: Stacking NODE_ADD (250,12) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.690080 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_2: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.690115 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 5
>> [ 1:27.655] ## DEBUG0: 01:25:03.690149 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_1 (250:11).
>> [ 1:27.655] ## DEBUG0: 01:25:03.690185 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:11) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.690538 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_1: Stacking NODE_ADD (250,11) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.690573 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_1: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.690600 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 4
>> [ 1:27.655] ## DEBUG0: 01:25:03.690627 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_1 (250:10).
>> [ 1:27.655] ## DEBUG0: 01:25:03.690664 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:10) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.691044 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_1: Stacking NODE_ADD (250,10) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.691088 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_1: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.691124 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 3
>> [ 1:27.655] ## DEBUG0: 01:25:03.691159 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rimage_0 (250:9).
>> [ 1:27.655] ## DEBUG0: 01:25:03.691195 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:9) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.691553 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_0: Stacking NODE_ADD (250,9) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.691594 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_0: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.691661 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 2
>> [ 1:27.655] ## DEBUG0: 01:25:03.691712 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1_rmeta_0 (250:8).
>> [ 1:27.655] ## DEBUG0: 01:25:03.691749 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:8) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.692116 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_0: Stacking NODE_ADD (250,8) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:03.692156 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_0: Stacking NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:03.692191 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 1
>> [ 1:27.655] ## DEBUG0: 01:25:03.692226 lvconvert[15860] device_mapper/libdm-deptree.c:1335  Resuming LVMTEST14057vg-LV1 (250:18).
>> [ 1:27.655] ## DEBUG0: 01:25:03.692261 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm resume   (250:18) [ noopencount flush ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.090578 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1: Stacking NODE_ADD (250,18) 0:0 0600 [verify_udev]
>> [ 1:27.655] ## DEBUG0: 01:25:04.090718 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1: Stacking NODE_READ_AHEAD 1280 (flags=1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.090745 lvconvert[15860] device_mapper/libdm-common.c:290  Suspended device counter reduced to 0
>> [ 1:27.655] ## DEBUG0: 01:25:04.090786 lvconvert[15860] activate/dev_manager.c:3888  Creating CLEAN tree for LVMTEST14057vg/LV1.
>> [ 1:27.655] ## DEBUG0: 01:25:04.090817 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV].
>> [ 1:27.655] ## DEBUG0: 01:25:04.090845 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.090891 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:18) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.090952 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:17) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091004 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:4) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091053 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:16) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091102 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:20) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091151 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:5) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091199 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:19) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091248 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:13) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091296 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:2) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091344 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:12) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091392 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:11) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091441 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:1) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091489 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:10) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091537 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:9) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091586 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:0) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091634 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm deps   (250:8) [ opencount flush ]   [16384] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091696 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.091723 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091801 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.091823 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091859 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf].
>> [ 1:27.655] ## DEBUG0: 01:25:04.091883 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091916 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.091940 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.091971 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.091995 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092027 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092051 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092083 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092107 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092137 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_0-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092161 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092192 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092215 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092248 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092272 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092302 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092326 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092357 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092401 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092434 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092458 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092489 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_1-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092512 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092544 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092567 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092600 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092624 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092654 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092678 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092726 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092750 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092783 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092807 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092838 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_2-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092862 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092893 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092916 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.092949 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.092991 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093023 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_3-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.093047 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093077 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g].
>> [ 1:27.655] ## DEBUG0: 01:25:04.093101 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093134 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.093157 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093188 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_3-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.093211 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093242 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn].
>> [ 1:27.655] ## DEBUG0: 01:25:04.093266 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093298 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.093322 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093352 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rimage_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.093376 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093407 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4 [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s].
>> [ 1:27.655] ## DEBUG0: 01:25:04.093431 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093463 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-real [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real].
>> [ 1:27.655] ## DEBUG0: 01:25:04.093488 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-real [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093518 lvconvert[15860] activate/dev_manager.c:859  Getting device info for LVMTEST14057vg-LV1_rmeta_4-cow [LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow].
>> [ 1:27.655] ## DEBUG0: 01:25:04.093542 lvconvert[15860] device_mapper/ioctl/libdm-iface.c:2107  dm info  LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s-cow [ noopencount flush enablechecks ]   [2048] (*1)
>> [ 1:27.655] ## DEBUG0: 01:25:04.093597 lvconvert[15860] mm/memlock.c:651  Leaving critical section (resumed).
>> [ 1:27.655] ## DEBUG0: 01:25:04.093622 lvconvert[15860] mm/memlock.c:653  Leaving section (unlocking on resume).
>> [ 1:27.655] ## DEBUG0: 01:25:04.098453 lvconvert[15860] lvconvert.c:3838  Faulty devices in LVMTEST14057vg/LV1 successfully replaced.
>> [ 1:27.655] ## DEBUG0: 01:25:04.098590 lvconvert[15860] mm/memlock.c:609  Unlock: Memlock counters: prioritized:1 locked:1 critical:0 daemon:0 suspended:0
>> [ 1:27.655] ## DEBUG0: 01:25:04.098615 lvconvert[15860] mm/memlock.c:568  Unlocking memory
>> [ 1:27.655] ## DEBUG0: 01:25:04.099333 lvconvert[15860] mm/memlock.c:311  munlock        216KiB 56246274e000 - 562462784000 r--p 00000000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.655] ## DEBUG0: 01:25:04.099492 lvconvert[15860] mm/memlock.c:311  munlock       1356KiB 562462784000 - 5624628d7000 r-xp 00036000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.655] ## DEBUG0: 01:25:04.099885 lvconvert[15860] mm/memlock.c:311  munlock        768KiB 5624628d7000 - 562462997000 r--p 00189000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.655] ## DEBUG0: 01:25:04.100170 lvconvert[15860] mm/memlock.c:311  munlock         44KiB 562462997000 - 5624629a2000 r--p 00248000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.655] ## DEBUG0: 01:25:04.100236 lvconvert[15860] mm/memlock.c:311  munlock        248KiB 5624629a2000 - 5624629e0000 rw-p 00253000 103:00 8408912                   /mnt/test/lvm2/tools/lvm
>> [ 1:27.655] ## DEBUG0: 01:25:04.100402 lvconvert[15860] mm/memlock.c:311  munlock       2716KiB 5624629e0000 - 562462c87000 rw-p 00000000 00:00 0
>> [ 1:27.655] ## DEBUG0: 01:25:04.100798 lvconvert[15860] mm/memlock.c:311  munlock      19212KiB 5624632e7000 - 5624645aa000 rw-p 00000000 00:00 0                          [heap]
>> [ 1:27.655] ## DEBUG0: 01:25:04.104313 lvconvert[15860] mm/memlock.c:311  munlock         16KiB 7f05f8c48000 - 7f05f8c4c000 rw-p 00000000 00:00 0
>> [ 1:27.655] ## DEBUG0: 01:25:04.104365 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgpg-error.so.' matches '7f05f8c4c000-7f05f8c50000 r--p 00000000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.655] ## DEBUG0: 01:25:04.104392 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgpg-error.so.' matches '7f05f8c50000-7f05f8c66000 r-xp 00004000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.655] ## DEBUG0: 01:25:04.104417 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgpg-error.so.' matches '7f05f8c66000-7f05f8c6f000 r--p 0001a000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.655] ## DEBUG0: 01:25:04.104440 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8c6f000-7f05f8c70000 ---p 00023000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0 : Skipping.
>> [ 1:27.655] ## DEBUG0: 01:25:04.104465 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgpg-error.so.' matches '7f05f8c70000-7f05f8c71000 r--p 00023000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.655] ## DEBUG0: 01:25:04.104490 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgpg-error.so.' matches '7f05f8c71000-7f05f8c72000 rw-p 00024000 fd:00 16808138                   /usr/lib64/libgpg-error.so.0.32.0': Skipping.
>> [ 1:27.655] ## DEBUG0: 01:25:04.104514 lvconvert[15860] mm/memlock.c:311  munlock          8KiB 7f05f8c72000 - 7f05f8c74000 rw-p 00000000 00:00 0
>> [ 1:27.655] ## DEBUG0: 01:25:04.104559 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libdl-' matches '7f05f8c74000-7f05f8c76000 r--p 00000000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.655] ## DEBUG0: 01:25:04.104585 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libdl-' matches '7f05f8c76000-7f05f8c78000 r-xp 00002000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.655] ## DEBUG0: 01:25:04.104609 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libdl-' matches '7f05f8c78000-7f05f8c79000 r--p 00004000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.655] ## DEBUG0: 01:25:04.104633 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libdl-' matches '7f05f8c79000-7f05f8c7a000 r--p 00004000 fd:00 16807956                   /usr/lib64/libdl-2.33.so': Skipping.
>> [ 1:27.655] ## DEBUG0: 01:25:04.104657 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8c7a000 - 7f05f8c7b000 rw-p 00000000 00:00 0
>> [ 1:27.655] ## DEBUG0: 01:25:04.104748 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libpcre2-' matches '7f05f8c7b000-7f05f8c7d000 r--p 00000000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.104771 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libpcre2-' matches '7f05f8c7d000-7f05f8ce8000 r-xp 00002000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.104796 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libpcre2-' matches '7f05f8ce8000-7f05f8d0f000 r--p 0006d000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.104821 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8d0f000-7f05f8d10000 ---p 00094000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1 : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.104845 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libpcre2-' matches '7f05f8d10000-7f05f8d11000 r--p 00094000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.104868 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libpcre2-' matches '7f05f8d11000-7f05f8d12000 rw-p 00095000 fd:00 16808341                   /usr/lib64/libpcre2-8.so.0.10.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.104894 lvconvert[15860] mm/memlock.c:311  munlock         28KiB 7f05f8d12000 - 7f05f8d19000 r--p 00000000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.104946 lvconvert[15860] mm/memlock.c:311  munlock         60KiB 7f05f8d19000 - 7f05f8d28000 r-xp 00007000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.105007 lvconvert[15860] mm/memlock.c:311  munlock         16KiB 7f05f8d28000 - 7f05f8d2c000 r--p 00016000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.105044 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8d2c000-7f05f8d2d000 ---p 0001a000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105069 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8d2d000 - 7f05f8d2e000 r--p 0001a000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.105114 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8d2e000 - 7f05f8d2f000 rw-p 0001b000 fd:00 16807968                   /usr/lib64/libpthread-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.105157 lvconvert[15860] mm/memlock.c:311  munlock         16KiB 7f05f8d2f000 - 7f05f8d33000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.105208 lvconvert[15860] mm/memlock.c:311  munlock         12KiB 7f05f8d33000 - 7f05f8d36000 r--p 00000000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.665] ## DEBUG0: 01:25:04.105251 lvconvert[15860] mm/memlock.c:311  munlock         72KiB 7f05f8d36000 - 7f05f8d48000 r-xp 00003000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.665] ## DEBUG0: 01:25:04.105318 lvconvert[15860] mm/memlock.c:311  munlock         12KiB 7f05f8d48000 - 7f05f8d4b000 r--p 00015000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.665] ## DEBUG0: 01:25:04.105359 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8d4b000-7f05f8d4c000 ---p 00018000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1 : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105385 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8d4c000 - 7f05f8d4d000 r--p 00018000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.665] ## DEBUG0: 01:25:04.105426 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8d4d000 - 7f05f8d4e000 rw-p 00019000 fd:00 16797839                   /usr/lib64/libgcc_s-11-20210728.so.1
>> [ 1:27.665] ## DEBUG0: 01:25:04.105466 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgcrypt.so.' matches '7f05f8d4e000-7f05f8d5c000 r--p 00000000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105491 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgcrypt.so.' matches '7f05f8d5c000-7f05f8e42000 r-xp 0000e000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105535 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgcrypt.so.' matches '7f05f8e42000-7f05f8e7f000 r--p 000f4000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105560 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8e7f000-7f05f8e80000 ---p 00131000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3 : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105584 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgcrypt.so.' matches '7f05f8e80000-7f05f8e83000 r--p 00131000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105609 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libgcrypt.so.' matches '7f05f8e83000-7f05f8e89000 rw-p 00134000 fd:00 16808029                   /usr/lib64/libgcrypt.so.20.3.3': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105633 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8e89000 - 7f05f8e8a000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.105673 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libcap.so.' matches '7f05f8e8a000-7f05f8e8c000 r--p 00000000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105706 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libcap.so.' matches '7f05f8e8c000-7f05f8e90000 r-xp 00002000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105726 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libcap.so.' matches '7f05f8e90000-7f05f8e92000 r--p 00006000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105749 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libcap.so.' matches '7f05f8e92000-7f05f8e93000 r--p 00007000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105773 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libcap.so.' matches '7f05f8e93000-7f05f8e94000 rw-p 00008000 fd:00 16808244                   /usr/lib64/libcap.so.2.48': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105797 lvconvert[15860] mm/memlock.c:311  munlock          8KiB 7f05f8e94000 - 7f05f8e96000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.105842 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblz4.so.' matches '7f05f8e96000-7f05f8e99000 r--p 00000000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105868 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblz4.so.' matches '7f05f8e99000-7f05f8eb5000 r-xp 00003000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105887 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblz4.so.' matches '7f05f8eb5000-7f05f8eb8000 r--p 0001f000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105911 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblz4.so.' matches '7f05f8eb8000-7f05f8eb9000 r--p 00021000 fd:00 16808382                   /usr/lib64/liblz4.so.1.9.3': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.105935 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8eb9000 - 7f05f8eba000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.105980 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libzstd.so.' matches '7f05f8eba000-7f05f8ebf000 r--p 00000000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106007 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libzstd.so.' matches '7f05f8ebf000-7f05f8f9f000 r-xp 00005000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106033 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libzstd.so.' matches '7f05f8f9f000-7f05f8fad000 r--p 000e5000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106052 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8fad000-7f05f8fae000 ---p 000f3000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0 : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106076 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libzstd.so.' matches '7f05f8fae000-7f05f8faf000 r--p 000f3000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106121 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libzstd.so.' matches '7f05f8faf000-7f05f8fb0000 rw-p 000f4000 fd:00 16808230                   /usr/lib64/libzstd.so.1.5.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106147 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblzma.so.' matches '7f05f8fb0000-7f05f8fb3000 r--p 00000000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106171 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblzma.so.' matches '7f05f8fb3000-7f05f8fce000 r-xp 00003000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106196 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblzma.so.' matches '7f05f8fce000-7f05f8fd9000 r--p 0001e000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106219 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f8fd9000-7f05f8fda000 ---p 00029000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5 : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106244 lvconvert[15860] mm/memlock.c:283  munlock default filter '/liblzma.so.' matches '7f05f8fda000-7f05f8fdb000 r--p 00029000 fd:00 16808226                   /usr/lib64/liblzma.so.5.2.5': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106268 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8fdb000 - 7f05f8fdc000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.106316 lvconvert[15860] mm/memlock.c:311  munlock         12KiB 7f05f8fdc000 - 7f05f8fdf000 r--p 00000000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.106359 lvconvert[15860] mm/memlock.c:311  munlock         16KiB 7f05f8fdf000 - 7f05f8fe3000 r-xp 00003000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.106411 lvconvert[15860] mm/memlock.c:311  munlock          8KiB 7f05f8fe3000 - 7f05f8fe5000 r--p 00007000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.106457 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8fe5000 - 7f05f8fe6000 r--p 00008000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.106501 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f8fe6000 - 7f05f8fe7000 rw-p 00009000 fd:00 16807972                   /usr/lib64/librt-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.106545 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libtinfo.so.' matches '7f05f8fe7000-7f05f8ff5000 r--p 00000000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106571 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libtinfo.so.' matches '7f05f8ff5000-7f05f9003000 r-xp 0000e000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106597 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libtinfo.so.' matches '7f05f9003000-7f05f9011000 r--p 0001c000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106622 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libtinfo.so.' matches '7f05f9011000-7f05f9015000 r--p 00029000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106647 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libtinfo.so.' matches '7f05f9015000-7f05f9016000 rw-p 0002d000 fd:00 16807937                   /usr/lib64/libtinfo.so.6.2': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.106673 lvconvert[15860] mm/memlock.c:311  munlock        152KiB 7f05f9016000 - 7f05f903c000 r--p 00000000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.106764 lvconvert[15860] mm/memlock.c:311  munlock       1332KiB 7f05f903c000 - 7f05f9189000 r-xp 00026000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.107159 lvconvert[15860] mm/memlock.c:311  munlock        304KiB 7f05f9189000 - 7f05f91d5000 r--p 00173000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.107269 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f91d5000-7f05f91d6000 ---p 001bf000 fd:00 16807954                   /usr/lib64/libc-2.33.so : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.107295 lvconvert[15860] mm/memlock.c:311  munlock         12KiB 7f05f91d6000 - 7f05f91d9000 r--p 001bf000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.107365 lvconvert[15860] mm/memlock.c:311  munlock         12KiB 7f05f91d9000 - 7f05f91dc000 rw-p 001c2000 fd:00 16807954                   /usr/lib64/libc-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.107413 lvconvert[15860] mm/memlock.c:311  munlock         44KiB 7f05f91dc000 - 7f05f91e7000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.107477 lvconvert[15860] mm/memlock.c:311  munlock         60KiB 7f05f91e7000 - 7f05f91f6000 r--p 00000000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.107543 lvconvert[15860] mm/memlock.c:311  munlock        616KiB 7f05f91f6000 - 7f05f9290000 r-xp 0000f000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.107844 lvconvert[15860] mm/memlock.c:311  munlock        608KiB 7f05f9290000 - 7f05f9328000 r--p 000a9000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.108044 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f9328000-7f05f9329000 ---p 00141000 fd:00 16807958                   /usr/lib64/libm-2.33.so : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.108067 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f9329000 - 7f05f932a000 r--p 00141000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.108110 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f932a000 - 7f05f932b000 rw-p 00142000 fd:00 16807958                   /usr/lib64/libm-2.33.so
>> [ 1:27.665] ## DEBUG0: 01:25:04.108154 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libselinux.so.' matches '7f05f932b000-7f05f9331000 r--p 00000000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.108178 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libselinux.so.' matches '7f05f9331000-7f05f934b000 r-xp 00006000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.108200 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libselinux.so.' matches '7f05f934b000-7f05f9352000 r--p 00020000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.108223 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f9352000-7f05f9353000 ---p 00027000 fd:00 16808421                   /usr/lib64/libselinux.so.1 : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.108246 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libselinux.so.' matches '7f05f9353000-7f05f9354000 r--p 00027000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.108269 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libselinux.so.' matches '7f05f9354000-7f05f9355000 rw-p 00028000 fd:00 16808421                   /usr/lib64/libselinux.so.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.108292 lvconvert[15860] mm/memlock.c:311  munlock          8KiB 7f05f9355000 - 7f05f9357000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.109464 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f9357000 - 7f05f9358000 r--p 00000000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.665] ## DEBUG0: 01:25:04.109573 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f9358000 - 7f05f9359000 r-xp 00001000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.665] ## DEBUG0: 01:25:04.109614 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f9359000 - 7f05f935a000 r--p 00002000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.665] ## DEBUG0: 01:25:04.109657 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f935a000 - 7f05f935b000 r--p 00002000 fd:00 16973809                   /usr/lib64/libaio.so.1.0.1
>> [ 1:27.665] ## DEBUG0: 01:25:04.109713 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f935b000 - 7f05f935c000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.109757 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libblkid.so.' matches '7f05f935c000-7f05f9363000 r--p 00000000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.109782 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libblkid.so.' matches '7f05f9363000-7f05f9382000 r-xp 00007000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.109807 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libblkid.so.' matches '7f05f9382000-7f05f938b000 r--p 00026000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.109853 lvconvert[15860] mm/memlock.c:266  munlock area unreadable 7f05f938b000-7f05f938c000 ---p 0002f000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0 : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.109878 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libblkid.so.' matches '7f05f938c000-7f05f9390000 r--p 0002f000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.109902 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libblkid.so.' matches '7f05f9390000-7f05f9391000 rw-p 00033000 fd:00 16812440                   /usr/lib64/libblkid.so.1.1.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.109928 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libsystemd.so.' matches '7f05f9391000-7f05f93a3000 r--p 00000000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.109952 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libsystemd.so.' matches '7f05f93a3000-7f05f9424000 r-xp 00012000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.109978 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libsystemd.so.' matches '7f05f9424000-7f05f944f000 r--p 00093000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110003 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libsystemd.so.' matches '7f05f944f000-7f05f9453000 r--p 000bd000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110029 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libsystemd.so.' matches '7f05f9453000-7f05f9454000 rw-p 000c1000 fd:00 16812474                   /usr/lib64/libsystemd.so.0.31.0': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110053 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f9454000 - 7f05f9455000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.110100 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libreadline.so.' matches '7f05f9455000-7f05f946b000 r--p 00000000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110127 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libreadline.so.' matches '7f05f946b000-7f05f9499000 r-xp 00016000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110152 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libreadline.so.' matches '7f05f9499000-7f05f94a3000 r--p 00044000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110177 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libreadline.so.' matches '7f05f94a3000-7f05f94a6000 r--p 0004d000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110202 lvconvert[15860] mm/memlock.c:283  munlock default filter '/libreadline.so.' matches '7f05f94a6000-7f05f94ac000 rw-p 00050000 fd:00 16808018                   /usr/lib64/libreadline.so.8.1': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110227 lvconvert[15860] mm/memlock.c:311  munlock          4KiB 7f05f94ac000 - 7f05f94ad000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.110269 lvconvert[15860] mm/memlock.c:311  munlock         20KiB 7f05f94b4000 - 7f05f94b9000 rw-s 00000000 00:10 42259                      /[aio] (deleted)
>> [ 1:27.665] ## DEBUG0: 01:25:04.110297 lvconvert[15860] mm/memlock.c:311  munlock          8KiB 7f05f94b9000 - 7f05f94bb000 rw-p 00000000 00:00 0
>> [ 1:27.665] ## DEBUG0: 01:25:04.110341 lvconvert[15860] mm/memlock.c:283  munlock default filter '/ld-2.' matches '7f05f94bb000-7f05f94bc000 r--p 00000000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110367 lvconvert[15860] mm/memlock.c:283  munlock default filter '/ld-2.' matches '7f05f94bc000-7f05f94e1000 r-xp 00001000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110391 lvconvert[15860] mm/memlock.c:283  munlock default filter '/ld-2.' matches '7f05f94e1000-7f05f94eb000 r--p 00026000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110431 lvconvert[15860] mm/memlock.c:283  munlock default filter '/ld-2.' matches '7f05f94eb000-7f05f94ed000 r--p 0002f000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110455 lvconvert[15860] mm/memlock.c:283  munlock default filter '/ld-2.' matches '7f05f94ed000-7f05f94ef000 rw-p 00031000 fd:00 16807947                   /usr/lib64/ld-2.33.so': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110479 lvconvert[15860] mm/memlock.c:311  munlock        136KiB 7ffdb806e000 - 7ffdb8090000 rw-p 00000000 00:00 0                          [stack]
>> [ 1:27.665] ## DEBUG0: 01:25:04.110592 lvconvert[15860] mm/memlock.c:311  munlock         16KiB 7ffdb813c000 - 7ffdb8140000 r--p 00000000 00:00 0                          [vvar]
>> [ 1:27.665] ## DEBUG0: 01:25:04.110621 lvconvert[15860] mm/memlock.c:273  munlock ignore filter '[vdso]' matches '7ffdb8140000-7ffdb8142000 r-xp 00000000 00:00 0                          [vdso]': Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110645 lvconvert[15860] mm/memlock.c:266  munlock area unreadable ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall] : Skipping.
>> [ 1:27.665] ## DEBUG0: 01:25:04.110668 lvconvert[15860] mm/memlock.c:397  Unlocked 28925952 bytes
>> [ 1:27.665] ## DEBUG0: 01:25:04.110773 lvconvert[15860] mm/memlock.c:518  Restoring original task priority 0.
>> [ 1:27.665] ## DEBUG0: 01:25:04.117153 lvconvert[15860] activate/fs.c:493  Syncing device names
>> [ 1:27.665] ## DEBUG0: 01:25:04.117195 lvconvert[15860] device_mapper/libdm-common.c:1490  LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0: Processing NODE_DEL [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.117530 lvconvert[15860] device_mapper/libdm-common.c:1114  Removed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_3_extracted-missing_0_0
>> [ 1:27.665] ## DEBUG0: 01:25:04.117557 lvconvert[15860] device_mapper/libdm-common.c:1490  LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0: Processing NODE_DEL [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.117884 lvconvert[15860] device_mapper/libdm-common.c:1114  Removed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_3_extracted-missing_0_0
>> [ 1:27.665] ## DEBUG0: 01:25:04.117911 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_4: Processing NODE_ADD (250,17) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.117973 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_4: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.133257 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rimage_4 (250:17): read ahead is 256
>> [ 1:27.665] ## DEBUG0: 01:25:04.133430 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rimage_4: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.665] ## DEBUG0: 01:25:04.133457 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_4: Processing NODE_ADD (250,16) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.133527 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_4: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.133888 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rmeta_4 (250:16): read ahead is 256
>> [ 1:27.665] ## DEBUG0: 01:25:04.133963 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rmeta_4: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.665] ## DEBUG0: 01:25:04.133985 lvconvert[15860] device_mapper/libdm-common.c:1493  LVMTEST14057vg-LV1_rimage_5: Processing NODE_RENAME to LVMTEST14057vg-LV1_rimage_3 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.134539 lvconvert[15860] device_mapper/libdm-common.c:1201  Renamed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_5 to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rimage_3
>> [ 1:27.665] ## DEBUG0: 01:25:04.134568 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_3: Processing NODE_ADD (250,20) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.134633 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_3: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.135000 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rimage_3 (250:20): read ahead is 256
>> [ 1:27.665] ## DEBUG0: 01:25:04.135078 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rimage_3: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.665] ## DEBUG0: 01:25:04.135102 lvconvert[15860] device_mapper/libdm-common.c:1493  LVMTEST14057vg-LV1_rmeta_5: Processing NODE_RENAME to LVMTEST14057vg-LV1_rmeta_3 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.135643 lvconvert[15860] device_mapper/libdm-common.c:1201  Renamed /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_5 to /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1_rmeta_3
>> [ 1:27.665] ## DEBUG0: 01:25:04.135671 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_3: Processing NODE_ADD (250,19) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.135744 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_3: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.136082 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rmeta_3 (250:19): read ahead is 256
>> [ 1:27.665] ## DEBUG0: 01:25:04.136159 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rmeta_3: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.665] ## DEBUG0: 01:25:04.136185 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_2: Processing NODE_ADD (250,13) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.136247 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_2: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.136575 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rimage_2 (250:13): read ahead is 256
>> [ 1:27.665] ## DEBUG0: 01:25:04.136653 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rimage_2: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.665] ## DEBUG0: 01:25:04.136677 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_2: Processing NODE_ADD (250,12) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.136748 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_2: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.137087 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rmeta_2 (250:12): read ahead is 256
>> [ 1:27.665] ## DEBUG0: 01:25:04.137167 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rmeta_2: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.665] ## DEBUG0: 01:25:04.137191 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_1: Processing NODE_ADD (250,11) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.137252 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_1: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.137583 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rimage_1 (250:11): read ahead is 256
>> [ 1:27.665] ## DEBUG0: 01:25:04.137660 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rimage_1: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.665] ## DEBUG0: 01:25:04.137694 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_1: Processing NODE_ADD (250,10) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.137762 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_1: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.138094 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rmeta_1 (250:10): read ahead is 256
>> [ 1:27.665] ## DEBUG0: 01:25:04.138171 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rmeta_1: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.665] ## DEBUG0: 01:25:04.138196 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rimage_0: Processing NODE_ADD (250,9) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.138259 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rimage_0: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.139634 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rimage_0 (250:9): read ahead is 256
>> [ 1:27.665] ## DEBUG0: 01:25:04.139787 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rimage_0: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.665] ## DEBUG0: 01:25:04.139815 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1_rmeta_0: Processing NODE_ADD (250,8) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.139881 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1_rmeta_0: Processing NODE_READ_AHEAD 256 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.140235 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1_rmeta_0 (250:8): read ahead is 256
>> [ 1:27.665] ## DEBUG0: 01:25:04.140315 lvconvert[15860] device_mapper/libdm-common.c:1374  LVMTEST14057vg-LV1_rmeta_0: retaining kernel read ahead of 256 (requested 256)
>> [ 1:27.665] ## DEBUG0: 01:25:04.140360 lvconvert[15860] device_mapper/libdm-common.c:1485  LVMTEST14057vg-LV1: Processing NODE_ADD (250,18) 0:0 0600 [verify_udev]
>> [ 1:27.665] ## DEBUG0: 01:25:04.140422 lvconvert[15860] device_mapper/libdm-common.c:1496  LVMTEST14057vg-LV1: Processing NODE_READ_AHEAD 1280 (flags=1)
>> [ 1:27.665] ## DEBUG0: 01:25:04.140756 lvconvert[15860] device_mapper/libdm-common.c:1250  LVMTEST14057vg-LV1 (250:18): read ahead is 768
>> [ 1:27.665] ## DEBUG0: 01:25:04.140832 lvconvert[15860] device_mapper/libdm-common.c:1300  LVMTEST14057vg-LV1 (250:18): Setting read ahead to 1280
>> [ 1:27.665] ## DEBUG0: 01:25:04.141874 lvconvert[15860] activate/fs.c:202  Removing /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/LVMTEST14057vg/LV1
>> [ 1:27.665] ## DEBUG0: 01:25:04.142155 lvconvert[15860] activate/fs.c:212  Linking /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/LVMTEST14057vg/LV1 -> /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1
>> [ 1:27.665] ## DEBUG0: 01:25:04.142595 lvconvert[15860] mm/memlock.c:609  Unlock: Memlock counters: prioritized:0 locked:0 critical:0 daemon:0 suspended:0
>> [ 1:27.665] ## DEBUG0: 01:25:04.142802 lvconvert[15860] format_text/archiver.c:247  WARNING: This metadata update is NOT backed up.
>> [ 1:27.665] ## DEBUG0: 01:25:04.142831 lvconvert[15860] misc/lvm-flock.c:84  Unlocking /mnt/test/LVMTEST14057.I4CHaFJWdP/var/lock/lvm/V_LVMTEST14057vg
>> [ 1:27.665] ## DEBUG0: 01:25:04.142877 lvconvert[15860] misc/lvm-flock.c:47  _undo_flock /mnt/test/LVMTEST14057.I4CHaFJWdP/var/lock/lvm/V_LVMTEST14057vg
>> [ 1:27.665] ## DEBUG0: 01:25:04.143244 lvconvert[15860] metadata/vg.c:80  Freeing VG LVMTEST14057vg at 0x562463b9d1b0.
>> [ 1:27.665] ## DEBUG0: 01:25:04.143481 lvconvert[15860] metadata/vg.c:80  Freeing VG LVMTEST14057vg at 0x562463b71a20.
>> [ 1:27.665] ## DEBUG0: 01:25:04.143519 lvconvert[15860] cache/lvmcache.c:2625  Destroy lvmcache content
>> [ 1:27.665] ## DEBUG0: 01:25:04.269149 lvconvert[15860] lvmcmdline.c:3370  Completed: lvconvert -y --repair LVMTEST14057vg/LV1
>> [ 1:27.665] ## DEBUG0: 01:25:04.269699 lvconvert[15860] cache/lvmcache.c:2625  Destroy lvmcache content
>> [ 1:27.665] ## DEBUG0: 01:25:04.269755 lvconvert[15860] metadata/vg.c:80  Freeing VG #orphans_lvm2 at 0x5624633141f0.
>> [ 1:27.665] ## DEBUG0: 01:25:04.269852 lvconvert[15860] activate/fs.c:493  Syncing device names
>> [ 1:27.665] <======== Info ========>
>> [ 1:27.841] ## DMINFO:   Name                        Maj Min Stat Open Targ Event  UUID
>> [ 1:27.916] ## DMINFO:   LVMTEST14057pv1             250   0 L--w    2    2      0 TEST-LVMTEST14057pv1
>> [ 1:27.916] ## DMINFO:   LVMTEST14057pv2             250   1 L--w    2    2      0 TEST-LVMTEST14057pv2
>> [ 1:27.916] ## DMINFO:   LVMTEST14057pv3             250   2 L--w    2    2      0 TEST-LVMTEST14057pv3
>> [ 1:27.916] ## DMINFO:   LVMTEST14057pv4             250   3 L--w    0    1      0 TEST-LVMTEST14057pv4
>> [ 1:27.916] ## DMINFO:   LVMTEST14057pv5             250   4 L--w    2    2      0 TEST-LVMTEST14057pv5
>> [ 1:27.916] ## DMINFO:   LVMTEST14057pv6             250   5 L--w    2    2      0 TEST-LVMTEST14057pv6
>> [ 1:27.916] ## DMINFO:   LVMTEST14057pv7             250   6 L--w    0    2      0 TEST-LVMTEST14057pv7
>> [ 1:27.916] ## DMINFO:   LVMTEST14057pv8             250   7 L--w    0    2      0 TEST-LVMTEST14057pv8
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1          250  18 L--w    0    1      6 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1_rimage_0 250   9 L--w    1    1      0 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1_rimage_1 250  11 L--w    1    1      0 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1_rimage_2 250  13 L--w    1    1      0 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1_rimage_3 250  20 L--w    1    1      1 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1_rimage_4 250  17 L--w    1    1      0 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1_rmeta_0  250   8 L--w    1    1      0 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1_rmeta_1  250  10 L--w    1    1      0 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1_rmeta_2  250  12 L--w    1    1      0 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1_rmeta_3  250  19 L--w    1    1      1 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g
>> [ 1:27.916] ## DMINFO:   LVMTEST14057vg-LV1_rmeta_4  250  16 L--w    1    1      0 LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s
>> [ 1:27.916] <======== Active table ========>
>> [ 1:27.953] ## DMTABLE:  LVMTEST14057pv1: 0 2048 linear 7:0 2048
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv1: 2048 161792 delay 7:0 4096 0 7:0 4096 50
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv2: 0 2048 linear 7:0 165888
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv2: 2048 161792 delay 7:0 167936 0 7:0 167936 50
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv3: 0 2048 linear 7:0 329728
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv3: 2048 161792 delay 7:0 331776 0 7:0 331776 50
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv4: 0 163840 error
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv5: 0 2048 linear 7:0 657408
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv5: 2048 161792 delay 7:0 659456 0 7:0 659456 50
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv6: 0 2048 linear 7:0 821248
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv6: 2048 161792 delay 7:0 823296 0 7:0 823296 50
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv7: 0 2048 linear 7:0 985088
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv7: 2048 161792 delay 7:0 987136 0 7:0 987136 50
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv8: 0 2048 linear 7:0 1148928
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057pv8: 2048 161792 delay 7:0 1150976 0 7:0 1150976 50
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1: 0 132096 raid raid6_zr 3 128 region_size 1024 5 250:8 250:9 250:10 250:11 250:12 250:13 250:19 250:20 250:16 250:17
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1_rimage_0: 0 44032 linear 250:0 3072
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1_rimage_1: 0 44032 linear 250:1 3072
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1_rimage_2: 0 44032 linear 250:2 3072
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1_rimage_3: 0 44032 linear 250:5 3072
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1_rimage_4: 0 44032 linear 250:4 3072
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1_rmeta_0: 0 1024 linear 250:0 2048
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1_rmeta_1: 0 1024 linear 250:1 2048
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1_rmeta_2: 0 1024 linear 250:2 2048
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1_rmeta_3: 0 1024 linear 250:5 2048
>> [ 1:28.032] ## DMTABLE:  LVMTEST14057vg-LV1_rmeta_4: 0 1024 linear 250:4 2048
>> [ 1:28.032] <======== Inactive table ========>
>> [ 1:28.037] ## DMITABLE: LVMTEST14057pv1:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057pv2:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057pv3:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057pv4:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057pv5:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057pv6:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057pv7:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057pv8:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1_rimage_0:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1_rimage_1:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1_rimage_2:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1_rimage_3:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1_rimage_4:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1_rmeta_0:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1_rmeta_1:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1_rmeta_2:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1_rmeta_3:
>> [ 1:28.112] ## DMITABLE: LVMTEST14057vg-LV1_rmeta_4:
>> [ 1:28.112] <======== Status ========>
>> [ 1:28.116] ## DMSTATUS: LVMTEST14057pv1: 0 2048 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv1: 2048 161792 delay 0 0 1
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv2: 0 2048 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv2: 2048 161792 delay 0 0 1
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv3: 0 2048 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv3: 2048 161792 delay 0 0 1
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv4: 0 163840 error
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv5: 0 2048 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv5: 2048 161792 delay 0 0 1
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv6: 0 2048 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv6: 2048 161792 delay 0 0 1
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv7: 0 2048 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv7: 2048 161792 delay 0 0 0
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv8: 0 2048 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057pv8: 2048 161792 delay 0 0 0
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1: 0 132096 raid raid6_zr 5 AAAaA 11040/44032 recover 0 0 -
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1_rimage_0: 0 44032 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1_rimage_1: 0 44032 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1_rimage_2: 0 44032 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1_rimage_3: 0 44032 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1_rimage_4: 0 44032 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1_rmeta_0: 0 1024 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1_rmeta_1: 0 1024 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1_rmeta_2: 0 1024 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1_rmeta_3: 0 1024 linear
>> [ 1:28.184] ## DMSTATUS: LVMTEST14057vg-LV1_rmeta_4: 0 1024 linear
>> [ 1:28.184] <======== Tree ========>
>> [ 1:28.187] ## DMTREE:   LVMTEST14057pv4 (250:3)
>> [ 1:28.247] ## DMTREE:   LVMTEST14057pv7 (250:6)
>> [ 1:28.247] ## DMTREE:    `- (7:0)
>> [ 1:28.247] ## DMTREE:   LVMTEST14057pv8 (250:7)
>> [ 1:28.247] ## DMTREE:    `- (7:0)
>> [ 1:28.247] ## DMTREE:   LVMTEST14057vg-LV1 (250:18)
>> [ 1:28.247] ## DMTREE:    |-LVMTEST14057vg-LV1_rimage_4 (250:17)
>> [ 1:28.247] ## DMTREE:    |  `-LVMTEST14057pv5 (250:4)
>> [ 1:28.247] ## DMTREE:    |     `- (7:0)
>> [ 1:28.247] ## DMTREE:    |-LVMTEST14057vg-LV1_rmeta_4 (250:16)
>> [ 1:28.247] ## DMTREE:    |  `-LVMTEST14057pv5 (250:4)
>> [ 1:28.247] ## DMTREE:    |     `- (7:0)
>> [ 1:28.247] ## DMTREE:    |-LVMTEST14057vg-LV1_rimage_3 (250:20)
>> [ 1:28.247] ## DMTREE:    |  `-LVMTEST14057pv6 (250:5)
>> [ 1:28.247] ## DMTREE:    |     `- (7:0)
>> [ 1:28.247] ## DMTREE:    |-LVMTEST14057vg-LV1_rmeta_3 (250:19)
>> [ 1:28.247] ## DMTREE:    |  `-LVMTEST14057pv6 (250:5)
>> [ 1:28.247] ## DMTREE:    |     `- (7:0)
>> [ 1:28.247] ## DMTREE:    |-LVMTEST14057vg-LV1_rimage_2 (250:13)
>> [ 1:28.247] ## DMTREE:    |  `-LVMTEST14057pv3 (250:2)
>> [ 1:28.247] ## DMTREE:    |     `- (7:0)
>> [ 1:28.247] ## DMTREE:    |-LVMTEST14057vg-LV1_rmeta_2 (250:12)
>> [ 1:28.247] ## DMTREE:    |  `-LVMTEST14057pv3 (250:2)
>> [ 1:28.247] ## DMTREE:    |     `- (7:0)
>> [ 1:28.247] ## DMTREE:    |-LVMTEST14057vg-LV1_rimage_1 (250:11)
>> [ 1:28.247] ## DMTREE:    |  `-LVMTEST14057pv2 (250:1)
>> [ 1:28.247] ## DMTREE:    |     `- (7:0)
>> [ 1:28.247] ## DMTREE:    |-LVMTEST14057vg-LV1_rmeta_1 (250:10)
>> [ 1:28.247] ## DMTREE:    |  `-LVMTEST14057pv2 (250:1)
>> [ 1:28.247] ## DMTREE:    |     `- (7:0)
>> [ 1:28.247] ## DMTREE:    |-LVMTEST14057vg-LV1_rimage_0 (250:9)
>> [ 1:28.247] ## DMTREE:    |  `-LVMTEST14057pv1 (250:0)
>> [ 1:28.247] ## DMTREE:    |     `- (7:0)
>> [ 1:28.247] ## DMTREE:    `-LVMTEST14057vg-LV1_rmeta_0 (250:8)
>> [ 1:28.247] ## DMTREE:       `-LVMTEST14057pv1 (250:0)
>> [ 1:28.247] ## DMTREE:          `- (7:0)
>> [ 1:28.247] <======== Recursive list of /mnt/test/LVMTEST14057.I4CHaFJWdP/dev ========>
>> [ 1:28.250] ## LS_LR:	/mnt/test/LVMTEST14057.I4CHaFJWdP/dev:
>> [ 1:28.330] ## LS_LR:	total 4
>> [ 1:28.330] ## LS_LR:	drwxr-xr-x 2 root root   17 Feb  6 01:25 LVMTEST14057vg
>> [ 1:28.330] ## LS_LR:	brw-r--r-- 1 root root 7, 0 Feb  6 01:23 loop0
>> [ 1:28.330] ## LS_LR:	brw-r--r-- 1 root root 7, 1 Feb  6 01:23 loop1
>> [ 1:28.330] ## LS_LR:	brw-r--r-- 1 root root 7, 2 Feb  6 01:23 loop2
>> [ 1:28.330] ## LS_LR:	brw-r--r-- 1 root root 7, 3 Feb  6 01:23 loop3
>> [ 1:28.330] ## LS_LR:	brw-r--r-- 1 root root 7, 4 Feb  6 01:23 loop4
>> [ 1:28.330] ## LS_LR:	brw-r--r-- 1 root root 7, 5 Feb  6 01:23 loop5
>> [ 1:28.330] ## LS_LR:	brw-r--r-- 1 root root 7, 6 Feb  6 01:23 loop6
>> [ 1:28.330] ## LS_LR:	brw-r--r-- 1 root root 7, 7 Feb  6 01:23 loop7
>> [ 1:28.330] ## LS_LR:	drwxr-xr-x 2 root root 4096 Feb  6 01:25 mapper
>> [ 1:28.330] ## LS_LR:	crw-r--r-- 1 root root 1, 3 Feb  6 01:23 testnull
>> [ 1:28.330] ## LS_LR:	
>> [ 1:28.330] ## LS_LR:	/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/LVMTEST14057vg:
>> [ 1:28.330] ## LS_LR:	total 0
>> [ 1:28.330] ## LS_LR:	lrwxrwxrwx 1 root root 63 Feb  6 01:25 LV1 -> /mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper/LVMTEST14057vg-LV1
>> [ 1:28.330] ## LS_LR:	
>> [ 1:28.330] ## LS_LR:	/mnt/test/LVMTEST14057.I4CHaFJWdP/dev/mapper:
>> [ 1:28.330] ## LS_LR:	total 0
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,   0 Feb  6 01:25 LVMTEST14057pv1
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,   1 Feb  6 01:25 LVMTEST14057pv2
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,   2 Feb  6 01:25 LVMTEST14057pv3
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,   3 Feb  6 01:24 LVMTEST14057pv4
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,   4 Feb  6 01:25 LVMTEST14057pv5
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,   5 Feb  6 01:25 LVMTEST14057pv6
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,   6 Feb  6 01:25 LVMTEST14057pv7
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,   7 Feb  6 01:25 LVMTEST14057pv8
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,  18 Feb  6 01:24 LVMTEST14057vg-LV1
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,   9 Feb  6 01:24 LVMTEST14057vg-LV1_rimage_0
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,  11 Feb  6 01:24 LVMTEST14057vg-LV1_rimage_1
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,  13 Feb  6 01:24 LVMTEST14057vg-LV1_rimage_2
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,  20 Feb  6 01:25 LVMTEST14057vg-LV1_rimage_3
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,  17 Feb  6 01:24 LVMTEST14057vg-LV1_rimage_4
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,   8 Feb  6 01:24 LVMTEST14057vg-LV1_rmeta_0
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,  10 Feb  6 01:24 LVMTEST14057vg-LV1_rmeta_1
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,  12 Feb  6 01:24 LVMTEST14057vg-LV1_rmeta_2
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,  19 Feb  6 01:25 LVMTEST14057vg-LV1_rmeta_3
>> [ 1:28.330] ## LS_LR:	brw------- 1 root root 250,  16 Feb  6 01:24 LVMTEST14057vg-LV1_rmeta_4
>> [ 1:28.330] ## LS_LR:	crw------- 1 root root  10, 236 Feb  6 01:23 control
>> [ 1:28.330] <======== Udev DB content ========>
>> [ 1:28.351] ## UDEV:	P: /devices/virtual/block/dm-0
>> [ 1:29.012] ## UDEV:	N: dm-0
>> [ 1:29.012] ## UDEV:	L: 0
>> [ 1:29.012] ## UDEV:	S: mapper/LVMTEST14057pv1
>> [ 1:29.012] ## UDEV:	S: disk/by-id/dm-name-LVMTEST14057pv1
>> [ 1:29.012] ## UDEV:	S: disk/by-id/lvm-pv-uuid-KGKo8r-5nBB-UF0y-OVek-DNBw-dXHT-ul1HQy
>> [ 1:29.012] ## UDEV:	S: disk/by-id/dm-uuid-TEST-LVMTEST14057pv1
>> [ 1:29.012] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-0
>> [ 1:29.012] ## UDEV:	E: DEVNAME=/dev/dm-0
>> [ 1:29.012] ## UDEV:	E: DEVTYPE=disk
>> [ 1:29.012] ## UDEV:	E: DISKSEQ=954
>> [ 1:29.012] ## UDEV:	E: MAJOR=250
>> [ 1:29.012] ## UDEV:	E: MINOR=0
>> [ 1:29.012] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:29.012] ## UDEV:	E: USEC_INITIALIZED=1276028206
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:29.012] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:29.012] ## UDEV:	E: DM_NAME=LVMTEST14057pv1
>> [ 1:29.012] ## UDEV:	E: DM_UUID=TEST-LVMTEST14057pv1
>> [ 1:29.012] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:29.012] ## UDEV:	E: ID_FS_UUID=KGKo8r-5nBB-UF0y-OVek-DNBw-dXHT-ul1HQy
>> [ 1:29.012] ## UDEV:	E: ID_FS_UUID_ENC=KGKo8r-5nBB-UF0y-OVek-DNBw-dXHT-ul1HQy
>> [ 1:29.012] ## UDEV:	E: ID_FS_VERSION=LVM2 001
>> [ 1:29.012] ## UDEV:	E: ID_FS_TYPE=LVM2_member
>> [ 1:29.012] ## UDEV:	E: ID_FS_USAGE=raid
>> [ 1:29.012] ## UDEV:	E: SYSTEMD_READY=1
>> [ 1:29.012] ## UDEV:	E: SYSTEMD_ALIAS=/dev/block/250:0
>> [ 1:29.012] ## UDEV:	E: SYSTEMD_WANTS=lvm2-pvscan@250:0.service
>> [ 1:29.012] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057pv1 /dev/disk/by-id/dm-name-LVMTEST14057pv1 /dev/disk/by-id/lvm-pv-uuid-KGKo8r-5nBB-UF0y-OVek-DNBw-dXHT-ul1HQy /dev/disk/by-id/dm-uuid-TEST-LVMTEST14057pv1
>> [ 1:29.012] ## UDEV:	E: TAGS=:systemd:
>> [ 1:29.012] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:29.012] ## UDEV:	
>> [ 1:29.012] ## UDEV:	P: /devices/virtual/block/dm-1
>> [ 1:29.012] ## UDEV:	N: dm-1
>> [ 1:29.012] ## UDEV:	L: 0
>> [ 1:29.012] ## UDEV:	S: disk/by-id/dm-uuid-TEST-LVMTEST14057pv2
>> [ 1:29.012] ## UDEV:	S: disk/by-id/dm-name-LVMTEST14057pv2
>> [ 1:29.012] ## UDEV:	S: disk/by-id/lvm-pv-uuid-TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD
>> [ 1:29.012] ## UDEV:	S: mapper/LVMTEST14057pv2
>> [ 1:29.012] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-1
>> [ 1:29.012] ## UDEV:	E: DEVNAME=/dev/dm-1
>> [ 1:29.012] ## UDEV:	E: DEVTYPE=disk
>> [ 1:29.012] ## UDEV:	E: DISKSEQ=955
>> [ 1:29.012] ## UDEV:	E: MAJOR=250
>> [ 1:29.012] ## UDEV:	E: MINOR=1
>> [ 1:29.012] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:29.012] ## UDEV:	E: USEC_INITIALIZED=1276058476
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:29.012] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:29.012] ## UDEV:	E: DM_NAME=LVMTEST14057pv2
>> [ 1:29.012] ## UDEV:	E: DM_UUID=TEST-LVMTEST14057pv2
>> [ 1:29.012] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:29.012] ## UDEV:	E: ID_FS_UUID=TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD
>> [ 1:29.012] ## UDEV:	E: ID_FS_UUID_ENC=TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD
>> [ 1:29.012] ## UDEV:	E: ID_FS_VERSION=LVM2 001
>> [ 1:29.012] ## UDEV:	E: ID_FS_TYPE=LVM2_member
>> [ 1:29.012] ## UDEV:	E: ID_FS_USAGE=raid
>> [ 1:29.012] ## UDEV:	E: SYSTEMD_READY=1
>> [ 1:29.012] ## UDEV:	E: SYSTEMD_ALIAS=/dev/block/250:1
>> [ 1:29.012] ## UDEV:	E: SYSTEMD_WANTS=lvm2-pvscan@250:1.service
>> [ 1:29.012] ## UDEV:	E: DEVLINKS=/dev/disk/by-id/dm-uuid-TEST-LVMTEST14057pv2 /dev/disk/by-id/dm-name-LVMTEST14057pv2 /dev/disk/by-id/lvm-pv-uuid-TfPnvT-Xdxs-qRMn-u01c-MTTa-8Pm1-EmtnnD /dev/mapper/LVMTEST14057pv2
>> [ 1:29.012] ## UDEV:	E: TAGS=:systemd:
>> [ 1:29.012] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:29.012] ## UDEV:	
>> [ 1:29.012] ## UDEV:	P: /devices/virtual/block/dm-10
>> [ 1:29.012] ## UDEV:	N: dm-10
>> [ 1:29.012] ## UDEV:	L: 0
>> [ 1:29.012] ## UDEV:	S: mapper/LVMTEST14057vg-LV1_rmeta_1
>> [ 1:29.012] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-10
>> [ 1:29.012] ## UDEV:	E: DEVNAME=/dev/dm-10
>> [ 1:29.012] ## UDEV:	E: DEVTYPE=disk
>> [ 1:29.012] ## UDEV:	E: DISKSEQ=1088
>> [ 1:29.012] ## UDEV:	E: MAJOR=250
>> [ 1:29.012] ## UDEV:	E: MINOR=10
>> [ 1:29.012] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:29.012] ## UDEV:	E: USEC_INITIALIZED=1352391054
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG=1
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_DISABLE_DISK_RULES_FLAG=1
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_DISABLE_OTHER_RULES_FLAG=1
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:29.012] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:29.012] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1_rmeta_1
>> [ 1:29.012] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPECpDDoSoAPBhNAETfcjGzeExe4Iw0HR
>> [ 1:29.012] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:29.012] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:29.012] ## UDEV:	E: DM_LV_NAME=LV1_rmeta_1
>> [ 1:29.012] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057vg-LV1_rmeta_1
>> [ 1:29.012] ## UDEV:	E: TAGS=:systemd:
>> [ 1:29.012] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:29.012] ## UDEV:	
>> [ 1:29.012] ## UDEV:	P: /devices/virtual/block/dm-11
>> [ 1:29.012] ## UDEV:	N: dm-11
>> [ 1:29.012] ## UDEV:	L: 0
>> [ 1:29.012] ## UDEV:	S: mapper/LVMTEST14057vg-LV1_rimage_1
>> [ 1:29.012] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-11
>> [ 1:29.012] ## UDEV:	E: DEVNAME=/dev/dm-11
>> [ 1:29.012] ## UDEV:	E: DEVTYPE=disk
>> [ 1:29.012] ## UDEV:	E: DISKSEQ=1089
>> [ 1:29.012] ## UDEV:	E: MAJOR=250
>> [ 1:29.012] ## UDEV:	E: MINOR=11
>> [ 1:29.012] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:29.012] ## UDEV:	E: USEC_INITIALIZED=1352399104
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG=1
>> [ 1:29.012] ## UDEV:	E: DM_UDEV_DISABLE_DISK_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_OTHER_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:29.603] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1_rimage_1
>> [ 1:29.603] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC6hFXe53SZXqDQYbd8DC5OQHGaeFaVSdW
>> [ 1:29.603] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:29.603] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:29.603] ## UDEV:	E: DM_LV_NAME=LV1_rimage_1
>> [ 1:29.603] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057vg-LV1_rimage_1
>> [ 1:29.603] ## UDEV:	E: TAGS=:systemd:
>> [ 1:29.603] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:29.603] ## UDEV:	
>> [ 1:29.603] ## UDEV:	P: /devices/virtual/block/dm-12
>> [ 1:29.603] ## UDEV:	N: dm-12
>> [ 1:29.603] ## UDEV:	L: 0
>> [ 1:29.603] ## UDEV:	S: mapper/LVMTEST14057vg-LV1_rmeta_2
>> [ 1:29.603] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-12
>> [ 1:29.603] ## UDEV:	E: DEVNAME=/dev/dm-12
>> [ 1:29.603] ## UDEV:	E: DEVTYPE=disk
>> [ 1:29.603] ## UDEV:	E: DISKSEQ=1090
>> [ 1:29.603] ## UDEV:	E: MAJOR=250
>> [ 1:29.603] ## UDEV:	E: MINOR=12
>> [ 1:29.603] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:29.603] ## UDEV:	E: USEC_INITIALIZED=1352415211
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_DISK_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_OTHER_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:29.603] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1_rmeta_2
>> [ 1:29.603] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC0YcGCTtf8vIT472qo7CQmyfVuDdJVxnT
>> [ 1:29.603] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:29.603] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:29.603] ## UDEV:	E: DM_LV_NAME=LV1_rmeta_2
>> [ 1:29.603] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057vg-LV1_rmeta_2
>> [ 1:29.603] ## UDEV:	E: TAGS=:systemd:
>> [ 1:29.603] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:29.603] ## UDEV:	
>> [ 1:29.603] ## UDEV:	P: /devices/virtual/block/dm-13
>> [ 1:29.603] ## UDEV:	N: dm-13
>> [ 1:29.603] ## UDEV:	L: 0
>> [ 1:29.603] ## UDEV:	S: mapper/LVMTEST14057vg-LV1_rimage_2
>> [ 1:29.603] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-13
>> [ 1:29.603] ## UDEV:	E: DEVNAME=/dev/dm-13
>> [ 1:29.603] ## UDEV:	E: DEVTYPE=disk
>> [ 1:29.603] ## UDEV:	E: DISKSEQ=1091
>> [ 1:29.603] ## UDEV:	E: MAJOR=250
>> [ 1:29.603] ## UDEV:	E: MINOR=13
>> [ 1:29.603] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:29.603] ## UDEV:	E: USEC_INITIALIZED=1352424568
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_DISK_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_OTHER_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:29.603] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1_rimage_2
>> [ 1:29.603] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCBj6IOwbJurbApjLSwkp0PSEl8VMGrhfS
>> [ 1:29.603] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:29.603] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:29.603] ## UDEV:	E: DM_LV_NAME=LV1_rimage_2
>> [ 1:29.603] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057vg-LV1_rimage_2
>> [ 1:29.603] ## UDEV:	E: TAGS=:systemd:
>> [ 1:29.603] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:29.603] ## UDEV:	
>> [ 1:29.603] ## UDEV:	P: /devices/virtual/block/dm-16
>> [ 1:29.603] ## UDEV:	N: dm-16
>> [ 1:29.603] ## UDEV:	L: 0
>> [ 1:29.603] ## UDEV:	S: mapper/LVMTEST14057vg-LV1_rmeta_4
>> [ 1:29.603] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-16
>> [ 1:29.603] ## UDEV:	E: DEVNAME=/dev/dm-16
>> [ 1:29.603] ## UDEV:	E: DEVTYPE=disk
>> [ 1:29.603] ## UDEV:	E: DISKSEQ=1094
>> [ 1:29.603] ## UDEV:	E: MAJOR=250
>> [ 1:29.603] ## UDEV:	E: MINOR=16
>> [ 1:29.603] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:29.603] ## UDEV:	E: USEC_INITIALIZED=1352498827
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_DISK_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_OTHER_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:29.603] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1_rmeta_4
>> [ 1:29.603] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCyuxL14LpqF7A4LdOlBK5GVH7vZdDB69s
>> [ 1:29.603] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:29.603] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:29.603] ## UDEV:	E: DM_LV_NAME=LV1_rmeta_4
>> [ 1:29.603] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057vg-LV1_rmeta_4
>> [ 1:29.603] ## UDEV:	E: TAGS=:systemd:
>> [ 1:29.603] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:29.603] ## UDEV:	
>> [ 1:29.603] ## UDEV:	P: /devices/virtual/block/dm-17
>> [ 1:29.603] ## UDEV:	N: dm-17
>> [ 1:29.603] ## UDEV:	L: 0
>> [ 1:29.603] ## UDEV:	S: mapper/LVMTEST14057vg-LV1_rimage_4
>> [ 1:29.603] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-17
>> [ 1:29.603] ## UDEV:	E: DEVNAME=/dev/dm-17
>> [ 1:29.603] ## UDEV:	E: DEVTYPE=disk
>> [ 1:29.603] ## UDEV:	E: DISKSEQ=1095
>> [ 1:29.603] ## UDEV:	E: MAJOR=250
>> [ 1:29.603] ## UDEV:	E: MINOR=17
>> [ 1:29.603] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:29.603] ## UDEV:	E: USEC_INITIALIZED=1352494657
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_DISK_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_DISABLE_OTHER_RULES_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:29.603] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:29.603] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1_rimage_4
>> [ 1:29.603] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCUpTyd7TcK6sIK4vCUEe8eaSgZs8KYYkn
>> [ 1:30.294] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:30.294] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:30.294] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:30.294] ## UDEV:	E: DM_LV_NAME=LV1_rimage_4
>> [ 1:30.294] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057vg-LV1_rimage_4
>> [ 1:30.294] ## UDEV:	E: TAGS=:systemd:
>> [ 1:30.294] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:30.294] ## UDEV:	
>> [ 1:30.294] ## UDEV:	P: /devices/virtual/block/dm-18
>> [ 1:30.294] ## UDEV:	N: dm-18
>> [ 1:30.294] ## UDEV:	L: 0
>> [ 1:30.294] ## UDEV:	S: LVMTEST14057vg/LV1
>> [ 1:30.294] ## UDEV:	S: disk/by-id/dm-name-LVMTEST14057vg-LV1
>> [ 1:30.294] ## UDEV:	S: disk/by-id/dm-uuid-LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV
>> [ 1:30.294] ## UDEV:	S: mapper/LVMTEST14057vg-LV1
>> [ 1:30.294] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-18
>> [ 1:30.294] ## UDEV:	E: DEVNAME=/dev/dm-18
>> [ 1:30.294] ## UDEV:	E: DEVTYPE=disk
>> [ 1:30.294] ## UDEV:	E: DISKSEQ=1096
>> [ 1:30.294] ## UDEV:	E: MAJOR=250
>> [ 1:30.294] ## UDEV:	E: MINOR=18
>> [ 1:30.294] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:30.294] ## UDEV:	E: USEC_INITIALIZED=1352665920
>> [ 1:30.294] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:30.294] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:30.294] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1
>> [ 1:30.294] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV
>> [ 1:30.294] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:30.294] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:30.294] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:30.294] ## UDEV:	E: DM_LV_NAME=LV1
>> [ 1:30.294] ## UDEV:	E: DEVLINKS=/dev/LVMTEST14057vg/LV1 /dev/disk/by-id/dm-name-LVMTEST14057vg-LV1 /dev/disk/by-id/dm-uuid-LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCJNYq2x9NfUs6vArBR1UEefyc96SurJIV /dev/mapper/LVMTEST14057vg-LV1
>> [ 1:30.294] ## UDEV:	E: TAGS=:systemd:
>> [ 1:30.294] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:30.294] ## UDEV:	
>> [ 1:30.294] ## UDEV:	P: /devices/virtual/block/dm-19
>> [ 1:30.294] ## UDEV:	N: dm-19
>> [ 1:30.294] ## UDEV:	L: 0
>> [ 1:30.294] ## UDEV:	S: mapper/LVMTEST14057vg-LV1_rmeta_3
>> [ 1:30.294] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-19
>> [ 1:30.294] ## UDEV:	E: DEVNAME=/dev/dm-19
>> [ 1:30.294] ## UDEV:	E: DEVTYPE=disk
>> [ 1:30.294] ## UDEV:	E: DISKSEQ=1097
>> [ 1:30.294] ## UDEV:	E: MAJOR=250
>> [ 1:30.294] ## UDEV:	E: MINOR=19
>> [ 1:30.294] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:30.294] ## UDEV:	E: USEC_INITIALIZED=1354541253
>> [ 1:30.294] ## UDEV:	E: DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG=1
>> [ 1:30.294] ## UDEV:	E: DM_UDEV_DISABLE_DISK_RULES_FLAG=1
>> [ 1:30.294] ## UDEV:	E: DM_UDEV_DISABLE_OTHER_RULES_FLAG=1
>> [ 1:30.294] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:30.294] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:30.294] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1_rmeta_3
>> [ 1:30.294] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCj3UCqN2DMR6ntxzx9EPZYaNltVqcjA3g
>> [ 1:30.294] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:30.294] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:30.294] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:30.294] ## UDEV:	E: DM_LV_NAME=LV1_rmeta_3
>> [ 1:30.294] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057vg-LV1_rmeta_3
>> [ 1:30.294] ## UDEV:	E: TAGS=:systemd:
>> [ 1:30.294] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:30.294] ## UDEV:	
>> [ 1:30.294] ## UDEV:	P: /devices/virtual/block/dm-2
>> [ 1:30.294] ## UDEV:	N: dm-2
>> [ 1:30.294] ## UDEV:	L: 0
>> [ 1:30.294] ## UDEV:	S: disk/by-id/dm-name-LVMTEST14057pv3
>> [ 1:30.294] ## UDEV:	S: disk/by-id/dm-uuid-TEST-LVMTEST14057pv3
>> [ 1:30.294] ## UDEV:	S: mapper/LVMTEST14057pv3
>> [ 1:30.294] ## UDEV:	S: disk/by-id/lvm-pv-uuid-AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck
>> [ 1:30.294] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-2
>> [ 1:30.294] ## UDEV:	E: DEVNAME=/dev/dm-2
>> [ 1:30.294] ## UDEV:	E: DEVTYPE=disk
>> [ 1:30.294] ## UDEV:	E: DISKSEQ=956
>> [ 1:30.294] ## UDEV:	E: MAJOR=250
>> [ 1:30.294] ## UDEV:	E: MINOR=2
>> [ 1:30.294] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:30.294] ## UDEV:	E: USEC_INITIALIZED=1276077277
>> [ 1:30.294] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:30.294] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:30.294] ## UDEV:	E: DM_NAME=LVMTEST14057pv3
>> [ 1:30.294] ## UDEV:	E: DM_UUID=TEST-LVMTEST14057pv3
>> [ 1:30.294] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:30.294] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:30.294] ## UDEV:	E: ID_FS_UUID=AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck
>> [ 1:30.294] ## UDEV:	E: ID_FS_UUID_ENC=AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck
>> [ 1:30.294] ## UDEV:	E: ID_FS_VERSION=LVM2 001
>> [ 1:30.294] ## UDEV:	E: ID_FS_TYPE=LVM2_member
>> [ 1:30.294] ## UDEV:	E: ID_FS_USAGE=raid
>> [ 1:30.294] ## UDEV:	E: SYSTEMD_READY=1
>> [ 1:30.294] ## UDEV:	E: SYSTEMD_ALIAS=/dev/block/250:2
>> [ 1:30.294] ## UDEV:	E: SYSTEMD_WANTS=lvm2-pvscan@250:2.service
>> [ 1:30.294] ## UDEV:	E: DEVLINKS=/dev/disk/by-id/dm-name-LVMTEST14057pv3 /dev/disk/by-id/dm-uuid-TEST-LVMTEST14057pv3 /dev/mapper/LVMTEST14057pv3 /dev/disk/by-id/lvm-pv-uuid-AYf3Ve-pu0j-hNhn-xcq7-SnbP-ekA5-8P01Ck
>> [ 1:30.294] ## UDEV:	E: TAGS=:systemd:
>> [ 1:30.294] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:30.294] ## UDEV:	
>> [ 1:30.294] ## UDEV:	P: /devices/virtual/block/dm-20
>> [ 1:30.294] ## UDEV:	N: dm-20
>> [ 1:30.294] ## UDEV:	L: 0
>> [ 1:30.294] ## UDEV:	S: mapper/LVMTEST14057vg-LV1_rimage_3
>> [ 1:30.294] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-20
>> [ 1:30.294] ## UDEV:	E: DEVNAME=/dev/dm-20
>> [ 1:30.294] ## UDEV:	E: DEVTYPE=disk
>> [ 1:30.294] ## UDEV:	E: DISKSEQ=1098
>> [ 1:30.294] ## UDEV:	E: MAJOR=250
>> [ 1:30.294] ## UDEV:	E: MINOR=20
>> [ 1:30.695] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:30.695] ## UDEV:	E: USEC_INITIALIZED=1354557866
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG=1
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_DISABLE_DISK_RULES_FLAG=1
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_DISABLE_OTHER_RULES_FLAG=1
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:30.695] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:30.695] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1_rimage_3
>> [ 1:30.695] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCPtUeCRXXR20fMRPfneYComAjivQde67z
>> [ 1:30.695] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:30.695] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:30.695] ## UDEV:	E: DM_LV_NAME=LV1_rimage_3
>> [ 1:30.695] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057vg-LV1_rimage_3
>> [ 1:30.695] ## UDEV:	E: TAGS=:systemd:
>> [ 1:30.695] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:30.695] ## UDEV:	
>> [ 1:30.695] ## UDEV:	P: /devices/virtual/block/dm-3
>> [ 1:30.695] ## UDEV:	N: dm-3
>> [ 1:30.695] ## UDEV:	L: 0
>> [ 1:30.695] ## UDEV:	S: disk/by-id/dm-uuid-TEST-LVMTEST14057pv4
>> [ 1:30.695] ## UDEV:	S: disk/by-id/dm-name-LVMTEST14057pv4
>> [ 1:30.695] ## UDEV:	S: mapper/LVMTEST14057pv4
>> [ 1:30.695] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-3
>> [ 1:30.695] ## UDEV:	E: DEVNAME=/dev/dm-3
>> [ 1:30.695] ## UDEV:	E: DEVTYPE=disk
>> [ 1:30.695] ## UDEV:	E: DISKSEQ=957
>> [ 1:30.695] ## UDEV:	E: MAJOR=250
>> [ 1:30.695] ## UDEV:	E: MINOR=3
>> [ 1:30.695] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:30.695] ## UDEV:	E: USEC_INITIALIZED=1276104134
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:30.695] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:30.695] ## UDEV:	E: DM_NAME=LVMTEST14057pv4
>> [ 1:30.695] ## UDEV:	E: DM_UUID=TEST-LVMTEST14057pv4
>> [ 1:30.695] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:30.695] ## UDEV:	E: LVM_PV_GONE=1
>> [ 1:30.695] ## UDEV:	E: SYSTEMD_READY=1
>> [ 1:30.695] ## UDEV:	E: DEVLINKS=/dev/disk/by-id/dm-uuid-TEST-LVMTEST14057pv4 /dev/disk/by-id/dm-name-LVMTEST14057pv4 /dev/mapper/LVMTEST14057pv4
>> [ 1:30.695] ## UDEV:	E: TAGS=:systemd:
>> [ 1:30.695] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:30.695] ## UDEV:	
>> [ 1:30.695] ## UDEV:	P: /devices/virtual/block/dm-4
>> [ 1:30.695] ## UDEV:	N: dm-4
>> [ 1:30.695] ## UDEV:	L: 0
>> [ 1:30.695] ## UDEV:	S: disk/by-id/dm-name-LVMTEST14057pv5
>> [ 1:30.695] ## UDEV:	S: mapper/LVMTEST14057pv5
>> [ 1:30.695] ## UDEV:	S: disk/by-id/lvm-pv-uuid-yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU
>> [ 1:30.695] ## UDEV:	S: disk/by-id/dm-uuid-TEST-LVMTEST14057pv5
>> [ 1:30.695] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-4
>> [ 1:30.695] ## UDEV:	E: DEVNAME=/dev/dm-4
>> [ 1:30.695] ## UDEV:	E: DEVTYPE=disk
>> [ 1:30.695] ## UDEV:	E: DISKSEQ=958
>> [ 1:30.695] ## UDEV:	E: MAJOR=250
>> [ 1:30.695] ## UDEV:	E: MINOR=4
>> [ 1:30.695] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:30.695] ## UDEV:	E: USEC_INITIALIZED=1276119823
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:30.695] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:30.695] ## UDEV:	E: DM_NAME=LVMTEST14057pv5
>> [ 1:30.695] ## UDEV:	E: DM_UUID=TEST-LVMTEST14057pv5
>> [ 1:30.695] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:30.695] ## UDEV:	E: ID_FS_UUID=yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU
>> [ 1:30.695] ## UDEV:	E: ID_FS_UUID_ENC=yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU
>> [ 1:30.695] ## UDEV:	E: ID_FS_VERSION=LVM2 001
>> [ 1:30.695] ## UDEV:	E: ID_FS_TYPE=LVM2_member
>> [ 1:30.695] ## UDEV:	E: ID_FS_USAGE=raid
>> [ 1:30.695] ## UDEV:	E: SYSTEMD_READY=1
>> [ 1:30.695] ## UDEV:	E: SYSTEMD_ALIAS=/dev/block/250:4
>> [ 1:30.695] ## UDEV:	E: SYSTEMD_WANTS=lvm2-pvscan@250:4.service
>> [ 1:30.695] ## UDEV:	E: DEVLINKS=/dev/disk/by-id/dm-name-LVMTEST14057pv5 /dev/mapper/LVMTEST14057pv5 /dev/disk/by-id/lvm-pv-uuid-yT23m1-WG8I-xw0d-8BCs-eGkG-r6YE-3ITFWU /dev/disk/by-id/dm-uuid-TEST-LVMTEST14057pv5
>> [ 1:30.695] ## UDEV:	E: TAGS=:systemd:
>> [ 1:30.695] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:30.695] ## UDEV:	
>> [ 1:30.695] ## UDEV:	P: /devices/virtual/block/dm-5
>> [ 1:30.695] ## UDEV:	N: dm-5
>> [ 1:30.695] ## UDEV:	L: 0
>> [ 1:30.695] ## UDEV:	S: mapper/LVMTEST14057pv6
>> [ 1:30.695] ## UDEV:	S: disk/by-id/lvm-pv-uuid-ZBD1DC-klu6-jpwL-q4cr-lGAT-cOhS-OlCnI9
>> [ 1:30.695] ## UDEV:	S: disk/by-id/dm-name-LVMTEST14057pv6
>> [ 1:30.695] ## UDEV:	S: disk/by-id/dm-uuid-TEST-LVMTEST14057pv6
>> [ 1:30.695] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-5
>> [ 1:30.695] ## UDEV:	E: DEVNAME=/dev/dm-5
>> [ 1:30.695] ## UDEV:	E: DEVTYPE=disk
>> [ 1:30.695] ## UDEV:	E: DISKSEQ=959
>> [ 1:30.695] ## UDEV:	E: MAJOR=250
>> [ 1:30.695] ## UDEV:	E: MINOR=5
>> [ 1:30.695] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:30.695] ## UDEV:	E: USEC_INITIALIZED=1276158383
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:30.695] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:30.695] ## UDEV:	E: DM_NAME=LVMTEST14057pv6
>> [ 1:30.695] ## UDEV:	E: DM_UUID=TEST-LVMTEST14057pv6
>> [ 1:30.695] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:30.695] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:30.695] ## UDEV:	E: ID_FS_UUID=ZBD1DC-klu6-jpwL-q4cr-lGAT-cOhS-OlCnI9
>> [ 1:30.695] ## UDEV:	E: ID_FS_UUID_ENC=ZBD1DC-klu6-jpwL-q4cr-lGAT-cOhS-OlCnI9
>> [ 1:30.695] ## UDEV:	E: ID_FS_VERSION=LVM2 001
>> [ 1:30.695] ## UDEV:	E: ID_FS_TYPE=LVM2_member
>> [ 1:30.695] ## UDEV:	E: ID_FS_USAGE=raid
>> [ 1:30.695] ## UDEV:	E: SYSTEMD_READY=1
>> [ 1:30.695] ## UDEV:	E: SYSTEMD_ALIAS=/dev/block/250:5
>> [ 1:30.695] ## UDEV:	E: SYSTEMD_WANTS=lvm2-pvscan@250:5.service
>> [ 1:30.695] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057pv6 /dev/disk/by-id/lvm-pv-uuid-ZBD1DC-klu6-jpwL-q4cr-lGAT-cOhS-OlCnI9 /dev/disk/by-id/dm-name-LVMTEST14057pv6 /dev/disk/by-id/dm-uuid-TEST-LVMTEST14057pv6
>> [ 1:31.270] ## UDEV:	E: TAGS=:systemd:
>> [ 1:31.270] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:31.270] ## UDEV:	
>> [ 1:31.270] ## UDEV:	P: /devices/virtual/block/dm-6
>> [ 1:31.270] ## UDEV:	N: dm-6
>> [ 1:31.270] ## UDEV:	L: 0
>> [ 1:31.270] ## UDEV:	S: mapper/LVMTEST14057pv7
>> [ 1:31.270] ## UDEV:	S: disk/by-id/lvm-pv-uuid-wwuazH-RbpM-lybe-GMg5-Qdwj-qGhG-QE2Vu6
>> [ 1:31.270] ## UDEV:	S: disk/by-id/dm-uuid-TEST-LVMTEST14057pv7
>> [ 1:31.270] ## UDEV:	S: disk/by-id/dm-name-LVMTEST14057pv7
>> [ 1:31.270] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-6
>> [ 1:31.270] ## UDEV:	E: DEVNAME=/dev/dm-6
>> [ 1:31.270] ## UDEV:	E: DEVTYPE=disk
>> [ 1:31.270] ## UDEV:	E: DISKSEQ=960
>> [ 1:31.270] ## UDEV:	E: MAJOR=250
>> [ 1:31.270] ## UDEV:	E: MINOR=6
>> [ 1:31.270] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:31.270] ## UDEV:	E: USEC_INITIALIZED=1276180418
>> [ 1:31.270] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:31.270] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:31.270] ## UDEV:	E: DM_NAME=LVMTEST14057pv7
>> [ 1:31.270] ## UDEV:	E: DM_UUID=TEST-LVMTEST14057pv7
>> [ 1:31.270] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:31.270] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:31.270] ## UDEV:	E: ID_FS_UUID=wwuazH-RbpM-lybe-GMg5-Qdwj-qGhG-QE2Vu6
>> [ 1:31.270] ## UDEV:	E: ID_FS_UUID_ENC=wwuazH-RbpM-lybe-GMg5-Qdwj-qGhG-QE2Vu6
>> [ 1:31.270] ## UDEV:	E: ID_FS_VERSION=LVM2 001
>> [ 1:31.270] ## UDEV:	E: ID_FS_TYPE=LVM2_member
>> [ 1:31.270] ## UDEV:	E: ID_FS_USAGE=raid
>> [ 1:31.270] ## UDEV:	E: SYSTEMD_READY=1
>> [ 1:31.270] ## UDEV:	E: SYSTEMD_ALIAS=/dev/block/250:6
>> [ 1:31.270] ## UDEV:	E: SYSTEMD_WANTS=lvm2-pvscan@250:6.service
>> [ 1:31.270] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057pv7 /dev/disk/by-id/lvm-pv-uuid-wwuazH-RbpM-lybe-GMg5-Qdwj-qGhG-QE2Vu6 /dev/disk/by-id/dm-uuid-TEST-LVMTEST14057pv7 /dev/disk/by-id/dm-name-LVMTEST14057pv7
>> [ 1:31.270] ## UDEV:	E: TAGS=:systemd:
>> [ 1:31.270] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:31.270] ## UDEV:	
>> [ 1:31.270] ## UDEV:	P: /devices/virtual/block/dm-7
>> [ 1:31.270] ## UDEV:	N: dm-7
>> [ 1:31.270] ## UDEV:	L: 0
>> [ 1:31.270] ## UDEV:	S: disk/by-id/dm-name-LVMTEST14057pv8
>> [ 1:31.270] ## UDEV:	S: disk/by-id/lvm-pv-uuid-0R10Ru-2Wdf-dkfe-nkeO-FReE-R2Nd-dtU49n
>> [ 1:31.270] ## UDEV:	S: disk/by-id/dm-uuid-TEST-LVMTEST14057pv8
>> [ 1:31.270] ## UDEV:	S: mapper/LVMTEST14057pv8
>> [ 1:31.270] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-7
>> [ 1:31.270] ## UDEV:	E: DEVNAME=/dev/dm-7
>> [ 1:31.270] ## UDEV:	E: DEVTYPE=disk
>> [ 1:31.270] ## UDEV:	E: DISKSEQ=961
>> [ 1:31.270] ## UDEV:	E: MAJOR=250
>> [ 1:31.270] ## UDEV:	E: MINOR=7
>> [ 1:31.270] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:31.270] ## UDEV:	E: USEC_INITIALIZED=1276222881
>> [ 1:31.270] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:31.270] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:31.270] ## UDEV:	E: DM_NAME=LVMTEST14057pv8
>> [ 1:31.270] ## UDEV:	E: DM_UUID=TEST-LVMTEST14057pv8
>> [ 1:31.270] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:31.270] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:31.270] ## UDEV:	E: ID_FS_UUID=0R10Ru-2Wdf-dkfe-nkeO-FReE-R2Nd-dtU49n
>> [ 1:31.270] ## UDEV:	E: ID_FS_UUID_ENC=0R10Ru-2Wdf-dkfe-nkeO-FReE-R2Nd-dtU49n
>> [ 1:31.270] ## UDEV:	E: ID_FS_VERSION=LVM2 001
>> [ 1:31.270] ## UDEV:	E: ID_FS_TYPE=LVM2_member
>> [ 1:31.270] ## UDEV:	E: ID_FS_USAGE=raid
>> [ 1:31.270] ## UDEV:	E: SYSTEMD_READY=1
>> [ 1:31.270] ## UDEV:	E: SYSTEMD_ALIAS=/dev/block/250:7
>> [ 1:31.270] ## UDEV:	E: SYSTEMD_WANTS=lvm2-pvscan@250:7.service
>> [ 1:31.270] ## UDEV:	E: DEVLINKS=/dev/disk/by-id/dm-name-LVMTEST14057pv8 /dev/disk/by-id/lvm-pv-uuid-0R10Ru-2Wdf-dkfe-nkeO-FReE-R2Nd-dtU49n /dev/disk/by-id/dm-uuid-TEST-LVMTEST14057pv8 /dev/mapper/LVMTEST14057pv8
>> [ 1:31.270] ## UDEV:	E: TAGS=:systemd:
>> [ 1:31.270] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:31.270] ## UDEV:	
>> [ 1:31.270] ## UDEV:	P: /devices/virtual/block/dm-8
>> [ 1:31.270] ## UDEV:	N: dm-8
>> [ 1:31.270] ## UDEV:	L: 0
>> [ 1:31.270] ## UDEV:	S: mapper/LVMTEST14057vg-LV1_rmeta_0
>> [ 1:31.270] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-8
>> [ 1:31.270] ## UDEV:	E: DEVNAME=/dev/dm-8
>> [ 1:31.270] ## UDEV:	E: DEVTYPE=disk
>> [ 1:31.270] ## UDEV:	E: DISKSEQ=1086
>> [ 1:31.270] ## UDEV:	E: MAJOR=250
>> [ 1:31.270] ## UDEV:	E: MINOR=8
>> [ 1:31.270] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:31.270] ## UDEV:	E: USEC_INITIALIZED=1352354503
>> [ 1:31.270] ## UDEV:	E: DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG=1
>> [ 1:31.270] ## UDEV:	E: DM_UDEV_DISABLE_DISK_RULES_FLAG=1
>> [ 1:31.270] ## UDEV:	E: DM_UDEV_DISABLE_OTHER_RULES_FLAG=1
>> [ 1:31.270] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:31.270] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:31.270] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1_rmeta_0
>> [ 1:31.270] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szCmQ1uvHdalFxxtPX2wQ6PcSCxsmAzJFqG
>> [ 1:31.270] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:31.270] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:31.270] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:31.270] ## UDEV:	E: DM_LV_NAME=LV1_rmeta_0
>> [ 1:31.270] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057vg-LV1_rmeta_0
>> [ 1:31.270] ## UDEV:	E: TAGS=:systemd:
>> [ 1:31.270] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:31.270] ## UDEV:	
>> [ 1:31.270] ## UDEV:	P: /devices/virtual/block/dm-9
>> [ 1:31.270] ## UDEV:	N: dm-9
>> [ 1:31.270] ## UDEV:	L: 0
>> [ 1:31.270] ## UDEV:	S: mapper/LVMTEST14057vg-LV1_rimage_0
>> [ 1:31.270] ## UDEV:	E: DEVPATH=/devices/virtual/block/dm-9
>> [ 1:31.270] ## UDEV:	E: DEVNAME=/dev/dm-9
>> [ 1:31.270] ## UDEV:	E: DEVTYPE=disk
>> [ 1:31.270] ## UDEV:	E: DISKSEQ=1087
>> [ 1:32.704] ## UDEV:	E: MAJOR=250
>> [ 1:32.704] ## UDEV:	E: MINOR=9
>> [ 1:32.704] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:32.704] ## UDEV:	E: USEC_INITIALIZED=1352380748
>> [ 1:32.704] ## UDEV:	E: DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG=1
>> [ 1:32.704] ## UDEV:	E: DM_UDEV_DISABLE_DISK_RULES_FLAG=1
>> [ 1:32.704] ## UDEV:	E: DM_UDEV_DISABLE_OTHER_RULES_FLAG=1
>> [ 1:32.704] ## UDEV:	E: DM_UDEV_PRIMARY_SOURCE_FLAG=1
>> [ 1:32.704] ## UDEV:	E: DM_ACTIVATION=1
>> [ 1:32.704] ## UDEV:	E: DM_NAME=LVMTEST14057vg-LV1_rimage_0
>> [ 1:32.704] ## UDEV:	E: DM_UUID=LVM-lQw2ngFY0Bbmyzg1PYqfGtGLNLHm8szC2CKKm2JyVXLIdGr9S5yFAXNl4ZAW3KFf
>> [ 1:32.704] ## UDEV:	E: DM_SUSPENDED=0
>> [ 1:32.704] ## UDEV:	E: DM_UDEV_RULES_VSN=2
>> [ 1:32.704] ## UDEV:	E: DM_VG_NAME=LVMTEST14057vg
>> [ 1:32.704] ## UDEV:	E: DM_LV_NAME=LV1_rimage_0
>> [ 1:32.704] ## UDEV:	E: DEVLINKS=/dev/mapper/LVMTEST14057vg-LV1_rimage_0
>> [ 1:32.704] ## UDEV:	E: TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	
>> [ 1:32.704] ## UDEV:	P: /devices/virtual/block/loop0
>> [ 1:32.704] ## UDEV:	N: loop0
>> [ 1:32.704] ## UDEV:	L: 0
>> [ 1:32.704] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop0
>> [ 1:32.704] ## UDEV:	E: DEVNAME=/dev/loop0
>> [ 1:32.704] ## UDEV:	E: DEVTYPE=disk
>> [ 1:32.704] ## UDEV:	E: DISKSEQ=953
>> [ 1:32.704] ## UDEV:	E: MAJOR=7
>> [ 1:32.704] ## UDEV:	E: MINOR=0
>> [ 1:32.704] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:32.704] ## UDEV:	E: USEC_INITIALIZED=213039551
>> [ 1:32.704] ## UDEV:	E: TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	
>> [ 1:32.704] ## UDEV:	P: /devices/virtual/block/loop1
>> [ 1:32.704] ## UDEV:	N: loop1
>> [ 1:32.704] ## UDEV:	L: 0
>> [ 1:32.704] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop1
>> [ 1:32.704] ## UDEV:	E: DEVNAME=/dev/loop1
>> [ 1:32.704] ## UDEV:	E: DEVTYPE=disk
>> [ 1:32.704] ## UDEV:	E: DISKSEQ=37
>> [ 1:32.704] ## UDEV:	E: MAJOR=7
>> [ 1:32.704] ## UDEV:	E: MINOR=1
>> [ 1:32.704] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:32.704] ## UDEV:	E: USEC_INITIALIZED=213051885
>> [ 1:32.704] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:32.704] ## UDEV:	E: TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	
>> [ 1:32.704] ## UDEV:	P: /devices/virtual/block/loop10
>> [ 1:32.704] ## UDEV:	N: loop10
>> [ 1:32.704] ## UDEV:	L: 0
>> [ 1:32.704] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop10
>> [ 1:32.704] ## UDEV:	E: DEVNAME=/dev/loop10
>> [ 1:32.704] ## UDEV:	E: DEVTYPE=disk
>> [ 1:32.704] ## UDEV:	E: DISKSEQ=46
>> [ 1:32.704] ## UDEV:	E: MAJOR=7
>> [ 1:32.704] ## UDEV:	E: MINOR=10
>> [ 1:32.704] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:32.704] ## UDEV:	E: USEC_INITIALIZED=213190221
>> [ 1:32.704] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:32.704] ## UDEV:	E: TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	
>> [ 1:32.704] ## UDEV:	P: /devices/virtual/block/loop11
>> [ 1:32.704] ## UDEV:	N: loop11
>> [ 1:32.704] ## UDEV:	L: 0
>> [ 1:32.704] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop11
>> [ 1:32.704] ## UDEV:	E: DEVNAME=/dev/loop11
>> [ 1:32.704] ## UDEV:	E: DEVTYPE=disk
>> [ 1:32.704] ## UDEV:	E: DISKSEQ=47
>> [ 1:32.704] ## UDEV:	E: MAJOR=7
>> [ 1:32.704] ## UDEV:	E: MINOR=11
>> [ 1:32.704] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:32.704] ## UDEV:	E: USEC_INITIALIZED=213187856
>> [ 1:32.704] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:32.704] ## UDEV:	E: TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	
>> [ 1:32.704] ## UDEV:	P: /devices/virtual/block/loop12
>> [ 1:32.704] ## UDEV:	N: loop12
>> [ 1:32.704] ## UDEV:	L: 0
>> [ 1:32.704] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop12
>> [ 1:32.704] ## UDEV:	E: DEVNAME=/dev/loop12
>> [ 1:32.704] ## UDEV:	E: DEVTYPE=disk
>> [ 1:32.704] ## UDEV:	E: DISKSEQ=48
>> [ 1:32.704] ## UDEV:	E: MAJOR=7
>> [ 1:32.704] ## UDEV:	E: MINOR=12
>> [ 1:32.704] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:32.704] ## UDEV:	E: USEC_INITIALIZED=213221188
>> [ 1:32.704] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:32.704] ## UDEV:	E: TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	
>> [ 1:32.704] ## UDEV:	P: /devices/virtual/block/loop13
>> [ 1:32.704] ## UDEV:	N: loop13
>> [ 1:32.704] ## UDEV:	L: 0
>> [ 1:32.704] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop13
>> [ 1:32.704] ## UDEV:	E: DEVNAME=/dev/loop13
>> [ 1:32.704] ## UDEV:	E: DEVTYPE=disk
>> [ 1:32.704] ## UDEV:	E: DISKSEQ=49
>> [ 1:32.704] ## UDEV:	E: MAJOR=7
>> [ 1:32.704] ## UDEV:	E: MINOR=13
>> [ 1:32.704] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:32.704] ## UDEV:	E: USEC_INITIALIZED=213211604
>> [ 1:32.704] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:32.704] ## UDEV:	E: TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	
>> [ 1:32.704] ## UDEV:	P: /devices/virtual/block/loop14
>> [ 1:32.704] ## UDEV:	N: loop14
>> [ 1:32.704] ## UDEV:	L: 0
>> [ 1:32.704] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop14
>> [ 1:32.704] ## UDEV:	E: DEVNAME=/dev/loop14
>> [ 1:32.704] ## UDEV:	E: DEVTYPE=disk
>> [ 1:32.704] ## UDEV:	E: DISKSEQ=50
>> [ 1:32.704] ## UDEV:	E: MAJOR=7
>> [ 1:32.704] ## UDEV:	E: MINOR=14
>> [ 1:32.704] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:32.704] ## UDEV:	E: USEC_INITIALIZED=213259591
>> [ 1:32.704] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:32.704] ## UDEV:	E: TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	
>> [ 1:32.704] ## UDEV:	P: /devices/virtual/block/loop15
>> [ 1:32.704] ## UDEV:	N: loop15
>> [ 1:32.704] ## UDEV:	L: 0
>> [ 1:32.704] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop15
>> [ 1:32.704] ## UDEV:	E: DEVNAME=/dev/loop15
>> [ 1:32.704] ## UDEV:	E: DEVTYPE=disk
>> [ 1:32.704] ## UDEV:	E: DISKSEQ=51
>> [ 1:32.704] ## UDEV:	E: MAJOR=7
>> [ 1:32.704] ## UDEV:	E: MINOR=15
>> [ 1:32.704] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:32.704] ## UDEV:	E: USEC_INITIALIZED=213239550
>> [ 1:32.704] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:32.704] ## UDEV:	E: TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:32.704] ## UDEV:	
>> [ 1:32.704] ## UDEV:	P: /devices/virtual/block/loop2
>> [ 1:32.704] ## UDEV:	N: loop2
>> [ 1:32.704] ## UDEV:	L: 0
>> [ 1:32.704] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop2
>> [ 1:33.775] ## UDEV:	E: DEVNAME=/dev/loop2
>> [ 1:33.775] ## UDEV:	E: DEVTYPE=disk
>> [ 1:33.775] ## UDEV:	E: DISKSEQ=38
>> [ 1:33.775] ## UDEV:	E: MAJOR=7
>> [ 1:33.775] ## UDEV:	E: MINOR=2
>> [ 1:33.775] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:33.775] ## UDEV:	E: USEC_INITIALIZED=213060889
>> [ 1:33.775] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:33.775] ## UDEV:	E: TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	
>> [ 1:33.775] ## UDEV:	P: /devices/virtual/block/loop3
>> [ 1:33.775] ## UDEV:	N: loop3
>> [ 1:33.775] ## UDEV:	L: 0
>> [ 1:33.775] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop3
>> [ 1:33.775] ## UDEV:	E: DEVNAME=/dev/loop3
>> [ 1:33.775] ## UDEV:	E: DEVTYPE=disk
>> [ 1:33.775] ## UDEV:	E: DISKSEQ=39
>> [ 1:33.775] ## UDEV:	E: MAJOR=7
>> [ 1:33.775] ## UDEV:	E: MINOR=3
>> [ 1:33.775] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:33.775] ## UDEV:	E: USEC_INITIALIZED=213079110
>> [ 1:33.775] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:33.775] ## UDEV:	E: TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	
>> [ 1:33.775] ## UDEV:	P: /devices/virtual/block/loop4
>> [ 1:33.775] ## UDEV:	N: loop4
>> [ 1:33.775] ## UDEV:	L: 0
>> [ 1:33.775] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop4
>> [ 1:33.775] ## UDEV:	E: DEVNAME=/dev/loop4
>> [ 1:33.775] ## UDEV:	E: DEVTYPE=disk
>> [ 1:33.775] ## UDEV:	E: DISKSEQ=40
>> [ 1:33.775] ## UDEV:	E: MAJOR=7
>> [ 1:33.775] ## UDEV:	E: MINOR=4
>> [ 1:33.775] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:33.775] ## UDEV:	E: USEC_INITIALIZED=213108479
>> [ 1:33.775] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:33.775] ## UDEV:	E: TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	
>> [ 1:33.775] ## UDEV:	P: /devices/virtual/block/loop5
>> [ 1:33.775] ## UDEV:	N: loop5
>> [ 1:33.775] ## UDEV:	L: 0
>> [ 1:33.775] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop5
>> [ 1:33.775] ## UDEV:	E: DEVNAME=/dev/loop5
>> [ 1:33.775] ## UDEV:	E: DEVTYPE=disk
>> [ 1:33.775] ## UDEV:	E: DISKSEQ=41
>> [ 1:33.775] ## UDEV:	E: MAJOR=7
>> [ 1:33.775] ## UDEV:	E: MINOR=5
>> [ 1:33.775] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:33.775] ## UDEV:	E: USEC_INITIALIZED=213115253
>> [ 1:33.775] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:33.775] ## UDEV:	E: TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	
>> [ 1:33.775] ## UDEV:	P: /devices/virtual/block/loop6
>> [ 1:33.775] ## UDEV:	N: loop6
>> [ 1:33.775] ## UDEV:	L: 0
>> [ 1:33.775] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop6
>> [ 1:33.775] ## UDEV:	E: DEVNAME=/dev/loop6
>> [ 1:33.775] ## UDEV:	E: DEVTYPE=disk
>> [ 1:33.775] ## UDEV:	E: DISKSEQ=42
>> [ 1:33.775] ## UDEV:	E: MAJOR=7
>> [ 1:33.775] ## UDEV:	E: MINOR=6
>> [ 1:33.775] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:33.775] ## UDEV:	E: USEC_INITIALIZED=213166653
>> [ 1:33.775] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:33.775] ## UDEV:	E: TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	
>> [ 1:33.775] ## UDEV:	P: /devices/virtual/block/loop7
>> [ 1:33.775] ## UDEV:	N: loop7
>> [ 1:33.775] ## UDEV:	L: 0
>> [ 1:33.775] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop7
>> [ 1:33.775] ## UDEV:	E: DEVNAME=/dev/loop7
>> [ 1:33.775] ## UDEV:	E: DEVTYPE=disk
>> [ 1:33.775] ## UDEV:	E: DISKSEQ=43
>> [ 1:33.775] ## UDEV:	E: MAJOR=7
>> [ 1:33.775] ## UDEV:	E: MINOR=7
>> [ 1:33.775] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:33.775] ## UDEV:	E: USEC_INITIALIZED=213146806
>> [ 1:33.775] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:33.775] ## UDEV:	E: TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	
>> [ 1:33.775] ## UDEV:	P: /devices/virtual/block/loop8
>> [ 1:33.775] ## UDEV:	N: loop8
>> [ 1:33.775] ## UDEV:	L: 0
>> [ 1:33.775] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop8
>> [ 1:33.775] ## UDEV:	E: DEVNAME=/dev/loop8
>> [ 1:33.775] ## UDEV:	E: DEVTYPE=disk
>> [ 1:33.775] ## UDEV:	E: DISKSEQ=44
>> [ 1:33.775] ## UDEV:	E: MAJOR=7
>> [ 1:33.775] ## UDEV:	E: MINOR=8
>> [ 1:33.775] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:33.775] ## UDEV:	E: USEC_INITIALIZED=213138529
>> [ 1:33.775] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:33.775] ## UDEV:	E: TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	
>> [ 1:33.775] ## UDEV:	P: /devices/virtual/block/loop9
>> [ 1:33.775] ## UDEV:	N: loop9
>> [ 1:33.775] ## UDEV:	L: 0
>> [ 1:33.775] ## UDEV:	E: DEVPATH=/devices/virtual/block/loop9
>> [ 1:33.775] ## UDEV:	E: DEVNAME=/dev/loop9
>> [ 1:33.775] ## UDEV:	E: DEVTYPE=disk
>> [ 1:33.775] ## UDEV:	E: DISKSEQ=45
>> [ 1:33.775] ## UDEV:	E: MAJOR=7
>> [ 1:33.775] ## UDEV:	E: MINOR=9
>> [ 1:33.775] ## UDEV:	E: SUBSYSTEM=block
>> [ 1:33.775] ## UDEV:	E: USEC_INITIALIZED=213163800
>> [ 1:33.775] ## UDEV:	E: SYSTEMD_READY=0
>> [ 1:33.775] ## UDEV:	E: TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	E: CURRENT_TAGS=:systemd:
>> [ 1:33.775] ## UDEV:	
>> [ 1:33.775] <======== Free space ========>
>> [ 1:33.783] ## DF_H:	Filesystem      Size  Used Avail Use% Mounted on
>> [ 1:33.838] ## DF_H:	/dev/root        20G   11G  9.4G  54% /
>> [ 1:33.838] ## DF_H:	devtmpfs        3.3G     0  3.3G   0% /dev
>> [ 1:33.838] ## DF_H:	tmpfs           3.3G     0  3.3G   0% /dev/shm
>> [ 1:33.838] ## DF_H:	tmpfs           1.4G  1.1M  1.4G   1% /run
>> [ 1:33.838] ## DF_H:	tmpfs           4.0M     0  4.0M   0% /sys/fs/cgroup
>> [ 1:33.838] ## DF_H:	tmpfs           3.3G     0  3.3G   0% /tmp
>> [ 1:33.838] ## DF_H:	modules          14T   12T  2.8T  81% /tmp/modules
>> [ 1:33.838] ## DF_H:	tmpfs           676M     0  676M   0% /run/user/0
>> [ 1:33.838] ## DF_H:	/dev/nvme0n1     10G  6.2G  3.8G  62% /mnt/test
>> [ 1:33.838] <======== Script file "lvconvert-repair-raid.sh" ========>
>> [ 1:33.856] ## Line: 1 	 #!/usr/bin/env bash
>> [ 1:33.918] ## Line: 2 	
>> [ 1:33.918] ## Line: 3 	 # Copyright (C) 2013-2017 Red Hat, Inc. All rights reserved.
>> [ 1:33.918] ## Line: 4 	 #
>> [ 1:33.918] ## Line: 5 	 # This copyrighted material is made available to anyone wishing to use,
>> [ 1:33.918] ## Line: 6 	 # modify, copy, or redistribute it subject to the terms and conditions
>> [ 1:33.918] ## Line: 7 	 # of the GNU General Public License v.2.
>> [ 1:33.918] ## Line: 8 	 #
>> [ 1:33.918] ## Line: 9 	 # You should have received a copy of the GNU General Public License
>> [ 1:33.918] ## Line: 10 	 # along with this program; if not, write to the Free Software Foundation,
>> [ 1:33.918] ## Line: 11 	 # Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> [ 1:33.918] ## Line: 12 	
>> [ 1:33.918] ## Line: 13 	
>> [ 1:33.918] ## Line: 14 	 SKIP_WITH_LVMPOLLD=1
>> [ 1:33.918] ## Line: 15 	
>> [ 1:33.918] ## Line: 16 	 . lib/inittest
>> [ 1:33.918] ## Line: 17 	
>> [ 1:33.918] ## Line: 18 	 aux have_raid 1 3 0 || skip
>> [ 1:33.918] ## Line: 19 	 aux raid456_replace_works || skip
>> [ 1:33.918] ## Line: 20 	
>> [ 1:33.918] ## Line: 21 	 aux lvmconf 'allocation/maximise_cling = 0' \
>> [ 1:33.918] ## Line: 22 	 	    'allocation/mirror_logs_require_separate_pvs = 1' \
>> [ 1:33.918] ## Line: 23 	 	    'activation/raid_fault_policy = "allocate"'
>> [ 1:33.918] ## Line: 24 	
>> [ 1:33.918] ## Line: 25 	 aux prepare_vg 8 80
>> [ 1:33.918] ## Line: 26 	 get_devs
>> [ 1:33.918] ## Line: 27 	
>> [ 1:33.918] ## Line: 28 	 offset=$(get first_extent_sector "$dev1")
>> [ 1:33.918] ## Line: 29 	
>> [ 1:33.918] ## Line: 30 	 function delay
>> [ 1:33.918] ## Line: 31 	 {
>> [ 1:33.918] ## Line: 32 	 	for d in "${DEVICES[@]}"; do
>> [ 1:33.918] ## Line: 33 	 		aux delay_dev "$d" 0 $1 "$offset"
>> [ 1:33.918] ## Line: 34 	 	done
>> [ 1:33.918] ## Line: 35 	 }
>> [ 1:33.918] ## Line: 36 	
>> [ 1:33.918] ## Line: 37 	 # It's possible small raid arrays do have problems with reporting in-sync.
>> [ 1:33.918] ## Line: 38 	 # So try bigger size
>> [ 1:33.918] ## Line: 39 	 RAID_SIZE=32
>> [ 1:33.918] ## Line: 40 	
>> [ 1:33.918] ## Line: 41 	 # Fast sync and repair afterwards
>> [ 1:33.918] ## Line: 42 	 delay 0
>> [ 1:33.918] ## Line: 43 	
>> [ 1:33.918] ## Line: 44 	 # RAID1 transient failure check
>> [ 1:33.918] ## Line: 45 	 lvcreate --type raid1 -m 1 -L $RAID_SIZE -n $lv1 $vg "$dev1" "$dev2"
>> [ 1:33.918] ## Line: 46 	 aux wait_for_sync $vg $lv1
>> [ 1:33.918] ## Line: 47 	 # enforce replacing live rimage leg with error target
>> [ 1:33.918] ## Line: 48 	 dmsetup remove -f $vg-${lv1}_rimage_1 || true
>> [ 1:33.918] ## Line: 49 	 # let it notice there is problem
>> [ 1:33.918] ## Line: 50 	 echo a > "$DM_DEV_DIR/$vg/$lv1"
>> [ 1:33.918] ## Line: 51 	 check grep_dmsetup status $vg-$lv1 AD
>> [ 1:33.918] ## Line: 52 	 lvconvert -y --repair $vg/$lv1 "$dev3"
>> [ 1:33.918] ## Line: 53 	 lvs -a -o+devices $vg
>> [ 1:33.918] ## Line: 54 	 aux wait_for_sync $vg $lv1
>> [ 1:33.918] ## Line: 55 	 # Raid should have fixed device
>> [ 1:33.918] ## Line: 56 	 check grep_dmsetup status $vg-$lv1 AA
>> [ 1:33.918] ## Line: 57 	 check lv_on $vg ${lv1}_rimage_1 "$dev3"
>> [ 1:33.918] ## Line: 58 	 lvremove -ff $vg/$lv1
>> [ 1:33.918] ## Line: 59 	
>> [ 1:33.918] ## Line: 60 	
>> [ 1:33.918] ## Line: 61 	 # RAID1 dual-leg single replace after initial sync
>> [ 1:33.918] ## Line: 62 	 lvcreate --type raid1 -m 1 -L $RAID_SIZE -n $lv1 $vg "$dev1" "$dev2"
>> [ 1:33.918] ## Line: 63 	 aux wait_for_sync $vg $lv1
>> [ 1:33.918] ## Line: 64 	 aux disable_dev "$dev2"
>> [ 1:33.918] ## Line: 65 	 lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 66 	 vgreduce --removemissing $vg
>> [ 1:33.918] ## Line: 67 	 aux enable_dev "$dev2"
>> [ 1:33.918] ## Line: 68 	 vgck --updatemetadata $vg
>> [ 1:33.918] ## Line: 69 	 vgextend $vg "$dev2"
>> [ 1:33.918] ## Line: 70 	 lvremove -ff $vg/$lv1
>> [ 1:33.918] ## Line: 71 	
>> [ 1:33.918] ## Line: 72 	 # Delayed sync to allow for repair during rebuild
>> [ 1:33.918] ## Line: 73 	 delay 50
>> [ 1:33.918] ## Line: 74 	
>> [ 1:33.918] ## Line: 75 	 # RAID1 triple-leg single replace during initial sync
>> [ 1:33.918] ## Line: 76 	 lvcreate --type raid1 -m 2 -L $RAID_SIZE -n $lv1 $vg "$dev1" "$dev2" "$dev3"
>> [ 1:33.918] ## Line: 77 	 aux disable_dev "$dev2" "$dev3"
>> [ 1:33.918] ## Line: 78 	 # FIXME 2016/11/04 AGK: Disabled next line as it fails to guarantee it is not already in sync.
>> [ 1:33.918] ## Line: 79 	 #not lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 80 	 aux wait_for_sync $vg $lv1
>> [ 1:33.918] ## Line: 81 	 lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 82 	 vgreduce --removemissing $vg
>> [ 1:33.918] ## Line: 83 	 aux enable_dev "$dev2" "$dev3"
>> [ 1:33.918] ## Line: 84 	 vgck --updatemetadata $vg
>> [ 1:33.918] ## Line: 85 	 vgextend $vg "$dev2" "$dev3"
>> [ 1:33.918] ## Line: 86 	 lvremove -ff $vg/$lv1
>> [ 1:33.918] ## Line: 87 	
>> [ 1:33.918] ## Line: 88 	
>> [ 1:33.918] ## Line: 89 	 # Larger RAID size possible for striped RAID
>> [ 1:33.918] ## Line: 90 	 RAID_SIZE=64
>> [ 1:33.918] ## Line: 91 	
>> [ 1:33.918] ## Line: 92 	 # Fast sync and repair afterwards
>> [ 1:33.918] ## Line: 93 	 delay 0
>> [ 1:33.918] ## Line: 94 	 # RAID5 single replace after initial sync
>> [ 1:33.918] ## Line: 95 	 lvcreate --type raid5 -i 2 -L $RAID_SIZE -n $lv1 $vg "$dev1" "$dev2" "$dev3"
>> [ 1:33.918] ## Line: 96 	 aux wait_for_sync $vg $lv1
>> [ 1:33.918] ## Line: 97 	 aux disable_dev "$dev3"
>> [ 1:33.918] ## Line: 98 	 vgreduce --removemissing -f $vg
>> [ 1:33.918] ## Line: 99 	 lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 100 	 aux enable_dev "$dev3"
>> [ 1:33.918] ## Line: 101 	 vgck --updatemetadata $vg
>> [ 1:33.918] ## Line: 102 	 pvcreate -yff "$dev3"
>> [ 1:33.918] ## Line: 103 	 vgextend $vg "$dev3"
>> [ 1:33.918] ## Line: 104 	 lvremove -ff $vg/$lv1
>> [ 1:33.918] ## Line: 105 	
>> [ 1:33.918] ## Line: 106 	 # Delayed sync to allow for repair during rebuild
>> [ 1:33.918] ## Line: 107 	 delay 60
>> [ 1:33.918] ## Line: 108 	
>> [ 1:33.918] ## Line: 109 	 # RAID5 single replace during initial sync
>> [ 1:33.918] ## Line: 110 	 lvcreate --type raid5 -i 2 -L $RAID_SIZE -n $lv1 $vg "$dev1" "$dev2" "$dev3"
>> [ 1:33.918] ## Line: 111 	 aux disable_dev "$dev3"
>> [ 1:33.918] ## Line: 112 	 # FIXME: there is quite big sleep on several 'status' read retries
>> [ 1:33.918] ## Line: 113 	 # so over 3sec - it may actually finish full sync
>> [ 1:33.918] ## Line: 114 	 # Use 'should' for this test result.
>> [ 1:33.918] ## Line: 115 	 should not lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 116 	 aux wait_for_sync $vg $lv1
>> [ 1:33.918] ## Line: 117 	 lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 118 	 vgreduce --removemissing $vg
>> [ 1:33.918] ## Line: 119 	 aux enable_dev "$dev3"
>> [ 1:33.918] ## Line: 120 	 vgck --updatemetadata $vg
>> [ 1:33.918] ## Line: 121 	 vgextend $vg "$dev3"
>> [ 1:33.918] ## Line: 122 	 lvremove -ff $vg/$lv1
>> [ 1:33.918] ## Line: 123 	
>> [ 1:33.918] ## Line: 124 	 # Fast sync and repair afterwards
>> [ 1:33.918] ## Line: 125 	 delay 0
>> [ 1:33.918] ## Line: 126 	
>> [ 1:33.918] ## Line: 127 	 # RAID6 double replace after initial sync
>> [ 1:33.918] ## Line: 128 	 lvcreate --type raid6 -i 3 -L $RAID_SIZE -n $lv1 $vg \
>> [ 1:33.918] ## Line: 129 	     "$dev1" "$dev2" "$dev3" "$dev4" "$dev5"
>> [ 1:33.918] ## Line: 130 	 aux wait_for_sync $vg $lv1
>> [ 1:33.918] ## Line: 131 	 aux disable_dev "$dev4" "$dev5"
>> [ 1:33.918] ## Line: 132 	 lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 133 	 vgreduce --removemissing $vg
>> [ 1:33.918] ## Line: 134 	 aux enable_dev "$dev4" "$dev5"
>> [ 1:33.918] ## Line: 135 	 vgck --updatemetadata $vg
>> [ 1:33.918] ## Line: 136 	 vgextend $vg "$dev4" "$dev5"
>> [ 1:33.918] ## Line: 137 	 lvremove -ff $vg/$lv1
>> [ 1:33.918] ## Line: 138 	
>> [ 1:33.918] ## Line: 139 	 # Delayed sync to allow for repair during rebuild
>> [ 1:33.918] ## Line: 140 	 delay 50
>> [ 1:33.918] ## Line: 141 	
>> [ 1:33.918] ## Line: 142 	 # RAID6 single replace after initial sync
>> [ 1:33.918] ## Line: 143 	 lvcreate --type raid6 -i 3 -L $RAID_SIZE -n $lv1 $vg \
>> [ 1:33.918] ## Line: 144 	     "$dev1" "$dev2" "$dev3" "$dev4" "$dev5"
>> [ 1:33.918] ## Line: 145 	 aux disable_dev "$dev4"
>> [ 1:33.918] ## Line: 146 	 not lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 147 	 delay 0 # Fast sync and repair afterwards
>> [ 1:33.918] ## Line: 148 	 aux disable_dev "$dev4" # Need to disable again after changing delay
>> [ 1:33.918] ## Line: 149 	 aux wait_for_sync $vg $lv1
>> [ 1:33.918] ## Line: 150 	 lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 151 	 vgreduce --removemissing $vg
>> [ 1:33.918] ## Line: 152 	 aux enable_dev "$dev4"
>> [ 1:33.918] ## Line: 153 	 vgck --updatemetadata $vg
>> [ 1:33.918] ## Line: 154 	 vgextend $vg "$dev4"
>> [ 1:33.918] ## Line: 155 	 lvremove -ff $vg/$lv1
>> [ 1:33.918] ## Line: 156 	
>> [ 1:33.918] ## Line: 157 	 # Delayed sync to allow for repair during rebuild
>> [ 1:33.918] ## Line: 158 	 delay 50
>> [ 1:33.918] ## Line: 159 	
>> [ 1:33.918] ## Line: 160 	 # RAID10 single replace after initial sync
>> [ 1:33.918] ## Line: 161 	 lvcreate --type raid10 -m 1 -i 2 -L $RAID_SIZE -n $lv1 $vg \
>> [ 1:33.918] ## Line: 162 	     "$dev1" "$dev2" "$dev3" "$dev4"
>> [ 1:33.918] ## Line: 163 	 aux disable_dev "$dev4"
>> [ 1:33.918] ## Line: 164 	 not lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 165 	 delay 0 # Fast sync and repair afterwards
>> [ 1:33.918] ## Line: 166 	 aux disable_dev "$dev4" # Need to disable again after changing delay
>> [ 1:33.918] ## Line: 167 	 aux disable_dev "$dev1"
>> [ 1:33.918] ## Line: 168 	 aux wait_for_sync $vg $lv1
>> [ 1:33.918] ## Line: 169 	 lvconvert -y --repair $vg/$lv1
>> [ 1:33.918] ## Line: 170 	 vgreduce --removemissing $vg
>> [ 1:33.918] ## Line: 171 	 aux enable_dev "$dev4"
>> [ 1:33.918] ## Line: 172 	 vgck --updatemetadata $vg
>> [ 1:33.918] ## Line: 173 	 vgextend $vg "$dev4"
>> [ 1:33.918] ## Line: 174 	 lvremove -ff $vg/$lv1
>> [ 1:33.918] ## Line: 175 	
>> [ 1:33.918] ## Line: 176 	 vgremove -ff $vg
>> [ 1:33.918] aux teardown
>> [ 1:33.935] #lvconvert-repair-raid.sh:1+ aux teardown
>> [ 1:33.935] ## teardown....6,2230,1367016208,-;md: mdX: recovery done.
>> [ 1:34.862] ...## removing stray mapped devices with names beginning with LVMTEST14057:
>> [ 1:35.393] ..ok
>> ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
>>
>> ### 1 tests: 0 passed, 0 skipped, 0 timed out, 0 warned, 1 failed   in  1:42.225
>> make[1]: *** [Makefile:148: check_local] Error 1
>> make[1]: Leaving directory '/mnt/test/lvm2/test'
>> make: *** [Makefile:89: check_local] Error 2
> 
> .
> 



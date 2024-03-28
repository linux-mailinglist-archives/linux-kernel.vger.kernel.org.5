Return-Path: <linux-kernel+bounces-122740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE1688FC52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64111F2FB73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CBF7BAF4;
	Thu, 28 Mar 2024 10:01:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4A657BD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620066; cv=none; b=cSRwbP2pY5GXLOUOKnMfn4jlk5C4+hh5FQewLaNlZHEI7jFPbfRna/e91LiBKNHEkMOV+1neg5aXgXm1MabD0SHCGdMzvdVoM070h5vfA3kK7MHb1cud+cdBeE1cs9ytwqG1SbXF7UckMdsHOQetM3E63VsRMrFFGKmNOR263B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620066; c=relaxed/simple;
	bh=+6LHEoV9s46N51EU+LWqDbmOctNRbs5eK1bWjSv2IdI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=laox1Lr6YfilOLCm3UqWycesCBW69qWzEFR2WIL+I4X6WOPdkrAjIyuijUX6JwsbDj9z5FA6DmigvJZNPC3H2ab3fklHhtD65G/OPHu867/AIOIp7222EGlA5eAl6tar4940qCq7ykuzUT9SFRq3m+pbmWoA8zgKjytMPirHwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so64321239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711620062; x=1712224862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab8qw9AVrknDLGgJj+5LJ6dILUHEmB6hGFiour98v3c=;
        b=ZsB3Ujn9iBGG4oF/Dmfpg2oDZKdmsky+oRKIz4Ozlj5VFjKnSGaBgZ8RehKdvJKr/x
         6L+KiP2gGY1djlzJ57knXw7Y2mHMvsPF3Gibql18uV37aznGTFPSbIXcEcldO5wb5cCh
         MAc4SrLY3FR2FaR8p1sJYqN0hSNZ3SAE/K6PHWgn8x6kFCncOig4wbHnxcELZbja6bzf
         RuqchaA7qPXiD8VLjxOzR8Fiqqn27j2vwF7Pedmf7c7eaFDjs5dPEhHGk/qrunnFIgso
         Das37dnmlu4oVGrUUKA5M4wxXWsSdmAk5XMXaqvOl/13lqalgl9tu6P+slVCPyfBwefw
         kYlA==
X-Forwarded-Encrypted: i=1; AJvYcCVhPQnp7CauAzb2VHPz1fnMXPbGfKzFe0C31WkPVa0dLiIXymX9m5wiXEYtlPj8rY5Vr5W6qWMM1m1XSO3I8iuQX2627faOinkTfOAf
X-Gm-Message-State: AOJu0YzFc0Np97UunahxS7WDjm9kj2iuIWG4htoJUUoy2AQpbS9mrCfx
	luGPnYJVFYaC5oouLsCjHNPrxBcrBZWTBdR47IoPThjKkzu7dFk8BNRX1HHwK+nUvcCKbCA/ZMX
	//hj6aj941dwhZ+U+6V34dy/Kzh7iy+34yGrmdjZE28ovEanD1gYAgNQ=
X-Google-Smtp-Source: AGHT+IEw78GzKmoKx2Mo4gzNfjYiJopkXff13tBAzWtmZlgMSwm8qSfkO4ezX6DFTCrt51Eb36dR1A4A5F3vFt64swA4HhSKKse8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f90:b0:7cf:16d5:1820 with SMTP id
 fb16-20020a0566023f9000b007cf16d51820mr62462iob.2.1711620061971; Thu, 28 Mar
 2024 03:01:01 -0700 (PDT)
Date: Thu, 28 Mar 2024 03:01:01 -0700
In-Reply-To: <c621f56d-6354-45a3-8c41-1380f5f03b1f@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8d6b00614b599a2@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
From: syzbot <syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

o
  CC      fs/aio.o
  CC      drivers/hid/hid-gt683r.o
  CC      drivers/hid/hid-gyration.o
  CC      drivers/hid/hid-holtek-kbd.o
  CC      drivers/platform/x86/p2sb.o
  CC      drivers/iio/buffer/industrialio-triggered-buffer.o
  CC      drivers/staging/rtl8712/rtl871x_ioctl_set.o
  CC      drivers/staging/rtl8712/rtl8712_led.o
  AR      drivers/mailbox/built-in.a
  CC      fs/btrfs/uuid-tree.o
  CC      fs/xfs/xfs_dquot.o
  CC      fs/dax.o
  AR      drivers/iio/accel/built-in.a
  AR      drivers/iio/cdc/built-in.a
  CC      fs/locks.o
  CC      drivers/iio/adc/viperboard_adc.o
  CC      drivers/gpu/drm/i915/display/intel_plane_initial.o
  CC      fs/binfmt_misc.o
  CC      fs/binfmt_script.o
  CC      net/netfilter/xt_length.o
  CC      drivers/hid/hid-holtek-mouse.o
  AR      drivers/iio/chemical/built-in.a
  CC      fs/xfs/xfs_dquot_item.o
  AR      drivers/iio/common/cros_ec_sensors/built-in.a
  CC      drivers/iio/common/hid-sensors/hid-sensor-attributes.o
  CC      drivers/extcon/devres.o
  CC      fs/bcachefs/opts.o
  CC      drivers/iio/common/hid-sensors/hid-sensor-trigger.o
  CC      fs/binfmt_elf.o
  AR      drivers/media/usb/pvrusb2/built-in.a
  CC      fs/xfs/xfs_trans_dquot.o
  AR      drivers/iio/common/inv_sensors/built-in.a
  CC      fs/xfs/xfs_qm_syscalls.o
  CC      fs/xfs/xfs_qm_bhv.o
  CC      drivers/staging/rtl8712/rtl871x_mlme.o
  AR      drivers/iio/dac/built-in.a
  CC      drivers/hid/hid-holtekff.o
  CC      drivers/hid/hid-icade.o
  CC      drivers/iio/buffer/kfifo_buf.o
  AR      drivers/iio/common/ms_sensors/built-in.a
  CC      net/netfilter/xt_limit.o
  CC      net/netfilter/xt_mac.o
  AR      drivers/iio/common/scmi_sensors/built-in.a
  CC      drivers/thunderbolt/nhi.o
  AR      drivers/hwtracing/intel_th/built-in.a
  AR      drivers/iio/adc/built-in.a
  CC      net/netfilter/xt_multiport.o
  AR      drivers/iio/common/ssp_sensors/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_pmdemand.o
  AR      drivers/iio/dummy/built-in.a
  CC      drivers/thunderbolt/nhi_ops.o
  CC      fs/btrfs/props.o
  AR      drivers/iio/common/st_sensors/built-in.a
  CC      net/netfilter/xt_nfacct.o
  CC      fs/xfs/xfs_qm.o
  CC      net/netfilter/xt_osf.o
  AR      drivers/platform/x86/built-in.a
  CC      fs/xfs/xfs_quotaops.o
  AR      drivers/platform/built-in.a
  CC      fs/xfs/xfs_rtalloc.o
  CC      drivers/android/binderfs.o
  CC      drivers/iio/gyro/hid-sensor-gyro-3d.o
  CC      drivers/extcon/extcon-intel-cht-wc.o
  CC      fs/compat_binfmt_elf.o
  CC      fs/xfs/xfs_acl.o
  CC      drivers/thunderbolt/ctl.o
  CC      drivers/thunderbolt/tb.o
  CC      fs/btrfs/free-space-tree.o
  CC      fs/btrfs/tree-checker.o
  CC      fs/xfs/xfs_sysctl.o
  CC      drivers/hid/hid-ite.o
  CC      drivers/staging/rtl8712/ieee80211.o
  CC      drivers/staging/rtl8712/rtl871x_mp_ioctl.o
  CC      drivers/staging/rtl8712/rtl871x_mp.o
  CC      fs/btrfs/space-info.o
  CC      drivers/thunderbolt/switch.o
  CC      net/netfilter/xt_owner.o
  CC      drivers/hid/hid-kensington.o
  AR      drivers/nvmem/layouts/built-in.a
  CC      drivers/nvmem/core.o
  CC      drivers/staging/rtl8712/mlme_linux.o
  CC      fs/backing-file.o
  CC      drivers/staging/rtl8712/recv_linux.o
  CC      drivers/staging/rtl8712/xmit_linux.o
  CC      drivers/thunderbolt/cap.o
  CC      fs/bcachefs/printbuf.o
  AR      drivers/ras/built-in.a
  CC      fs/mbcache.o
  AR      drivers/iio/filter/built-in.a
  CC      drivers/counter/counter-core.o
  AR      drivers/iio/buffer/built-in.a
  CC      fs/posix_acl.o
  CC      drivers/staging/rtl8712/usb_intf.o
  CC      fs/coredump.o
  AR      drivers/iio/frequency/built-in.a
  AR      drivers/iio/health/built-in.a
  CC      drivers/most/core.o
  AR      drivers/extcon/built-in.a
  CC      drivers/counter/counter-sysfs.o
  CC      drivers/counter/counter-chrdev.o
  CC      net/netfilter/xt_cgroup.o
  AR      drivers/iio/gyro/built-in.a
  AR      drivers/iio/common/hid-sensors/built-in.a
  CC      fs/drop_caches.o
  AR      drivers/iio/common/built-in.a
  CC      drivers/iio/humidity/hid-sensor-humidity.o
  CC      fs/sysctls.o
  CC      drivers/hid/hid-keytouch.o
  CC      fs/xfs/xfs_ioctl32.o
  CC      drivers/thunderbolt/path.o
  CC      drivers/thunderbolt/tunnel.o
  AR      fs/ocfs2/built-in.a
  CC      drivers/thunderbolt/eeprom.o
  CC      net/netfilter/xt_physdev.o
  CC      fs/fhandle.o
  CC      drivers/android/binder.o
  CC      drivers/staging/rtl8712/os_intfs.o
  CC      fs/btrfs/block-rsv.o
  CC      drivers/android/binder_alloc.o
  CC      drivers/hid/hid-kye.o
  CC      drivers/most/configfs.o
  AR      drivers/iio/imu/bmi160/built-in.a
  AR      drivers/iio/imu/bmi323/built-in.a
  AR      drivers/iio/imu/bno055/built-in.a
  CC      fs/bcachefs/quota.o
  CC      drivers/iio/light/hid-sensor-als.o
  CC      drivers/iio/light/hid-sensor-prox.o
  AR      drivers/iio/imu/inv_icm42600/built-in.a
  AR      drivers/iio/imu/inv_mpu6050/built-in.a
  CC      fs/btrfs/delalloc-space.o
  AR      drivers/iio/imu/st_lsm6dsx/built-in.a
  CC      fs/btrfs/block-group.o
  AR      drivers/iio/imu/st_lsm9ds0/built-in.a
  CC      fs/btrfs/discard.o
  AR      drivers/iio/imu/built-in.a
  CC      fs/btrfs/reflink.o
  CC      drivers/staging/rtl8712/rtl871x_pwrctrl.o
  CC      fs/bcachefs/rebalance.o
  CC      drivers/iio/magnetometer/hid-sensor-magn-3d.o
  CC      fs/btrfs/subpage.o
  CC      drivers/thunderbolt/domain.o
  CC      fs/btrfs/tree-mod-log.o
  CC      net/netfilter/xt_pkttype.o
  CC      fs/btrfs/extent-io-tree.o
  AR      drivers/iio/multiplexer/built-in.a
  CC      drivers/iio/orientation/hid-sensor-incl-3d.o
  CC      drivers/gpu/drm/i915/display/intel_psr.o
  AR      drivers/media/usb/gspca/built-in.a
  AR      drivers/iio/position/built-in.a
  CC      drivers/iio/orientation/hid-sensor-rotation.o
  AR      drivers/media/usb/built-in.a
  CC      net/netfilter/xt_policy.o
  CC      net/netfilter/xt_quota.o
  AR      drivers/iio/potentiometer/built-in.a
  CC      drivers/nvmem/layouts.o
  CC      drivers/staging/rtl8712/rtl8712_recv.o
  AR      drivers/media/built-in.a
  CC      fs/bcachefs/recovery.o
  CC      fs/xfs/xfs_pnfs.o
  CC      drivers/gpu/drm/i915/display/intel_quirks.o
  CC      fs/btrfs/fs.o
  AR      drivers/iio/potentiostat/built-in.a
  CC      drivers/hid/hid-lcpower.o
  CC      drivers/hid/hid-lenovo.o
  CC      drivers/hid/hid-lg.o
  CC      drivers/hid/hid-lgff.o
  AR      drivers/iio/humidity/built-in.a
  CC      net/netfilter/xt_rateest.o
  AR      drivers/iio/resolver/built-in.a
  AR      drivers/iio/proximity/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_sprite.o
  CC      drivers/iio/pressure/hid-sensor-press.o
  CC      drivers/iio/temperature/hid-sensor-temperature.o
  CC      drivers/gpu/drm/i915/display/intel_sprite_uapi.o
  CC      fs/btrfs/messages.o
  CC      drivers/gpu/drm/i915/display/intel_tc.o
  AR      drivers/counter/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_vblank.o
  CC      drivers/gpu/drm/i915/display/intel_vga.o
  CC      drivers/hid/hid-lg2ff.o
  CC      drivers/thunderbolt/dma_port.o
  CC      fs/btrfs/bio.o
  AR      drivers/iio/light/built-in.a
  AR      drivers/iio/test/built-in.a
  AR      drivers/iio/trigger/built-in.a
  CC      drivers/thunderbolt/icm.o
  CC      net/netfilter/xt_realm.o
  CC      net/netfilter/xt_recent.o
  CC      net/netfilter/xt_sctp.o
  CC      drivers/thunderbolt/property.o
  AR      drivers/iio/magnetometer/built-in.a
  CC      drivers/hid/hid-lg3ff.o
  AR      drivers/most/built-in.a
  CC      drivers/thunderbolt/xdomain.o
  CC      drivers/hid/hid-lg4ff.o
  CC      net/netfilter/xt_socket.o
  CC      drivers/thunderbolt/lc.o
  CC      net/netfilter/xt_state.o
  CC      drivers/hid/hid-lg-g15.o
  CC      fs/btrfs/lru_cache.o
  CC      drivers/staging/rtl8712/rtl871x_recv.o
  CC      drivers/iio/industrialio-core.o
  CC      drivers/gpu/drm/i915/display/intel_wm.o
  AR      drivers/iio/orientation/built-in.a
  CC      net/netfilter/xt_statistic.o
  CC      drivers/iio/industrialio-event.o
  CC      drivers/iio/inkern.o
  CC      net/netfilter/xt_string.o
  CC      fs/btrfs/raid-stripe-tree.o
  CC      net/netfilter/xt_tcpmss.o
  CC      net/netfilter/xt_time.o
  CC      drivers/iio/industrialio-buffer.o
  CC      drivers/hid/hid-logitech-dj.o
  CC      drivers/gpu/drm/i915/display/skl_scaler.o
  AR      drivers/nvmem/built-in.a
  CC      drivers/iio/industrialio-trigger.o
  CC      drivers/gpu/drm/i915/display/skl_universal_plane.o
  CC      drivers/thunderbolt/tmu.o
  AR      drivers/iio/temperature/built-in.a
  CC      fs/btrfs/acl.o
  CC      drivers/hid/hid-logitech-hidpp.o
  CC      drivers/hid/hid-magicmouse.o
  AR      drivers/iio/pressure/built-in.a
  CC      drivers/thunderbolt/usb4.o
  CC      drivers/thunderbolt/usb4_port.o
  CC      drivers/staging/rtl8712/rtl871x_sta_mgt.o
  CC      drivers/gpu/drm/i915/display/skl_watermark.o
  CC      drivers/hid/hid-mf.o
  CC      net/netfilter/xt_u32.o
  CC      fs/bcachefs/reflink.o
  CC      drivers/staging/rtl8712/rtl871x_xmit.o
  CC      fs/btrfs/ref-verify.o
  CC      drivers/thunderbolt/nvm.o
  CC      net/netfilter/nf_hooks_lwtunnel.o
  CC      drivers/staging/rtl8712/rtl8712_xmit.o
  CC      fs/bcachefs/sb-clean.o
  CC      drivers/hid/hid-microsoft.o
  CC      fs/bcachefs/replicas.o
  CC      fs/btrfs/zoned.o
  CC      drivers/gpu/drm/i915/display/intel_acpi.o
  CC      fs/bcachefs/sb-counters.o
  CC      drivers/hid/hid-monterey.o
  CC      drivers/gpu/drm/i915/display/intel_opregion.o
  CC      fs/btrfs/verity.o
  CC      fs/bcachefs/sb-downgrade.o
  CC      fs/bcachefs/sb-errors.o
  CC      fs/bcachefs/sb-members.o
  CC      fs/bcachefs/siphash.o
  CC      drivers/hid/hid-multitouch.o
  CC      drivers/hid/hid-nti.o
  CC      drivers/hid/hid-ntrig.o
  CC      drivers/gpu/drm/i915/display/intel_fbdev.o
  CC      drivers/thunderbolt/retimer.o
  CC      fs/bcachefs/six.o
  CC      fs/bcachefs/snapshot.o
  CC      drivers/thunderbolt/quirks.o
  CC      drivers/thunderbolt/clx.o
  CC      drivers/thunderbolt/acpi.o
  CC      drivers/hid/hid-ortek.o
  CC      drivers/hid/hid-prodikeys.o
  CC      drivers/hid/hid-pl.o
  CC      drivers/gpu/drm/i915/display/intel_fbdev_fb.o
  CC      drivers/hid/hid-penmount.o
  CC      drivers/thunderbolt/debugfs.o
  CC      drivers/hid/hid-petalynx.o
  CC      drivers/hid/hid-picolcd_core.o
  CC      drivers/hid/hid-picolcd_fb.o
  CC      drivers/hid/hid-picolcd_backlight.o
  CC      drivers/hid/hid-picolcd_lcd.o
  CC      drivers/gpu/drm/i915/display/intel_display_debugfs.o
  CC      drivers/gpu/drm/i915/display/intel_display_debugfs_params.o
  CC      drivers/hid/hid-picolcd_leds.o
  CC      drivers/gpu/drm/i915/display/intel_pipe_crc.o
  CC      drivers/hid/hid-picolcd_cir.o
  CC      drivers/gpu/drm/i915/display/dvo_ch7017.o
  CC      drivers/gpu/drm/i915/display/dvo_ch7xxx.o
  CC      drivers/hid/hid-picolcd_debugfs.o
  CC      drivers/gpu/drm/i915/display/dvo_ivch.o
  CC      fs/bcachefs/subvolume.o
  CC      fs/bcachefs/super.o
  CC      fs/bcachefs/super-io.o
  CC      fs/bcachefs/sysfs.o
  CC      drivers/hid/hid-plantronics.o
  CC      fs/bcachefs/tests.o
  CC      fs/bcachefs/time_stats.o
  CC      fs/bcachefs/thread_with_file.o
  CC      drivers/hid/hid-primax.o
  CC      fs/bcachefs/trace.o
  CC      drivers/hid/hid-redragon.o
  CC      drivers/hid/hid-retrode.o
  CC      drivers/hid/hid-roccat.o
  CC      drivers/hid/hid-roccat-common.o
  CC      fs/bcachefs/two_state_shared_lock.o
  CC      drivers/hid/hid-roccat-arvo.o
  CC      fs/bcachefs/util.o
  CC      fs/bcachefs/varint.o
  CC      drivers/hid/hid-roccat-isku.o
  CC      drivers/gpu/drm/i915/display/dvo_ns2501.o
  CC      drivers/hid/hid-roccat-kone.o
  CC      fs/bcachefs/xattr.o
  CC      drivers/hid/hid-roccat-koneplus.o
  CC      drivers/gpu/drm/i915/display/dvo_sil164.o
  CC      drivers/hid/hid-roccat-konepure.o
  CC      drivers/hid/hid-roccat-kovaplus.o
  CC      drivers/gpu/drm/i915/display/dvo_tfp410.o
  CC      drivers/gpu/drm/i915/display/g4x_dp.o
  AR      drivers/iio/built-in.a
  AR      drivers/staging/rtl8712/built-in.a
  CC      drivers/hid/hid-roccat-lua.o
  CC      drivers/gpu/drm/i915/display/g4x_hdmi.o
  AR      drivers/staging/built-in.a
  CC      drivers/hid/hid-roccat-pyra.o
  CC      drivers/hid/hid-roccat-ryos.o
  CC      drivers/hid/hid-roccat-savu.o
  AR      net/netfilter/built-in.a
  CC      drivers/hid/hid-rmi.o
  CC      drivers/gpu/drm/i915/display/icl_dsi.o
  CC      drivers/hid/hid-saitek.o
  AR      fs/xfs/built-in.a
  CC      drivers/hid/hid-samsung.o
  AR      net/built-in.a
  CC      drivers/hid/hid-sjoy.o
  CC      drivers/hid/hid-sony.o
  CC      drivers/hid/hid-speedlink.o
  CC      drivers/hid/hid-steelseries.o
  CC      drivers/gpu/drm/i915/display/intel_backlight.o
  CC      drivers/hid/hid-sunplus.o
  CC      drivers/gpu/drm/i915/display/intel_crt.o
  CC      drivers/gpu/drm/i915/display/intel_cx0_phy.o
  CC      drivers/hid/hid-gaff.o
  CC      drivers/hid/hid-tmff.o
  CC      drivers/hid/hid-thrustmaster.o
  CC      drivers/gpu/drm/i915/display/intel_ddi.o
  CC      drivers/hid/hid-tivo.o
  CC      drivers/gpu/drm/i915/display/intel_ddi_buf_trans.o
  CC      drivers/hid/hid-topseed.o
  CC      drivers/hid/hid-twinhan.o
  CC      drivers/hid/hid-uclogic-core.o
  CC      drivers/hid/hid-uclogic-rdesc.o
  CC      drivers/hid/hid-uclogic-params.o
  AR      drivers/thunderbolt/built-in.a
  CC      drivers/hid/hid-udraw-ps3.o
  CC      drivers/hid/hid-led.o
  CC      drivers/hid/hid-xinmo.o
  CC      drivers/hid/hid-zpff.o
  CC      drivers/hid/hid-zydacron.o
  CC      drivers/hid/wacom_wac.o
  CC      drivers/hid/wacom_sys.o
  CC      drivers/hid/hid-waltop.o
  CC      drivers/hid/hid-wiimote-core.o
  CC      drivers/hid/hid-wiimote-modules.o
  CC      drivers/hid/hid-wiimote-debug.o
  CC      drivers/hid/hid-sensor-hub.o
  CC      drivers/gpu/drm/i915/display/intel_display_device.o
  CC      drivers/hid/hid-sensor-custom.o
  CC      drivers/gpu/drm/i915/display/intel_display_trace.o
  CC      drivers/gpu/drm/i915/display/intel_dkl_phy.o
  CC      drivers/gpu/drm/i915/display/intel_dp.o
  CC      drivers/gpu/drm/i915/display/intel_dp_aux.o
  CC      drivers/gpu/drm/i915/display/intel_dp_aux_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_dp_hdcp.o
  CC      drivers/gpu/drm/i915/display/intel_dp_link_training.o
  CC      drivers/gpu/drm/i915/display/intel_dp_mst.o
  CC      drivers/gpu/drm/i915/display/intel_dsi.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_dcs_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_vbt.o
  CC      drivers/gpu/drm/i915/display/intel_gmbus.o
  CC      drivers/gpu/drm/i915/display/intel_dvo.o
  CC      drivers/gpu/drm/i915/display/intel_hdmi.o
  CC      drivers/gpu/drm/i915/display/intel_lspcon.o
  CC      drivers/gpu/drm/i915/display/intel_lvds.o
  CC      drivers/gpu/drm/i915/display/intel_panel.o
  CC      drivers/gpu/drm/i915/display/intel_pps.o
  CC      drivers/gpu/drm/i915/display/intel_qp_tables.o
  CC      drivers/gpu/drm/i915/display/intel_sdvo.o
  CC      drivers/gpu/drm/i915/display/intel_snps_phy.o
  CC      drivers/gpu/drm/i915/display/intel_tv.o
  CC      drivers/gpu/drm/i915/display/intel_vdsc.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi.o
  CC      drivers/gpu/drm/i915/display/intel_vrr.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi_pll.o
  CC      drivers/gpu/drm/i915/display/intel_dp_tunnel.o
  AR      fs/btrfs/built-in.a
  CC      drivers/gpu/drm/i915/i915_perf.o
  CC      drivers/gpu/drm/i915/pxp/intel_pxp.o
  CC      drivers/gpu/drm/i915/pxp/intel_pxp_huc.o
  CC      drivers/gpu/drm/i915/pxp/intel_pxp_tee.o
  CC      drivers/gpu/drm/i915/i915_gpu_error.o
  CC      drivers/gpu/drm/i915/i915_vgpu.o
  AR      drivers/android/built-in.a
  AR      fs/bcachefs/built-in.a
  AR      fs/built-in.a
  AR      drivers/hid/built-in.a
  AR      drivers/gpu/drm/i915/built-in.a
  AR      drivers/gpu/drm/built-in.a
  AR      drivers/gpu/built-in.a
  AR      drivers/built-in.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
Killed
make[2]: *** [scripts/Makefile.vmlinux_o:62: vmlinux.o] Error 137
make[2]: *** Deleting file 'vmlinux.o'
make[1]: *** [/syzkaller/jobs/linux/kernel/Makefile:1141: vmlinux_o] Error 2
make: *** [Makefile:240: __sub-make] Error 2


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=12986595180000


Tested on:

commit:         d8889e86 bpf: Mark bpf prog stack with kmsan_unposion_..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/martin.lau/bpf-next.git interpreter.kmsan
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
dashboard link: https://syzkaller.appspot.com/bug?extid=1a3cf6f08d68868f9db3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.


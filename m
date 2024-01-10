Return-Path: <linux-kernel+bounces-22023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E9682980F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20191C21C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24141231;
	Wed, 10 Jan 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Fxr4dF6V"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7540C1C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2b27a67b7fso63377566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704884034; x=1705488834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jsBc7LWVuMBLq7HdFHhyl/91ZwUP9kfBcW9YgQ6VTM=;
        b=Fxr4dF6V1uvIsNZIcuXaHYwxL7wyICe1Z671UsyGmHEFW/jxHHqAjUiIg7tr113Pa9
         kFXmbvxJNpt2gUh37Ygw6eWYjrvz6FWkxDnX2Sy7yAQC8jU9Eov1lawR4pJ8oI9USUAO
         WzdTRAh5DyxiNvGNXHRjtQOM0wv0oiVrfhJk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704884034; x=1705488834;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jsBc7LWVuMBLq7HdFHhyl/91ZwUP9kfBcW9YgQ6VTM=;
        b=UhkrqdjIc9aUgCyWZBgbpp8saPuiisObtTSK5N0US7C7t60dmLwabT1hQgPA1P4I33
         9vuggwAhMwAwpRX32icR/RPLFYfTI6N1nq9aSkP/9LcHyzUojLlqzG8T7DLk+tofu2rt
         rg55x6bJOBgiFU1/d235EXIRgjan932SKi0bOceWYzF/hKf4/OltAkPz2qYpAPXa3CKp
         I64Lzw4VeW9NgkG4+kwh/seocxmXPQhd2g0mXKdR55EKY1ro1g3vGHUNF1AJUctrr+A6
         0rEab6U6rwAEMgxS7aYtJRDo+WjrHn1xMG7rMn105B4SdfvNQ4iIcg7t1gqlpbfV+ygI
         9iWA==
X-Gm-Message-State: AOJu0Yz8BofSY+rMr9TY7ip5+FDzaIG2uZqKwGtLnLy7LBESbXS5qh7C
	j8U0HdqJpQAgb+qUXmaJuQZa82YrDkepBQ==
X-Google-Smtp-Source: AGHT+IGvbi2Udbq52hidwZ7NZ+N/tAQbdmEryuosmducZx2A28CbT0myTY49ZSjosCtwUWGsQIQsmw==
X-Received: by 2002:a17:906:a091:b0:a2a:6916:60de with SMTP id q17-20020a170906a09100b00a2a691660demr1118102ejy.4.1704884033834;
        Wed, 10 Jan 2024 02:53:53 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f26-20020a17090624da00b00a28a8ca1c55sm1968803ejb.212.2024.01.10.02.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:53:53 -0800 (PST)
Date: Wed, 10 Jan 2024 11:53:51 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.dev>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2] drm: Check output polling initialized before disabling
Message-ID: <ZZ53P1v0nms-Y8gk@phenom.ffwll.local>
Mail-Followup-To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.dev>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
References: <1704869987-7546-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1704869987-7546-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Tue, Jan 09, 2024 at 10:59:47PM -0800, Shradha Gupta wrote:
> In drm_kms_helper_poll_disable() check if output polling
> support is initialized before disabling polling.
> For drivers like hyperv-drm, that do not initialize connector
> polling, if suspend is called without this check, it leads to
> suspend failure with following stack
> [  770.719392] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [  770.720592] printk: Suspending console(s) (use no_console_suspend to debug)
> [  770.948823] ------------[ cut here ]------------
> [  770.948824] WARNING: CPU: 1 PID: 17197 at kernel/workqueue.c:3162 __flush_work.isra.0+0x212/0x230
> [  770.948831] Modules linked in: rfkill nft_counter xt_conntrack xt_owner udf nft_compat crc_itu_t nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink vfat fat mlx5_ib ib_uverbs ib_core mlx5_core intel_rapl_msr intel_rapl_common kvm_amd ccp mlxfw kvm psample hyperv_drm tls drm_shmem_helper drm_kms_helper irqbypass pcspkr syscopyarea sysfillrect sysimgblt hv_balloon hv_utils joydev drm fuse xfs libcrc32c pci_hyperv pci_hyperv_intf sr_mod sd_mod cdrom t10_pi sg hv_storvsc scsi_transport_fc hv_netvsc serio_raw hyperv_keyboard hid_hyperv crct10dif_pclmul crc32_pclmul crc32c_intel hv_vmbus ghash_clmulni_intel dm_mirror dm_region_hash dm_log dm_mod
> [  770.948863] CPU: 1 PID: 17197 Comm: systemd-sleep Not tainted 5.14.0-362.2.1.el9_3.x86_64 #1
> [  770.948865] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 05/09/2022
> [  770.948866] RIP: 0010:__flush_work.isra.0+0x212/0x230
> [  770.948869] Code: 8b 4d 00 4c 8b 45 08 89 ca 48 c1 e9 04 83 e2 08 83 e1 0f 83 ca 02 89 c8 48 0f ba 6d 00 03 e9 25 ff ff ff 0f 0b e9 4e ff ff ff <0f> 0b 45 31 ed e9 44 ff ff ff e8 8f 89 b2 00 66 66 2e 0f 1f 84 00
> [  770.948870] RSP: 0018:ffffaf4ac213fb10 EFLAGS: 00010246
> [  770.948871] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8c992857
> [  770.948872] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff9aad82b00330
> [  770.948873] RBP: ffff9aad82b00330 R08: 0000000000000000 R09: ffff9aad87ee3d10
> [  770.948874] R10: 0000000000000200 R11: 0000000000000000 R12: ffff9aad82b00330
> [  770.948874] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
> [  770.948875] FS:  00007ff1b2f6bb40(0000) GS:ffff9aaf37d00000(0000) knlGS:0000000000000000
> [  770.948878] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  770.948878] CR2: 0000555f345cb666 CR3: 00000001462dc005 CR4: 0000000000370ee0
> [  770.948879] Call Trace:
> [  770.948880]  <TASK>
> [  770.948881]  ? show_trace_log_lvl+0x1c4/0x2df
> [  770.948884]  ? show_trace_log_lvl+0x1c4/0x2df
> [  770.948886]  ? __cancel_work_timer+0x103/0x190
> [  770.948887]  ? __flush_work.isra.0+0x212/0x230
> [  770.948889]  ? __warn+0x81/0x110
> [  770.948891]  ? __flush_work.isra.0+0x212/0x230
> [  770.948892]  ? report_bug+0x10a/0x140
> [  770.948895]  ? handle_bug+0x3c/0x70
> [  770.948898]  ? exc_invalid_op+0x14/0x70
> [  770.948899]  ? asm_exc_invalid_op+0x16/0x20
> [  770.948903]  ? __flush_work.isra.0+0x212/0x230
> [  770.948905]  __cancel_work_timer+0x103/0x190
> [  770.948907]  ? _raw_spin_unlock_irqrestore+0xa/0x30
> [  770.948910]  drm_kms_helper_poll_disable+0x1e/0x40 [drm_kms_helper]
> [  770.948923]  drm_mode_config_helper_suspend+0x1c/0x80 [drm_kms_helper]

So since this only happens for drivers using
drm_mode_config_helper_suspend, I think we should put the check in there.
And then we also need to (somehow, not sure how?) make sure that for that
case, we do not enable polling on resume either.

Because for drivers using poll helpers directly it would be a driver bug
to call _disable without having called _enable first. And so I think we
should at least put a drm_WARN around the if() check your adding, since
that if check papers over some more fundamental issue.

Cheers, Sima

> [  770.948933]  ? __pfx_vmbus_suspend+0x10/0x10 [hv_vmbus]
> [  770.948942]  hyperv_vmbus_suspend+0x17/0x40 [hyperv_drm]
> [  770.948944]  ? __pfx_vmbus_suspend+0x10/0x10 [hv_vmbus]
> [  770.948951]  dpm_run_callback+0x4c/0x140
> [  770.948954]  __device_suspend_noirq+0x74/0x220
> [  770.948956]  dpm_noirq_suspend_devices+0x148/0x2a0
> [  770.948958]  dpm_suspend_end+0x54/0xe0
> [  770.948960]  create_image+0x14/0x290
> [  770.948963]  hibernation_snapshot+0xd6/0x200
> [  770.948964]  hibernate.cold+0x8b/0x1fb
> [  770.948967]  state_store+0xcd/0xd0
> [  770.948969]  kernfs_fop_write_iter+0x124/0x1b0
> [  770.948973]  new_sync_write+0xff/0x190
> [  770.948976]  vfs_write+0x1ef/0x280
> [  770.948978]  ksys_write+0x5f/0xe0
> [  770.948979]  do_syscall_64+0x5c/0x90
> [  770.948981]  ? syscall_exit_work+0x103/0x130
> [  770.948983]  ? syscall_exit_to_user_mode+0x12/0x30
> [  770.948985]  ? do_syscall_64+0x69/0x90
> [  770.948986]  ? do_syscall_64+0x69/0x90
> [  770.948987]  ? do_user_addr_fault+0x1d6/0x6a0
> [  770.948989]  ? do_syscall_64+0x69/0x90
> [  770.948990]  ? exc_page_fault+0x62/0x150
> [  770.948992]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [  770.948995] RIP: 0033:0x7ff1b293eba7
> [  770.949010] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [  770.949011] RSP: 002b:00007ffde3912128 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  770.949012] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007ff1b293eba7
> [  770.949013] RDX: 0000000000000005 RSI: 00007ffde3912210 RDI: 0000000000000004
> [  770.949014] RBP: 00007ffde3912210 R08: 000055d7dd4c9510 R09: 00007ff1b29b14e0
> [  770.949014] R10: 00007ff1b29b13e0 R11: 0000000000000246 R12: 0000000000000005
> [  770.949015] R13: 000055d7dd4c53e0 R14: 0000000000000005 R15: 00007ff1b29f69e0
> [  770.949016]  </TASK>
> [  770.949017] ---[ end trace e6fa0618bfa2f31d ]---
> 
> Built-on: Rhel9, Ubuntu22
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
> Changes in v2
>  * Moved the poll_enabled check in drm_kms_helper_poll_disable()
>  * Reworded the patch description based on new changes
> ---
> ---
>  drivers/gpu/drm/drm_probe_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index 3f479483d7d8..b9f07d5f999f 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -877,6 +877,9 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
>   */
>  void drm_kms_helper_poll_disable(struct drm_device *dev)
>  {
> +	if (!dev->mode_config.poll_enabled)
> +		return;
> +
>  	if (dev->mode_config.poll_running)
>  		drm_kms_helper_disable_hpd(dev);
>  
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


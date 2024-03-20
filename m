Return-Path: <linux-kernel+bounces-109453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1074D88196E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60493B24C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C185C7D;
	Wed, 20 Mar 2024 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pnJUoYR4"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68F52F78;
	Wed, 20 Mar 2024 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710973113; cv=none; b=Vf3uXsGSylCUxN9vUSmwHlGGkaMwCR6qezRlxEIZ9V2p1IzfSR0FBV/5OlQ/0M0po++w4K+AgERnTsEIaOgGqBA4f7AchJuylNgsysMmh9uxEjD/mPEKQovmwecXgfPI6tUXDshm/KPsejvRHekdF6OFzUeqBYY1uj3l6ziOiY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710973113; c=relaxed/simple;
	bh=6RCHskeT2RU1mpvpXM4MlikboPygYC9zP58QNF0vw+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKU3nUO5MA3W+oCjAyLdFC5oz/yaSNyy2VRKCEE6tzKV8GStOybmaGzS/d+YfGnUOc8r+190CFFoPqfv0vEqfmKETzI7PQ1K65ffxvqbHD5nqbdkUhV7sjb1Ndg3jLvoG4gzbcYBBX9rnhxrhabJJ2P0WO249DBfUFtJqJ0dyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pnJUoYR4; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710973112; x=1742509112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KeocE86M7cxnIG2egIo+ph/Sy8YD4j7ADzzQLHu2U8M=;
  b=pnJUoYR4/ZlGLU8VhaNNZ90uaaR5JVQfKspAaOG7LgnxeyDDLULqx0kZ
   pIX6CDWU4hDw7RT6npfY3aHw/DjZ9Gl+430Pc9TzUtnlWyj2pkQ1kOKbr
   xZvw015XT2NBXQhcr31IuirdDP6R1gZCJCl28QUyhF5oQFeWe7Jka+H0O
   8=;
X-IronPort-AV: E=Sophos;i="6.07,141,1708387200"; 
   d="scan'208";a="281588042"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 22:18:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:55675]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.15:2525] with esmtp (Farcaster)
 id 5d501bbe-28c3-4f65-9498-0173a723cae1; Wed, 20 Mar 2024 22:18:28 +0000 (UTC)
X-Farcaster-Flow-ID: 5d501bbe-28c3-4f65-9498-0173a723cae1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 20 Mar 2024 22:18:28 +0000
Received: from 88665a182662.ant.amazon.com.com (10.88.162.81) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 20 Mar 2024 22:18:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <nicolas.cavallari@green-communications.fr>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH] ipv6: delay procfs initialization after the ipv6 structs are ready
Date: Wed, 20 Mar 2024 15:18:13 -0700
Message-ID: <20240320221813.11611-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240320171858.2671-1-nicolas.cavallari@green-communications.fr>
References: <20240320171858.2671-1-nicolas.cavallari@green-communications.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Date: Wed, 20 Mar 2024 18:17:36 +0100
> procfs files are created before the structure they reference are
> initialized.  For example, if6_proc_init() creates procfs files that
> access structures initialized by addrconf_init().
> 
> If ipv6 is compiled as a module and a program manages to open an ipv6
> procfs file during the loading of the module, it can oops the kernel.
> 
> It appears that we were unlucky enough to reproduce this problem
> multiple times already, out of maybe 100 boots:
> 
> NET: Registered PF_INET6 protocol family
> 8<--- cut here ---
> pwm-backlight backlight: supply power not found, using dummy regulator
> Segment Routing with IPv6
> In-situ OAM (IOAM) with IPv6
> Unable to handle kernel NULL pointer dereference at virtual address
>  00000000
> mt7915e 0000:03:00.0 wlp3s0: renamed from wlan0
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in: ipv6 mt7915e mt76_connac_lib mt76 dw_hdmi_imx
>  mac80211 dw_hdmi drm_display_helper imxdrm drm_dma_helper
>  drm_kms_helper snd_soc_imx_sgtl5000 syscopyarea sysfillrect sysimgblt
>  fb_sys_fops imx_ipu_v3 snd_soc_fsl_asoc_card cfg80211 snd_soc_sgtl5000
>  drm libarc4 snd_soc_fsl_ssi snd_soc_simple_card_utils imx_pcm_dma
>  snd_soc_core rfkill snd_pcm_dmaengine snd_pcm
>  drm_panel_orientation_quirks cfbfillrect cfbimgblt cfbcopyarea
>  snd_timer snd egalax_ts snd_soc_imx_audmux soundcore flexcan mux_mmio
>  imx2_wdt mux_core can_dev pwm_bl
> CPU: 2 PID: 850 Comm: snmpd Not tainted 6.1.14 #1
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> PC is at if6_seq_start+0x2c/0x98 [ipv6]
> LR is at init_net+0x0/0xc00
> [...]
>  if6_seq_start [ipv6] from seq_read_iter+0xb4/0x510
>  seq_read_iter from seq_read+0x80/0xac
>  seq_read from proc_reg_read+0xac/0x100
>  proc_reg_read from vfs_read+0xb0/0x284
>  vfs_read from ksys_read+0x64/0xec
>  ksys_read from ret_fast_syscall+0x0/0x54
> Exception stack(0xf0e31fa8 to 0xf0e31ff0)
> 1fa0:                   b67fd0b0 be8a666b 0000000a b67fd148 00000400
>  00000000
> 1fc0: b67fd0b0 be8a666b 00000001 00000003 be8a67ec 00000000 b6d7e000
>  b6c9954a
> 1fe0: b6d7eb30 be8a6638 b6ef11b4 b6ef0ddc
> Code: e5931004 e35100ff ca000014 e59e25dc (e7920101)
> ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


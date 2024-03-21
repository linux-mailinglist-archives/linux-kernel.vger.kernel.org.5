Return-Path: <linux-kernel+bounces-109540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77D881AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041C41F21C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F34A1D;
	Thu, 21 Mar 2024 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBi/3e+r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420FEC3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710984992; cv=none; b=eZu2wqhj1/hx9dQ2X5mMYMkSdickLZ4aXCoqQXeke6njLg6bZLY+c1ilZ9XMIAsTFF2CeJz7HOZbkdqhk7XwE8c05zKMxKN8Up7yVpOzXb3uNkcY7eQ5O5NjSwUwgDKVdTaUwKFwwJXuTsnKki5LUvynI7+lr/3cfqK4A0T/CqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710984992; c=relaxed/simple;
	bh=7VkvRogsC1DlJ9ZCQtEG9aRl90Whrc+CFOdxK7Eaddo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZWflPrBRLdcH+ULTENazEzrOFSdyF6koWDSxJf7PLOwyD3XSUwLtslB6mguM+2pR46r3T0IKPr+JCwdzBjkpxz6tJw1Q9Fb/4Y5MAHJmF1mJ3TC/sXN39mt5417QQY7gdYWa1hrJuXDcM3/YDBy6awNTJMETvYkTKdFpDosVjs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBi/3e+r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710984990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zLQEXqBep038/fndbOqYRXUu8u8+wrifOJGOB/c+1L8=;
	b=FBi/3e+rwusNTABzJ9OOLkCjvTdYPQbRWFknlchUY0MZYUBsJxPe0OkQE5u6KBOnLc+Xab
	m2UQsMueMri1+UCE5JIX3v3pfdifRqEuWIN+gLFuR63i54rsYwwM+dNzSCywwn7Dj8b7WC
	kXVi549lpMJdCSTVk4TZuAIlgj/Y5jo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-nsz6EhfiPMSRKryLhVgGvw-1; Wed, 20 Mar 2024 21:36:27 -0400
X-MC-Unique: nsz6EhfiPMSRKryLhVgGvw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c38d5fc6e0so519202b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710984986; x=1711589786;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zLQEXqBep038/fndbOqYRXUu8u8+wrifOJGOB/c+1L8=;
        b=EhryJLOUX0dh3xFzefqndc29Z0yLP1tBh7+77/IzmauDMmMR/yw4PEiq2IOTtUAw+x
         5dzklry7jZiQB3aZcnOBgLVo0uO3ovuC4OnAwXOWwWWkLR03QFJsAR4kn6bo+b93/7b+
         uoLcaQkz1ea+fb4bP+urd9bkTh4Qdw2m2hKdWd8IRujid/QKkqRoQqRzeLgabXHDgirf
         FUmIt/qDxsNUpx71J6R8PYwU4Byz5SgckZrr3vbvzrrDKOZKW2csDSFOqzYbVZK1o14T
         yGnecRDd7dzVMswSIjQFdWAR1Ka6ldW/UOUsg41Lyd6jBF93HHMnxRYH7w+h6qSTq7YN
         ab9A==
X-Forwarded-Encrypted: i=1; AJvYcCX5FQGOWpmmDmmByR23PXFJw+HARWicPffQOKV9JBhkN+WrSf5sUcJVHe7ffNb6Exktrl5aYjauKLC2h+pkZsa7bb/Bh2oBXgcnPw38
X-Gm-Message-State: AOJu0YylAi0H4YuF3foZxdjPs6kE0Si04HZJghSLlO6jVYU0OyTld1Vj
	UyL7DuzZW0/UW/CmXY/VMjvfoTc61hQ3Hz5RSwQx9ElJ3vqgdgWdSR2YVTuha557ZkZ/nYToL/X
	36kSIfNsGeg47myF5xvKWhZW/poKLjOJkDmXw0Yw0egnbpA2CjvTUOnt42hvLEw==
X-Received: by 2002:a05:6808:23c8:b0:3c3:882a:a874 with SMTP id bq8-20020a05680823c800b003c3882aa874mr12868661oib.5.1710984986359;
        Wed, 20 Mar 2024 18:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvpOAEjidxxnm9g5v1ek+06XqJIRZ1NeXBKttMUFfjx0y0CxF+IjoOGV02PelwsXUui8j5nw==
X-Received: by 2002:a05:6808:23c8:b0:3c3:882a:a874 with SMTP id bq8-20020a05680823c800b003c3882aa874mr12868649oib.5.1710984986098;
        Wed, 20 Mar 2024 18:36:26 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id fm4-20020a056a002f8400b006e669357e83sm12286869pfb.189.2024.03.20.18.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 18:36:25 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:36:21 +0900 (JST)
Message-Id: <20240321.103621.1433494402179493599.syoshida@redhat.com>
To: nicolas.cavallari@green-communications.fr
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: delay procfs initialization after the ipv6
 structs are ready
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20240320171858.2671-1-nicolas.cavallari@green-communications.fr>
References: <20240320171858.2671-1-nicolas.cavallari@green-communications.fr>
X-Mailer: Mew version 6.9 on Emacs 29.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 18:17:36 +0100, Nicolas Cavallari wrote:
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

The following tag is needed?

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Also, we should put appropriate prefix in the subject for netdev
patches, i.e. "net" or "net-next". As for this patch, I think
appropriate prefix is "[PATCH net]".

Anyway,

Reviewed-by: Shigeru Yoshida <syoshida@redhat.com>

Thanks,
Shigeru



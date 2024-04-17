Return-Path: <linux-kernel+bounces-149249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C018A8DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F44A1F2121D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0594CB45;
	Wed, 17 Apr 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbRNdcsp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F74AEDB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388910; cv=none; b=agkKWsq6FOFP5MQj5B2L+wSed7bCow49zubH+mWByVKIHmPQ89lJ9UOQaEA3Q6nAJCFHm8gmOj5r4VESC4Nm8RGkmqgxx2Ti5CAZovt1QYcXiJjVkWYqhzsPlmZ9HLjG+3C03JQscu/RS0oKiWwwMz1+C4K5LaLliMi+rsf8J68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388910; c=relaxed/simple;
	bh=5Lp35deZDRZlLG29EyyXARS2LA/ATg+JFgm5i41SOgg=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=BVbjKe9h9JUFbW1UY11nX4vjf6GYWpHY/rk6ixRtjp+XxtsWRM6cZ63pgE4QiIioS40kUbEFxHvaR1F72Wtt9njjT3ZxlefKuqdf1BIQ20P5Cnxoakjo+ZslNqjS5X9c2PfjSLm91bH9rBnyqoSEcQIVqv/yYa3RLbuUbH7XFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbRNdcsp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713388908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=qk5Z+ed5pzlWJq0eqk2WAXuOeBW1M/MKlcXS71AjFzU=;
	b=QbRNdcspRgmWIzmSodmobISegEhRcGvDXQC8omnR+YuwOeDh7cIGaPxWJmJnbXG5WiOUSX
	ZW9nSBjXicX+JhmD1fkLK0tZhQwkagOxu8N9NoN57KYIm56HwtIIMnP4sWdZ5l7fOyaqHG
	vNIlrkq8Cnc7hb0gmHXRf7f1lh3eHrA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-9_eWsnZKM82JPjuAMeTwzA-1; Wed, 17 Apr 2024 17:21:47 -0400
X-MC-Unique: 9_eWsnZKM82JPjuAMeTwzA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5e2b1cfabso26478439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388906; x=1713993706;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qk5Z+ed5pzlWJq0eqk2WAXuOeBW1M/MKlcXS71AjFzU=;
        b=pkUc/k12E7V0nYeMVXGdUrwD3OH6iWfxXOtMmLpv/XvWwJm455sCcA2Q+hx8aAjQOw
         5U8VKZUkyRW+ZhLE37R+fR0vA3CRqfPeSvser+5GEeugrfJ1lJXIRdZlH8oesWkxalB6
         QwIKTP7w6AyUBqRL4srF41O0HnmY1AJlhS5nQJTFIwUt+Klfr1JSiHK/ys7RwWYfOqLY
         C3TXbaG6b6k2caCdMPiV93FmQb+Va+0XTrHgPUmjQ/UbDs2FW9mfdvrveDUg4+vMRPqE
         lGK3n2aLFRNPWdJUWiCOaFG8NKguJKDJJd4Viq9hRo2ZxP4erxqIi1jzaRVi/jyr5HyB
         w9qg==
X-Forwarded-Encrypted: i=1; AJvYcCWmnqVx6C6mICEpf2eUHIn3a8swGFRoTX0+6EmHnZ4e22nxy85pe1Iw/QJPCsl9LWz+wtjC5FdDz78TyvG08HZPYSZyJAkKIUWNSSwx
X-Gm-Message-State: AOJu0YzKYDvF/u6DIlkppyfx2RWfiQ/BisyPr3VLhnjleNLd7eTjcJI8
	90J8aEsAHTnQv/jxn5LuCmswK+bBxw4wQ/GXj3zcUXqkP5haYQnBz6IN+EjdNI0rCMfqjkDhE9m
	fvKeBV8Axm7n068oIkONF1fcrGj8u5UrGCHKemjaNjLsb9rETSEbiMssOHsMvsQ==
X-Received: by 2002:a05:6e02:1d8b:b0:36a:1fde:a3b6 with SMTP id h11-20020a056e021d8b00b0036a1fdea3b6mr902173ila.30.1713388906184;
        Wed, 17 Apr 2024 14:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUEyPJo5A3M04fS8gQHlcYnbob5P5fnZXeNAp2gip9ftqcZTcPJYIB7Uzse9mwcCfffErD4Q==
X-Received: by 2002:a05:6e02:1d8b:b0:36a:1fde:a3b6 with SMTP id h11-20020a056e021d8b00b0036a1fdea3b6mr902136ila.30.1713388905486;
        Wed, 17 Apr 2024 14:21:45 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::789? ([2600:4040:5c6c:a300::789])
        by smtp.gmail.com with ESMTPSA id c14-20020a92b74e000000b0036b1201d991sm10855ilm.17.2024.04.17.14.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 14:21:44 -0700 (PDT)
Message-ID: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
Subject: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
From: Lyude Paul <lyude@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)"
 <bp@alien8.de>,  x86@kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 17 Apr 2024 17:21:43 -0400
Autocrypt: addr=lyude@redhat.com; prefer-encrypt=mutual; keydata=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
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi! I just wanted to let you know that one of the desktops I use for
testing no longer seems to boot after this commit (just finished
bisecting and confirming). The machine hangs before it gets to fbcon,
and the error I'm seeing in the early boot console is as such:

   Kernel panic - not syncing: timer doesn't work through Interrupt-remappe=
d IO-APIC
   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc5Lyude-Test+ #20
   Hardware name: MSI MS-7A39/A320M GAMING PRO (MS-7A39), BIOS 1.10 01/22/2=
019
   Call trace:
     <TASK>
     dump_stack_lvl+0x47/0x60
     panic+0x340/0x370
     ? timer_irq_works+0x67/0x130
     panic_if_irq_remap+0x1d/0x20
     setup_IO_APIC+0x82d/0x950
     ? _raw_spin_unlock_irqrestore+0x1d/0x40
     ? clear_IO_APIC_pin+0x16c/0x260
     apic_intr_mode_init+0x5d/0xf0
     x86_late_time_init+0x24/0x40
     start_kernel+0x673/0xa90
     x86_64_start_reservations+0x18/0x30
     x86_64_start_kernel+0x96/0xa0
     secondary_startup_64_no_verify+0x180/0x18b
     </TASK>
   --- [ end Kernel panic - not syncing: timer doesn't work through Interru=
pt-remapped IO-APIC ]---

Assuming I copied this over by hand to my computer correctly, the
decoded backtrace should be:

   Kernel panic - not syncing: timer doesn't work through Interrupt-remappe=
d IO-APIC
   Hardware name: MSI MS-7A39/A320M GAMING PRO (MS-7A39), BIOS 1.10 01/22/2=
019
   Call trace:
      <TASK>
      dump_stack_lvl (/home/lyudess/Projects/linux/worktrees/nouveau-aux-fi=
xes/lib/dump_stack.c:107)=20
      panic (/home/lyudess/Projects/linux/worktrees/nouveau-aux-fixes/kerne=
l/panic.c:344)=20
      ? timer_irq_works (/home/lyudess/Projects/linux/worktrees/nouveau-aux=
-fixes/./arch/x86/include/asm/msr.h:186 /home/lyudess/Projects/linux/worktr=
ees/nouveau-aux-fixes/arch/x86/kernel/apic/io_apic.c:1595 /home/lyudess/Pro=
jects/linux/worktrees/nouveau-aux-fixes/arch/x86/kernel/apic/io_apic.c:1634=
)=20
      panic_if_irq_remap (??:?)=20
      setup_IO_APIC (/home/lyudess/Projects/linux/worktrees/nouveau-aux-fix=
es/arch/x86/kernel/apic/io_apic.c:2241 /home/lyudess/Projects/linux/worktre=
es/nouveau-aux-fixes/arch/x86/kernel/apic/io_apic.c:2413)=20
      ? _raw_spin_unlock_irqrestore (/home/lyudess/Projects/linux/worktrees=
/nouveau-aux-fixes/./arch/x86/include/asm/preempt.h:94 (discriminator 1) /h=
ome/lyudess/Projects/linux/worktrees/nouveau-aux-fixes/./include/linux/spin=
lock_api_smp.h:152 (discriminator 1) /home/lyudess/Projects/linux/worktrees=
/nouveau-aux-fixes/kernel/locking/spinlock.c:194 (discriminator 1))=20
      ? clear_IO_APIC_pin (/home/lyudess/Projects/linux/worktrees/nouveau-a=
ux-fixes/arch/x86/kernel/apic/io_apic.c:563)=20
      apic_intr_mode_init (/home/lyudess/Projects/linux/worktrees/nouveau-a=
ux-fixes/arch/x86/kernel/apic/apic.c:2330 /home/lyudess/Projects/linux/work=
trees/nouveau-aux-fixes/arch/x86/kernel/apic/apic.c:1374)=20
      x86_late_time_init (/home/lyudess/Projects/linux/worktrees/nouveau-au=
x-fixes/arch/x86/kernel/time.c:101)=20
      start_kernel (/home/lyudess/Projects/linux/worktrees/nouveau-aux-fixe=
s/init/main.c:1035)=20
      x86_64_start_reservations (/home/lyudess/Projects/linux/worktrees/nou=
veau-aux-fixes/arch/x86/kernel/head64.c:543)=20
      x86_64_start_kernel (/home/lyudess/Projects/linux/worktrees/nouveau-a=
ux-fixes/arch/x86/kernel/head64.c:485 (discriminator 5))=20
      secondary_startup_64_no_verify (/home/lyudess/Projects/linux/worktree=
s/nouveau-aux-fixes/arch/x86/kernel/head_64.S:459)=20
      </TASK>
   --- [ end Kernel panic - not syncing: timer doesn't work through Interru=
pt-remapped IO-APIC ]---

Happy to provide any more information from this machine if you need it
:). And hopefully i'm not just late to the party and reporting a
regression someone else found already lol

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat



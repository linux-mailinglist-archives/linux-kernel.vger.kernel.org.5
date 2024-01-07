Return-Path: <linux-kernel+bounces-18871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175BE82643B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E2B1C2146F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B8134AE;
	Sun,  7 Jan 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="BXatm94l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17336134A9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 4077 invoked from network); 7 Jan 2024 14:16:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1704633419; bh=OFKash0VFKlhL0rGRyyvHVzIeY5+bCfvSPY6mx7l+kE=;
          h=From:To:Cc:Subject;
          b=BXatm94lwnQYv+Tm3kIsoJfMSgpl1qGJpZIzTkRMML0usKl5syaXCdwUu7GOqiUik
           n1oiZ0CFziKBZg5Mt+G+ni6eH362ojaRuT8X1p8xLfGntk/vLBGNn9UiTpWA11BOD4
           4kljKF3R13bV03Yj/TDq+MT1sClZARNqurRnqWvI=
Received: from public-gprs183174.centertel.pl (HELO mocarz) (deweloper@wp.pl@[46.134.54.199])
          (envelope-sender <deweloper@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <deweloper@wp.pl>; 7 Jan 2024 14:16:59 +0100
Date: Sun, 7 Jan 2024 14:16:57 +0100
From: Aleksander Mazur <deweloper@wp.pl>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Aleksander Mazur <deweloper@wp.pl>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/Kconfig: Transmeta Crusoe is cpu family 5, not 6
Message-ID: <20240107140609.2c1709e3@mocarz>
In-Reply-To: <1517697968-19014-3-git-send-email-tedheadster@gmail.com>
References: <1517697968-19014-3-git-send-email-tedheadster@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 45f78151cf98efbfa5f073ca941613f7
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [UeNU]                               

I found out I am no longer able to boot kernel compiled with CONFIG_MCRUSOE=y on
my HP t5300 with CPU: Transmeta(tm) Crusoe(tm) Processor TM5500 (family: 0x5,
model: 0x4, stepping: 0x3). It says:

> This kernel requires an i686 CPU, but only detected an i586 CPU.
> Unable to boot - please use a kernel appropriate for your CPU.    

It looks like this is caused by 25d76ac888216c369dea91768764728b83769799 which
started setting X86_MINIMUM_CPU_FAMILY=6 for MCRUSOE while CPUID gives family=5.

I was able to fix the problem with a patch included below. It just changes
X86_MINIMUM_CPU_FAMILY to 5. No other change was necessary (using -march=i686
seems fine).

/proc/cpuinfo:
processor	: 0
vendor_id	: GenuineTMx86
cpu family	: 5
model		: 4
model name	: Transmeta(tm) Crusoe(tm) Processor TM5500
stepping	: 3
cpu MHz		: 532.091
cache size	: 256 KB
fdiv_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti constant_tsc cpuid
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit mmio_unknown
bogomips	: 1064.18
clflush size	: 32
cache_alignment	: 32
address sizes	: 32 bits physical, 32 bits virtual
power management:

--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -375,7 +375,7 @@
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
-	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
+	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7 || MK8)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
 


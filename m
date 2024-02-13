Return-Path: <linux-kernel+bounces-62768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B185257D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A6C1C225B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F7111AC;
	Tue, 13 Feb 2024 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EN44tbkX"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64644BE49;
	Tue, 13 Feb 2024 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784934; cv=none; b=GWz3aaNYTzMdrOGnolhZopuV+rqeMsKJ5eFZbJCnLIBOo/KmV5ult/Bq13u+DHo5n71wCEVoIbMmEGLVKJF7GXhhs9h2x4lKUSpcdCS5nEnQiuNFAv9YHA2OvfZ4gTvSrHh6IUbRf75OwGHjqfIFd5Ee9eeVYzm9lETGwKGIWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784934; c=relaxed/simple;
	bh=UfhGyuSgD1Vwy9T7LqkIR0IJQBem4hE+uypmbddgxmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvTsV8rLifieof8ENGYophv/faq7q+F8MfpjvEXOQErcEN+60nV7hSulau4LoavuJuBTd8Y+mNb9NCmPTJwukiwdB027y5cGyg+Upg8qYtUlneEYIICyoS3T941V/gt5O5LsihZM9+7+Afxr69nZ6bOUHikG0aHi20QyIwCt7EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EN44tbkX; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707784925; x=1708389725; i=w_armin@gmx.de;
	bh=UfhGyuSgD1Vwy9T7LqkIR0IJQBem4hE+uypmbddgxmo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=EN44tbkXgslJoN7Gj9PmMBA9aqGKXgJIWbP2TTP1fnulwYbXgruW2lqBbjs+avfp
	 +j7d24x1R5dSZUj6e7jn5vW0TyuTqGQ0GJDM1XC0SulK/IdsSwAuP3A49lDmUyLf2
	 uoHKYOuJwnbRQYMPdO3oF5iS8zDsGoY8na2TI12GicFCao83nBsCBp9+gaI2la9t0
	 jRhrjB22wf+iRGN/MfA+6vBIYK78zTAuc2W66LAjYBguqJlQdyFdwfFkvHpAVUE6B
	 OE8AGYXHRd1JrizO5HmOZG/WK8G7HkhDCNzRd/vdUCZVkdcypPEIPUfLecC6UKbZP
	 aZPCJ+qQfvJ8PYG3yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mf078-1r1ybv2WD4-00gZLh; Tue, 13 Feb 2024 01:42:05 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: processor_idle: Fix memory leak in acpi_processor_power_exit()
Date: Tue, 13 Feb 2024 01:41:58 +0100
Message-Id: <20240213004158.3623-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w4T+Xb8F8M55zcrM+ojZL6fOe4erjAQZ72EXMTzDt6DVWKxzuSd
 BAIJJIihvA/EPPN3vJPWg/bkD1jSoxLf0BHnTpiXrg+xmkp73QL5qXB0s8vjXMSE6/LaG0j
 lyCstU7g29duqaWVyg7ASktOMu3oQoWi0aNaVqZh0/kjWHhTV7dA9j+5i1qO3PEdrqbUWtw
 /YSxio7/2sJm6SuPD6CJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TVkxfA66A2s=;qeVHllrP6T7eVIEMvB02Gsm683J
 ReRVPNPNTufbA3KYX1JtMQ4AnmGKiMS9Ujg25xl7hdxafUl5jnOhlKF94Dk0WdhTd3zS5//rB
 9BX+XADt6ZAYZndFt+I7+gpT1cKp2iroALMT2QpmJleCDcTx6l7nJWWlFyRI1AiFbNJZXG6zq
 KMYkHLbt9UVukWcesQiksqLf9GtjhmUefKF9q/X5JWuNMfVweXRYZ1b28EvLdHbayDIWSFow7
 KYQDNF0iXaQNP2DF4x1Ottj/RnjB8BI1PCrdalPLjI33xNPsR3Ph6ml5T2+3rHV4o677dIkSx
 IWMicHHg5lKMUraGCeMBZnINWy5WToFFrqa3BpuiLD3KHDacULCGyo94PHpRyUEurUOj53zmi
 bF/unPFSroJLR7HygJEFFkaMZJIJsWGKgO3r7eERzhs6gznyZj8axTLgHYzevaiQD80oXaz/w
 n5IQQMQcrivcMFV1XgSnQdL6w0lEZJyj58pbGtZVIra3ytpfoxUcrVwtTjVG0CTCaMWu9pD/I
 zM6Uwsin+pUIrSnxtz7xdrNLpgtvfiIRity1OUaN7MN/dQ65QlnRPuguNxUg6W3B8S/JceMDn
 Wem2UHC66xsCls/2IeAlBbkFnybD6pDsBM/L9ZjKcVVXgY5BF9xC1Rcxy1CbY9QAPb1ANqs7H
 9bw48ob0hg6tXtq87rMii5vD9ZfHrXfq2CGXtPz7OvNw7la/KslltHLPNpEuhRsUH5nutUdI9
 ZnpWBedY5Mi1YrvH3E+SUBMvW9DbQ3R2nZNE9F6R9wJwPwFbUBw0bGExH2JkEuLrksbodosXI
 4H9eSCn9GRF8Z0NY3jx3GPe8Dyye3ctEwmVa6VtslsAOs=

After unregistering the CPU idle device, the memory associated with
it is not freed, leading to a memory leak:

unreferenced object 0xffff896282f6c000 (size 1024):
  comm "swapper/0", pid 1, jiffies 4294893170
  hex dump (first 32 bytes):
    00 00 00 00 0b 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8836a742):
    [<ffffffff993495ed>] kmalloc_trace+0x29d/0x340
    [<ffffffff9972f3b3>] acpi_processor_power_init+0xf3/0x1c0
    [<ffffffff9972d263>] __acpi_processor_start+0xd3/0xf0
    [<ffffffff9972d2bc>] acpi_processor_start+0x2c/0x50
    [<ffffffff99805872>] really_probe+0xe2/0x480
    [<ffffffff99805c98>] __driver_probe_device+0x78/0x160
    [<ffffffff99805daf>] driver_probe_device+0x1f/0x90
    [<ffffffff9980601e>] __driver_attach+0xce/0x1c0
    [<ffffffff99803170>] bus_for_each_dev+0x70/0xc0
    [<ffffffff99804822>] bus_add_driver+0x112/0x210
    [<ffffffff99807245>] driver_register+0x55/0x100
    [<ffffffff9aee4acb>] acpi_processor_driver_init+0x3b/0xc0
    [<ffffffff990012d1>] do_one_initcall+0x41/0x300
    [<ffffffff9ae7c4b0>] kernel_init_freeable+0x320/0x470
    [<ffffffff99b231f6>] kernel_init+0x16/0x1b0
    [<ffffffff99042e6d>] ret_from_fork+0x2d/0x50

Fix this by freeing the CPU idle device after unregistering it.

Fixes: 3d339dcbb56d ("cpuidle / ACPI : move cpuidle_device field out of th=
e acpi_processor_power structure")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/processor_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 55437f5e0c3a..bd6a7857ce05 100644
=2D-- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1430,6 +1430,8 @@ int acpi_processor_power_exit(struct acpi_processor =
*pr)
 		acpi_processor_registered--;
 		if (acpi_processor_registered =3D=3D 0)
 			cpuidle_unregister_driver(&acpi_idle_driver);
+
+		kfree(dev);
 	}

 	pr->flags.power_setup_done =3D 0;
=2D-
2.39.2



Return-Path: <linux-kernel+bounces-89513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09086F166
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568D01C20936
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211B22627;
	Sat,  2 Mar 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="cIYAs6Wj"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5DEDC;
	Sat,  2 Mar 2024 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398050; cv=none; b=HUiTsD7bdKQbSQNX6IutOCZZFIGuwidy+r3btfXwhe/+WpsiG/ksnurcUrIYGlSxP5hd5/E2JOBBShY3PxxCdfMRPXJJPHZafaMl5kHdUOFhnS2I71R6XFuNhu6ngQsS24Gy+ozP8pvpWclFsVOb8sSidmWPO/o8OOpkVrf+M34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398050; c=relaxed/simple;
	bh=Gph6qqwfVdUGJw8HM5BtazzCGrYTiBgr/2QriesNWbI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T1fHvGJ9/CTl0aZmCI9xDW28K5Ce81ZyMPNBRHyXjKgAr6haNOqbPdRnzm7yit+SNGEbmdMvjiurAVoHupoguaNCr8gSN9rixrnYO+P2+6ZPMcsD81uC5hDzh/lXLxTbMN5v7waWmg92Bcca3tOiHr1/e9Hl8l+beBvZsfEulLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=cIYAs6Wj; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c83b2c59d7so15439239f.0;
        Sat, 02 Mar 2024 08:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709398048; x=1710002848;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5udyM8rVFnsV5+mNSVMzGQqpXPdKlsvvHE9LVo0y7GM=;
        b=cKT824zqMr+0NEjxSfQI26+/plu5TGb1DnXPcpvgog4BNZZBCFL3dGHmzv8ttCKg1H
         clL7QVyyb7GFuqfPhaZHIaGjaizy763/RyWZ3IlbwqSMFmXDotzsdMMfuU15Rqy+NwlT
         RLOLj4v4/6yw+bOSFLM3sjwG9sdliMFveGnLagHyb2m6TNBx9FAIfQdA5b75wJk33hYx
         FBm92bz1vTWLjRVBJyjE9D85Q0Cagv1ULr+6XPt5bY1wKqGC2ET/nDPRQ3DJhwqTpS3f
         ga3dIllhH4fB3cMQUY1eU/1FYeYjBkPKrF/KRXGjeeFHDjILqdE0NKdkENAQ0XT3QeVB
         6yOg==
X-Forwarded-Encrypted: i=1; AJvYcCUteZ0zFvEmZUom5VHtAY2ZB1pmq6kHkFYROW8tBTeOnNJv1HhfM3dnYmGXGGIZz9gIVMKnqke6uU1hT+MUhmvJDXQtOAbg9FMEgaa7
X-Gm-Message-State: AOJu0Yzmn283CqSWis64tJBpeimcttbN8z/Q8ltOr4G1t313O4K81Bfq
	4B2HVx/uHyOVz4u7xk7KROOmj4qcKopYAbVYPyx4zdq9mGcYei6c
X-Google-Smtp-Source: AGHT+IFuVOtsgQ1eXpQ17x0jb42z0NEi8b1ZhsVZJP8whWE3Xcq8VgZiPf0+xmYbCLjkxLZsCfzhdA==
X-Received: by 2002:a05:6602:2cc9:b0:7c7:fefa:6739 with SMTP id j9-20020a0566022cc900b007c7fefa6739mr6719772iow.17.1709398048089;
        Sat, 02 Mar 2024 08:47:28 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id t24-20020a05663801f800b00474e5300945sm38262jaq.11.2024.03.02.08.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:47:27 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709398045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5udyM8rVFnsV5+mNSVMzGQqpXPdKlsvvHE9LVo0y7GM=;
	b=cIYAs6WjG/h2zIuGUtiSVaJzY/WbmvVZA58Q2zKw1o2IlAaOrCTnFxb5YWHvtaF4k4Nwk4
	26eiY+RDRxGUoupPiycwphmeDw5nfn+l79kHt3bJHI8sN3Wnqyps6L1q700vkrN5rzcJR5
	2EiMQQ9S1RqLGHqclbF+JgZX2vNKKOghV1qe9hYLh6z2DfPPqTZl96OYj56bzPbw3p9zU8
	SOUdzimzkI6oiMz4WKKAmzmReQdJAWLFLjP3go83OjVmHcvNhGdfAcRi1kggvPP5ZFTK6D
	MXvyu8RdZfENnfqPEFaQkRanOxy00bmQkr5vPFDYRXru3M6Ozaw4rPRbfMMJYQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/5] scsi: constify struct class usage
Date: Sat, 02 Mar 2024 13:47:21 -0300
Message-Id: <20240302-class_cleanup-scsi-v1-0-b9096b990e27@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABlY42UC/x3MQQqAIBBA0avErBNMM7CrRITZVANh4VAE4t2Tl
 m/xfwLGSMjQVwkiPsR0hoKmrsDvLmwoaCkGJVUrtVTCH4558ge6cF+CPZNYtW1NN1vTGA0lvCK
 u9P7TYcz5A5hFqzZkAAAA
To: Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 "Manoj N. Kumar" <manoj@linux.ibm.com>, 
 "Matthew R. Ochs" <mrochs@linux.ibm.com>, 
 Uma Krishnan <ukrishn@linux.ibm.com>, 
 =?utf-8?q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Gph6qqwfVdUGJw8HM5BtazzCGrYTiBgr/2QriesNWbI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl41gc/5ZkDPlDe19PR57vIQzeb0sAy8r64TxVt
 h0Q2pLlgYKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeNYHAAKCRDJC4p8Y4ZY
 pjf4EACksR57BmDID+IGUc5tT1m5SN04Gv1inQmQcERiaANIuWmq59V/LPoQ2AfruPzo1lhm0y6
 B80+OfWRh3A86AXfi94uQ2Kmu7sulTARFUxpzFpufWcjeCdyepWl/r5CKqV6WG1Pjw/m9n1jFKg
 692jV4Q6z9nuukLh04modDuWJZ+QUpgj0FiGaZi16rOdSwJaz0GyqfEIvlIj2yRzW9dfCY9LUKt
 bSCZDBImNpAWecRJ3l+pVHt3zBZq16wq+GI1jDfMWsuSH03RO+NZeUqEdN0j08ITxgr1GyVNDVj
 lA1vUy390v3X5m2p+1gSzXkV5qVkwhMKEVkQymPQDru16FyIf+UN6ytnqNUrA3byMDy3X0gxP2i
 3baU4/2Jhkn+UdWlLhJRfaPPMrlLDLxuYUtQ2b0FCfRQZKOAdNxjGd74C5siLM/AXm2bJyxurqx
 RY+h73voFWeo91MasIuEsa8Zf9fBGQy5CtKguMjnA567UQF7y4Vqh2ZaPxeSL1QOd4XwA8iXIzk
 NVikyIpvHLbhbuBNUoiPtAqMpf9pnkA7umK4OZIwtVdDv3G4+zRDV3cdGpKc1gAkeQWrUocpmXk
 t59vjLq88cRoYaG/mp7vH9Et26L+0z0aZaS0NM36mw114CtJ51/+14/hyippH39uBWWnfBkR47t
 uY3K06eZnttJ96g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that aims to make the
class structures in scsi constant. This has been possible since 2023 [1].

To: Doug Gilbert <dgilbert@interlog.com>
To: James E.J. Bottomley <jejb@linux.ibm.com>
To: Martin K. Petersen <martin.petersen@oracle.com>
To: Manoj N. Kumar <manoj@linux.ibm.com>
To: Matthew R. Ochs <mrochs@linux.ibm.com>
To: Uma Krishnan <ukrishn@linux.ibm.com>
To: Kai Mäkisara <Kai.Makisara@kolumbus.fi>
Cc: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

[1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Ricardo B. Marliere (5):
      scsi: sg: make sg_sysfs_class constant
      scsi: pmcraid: make pmcraid_class constant
      scsi: cxlflash: make cxlflash_class constant
      scsi: ch: make ch_sysfs_class constant
      scsi: st: make st_sysfs_class constant

 drivers/scsi/ch.c            | 20 ++++++++++----------
 drivers/scsi/cxlflash/main.c | 17 ++++++++++-------
 drivers/scsi/pmcraid.c       | 20 +++++++++++---------
 drivers/scsi/sg.c            | 18 +++++++++---------
 drivers/scsi/st.c            |  4 ++--
 5 files changed, 42 insertions(+), 37 deletions(-)
---
base-commit: 7b020ab8a0096db229749d6618b64659cf699331
change-id: 20240302-class_cleanup-scsi-f39456b95153

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>



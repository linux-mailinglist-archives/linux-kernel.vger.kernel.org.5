Return-Path: <linux-kernel+bounces-60563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF63E8506BF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B46AB25DBC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1EF60ED3;
	Sat, 10 Feb 2024 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUKAxGRl"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62E6025A;
	Sat, 10 Feb 2024 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602028; cv=none; b=Bs+tmTdGJSg1YlLc+MviRmhjCv/YQGArTI7ict0DzdkYm66DAZUAQgyasH0fjorIRppYA3CHx/+l3SBwznETnsT7vxzx1h/x7B6CER7ZENyNfmTNJZLfxMT8rGC+snTj9kxGkR100e8zUDCrpC94nIXDzNUCDUBBKcl8fQ9nFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602028; c=relaxed/simple;
	bh=GKHPriFTGNHkJD6qCXBjTKuOyNY0TWh2kPZjPAtk1i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S83I6tiByRcUxGP46C8FDZjWK7BtgHrH25PFRWwlORxnvoVEDob8CUlVTPa1PRfAx+ZiqW2OG/AQH7DwJy3X0bWh1CFTyoUzAZuteo/dFq4EK2J7OBN2BxXqc/eylHiD7mMdDP+Xhi3lFtNbQMhQZDLpNycWzWVeCsATfIfb9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUKAxGRl; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5114cd44f6aso2779411e87.1;
        Sat, 10 Feb 2024 13:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602024; x=1708206824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxIWnn2EO/cc0iUSZCRrpP4DP3wiDSt99iawfQ/4DlA=;
        b=LUKAxGRlcTatqTM50SmhK5rpPcdPqY8VR7eJwSCZrAHjnaG7uw4WWZh7GVGY9dBcDD
         PwM9YLpfEPpnmyrer/wULhAka+6i5SYDejMI37Vc7vhyPKIvyqgFJl5ovEQy+vbHDP9b
         edIHxkkjSGtvrcIAqHbMRUD+TxYJ5mE5Uy8kcoBR3bCcna/hd1rhLQ0ampzotbt305lK
         jXFcM9Rsmzz/Z4AjZbn4q6wmn4ZOKfsBM3VKL7DngVPMXQHgWWqEKS2eo+nzCDpF2MVm
         o/ii+l7MpLhkAkXnBSSzcqCKhwKmr+GWERt0TUbVC+Ga+eRkCSS0WfRbMrm8Gw6MakQV
         tMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602024; x=1708206824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxIWnn2EO/cc0iUSZCRrpP4DP3wiDSt99iawfQ/4DlA=;
        b=Q3KDLMAcRZ4jFG7fwwxGTlMMpZuafHod/s1bJhDz+pBEGydcmJhqpotxAXYa+6mBrz
         viI6tvZf20KuKcXKFVcLzoQpYPojvfSslrPVq89aPqY6mfKeYEeT388oksbsKNDXYflG
         m+gHvLJertT8Nh/vtQMiJv1j9AMFsXtL3/kGSMEazVGtMBXyyh9wkWD+RM2S/hZURo+9
         SseMx42tiyTMwydMRaI64X50GjSrhJS/NXJaq8cSrOavp5HNO7UprQslmgKw92FoF8Ez
         2fz9Pr24arr2mMDf/e5pgyMIBNxajyDbM+SdbTlQuTnWmksaD9NWE9KvF0j8knqi4X7B
         r7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVi3J1Kx/teE9CI6H65vfJGWYInVk/h0RL7zmC7njcvPwlHYAuHJwQkZB9GSuC6MhnsiV5YzM/lT1kuIvqZe9Xnzc+o8fE5DNbpDcyEy4/W7MFEUw8jWks7//rMgFVOk2ECPKI8q/IDdcU=
X-Gm-Message-State: AOJu0YxNWI4O6Vlo4ouiHFj7ajE4KYA3athcv05tdDV4YdgKyLodqKDY
	PQXCY4rGOlaSyJDcB1FhoHwJKJYjcg92NuvLAPWp+Xs+4PPhCKp6zBSn+SgH7+A=
X-Google-Smtp-Source: AGHT+IGKle2VNm91jTGJj07sy3SfWm+RoYOpG5m1dTgQmKD1QWaDIvFWDxYszIgBQzQ4VuJqkfydiA==
X-Received: by 2002:a05:6512:2255:b0:511:48ab:2f9c with SMTP id i21-20020a056512225500b0051148ab2f9cmr2295109lfu.42.1707602024091;
        Sat, 10 Feb 2024 13:53:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/ukWofMNAchS0pigBsSdKuxqPNzk0OIcYvZbBmxn4m9ipLFgCMbrfNSB0mI7NyGEKZwrLEZT2MvQRjtYfpEVSWVzP9zb1moNulAW70qn6Vk0uR+NQu/xtQRGbLvfhth2fF5rdxgZ2k0SImIbTI4UMJ9b4vuQCCGXzAaTI39g8mplIXlW3y67Ft/NXXGSq+fXDp0pWSEJArmBmeYT1/ph864LBawPyXWFwgyZNLufNnRFVSZpvPCc1OnuWplSj2NclWGfBgv3Eh/H1kVTv9BYdjDLtMWvVS9w5Qp4SCxu9eINZtnDft8wdKk/vVqAOvtnFNeL6oOkGD31uliCnY1Om3+KC5DHDx/8cN2ozFa9JRdZcgSl8KQ==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:43 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 16/19] hid-ft260: uart: suppress unhandled report 0xb1 dmesg
Date: Sat, 10 Feb 2024 23:51:44 +0200
Message-Id: <20240210215147.77629-17-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suppress the "unhandled report 0xb1" error since it's related to the UART
DCD/RI function of the multifunctional GPIO pins status, which we do not
use for serial console. The configuration of these pins is a part
of the GPIO patch set.

[ 5453.117113] ft260 0003:0403:6030.0008: unhandled report 0xb1
[ 6641.582307] ft260 0003:0403:6030.0008: unhandled report 0xb1
[13418.439085] ft260 0003:0403:6030.0008: unhandled report 0xb1
[14110.820786] ft260 0003:0403:6030.0008: unhandled report 0xb1

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 52ccee83250e..d7eb00aeb669 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1768,6 +1768,8 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 	} else if (xfer->report >= FT260_UART_REPORT_MIN &&
 		   xfer->report <= FT260_UART_REPORT_MAX) {
 		return ft260_uart_receive_chars(dev, xfer->data, xfer->length);
+	} else if (xfer->report == FT260_UART_INTERRUPT_STATUS) {
+		return 0;
 	}
 	hid_err(hdev, "unhandled report %#02x\n", xfer->report);
 
-- 
2.40.1



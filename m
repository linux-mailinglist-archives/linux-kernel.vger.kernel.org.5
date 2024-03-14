Return-Path: <linux-kernel+bounces-103687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F7687C301
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04A01F23A28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B675815;
	Thu, 14 Mar 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="tOeFAKIc"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFF1E480;
	Thu, 14 Mar 2024 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441965; cv=none; b=PH0lePPLSD07S23ht8Ywvhk5XQDPIK+Q+A7o0Tpytwy83gLHeWZ4EjhrE79YFz5VG94Z68kifK7PnbfaHCJbuqwegdKO0qJrO5X3eZ6LRKl87eagUWX7PDQi0k2FKz6KLVPDE2oSwWhm6pQst+UCzpI2Yq+TFaIEYjj2MYkKsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441965; c=relaxed/simple;
	bh=73pleJhpD+977gat83JtY6VoRHWs9PM2nlEgjX6dODM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wpuqdap1h+8wnaLfITTPaRIJbcQ01uVs3Gkg2FjgD2xnXvuoQnFVkot8T8GCSaDnz5ICBAejJsn/3KV9BOni+ZrMaKdhE1nj/+6JGHK5sReYubDHW2S5afh1WFHe75whdw+bi0OxquXrzykq4u0wzFQaBvDiA4lTyC4jbZw/m/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=tOeFAKIc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710441946; x=1711046746; i=w_armin@gmx.de;
	bh=OvYtfM9Idw423mYxqaNVgKEM4T4GduoNSCU/wC8Pn1E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=tOeFAKIcNUuva+vSuzovLT1LU0qxVMTnPiaEdPMWXhJj+htslM/O+UdVSMpeEv+m
	 jihiyUg1NkOjBBhM7SKSBN+YlFptq9mL/SgbOaffTxv2SDN6ApQpy3ibPAHu2hts6
	 VDXjGLmIhuhCNprVMKjc5E2fSv8t/9R5NBn4bw+d46w2OtzTWFjR2T2jzCjnEt4Zl
	 i1/9Vn1RJiiLzkQNv5xwLUwdj91S35c4skPiRx/BrdxOiSSu+YnrjGMQmZgkkiqR0
	 GIfAqif/9IoaGORWboecJgYZHm5LKtPWMXTZN3o9ZnbFP84/R/1t9ADJIk+QgbTfM
	 NCMWiG61eafr15sN0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mt757-1qw2iJ25Np-00tVY5; Thu, 14 Mar 2024 19:45:46 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	mario.limonciello@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] platform/x86: wmi: Avoid returning AE_OK upon unknown error
Date: Thu, 14 Mar 2024 19:45:38 +0100
Message-Id: <20240314184538.2933-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240314184538.2933-1-W_Armin@gmx.de>
References: <20240314184538.2933-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BzNMQR+CPawSYJ7irsf98oWrdE8WPnzPb/P+gCNQPTjfHVCjbVM
 sBffKxV7U5JJAsA2qjjJgo2UoAvtoIAtCTikGGpHdGJ62AHjsYs9+HhPwXoKtIt5BmlHQmH
 bW/cBV+1q9BSXPmH0qij/L4v1Cq9lMxRd7rjWQqz6PGZto2onpt2BiZf8bVPbKeCHgyNhyq
 MD2v1zTVxG+7idXZbqHFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vZGeaRnPzjI=;Zb46cEwHdsv1VGbzDtSrQBIrCQ3
 QnW/GtdlNUE5+tm7hfEQsdAHEWfwLgOt5IBpjoKHIbtqP+XlIgHKBQ78z59jCs44O1htJtjHi
 +cy1aRLIoCAD/Vvf2gM48WAfMmF+Pcvk1XcHtxBAWNcVng+qcgfcYFlroNQSdGbn/MBprp00g
 mVxilJlmcqPZZW7St2qvHebCpaxNbJ5y3yh2K8oFaaKf3T/bYhmcz5LBHOEpFyeUXsxZTqbYg
 h0ngJSHOPQ3fHm3Hd4vtu94seoDRQYa1MDsnA0QNV4A7CaHg8guLUzVnnp0UOm7JT0FB0TEjb
 jMQMgM0lLYjICObtwlsiiNoAnrBy0k0fhZSwFAM3mEnYiIlFo4WiXEikqW/fD7nroQKPA9USM
 QDzNqtOS3+0kjc67d3mC094ZZAmZrZaK1y29KEASQb+bKt9WOKLgdNSPj2Hp3UisWK42LGDve
 1ItLOi+v2p3wgkgWvwA2jZsp5qb/SRy3HQ+Cap+p++vXI9wwMrU3WIs5c3oRrm30m+zIN9/aY
 OU1HKh2Tsi7DPJGdhmZXEEWT2AljXPMkz27K46DpwU3KquxtcuJy+Kg8ued+G79deU9BbDb0S
 w+Fav4lhIY3Ky4wrSAtCk1a6RFFSKMvKY64yRcemKv3a8qnRLgCOYmNgWtNnHzUpiSUICpQp6
 onx1I+4tK4Gpf/fnHVJT5rAk6VBo8m8iJkvaHMTIByFnlwTTDLwdhFLEKenveq6gQaneonxc3
 0OC1xJiLOFB7DNRySrUy++fh9sr8B7TXFjN+U34rbx7Vojl+zmkUT4Ohhnm+VITZSi/SqgLKb
 0nzS09uaxhcQBXzvzdoxlaXVvuYy76vIPGQ9P5NjZ0oJw=

If an error code other than EINVAL, ENODEV or ETIME is returned
by ec_read()/ec_write(), then AE_OK is wrongly returned.

Fix this by only returning AE_OK if the return code is 0, and
return AE_ERROR otherwise.

Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.=
intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 9602658711cf..060e4236f932 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1217,8 +1217,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physic=
al_address address,
 		return AE_NOT_FOUND;
 	case -ETIME:
 		return AE_TIME;
-	default:
+	case 0:
 		return AE_OK;
+	default:
+		return AE_ERROR;
 	}
 }

=2D-
2.39.2



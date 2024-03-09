Return-Path: <linux-kernel+bounces-98027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45B8773CF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4990EB20EF5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D2524C3;
	Sat,  9 Mar 2024 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Y0B69+Lr"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E59C524AE;
	Sat,  9 Mar 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710015217; cv=none; b=H2bL5wJUx4KmBJoN1hwpLl63cuQoGfRVSFkvKXu6IHw8InQbMKFs1C/qhN64sZ1cBLz3sJBdxwtj4OeWrJ3kyvliOBkT3YE0RkqpPBtdHfZUthbsu3WkedOjDi7CQkcRk5qR/5nyLQC10qeFEh85xlrKdfPlCLUs6AGk11rROVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710015217; c=relaxed/simple;
	bh=h7As2GoZ0kc5nMuNQ2K/Q6VQcUC5YXNL19J+2NPAfT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oU8XSpftwdakSSkcivUtNcM66rPykqnH7IDxspCWY7XiK2ol3abg6AWJ/lAItle58zV0lluSxxePXLH13NNpTV4ezFrtGgW4qgZmuUtZLByTJ/Tc6f6CsckkhLcTC6qyVr9ncb6hdbzHjILCsLIOL0T1gcJS6E4Rl7xQt6cZpEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Y0B69+Lr; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710015209; x=1710620009; i=w_armin@gmx.de;
	bh=h7As2GoZ0kc5nMuNQ2K/Q6VQcUC5YXNL19J+2NPAfT8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Y0B69+LrJqT450AJgDoNJ1lR57FIalwYDCBeks71ZbMurg6Vq+L4lA1HhPsFKvTN
	 xj4cLgZoWv5sJGTNV+Zk4h6rPohJynXQnOzY76hJFp9Iya1hviRacFu4rAwBEsgrC
	 q1FUf5l3HQQeNO4ljIG9J+GNosKp9GuhK25f5W2xfu8ZvNjcN6UHY+SmLvcU8z98N
	 DZTy7ikihAFu9guX3VemAr81Ao7SZ57fcQaiA2sNUsadkBzY6Xy2pMmGCcuhtW8qw
	 cycBGM3LWQiT5qpz464ve4FUWg8Vk8wQsC3V7aIAUDLarGhGKBfwIsjgYQjPJx8hA
	 V3WpY9nujgFWG0uKdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MXGrE-1rKIFT1ZGQ-00YgdU; Sat, 09 Mar 2024 21:13:29 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ACPI: bus: Indicate support for the Generic Event Device thru _OSC
Date: Sat,  9 Mar 2024 21:13:08 +0100
Message-Id: <20240309201310.7548-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240309201310.7548-1-W_Armin@gmx.de>
References: <20240309201310.7548-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VM6+TPnokB3vj8sl1fSmOpeuD2WdF77iFdD1I6kvwdhRdIIEHCe
 7aQuyl5LrWwzDTfl36ttYa9wIQofVj2v9xw0JuiS3AAaWYHPYD1tqMTqh/p9T6kponFwDLD
 c457tU27/Rr4MTSM6rCMkHsku9ovYanaiDt6ZStMkXv1Bd2XHb/LEYbeoa+IIDVF1T5HEWa
 hWfrX83LAmbRZ9Td8ymdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qlVnVpWaAyw=;r7njhLsw6csIgn8JbulqJlfZoHq
 Bu02f3y2wImHuJwv9K5GaIkFs7j5Zx7hMlA9zX6R+ILHxuiEW11A86PapTo1NZ3QJrGEA3tsg
 rX1CJa4hf+MBUvAe57/8JS1o0+VmkKKMbig+LQRDVqsiZOViylKehaIJT2D7BYmk7sjUDQOGA
 BdjMyaeEy6NE4mZPJiMHf6No0mZafuqFP8G+YMUHHiXfrXPaAb7nKUZPn3XGfuuXwG14qlG+r
 K59pyrDiWk7fek/gDDP6kR+u4fWzoFNMuMvBCZ6Op5i8zq27ab4GvYU2BAfS+0RnOwEu1Bpvh
 Kv7EQ1MRRdultsUqQrGkffTndU/BjW7VuhBYdrlTanUaT+7jXRYAeon6Zvv0Ug8FsEOVMCfwz
 K9pHdPI2nGfEDIIdCHMkr+EpU4JJoK/cFaUwIQ2e5eOHHOtWS/49XYiRSHf+iQAhXxhZzfnAw
 j6+QUfym/WXh/WXkiwAFEcpX4qBKagTQ4HD0fP02sLnYsax2b0ezIBVfdV9DtIls1i+iRUVtH
 A6oNLHyN9FYVwr04X6QEjrVaad8FUZUrFHLwLobMkJShC/1exHNwSnLoMuAfE5XrIz+UyAMJG
 E+fqX/y+b2f1BQpjuxV1q75wiDygvOUi+erH4dLi/CYZnhcuUnE8yOu/HjDZc4aIyGQ0hyvzO
 OaQ7v+kWpG/Vj0A1F2TtGNByl1X9OsG9GopfWyQvxLrOWYb2BCLuOpdH70jA9fMtmN4u37PFK
 uW3GEakFnPR+swdPfd9+lqa4mdQvyJISQqAiwA6530H47GwPYV5H1Ub9FowptsA7l9qvcOR9k
 qy7sdCXfgKE4r426/k6suAq4BglFn/fKminTYgubksEcQ=

A device driver for the Generic Event Device (ACPI0013) already
exists for quite some time, but support for it was never reported
thru _OSC.

Fix this by setting bit 11 ("Generic Event Device support") when
evaluating _OSC.

Fixes: 3db80c230da1 ("ACPI: implement Generic Event Device")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/bus.c   | 1 +
 include/linux/acpi.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d5b0e80dc48e..0c48b603098a 100644
=2D-- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -322,6 +322,7 @@ static void acpi_bus_osc_negotiate_platform_control(vo=
id)
 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PCLPI_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_OVER_16_PSTATES_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_GED_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_PRMT))
 		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PRM_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_FFH))
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index baa07b5a717f..aa26259a28b8 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -575,6 +575,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct ac=
pi_osc_context *context);
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_FAST_THERMAL_SAMPLING_SUPPORT	0x00000200
 #define OSC_SB_OVER_16_PSTATES_SUPPORT		0x00000400
+#define OSC_SB_GED_SUPPORT			0x00000800
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
 #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
 #define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
=2D-
2.39.2



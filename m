Return-Path: <linux-kernel+bounces-91255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06CF870BCF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8B41C2258E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B358FBFD;
	Mon,  4 Mar 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="d16SegXg"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8AFBFC;
	Mon,  4 Mar 2024 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585426; cv=none; b=NIsRfgnQ2nhS2EVM+kWFRqyNgg6Eln8D/P1ILE8nLH6bFQeUC8wdRthJkQKFIRmeZd+w8KF+Pqah1e5Rxci9g8zhyEi/oiGnK3AzcL8m1zufndv1IHo8sjQDy6OWEWuKwLrBzyTLY7gTJIRD0I2ei8n+Aa/4aNz259S1bHI/GrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585426; c=relaxed/simple;
	bh=Tzw2KfuLD15TbMFuOFXHHB1XRezhD5nSZGMRaniwCjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lv9O9FzTG9h7W+DrbpnPszWDAbTPURWp//7SPQZw4lOdY1JlAlJHxzsaZO6NWWPLnHk1H0HnPnz9CjpdSmLd0RqBhXBdP0P1coItLM8YuYVNx3b6DYW6aWNySjyQf/d0724aCS19dzDLe5brdi/sx1MgIh0bFjiyTl1frFDLVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=d16SegXg; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709585415; x=1710190215; i=w_armin@gmx.de;
	bh=Tzw2KfuLD15TbMFuOFXHHB1XRezhD5nSZGMRaniwCjc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=d16SegXghKFTumuGkkSJx6f4RV1ky6fMQJybHZCObF8w4bmcMtMckIo0JtmaHa7x
	 HTunq/yFlXXLk/uuwsodyeXqk4Rink/EUAAqWQombfByYhlEUzQUvrGTNDjnIYCVp
	 Pe/27mip/vP46stwv8ZXmzeEGQPi9/6ona25taVv9ERcvyc68bPUFs38NqUkhj8Jl
	 Ayc4OxUotNHQq9ESKVsKzpSzh+0GcugNPlV/sOiOGiQfjqvgIscnVZA4WBkItkOog
	 yntuB29PubTtjxy1lpRZtdaQEsAcjV9SVHGO6Y4oxpqhajx9HpLLuMR5hqP6NNwe7
	 NkfiT4o4+J7sOKUOfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N3KPq-1qhH3U3Hyk-010Iqs; Mon, 04 Mar 2024 21:50:14 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] platform/x86/amd/pmf: Fix return value of amd_pmf_start_policy_engine()
Date: Mon,  4 Mar 2024 21:50:02 +0100
Message-Id: <20240304205005.10078-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304205005.10078-1-W_Armin@gmx.de>
References: <20240304205005.10078-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8d9XMYhgFJgs7YKr08lxua9Cl9IWSRTR4jEtoSTH+T2j1YiT0fn
 PXb0xePM/Ie83TXJfniYWJ2H1Sbw4fmhvXhkKoJD4fhwuOkuM2TLzeu296L69mWOG31zQ/W
 xPfYXi9QRGn4SxRDRjMpv4jm5tk/fg2iNfuwazscEwp8ubzz5KVATePYs4wMl30TurcJFPV
 1B1tG9JmSivVdLpzMXy6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U5VYaQ7x7FU=;wYUHjOSSNN8XnWDFnkZLgYocNOw
 WrzTKLqtU4LOCimTxe+Xe1jPOYob3wTUM/KfPdBVdVbyChPjbwBohFOWJf6zHpMAnogsU8abA
 8GUrTalxHX/RNHxhHU9OVrGtpzmcVhgmlH3Egfgebw7w+N8kwyRIbdMxd4PVToBH0vhHBKXP4
 uw9z/XGx1B9UR39aPUkIGLC/4Ulw7GF1Oj+IwaZnwJbpahVHUgeK7+IdmJvXKsT/OCNEYxtAO
 gEMN1ah6rziogBQ4a/u/jMXdBeTW7cXIpqZ7zH0gbLDZVYr5ZuMtSwIF1MOovfdjJBiJq8fix
 PBKSUKF11AkMEVe81K+ju5a1sXArRjSCo2b8obCdYLvGdV9ADgPrRms++0H+AO/Rh8gmMLvvC
 CqQerq2uWNLRpUAhjvjz1oZnMKLLq7yHroTFa2ozPq05O5o32dlAZsV+erZ2uE48EzVTp3aXI
 8RImwlaSx+LgY3iQLY8idOqSjdENGFggSWtttUPxhO3yel2heXcqyQVFtcvoSQm/JVuz3Xg6v
 woAskANoOqggQITOVaYTRtj9wYm8HWR7hXC7XCZ6ysWfwbUs2CCYDNwTtqjBHmOTv5qqD/79W
 ZHz+5tQa73wkzm1EntQI8oMCNeEDTl47r+Ep5rdZGCDgxep6bXySaxhUMs7tANgdq1fuuAQoX
 s/VzihG3mFOwWlSc7NEiF1MMpBQU+9CO1C7T2sZ3G+xjM2AVIEQJEvLrtBiRDxA9CaH5aAA72
 WAJaHoWWeJYxyZOV0VEkncxIug0XJC/JecYNSYfa81ny8dzWNZOY+NrNf+QgfenEDuyDnjuQS
 kwkeQQvQb3pQMz7brX33XPb6HaiQOMUavXTRWDgHOiXBg=

amd_pmf_start_policy_engine() returns an negative error code upon
failure, so the TA_PMF_* error codes cannot be used here.

Return -EIO instead. Also stop shadowing the return code in
amd_pmf_get_pb_data().

Compile-tested only.

Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Fixes: 7c45534afa44 ("platform/x86/amd/pmf: Add support for PMF Policy Bin=
ary")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/amd/pmf/tee-if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index 16973bebf55f..13dd4462e1e3 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -269,7 +269,7 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_=
dev *dev)
 	} else {
 		dev_err(dev->dev, "ta invoke cmd init failed err: %x\n", res);
 		dev->smart_pc_enabled =3D PMF_SMART_PC_DISABLED;
-		return res;
+		return -EIO;
 	}

 	return 0;
@@ -309,8 +309,8 @@ static ssize_t amd_pmf_get_pb_data(struct file *filp, =
const char __user *buf,

 	amd_pmf_hex_dump_pb(dev);
 	ret =3D amd_pmf_start_policy_engine(dev);
-	if (ret)
-		return -EINVAL;
+	if (ret < 0)
+		return ret;

 	return length;
 }
=2D-
2.39.2



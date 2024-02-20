Return-Path: <linux-kernel+bounces-72357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2706B85B265
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D241F21CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34EB56B9E;
	Tue, 20 Feb 2024 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="aLitBPO/"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A879482D1;
	Tue, 20 Feb 2024 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407932; cv=none; b=EFEJrTWBja/jcHayO8TO22IiPipTJPdkeaas/8FU82XwjEJ8m+sNalgQpp0iC5Z+ReSw1WL8buNbhY4xtip/yE1SDvIo6S8XDTAqayChFnBDOr7kOP3U+HytaoVmqzL1mgptvxwMOA/YOGzlJAD+wc8VqycmBNEhg5Q4W7UgXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407932; c=relaxed/simple;
	bh=wMCc8J1PCY8KB0C8TU2S2VGitU5uhYxb7pS5TWKpv/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WrJPQK97MRcTy7si0GL3euoPhM6IagOueej1cEolk+d9R9CkESvwVqGh7GPNtZwH3YGfv8IDIYTNGLv6G6H0D2I+dSKZVzbjDCR8wfhCi5nv9xWU8mFgSrSW4o6bxGNOT3GMS1IhjlSFoMwz9rLMj62Och2BsKyQqIFATKh0h7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=aLitBPO/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708407918; x=1709012718; i=w_armin@gmx.de;
	bh=wMCc8J1PCY8KB0C8TU2S2VGitU5uhYxb7pS5TWKpv/4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=aLitBPO/PNEumsiFTO5LEBWzlUKDQCkasQdR5ZDmIVTh5+SAzGljSZSIhp8HaAAy
	 /S0+l2BeiOpPSg271uN0IR8lTSgalXntcxvjTuZl9p+EQtcPzs7u8itXLB4+59drz
	 EY7ccLY319/767ZqQZpyVGMSAqm8PWIzbBvauVjYWaFSIO8LcigRy6kpdCv1wmpZu
	 6A4xZVmYzOAlbCNVU5CT+sCHTg6nkFAKp/X27sM2QnLuEh9oa4u6HKxqT/ymyHVOt
	 23jvgAiAxi2PuLZPViBM8fwOvl1NPaop6Xr5hSiVEZpKb8I0RdYzyG6VEKS7VVgmd
	 9p/h/4Q3crejPt+iTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M9Wyy-1rWmdN3pp6-005cp5; Tue, 20 Feb 2024 06:45:18 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com,
	mika.westerberg@linux.intel.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86/amd/pmf: Add missing __iomem attribute to policy_base
Date: Tue, 20 Feb 2024 06:45:11 +0100
Message-Id: <20240220054513.2832-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ozzk3tnKBJ32+TPnyj6okQniSEs5v+d+xylq2BPWyiH69B9isX1
 ihj78sqcgowFCHaFxcvQZhSsKIHqKnVaKKpMWgjbB60ayJnv6x2pKMjJW3UcgPKK0Jl1dpn
 XEyk36rVvykCSjFPGGMBfjvatk/HWpKDsRrNXKDpidRYZFSXDLjAZnoCOThZMNyOR/WgO8c
 WlM8rxOUGSf/S6urDAl0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uyGY52FymLM=;UIsQXfUcdN2wYpy9mdDmqgdB6/z
 pl5xRbfE7qMdUWUo91GRlRQIgqf1HlnQL+o6Um2hpvDWFo5AS+vPAArIaeWM21pOnNUJtHTKq
 XmCVwcYGWGDgj5d3aVyOLSvrzdZr2ifU5wP8i2hQ81SPtZrCsExEqQeTfAYGqB4WoW6BJfVfo
 7XR3szR12LONsZcV068Fb90TFZ/YtkSgIe+Hgf80SeVc5eUiiHTcBafq0c6vf9vuYIHaMn0b3
 3Emrpzwam+yus7T8HQK7pEHv6naNscqM23y72WH4JiQEzUHA51h5FXBfECf1Wx6+IaNu2rzVE
 yy0jtsru76GvpUaULsRHWE5q45qOb33LL3UPVZ4DNWBWL63C7uCkH95yuDqlMyzyIo1dViqe4
 YQf4brQV7X+IlUZAfOqPr2J6njg98m1/EOpHRjjLSp4+D1HVuTSavWvyl7vgUKYZfPKPeWvIF
 o7fakstS/KAZyNgDTDjtuuqV9XyxHQ9Fnh8+JFrSrZqMujgju0ugdWq9q8wyLAaZaEgx3gXkO
 VUIXEUZvtEGaQaaMKVYRUcD0UDWXUIiaBlEtDUylhlneg6HQMmey/syc8nhtbTxA8ADz8+iob
 roHMSJKgZBGN443CFuhnqHKxHW6Igub+E50iFhI4MjfQSkifITQy+yVPz9ATqyp2R8UfDsAUO
 6lCINWE0bLDPhruqCNNy6ZedbReFjfkPPv0V8T6nsK+D5pTmZ/T+wPLHLJaJ4Q/98VB4vA3ae
 YsQiYvP5auEeZOQXlu0L/3E3JRHvSLuLMVc+s6R63wjf2vlI+z8QNnhHUgS0msFUmUnr0Mi+T
 uhegh0HkId82pLSb005B862OWh/ZBeFNVmAFFDzsUisJE=

The value of policy_base is the return value of a devm_ioremap call,
which returns a __iomem pointer instead of an regular pointer.
Add the missing __iomem attribute.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/amd/pmf/pmf.h    | 2 +-
 drivers/platform/x86/amd/pmf/tee-if.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd=
/pmf/pmf.h
index 16999c5b334f..bcf777a5659a 100644
=2D-- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -229,7 +229,7 @@ struct amd_pmf_dev {
 	struct delayed_work pb_work;
 	struct pmf_action_table *prev_data;
 	u64 policy_addr;
-	void *policy_base;
+	void __iomem *policy_base;
 	bool smart_pc_enabled;
 };

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index f8c0177afb0d..16973bebf55f 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -346,7 +346,7 @@ static int amd_pmf_get_bios_buffer(struct amd_pmf_dev =
*dev)
 	if (!dev->policy_base)
 		return -ENOMEM;

-	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
+	memcpy_fromio(dev->policy_buf, dev->policy_base, dev->policy_sz);

 	amd_pmf_hex_dump_pb(dev);
 	if (pb_side_load)
=2D-
2.39.2



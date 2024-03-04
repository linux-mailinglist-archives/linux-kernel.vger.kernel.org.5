Return-Path: <linux-kernel+bounces-91259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3442870BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE977282D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA144CE0E;
	Mon,  4 Mar 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kFXFBocs"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E799101C5;
	Mon,  4 Mar 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585429; cv=none; b=Cebi3AW/mfjNxAxA4tYjTuRZTrpOW0s/cVs+rDjfK5IOuXHSD9bejs3iS4BVExdqrRx8FDx316dlHebsD7ObdFOmZJGPWgrMb2fE9xBXRRm/FjPFDbUz3KnSigL9Afwi7NmwO/x1V5THGbNyjfPpMytQ9hMKy4H9GVNSkqJ0MbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585429; c=relaxed/simple;
	bh=/Yt3m3QNMxVunjWQ91MeMMIfkjCAz9FIsDyld1UwyI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANnQlPZkFkBXZ6qiCgyMURNnSkcBpravHgJpv9AzVExCWgV9mFhSQz7goWCcHbEjoEuZWrol8PZ6p2T/NkMKnFsXS/0dkjJbKPAa+B/YQnW+HV17ZqaYGlY2zlTkWPXdhdz20RPEM34dgKcX4pQ4p6taRjWoPRgxYjX9AZwsYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=kFXFBocs; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709585419; x=1710190219; i=w_armin@gmx.de;
	bh=/Yt3m3QNMxVunjWQ91MeMMIfkjCAz9FIsDyld1UwyI0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=kFXFBocsoRO0v5aFUhC3Gse9ovxb6aHDxThdhKFxQxJUcm8N6PUlupsJIlsgmlL4
	 bX7nadw8g6Wl4bIDSL+Z10b78/ywmmH5gtcwn+wZzQbcwsajB9l3uc5vnYlcilEqh
	 eoR91PtLBUwf0vuVTQ7DborXjXZiX2g8BeONMUzVyGkLB9G3BeJ6jLgWlVzScHAko
	 bDxngmhdTWsHvVrUghnQ26cxQgTLpR2kW49Ku5OREHtOYMxVNXqIfx31dRkfegg+1
	 jAwkLiC0/byJfocAYUfQsRXjdk0/WGlM3zbnV5mFpYw1wil2XKg8jBgXqMVYkbbJP
	 1d8k+L/49vIMDNEuvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MacSe-1r9qW91wVe-00c5nK; Mon, 04 Mar 2024 21:50:19 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] platform/x86/amd/pmf: Fix possible out-of-bound memory accesses
Date: Mon,  4 Mar 2024 21:50:05 +0100
Message-Id: <20240304205005.10078-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304205005.10078-1-W_Armin@gmx.de>
References: <20240304205005.10078-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4unXtnfNipYqD0DGmmAFTw4uVIT2ZbY1gRHrlSqvzY0ZtJtCHc8
 29st9mq2zFZXJOxGqRKaTd/ymY8JWm7RFm4wO854nrbPOtHQY1c0p/LSqzJ+JkHHuO69gss
 NblXqwypb9r10joTSFTNwbGpYiNBGsfwB1D6xQZZbizrV/iRjoFeQCyVujVMsT4c47Z1ZJR
 zh0KH3FtOWldCucAqIDRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nE75bobHrC4=;Nobj9OwVmbhnUnr/40vGxXz1VOM
 D5HIS0HO6t8QIe21y5D0kNnKlUMn31fzP9vZ/9dXMrugwdFTBTKF+KWDn6SAo2qaiXog4p0ga
 W/8AkDzETwosbuW7gz/Pa375qdnyWW4tZt/PYFMYds/TN/oVgEpvNcvGtP0DHroVOajfDUuHg
 RiF+laPFkBxJzItarPKotGtKTejzwgVcQ78Cl0PXwYNUbbU+KcfQASjlSuf7TirfQMdLUiH/C
 qH0oNo1qmhkN3jDNnq23MdxO1N3U259/MNOQCPKhXhIe5bsZbukT85AshMblyOdTcF3c2ekBQ
 5vb6SO1/EnwzkIYb2Zdrtu+5w4UxO2zyJ8PxCAhTciIynH4V7AE/6IkfLos+aE7m4+EKlloQn
 70he4WpO40jkKSqQgiOH2vpJEVXrs1S39vJ5wdbxoCTfrrTeXoVC/GqUjE+3xnXmmqroJvNRe
 HDo3TngxR/NmaI3D0Vdr4zt3o8MQydkfGFVYf8mbrtZ2JJNVtFjAwd7X37Gd8kI9uYm3xPmT/
 s1K2plQ6VF3r6/0oE7brgPb8JGyR9WzrEdm3iq42+q6ZWZYgbfQpTfE8cCM7BHnOsaFCtBxFn
 gH+SaZuku7lrfJ6UizUgZdTxI/9XGf72/ZQMwUl0kRML3yp5rvg1IENuHb95Ge9CHFJig1Dzr
 7PINWIkpQVggje7YglZanEjmqwNXIhjAJBfiuH2iuMvXxBr/xj/LNsIvASn5FgS4itVdm/vpX
 iPCGsmUpzLAIMKSLtt5lnECtFxv4/PFyxOaM5iEQAuNr9S9soQHUnlqR50BG876taRIClcOuw
 4dAtSyz2lhr8ugFaq7ylYW/ut70s6g/4bqlcxgBiY4z3I=

The length of the policy buffer is not validated before accessing it,
which means that multiple out-of-bounds memory accesses can occur.

This is especially bad since userspace can load policy binaries over
debugfs.

Compile-tested only.

Fixes: 7c45534afa44 ("platform/x86/amd/pmf: Add support for PMF Policy Bin=
ary")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/amd/pmf/tee-if.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index 71ea7eefc211..75370431a82e 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -249,11 +249,17 @@ static int amd_pmf_start_policy_engine(struct amd_pm=
f_dev *dev)
 	struct cookie_header *header;
 	int res;

+	if (dev->policy_sz < POLICY_COOKIE_OFFSET + sizeof(*header))
+		return -EINVAL;
+
 	header =3D (struct cookie_header *)(dev->policy_buf + POLICY_COOKIE_OFFS=
ET);

 	if (header->sign !=3D POLICY_SIGN_COOKIE || !header->length)
 		return -EINVAL;

+	if (dev->policy_sz < header->length + 512)
+		return -EINVAL;
+
 	/* Update the actual length */
 	dev->policy_sz =3D header->length + 512;
 	res =3D amd_pmf_invoke_cmd_init(dev);
=2D-
2.39.2



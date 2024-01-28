Return-Path: <linux-kernel+bounces-41599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A3E83F52D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924B9B21A12
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696CE200DA;
	Sun, 28 Jan 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="G4Olv8bM"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4671EB3F;
	Sun, 28 Jan 2024 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706441273; cv=none; b=KvfPPl1qV/2AxC9BdjdACC+mRbCTA51CbClIrKF87KcsLCk29qMhWvAr6tOG1IRCaXKGSN6JpBPTMO7N4v7Cnb3xSrKC2Ky1j9c346JQknOl0it4PFDrBnEoPoFzK6ceTOMtCfiryFSvX3bvYLMj1CBMvdslKtVEky3OXEvMFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706441273; c=relaxed/simple;
	bh=0GN2Bv/A+IeP+4/5GEgM6WZAwRH4zVNjGdeSFF0auzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mGRBcQd76tqU7FF81ANqFH3X1WSGDAEMkEbP/BPKbSpLdetVPXsJ1qdRjESTt2zSNSr/m7iUc+YfKhNCPrDOCcig9JzrpK1U/YwLgJ7Aczj4uKwHMCwZS+KfoZ4yxzDGHfRrP6QDLtuGWc9wCLNyQNXyGQmTeY9+De1ykgs96Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=G4Olv8bM; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706441260; x=1707046060; i=erick.archer@gmx.com;
	bh=0GN2Bv/A+IeP+4/5GEgM6WZAwRH4zVNjGdeSFF0auzQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=G4Olv8bM0Zi01S4TiGpnwHeE0U5XBriX3S3E/Shuw47w/Qvj2/yGHhzXf8CTa/Gl
	 mp+OqfWSRI2hSmBNBg+EF/2Vwq2EaXRBNm7qpLSAMMIKkPeSRuCjC5GjR8XGiWrzL
	 V5ld8U8JsAvGsPHf6qpjTkCcczdZAdlQgKqqc6Fsz/at5JKHGaXXoJkUTb7d5ApDd
	 N7SJ7vPn4eUEJUadomwcHHQQFesdj3YdgQzq5PqM9/bZK5zhpc3aB+T1gfG1qhVh4
	 edrKSUnZ1A8B/jMsJW5+cvs/1spkiN6d8fAhs7kO6NXCYQyA6MUkNQ9PSNsz3t7Pi
	 YdEjn3T4A2vlh5s33Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MK3W0-1rmGQc12cQ-00LXk4; Sun, 28 Jan 2024 12:27:40 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Elder <elder@linaro.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] bus: mhi: ep: Use kcalloc() instead of kzalloc()
Date: Sun, 28 Jan 2024 12:27:22 +0100
Message-Id: <20240128112722.4334-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EQoWUExa/DIBgOI20JFy4vw9y0S152bCMrw7Ds5pWGwDK66l/Vj
 f9UkZeFwkKUqiv4QVkTtx9qyixY68fZn6aE/SuEexl/57uXeVm9s/sxi3GpkfA1bPLR4tXt
 9hEcQ801VXlcYJyOPtBsrU39GCI8Kp+rSOV24zdPPYu2RpBSlZM5+1rFkVblS6P5QMMu7j0
 lpHJ1dACELKUZ3Ue6sfZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QpCG4lROFyc=;IQKTYInMl7RWTyOg1TIUJUrtwut
 460V792KEUzvomGrMCI4hki5D65XiZ4VSTNd/xXmS/6WZGyi7xIiPS+l8V7kXmjGosUEguvmS
 IqsrSCmaAJUBidKc90XsPldsPcIF50k92K0WzzGbyMQlttOr09KILnWRNiQ2klVEk4qPbsI1h
 tZ1/D54a7sKEyjXr0QnzE08/zE3cS/fE40SwWFq2ESHe5UCWVN7WFsOtye/QyzoUFI4fqzTHe
 DEKgkVRzpLzA1IaxxntC/xxEaGsXU59EIcuZGu9D/tXAKrDilVxJ8sC+JMPQhqA+yUTl3DhQ1
 OOEJvOoU3JpEVsXvCKaaiS3n3dTVo8zkwKkXrpmdJNpMlcSr/XbcdX+ggLvSGhVtbjWUA+Yrr
 9Hs1DfLTGWjkMMMZ+MIGwu1c9iBdTDtU66eOOSfDqZFJFtmn+HAL2SwhhsXkbeaEbbEot9UE6
 UWUxPjNXIuOPRYjqrd3B1VxggeM/wWeeIO8b0txgqDtOs3N8kzSLVDmgsPDNQxujWK7fGRyG8
 9gDUIN2XHEI7Si13HEKe1F2+NRmbF4HLQWlt9j2mUW+hBiHnHfnIjXnmXvoYo5Sn5YRbVp52j
 OR5MTNslL0MHdmq31rqDeqwblw2GFVzGUzq55J0M1tr9FY+m2zcHr/fn1q0p6BQ0mqlWNMdC8
 02vR7F1hKgpdZWscnVeeEEN3tMM/iw+k5fErwHScoD2AMggRV0M+O+aJB0eEeCG1rMRStt+rp
 Z57ccqRvPTMyXsAukU2eLr8Kx696xZ63inmz91gzKk5FlV6qLIAgb6IYRqLT9AihhvVv2Ifjo
 dd/ZFN7ytTn9yjQYgNXaZRm5U8CXBstZA8IPuh+pMmi4miAE50PhPmk5qQrhMySCH7MfAABRd
 PnSSsvOgE0MKTfJdiX3Vwf5N+x9M5YvKy6eYiQOVZ/3uWBREnbDjJujMuMJGzYQDFfDMFESJ5
 yjsDpTnkYiRjc3tP4IT4ApFgeRM=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

Here the multiplication is obviously safe because the "event_rings"
member never can have a value greater than 255 (8 bits). This member
is set twice using always FIELD_GET:

mhi_cntrl->event_rings =3D FIELD_GET(MHICFG_NER_MASK, regval);
mhi_cntrl->event_rings =3D FIELD_GET(MHICFG_NER_MASK, regval);

And the MHICFG_NER_MASK macro defines the 8 bits mask that guarantees
a maximum value of 255.

However, using kcalloc() is more appropriate [1] and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
Changes in v2:
- Add more info in the commit message to better explain the change.
  (Dan Carpenter)
- Add the "Reviewed-by:" tag.

Previous versions:
v1 - https://lore.kernel.org/linux-hardening/20240120152518.13006-1-erick.=
archer@gmx.com/
=2D--
 drivers/bus/mhi/ep/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 65fc1d738bec..8d7a4102bdb7 100644
=2D-- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1149,8 +1149,9 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
 	mhi_ep_mmio_mask_interrupts(mhi_cntrl);
 	mhi_ep_mmio_init(mhi_cntrl);

-	mhi_cntrl->mhi_event =3D kzalloc(mhi_cntrl->event_rings * (sizeof(*mhi_c=
ntrl->mhi_event)),
-					GFP_KERNEL);
+	mhi_cntrl->mhi_event =3D kcalloc(mhi_cntrl->event_rings,
+				       sizeof(*mhi_cntrl->mhi_event),
+				       GFP_KERNEL);
 	if (!mhi_cntrl->mhi_event)
 		return -ENOMEM;

=2D-
2.25.1



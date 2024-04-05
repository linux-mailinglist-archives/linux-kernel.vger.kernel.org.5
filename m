Return-Path: <linux-kernel+bounces-132531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A989964D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792301F28DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60A2C69F;
	Fri,  5 Apr 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J8hjm88l"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E02C69B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301143; cv=none; b=Gbs9QqfCEPmQ6RK2mu5dtJaMfb/5T98d/00IaDfFyd+CAHDeoWKRbUxTEvb7P7OSxHdGksXuJQBL15u2McniNAuciuQjQKjrb73z0V/w5046pa4j54OaMMLaZLVot3umM7/Fk8StRH6AZ7z49GPoGoUHf4rulV8nL+P0HH22rAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301143; c=relaxed/simple;
	bh=cEnW8idM7VN5XFwYHiOc4IetFhJwD4CGFbBP7KHBkkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=XO6V3O440sQ0VsjNtZTtl2Ytz/KBGkaZLkwYD39zug9IqUEckNP/amxbVAuFPgugsTrFUOySWImi5cb7zKcwa+27niQO4UV7EwRfuSE9kMUk5FbpoNWoGwM8MTl8SSPn4K4ld0ITdXgTmZDuRRusnG7pI9jnG8N5PFJGI2eeaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J8hjm88l; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240405071219epoutp043824dd4341022092c24c4173d79e89e3~DUNBtoDwI1576215762epoutp04Z
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:12:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240405071219epoutp043824dd4341022092c24c4173d79e89e3~DUNBtoDwI1576215762epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712301139;
	bh=9r+juJE3qz21CeqL4wvnikvqrJqOObHZeY1eDWH8+Do=;
	h=From:To:Cc:Subject:Date:References:From;
	b=J8hjm88l7iA6JMPtPG/wF0DDs9rePBn15Rf+vyupQ96DTP38RW330d/dlePnkBORc
	 70LqzWyjJZZ6bUK6P+UmyPXrz4wsGFRueo9NsJdqHI0+RQ8dBf1HNSbGdYo8eZ6RZ5
	 ztLHwzi2cHPzQgpLvV1mDdpSBhiyT1ceHCUVHcgs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240405071218epcas2p1855b124a4c6bf1d9af50772fd608dea8~DUNBPayJB2290522905epcas2p1g;
	Fri,  5 Apr 2024 07:12:18 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4V9qS21p58z4x9Py; Fri,  5 Apr
	2024 07:12:18 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.52.09665.254AF066; Fri,  5 Apr 2024 16:12:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240405071217epcas2p470124e9f6e9066cb5cdc7f78557042e3~DUNALWEm_2316423164epcas2p4-;
	Fri,  5 Apr 2024 07:12:17 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240405071217epsmtrp11216db7a0da614fe45986cb5f04ae0f5~DUNAKJftw1926919269epsmtrp1B;
	Fri,  5 Apr 2024 07:12:17 +0000 (GMT)
X-AuditID: b6c32a47-93fff700000025c1-af-660fa4529c57
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9C.BA.07541.154AF066; Fri,  5 Apr 2024 16:12:17 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240405071217epsmtip2e610d3f7babf7ce393fbfb3b63f331c6~DUM-3VPQG0135401354epsmtip2M;
	Fri,  5 Apr 2024 07:12:17 +0000 (GMT)
From: SEO HOYOUNG <hy50.seo@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
	kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
	quic_nguyenb@quicinc.com, cpgs@samsung.com, h10.kim@samsung.com
Cc: SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: core: changing the status to check inflight
Date: Fri,  5 Apr 2024 16:16:01 +0900
Message-Id: <20240405071601.84337-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmqW7QEv40g1eHuC0ezNvGZvHy51U2
	i4MPO1kspn34yWzx8pCmxd/bF1ktVi9+wGKx6MY2JoutN3ayWNzccpTF4vKuOWwW3dd3sFks
	P/6PyWLqi+PsFkv/vWVx4Pe4fMXbY8KiA4we39d3sHl8fHqLxWPinjqPvi2rGD0+b5LzaD/Q
	zRTAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0
	upJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgU
	qDAhO2Pi10WMBfc5Kz5tfsfWwDiFo4uRk0NCwERizaMtzF2MXBxCAjsYJf6+6WMFSQgJfGKU
	2PPdByLxDcjeeZ4dpuNB3xlGiMReRok/x++yQzg/GCWOL7kMVsUmoCGx5tghJhBbROAyk8Sf
	ZWYgNrOAmsTnu8tYQGxhAS+J93N/g9WzCKhKzF92lhnE5hWwlDh//QLUNnmJRQ2/mSDighIn
	Zz5hgZgjL9G8dTbY3RICMzkkGi43AhVxADkuEq832kD0Cku8Or4Fao6UxMv+NnaIkmKJWQur
	IVobGCUOzZ4FVWMsMetZOyNIDbOApsT6XfoQ5coSR25BbeWT6Dj8F6qaV6Jh42+oibwSHW1C
	EGEliTNzb0OFJSQOzs6BCHtIfF/ymBEStLESN86/Zp7AqDALyVuzkLw1C+GEBYzMqxjFUguK
	c9NTi40KjOGxm5yfu4kRnIy13Hcwznj7Qe8QIxMH4yFGCQ5mJRHebgfeNCHelMTKqtSi/Pii
	0pzU4kOMpsCAnsgsJZqcD8wHeSXxhiaWBiZmZobmRqYG5krivPda56YICaQnlqRmp6YWpBbB
	9DFxcEo1MMW17Pg3TenjD2aDjsm/H2RO/KN3NrxwGrv0BnnmuRt4e9ic7j54/Onmvt7N56+b
	WNooqx/2r1ms8/ZxyYTDa5jM7A807XOt/16Tf6ZsyqSyLZovblf7rE2bsFVHSogv2vuYU3tL
	AreVhNASZcMSjv6LOzO5eIu3m6resMxZtPGEgehyAbe/VdfZDGasnbdqQ+rhUx/yPpkqLahn
	mB3oPeFzdYSl0+25cyyjTMJm/JPbuvT6S8HrazJnzpgW5B3UdSl53YczYWWPPaROzJC5a6dX
	bN+2qev8p+9pZ1ke3LjAXh8VrLXHSZNF7cs09hcxbda8YYKNhRHFemfcllvE12wLXnLPK37x
	0+mFfyZdlVFiKc5INNRiLipOBAAlOmUxTwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvG7gEv40g5tn1S0ezNvGZvHy51U2
	i4MPO1kspn34yWzx8pCmxd/bF1ktVi9+wGKx6MY2JoutN3ayWNzccpTF4vKuOWwW3dd3sFks
	P/6PyWLqi+PsFkv/vWVx4Pe4fMXbY8KiA4we39d3sHl8fHqLxWPinjqPvi2rGD0+b5LzaD/Q
	zRTAEcVlk5Kak1mWWqRvl8CVMfHrIsaC+5wVnza/Y2tgnMLRxcjJISFgIvGg7wxjFyMXh5DA
	bkaJhlfbmCESEhL/FzcxQdjCEvdbjrBCFH1jlJjx8DZYEZuAhsSaY4eYQBIiAk+ZJE4c6gJL
	MAuoSXy+u4wFxBYW8JJ4P/c3O4jNIqAqMX/ZWbAaXgFLifPXL7BDbJCXWNTwmwkiLihxcuYT
	Fog58hLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjOCI
	0NLYwXhv/j+9Q4xMHIyHGCU4mJVEeLsdeNOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrOmJ0i
	JJCeWJKanZpakFoEk2Xi4JRqYMpXPXJkX9CGtn+fH8+vnGTVsVKIYfJdhmY2h9Cb5+qerHyZ
	dW2v95fc82d4vd2mWv5lPPW19PQuj1rm1y3u6pzTiyTE2ry0759XeSP77KC6icWLj0HKy/27
	KhfO1y8NnnPu+2atXXFX6/WZPfnUHn4Lcr47MZtra8+KjfueTflx8ZHoxzzfSklXVffZ7Wsj
	/JuaNZpLPRhqrs+ZL7tJeUJE4WITzeia9CWqKpn3ror1hKY6/HlY6nq697vHIuHbW1eXx3S8
	PmlUevauCk/h0o0e9reeXVhn+K1KyyxYLmPJVR0JcY4SiTO+6yx2/EzRTri0+NM9/X82vxqF
	Yp6v/zw7O/jtRDfP8ISaKM6zv5RYijMSDbWYi4oTAZzMngD3AgAA
X-CMS-MailID: 20240405071217epcas2p470124e9f6e9066cb5cdc7f78557042e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240405071217epcas2p470124e9f6e9066cb5cdc7f78557042e3
References: <CGME20240405071217epcas2p470124e9f6e9066cb5cdc7f78557042e3@epcas2p4.samsung.com>

According to below the patch applied, lrbp->cmd do not will NULL
after call release_scsi_cmd()
So check the rq->state unconditionally even if it is completed normally
in ufshcd_cmd_inflight()

If occurred abort status and tm_cmd timeout, will run err_handler
for re-init UFS.
Then err_handler will check pending request for clearing cmd.
At that time, check if the state of rq is not MQ_RQ_IDLE.
In other words, check if it is MQ_RQ_COMPLETE or MQ_RQ_IN_FLIGHT.
If rq->state is MQ_RQ_COMPLETE, it is already completed in the block,
so there is no need to process the queue.

Link: https://lore.kernel.org/linux-scsi/20230517223157.1068210-3-bvanassche@acm.org/
Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 21429eec1b82..3f47ea584cb1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3088,7 +3088,7 @@ bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
 		return false;
 
 	rq = scsi_cmd_to_rq(cmd);
-	if (!blk_mq_request_started(rq))
+	if (blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)
 		return false;
 
 	return true;
-- 
2.26.0



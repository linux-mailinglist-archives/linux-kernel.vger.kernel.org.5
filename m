Return-Path: <linux-kernel+bounces-12163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C650D81F0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C7A1C215A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C03346452;
	Wed, 27 Dec 2023 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tWfJQwkp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2746437;
	Wed, 27 Dec 2023 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703697387; x=1704302187; i=markus.elfring@web.de;
	bh=Ov3WUUWTNVb8pj2W5+dHtNGdRbRpUFyvJpbrqjNl4bo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=tWfJQwkpYzQP81B7bnS5jI0nTEdOhhAroQ2+21LxQmHXV0tzhK/DT/xEjrgbQkY5
	 H7yYKJi85517fV/EYIjO6/5E1w9AI1FbkJv2QE0klkUDPo4VAxN06fzraISrBFYb5
	 F2r0l+ySP4a72aWn42pTmpCUDbjUNSrrxE2A5UQPLUvbsETBXpKat9NNTgUbB4Hqs
	 37Nz0/BnQPtmcYOSgTPw9rj9R1IsdECdIThFwD0VIMcmRqmjxvW7eskauoNCUob2y
	 CrnLfWxJ5TPowAiSSZ2MPXQc99DirK9wH8vbKC+KWA95s7/hvKhhTKtw0XxmpWqXe
	 OGkPX4xKHT4yQmZDgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1rnpk10N4U-00Vobh; Wed, 27
 Dec 2023 18:16:27 +0100
Message-ID: <831d0d61-6d45-4184-81fc-38828f9e5d29@web.de>
Date: Wed, 27 Dec 2023 18:16:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] nvmet-fc: One function call less in
 nvmet_fc_alloc_ls_iodlist() after error detection
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
In-Reply-To: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yx3du+OOx5YLfc/sgw4RHGZO88uZ4TXt5NhsVF1iHNlgdNQxYUg
 n6S5yHZS8L4deNN2JL5azTRMtGRQK98/lFwDLYmNKz8ekNH4Bsv+RWudE+cp7vvBnChZ3CD
 Zmf/uLVPzMf7DFedQxCpM1epbL7yfemhWt25pIKevtgBL8YfsYAUfESpALWGS+ETqJZKfkt
 agYPPePhlfX/O1l9xagYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gHNqSJy4XnE=;ypyqEJVSwQ+0OZ2Q2o0ASwJchcx
 6wajWPplosHaaRquh7mV0AT6F9lUteP0042PxkHW6fRLUWfRincqHGRzbPyBnEqP2SmPCAsU3
 V4vD8MgQcPnWjgl/7j1eiIZSozrW0P6d4abn1Ngmanftt/0On+MzSJVZugPRLjPNKcg+6AXRQ
 tTLQzKYSpywc6dpZ8k6hZj9SVrJhUfqsBzBKscB+H3VF5hq1RjZ1AaIhNiIkokVjI6JPXRhF3
 ziBEOyyKq6AmpxeQGmpDbrUcoHCJEU3UklkcblKW5EFSI7++e8gNKkiqXeZNpG/r4whvpeN65
 9ePXhiiErOWtDOMkHcmliB6l9GvT53AbY3KW2NVWfBMCZrvmmgU7/w74vwAXF02iqm3zs+jK0
 X809OArp+dRTGFZvBjxgdC+hsjm15KsmY5i+ChDSdGk7b838dh1edu0sW6Q0sQoC6W3E3f8h8
 hOndXmOHbx2CcqD854qIP8/9guiHFve9W2aWDn/Ng50v3eVqhtQBCRuKJoq0o6fc0mL00Nyyr
 n+wynAWbLd+HSFMdHAvzGoB6B77VQTm2AfbasBsQG9Q1W1+wkwCYTOPBvp7gwfH1ngldtLow7
 hwpLcF54iHlrmYeihnzaX70eMNajIS8WCVXsvJWpi5caZ9ehFv5zgUkYTjtts+4l3wI0oMw2/
 Zvp9Q1JgnglZVeqE3OEN2k/gtJ/zfQdyC0bdeTG0gWFy3L0BB2Eb90XS+ZT72DbQOsRH9p473
 70airwvBeVCFBp22Q1qDF0M4LzSnfiAh3chSjWklw4KdRsQD1KYp5GSOrRQJA9ZbzKe5NXk/x
 rILbN0KeEmDI438SGPc6zX9+6J0+3LsOFixWGBI+joeU2EX3p/SAhgo01JMpI9jaBgiXuXn+q
 KDgr6Nars/LjBIeyp+KD59KWx8R3wmc15elb/ILri0uoU7scJll0lvcDtetLH0ttcxffufk+U
 PUafcA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 17:52:46 +0100

The kfree() function was called in one case by
the nvmet_fc_alloc_ls_iodlist() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bd59990b5250..856a68404f32 100644
=2D-- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -553,7 +553,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgt=
port)
 				       sizeof(union nvmefc_ls_responses),
 				       GFP_KERNEL);
 		if (!iod->rqstbuf)
-			goto out_fail;
+			goto out_delete_entry;

 		iod->rspbuf =3D (union nvmefc_ls_responses *)&iod->rqstbuf[1];

@@ -568,6 +568,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgt=
port)

 out_fail:
 	kfree(iod->rqstbuf);
+out_delete_entry:
 	list_del(&iod->ls_rcv_list);
 	for (iod--, i--; i >=3D 0; iod--, i--) {
 		fc_dma_unmap_single(tgtport->dev, iod->rspdma,
=2D-
2.43.0



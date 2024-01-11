Return-Path: <linux-kernel+bounces-23322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB4282AB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03BD1F241AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B8112E7E;
	Thu, 11 Jan 2024 09:31:54 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86119125C6;
	Thu, 11 Jan 2024 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b6140aa2ba57407db9211ebcb797b455-20240111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:93e3ff86-4419-43b1-b776-baafee3f628e,IP:20,
	URL:0,TC:0,Content:11,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:16
X-CID-INFO: VERSION:1.1.35,REQID:93e3ff86-4419-43b1-b776-baafee3f628e,IP:20,UR
	L:0,TC:0,Content:11,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:16
X-CID-META: VersionHash:5d391d7,CLOUDID:54c4bc82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240111173139SFQXI8WX,BulkQuantity:0,Recheck:0,SF:17|19|44|64|66|24|1
	02,TC:nil,Content:3,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,
	TF_CID_SPAM_SNR
X-UUID: b6140aa2ba57407db9211ebcb797b455-20240111
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1387183627; Thu, 11 Jan 2024 17:31:38 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7E03FE000EB9;
	Thu, 11 Jan 2024 17:31:38 +0800 (CST)
X-ns-mid: postfix-659FB57A-437709967
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id CC01CE000EB9;
	Thu, 11 Jan 2024 17:31:35 +0800 (CST)
Message-ID: <346b631c-8b46-4b41-9188-8cbaaa1ff178@kylinos.cn>
Date: Thu, 11 Jan 2024 17:31:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: aspeed: Check return value of kasprintf in
 ast_vhub_alloc_epn
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au,
 andriy.shevchenko@linux.intel.com, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kunwu.chan@hotmail.com,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20231122014212.304254-1-chentao@kylinos.cn>
 <2023112236-bullseye-pranker-491e@gregkh>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <2023112236-bullseye-pranker-491e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, I didn't find out about this email until now because it was 
intercepted by my company's email server.

On 2023/11/22 20:10, Greg KH wrote:
> On Wed, Nov 22, 2023 at 09:42:12AM +0800, Kunwu Chan wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   drivers/usb/gadget/udc/aspeed-vhub/epn.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
>> index 148d7ec3ebf4..e0854e878411 100644
>> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
>> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
>> @@ -826,6 +826,8 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct ast_vhub_dev *d, u8 addr)
>>   	ep->vhub = vhub;
>>   	ep->ep.ops = &ast_vhub_epn_ops;
>>   	ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", addr);
>> +	if (!ep->ep.name)
>> +		return NULL;
> 
> This will break things if this ever triggers.  How was this tested?  The
It's my fault, I think it's too simplistic. Compiled test only.
Cause I don't know how to test effectively. I didn't find a way to test 
this in 'Documentation/usb/gadget-testing.rst'.
> "slot" for this device will still be seen as used and so the resources
> never freed and then you can run out of space for real devices, right?
> 
> Looks like the other error handling in this function below this call is
> also broken, can you fix that up too?Yes, after reading the relevant code, I found that this is indeed a problem.
So I write the v2 patch below, but the same question bothering me, about 
how to test effectively and what hardware equipment is needed? I'm new 
to this area, do you have any suggestions?

The v2 patch look like:
@@ -826,6 +826,9 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct 
ast_vhub_dev *d, u8 addr)
  	ep->vhub = vhub;
  	ep->ep.ops = &ast_vhub_epn_ops;
  	ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", addr);
+	if (!ep->ep.name)
+		goto fail_name;
+
  	d->epns[addr-1] = ep;
  	ep->epn.g_idx = i;
  	ep->epn.regs = vhub->regs + 0x200 + (i * 0x10);
@@ -834,11 +837,9 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct 
ast_vhub_dev *d, u8 addr)
  				     AST_VHUB_EPn_MAX_PACKET +
  				     8 * AST_VHUB_DESCS_COUNT,
  				     &ep->buf_dma, GFP_KERNEL);
-	if (!ep->buf) {
-		kfree(ep->ep.name);
-		ep->ep.name = NULL;
-		return NULL;
-	}
+	if (!ep->buf)
+		goto fail_dma;
+
  	ep->epn.descs = ep->buf + AST_VHUB_EPn_MAX_PACKET;
  	ep->epn.descs_dma = ep->buf_dma + AST_VHUB_EPn_MAX_PACKET;

@@ -851,4 +852,21 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct 
ast_vhub_dev *d, u8 addr)
  	ep->ep.caps.dir_out = true;

  	return ep;
+
+/* Free name & DMA buffers */
+fail_dma:
+	dma_free_coherent(&vhub->pdev->dev,
+				     AST_VHUB_EPn_MAX_PACKET +
+				     8 * AST_VHUB_DESCS_COUNT,
+				     ep->buf, ep->buf_dma);
+	ep->buf = NULL;
+	kfree(ep->ep.name);
+	ep->ep.name = NULL;
+
+/* Mark free */
+fail_name:
+	ep->dev->epns[ep->d_idx - 1] = NULL;
+	ep->dev = NULL;
+
+	return NULL;
  }



> 
> thanks,
> 
> greg k-h
-- 
Thanks,
   Kunwu



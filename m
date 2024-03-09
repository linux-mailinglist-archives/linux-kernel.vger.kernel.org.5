Return-Path: <linux-kernel+bounces-98053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5387741E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 23:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4913C1F21930
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB5C5338A;
	Sat,  9 Mar 2024 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iZV3SkMM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3C20B22;
	Sat,  9 Mar 2024 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710024350; cv=none; b=FOlwUesg9rFk/wArOsfr8npMYwT2wK7QCadjIU8Nh8bwhDLGrcp4wCXmvYgEiz21wKKMMEyUOyoa8r44CaMJPZstb5757HjQnLKhwyiQUvprM8obZ7FAe/0GPosbF3GWGZhZ8cYhItXjxAVs175SSAJ9QtQxT55JtYq4nembIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710024350; c=relaxed/simple;
	bh=0wr76cui/63QHQTpUDqkmMkTQ9ZdNWUNuERh1WcLqU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IXAAHc6+MsosQvx4fDy8I3sVyiRYe6BEh1urOHEBROp04EpHJdHLGZ+CjxcwgjgUkVDp7LvKnJFXS0v0tEjla9NefiZpmUvMgzosvwTz/hsFj4NwXyE6Rbw4AzWvP4WHXRVqrV/94I/x4E0B9CllZpQEwaciQd3TGBi3ln6azcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iZV3SkMM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fknmEs34Vbnx707+0zwgSmO1iUI8E7zWqIKhyAXJOyQ=; b=iZV3SkMMIQNrWwlVZkQzDsG9Zs
	xNSudEPMlkhUJrQKKoaUE9lU2gLoi/uacJ5/2gv7a5rtJHZzLYoryD+eJgYl9ViqpysD5eGSJDF9g
	3pZ+3mpFciJeh66gOxLqJF8F/KXOQLkTzNUr9oCb6D0uLGYjAHkJHYdfiOTFCM5vmXA4XWo1f4tSM
	YueAxWpQ/7SS02j+ly+oENU0qfwQyIlCdF/LdZdtwRNEgSCOCEgsf2SXP0WonoCRqEFF6CQravRJU
	iY/t/r0Qi0mAMqpQ1aPZV9bvmfePVX+dX/N3Di3RXfuSB4bHyf102+EbcDyb1OvBjZecX7Q6h9Dku
	E6eyD7ug==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rj5Rm-0000000EP0O-1Or5;
	Sat, 09 Mar 2024 22:45:42 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ying Sun <sunying@isrc.iscas.ac.cn>,
	=?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>,
	linux-wireless@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol
Date: Sat,  9 Mar 2024 14:45:38 -0800
Message-ID: <20240309224540.22682-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CONFIG_SSB_DEBUG is used in one header file and nowhere else, so
remove it and the now-empty inline function that contained it. Also
remove the call to the empty inline function. The empty "default:"
case is kept to prevent 2 compiler warnings:

  drivers/ssb/main.c:1133:9: warning: enumeration value 'SSB_BUSTYPE_PCMCIA' not handled in switch [-Wswitch]
  drivers/ssb/main.c:1133:9: warning: enumeration value 'SSB_BUSTYPE_SDIO' not handled in switch [-Wswitch]

Reported-by: Ying Sun <sunying@isrc.iscas.ac.cn>
Link: https://lore.kernel.org/lkml/4e8525fe.607e2.18a8ddfdce8.Coremail.sunying@isrc.iscas.ac.cn/
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Büsch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>
---
This Closes only 1 of the 3 issues reported in the Link.

 drivers/ssb/main.c      |    1 -
 include/linux/ssb/ssb.h |    8 --------
 2 files changed, 9 deletions(-)

diff -- a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -621,14 +621,6 @@ extern u32 ssb_dma_translation(struct ss
 #define SSB_DMA_TRANSLATION_MASK	0xC0000000
 #define SSB_DMA_TRANSLATION_SHIFT	30
 
-static inline void __cold __ssb_dma_not_implemented(struct ssb_device *dev)
-{
-#ifdef CONFIG_SSB_DEBUG
-	printk(KERN_ERR "SSB: BUG! Calling DMA API for "
-	       "unsupported bustype %d\n", dev->bus->bustype);
-#endif /* DEBUG */
-}
-
 #ifdef CONFIG_SSB_PCIHOST
 /* PCI-host wrapper driver */
 extern int ssb_pcihost_register(struct pci_driver *driver);
diff -- a/drivers/ssb/main.c b/drivers/ssb/main.c
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -1144,7 +1144,6 @@ u32 ssb_dma_translation(struct ssb_devic
 				return SSB_PCI_DMA;
 		}
 	default:
-		__ssb_dma_not_implemented(dev);
 	}
 	return 0;
 }


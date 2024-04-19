Return-Path: <linux-kernel+bounces-151709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9809F8AB271
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90DA1C21601
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32542130497;
	Fri, 19 Apr 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzkYlqDY"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D6F130A5B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541886; cv=none; b=mn69dscDGbvtZ99DRmd2M2WroVca9VLvYy808kQt2+vKv/T/7Dl/wgZPPpT0cMS1w0mfFNZ9A2Xwa7fejGTAQ3nEX8VkvrwObuuknqwbVWDcidcdthA5vcYzMPv13TntpBNvRGqcgEFgtN99dar9ALwynyhLvzbsrNHvtSdUgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541886; c=relaxed/simple;
	bh=1cxweB0hRjQ+WzZkwwvAgkCSIzsCBsrVCYKtFZrlX74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeCW4CE+MvBnpb3GqrYSKJ5F4H2na5X+nFsPsztSsjBAB4T88g7sAGllAUkltvT0XmiNnqKGhXdlz+EengPN1+dBRT5NJHLqEW2V4cIiTaxKWaFn3xTOP3yO+6Vg25AMGahvEnDHP00TzfHtJyntqcIHVgIiWgml2zpmgr3IF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzkYlqDY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a2d82537efso1522988a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541884; x=1714146684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixWX2IQq6JyK76hK0WzeXnpZdN1BVMtzoSqK9MbhSaM=;
        b=PzkYlqDYtzBMRHOtob+VQZfQ2kDXw2R0r/UDC+uKwhQXjY+xciFay++xqIRllnnL/y
         v/pi+K9s679DyVhZhLYHQeYoRa4af2sR97D2si8B4IsPPUpcfP0039qxAjdXqi2jXBaS
         8DX9Hv6RGaa/VC0LlXRmLhoLWiuJv2ABhpwC1w8VbSEnHNIZfQ21H2k0ZsH2NlBmglCA
         m4w2qMmVMMmF35a1YlUiroBWiqu2ziVwAzYCBb6TZ9QQEoz9lB2gB2aNY3e1bbmqB024
         zyPsI2IY9YJYVaIHQJ+S+LOcOG0u+gb3cRhMRc8mRTsp7eyRTyegSY0M0Y0M/ARUqpgB
         FXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541884; x=1714146684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixWX2IQq6JyK76hK0WzeXnpZdN1BVMtzoSqK9MbhSaM=;
        b=BkoryVJX9zHoD5+R6voOIMcrOCAJy97qSM5035nzT113AxwOoNrMmm+UT6XcH08W1Y
         6L1Cr2AuhmSVjy9M1z06YfyUhZcuxnCj6K+l9cL5DFBdaWP5zjPGG/k61a8pc+6tbifN
         k2qAeFtY1G09bjUo+bW+GUVPCRdSAhZYai3+dtv7MS6ZTb0dw+vEAOQ5GuVW1NtxFs0e
         icrsbzk8/IaGgssMFowSGXEXNMc+7yjSaIQbWE7Iz1R6cJd+W9TQu76dD9cX3RyWq+oP
         2keMWQawSBCWtGoVKcL+/QVKgbufqjSeWPdMX+qKaSWdMy4N/4lfLAdMB9kPL3h2IIny
         2h6w==
X-Gm-Message-State: AOJu0YwxUUtLhS7iXFx/8JqSO3+tqNPM7H2u2IQcgPG8r0fj0zZIzuEq
	CgNKKCyMj0P922TH+x7QYg0v6vEQxc2ns7yp/wFDReORwZTdVLaV
X-Google-Smtp-Source: AGHT+IGFGZ8Con2oWdR88nvpCrj6A8u1ICttIEZZ1NOqllp//OFXEdTR2w1tHMqrWqo6Hmux8frBJw==
X-Received: by 2002:a17:90a:e54d:b0:2ac:cc17:ae23 with SMTP id ei13-20020a17090ae54d00b002accc17ae23mr582464pjb.3.1713541884501;
        Fri, 19 Apr 2024 08:51:24 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id hi2-20020a17090b30c200b002a22ddac1a1sm3302767pjb.24.2024.04.19.08.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:51:24 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
Date: Sat, 20 Apr 2024 00:51:20 +0900
Message-Id: <20240419155120.15602-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000004a86bf0616571fc7@google.com>
References: <0000000000004a86bf0616571fc7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


please test uninit-value in hsr_get_node

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0b3f21cba552..5300bbbc617d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1676,7 +1676,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	rcu_read_unlock();
 
 	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
-	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
+	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL | __GFP_ZERO)))
 		return ERR_PTR(-ENOMEM);
 
 	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
-- 
2.34.1


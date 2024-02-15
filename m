Return-Path: <linux-kernel+bounces-66538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DD0855E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C51D1C222F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDA717745;
	Thu, 15 Feb 2024 09:27:57 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFA1BDDC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989276; cv=none; b=QGtOesCKS5aginfYXJ8QtAho6YP/kSCVJx9FnhLDqJG4G64kPhy5qPm8GcFK1JKp+KVBy5wrAumqgGO8nHvqCxfuz5vxfB+r8AGqpbodOVgWhX1RF1UjykAw5tn1iIrE7fHelTbSmeyAJPR5viteCxN5+V1CDUk2IUSRyOGke/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989276; c=relaxed/simple;
	bh=y4KsnMaM1jeTKOiBqze/3PoDt+OJ+BvsOH1JT8gc31Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F7aWcB62f7JnqZ021Rpep+W8z/QnS3LKAqnPPk/5ePNdCQcbruLwKM2bpYnI19ELn7NxRbfaNji74WNdZd56Zuwpzd7zwVbKJZJO5frh4uo5Yq5WeVbmyjOwPGdOQcmsRUfUW+X/cUMl4LeAJjpdhA8fwRxw6UZlI1xWUJCv0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-364214c3e5aso3396675ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989274; x=1708594074;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVmpyBhTJNCnvh7DhkPIqDwZhWlumLZUWx0BJUPSDD0=;
        b=p1aJ4gufLuLjsG/fDcYmkUnKWxmhqwhmzL136AVQcXw5TLOUnUkZrrD5l2/qe88Dnn
         3CFE7NqjIFZBrslRaenWbu+nDV9wHWug+eteM42rJotfre0yd6BgLkhjjTJNUDQptVKq
         UzpMxNKl3fwHH4KOYpzn1mDQMyUajro7+w4DvNuiwMeTqU2mF1Ovo5d+kRI4VBpvFnYn
         Yhkb+LkQzWRlyptv+dzK5INRvjBOeRvPsChTYxKK8CzSWw/q3N4NdcKtmgJa0c8M1BKH
         xG7C6wj12pz9uXcMn8x5Bu0Sk8c3aGkhlp7pleMgcaBw/bZk36Ms+mvVo58sDm9bwmjI
         29YQ==
X-Gm-Message-State: AOJu0YwA2CpXZ4S0OnxDLfkLj45+qR6oqdWZd/sAfF+CSEKl5f15noax
	2ThCo25LpSjqFtSjw2K6aSXLkurrCw49STTeTFtdsvjAmz0Ql/ftJ2vIs/9j/L3c5Ls+Siuvmr1
	He3NJ0uvVH/fRg10PnFh4bwQiRQws1ooo+ZNEa5u5TpuQZstT1izYEmVngA==
X-Google-Smtp-Source: AGHT+IGLu5LjAcHL/xFOSZeBQ6kqcRifli7SC8jOAthL07Vj+Gysfr5YWo80KwjA/sPUTozYfs2nUmcSn7VJzMcjmGFpcnUDQkxd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d06:b0:360:134:535e with SMTP id
 i6-20020a056e021d0600b003600134535emr100639ila.1.1707989274172; Thu, 15 Feb
 2024 01:27:54 -0800 (PST)
Date: Thu, 15 Feb 2024 01:27:54 -0800
In-Reply-To: <0000000000002cf4690610660f71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7a62d0611683d4e@google.com>
Subject: Re: [syzbot] [PATCH] net: Fix kernel-infoleak in __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] net: Fix kernel-infoleak in __skb_datagram_iter (2)
Author: ryasuoka@redhat.com

#syz test

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 27998f73183e..c7bf1c38b292 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2532,6 +2532,11 @@ static inline unsigned char
*skb_tail_pointer(const struct sk_buff *skb)
        return skb->head + skb->tail;
 }

+static inline unsigned int skb_tail_offset(const struct sk_buff *skb)
+{
+       return skb->tail;
+}
+
 static inline void skb_reset_tail_pointer(struct sk_buff *skb)
 {
        skb->tail = skb->data - skb->head;
@@ -2549,6 +2554,11 @@ static inline unsigned char
*skb_tail_pointer(const struct sk_buff *skb)
        return skb->tail;
 }

+static inline unsigned int skb_tail_offset(const struct sk_buff *skb)
+{
+       return skb->tail - skb->head;
+}
+
 static inline void skb_reset_tail_pointer(struct sk_buff *skb)
 {
        skb->tail = skb->data;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index eb086b06d60d..f11bb308f1ed 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -167,7 +167,7 @@ static inline u32 netlink_group_mask(u32 group)
 static struct sk_buff *netlink_to_full_skb(const struct sk_buff *skb,
                                           gfp_t gfp_mask)
 {
-       unsigned int len = skb_end_offset(skb);
+       unsigned int len = skb_tail_offset(skb);
        struct sk_buff *new;

        new = alloc_skb(len, gfp_mask);



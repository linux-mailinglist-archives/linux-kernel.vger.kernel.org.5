Return-Path: <linux-kernel+bounces-69912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DC0859028
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CF0283120
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6697C0A4;
	Sat, 17 Feb 2024 14:51:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020F69E03
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708181470; cv=none; b=X4NZez7fDpopcruiJIFd342sNOVgtOo3+vmoJ14BSbuSD5LDKPoKsWu+kr4N4QEjdK2jGqqThLK4D+vie6rwSx/Q6+9lx2+aLqB6KGNgLPYA+dByzve9yEYmaKNKZRCAeE914JUxx8CIuphbPAjZWkCkvJ4okYyM8IXkdMZasgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708181470; c=relaxed/simple;
	bh=cJyGmbL/M2P2FaQNjfB8qOun1MkvJL88mCvWOiDQvk4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sD71w44GVKJXknoukvVLVWGmRiKAMshuvSwEqwLF/YEooDMIy2MqtSQQ07Da2237MYRDqplwuNgSP249vE25OHyiNjxTzMD9XVKfhwPlbrecHIEtLV0aoPw3MNIxus0CnyWcbKRcQsVvoxWST0UetRyRdZUFsx21V4YM4FGfyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363dfc1a546so27320345ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708181468; x=1708786268;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXwBazE1XSTv1CcPSfbL565M8WUrifKU9hE49H2OgVI=;
        b=Of/eRP35sMIvb5+mFlqQBemlBj96NRiRwCe73phIH8O8hE9/KiusA81bYfTqrZVATD
         qWCQqMxD4mUFwYsT/56GivlQ0dcFPsGMghVXjHVLr6pOKnmQd/rkJ0n8ASYjKmHUYlVx
         bTUEZaBwlyKUdv3mG4UTEVzEYV6ZtSKWn/5w4DVswxkQviMQZOypbntXb+mDAsTWMcWA
         BCy4q8UiuKkRZTku7DrsFahCJjV5H5i440Fjod+bBXs+3YVzYXOJDpBRWFxbZVVs5TY8
         z+K4SST4Vtb9+9aAEDcmB5Yv902laqEDw/wb3BP9gp6aYLC9avhqezq2tvLmYTk4SKJq
         Gkow==
X-Gm-Message-State: AOJu0YwcGb8Sc0sd4uW1wdzdpLIOCwfYERpEuiTtDr2YqKa24KhNE/dP
	R6H64aQ6YAgPQNCXe+vRJPaG/iA6m62A4XGt6PCEzzJI9enRheg/JMM2FStqR4vkSPbZCUb7iNI
	DCFe/+pVqKH4dsDK2nou9fHbctKOBC9IPiPSnWm6+qIymutWoCBzltqs53A==
X-Google-Smtp-Source: AGHT+IE1K2NgFIIbui6miofg6AnSukOL4SNTaJAtLvEfHhFfGClL4G7VVticxwd7uRpmLCEXVcZsv6urhGgk6pr2fnEi38k4lEuM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8b:0:b0:363:cc38:db22 with SMTP id
 r11-20020a92cd8b000000b00363cc38db22mr575563ilb.3.1708181467879; Sat, 17 Feb
 2024 06:51:07 -0800 (PST)
Date: Sat, 17 Feb 2024 06:51:07 -0800
In-Reply-To: <0000000000002cf4690610660f71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009adee2061194fdf2@google.com>
Subject: Re: [syzbot] Re: [PATCH] net: Fix kernel-infoleak in
 __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [PATCH] net: Fix kernel-infoleak in __skb_datagram_iter (2)
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
9f8413c4a66f

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
+ return skb->tail;
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
+ return skb->tail - skb->head;
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
- unsigned int len = skb_end_offset(skb);
+ unsigned int len = skb_tail_offset(skb);
  struct sk_buff *new;

  new = alloc_skb(len, gfp_mask);



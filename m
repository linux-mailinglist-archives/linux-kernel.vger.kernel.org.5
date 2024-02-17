Return-Path: <linux-kernel+bounces-69841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B7858F5C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47401C20C7C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25177A703;
	Sat, 17 Feb 2024 12:40:51 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0821171A4
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708173651; cv=none; b=i7x1n33adSQ/yO1qiUXQja9ws68P5MWn0Go3bIaUAO3EBO1E9ztI9t3/1Bm+EG5jPZ/CTl1/U8G3FvT7I8Ebc8fYtsDK4EOHByipJPzx/1rbh4xTfGYAEDVS801OaUPmLo3d+zmQ+o++s9vqMgOBjX9xy98BQNY+jyN4e11Yeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708173651; c=relaxed/simple;
	bh=UJyTW58T2Za8+AowX11R9N2e6wKVvQ2V+ZNj9tq5F3g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l2DcEU+O+JbqwZEnRL97ryAx8U6rOcaOsCdIeiKMtW+hxKgY3VYVky5HUlEWJ0hMsGfquaNvrdUnhgsrALR1mqyF1gjJnJeVmmcM3+Q3mdI0J0ISmpQJd5/30oJX2JEbY2BHYAk7+5kLtfc9gwba8W5y88dGHkhtbFBVmTdSVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c4a0dc9f57so215985239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708173649; x=1708778449;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xK11ukSB+KWoNheD43b92AitRf3mUztha3gB0OXgiM=;
        b=BHahBO0haL2KWi20FzgX3E2i7ngqK68vPSuMv4WRpjRg6b5Lqm+pQVLgJZzDFHvpFW
         evNyq6Ysyl+dli0R0hcWPDkhWGjD2K7jbrcO1MMnOpgVzGILIIgwiHf/prMhW1Sm/QGm
         QlzeRpZISen5PmZPAIRDLkDMaJX0QoiEPxIN92Ma20jonsaYgVLGhEjCng2lBVWSU13P
         /7XsV43WzLLyHEUXUklToRrT3SmbmtN4PdOOgprdbxGIYcsV9vedcHLChfMP1c9vEk9v
         FVDj8mjkfesA+bggzjkG+HmSzk05sL/lw1FZQLz60FXolvqBojQ7xoMaIqH1IKJ5BNOg
         bQKw==
X-Gm-Message-State: AOJu0YzBNyRT+ni7rlc39cYBp87odTTPRloGLbq/yO2+ndBzW7Sr/z5B
	hUhJhsWWgL94C8YQvNVALEiWYMNfe8x0CWtrntYBFBU4nMF98mzAz9/csAuCSp46YWsgOAJU9Xn
	Tz6EvbINnER9XiOPwGamBAEgQ2y/LtSSsZmdaaF2wTRBEURV60vbvPDhMqA==
X-Google-Smtp-Source: AGHT+IE1+hNTwaLc+//ElkGVddMsjSwGKgUPYuolUoRRz2QkYEDwOvig08XxmWtsm/Oe4u97A/xBbdM43hxagpSP3d8QbDZGFM1Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4911:b0:471:52c3:4661 with SMTP id
 cx17-20020a056638491100b0047152c34661mr167308jab.5.1708173649048; Sat, 17 Feb
 2024 04:40:49 -0800 (PST)
Date: Sat, 17 Feb 2024 04:40:49 -0800
In-Reply-To: <0000000000002cf4690610660f71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090fef10611932b01@google.com>
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
master

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203..540df9a6a9b3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2542,6 +2542,11 @@ static inline unsigned char
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
@@ -2559,6 +2564,11 @@ static inline unsigned char
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
index 9c962347cf85..d1b8e02c7e44 100644
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



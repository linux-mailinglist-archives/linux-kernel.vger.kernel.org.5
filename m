Return-Path: <linux-kernel+bounces-72323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ED185B1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42A32843FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94075466C;
	Tue, 20 Feb 2024 04:50:23 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7056B6E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708404623; cv=none; b=ZB7YOwbheBTuzqHSJ68g8xL3NirILA/587loKsbPDfqHN8yD6fr8iD8HGgmYqozwCPWNW4xq/sbsI6zeh6WMYseJ6T81AH5sAxzaxoDeeN56+gsSP59HdWshCMMwIm45aZAJD974xAmTUvihvDNWxU8M2ProEiNmP5229e5CDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708404623; c=relaxed/simple;
	bh=2Fx59YXzkq/TRh7yLo6oV/FgmBEik4djHMsTb7l+ubk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jybF8fBdo9vHU/83rTuy/a99xzqp/0XFymxzLdmL8zIHmmdNlQV1UHyBSsHKzmCivf2NPO08Gjcg0VeM7c2Y5ge7EO9NG1aRqqjLMkDaQDMCZaIr7oHUyMYz7fBXDe1moIDk1xbIA0q/V0e3wSSjFQuvyLSkKX4B/fSDZg6gyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c2c96501e6so302033239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708404593; x=1709009393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtED8zHL14b5GFJmXK+S/QT5u2Lk8otZFD2L6kc9fks=;
        b=iw0S1XJV3ngTTWBO4rW0FBzLoLypXnWAO5UjLSR1LvvB3VNxZF8oUzZjMjY+muhOl5
         TfPlqYZYyQADBC4R1kGjVMm+Z3uSOocBfQeH5Hrrd+ArkGXtlWCtq41HMjaJk7fTQumv
         C+W2gQlqgVhj+iGCcnIgw3ozNX6Ho7gyJBadWQmcNzBpRv9IdVMrC80lv/Rp3pbJJ1K1
         MmrAJzNP0jWdbYupoMP4Wdo4jNPSfs1jRKULUXXYr4NudbfxYlJYQ8i7KgTFYIVxyUUl
         rMn+HsNYxk4TYo3+cRkposmy16KFH+B9BsJa36KG2GlD+IILr+gKGmO+KlcfFS8RFr7j
         8I3w==
X-Gm-Message-State: AOJu0YwusC2D1g+cXsCH7ixIFWS39x5TAlIk1Fq09Hne5O/JMHr2TuPJ
	wZm6Stk/t7/Kaf5B/99BCUBErrb0OMy/uaH9EANkt23hxZTFlZdVsyvp1lsvLg8bYbGsBYe2Nx/
	o2ixkGJdlwIKnrovqSjM6jEtiJy/uEmurrvWdh/jQJ7xGIkXb/wk+tyXTDA==
X-Google-Smtp-Source: AGHT+IGgisPFVNlmYddP/5hC3o+QC+gYkSja4UezCH/3g9OGzLch7OJSs8/BRPM7aZ4EdyZEoDDtqDs8DJchVPu5LLb5A8059te0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:365:3db4:16eb with SMTP id
 j3-20020a056e02218300b003653db416ebmr156747ila.3.1708404593780; Mon, 19 Feb
 2024 20:49:53 -0800 (PST)
Date: Mon, 19 Feb 2024 20:49:53 -0800
In-Reply-To: <0000000000002cf4690610660f71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1f4590611c8f03e@google.com>
Subject: Re: [syzbot] [PATCH net] netlink: Fix kernel-infoleak in __skb_datagram_iter()
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net] netlink: Fix kernel-infoleak in __skb_datagram_iter()
Author: ryasuoka@redhat.com

#syz test

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9c962347cf85..ff315351269f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -167,7 +167,7 @@ static inline u32 netlink_group_mask(u32 group)
 static struct sk_buff *netlink_to_full_skb(const struct sk_buff *skb,
                                           gfp_t gfp_mask)
 {
-       unsigned int len = skb_end_offset(skb);
+       unsigned int len = skb->len;
        struct sk_buff *new;

        new = alloc_skb(len, gfp_mask);



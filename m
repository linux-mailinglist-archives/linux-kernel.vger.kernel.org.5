Return-Path: <linux-kernel+bounces-72457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D911E85B3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5721C21672
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF35B1F8;
	Tue, 20 Feb 2024 07:16:15 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5D5A7AA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413375; cv=none; b=eR8ZgHiLDS4Ytxme8FGsL85ftnOo11QBz2pwRtvSjAihg7Rfh+yXDiAdgs9PmXM9dnb+pfD1tRHRIggWG25EeiIyr4kz9zWxwHpESuScijea7quR4QOqTklAYGc1kE9+PreqBAR0f1yJnKwSUqPuX4hY150ImtCaT0+yvOD3KXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413375; c=relaxed/simple;
	bh=Y5g/NozKOkvYdEq6doQYTKN0YGh6Ay4GymYgkWKFTGo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fnCWkR24lGkjvUMv3U1hI4qcHF6Jy/G/qMs6UlEwaiAQdSyL5vGvcmk1X0m87ThnjVx7x9s0zNJKJ5gFh+HLUaRGK5VzZmuORXILKS9QAuC39wKP+hZ2ING1ZBZbEQh9ttRlcCfM+89BK3p8UIsPcqOFw2F+m5gDfoicbmu6Vjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7baa66ebd17so644118339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708413373; x=1709018173;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/k/JrZr1BfcHhOAaV2oyCmSOvOCr7BBaqqXONQJem0=;
        b=gg7EaGO7k66IEYBuhBwM9Dm9YO1M4iwmMWUUGC5qwVs39Y0VWDvOcDB71avqqopQch
         /UfkSAr0E/PHYiUESNdNgygDqhSuGJIkC8z8L3Dpg+SoDz20Y/8OPwEb0wo3ByJNQ5/D
         o5bJugJbyLu08lw2V57lVacPnixDXwgoLagSUAD8cSxIk72UoKvU2v8Y/uMgmGEVWyB9
         9AwXSY6wnnEdl9BHgGS0TPFoM1Dtxj0iRdQMJUaduG4pX3YqZL6VbEmBm49LWEWvoxP2
         iN2ZFqbeJPVnHXIZrubRWPnM7KA3JV7b4sIWSNl0OtwelfD2al9UZ8RGjZadybEvyKyD
         y48A==
X-Gm-Message-State: AOJu0YwRngAtj6/+pXGdeiAOr0uzCDkJmMUkibtH5ghNQzkqzSB1j2ps
	HkYL0MAL4WecATJUtd6K3gfC3gF5xJGQeC6qgZrgif3q+jI7b1dXPgVXdzwRCx34hVcSITcdXyh
	OgEMFTcWgN2RquzgCtTi3xEZ7Ulks/6Io7dV0CltdnkP8nwIN47K1zO1Yng==
X-Google-Smtp-Source: AGHT+IFLa6a37A3Ttc9GvLlCffwoKXGlCdYtCzkj2b5rW2CSJb/4gq9zn/Ohj6OY5wIZYocvCRSiij+Mc9RhPU3V0uRLv4i34e6x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188c:b0:365:21f4:7030 with SMTP id
 o12-20020a056e02188c00b0036521f47030mr760052ilu.4.1708413372910; Mon, 19 Feb
 2024 23:16:12 -0800 (PST)
Date: Mon, 19 Feb 2024 23:16:12 -0800
In-Reply-To: <0000000000002cf4690610660f71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038d3680611cafc4d@google.com>
Subject: Re: [syzbot] Test for 34ad5fab48f7bf510349
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test for 34ad5fab48f7bf510349
Author: syoshida@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9c962347cf85..c9ad41bce426 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -167,7 +167,8 @@ static inline u32 netlink_group_mask(u32 group)
 static struct sk_buff *netlink_to_full_skb(const struct sk_buff *skb,
 					   gfp_t gfp_mask)
 {
-	unsigned int len = skb_end_offset(skb);
+	//unsigned int len = skb_end_offset(skb);
+	unsigned int len = skb->len;
 	struct sk_buff *new;
 
 	new = alloc_skb(len, gfp_mask);



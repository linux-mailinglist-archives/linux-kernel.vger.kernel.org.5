Return-Path: <linux-kernel+bounces-63648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F18532C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E90285044
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7257336;
	Tue, 13 Feb 2024 14:13:18 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E095731B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833598; cv=none; b=ohMiKFajz/1iN6FsRTufzj5YOfj7qnfw7Lj/7mKIRQnCzez4l5pc1Pi+4Km3I3G7L1QniH3h66tkQMlM0skM0W0Hi75PAtzgO4sODxXz52W5Ox0rn1DwN7H7VT+kiUBix1FaXFk/vQPyu8gwlZef7fC3362cgVZTkxwxQdUm8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833598; c=relaxed/simple;
	bh=PEVdEyWMp3HVrKR9TYMKV3fjkz7arurJjIDXn+uMMzE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vEfHYWOdPm36uh9Fpkgh9GS31+EjSfzz8DO4Uwh0VT6PQXbJM8gbFHQi1aCggZFgd5YhRS9NbFKM6KGKGbTIE3ss7Je+MP9CR80wLf7ySmINekwFwCpLoJHxwa6Y1vTcOcvq7OMKUmI+HFpi36WBVf7BNM8UsZkoRFOvGYYCnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363bde409b2so34044135ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833595; x=1708438395;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEVdEyWMp3HVrKR9TYMKV3fjkz7arurJjIDXn+uMMzE=;
        b=SObEB5gk58MDRyA2yWm+OpPh9X/g0l+lizwrKMezU1mT1XeSBy6/dAn72DZ0lpC8NX
         dxoFUX4wPxf6mxFz3Wg3CyAZ8peuXzc/oAZOHCwmTHC7gBqw32zcLpOVMha/mV8V+6n0
         nTC/Dhgk0ZyqbGh/v1aR8taMds6jSAu1F6qWeiLiWivb3qXmGlluwtEeTqdmBd+kY3Zn
         ct/eJmiRx94zOmDb4QMtahjjJFS7nPckulyAREyPFOXi7kF1WnG3UQu3NMQm3F85dodH
         SDvaBL1C2g6ksRKsNc7v/1SHTrEDdeGNJd+ME2CyyvVUxciS3TAXlzlHtSjnv3Mpakbe
         5+cQ==
X-Gm-Message-State: AOJu0YxUR7e08J9Tjdm6kfKPQc48wuo+j97pH1io2iWLxg/TLVq95jhz
	l2EeziZYh8vh5WIB2eUwwSYcijvCZUZttrIv57IBJM5hKOc1MFC2I/oscppr72wajPBugJvsEb4
	Jcd5capwI0hk16L9H4QtGPp5XA+Ilf2CM/UOdHBnQrsVHp8z8csyFCPlgoQ==
X-Google-Smtp-Source: AGHT+IHsR62WEqRZpM+f3SRViO4NCXH2qW/89hZa/womdZZuuLUL2F6K9YLaVtbDAMEgzKDvoI+lJC+4iFWm3NiTosxu26x5M0Oa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6207:b0:471:805a:3552 with SMTP id
 fg7-20020a056638620700b00471805a3552mr63050jab.1.1707833595858; Tue, 13 Feb
 2024 06:13:15 -0800 (PST)
Date: Tue, 13 Feb 2024 06:13:15 -0800
In-Reply-To: <000000000000708723060df6ab96@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1143e061143fe2e@google.com>
Subject: Re: [syzbot] [syzbot] [wpan?] KMSAN: uninit-value in
 ieee802154_hdr_push (2)
From: syzbot <syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [wpan?] KMSAN: uninit-value in ieee802154_hdr_push (2)
Author: n.zhandarovich@fintech.ru

Check that issue is still active.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master


Return-Path: <linux-kernel+bounces-133957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E789AB70
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B3BB21284
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FE23770C;
	Sat,  6 Apr 2024 14:50:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAC20314
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712415004; cv=none; b=bc8f74nVaiu109/WK4RST9++Zwh/xyNgDJ311QvrS15i3Zrw7hsO+STfCyCvcETASoswwSRAiMEemR88hVl9oeOYx0K4GebuJxA92jSTcNgYFgmur/mQmWjSauaCO7J01OuCpdAZdqwQpucTq/3p8+I12oWjd6Bpi6HSm/013G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712415004; c=relaxed/simple;
	bh=/MycvcpeKOm2Dt4YdnMRRXlOwbY6M7FEBdksizHV4wc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AK0dIDFLK6VJhAqGqQxCbsNqEFuLQ3KtbDsELMFML9d3JL3grAHaoIT9jP1kEuGzaGNkergD54LZxCX00IJO6UbGNLIl12AUok60mRFE2U5BSlwH4hSwsWVwq10wriaTqZri/pnw3QN0XMLFCf4nq6pqt0zk4ZrhsNkxcRbMpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a15771b9aso7611785ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 07:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712415002; x=1713019802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSfDQpNujcZDyE/BIIEjy82Odd3ZPcrCcgJQIaUQEuo=;
        b=L5T5f6iMAJHLKUv1/ctJQeqdTmKyY77M6EODyfwg8+5k+DEZEQ7jOdCXLTlgU1pK+R
         93j59RUr6ayBVe3kX76vFsLn/iIJfrfssD0FWWy5vHe8QfkDbTsTQKrBIUSKU8rhDXN3
         wBMYTExgyszKZ3yJsdmsFtHeY+GOiplPC4KKqfERTuko3Wtyc9vV1Z5r+QUIzAQjcR2s
         wro63SFEiLjBc1BaPOTcHduMSgldvgGaJodFSnMoyuWnc4MIutcSp6GKih+oUTW0tbod
         vc2JfFr3kkRkX+mehFSjGOj0GPXjkHgy/zfLhW7h/iV1mP5dWH51Q3vDtA6nc1nYJiVq
         eE5A==
X-Gm-Message-State: AOJu0YwdTgTImcyvWM4NhpfWsQUqG2+7qcTghXhlb0yFvywKBu7GTo0u
	43i0G8tznVAFNjdxO4oVcdXP0nOo34vbmkTiuDju1WI0ASsU1fSBdsnkh2SDYDT/Q6diN3qLra9
	T6BiMahjiO1cHBr/nhEQGPOSh1b92xYorqsKVIZmqIhZABszHfQi7Fs0vVQ==
X-Google-Smtp-Source: AGHT+IHFrr4YMZ610WoVekH4LCHv3mGbrVt7twWXy5d9m9osDx9FlsLru1TRNsZA+1Xk/mFCUYn/auodyODTj6gvYI6ZjabDSTWc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:36a:1275:4ad8 with SMTP id
 k10-20020a056e021a8a00b0036a12754ad8mr275731ilv.1.1712415002091; Sat, 06 Apr
 2024 07:50:02 -0700 (PDT)
Date: Sat, 06 Apr 2024 07:50:02 -0700
In-Reply-To: <ZhAd06NiYTRbsnWv@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e870e106156eaf0b@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com

Tested on:

commit:         6c6e47d6 Merge tag 'firewire-fixes-6.9-rc2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1001b623180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ce598d180000

Note: testing is done by a robot and is best-effort only.


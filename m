Return-Path: <linux-kernel+bounces-126200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83421893393
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3539A287FB8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE55614AD03;
	Sun, 31 Mar 2024 16:37:58 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171F14A629
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903078; cv=fail; b=BBQR8Q6LqZxLHCXW1LKhyvovTe1yp3punYjONfDR5CoFIwOye46jHigGn3idorA1dhZy1lD0+8p7VLmcWcCnqjmkAd7do8FX5eLtH4hlUOvOx/EbHjBTW8hmXEb/n0m9Uq5PRpTzW1rtRd4ICsuv6MuSBE6xtG+TJf7TMFmxADg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903078; c=relaxed/simple;
	bh=0pPA2FId672iO+EhkbbIOjX8z+KIhSHKWVbs6vDl1uo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eMCdD4TnpI1LHqkEzUOEWy67f0mO39O3zHh+AwBEjV60rZJlvUTdvHGSmVHDxNSXR2IkaYah5LKPxbex8w2LBzV9hEnYooC0Qh1vsDFjbW6z9cXjNMbbj6vgYQCwFIwMEkAXWZiniz9WhSErE/JI9CAYki29HX21R2STA01N3OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=fail smtp.mailfrom=syzkaller.appspotmail.com; arc=none smtp.client-ip=209.85.166.71; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=syzkaller.appspotmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 10D5520754;
	Sun, 31 Mar 2024 18:37:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lfkbe-HQElPj; Sun, 31 Mar 2024 18:37:54 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 448052067F;
	Sun, 31 Mar 2024 18:37:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 448052067F
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 38A1D80004A;
	Sun, 31 Mar 2024 18:37:54 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:37:54 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:12 +0000
X-sender: <linux-kernel+bounces-125977-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoAvHIFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 8218
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125977-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com B506120199
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711868585; cv=none; b=Dg522ZiaAUCa3d40Ga0zhE+vbY6qn0sfaEwjQXzIvcjMfPVDY+bvAkZsSMEHAI1fY1WYvl19XfVEAWReA31IF45sRoQxcyk2AyabT4koijg4nP5KoQwgC7k8MDLplGT81ssy+Xa9aXpgDrsBvssoXLQ/YPWSm3xMGsE1LwB8vU8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711868585; c=relaxed/simple;
	bh=0pPA2FId672iO+EhkbbIOjX8z+KIhSHKWVbs6vDl1uo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=grbQA7ZgI4npmE7nWHZu4ylCc4W4yhXe20whepK4BOPgz6T9eWLtSoHIOUqfy+liXyGTiMWjynEqwA2DtxjvgB/kFP0AZmhVerEZ9qT1fG703ub3ACSbGzYbr4Kv4F/jWGnVCWRLBg+DwhlNbTGeSanvWnruhQEsCRj4vrW/M2A=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711868583; x=1712473383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdKB7ff7cvQS5rwdXXkTHakFZyi4v67RcWzVnTE04OY=;
        b=pYLg4nAkBkWrFMBJza5hhQk03e0QdCoLB6Kp7ec8Y0x7zLyon1z3Je++FpeI2ZaRHV
         m1ITwH/F3gdB5nKA+Ew5C7E1FJuGNMdqYb8N5gFZafI4SV/XaNP+rqjIUF/L3O0KE2zq
         uZgkP1fSp6alKqTABJg9ZIVP0GfojSCgVtFqCyamED/DPHX8+2GPXGCOgm7xdt3xM1K5
         p/ClTz8CazUyyMfnZkegUKcWUvoMxhg4asR9i/6545hl2hPBccIyI648TckzoaE5Nb4f
         8qU0pLZpWYEBqdvir+cA11YlvRXLKf8+bN6jrMZzIay7AJp2CQ1oRvDfFgACP7ZDPoEA
         tm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuvEIwItdFnhs15QVWTI5m3VHmv4Liufe9g12rBiuRirx6k9Fn2qCt5pQ1mFP1oR3ENE9vKt/BPoDpeLjGiu4od8LIQE7K6WCIbL+E
X-Gm-Message-State: AOJu0Yx0H0KKMUigU1Ir7xlql5SvO/B57eT4rpdXPfJecJsIUfFZUhW3
	DUihZEceh11bA//eYgO0FDchz3pN80g8+z0BSPo75CftxKVU0PjdpMJlOFD2pHfVZidGFZ1Z2vj
	HPsk81iJiCvDyxoMB9TtaSI68RT1cm68Kn9YhIzPdbnfzhJ77kGVP47U=
X-Google-Smtp-Source: AGHT+IE6XBVLyx+XHQNh50pRRiuhGYKxlNkCb4GhC9oaEVK6jwVlzp1AqVG21UVoomYS8jI4KPcXIf/AmrAi8ViTMX+v8Lv4dupP
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:350c:b0:366:1f71:1f69 with SMTP id
 bu12-20020a056e02350c00b003661f711f69mr382426ilb.2.1711868583533; Sun, 31 Mar
 2024 00:03:03 -0700 (PDT)
Date: Sun, 31 Mar 2024 00:03:03 -0700
In-Reply-To: <20240331061958.3340-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2f1800614ef7685@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
From: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
To: <hdanton@sina.com>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1424fe29180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa663a2100308ab6eab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a3b92d180000

Note: testing is done by a robot and is best-effort only.



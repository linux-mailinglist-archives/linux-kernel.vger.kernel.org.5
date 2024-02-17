Return-Path: <linux-kernel+bounces-69853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A848858F78
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0D0B223E0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2F17A728;
	Sat, 17 Feb 2024 12:58:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7464A8E
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174684; cv=none; b=EfefdYvqPSwKPc3PvA5Lh7ppYi0tiJG4ZJfct+NVrsdWgNheJCEaPBye0Rh6z7DhzjcAyhxhPKoSQLP6sY+NRAek+a6597jX0rUh9UUDn8uGhYXrpv/T5BpjQLfsBisGRHuHB+Ra3Ds8qVjdSwaiwfL4jTT+bOE5EX7aEmMWS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174684; c=relaxed/simple;
	bh=V91F+XiGSNIZJP0BJI4TOAOEAYRSq614st+Z4QJMkKs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q3yXSoIbeI3bO/n34B5TNxqrnmRCuUGFtyvi+m+Ayw0txnkrUv1FqD5IXOgDcNbP/GtooRp5kjKB6t9ierKcZkLWWkILTS8A6hXJY2tqjXgWOmGCdvG0GqBoB/33ME1ESUPs/Hf6dTCkyONHonvOsfNLITUV3tPfdWaiDduf1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363cef35a5eso25344405ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708174682; x=1708779482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjGfsuesM7pj+DBL7gT4slzCZTyga7kmhe9BXoTM+UE=;
        b=ZYIYKvaVDRJlMCNUmQtWlNjzKhnckIS0syH0VfBW34TsYAbn7VvNnXQqgLq9cGx6/E
         H8YsbPsfSUsi2eVVK65vDoVZMQWXhaN8eeqX4A8CHH1qTbI4KlFIIbrXVwJUiIksICRz
         luOC9ASndX7ENNdHyJ1cRPAcck1Tnkq+MIhUOKLCMHDUL6jeugpKl279+sfSnxswTnn6
         B3EWnnmunSTfM/2RSW078FkKdmKdYXSpPdz4WcjP+jLPsDRbwGuRXC6ZrmufhJlW8XHK
         D6Z9lBu0WT8rwT73hkubfUvJAKkS7WjWlsGeTJW2rJ+zrsJh/rW+dYr8LcEX2RAQvK4r
         DaIg==
X-Gm-Message-State: AOJu0YxpzbiEMvjUAZ2kuSmfuBKd+l/ASU/+8sQmW7Wf420oBn5Px9tA
	6PNAXD0YHz5VTNFg9akowfimTswplP3lef7vJkUXwns3ivuaufFmF7XZp46tqPytcDmoI4dwIlS
	bXyDfRMghoozyvZZxf3zP2X/VgW+QkN7rPin61f2cMHODmAPykhQLD+5EYA==
X-Google-Smtp-Source: AGHT+IEy02N++BaFB7VwMswglToL3OH/qcEIsrhHfEXvfHFLwL78XG9yuaIE8TGcVUTabey5FGEp7y8ekBk350uxn/U7yQzmcCaA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:365:21f4:700d with SMTP id
 w4-20020a056e021a6400b0036521f4700dmr6805ilv.2.1708174682479; Sat, 17 Feb
 2024 04:58:02 -0800 (PST)
Date: Sat, 17 Feb 2024 04:58:02 -0800
In-Reply-To: <CAHpthZoG-4eO91UNScaiL1GUcoTZRDMQDzTZ0RvhGZdRZHHGLw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029e465061193698e@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/linux/skbuff.h
patch: **** malformed patch at line 8: diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c




Tested on:

commit:         c1ca10ce Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3f069371247b697
dashboard link: https://syzkaller.appspot.com/bug?extid=34ad5fab48f7bf510349
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12296ac2180000



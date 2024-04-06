Return-Path: <linux-kernel+bounces-133936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C871A89AB1B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5698E1F218E0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AEF36B1D;
	Sat,  6 Apr 2024 13:41:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1F2C1A3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712410865; cv=none; b=pgiUVA46K98hQIq0SPYeXB7jebbytFzJX/5WbvzRSXIb4IsuT5SOGYq9ZL+nVT5gpAj5GrmS4Fj1UrQv4CMqoG9K2zxbzlqu9eVxTle16Bse4s8H1zH2xHJIXhVicmBoPIc7BYtBZ0kNCXnMx4h9AT7ob4F4CJkvnuRRP6XFNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712410865; c=relaxed/simple;
	bh=98RGeaZ3siRbsFOO5zsfGLSPm4iOgDSU92FnJMBD/SM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RTgDk7sejwSu6/W2RBhyk4RpnShPLh0cUpP/skX+NOvj7rBhdxvAzYCLGT1cEzTI/XXz6AtXpxdiP2fvj8xVUbTh3e4+kmPKUeOy5SGia9FomPakkW9kWhbA6hyoYRui2RHdOIkwyeuMbUxHcN/IS3ZjBB2PoVU2IOBaMpRbFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c88a694b46so278925739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 06:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712410863; x=1713015663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9u41diGsDkme39f+PdTWEo3tMB+ngldHHsLXrVFgwZw=;
        b=Fij646lOuHil9R/Eo6jTVyyDlqQh40oR78UyOlpat6MiJHSA9aaaAH2a9Y0ThpSord
         ZwnW5ug1PuFGTQBVjiCYsORX5rnHpV9V+T+tAvhxCeWKII5Qw1OENpOuf+x9GHvuvY26
         GjxVcRZllmiFeBkVRYHtZ+Xmpcs5PrCKWNIMuOAQKpP9aYW6i62GYrYMpRIE52RRtIRx
         px1W0Otrzuxtu2UGkXbqPFBf3rybobEQKTUwTr0/Ae1DRZgAjU5T1XduqsnQGLNP0cjX
         BRYvyWIFo15CIp0cK837Pif+otTH9ZLHm7+XzvoBIEpANEuW6tKUj/ZVYHMlPf96HXLT
         3Ivg==
X-Forwarded-Encrypted: i=1; AJvYcCUTQ7T3YyyjglWdvAmf4vRzM/eK+iaIR7AlcMK7+/xgnyBill7gE46uJiDJljJq0/CZHaOvO3+EhwwouRscYMjg2n8eLCXwv8SVmhC1
X-Gm-Message-State: AOJu0YxtCvaP2UPXgM7EAy9+WOsmM/7qgx7w+HHq4PukGTd6jTLE2+hh
	NPI+VCsCj2A8SL70qrEtPr1bOgM1MIBG0Rc+a/f/HQ48zD6hZE+0Aj0OCbZOz0SCA85w/GN7wrM
	4+p0cdrtmHtNd9O8y2VDwH3NTIg8WFeQbC19HHlS41KFDXaz8wBZM8gc=
X-Google-Smtp-Source: AGHT+IF1mBXpRrSaIccnCRUlMNLGXq7MxlQkSrcdLC91KJuZiuLbJvSTvB9YdFYjSc28F6BQIG2Crict0Akn+m0Ii/uIx5zG7Xqa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:369:e336:cc57 with SMTP id
 g14-20020a92cdae000000b00369e336cc57mr227503ild.2.1712410862453; Sat, 06 Apr
 2024 06:41:02 -0700 (PDT)
Date: Sat, 06 Apr 2024 06:41:02 -0700
In-Reply-To: <tencent_3625ABBA9DBB0A33C69E1A1B8A4B7B1BC308@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a949006156db98e@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in sco_sock_setsockopt
From: syzbot <syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=141bdfc5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=b71011ec0a23f4d15625
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14167ead180000

Note: testing is done by a robot and is best-effort only.


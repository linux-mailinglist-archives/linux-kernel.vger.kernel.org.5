Return-Path: <linux-kernel+bounces-134503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0389B24A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3BE288154
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63843B7A8;
	Sun,  7 Apr 2024 13:32:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969B3B2A1
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712496726; cv=none; b=sDtFXHmxFL8TO50o4Rh86ZUuiIPj2KQxdqMNdLUwxFTFm8Ldup5bxv4juREMPxPEQ4Lc0IceluQ1KPDIaPtmlXn4P28Xm9+aCvu3gCUxTSwbf4ERcTljYl+wXVnPdzOHT6lhZiyD5QMdRgfZnFGE+lhwGssZIDCme6oel+xLGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712496726; c=relaxed/simple;
	bh=Q9g2jCtZAnTaO321KBZVOUc2TQZP9rVAKyvQwS8mCcc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L586EOxSDUep+BFjCHCA8Pqtk8wiSpMO0b0vL3+ygMYC3aY3TNg+NGj3WCB7teJ+qMs4/Qc8b+OsYJCapDEFa5fQiAdRUudsTzz/5VUXvqG6pc3+aK9hL+nh6wTp91AZ3gfaQsDyEAlHNFrmxcLTg20bHIztrCSNSkscZwOZBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8a98e52b5so319220139f.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 06:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712496724; x=1713101524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyQ84fLD60cZlRW/r0HMzxJieZWZ88ayu8b7NccxnOM=;
        b=mP7ZstlTG0Vj31/xwQ+knKQrPBOeF6+X7DLO9Tn+Jpe3k1jh0J7r9gs69yABbvTzC7
         m+tFItEuuPa6V5o5g4NILEn3n2kIhx2VX5Xu3kvHEVIjm2/QaY8sXyM6Hmt/8jLuv4eB
         KG0FGR38m5E/2z4jNwRLsfDNKJqVdoSmhTq80pSRXhdC2gLmEizkm5qEkNmyz7rLyckK
         ACzPIaT/5yfBx2rKsBrfNtosOEN3hwD0ayLQ3ocZRq9a4v9qo870EUDK9XSFc4APLfaM
         iY0rdcmTIBCZTpn2knLxFjq2ClPDEskcz1ChNp2ipwN2czcEZPAu/eWMz33jE7f2aJQm
         u39w==
X-Gm-Message-State: AOJu0YwhVvgrEEHWhm0ctxTXdbpYZ6taNNw+JyD/tDMCNjPOYmiwhwrD
	srgsK8e0sgmUQcAfrdV5xvpcwjH4REtyuocKtKIvWBrWI1zIppxQs4gjXcUSKDTVxH76AgrR3PA
	7PfkK2IkNIyABfAjF5hdepG4x4YuT750yPTNZIerbA9JkmC3lefwjzTE4zw==
X-Google-Smtp-Source: AGHT+IHg83ecyAsYnbU7BiPN0m5ucLJMzphg1bJj7R8HZ12FLBxXirYeMm7S8K0O2S6hyHy6oVHOYKhxEFtClySS7Q2ECD0qJAcT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1501:b0:47e:dc7a:6a89 with SMTP id
 b1-20020a056638150100b0047edc7a6a89mr383505jat.0.1712496724095; Sun, 07 Apr
 2024 06:32:04 -0700 (PDT)
Date: Sun, 07 Apr 2024 06:32:04 -0700
In-Reply-To: <20240407130042.26015-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb4635061581b604@google.com>
Subject: Re: [syzbot] [usb?] [wireless?] WARNING in ar5523_cmd/usb_submit_urb
From: syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1589c5a1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=330805b1287ebcda
dashboard link: https://syzkaller.appspot.com/bug?extid=1bc2c2afd44f820a669f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b5b623180000

Note: testing is done by a robot and is best-effort only.


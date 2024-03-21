Return-Path: <linux-kernel+bounces-110213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF341885B90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A48828595F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75548624A;
	Thu, 21 Mar 2024 15:24:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12038624D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034645; cv=none; b=kSb7uPHWXlVKImMoxJes3rtp6DKo3X7Z3Klq+E1nTJ7M0h6fSWBsRAkt0bkEzLz3czn6sRcPms0lrAlyw2T1fA+IJJ05YleQ3CrXTUj9EAx7/s4FTtb0b+pQPNloOxM9A8AxtkoKsh4mmQ3K9PWVFuCuu6Eq+B0u1UE0+3PYsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034645; c=relaxed/simple;
	bh=yGybokzJd+yg72sbXROHX6ZYxfcEdLlx8fW8rxaYUuo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g2JSurF1I0sftaPq76DRlVUT4vQr3IplR5kDyBArztzgQ+Gq0E/JqQrixo0PW2clYreKcSsa7OKmX43kY9Qo6Tk65ostUgihrRVZLcaFnasIvJHHVAuS7uRz7i/7iY8VYFyC8q/9jfGvKXNWswOm8fFy5ZfVQzKNeT7ln3RrJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf2ff0e33so107453239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711034643; x=1711639443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wb9cL8kWLHvuPt4ouPjlxwVs15/UE+6d6/NnUxfn/G4=;
        b=USRsayWlK6fdibCUCDyT5rJOZjUcDi+PWJao+fJPc2G0iOeq0aUWONLzFRGZxb+KVB
         zSl0rvX+l0cHGYAPhIEabX3X/uxUdhFw3vvD9w7WaZFgKNG6ePPTTgHoZ4K4J56yqzve
         ZM51rRIPtQMpUW3Bu2iKJEg9WikS6FBE1A0fvpTGiOH0O4YUieyZ85om5y9hLF4I4oYX
         qqsU+0kE2padqMgFfZuOTQJTNWwyFO1m3N63Dr+m7MsrHFa4I7uMTeGmUwp7cjyh/WLG
         6fTPa88PWXktxls7vz9zDMfKAm5RTGS2bVsxndI19jIJiS5ccOLkkFXzL7ijMvay+Nt3
         Vmfw==
X-Forwarded-Encrypted: i=1; AJvYcCULg71W4gCibBJudwcuEy9GYULMvS9FUjDMsRNC867sKqxpz8Y2sjuwjSudXrfPY88/NBp+GmntZL3Z0F/zGpQny0w2FFYIXOHiZtGk
X-Gm-Message-State: AOJu0YyodoZXklUoi2GV2bWQi7nMogk/BSRi70KPTIJvXsjJcZHewPKL
	3pcvcR/JoJMbuuJK3ZNwy8fvpZJd2/hOrtca6Oe47M9e9yFjrMo/yLIJp5Q+3wg/NWlaVIdJi39
	94ifm3NeSLIPc/ix/uVII5auIVSzcBol3RO1RAf1j9Jv92elH9wPhjpY=
X-Google-Smtp-Source: AGHT+IFiwwlCLIdcfJ+9kF4A18z2YILu8/ybxBF4kM6VsEWLcytJN5ZOhzK9vK+8CpP4FK4nOHQKK26abfvoE5rxpJJO6BsflEPi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1646:b0:7cc:838:7f3a with SMTP id
 y6-20020a056602164600b007cc08387f3amr464694iow.1.1711034643097; Thu, 21 Mar
 2024 08:24:03 -0700 (PDT)
Date: Thu, 21 Mar 2024 08:24:03 -0700
In-Reply-To: <tencent_9E7A866D382C796FF8943CE8A6ED26CF1C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019c0cd06142d4cb7@google.com>
Subject: Re: [syzbot] [sound?] inconsistent lock state in snd_timer_interrupt
From: syzbot <syzbot+d832e7bb0f8bf47217f1@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d832e7bb0f8bf47217f1@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=161b6dc9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=d832e7bb0f8bf47217f1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e7dd85180000

Note: testing is done by a robot and is best-effort only.


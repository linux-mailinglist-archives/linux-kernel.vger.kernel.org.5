Return-Path: <linux-kernel+bounces-93499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A868730AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BFB5B218A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F0D5D74F;
	Wed,  6 Mar 2024 08:27:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3D5CDF5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713626; cv=none; b=lSxixzynPmdXmZgfyyYrLdXyW4Uz14Hzy2TzhcsmZet25cPr/1760Czh36Ml54pkHWwGGqgDmu01d3Dl57cQJiNqy0AwRmXezIBkfIrjyHKmZLjcaPhcLWLLNOFDIXECxP1fqhGm8092CbEsVzY+0TogVUjHj3RZ5lL+9JcRtME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713626; c=relaxed/simple;
	bh=JlyL6DFG9I9DS9LmJAlSk/HEzmBIQT/HDz8liPmMN0E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q9kpVUI+tmWH8rUWEMw5jaTGukwDmXZn1HodmhW21f32xLp8nfd+IcR5wwazfoH3CjIb+YDYalhLGLflZDaadxANbS3/qIWvxGuttf3Z81AlAdlPaPTs/YtSO84u6Vocu7Tj+NElhwnnaTtIIJ0HeWOOm6vqcTO1+V+m/xTJVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3657ef5f01eso101887755ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713624; x=1710318424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFky0MkM2gx1sgYAsTUNFhAzVnvGAsKVinHJIY9WMw8=;
        b=MAwa1vnsEQIYp4i2Z6lLhJejho6zu3hPXL189wzpwLYJRPMsPVjsCLo4qzJCkZGpXm
         GUEgGxlhYAUiKFhQ92sC+vLl1kHrXd99tEq5CXM+EKne54dFNVldaS5RtIPujlBLaJXs
         +dY37MKSCLXJJXfajmeuGIbaJRv3U3iLXrC4gUegp7q26s/zFUsIHZc1xxRO4/bLZ822
         mJ3i4aq2f8iwWoSOlTCTxAiUmWQllzrD/e29jFvMCLtZYjb9fR510vGovqOZr8W4TOCG
         3yEWngj0bDSo0kQcVcM4P8tt1mUOwjFwmMW2iq7jvuIMFuosfz8NssZk8aVVcXOQgzaG
         s1HA==
X-Forwarded-Encrypted: i=1; AJvYcCVxxkAFqCPGUeLPDHtOKn253YRe1Z0KzsFqI9GflCp6OQHobhwDBHosXG6zBsbXN/TZM4qFMG5qAVS1DI1PUXz6tYdvbCMMsTreya01
X-Gm-Message-State: AOJu0Yzor77M9Z8jIdTnu+1AZ1FGCyCRrxy9oTk7X4IA/mEdE3BxoRee
	1GZPeDWcyXEhcbe+xeCh4vuvm2bCe2ZSD135j6upHUL1M3IilfXT7U8ZuzxaT+ztcJXL9tfr0Yg
	9ldPL0aaMdAqKoIF31q7YoCSIliTnqeZcYgWWln8gOHXLJeMY0L5k/Yo=
X-Google-Smtp-Source: AGHT+IHgyylix9GwtwXYsf7Xq6RBrR4Tb9F14qEFn1iDWpp1TrBRT1ITVHSPRlY+6AGoCx2u/CQ+yQp2J7M/jn2BnqkSxQGx1TAG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:365:1c10:9ce2 with SMTP id
 w11-20020a056e021c8b00b003651c109ce2mr882329ill.2.1709713624384; Wed, 06 Mar
 2024 00:27:04 -0800 (PST)
Date: Wed, 06 Mar 2024 00:27:04 -0800
In-Reply-To: <000000000000a97e9f061287624c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fde310612f9b943@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_port_change_check (2)
From: syzbot <syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jiri@nvidia.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	liuhangbin@gmail.com, netdev@vger.kernel.org, nicolas.dichtel@6wind.com, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ec4ffd100ffb396eca13ebe7d18938ea80f399c3
Author: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date:   Mon Jan 8 09:41:02 2024 +0000

    Revert "net: rtnetlink: Enslave device before bringing it up"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=163d5686180000
start commit:   90d35da658da Linux 6.8-rc7
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=153d5686180000
console output: https://syzkaller.appspot.com/x/log.txt?x=113d5686180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c11c5c676adb61f0
dashboard link: https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158ae1de180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165f2732180000

Reported-by: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Fixes: ec4ffd100ffb ("Revert "net: rtnetlink: Enslave device before bringing it up"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


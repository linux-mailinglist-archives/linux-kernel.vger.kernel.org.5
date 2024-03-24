Return-Path: <linux-kernel+bounces-112616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813CF887C07
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 09:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD9C281D42
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 08:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B5171A2;
	Sun, 24 Mar 2024 08:37:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08726D520
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711269424; cv=none; b=HP/NxiMS/E83zcKpg4/BGf/dgBFh2h24NzVo369HxEWnBwYz60u8Z4lUZbK2hDWLu6QHZKptP3pzId9MMW9SNypY/RlqxAJxYe4ert8XhqCOyxovBPJWXpFfoIKLx854kIHXRH+1BVXQxmmmf1pLrTjTmqfaqarXR2NR2mWeyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711269424; c=relaxed/simple;
	bh=14tYmPQEs3CyHiGchvoFwUfgmSdjXsja0blVcdmRCBw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QWkW4w2u6Gw0wVKKCR2zTeipWldsm6utIkM5bYzyfAyO+DNZLwcy7KRmRReGEuEGVhN/v9Fr5w7UVNjVyLxKYqDW0+l57iGPR97u2IJFI8ms6Izb/SkGkPtT0l17C2ia0VKgvDCghSlOzusjmZSnhAzbzWftFtXFo6SiRZ0HozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf265cb019so251306739f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 01:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711269422; x=1711874222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHc+uNAqG9Tf2XkO9MeTOtdp6u8g7/un/HgEhAdVl8E=;
        b=Ad1QD2XB76/iTVIKUx29pBWMNNXg5edz/NL7Q8FECHYY5OLiZa/RVPBKklLBtcemHm
         noPHTmvd82/7sgZ6TYFzird4y9wC2c0SDTJEJ8THbuE3dF3kRwlZOlq8F+oaeRMnZeVk
         Ivy4TxxSyBeXH2uaINMH3gsn42xVkx2Movuao3EyyfNekWqiUK2oEKCjicQvK2UgcPVV
         Xa5+fCkO6r8qivahiRXpzSeUuhjyDVjlToU73TqNsYBp/fTs9i/xT8c4GHq90lklYaYR
         DeEDsraySeg9op4Q7D42uUS/RuK5As+alJba3YMHfkTUcVimzVZMObepJW13AD3qvAaB
         7+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXCk9iDXUobYQzTKJ9dFgycHuQrjE6qp5G4jHTfeVLC8UmXyXFRy8j49Szpt0kAg/3EmlxWVGy3/Vf0FxW98n6MsvPjGP1AnSxe0/t3
X-Gm-Message-State: AOJu0Yz3fMUiYIcXmKYZiWscy46xeBJ0gXUBSK1OGzEdqSHqhJ7PSe4V
	v85edvc/nik1GDgOAnJ1CKzbdUDtxbhZwbseiQ8Fy+0615IqJj7HGLxoit+S2IefsTJgE0rY/ZU
	bGJ2i+yeJNzmSoJY9PHBylSDY5rmjYjArftY5EUDfPiJLvOyL6BzXceI=
X-Google-Smtp-Source: AGHT+IFS5mwHGgQBIEGBw1W4MY+ckTv6PfgXdkx4mzY4libLgoQiChHN4YGf1+hVLBjB3Jvx9K+U+q4SkRzhqg6qe1socyn3uzBq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:348b:b0:47b:fd8e:c03 with SMTP id
 t11-20020a056638348b00b0047bfd8e0c03mr206118jal.1.1711269422262; Sun, 24 Mar
 2024 01:37:02 -0700 (PDT)
Date: Sun, 24 Mar 2024 01:37:02 -0700
In-Reply-To: <0000000000007628d60614449e5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000077c22061463f6f5@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_check (2)
From: syzbot <syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	olsajiri@gmail.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 6082b6c328b5486da2b356eae94b8b83c98b5565
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Fri Mar 8 01:08:03 2024 +0000

    bpf: Recognize addr_space_cast instruction in the verifier.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101f5ac9180000
start commit:   ddb2ffdc474a libbpf: Define MFD_CLOEXEC if not available
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121f5ac9180000
console output: https://syzkaller.appspot.com/x/log.txt?x=141f5ac9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=ba82760c63ba37799f70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115671f1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f14e31180000

Reported-by: syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com
Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


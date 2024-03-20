Return-Path: <linux-kernel+bounces-109002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159088133A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0B61C22C96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72E482E5;
	Wed, 20 Mar 2024 14:20:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55647794
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944407; cv=none; b=YqVGYsQ+rw4J01uSGDWAzXmiG9eNw0dTjanRR/Rf3Ek5H3kHkeGIXbxrSH1Gne3GnxQSofX9LROs9b5S8bvtZZJ983CLfjfiE/JF6RtvbPumCMYSIPxDgI7QBgTcXRRE8YfQcuSQyEik5OVuu1R/ayKwr+QW2FQuRI0UISjF4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944407; c=relaxed/simple;
	bh=U4PenDBB1njw1+W+z24TpzT7efnUyBjddFGh7Ku/DCs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dzy2juY3kuhA72FUgOkQVxvU9CoBdZBCRfRxOx/lNo/2r7iZLew1sB8ObK1pkPPHVlu3YYEjsq8cHc7hqECRKNIGQzGIsstcTj9dv5dHOGd8Kth+yDw+k8F5fFZV4BXe5wjjnwxR0xWyJMpBnS3MPlqzwZTgAJ6PHtInTnjY6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so100140439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710944405; x=1711549205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1IUsR6kV07MDW8I1wx0WoXxXZKs91pAq00W+bBUR6M=;
        b=lrbQhmjkTmjHf4dUl7VpyG3MJwlDwSSa3QCq//rRWsNg1uXYsaQzLxwRYmkqkeie53
         +bdtu2WLYTjHYXTEaXLaQLcQLQZ/i096714WIb01iAl+9Ll9Y266+hmT+LjhrOl4t5oz
         U3YZ2NI4PorRFLjuQZPfVG1EgD+oHijlmr5NSf0M6QRftV+BAX807k+8dQauDRaUOYO0
         4zn4d44s8QUiQTQbW/6j0TP02EgfGOFxOmdkhYrElxJ69uM/WpoDkFFDGp7MWEJdloF1
         cbCdPQhVVBGAZO5FWmZPh+TrJtqWl7EKbGvZzFL9KoAtIvxcM6sbawX0hTOr4cTec9kM
         gTtA==
X-Forwarded-Encrypted: i=1; AJvYcCWoun6J+4F/OFsVDP5LzRrQU6I1Rr0H0+Q17n0tW7wJx5X1P4B3USMsKpQG1Nqe2O8UjgN9/pIXHNQh3SQIEYMN2CubG6Dymf5Q6ucY
X-Gm-Message-State: AOJu0YxoQNL0ASEpQKfWFoeQMG99GG3nMgmsOvaiduY/w9MgkYq1u3BJ
	wtxb+1bSTcLwctUD4Fvf3qGmdcXScEbOaVXzGhZV/kgHwgxYmFDt5KEmQ+N4s4Q5LKCmv08IWIQ
	pXcZAJZSkN3MPpxNuGy4gPVml1tcAnFgsM2KwQIIqbp9iWcl6wvzOiVo=
X-Google-Smtp-Source: AGHT+IEWPHrTc59k7P2wQWzcYopFmKG07JD0uCDKZoWRP8x0fTDj3ZrpQ0kLcy4ldIilE+R1PHKeJuAl3t17ypSJCNHgW+khmHGo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1482:b0:7cc:66b1:fa95 with SMTP id
 a2-20020a056602148200b007cc66b1fa95mr325628iow.3.1710944404652; Wed, 20 Mar
 2024 07:20:04 -0700 (PDT)
Date: Wed, 20 Mar 2024 07:20:04 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007866bb0614184925@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, elic@nvidia.com, haoluo@google.com, 
	hdanton@sina.com, jasowang@redhat.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, mst@redhat.com, 
	netdev@vger.kernel.org, parav@nvidia.com, sdf@google.com, song@kernel.org, 
	songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1626def1180000
start commit:   f6e922365faf xsk: Don't assume metadata is always requeste..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1526def1180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1126def1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14115c6e180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124fd231180000

Reported-by: syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


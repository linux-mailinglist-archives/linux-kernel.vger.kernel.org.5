Return-Path: <linux-kernel+bounces-46345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2CB843E57
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C9C28F07C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A4D78662;
	Wed, 31 Jan 2024 11:29:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F176906
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700547; cv=none; b=aavAIpOWpHy/IYAvDDxg6woiV2+4Pa1ZA3AorhHcOJ0JvTnXmYoiV03NAp0unmurxdsnroS6xsaG67fsjNRUeoJw/Lon00R3nIqVsmk6O8wkP3m5FaaA+BXdoD1BTCkq6SylgUS8YjBVmn20PIoQNkkSLQ7eI6YGktOhZsKgRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700547; c=relaxed/simple;
	bh=VvhBjcDQyhRQey66mVjt2h3hioRHmNNCtKdYCiX4HUQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eA4Vyg88t2fM3BqwjSot95wgHh/7YDkZkUGyHQiJ2Ti8Rhi7qf7Mor8mswgtDzYnnNxcjsI7Al+cNNbvizAJj8YTjbuY3aAdU2CsFIPdKzzXst4rGyDYv95Gfz3kjFmXr6s+RR2KMv8JvWHV7WLxOM1KIwMQPzlVho2afMIRk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3637e2a2e5fso4223985ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706700545; x=1707305345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqJ1VFyXzv77xQ1wVPZaGWa05ieFny/6Ks8ZB2AjPvA=;
        b=rAWTb7ppxWK5PhrUaJYFzA4S15sQBt/jVtycbCEslqSj5m2QvQIQ0oxxTkdlSAliUJ
         +7E0Rhn4x3pv/uII4DlWUx54XOXwN4rFk3yPlBgmWmNYoNMIa75IKCwOV/yYv/MQ5XFy
         I5epIJ+bBDEfjClmGRapd5a30p2D3acDWOtN6y3T56m94bj7CUtLSwPoFs+Jg6dgbvOq
         pwo7eeTPCtshzuXR8sQaTT61axxGdHCDXoJT2isN5L0zjedASxg9d7mb0Q+gZjMAIkxC
         T+4Z4Z8pkXSABvSZyuQ/zPoYh6hG5NBC8ZnjlkiLYyQaPigWsVfqjMy96yLpnVMhyB8z
         X7HA==
X-Gm-Message-State: AOJu0YwF8uPdVfv/TOnHUuhx6wPFQW2naYPu7pZHiNSrmCW/m1tbRemk
	31i9QX8m2VzXHAVTYu88pqR8O7bQldranxZ/yVFMHIxuUGNtM3Xyh8VNh69qhniixSV7EHFg/Go
	v3oxzLiYnfsmPE7arltVhhicSFcpYLd78DYWCYotRFNvkUZ4C5mdjwzE=
X-Google-Smtp-Source: AGHT+IFeKkJaobJHPLZkKWEyEX2ZFgisgbMXudwPhKUO8dGfX0qFXlrGqBrfI3CZi3++TC2CZp33TAjV+VmpSWNywF6WekjPLEo7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aac:b0:363:75a8:56e1 with SMTP id
 l12-20020a056e021aac00b0036375a856e1mr100345ilv.3.1706700545472; Wed, 31 Jan
 2024 03:29:05 -0800 (PST)
Date: Wed, 31 Jan 2024 03:29:05 -0800
In-Reply-To: <20240131102731.1550-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c041c206103c2f22@google.com>
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
From: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
To: boqun.feng@gmail.com, eadavis@qq.com, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com

Tested on:

commit:         dd85149d rcu/exp: Remove rcu_par_gp_wq
git tree:       https://github.com/fbq/linux.git rcu-exp.2024.01.29b
console output: https://syzkaller.appspot.com/x/log.txt?x=1132b337e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9804db253bdfc61
dashboard link: https://syzkaller.appspot.com/bug?extid=a984066a63e9c1e62662
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


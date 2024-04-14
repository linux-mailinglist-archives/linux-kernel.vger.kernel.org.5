Return-Path: <linux-kernel+bounces-144083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24988A4199
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E451F21685
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA0324205;
	Sun, 14 Apr 2024 09:52:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0D23749
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713088324; cv=none; b=hSjzBudCgCe6ugPfrlgYSvLS1XoMC/upb5Z14a6RJ3UrELdkp509j4T6HysScrgMxnU3Ers6F1zusRHH6l22YOp3ymb0tNdZRBXjXr/jyMMhCsQamjKWTaEqX2ArGV0HAzntHkGLSG1i15B1H46haeGEVQ4T6WPsueEuc1AHep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713088324; c=relaxed/simple;
	bh=rVjvMYl6jujW/aBZFd3by5bd6kS8zogQYswAr8SvPTw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jPUXXiI8dSVZz1F4VjOrx5KqvrIbD1nS4DP3iWwJ2JqF03uePguECWzutYwVplWvNLoca/lAOvbzAHajBAvXAtKNu0x1Ec/xQOhfCWDCnH7zmC4mdHT28pnNafJPGHiaoE8wmeQwBZf7huzRkI5ZBIEyskAsLyDeoH7ZqsTaqgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc764c885bso296274139f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713088322; x=1713693122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzM3bqULtIVPjR87hP9ImN5A5oCH9tbGf6ttArCEHsg=;
        b=RAGBmjFVnAzLtyfHE/DOnvLqL25eKkHOkaxcTIzasZBv53WLUUiynm1DM59IBnJ1Zk
         flDQ9LvuIPup+Zp7PSLawRe92m5PWl/vQcymw8rnuHDc7PXaGeDT4omIiwzPfFU+Y6KX
         Sj4vMVOGBH0eFMqVAkwXEAxpn2pE2xjOX+3AxGDexVgqeulNWMtnCF1F5/9sISRxFTDh
         hD7bTqOpdyC/N53R02B40JX2dNFz7LCY1gv5wMurV/kA0btJls/H3lPyTlF0ej5sWiif
         DfstIpviKRemQ8R3Ta67ybVGW5UHp5mw+XfCVt/bbo/h9paEanda6Nda/LJM8ArkzWA6
         Lubg==
X-Forwarded-Encrypted: i=1; AJvYcCXeKa+LkNDWWhnQDAm1ZiOD3LIhrEl6MSOP/7ZXXHq2gww6mP+wX2rCvV7PkzlYRtPuu5/1ogTh4c5p25NrSDgRzVg+gJ7DrziLn/cG
X-Gm-Message-State: AOJu0Yxg553ftLICfgcPUGwZHFzXClYjS5r36f9962wCDU/6UPXO1lEB
	x6fmSLMAdZnSpBlUTMvxeEO5wAuVh+i2x+2SZts5hLezXPCvIhTBnTvqxq4zaonYLNBsdZjr4Mj
	198A3wv8VPAciND+vVKzhq/RIf604/LW9KCxmZQKinKkK8eVq8+Dz1AI=
X-Google-Smtp-Source: AGHT+IGGxlCEd7pcUal9YG77ZBkKsFWHBKangnlYHynjKo+omomcgitaM+2Q2aIBJ7WR+lhdBP8q6Sd9TIgiCJdRiOR2/T3pzKze
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1646:b0:482:fa29:27fa with SMTP id
 a6-20020a056638164600b00482fa2927famr89660jat.1.1713088322293; Sun, 14 Apr
 2024 02:52:02 -0700 (PDT)
Date: Sun, 14 Apr 2024 02:52:02 -0700
In-Reply-To: <20240414093011.2358-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb5fe506160b7425@google.com>
Subject: Re: [syzbot] [can?] KASAN: slab-use-after-free Read in j1939_xtp_rx_dat_one
From: syzbot <syzbot+75ec36af46e2098f253c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+75ec36af46e2098f253c@syzkaller.appspotmail.com

Tested on:

commit:         2c71fdf0 Merge tag 'drm-fixes-2024-04-09' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14ba600b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=75ec36af46e2098f253c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c0ceb3180000

Note: testing is done by a robot and is best-effort only.


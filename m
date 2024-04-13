Return-Path: <linux-kernel+bounces-143590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC1A8A3B2C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E661C21EAF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA61CA95;
	Sat, 13 Apr 2024 05:54:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C51B952
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712987645; cv=none; b=uTUjS3OadE9bHU0O/F+7JBHbrxMAZJ5lgg6DcAO91dOSR5Jiaqj+1gM2WuTd8GSXt5W/eccZzG0IpWna2wEPedpkoPRaGr9pkZWBcYM0n9llhAMUXAOe3veLKjjlcCm5H6wFk2w2YNVnYYy200SXiEXmbiQeITHNuYnWG6k6AD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712987645; c=relaxed/simple;
	bh=iLXiiE03jfsOCfGJ6FOZM4rgx6BrtVKCoGcZd4n6Aek=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d4Hznlq0KX+YiQr+H/N+uW2NkdbS4gO0i9Swf01ByefzhmSkCN6YJX2cmkGfSGdR8MiF7QQjQKtpKwF42E4npOkoRlxR8d07D+NEvGkU1wKEDSuSHwC7sT+WZSvcgT1lPga6TWzdpVUzxxq2bhu7Sn42UFFcmrO8nnylTrWLcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a1989a5ecso17700435ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712987643; x=1713592443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhlGuU+e7cJZnBZe87XF6+irnPoVw1a7xfHb4KdI79o=;
        b=X0eBZUx4R/TWyTnMCirVPKW7xMRnpuKFnVqPU80yC7+XmuuiOp+44zMs/gKiDNOzDN
         fJvaeFSHtnpPxbu0G0eUYdgb/ZVcbybxc4B07ckbMQQ+P7kZ2l6Iv3BY0wDB2FU5Zdsj
         31YEgG7CVOvdCiKfHtRjpA5n2G460W42V9nY128+tP4P3D7tx5ymT6caU7aWhZRvN523
         O3U+UoIDC0PGSvouw8j5sQJm9NLHsSwy6x/mSq1hVGqWRdVYnKjRJFefFqYyBJMpHk4Z
         GjKhG3GNfb+Rkw9xJ+oRsDQ8REFtC9j8SJsaI6o8bgihKTMmqI3aKVgwfVwg4tTxFm8U
         XwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9MaYIvigCzdyLhCssKrKfZKZPs8isfyMtMVahyIQPiSigJnjC7BYppj/y4v0NkUYragep6msH1qXQ/zPauMsMxasKDe9QWLnNrM2M
X-Gm-Message-State: AOJu0YxY7TMo0XHlAFH2BweqzAwOgjanQ0uaTOZYGoyOwrRSjNGYYC+F
	VHqRKomSI8qlZYHlV0OSL6VYwn8pPJNQlSr512XJdBy8Oc97fEIop+W9R7a2fnlQje65K0gtzvD
	+3fu0DFM9dkO5kjxhbtEH18VwKZIisGTTot8oUq1OB0vbumT3pUcDKLA=
X-Google-Smtp-Source: AGHT+IHiIzUfuJmxoHEhP6eLx819i9Hyqgs2goNshHUB9Crt++BxZUymlMPjLbkNJWinAa8b5f9mQ0FAPgXMK2qiTSiFk9wZKK6p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:36a:20a2:e4d9 with SMTP id
 l2-20020a056e021c0200b0036a20a2e4d9mr246966ilh.4.1712987643196; Fri, 12 Apr
 2024 22:54:03 -0700 (PDT)
Date: Fri, 12 Apr 2024 22:54:03 -0700
In-Reply-To: <tencent_2E487A6E6D182D096F0097E4EA8AEDFACC0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa43890615f40328@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
From: syzbot <syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

/include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"


Tested on:

commit:         e8c39d0f Merge tag 'probes-fixes-v6.9-rc3' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ba01eb180000



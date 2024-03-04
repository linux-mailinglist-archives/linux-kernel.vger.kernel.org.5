Return-Path: <linux-kernel+bounces-90056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4E786F990
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAF21F21714
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163EB676;
	Mon,  4 Mar 2024 05:27:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E833C5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709530025; cv=none; b=Fs0m5ibcrapCEKC8r6Mt9nNWBeifwle5nHsubUmfRG0r97pp4pzwaeg/5v6mNLBDBm7vNFqZRlx8GyOzVVeAl3Y6SswcUcI2kdaZzBDrQQy1MVD8YT5POAmDUwJ3oS1nUQY9BxlBik4Gc3/dHlzBoDQ+GQRjpfwdeCzWbByQhWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709530025; c=relaxed/simple;
	bh=QpTcNn/QKKDXBkHK+dfH/+Ce9WnDMkQrFPljooN1J4U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ttrdNPRtCQ96dtf6XGMdFe6liabK434yUtWwggnpal4s4Fxc6EuTBttJc1e6TEAmG9pxCzc1sFx1qX8nry3lEODIoISoMelZLlEqibwuslNYSz3CdR7g1PqPW63W/6/zZ0t0COn5gUgjnFOboHoZW20NfmJsluXwvajofLY/PnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c858e555d1so29894039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 21:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709530023; x=1710134823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PeZRlucJ1lwBjXjtbFWI5UI+NxNlqTF0cug8QuOBcU=;
        b=BHfUya/G6qtJpTpXzrHFBj04BW6kP/ruF1UIocy1ZjsyztGXh8PXSEYdfq4ACC+qRh
         9dm1V/lJyrZvn98riPavX6gexatcJoPoda6zWAZVr9+GhwrpENNdziiDw4PtA5sJkEL9
         pOn5ksmKA7n2Xfefqk5+t0JLGcLZibPj/CfyoC/+AR7ROe6QaDeX0fp+QPgnWNv/KQdw
         nVtTwOutuUjKhSLP2NpDKo9doRyj42zOMUv/CQ3F/987knD01/bm6W7vwsToZpbmWmQk
         hqeWek7ULFmyGyqR/8BuZUQfDRow00yMLd0BvVUZwQUNSih7KJIjPKPgpu8hGoqn4I7A
         hr9w==
X-Forwarded-Encrypted: i=1; AJvYcCWMOkvH/NMLrFNj4fN0LeHBB/wPNG/W1WC/m710ivPgwNvpzEVzjiHDzGyeczTHck92Xkhk6VkuwnDxexJf1pSBEEUKCqXTtmgEIi1Y
X-Gm-Message-State: AOJu0YwZ4MmSZYFHuFyhzXVQ+UPijLmr4+ePy3GRhx9rdkiITHC0sdeS
	RZDNN8R30Fm/ouqwyPYeRd+HO10g0VT0uw4MI0jsywd/MVdSOcgbEvW9SHRKVYj+hXa9TwOOYAi
	W1+900IqHdlsYgMWGdP1kASfLLriWyuZf6THFs2vu6mT2+2SkSAVOYnw=
X-Google-Smtp-Source: AGHT+IHfd9yXpkBCnoF69oagwtvvPdgFQISAOu0aRkB7TOS998hMYB+gQUfWbjtG8TwBcGTNlxS4h/gGwTpAyKKKB9Na1BU6APg1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16ca:b0:474:c881:1bff with SMTP id
 g10-20020a05663816ca00b00474c8811bffmr326225jat.2.1709530023127; Sun, 03 Mar
 2024 21:27:03 -0800 (PST)
Date: Sun, 03 Mar 2024 21:27:03 -0800
In-Reply-To: <tencent_806C802F5D6EE895B4E862EFC6CC947B720A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2effe0612cef9a1@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
From: syzbot <syzbot+c6d8e1bffb0970780d5c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c6d8e1bffb0970780d5c@syzkaller.appspotmail.com

Tested on:

commit:         90d35da6 Linux 6.8-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=177befac180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db27810a659d0b3d
dashboard link: https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17bbefac180000

Note: testing is done by a robot and is best-effort only.


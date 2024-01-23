Return-Path: <linux-kernel+bounces-34992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EA8838A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE99B23164
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA7B59B4A;
	Tue, 23 Jan 2024 09:24:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8958ABB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001847; cv=none; b=cdBi7XYW5VQRPXQsCnJWHgJaSOk8STiUJsgjKSeoyYKzr61+O+qSUDMwr9HCBdqu4/zaWASfzhINaYxzdqpEHV7w5P6gy+x836ssnZJxeK7pUl+MHDgwzGn6GqBN3KlciWyzF+DEUpmkMsxIf38oYKHv5/txYDha/7mfKyp0NNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001847; c=relaxed/simple;
	bh=smxt9XuoM74nCGHa2KTaT8LFOM3b/ZQ7RbbKvJ23ehk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VOLNjYk6Bvji6D3MGYFSjW0bm8VI8QcvomLIF414wSReU8XlBK6D0xPZk1qyCij+R/eXQnjiiYfNJ/1EYDfMUGq1KsF32xL5WAkFJ6RSG27lb11Id41HYHqOrHTPZFTXZT0PA39kCTV5yItLfPRq+q0pgTlGM76O5sZUo8QIe68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3627d99cbe5so20212965ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001845; x=1706606645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDKWAHGStyE66y/xlPIuFnvNH4CnxVvWeCuX7ymdLV8=;
        b=CgiktwRn8+B5DhCmvaE4I9uiehrnuf+Qoti9r9Cm3geOClnvwZulhSfN/UJPaiJpI0
         WkST7c8NBupJfw4uy2dt88v9Mu7aohmvv85LJ/BAGkVoyw+50BCWKiwoTtUEWqWLb6oP
         QIoY+edqtcOLkpQ+TuWwbrb72MCQicCYN6jv1wgpMbth6ZJin7Zg8Ubyv+Em86RkkDyb
         bM6bBeOLwOB77gK+4G71tro5rzDvUMKZw+06MidpRL+zTocRbLxxsCNytALcPucSzMmb
         +wCzccnGA5t6TCk8ZKnDMR1fVFRE2uXy4PsHVFMfaB4i4JPJOQ1uFMGgSsxE9R/4uH/M
         DmHg==
X-Gm-Message-State: AOJu0YyaxP9Xb1VKZHbPWzwlGxv2V66KNZ3QVQoTLpboGc23ChxhWvLz
	Fd3qBWasJ+WgQx5jvnuUrbVpN/5Jvt3lNl/mslBFnIrPzNW27maSVvjEswdkb7cNEEYZybwefC7
	rKL9UDTdMEYOg3+zMFYB+vwewcWBb8xpcSspyynspxyfu/7ZS8QLOjy0=
X-Google-Smtp-Source: AGHT+IHlnAOlbk9604ATaA0d+tElhvg2z9P+ujZDKnUufKSuKThByIn9xuZG2lkyQVL1dF8M9+A6HkRcbxs1W25H5S/E7hL6vXBJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be8:b0:35f:a338:44ae with SMTP id
 y8-20020a056e021be800b0035fa33844aemr741203ilv.3.1706001845362; Tue, 23 Jan
 2024 01:24:05 -0800 (PST)
Date: Tue, 23 Jan 2024 01:24:05 -0800
In-Reply-To: <tencent_9744F767376B06D113772362E96A43A14405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000faa7cf060f9981bd@google.com>
Subject: Re: [syzbot] [can?] memory leak in j1939_netdev_start
From: syzbot <syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 98b1cc82c4af: failed to run ["git" "fetch" "--force" "--tags" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "98b1cc82c4af"]: exit status 128
fatal: couldn't find remote ref 98b1cc82c4af



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 98b1cc82c4af
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b9d95ada516af
dashboard link: https://syzkaller.appspot.com/bug?extid=1d37bef05da87b99c5a6
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1401d2d7e80000



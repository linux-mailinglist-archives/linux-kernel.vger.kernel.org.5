Return-Path: <linux-kernel+bounces-150627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD778AA202
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B9F1F225A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9ED17AD68;
	Thu, 18 Apr 2024 18:27:19 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4C16D30B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464838; cv=none; b=axrzttsSf37EIOYdp9ytmk/O9W0HJwJ6EFljHAO2I4Ei9oVnEkiHR93W7dLjMrcx1WhZYfc4mKIaqNZp44o8vYJFbLhMoyMrcseYlSHjohDKTE3MVUnIh8TBhklKvOkE9EQ1b98W+uI3OkqCqbOhb/LLgZCuqZbIrXWPraXp+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464838; c=relaxed/simple;
	bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sy9thJRM7u4SZ6aSvck/FQVk31OGjhn7BrF9WcXxYU2fafYx6QpcY0ZWY2S84Bp8+kF4x33di2dY2Wcb9cbQmCIjCE/qU8libggyAWgcg39hZXBoMs4rGmGi0ySIEiOldvt8M2YbDF1VCr3Ov+LEaO0cjtANZyGjcXOe/RoSJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a1a2f396aso15425505ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713464837; x=1714069637;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
        b=X8X8A+cRI8tguUEr7y4+G4u+COhNwPaiwxBn07N715SVM7XmUTNo8yWMPZXsAhvzjT
         /ULRNWfvmLMjT8Bl0GLgg948rc+ydn9FJ/wmapL9m9uA2/IIMmSrAW/GEKdSGnKpzaDx
         9TG/WqnjROztsTlvFAqnVmmOhkKkqR3PDWUF8murNtQTTU0g4XnQgNcXjwdIOhlueuda
         YbnMzLy5Pow2ZpmaN719s/yH5gCKqPkSQ/ziOxJQUFqYkO7hyMu0DMRDlsfakiA98dnl
         Jw0mgtpkkw9VNYXDxk7XD1B9rj6pTjm0tRtqZnl5dr7nIrej5DCFYbKAOTCWglk8deXd
         ciBw==
X-Forwarded-Encrypted: i=1; AJvYcCVP7Ghk87PHVa5UdMolgV4FIUt128kOgDxMGHMBHdQGIRBPuRGG80//3REHfwqI+EHVb4Z3x40filu8Kbb9kSx2Ny5rsBcAcn2y0DQq
X-Gm-Message-State: AOJu0YzKU5BaJKC61EBeyip64FbOeEdI8JXHeQQo43zJ5JuEBwWY9dqr
	1775I/MZHkrknx8SJdmipUuoxjANFM8fF0voNAPUt3WaBpWtoErO4TWe9F98dK/x02Fegrv8JXy
	xW5yTFv6SQyaXp7TAPJWSNdn1UiYmm57fWfkZAjVGt34uKYOty6vChuo=
X-Google-Smtp-Source: AGHT+IEzDA31gc0F9RRvsZZF/gSZWsQm4Y6V2uPL90Ae6Iw6pW6GD1T2cNU2+K7lft+xRk0EoqR8YaFFWMJEAeNWAMQhYQXxDrC6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:36b:214:bc2f with SMTP id
 dj7-20020a056e021fc700b0036b0214bc2fmr165289ilb.3.1713464836829; Thu, 18 Apr
 2024 11:27:16 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:27:16 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef47400616631ea7@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos


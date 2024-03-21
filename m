Return-Path: <linux-kernel+bounces-110129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80E885A71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A221C21260
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C684FCF;
	Thu, 21 Mar 2024 14:14:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEA134CD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030444; cv=none; b=pq+eEl6bHp3BGfP8qunskDyI+98fMuMUahb8/FVs6KWdYJOC8vujnkOalcXkdDWEASuZq3bH9yZBxplcM2ivUbRbQUrB73LONgLeGfMga1TY+bU6o9TP+9K6GH1AEaXR9GPRSaycixPRChsU87iMLPvMvfhxjlOxmEXYdjtdDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030444; c=relaxed/simple;
	bh=4XbNPAh8Z3zYRb0BBUiZXNrWwOXuGI8uIImGV9mr0yU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c1Hclmq7k7cqJlVsm72F9nxgeg/f4kpyHk+XHXytojbCmM2U78z41Yjjf7HoNbrM1MXrGtY2OtN9kt4d5LMFBYgI1UkpDTEwvQoSQz8eRxyvy/SZaHTkgfI7jmws+x1weoKebxbDwIgGMoRPicMCfh3Z0x2Eae1d419kmvA8DTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbdcfcd458so102717639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711030442; x=1711635242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jc78VNLNqYB3IsM9jGxysd2/w7v6sV62o3Q3Q/Kwm+s=;
        b=s8sZhxvF9Fw/i4YCnaKsusuDqdvJBQID20IDlauTVXDz/44I5R73EkJS5FeWONM4qK
         cScqr6CUbd8FmHckZ+aJIIsnHcvmDxiYWMf9aBondruqZvIFg1HfjZ7cyQh7+piF7Bmr
         o/ri3k9D1lFjuGuQXm6vL4akCRsmJCNZGaraMHafeb1pf+LxJNjODfz8cru7q5pxjl1J
         4QjLJ+OoODpj9+DAaKlbfObTi8oSxfI8Lq+HmygUL/3bbrdZWLm++/3letZtFszNpG2A
         LmBTKB3Yq88bHIn0q9mCiz5jEJhAsST6ItWT2unSHO+MGgIjbRa22smpfQs9QszEGBiD
         Rkuw==
X-Forwarded-Encrypted: i=1; AJvYcCUw9wEuL1JaPNm1x7YU7/tXT1hj2nS3IqX4WoSfJP8ShR5qlZs8j7u/9hjDaFeEy3Ku4L+L/H/1IpekuTERDO43W3v3TbMU+wv8hXIn
X-Gm-Message-State: AOJu0YwUmBXKjIFU8ayE0JbI0pDiuHH8bW3lNjGiB/Pvv4Tvx4giDYdb
	OXAocOsY3TSk5L3V5ZP/C8AXYO06fqMPZPorxKPwmQNsFbAUW0a1dj93zz9ThjO2PCWJ1ZraXa2
	5TF50Cb38S25Z50+ojVtD9h1hgl9O0dC6Ha78Mb71wDEuE1M3ShLQhfY=
X-Google-Smtp-Source: AGHT+IFMFoFO1vF/KO/qfZofAJHvAiJm6WUY2AWIKYkAq9+OI3ZvcoxEgpzXxAtHk9hzPp8012o+uJj/gjvHfa36G7rlqXzlf1vB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1501:b0:474:f25a:6fb with SMTP id
 b1-20020a056638150100b00474f25a06fbmr539463jat.3.1711030442153; Thu, 21 Mar
 2024 07:14:02 -0700 (PDT)
Date: Thu, 21 Mar 2024 07:14:02 -0700
In-Reply-To: <20240320234741.2355-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4680106142c5155@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in wq_worker_tick
From: syzbot <syzbot+8627369462e8429d7cd6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8627369462e8429d7cd6@syzkaller.appspotmail.com

Tested on:

commit:         ea80e3ed net: ethernet: mtk_eth_soc: fix PPE hanging i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12324231180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=8627369462e8429d7cd6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15812546180000

Note: testing is done by a robot and is best-effort only.


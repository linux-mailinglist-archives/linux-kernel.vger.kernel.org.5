Return-Path: <linux-kernel+bounces-31329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EEF832C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45B3282D56
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7005D54BDB;
	Fri, 19 Jan 2024 15:56:22 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73C54BE1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679782; cv=none; b=FtnLRBqg4VjgZk8Q18aw7iXaZavmpfnmw3Nq/F8z+mfYlEOyNRBTUPgL59AMC2/FynsXBeI8Weh7u8xHCKotXrCPkdYby87Q3KBooliF6UNOvadOk5+Xwd/L83quTODtc0M93b4OP+s7qIjg91G8+0jlLrMMw8dZG5jzNdIdH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679782; c=relaxed/simple;
	bh=12Nnjy/vtsodJroqaUX8Wxo3D6Lm8TnydEHDdBU9vJw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KbHjVsG9KPxfkNcmzJmO2iNplJ/FSZp4fLPxJgh8KEQtEYMZCuwbDkPrRb+93npjwOyTmySx6V3Blqbvo6e3hHfkeK7HtnJ2/oRAtNix02B6YRU5BZGiZK39RjHbusDLT3f0pK7pQqFJG9+kBC+rGDjbOQeeO8ykAa3H2K1GcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7beebd130aaso102457539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705679780; x=1706284580;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12Nnjy/vtsodJroqaUX8Wxo3D6Lm8TnydEHDdBU9vJw=;
        b=Uiv9y8tPUP7zxDO7ttYGvExzkFTfscB3uAYMQkEP9EmUngaB7+ZafffQsTJkYtGY8b
         2MEWoudtU6L0GJFNiE6mqBU9+BazU8H0Xe60+izFQ7tCl3Tv0sNVrkN7D4vckgz32t3i
         b0JvL73cO8VNwfFv0A29zxTOUjJ90BCrPNF3gnnjzY6qAKOfXmJUMu2IL6nvh3CM8qTD
         ZaQqBJgJcamTBtdkJKAiYPo59zRqXpDH7ax4hgUQjbPF63HzO7plniZjvOAL82HKMiHz
         teBN8kH4YG2MmsCDkClX0HdJXcK5W3caxOd3ZYQ2nBBTE9EP6WjfZOIFC7lsVhzqRcpp
         pk1w==
X-Gm-Message-State: AOJu0Yz3rr87ivBSW2I0rMnDwZa432cKsTXhL6D5jgmTAImlo/D4+byD
	kC3P9Y6+wziZ6zQIlEnKK3hsy4Fb/7GDHTcrjhDMd5BbhY6eV5kgYDzTa72tQ9RNULHRqMBxCNB
	V3pP4mK+1lyG6Aqa/3Dd0zyaxPorbta1hzALpEx3Oewn0PrXP9giQL3dnWg==
X-Google-Smtp-Source: AGHT+IFzRS/yaGYkQ+vRe1BJAR9mAENb2cYWL8nLTZm4ZCFz4uc3yQtzITnOUsIb6f+qLsNPyIm4AX3CZ+LYsm2c19/7WjaJJlzt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2585:b0:46e:308a:832 with SMTP id
 s5-20020a056638258500b0046e308a0832mr70629jat.3.1705679779884; Fri, 19 Jan
 2024 07:56:19 -0800 (PST)
Date: Fri, 19 Jan 2024 07:56:19 -0800
In-Reply-To: <0000000000009c91ce060e87575b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061739e060f4e8599@google.com>
Subject: Re: [syzbot] [syzbot] [kvm?] KMSAN: uninit-value in em_ret_far
From: syzbot <syzbot+579eb95e588b48b4499c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [kvm?] KMSAN: uninit-value in em_ret_far
Author: n.zhandarovich@fintech.ru

#syz test: https://github.com/google/kmsan.git master


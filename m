Return-Path: <linux-kernel+bounces-49237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DCE8467BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6E028B1F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803011754C;
	Fri,  2 Feb 2024 05:58:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEC8F4FD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706853488; cv=none; b=us9wQWtcy7gEDLjvpFdiXtkkH8w2wj6pq1DN7lXbLtU244ci+OaYt6oE/K9QUSmGaZQ5RMnqC7+1Z2YD1ERmtjSJrIWvjv7EwZisU7Z+YQGNk/nRgJLhI6PUgLvwSyODbmqrHUQ0R0udXrbUxaK9C2BWKx+BjHI9YaV0a48u/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706853488; c=relaxed/simple;
	bh=BSbszJ5Y/AvllC/4xf/jfFA62CQHhAoN2ik1m5evc4M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HPzS4r7vYWoKQbys+C/G8ga0jVNqg5Pe5292PuGstjJWQ+GNzxtLO4bpEP/u9h16lykq57S06wT3XB576cigBAV2nsRRb3jCylRchp47qCeKpN0QnMnsVAyHoSC0j0IVcHiWl7FlB5ZDc48mTJTi1B5sBBq12kkQl2lXHU9cHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3638c09d8d9so12373655ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 21:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706853486; x=1707458286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNS9efCs9xd6ENVLUcQazqKgHqMzi0P1Y5Gnxr/6LRI=;
        b=Ox3r7I682Ugj4hAXPH/75ZFDRTau5DMyrpuhnCZJE+pnMFQ4YDyxUWYXuLyIfubLi6
         vSDF48uDNigdSm99++toFkK1CM5WElcX8iq4/PRmnBHjo/lNM2gFq4Xxo63hTqnHsfMQ
         X7Kgkw7wlMcrfy5pJH/+J2ZTOYQPCE5jjRMRNeYT+upf7a1xcox+LSq2cL3oi3GXBiyj
         VLS7YO1kxr0LyqPpCMVKny0ukI9jASvPEJRY1LqvjzQ/9dhY2R4Hi3DXbnMnhrFdJGnU
         gMAPwc1E2YfdOFc1R72ecZpfBDpeVwyGlucQG/4q+82M4bzOy0RlxU64b0n2KL1mhlaL
         zWcg==
X-Gm-Message-State: AOJu0YxIHXfNxonRTSWvFxrpDg5IYFo8YCgRAUHRVL7P3fzLabIB9Rhk
	IZDlK1FwifIsOlDJUl7IPsyYjAvNm/DvfdVvy9VEy9f9CpRYxq9pqv4b1EglQiKmP5mwVvjWMjj
	EnTjQ0X7KRuDoLFlcElF/q0NaGVuBPHqA/uLyFcDYsAXd3arC+H19oN4=
X-Google-Smtp-Source: AGHT+IGjwrnS9D+vDzeyqgJXaM++uthEE9qa1/9iczo6r2Bw1MiHWgTHV2o0N5U46ye0bPVI8uAhhuVQ6V/OitNmIXioGwwJLjFR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e02:b0:361:a33f:36a4 with SMTP id
 g2-20020a056e021e0200b00361a33f36a4mr382116ila.2.1706853485942; Thu, 01 Feb
 2024 21:58:05 -0800 (PST)
Date: Thu, 01 Feb 2024 21:58:05 -0800
In-Reply-To: <tencent_91554BB11BE325DDBA70BBD9331A9EBC1B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6a56d06105fcb46@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (3)
From: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/erofs/decompressor.c
Hunk #1 FAILED at 252.
1 out of 1 hunk FAILED



Tested on:

commit:         02153319 Kconfig: Disable -Wstringop-overflow for GCC ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=88ad8b0517a9d3bb9dc8
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15eb0838180000



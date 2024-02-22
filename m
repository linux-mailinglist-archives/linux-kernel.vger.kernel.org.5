Return-Path: <linux-kernel+bounces-75864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE785EFFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB261F24D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A823F1775F;
	Thu, 22 Feb 2024 03:41:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBD28EF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573266; cv=none; b=CYSLqziDz70cJXKtzVTXLbmV+6oBDs2VtDkZLk5fTnGCXqmrv0O67E2X8pPhErPZw8UzpU7nqbZIiag34ZRQOUze/nVs64V/4PAcbgGcCQzsrKSpAjzebnOsrsCzGYXkcjwIX+cyzM2pDQvOL9Yj5DgMrxe+FG0Gw6ZuKtalvno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573266; c=relaxed/simple;
	bh=aoUmwboxcQssiTsohUlnKaa6wq/qekuPRi030rCJNCw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uNZWDRq/nSEhuYQvQNshM+VG1cGgRDZxU3jgTHhiJznNKb/mr7EuhF5dDsIyXOKWVVMDKZpgjNoGH82ZJJwbhZx+ryH5a3KrATDTjwiRLF0mOk7O8Iq88UfwBIp61xEQ9sTxZUfXnp57mULx9Atbm+rn3TiCeYPLZEwpES+ce8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36541324e57so26561545ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708573264; x=1709178064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAzFF/W+Tz54pu8G8JB7QVdFqeLOi+89YAZw0zJOldg=;
        b=k6GfG6BqNbPN8ELJa1Or7LdjnC9G253f4QYffVPXEMR88XD1jAPfJWYrFGsNVa+MsX
         AFOdVGtOAYuEdDwIHZwz5YUQyvO1EJ4+N9oHh//ZT99ku7+3UaTxJrB8pUJCJIt7ngAc
         bsRYzo6go318kSpIr0u3g3Hszbh327qlc/e1YmkwJJlOQx5K0iL2f9GE9/DkJ/ZKm/XQ
         tccxBML8m3xjO2k/jLxkZ/JqZ2ZJmoQEOZFzTmgwBKRLFwCoMf3ssppWBgwLFAKy9LDO
         W9Tsg9orFxirBXd/k5Is+PWc4XxIbL5KJIXeYOfl7SgkoRDbniFntZxYcgOTRRAnomL+
         MemA==
X-Gm-Message-State: AOJu0YxgFSIY3dNsPauWSKmlL4mT/zdBgqBVTQZ15vsV7HCRfVaSDdQU
	jz2YB4AriXHpRpnx/lVy/6JDhEmdtXkoJZhNWqvVlhAZqMhIwLd/Db14C9D0clnZv/IVXdqYpH4
	Xx/A5jxHQtwEDYO7L90Utd9vDPN0u7HwjGn4Y+M6mNQjOa/Gxqu211lUW8w==
X-Google-Smtp-Source: AGHT+IFXQ0s2KhqVzZuuwD75OfnZVmpMGvXQF2DYLFJL6XnQqXRM8VEKnB2D+v+Wn3OuiFANbjvmJUL4c1yuzLDU3lB4vG8i+u1E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2143:b0:365:1780:2ca9 with SMTP id
 d3-20020a056e02214300b0036517802ca9mr1105869ilv.5.1708573264058; Wed, 21 Feb
 2024 19:41:04 -0800 (PST)
Date: Wed, 21 Feb 2024 19:41:04 -0800
In-Reply-To: <20240222031539.2038610-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a22870611f036b5@google.com>
Subject: Re: [syzbot] [net?] WARNING in mpls_gso_segment
From: syzbot <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com

Tested on:

commit:         6d5c3656 PPPoL2TP: Add more code snippets
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=1234b4f8180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=970c7b6c80a096da
dashboard link: https://syzkaller.appspot.com/bug?extid=99d15fcdb0132a1e1a82
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11727f68180000

Note: testing is done by a robot and is best-effort only.


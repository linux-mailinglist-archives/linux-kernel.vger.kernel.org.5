Return-Path: <linux-kernel+bounces-70298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45818595C1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892091F2255C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B3125D5;
	Sun, 18 Feb 2024 08:46:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8A10A0D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708245966; cv=none; b=Gpl7U1WeDOrnFpKVaCotu1zd51F4hAN2xlhdmSMlh0BbsWXz2OzZ7f+riRAR4lbsbot97IRFWYbaHUaC5PAxRC0YRNztGnrzrL5kj5l6HAtw1ghHc1m1621VCHHLKQ3UW7gETZU7PAiNBd7KQr6ryPHnvk59ZXRnBkq0TiLQ6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708245966; c=relaxed/simple;
	bh=IV8cJeH1miOJdHLTbeSju4FAVO5IRLuI8VdeWkYgSaA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SJ+SGIzywNEzUFIEIng1HM8hOpdrYR8LKGEh//883mXEhxNCcroVQTCn/RGNp2K0qRqRRrGpH3eD8UyYz4i4q9gVvkWfa8MCsZLXWcXbTaZgfBAVJ17XZXEhDeDfDebf9jJOPdOC6giSO9BR9iDbqvqSvunqfAFFzEZrzxB9rCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-365256f2efcso5940715ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 00:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708245964; x=1708850764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvBZmxbpdbv3eTvup8ChoTXHTNy9zOx6bgi37VxLF9k=;
        b=sKEUopm2B/y1YZ8stkxvt+0qeXQyUzMJWRqVmVy/+G4lh5qcLN0Ng7zRPtaiuAJwtm
         ebUUI9tR6JRFqUUoP3ocPIKY/Qg+4sKECPvLnFtQfc+arkpFIEuMu9pfCntrnuShRdnW
         DWeZc5iiJSjxuwGdUB23381LlqfwhIREuBirYCTITpVT7Fdh9KsNfIPnEBdX1eT4kxC5
         rT9o/65TwBtC5PN92hryWiI7x8FT9iqz4Qe/9X7i+V3nszvriYRQb2N1FGtjWl5Poauy
         xqD8E/O7or9tRrlhTY4NVk63qRDjVQkQMH/xT7cpJtrOb/jBG82hHB4QvkMplA4Y339s
         CWlA==
X-Forwarded-Encrypted: i=1; AJvYcCWQkxdDGIYv5Z7ei6Gk9s/Wsm0MgJ1XyDiwcBITBFgbmgxvfTnKXAUZj5NLcGAjzgE++npkzjaFxcjqg1eVVXjXLd+MXimqk1fvqjgc
X-Gm-Message-State: AOJu0Yz/DHhSLcop1izrjkttaGqHsSq+vGO+mjUkEran847vzatw+Ch2
	D7gf+roeVmI18kFB7+CsUcimxUGxg7IHfzeS25PF4Tkolm/uUDvXl7nbuRj1KR4rtFCcKZo9jJv
	xvqzA8ZHHJQNzUgvKplLUNIf8zjzuLnnwIfreOBu39VIVymK6ncJGRrQ=
X-Google-Smtp-Source: AGHT+IGhDFB0ZIAdrhCAAdG7WiSqnpmVWvOugcnWwqTxQykW782tMI5Z0ONr1iAFhtMsw+TE9x3iI2YW7a+odXClPrqVeIK5jEST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4d:0:b0:365:21f4:7008 with SMTP id
 q13-20020a92ca4d000000b0036521f47008mr237697ilo.4.1708245964016; Sun, 18 Feb
 2024 00:46:04 -0800 (PST)
Date: Sun, 18 Feb 2024 00:46:04 -0800
In-Reply-To: <20240218084414.1254-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfd6170611a40107@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From: syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git on commit 2c3b09aac00d: failed to run ["git" "fetch" "--force" "--tags" "fc608f7504e8b3e110eb6e7b798cef357818c5e1" "2c3b09aac00d"]: exit status 128
fatal: couldn't find remote ref 2c3b09aac00d



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 2c3b09aac00d
kernel config:  https://syzkaller.appspot.com/x/.config?x=176d2dcbf8ba7017
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1219de58180000



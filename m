Return-Path: <linux-kernel+bounces-43576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF508415D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71B61F23EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23DA15A4BA;
	Mon, 29 Jan 2024 22:36:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE6524C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567765; cv=none; b=YDI1oGFgiNtxzEnELxngczOSo4iam8imIHYCK04fxRMEqE6RxaZmK5YLsASZxsvWalwlP1dUHsPiN6Ld9MyLVGNaUurr3gcfpqS3mI4FxWI4yICL6i/UhD4FefxUhVReP7hsWGOEOJln4joHiVBH3ca3BUkTCfxKkGjAhPxBlQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567765; c=relaxed/simple;
	bh=euiU8terl0EWpgqFQ5bL3X18nbX+ON45QTpVACbbAjE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hi1psgi10paoIvAjOjQ/hP1tHY76qnodlUG5SWA1gWyRDnPpdZaw1x8nnVw+xnhKqsLJEo1K1abR3zUsgMq3jgPWYGDlOs8XVIaaTKFAqgVhBnZqfCdKxht+ZZEssNDdLcnOBoF773J2+C96jLMrJ7gPsrheTKYAGS5T+3cpHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-360c3346ecbso17174945ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567763; x=1707172563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LaawQ/30rYEp7t57BKkjQDVYrmgcFT0eTG0oi7N4Mk=;
        b=BkZKcRGFJb1iYZqjKwA15VsEOpYQMe47sB6aOYiy5zYOcH0Qggh+5JYk0sZY6u7k0C
         AdpnG7aiWVSNK6ONRdcC+h+67M1GBcJ1L8rNDWLg3041BEZqY7Q+wjtJHOsDGpl4nnmb
         SwbjY/6V3CGnyTY1Sbkn2HcGwKrIyR8o+CSYnRerS0CTmaqDDyy49VUYn3CQ9jpVW6gb
         x0cx6ZrNxBgZ5qjyO6pxYak+jCuE0kRSfRwwAkNKYHKvjpdsufejnbh7ov36ThkQ1Cze
         z2Bho+K8yQmQm2YMV2q8U2KA67+kCdLVaVmhDPn4YI+omaXskiFqDc+nHSHXbfVzGiKD
         9uXQ==
X-Gm-Message-State: AOJu0YxO2D1aCsfelX9rkx27VCYcas+y6I8kZZILvMABO/Ve7o0jgeuS
	H8BOHKtJ9k+mosvTRkm7e0xETaeW6XUW7aNggB47TRffFmXvmR+LZ092YRWdJ4eDvBwyDyLogov
	ZAIhO80l0xLmTus3IRcEUrceZ09OqbxT9KfhnEVYpS5SktH842n/yWc1Ptg==
X-Google-Smtp-Source: AGHT+IGhmVG/DZAwgzKo+Ir9qYlx6O8mk3+uh/4Z8008rv6se2MMihJOIq9OpPHzZJmKA/t6Iyj3poBcSHEExrK2PODDHBWucDTG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160c:b0:363:7b21:c860 with SMTP id
 t12-20020a056e02160c00b003637b21c860mr573761ilu.4.1706567763213; Mon, 29 Jan
 2024 14:36:03 -0800 (PST)
Date: Mon, 29 Jan 2024 14:36:03 -0800
In-Reply-To: <3aef3775-1468-41e6-846d-35d740852889@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fd8b906101d454c@google.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_route_info_create
From: syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sinquersw@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:ThinkerYzu/linux.git/fix-gc-uaf: failed to run ["git" "fetch" "--force" "7f85d17015ba166311ead463ef566bfcdfcee3b7" "fix-gc-uaf"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@github.com:ThinkerYzu/linux.git fix-gc-uaf
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
compiler:       

Note: no patches were applied.


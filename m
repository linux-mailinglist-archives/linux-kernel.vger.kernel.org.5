Return-Path: <linux-kernel+bounces-39510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD1383D230
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5022F1C2625B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EB84C9F;
	Fri, 26 Jan 2024 01:43:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251124683
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233387; cv=none; b=Rulg8nsvxajLd0yL42veRzRNM09HY+LwezuncgUbwQ6tlI7GEhi5L+PX0IhWadYCQG/otimsf9hXhb7dvl8GrmjAPz0u62MqOVZDcpVEdy+XgKC/n2K+rY1VQ8lbZg/Pi65ut1Bml1iTEduhDa3nZ168yRsHfTqStnYc7YpnaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233387; c=relaxed/simple;
	bh=W4sKgLf37l/hG3tnz8eexsaxMPkwfwvTiafPvJkL+ZE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tm8jE735VvuOrCtnjoUZCvLOBr5gvqygiWK1Lj7qVVjm+j3Vsik6R9RiNGikojKbnXup395t5mfu1WxxL+xOjlGXdSNUOjtf4eBr6WU9zld1SCSde0CFpgpx5L854CIb0Ejb5yfHq/dHWpIkjbiOOpt6fDM+G+lTiKQJckBoaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-361aaf3f03bso52770765ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706233385; x=1706838185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61lwJK50aEyzlC5X3GEgrgc10KRILCmEU5SsNvi/Amo=;
        b=HPFGXYrif9FB01HGNyGNmJKOIPaheVVf6g1mi9HPGHedKSzcOF3GWx2DS/Rx73P5yc
         1ip7ZoNGTaQcRXvdX43NzzidEBG9+iX3adBc4Mlccg7WG2OoFFHrePyskkY0fhA/sDeR
         HkFcTw/vbyxTFusj78OXUVXNIQEi2qKRWdrtWijfGSbfsq6KhUURn6jEX2uneFiweUhn
         tbCtsbaa5dA/fz/URy2IqzcuzKC2B3hbpKdF2RcUBafinzZa7uI0FNAkxrkvcaK7VDhP
         YF6MZUfKlHoP8MtMnw6FZ0UdIp40XkxIhlQUFoa/uRVo1Ag1VtHLupPF0fjsKE7pA0uf
         7Vng==
X-Gm-Message-State: AOJu0Yzqg6URkIQVgy7XaWVGaQza0QimgTZQj1G/iPsKX5Y7tffeMfxE
	94jIh0/atXFLh3pN5FDFscsaafvihxJ1to9gsXAs9IZqDvp2Gb+3sVS2+fFSgRybDsUcv/isspf
	hDdKmCD7co6kOwgTbk4uoFnDbb42sM2Xinujd6uMJH8fKVaXOaT/G2a0=
X-Google-Smtp-Source: AGHT+IFzHOtoyv4YKjv3Py/sXSJJzaYjUbKsh008dEE93obhGasHI5JJCjhTZUpK9RfSUCcmciOqqUg+nHZAYk89qW9131umvgs+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4a:b0:361:9322:6ae0 with SMTP id
 u10-20020a056e021a4a00b0036193226ae0mr67103ilv.6.1706233385380; Thu, 25 Jan
 2024 17:43:05 -0800 (PST)
Date: Thu, 25 Jan 2024 17:43:05 -0800
In-Reply-To: <tencent_613652973C377A4AEC7507777B66C63C8309@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6f6d6060fcf6ac6@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit fbafc3e621c3: failed to run ["git" "fetch" "--force" "--tags" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "fbafc3e621c3"]: exit status 128
fatal: couldn't find remote ref fbafc3e621c3



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=132ce437e80000



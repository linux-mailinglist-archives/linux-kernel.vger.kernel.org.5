Return-Path: <linux-kernel+bounces-60173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F501850107
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20AE1C26CF7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F111E23BD;
	Sat, 10 Feb 2024 00:17:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01977366
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524226; cv=none; b=DKCTg7N4WYLQKbbmN2b6JcYIVaeJ7xcdycjGm3FEYvjV9MN0OSCURNYvqJzuAoxL63cFkpAJyECb9jBT6QGy2WqtLg0XNqN176Iwx0FnSTe/Zj9dnG4xsYL+a/JyXuv4fSs3yBKpEfY14VvFkT3GzQwWIU8IDKa8TTfNz/uIaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524226; c=relaxed/simple;
	bh=NpdXnujk8uz7fyDvZkKu93W5CtUqe0+jwrGTxj/TXPw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qhtmUCz15Z4BNaEggbhvDMnh8+cQzwmVAiPBN/HwIvpk4edMphIf06M8rcnoJ1JmnTt1xTHLIRDZc+yJKBGp913nXqa74KUzmLOaNryV9LZuNTEfEY+6HUy9ZhB0RqcG2U7bSCmtizMUzO1jNM5SoFlg8x1BsOxNnfGLeNsZE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363c3eb458cso8641965ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524224; x=1708129024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ho2u/4j61/FIneEGCKP7KoT1wGfcKHFvYYyBQNKibs=;
        b=xE+rzoXZkYCxbjYrluL7/I8d0QPZoSfMlxUyz6ttf4voR7bYcDzIQq4VrXiejlBCIP
         S4tiTvojUIJ+04oKgwLRS55rA3Zhs7grPufX+QDCDuhdyjsJcD9wIGt3nXOGY9HII73K
         qPN5mMdr7de/w2wM9azq3e1ZaCC2QQM+vYK1WdR1s6RL8CqArjimZRxGTGBfWzdTGE/K
         Hu554AszFaIigsbzwMCMepiOClMF7a9WsDhbNt/b39VTKb+HUceL84lVAnT8GxRFgWQ0
         uS5cmb+jLoal5YvSzPgYyaksGbM4afXRI1sxbQ+hmLTfKbC8I8J8TV+Dyf0aHOOTaIeO
         NFCg==
X-Gm-Message-State: AOJu0Ywc2lQRtVsI+GSHq/PYG8tmTyz2achd98ipyvd6ZWNjj10F3PE0
	7rzuRM4y73GL2Gy8hJR4V8QfDz0oy+3WdeSPBwx3GmBCjvP9XAOStAPXHTESHrIM4i+ssGgmj68
	NJrx8X6nzO1Wym0iUNU9h01GJ4DXrmuY01NJKsCFDHLh7klh2xsSQtxo=
X-Google-Smtp-Source: AGHT+IHVwO1+Ok3Qs2xKgOA7VWr2yJxR61qKMQapUl1jOQtA/TDgElhaWMT1cLj+MV1sfU9WjvC3v/3ChfrWUnCgOgwH1ugEQChT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:363:c8ba:ea5a with SMTP id
 k2-20020a056e021a8200b00363c8baea5amr48953ilv.6.1707524224116; Fri, 09 Feb
 2024 16:17:04 -0800 (PST)
Date: Fri, 09 Feb 2024 16:17:04 -0800
In-Reply-To: <20240209-notdienst-watscheln-4ca4930cb089@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2f71f0610fbf6d3@google.com>
Subject: Re: [syzbot] [block?] WARNING in bdev_file_open_by_dev
From: syzbot <syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@gitlab.com:brauner/linux.git/vfs.super: failed to run ["git" "fetch" "--force" "81e322358ba96b4e95306c1d79b01e0c61095de5" "vfs.super"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@gitlab.com:brauner/linux.git vfs.super
kernel config:  https://syzkaller.appspot.com/x/.config?x=85aa3388229f9ea9
dashboard link: https://syzkaller.appspot.com/bug?extid=96f61f1ad84e33cee93e
compiler:       

Note: no patches were applied.


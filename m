Return-Path: <linux-kernel+bounces-167084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0E98BA445
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE47D1C22349
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B41C6BD;
	Fri,  3 May 2024 00:01:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E33D68
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694467; cv=none; b=K9vCDmQk3n43IiTBrAQfQ4lq59AXpoGrMMzjGRkSbJWS9EcMr6BKX7IWwLmpZnGe794qc+3rvDuimG5k9jjzXC5wZyfw9x58Vj6cVU1tlNr8RUBuZLwgPKrYYPBnAHzPKf3KKAlLZj45QktDlTu2UrzOI4iZWRUfgj/y1w8MW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694467; c=relaxed/simple;
	bh=UucgdoI9Rv74uMss/HA+zbrw+jrrNrtqHAgCtfE4d20=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DQTZg2qaaqfT5Sw71rA4nloCwvww2TnEOrKiNdnrq4fhSPXVOSOoKB9azVy/eZbRh9FgmgAvX2aJytBQgk+lw9zQ2q09CDWvDYK6Crml7l80+49XWroKQlM6Ai52hLi9zeTFFMvF/rrSlZIMff1FaxnRBvZhcnM4wewoaIkYyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d6bf30c9e3so942662939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714694465; x=1715299265;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoOHLgo6Y9PwTh5VNZrvA5iJ3AMG7BGXoSjhDtrjLLs=;
        b=SstaCslGLEEHGnD54F8SByrq9m/jH5y8C2H5saZsPHQvsq+DRbG2LJzariBRzuCZu2
         74OCf5cB1kmcdzNMOrH6Ks6zqtp1t6P6voIxUTJYE9iKnbwRO6ciIaAmGirwBVuayGL8
         VdL3Tnv2d/KDxOa/V8PBsnC8yacXhL4aN7rjIwGMlj9DlO80nSJtTXycZVduHwxFi8Gv
         jInBIFshE3hGdh6S//DTPIcHf48D3D3AMlbVvGep/aIoq/MQrnOD+UyeyjZKOSZT4DyU
         kuBCsJEBoh9mXJ62oQAl2ySuC8Ey6aSF9s06y4bm00CDHr3jdaLG8WDozcF/Qu0SuGo5
         2s9A==
X-Forwarded-Encrypted: i=1; AJvYcCUg+EzO9Sm9zU3dUM/Tk+7rT1YpsAOyLryPV2YcQlSkvRMvlhLjxZsoLM/S2kQtAlmGMhLcCJgAEc+TcStul40wKXc+EsayZtMyyWdu
X-Gm-Message-State: AOJu0Yz0dpn2gFDNPnCdmrOjKbeVy6lyeZnEp3AfAs2epbsrvTLtdhRP
	G2ftDNwUOqGfjnFiAf3RSo+WzuKtvQKu0pJAgB5HiToQC5L6vkY0De8ELT0MAngjrH4e28cWu2u
	8UT8tJyKBqrylBtR+lSZLUdZVAwlYU8FzE0oj/tE901581PHr7c+zaNw=
X-Google-Smtp-Source: AGHT+IG9J4OUG2zWBfCEhux5ccJFvEXQLpEJQzDN27fWMLmTEKxbzhbJ6jwSV9+imdvHJonWtO8lQjhcICCQBzrcZMOP41Dom4Vz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c19:b0:7cc:cc9:4332 with SMTP id
 ik25-20020a0566026c1900b007cc0cc94332mr36905iob.4.1714694465456; Thu, 02 May
 2024 17:01:05 -0700 (PDT)
Date: Thu, 02 May 2024 17:01:05 -0700
In-Reply-To: <20240502232247.1845-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000831ea10617816ada@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in folio_unlock (2)
From: syzbot <syzbot+9e39ac154d8781441e60@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9e39ac154d8781441e60@syzkaller.appspotmail.com

Tested on:

commit:         9c6ecb3c Add linux-next specific files for 20240502
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1119ce38980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25ba1e5e9c955f1a
dashboard link: https://syzkaller.appspot.com/bug?extid=9e39ac154d8781441e60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=159e778b180000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-49812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693B8846FC7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B2529633F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8D713DB8C;
	Fri,  2 Feb 2024 12:08:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AB5FEEC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875686; cv=none; b=OOsulIQdT4zfc6bNZCjx/5Nw247OMNCbG1lo2nx9NxGXA0zWLa2AoxhNMXQqZ3Jq9F+GmURxw4QM4pAEJf7yc05kXC8vE6773EXXGHND9gI2bU/2rof/sMPXDqshLHYtccGbrJk1tIP2oHjloMIZtDQp3OZQM3sM5qjUYlRjkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875686; c=relaxed/simple;
	bh=5sLCD3MuB9OzAqYw6d9toAtS5eD5iP4j9fVotwYRvFc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g/bCDGJg65j8OVAvM3Rllp1++oKMY1XuYm+uGz6o7Truqi/u5rqSoxRFVXZEOnLJm05kNSj1M0jMtQUAZy635ZFHPWCRksklvxukhahEgMvHMj6yYaSmZ3ZCICf+4W/Z5IkvwcvlH375ICQyoMyDyT0QQE0oIrmv75hbnCbdZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfd75bf218so182938839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875684; x=1707480484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=radyFDzDEoKTAo/BySQz2s5AnzlvlFlE9g1TBTwDoeE=;
        b=ZXI/zFomv7IbzTf1PE7nJguFbskFE7K1Ma/s904ydwEMfOeNRi/GNlbMKw5fVa1wXn
         wt4jfOzCmVDVapC6tPugnxeBzwcyWI8V3jd33DNp6TacSkxrs6BhHkpXxkVrc9FbzU84
         eWqUlDP/NVevsoFD/vj5+YitQjJUw/B7fWhyYr6l3ieL8quP9yY3cDwAR/4ulZc/AfYw
         ul9ppYNg/T9rl34x4UWBU6oMhmDVEJ73WZ3XYMSdIw5o4R2EXhTb2d81tKTDsBDQ+nkv
         cwngqoVer+92VyUskem5wqnOdoheCogNqpN3JcbGSjt20tfitoCyXvf37URwB1MSkaOW
         fZqA==
X-Gm-Message-State: AOJu0Yw+uERpKsMrREu4+sT8+gWGPY/Z5EskZbVAeMBOkffLjwkncsm4
	kfknWrgFhBow2u22O53AUFxX8RPqRJao0zEvHo7vtPWeQkbzn/I5yAIA5GfTx3exGEOHjef8oJM
	dY+O5X1yw5zEyV/pGrJDPJ5DuZ3/caydKU0U5US579nIQZE5cGgTiSGoPOw==
X-Google-Smtp-Source: AGHT+IG1mhnz4fhMT3ZgAA5deHvtFTwobA2Xk0ZrszTf8A18uVO7uS6EdttmAsC7Abk+chKkcklqJFcbGcTYTQhdeIUFjwgGVpUu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:363:9ffd:beca with SMTP id
 l7-20020a056e0212e700b003639ffdbecamr170534iln.5.1706875683894; Fri, 02 Feb
 2024 04:08:03 -0800 (PST)
Date: Fri, 02 Feb 2024 04:08:03 -0800
In-Reply-To: <20240202084133.2624148-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d07eb5061064f6f2@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in v9fs_stat2inode_dotl
From: syzbot <syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com

Tested on:

commit:         076d56d7 Add linux-next specific files for 20240202
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=172cf5b0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4eccd90d3ac887b2
dashboard link: https://syzkaller.appspot.com/bug?extid=7a3d75905ea1a830dbe5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108fe43fe80000

Note: testing is done by a robot and is best-effort only.


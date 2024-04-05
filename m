Return-Path: <linux-kernel+bounces-132923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D5E899C10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2611F238BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEE216C69F;
	Fri,  5 Apr 2024 11:49:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE972032D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317746; cv=none; b=oZp08xiKaMlxC24xYtGYdS992vlX1Cl9Vzr26fwRWFcaLUJhANCr8PNLu0Y3Cd/2hL4vHxmcGM0mx6O8lQ0+U+Pr2h4kaURKkxIK3B0f7QLYB7kCZJYT24+SCR/6Nypw69R0Hq/DiOyuECmyphNvR4AtCpzKYqtL1vbyujJttig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317746; c=relaxed/simple;
	bh=iuJ0oOvr7o3R9DX7SFeNsPo3GqE0MvplUqMzCwp1wjo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HJSdCZVd7giH1RFrC13Zj7QASl13UPmpOyGwV+R+BgvNND5dIbV37LtZU8/zvS6F/5yVccqVGw7maaa05mmGXyHc9sOtSnbkM4Ga2ZwUSe8QCQYIaLwBd8SlO/XR+yedSUe9amW4dlGbFO30+tPcRn7D6qFHM8Bq1JNySthPdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so224093539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 04:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712317744; x=1712922544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I20oMVc/N5z49C49MuvYM28xURnCUIAvg0LYLO1HBnk=;
        b=iwqzuscNgUTJbMv+ECOaa9Dn1hCFDHRFWz0Tjm4cT/6WLL47Mg0jwO8hj/FRWUkvBQ
         W2pOTYcrCaX+ujeUvTyD+YYt66lnprrm8kM442tarG/fAIPm4DM5odUkBxcYg22eumJZ
         MzG0X4XrMtr8AC7d3197tn//q/tc9KWPD75S3Q8S2otamntbObLNOryld31YwR1XM26+
         fTAWjiBXpPBYw46FlNa4JjLjny1JC/MF9YItuw/F5Kd+2SePJ2viIsp7atdgnJLrlNfs
         Gi9aIxl5OSiuurJXOSqjEAsf01mvDjsZ6mE4YnEeskWyCT06EyeJb0yDxZlD+ROLjd0D
         8cFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGdeuvH7V4KdgnKNDM6Ca8uMCOC43mIT3tIETF63lGTLvW5BWO7w1YtMZszxCrzArgx7Z8alLJOElQr+36UOVNLm2LQiFFPT2IDhjY
X-Gm-Message-State: AOJu0YxxTLnP0apF5sV+RXPbmD36/t5guiBh1s3Vtu8gqAJBelbh2+nj
	DOBgxsnPRHf7EHi2SCxXfJqu//o9HYVJUdVwSUAJ7MIb02rrAIfS6rEShemd5L2QuoLMdSMHsZI
	nyLOeqAwIBGeB+IhwCahmVBdCqTTvCUAmHVodHk/di3r709lO04J14I4=
X-Google-Smtp-Source: AGHT+IEi8GDmcepfF+m+5H6tWqKtCl+XTsXConhKQCxFdIFtkwH6Un4xtDl8nAbakJNR1nlpPMuU0vrtAhMteAKQELmYhC5O8l4f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198b:b0:36a:1275:4aea with SMTP id
 g11-20020a056e02198b00b0036a12754aeamr9374ilf.4.1712317743753; Fri, 05 Apr
 2024 04:49:03 -0700 (PDT)
Date: Fri, 05 Apr 2024 04:49:03 -0700
In-Reply-To: <20240404235638.771-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbffef0615580abe@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in unix_del_edges
From: syzbot <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com

Tested on:

commit:         2b3d5988 Add linux-next specific files for 20240404
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14d06aa9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c48fd2523cdee5e
dashboard link: https://syzkaller.appspot.com/bug?extid=7f7f201cc2668a8fd169
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d94d8d180000

Note: testing is done by a robot and is best-effort only.


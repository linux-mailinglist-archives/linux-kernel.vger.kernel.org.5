Return-Path: <linux-kernel+bounces-72230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4557D85B0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0124A28521D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200FA37149;
	Tue, 20 Feb 2024 02:56:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463561EB3F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397764; cv=none; b=muTrgzJyWG//u/WuWYA8DhIoZOuyznik6KvAi2gmFvwJ2RvOUoPyIwoxdLyVYlv9v8osCEZr+qDUbLIrsPg8+2JtYkjs2zlh8LeFq8CQlxlMO9DVZNMY6H8hzeEMcpOanLsxLudrFkw+REo1iW8R49eHhSq7HKyicPhXBu/msbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397764; c=relaxed/simple;
	bh=GFBmUld2gf8Aiq7OvKwOtzT+ecJpTWZ6tCRvxcN7YnU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JQzeASdQ2lM2b4ivn4jbKRciMOSLd4ai/n1cORUpJ3njzlApBaRe/Q4fJgbQlp08pJVLeGSCMaAIEVNVeHQ+TCUrjNbkafSr6stWO3+YOVLtYV+8j6ZVjBCLg2c+Jlt67NxTrRAYdYY2NhJDEIvCcfnosRqzt0jdK7Z5wreXUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-365067c1349so34085325ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708397762; x=1709002562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwgEVLxq1VznkWz+vtJqB1ba9PeLsN+ROj5HvDyNL40=;
        b=VEHO3Ojae5Tx14Ia2MW4atuFkFinhRPWzocWrtCc/3mL8ZijBn3z1CIOGwrmJWqJQs
         zqRRxEWoxT7JGAOCfwsMX1S/63EgSnE9usngRS2gUN0S8+da2rsNEjorBqaCuoKVCM4V
         dPD8v0wg7MQ1GO8bap+nxmu0frxpFsHvU9xpJ8jlEFosJ4PZ1f7mgeP4Ke7hqrsMs0p7
         riz1ChZBYMMENkCP53vw4Qa/igGC1AuI0lHdbJhNTO28GgA8US9eI4vSVXezoYygRKhx
         0k+oti4bCVng6Pj/+sZkxJKk3Ar5JUxbv6lRwzARy2ev5AqRD9aSK4ZFJbMShhA3WmL1
         eRbg==
X-Gm-Message-State: AOJu0YxkV1reXWCHFa7HusyaP9YjR/S+Rgg48MhxHoMRusGJp11+Ixil
	GN5BkPiiucZGXFNJ3V3WMs9FKcBZyt95COUSB7ehipKYARXCnqIHtSig9RnCr8dyx4PAHuSJJu8
	YtwpjAY8AfIiBmBUISQQeZy3SG3yb8c3i1JDuXWQl7vje03AomHtA1sIcCw==
X-Google-Smtp-Source: AGHT+IE5x7fwAgwhNfl8Bk2CME3ORBBLXePDpGIdD7RQ8s+YGAMMutFcaLkPpwxhc1irtWMUDI0pw5ZmE/YDZElygU5vFF9IC+E/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:b0:365:2f9d:5f04 with SMTP id
 h9-20020a056e021d8900b003652f9d5f04mr361464ila.5.1708397762525; Mon, 19 Feb
 2024 18:56:02 -0800 (PST)
Date: Mon, 19 Feb 2024 18:56:02 -0800
In-Reply-To: <ZdQRnIUGz-j1ubag@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5436c0611c759aa@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (2)
From: syzbot <syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 5bd7ef53ffe5: failed to run ["git" "fetch" "--force" "--tags" "f569e972c8e9057ee9c286220c83a480ebf30cc5" "5bd7ef53ffe5"]: exit status 128
fatal: couldn't find remote ref 5bd7ef53ffe5



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5bd7ef53ffe5
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3f069371247b697
dashboard link: https://syzkaller.appspot.com/bug?extid=34ad5fab48f7bf510349
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c8b658180000



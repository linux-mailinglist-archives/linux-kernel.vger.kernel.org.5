Return-Path: <linux-kernel+bounces-55255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71484B9C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9874E28EC31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597D313341D;
	Tue,  6 Feb 2024 15:37:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B612E1D8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233826; cv=none; b=GBR7upiuYznbeI8dFe7RMBUPjpMDFiURHp1Qbr87VfkmjyOzvAkXHRJZzKjO67lnhPXV6z+N3gylxjC5BzhXlg9pprfDwM/5FlJkLPhXjLGTwlUy1CtZ43li5Skd/WCcmWdPmIovdLGmW3wTGFJu/urSIU9x+tbORWjyMthvCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233826; c=relaxed/simple;
	bh=Ng0b8wSoWNJFRHttU84cSbnmcIDm3gePN8ehYp9NBus=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TGqnxTHB/Lcj/03RPRfim9I8Zj2ZQhQW9HIt4sNAkUvtZ8R5sHD+fj45hmVwZ15trxxSBu9dUtL6EgvOCbW88qICnSdhigwzA+soGeyDLwtKAeccxalycu6BVVHj34MNfX2sneASIfDT03+EzOr0JmmDTt/secjWrsonM6Ee6I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-360c3346ecbso39715385ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233824; x=1707838624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9nOob/8JifL/CSthC7q1oZwu7tQRQ1QA5+fvwsmZ/E=;
        b=oL0geiMs/rrbzpLDXhlrp6YMFolpKBA7M0aG8yQCiw7dWYOddQNeIwLPS5ktnPmh8n
         nMTiv5meBDLA3+/R9QMnM2OJY0eBhZYGJ7ne6mX4U+CgzBThiaj2Zw3e4VqKpz5Y2Zg5
         9hKA+QD96HFHwrlLTGWdSNnERjbyuPVPFRHfBi4CjMSPbhJwGZ5KEjvoxBcBoPioc3Zv
         HR1gxJi2BcubKCH+iuqk52EQSttJ37FYnQAPC7n2QATKMT9B826NnCuHyzlixZi3kLGa
         p9A0xviTpd++KC1vwqU1LNgPflP9ozpyp5Ig6WM5BSfzN0ESNglU9DQXwzxDrTaHmROl
         YYzw==
X-Gm-Message-State: AOJu0Yz57ebLqmwPn0wVffXHFHfS6Fr5ajUaspmxaOsD4799fWrU+/UN
	nI87hsKkotgvgACCuO3fpRkVjpB1yFlTQLJqJzDhRbKG45OGK99bX5gJbn/GerW5VLRv4vJ1Yah
	z2uDWY6i58iyUCFXluRJRjg/r+5jONKdk4noRMY9Rhk4OYwAUG6M9rpw=
X-Google-Smtp-Source: AGHT+IGMAEXhLsUrLC+UOgJ/3kd9L8ybPrpo4qLvWoPKvOnQRK4VP10cyMDFP4krNfsGgDUPMBSSioNv39wNBjJHiR7dBzS4e9Pa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1545:b0:363:c2fe:bb3d with SMTP id
 j5-20020a056e02154500b00363c2febb3dmr210132ilu.1.1707233824729; Tue, 06 Feb
 2024 07:37:04 -0800 (PST)
Date: Tue, 06 Feb 2024 07:37:04 -0800
In-Reply-To: <20240206045254.711-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abf10f0610b859b4@google.com>
Subject: Re: [syzbot] [ceph?] [fs?] INFO: task hung in ceph_mdsc_pre_umount
From: syzbot <syzbot+4bbc13a207327f82b3b0@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/workqueue.c
Hunk #1 FAILED at 1999.
Hunk #2 FAILED at 2016.
2 out of 2 hunks FAILED



Tested on:

commit:         ac139fc7 Add linux-next specific files for 20240206
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=4bbc13a207327f82b3b0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e9713fe80000



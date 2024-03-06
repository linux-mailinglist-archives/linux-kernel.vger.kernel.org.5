Return-Path: <linux-kernel+bounces-93184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080B8872BF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954A11F243D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339876ABF;
	Wed,  6 Mar 2024 01:10:12 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD98647
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687411; cv=none; b=a4/Oum8qDTx5Q6Bk6d+zi/WzsTVU0W7zyxBLavzMqxlednOkfeesXR66NiMP2mDC9w7hVFSpRJIASvLepozTBAb2EJdWotbsv6GUYzA1vatJLjCIyxQSSahV1WFacNLJUhoFS5V35fsE9OwP5nE8joR2EvzhUfqJ+4vS7Erfl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687411; c=relaxed/simple;
	bh=Gsqfq1QE1WQ94C9Cduf0SlqoyXSp4TQRd+7OFrf89Pk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xwl30QaMcixe2GfnwTcFQupn86v6xcHrg3lKquoHxlidOrni1EK3yD5xLRKDblelFRAj4ofxZCnnYhSVWQzpBsm1B7TxFjUgNzji5nYowSlMfx4CZGV8+JtsbAgiNIZCPAPQQHPWBDI144fioXvXV+hIxi8ZJIZ0qukHdvGnk+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3651d2b88aeso67875645ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 17:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709687409; x=1710292209;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BadOzfmUaXFxmWb7/Io+AkDxpbt0fdFAyOxZh/UedJc=;
        b=mTBxZGA+phIkFAGE8Y2V+JuA2KY3+j02fTlqznNWDGCHX5dj46HUuK1eLjzAqYi7S3
         SoduCRHsoEiRBS6xxaKs2BHq+NwIQVdgp7KcssYLGgJGkhRIGY3xmtikf06Qlnfm7ieT
         1fW47OOcGDsBANCdwvpDI2Pb8QxoOJLfLvs6n0xiHR2uOVuRYbwmqtjMPQnPAqLJQ5r6
         WG9W8URq7p/Na9olzulpsmtBkdE7l2a0i1gpmMwDxELHpWJ271CK/+aS2QFVkJAs/v8S
         WGNkpucfccnuqAwio45xB4VwPCT/LrLHVvyx9m4SNsWyicD25tg/UwKsdkrsIOLRb2Bq
         Pzyg==
X-Gm-Message-State: AOJu0Yy2r1mBC+xEdPO3DMQUJksfyviUd0Hw4Dr/qjXFfAKcBfVRoK9x
	64zg2i4idKInSCMUR1go3IEq48m6bQ2SRiqskSFkK50fw5tjWrzR3m7gdnbH1TS4JQPQbQulFoU
	yZDbvBioN6uRtOKcTpzmD1eTf40QCPKlC8p12ufp0LAZ+IZOlAXEyfM+V6g==
X-Google-Smtp-Source: AGHT+IEDsmnmmZkb9AHVFnAYpfa3+WmQ16ExDkjmtD38yPCelqjJ8h6ZCT/ojrkuilMbVOVAhPiXakIhqr+Qneh3oxFUMFg8Yh8Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152b:b0:365:21f4:7008 with SMTP id
 i11-20020a056e02152b00b0036521f47008mr1032187ilu.4.1709687409608; Tue, 05 Mar
 2024 17:10:09 -0800 (PST)
Date: Tue, 05 Mar 2024 17:10:09 -0800
In-Reply-To: <000000000000e5ee7305f0f975e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba20260612f39ed4@google.com>
Subject: Re: [syzbot] Re: WARNING in print_bfs_bug
From: syzbot <syzbot+630f83b42d801d922b8b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: WARNING in print_bfs_bug
Author: david@fromorbit.com


Not obviously an XFS bug. This is an error coming from internal
lockdep code and many of the reproducers don't involve XFS at all.
e.g. some are are caused purely by netlink tests. But this isn't a
netlink bug, either, as the error message indicates lockdep failed
to traverse the dependency graph for some reason.

#syz set subsystems: kernel

-- 
Dave Chinner
david@fromorbit.com


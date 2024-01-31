Return-Path: <linux-kernel+bounces-46723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8088E84432D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3CE1F2B1E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF4512AAC5;
	Wed, 31 Jan 2024 15:34:38 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE071292FA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715278; cv=none; b=LtYVkr3/NoSBfCktjvxkMfGORySH+TWz1rhRoL6iI4aqJdfNvt9OmvXZ2MBcNhVZeyF8peBPtbgjOlhT54OFL5kXk2rVfacxI0KEAmVLPuV49Xo1/B1rB7bfg3QvlsfCr806M5D+k9s33tKjmwBjHTxo5GQvIjZURMUn2alKBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715278; c=relaxed/simple;
	bh=n21JzV+YFkVlt0DBtGzYqoliU3KbKSGwCRR4GvCcf5o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l1zjoIWKVJBkVmcVx3MxLZrogW9g2fpgkKJWVqXfmDcPHYD+ccZmZ7EZPbZQQCpbVD471zyBv0lJnl26jr4gpjkW1HQHiWVDcJ6DeqS7CA8iGU5v1rYgCJ1OC2My1NUNsEaNahUco0FENncXYnrbTVmwfjsAqBOZzIOcsDJ1B5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fc6976630so35710055ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706715276; x=1707320076;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n21JzV+YFkVlt0DBtGzYqoliU3KbKSGwCRR4GvCcf5o=;
        b=GrBUqGpy1n6neIHieT0Q8ruREMR1k69hHd5kGUYKMIGDAmqL6JkiYHls7dMPBFnU9P
         4lWYG4EwgwtY6CCw0D3uBzaLccItMq1vLu4ZiXxdv4SOa6+hk10CagFU17L+0RffUb77
         JcZ7db5+EagkkE0Y5DsJCtOH2X3WXv2ztEbvvah0a/YQU0/6b/EkEe+qljRCK6KwzNAv
         pdCWMpgjKudCBLFdrxB5ClB5mk64crl6JcItddztMKTcYk4gtUWVOZbrQyufS9YscMl2
         7j00/1iCr3tXzXrKMjNS7J5UMyowESckGhzZck/0QOVCDhhq5DJz3nwLpMDMDBhwuMip
         amcg==
X-Gm-Message-State: AOJu0YzljcRUrH6DESy0ttDoOuTqOjSJqWgBsV7ZLjLiNgNfcn4ZS09q
	Lh9G2aepcgPVYUwgxuFxZvWQW38ZbitTEAvyWG7G8z/3nyKj+dtUkGR4yRMLNVcZKA8+w3OkpXF
	4uzBCUSf6TXu9p9Z+3CK0CvEBuycIbMaTlK+8HegvLXgw+OSvWZPT+Yk8Bw==
X-Google-Smtp-Source: AGHT+IEuKUpwc2OxY1AwdK5JAfSDMaDK1Aay4cHHX2aY1Chd71OqzjGAgxdMsf2tqNQudoWUW60+AjsGpYoLuJ9/Sy5VfEeQjUf9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c7:b0:363:8336:b21d with SMTP id
 7-20020a056e0220c700b003638336b21dmr181118ilq.4.1706715275907; Wed, 31 Jan
 2024 07:34:35 -0800 (PST)
Date: Wed, 31 Jan 2024 07:34:35 -0800
In-Reply-To: <000000000000fae03b05df551046@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0fb7806103f9dbd@google.com>
Subject: Re: [syzbot] Re: Test [syzbot] possible deadlock in rds_wake_sk_sleep
From: syzbot <syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: Test [syzbot] possible deadlock in rds_wake_sk_sleep
Author: allison.henderson@oracle.com

#syz test: https://github.com/allisonhenderson/rds_work syzbug_f9db6ff27b9bfdcfeca


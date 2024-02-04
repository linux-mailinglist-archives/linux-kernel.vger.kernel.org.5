Return-Path: <linux-kernel+bounces-51590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF18848CEE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D582824E4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C7721A0C;
	Sun,  4 Feb 2024 10:42:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA8219F6
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043327; cv=none; b=h7dVuVu7aWoIDKWWxxQfhBmiAZ9gMDHlu3GWuAmZ193hZAer0Ad6jAqL2Bj3BUFObJ41OJg2HqJ7WZ/dGD1xHcuGgkrOc0+fHVJrPzFf9qAbUsa9YWyCFCW/lin7TWRPAY7iq1IPG36GnZha6UB/JF5bAUgp7Hs2SrC9w6bSa8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043327; c=relaxed/simple;
	bh=GoUTRbKLElAG/AL1IG7nVgmYJ36eWQT1I0/0CovrYqM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=atVtM+6RO3QXv/1JIuo2qeqnNpKpEhutvtoY+NSTP4qZpQD/11jIuAPPqYCNE0L1Z4VLNRqfeDMn+tV0TqJZ+8WAiaFhUSPadv3SpNeg+2MrSj7j7jdmmqbfiDk7YAGl4zrRnjUpL3rS/ivl3QVDwFTMC5ALeA7kMjHMNA4nXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363be67c17aso3334735ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 02:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707043325; x=1707648125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7D58G+H6o23ESRSgY/mYkIWXBIe2Y3LIMtoZ9nrw604=;
        b=lRNjtI6T4h7du9DTCEBETkRhzVCBbD29kDTcLFpr/ZDIy4SA6idmjhB4ei/4Fvgo9l
         7F9oHlI1EYp8wXqyyARM/c6mlfzwDJIRFqNfxBmMLoMvVH6iwSFLiQ74AI4S9lTcwrIt
         G1h4LeijVYbUGG29MEzQylqIbtQhtv2OnL4D5Z6a6wCmQcsOsq8wnEWISE60wzPQ3uOq
         VpgsMg9JDCc84rakBQp/F7vQM4TNK7SrUfiK2zX7JKWQiIn68/83pDa82ZmP0iEoXVyn
         AUS2bgQyHeHuh1fPRX11FRrF/ZHYkuDmanY8BLCWcjO6gU82DSNzF3Z3Kk+ePbzWYAFT
         siLA==
X-Gm-Message-State: AOJu0YzulzOsmukL6xa5MPqf/aZgFnkX7yQkbxUFEY45lVYTQOHTKWoP
	Fn+AphavpyxmPkwuCQwk4rkXVvf7wWpN7O8DVhe31g6Rz7T5WvCNrYee3IAdLgoGe7vfdJSWqCQ
	/8nlJX8HrOaHqHVz4TUJuCiKU8LpO6OGPAvN3D+dyil3CS9Bqfbc8VkI=
X-Google-Smtp-Source: AGHT+IGF14dKMIo1FYhsGeomwfl4zmXxuOQfCLnfG9mWyKCI7kZN6yu5TFQSo7+7Xt+8/PU+/qZs64+YzCAspyNuiWxTRhOa+Aeg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:363:75a8:56e1 with SMTP id
 h12-20020a92c26c000000b0036375a856e1mr296405ild.3.1707043325204; Sun, 04 Feb
 2024 02:42:05 -0800 (PST)
Date: Sun, 04 Feb 2024 02:42:05 -0800
In-Reply-To: <20240204080230.540-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003e14c06108bff7e@google.com>
Subject: Re: [syzbot] [afs?] [net?] INFO: task hung in rxrpc_release (3)
From: syzbot <syzbot+6b1634ec78e55df41793@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6b1634ec78e55df41793@syzkaller.appspotmail.com

Tested on:

commit:         dd85149d rcu/exp: Remove rcu_par_gp_wq
git tree:       https://github.com/fbq/linux.git rcu-exp.2024.01.29b
console output: https://syzkaller.appspot.com/x/log.txt?x=16865147e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca1dda9cc5291b8
dashboard link: https://syzkaller.appspot.com/bug?extid=6b1634ec78e55df41793
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


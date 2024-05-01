Return-Path: <linux-kernel+bounces-164857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE098B8406
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CAF1F231C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D0C522A;
	Wed,  1 May 2024 01:44:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22B4C66
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527844; cv=none; b=XeOGoRJsrzHRoE7Ou+FBEK84DgSBM2mX37jUq10X3svHh4KFh30TCix5yl+I5NuhmG3C9D8saKBaT9W71ErEt5/bwVVcHUemti0YuotYa5YU4sDT0p05uY0jfUcuZkMcAhFD7xNFKbHsKDDtPimuN7RWS5GQx5ztanLrx228FuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527844; c=relaxed/simple;
	bh=iha4OoiYSWjWeJDupMA8VQxAxP6sf47KVLQAQLR7+Yc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aDt91UNZYoIY1Bct50aQsqoEQ5WmvrE8rUW37apiNdhMFCdZoPzBTam5DWVhT7Jm5jeqsTcwlnKrivUwzU368eFivul+1BAZ0QXRaWq1dfVaMuPEIo/yLzVqXCLD8zMuzAHnnMTwxjvmxpovR9vSeNUaDD9uRylkCo3+0jjyl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36c5e4166cfso8981345ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714527842; x=1715132642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/NujNNKfxSGUe0SScP+5l6NkyAk+w5y6kEsqa2Cy40=;
        b=WGBrVpVtI7bfHr3r6NGLm/jwzyYCPtbEt2CEy0R3oiewS2wqTzsZct4BXDbSN9hUOM
         zKb2AzwQPU7m40+s+EUxsA6PTYs6DZVVWOZpvWksqOBNSgPB+5TxZ0I1xSlXE/0X8X6Q
         ZNGfxN8OJttsocQSkAHqm0jSDm3L+0zirOaX/sufrnYcCyMrXDfVJhl1jVdo3xggI2VF
         O/8gnnYfugCoom2sIv7bu212zxaAohxTdsZRg+hzqEtEp4OaNWFSSxYt8SaYlJtpz0Ty
         gYk2SpwbHkvj/VovXKlh2g6j89ee0qmIov90hEO7RR44ALdZun4S4PaFwUNy0k6UQdWN
         5l+A==
X-Forwarded-Encrypted: i=1; AJvYcCUZem98UShU6n65dLHWWDZ3fWp2hGvPDA1BQHN+Y0HKzW7hE4q4SZ5Dt0YgXhmckz2/Xm6Eun0Nhv/UU93ICQT4IdVnmpEpOrVbruis
X-Gm-Message-State: AOJu0YzYNhoM5MOw59HOQFE1RDOjeo2+hza74tK1qmHUAKLB2GeS8hS9
	wrhFE0sJXWgiNhkYAfvbk4KfkjtBpPjC/hfhGwatiQKRJdOFjiJEfEK/JdVOqeiMQCC4rxLQaQ4
	QhaPHgvWMZ8fGpQlIHA+chkBgG5j/mJT8q39GN3FTsTHrI9Vv0dX/Xmw=
X-Google-Smtp-Source: AGHT+IGLLzujmiMvf4RJDnjz0fzp17dlbQD8eh6+VaJj0l/Xfgt1byvrD/1BBUVPgu7CK11PsJ2mvPn+uznDBhAS861av9Nr5cUL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:36c:468b:203c with SMTP id
 l1-20020a056e021aa100b0036c468b203cmr70813ilv.4.1714527842546; Tue, 30 Apr
 2024 18:44:02 -0700 (PDT)
Date: Tue, 30 Apr 2024 18:44:02 -0700
In-Reply-To: <20240501000514.1552-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000351a306175a9ffc@google.com>
Subject: Re: [syzbot] [wireless?] [usb?] INFO: trying to register non-static
 key in skb_dequeue (3)
From: syzbot <syzbot+2660b9135e6144ca41a5@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2660b9135e6144ca41a5@syzkaller.appspotmail.com

Tested on:

commit:         ac6a205c usb: xhci: compact 'trb_in_td()' arguments
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=129f5c90980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe204286ac73e15
dashboard link: https://syzkaller.appspot.com/bug?extid=2660b9135e6144ca41a5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120eae87180000

Note: testing is done by a robot and is best-effort only.


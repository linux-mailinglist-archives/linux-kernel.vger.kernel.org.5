Return-Path: <linux-kernel+bounces-97703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F05876E15
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2AF1C21783
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7E3111E;
	Sat,  9 Mar 2024 00:24:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA536E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709943843; cv=none; b=BkWb2L4FabniKp7psVYy+LhR2ooJP3P/+FU60ktPUfeYu7zcNhBpwRUWF1f1qFerSHQdOal6s6GBcrCIsv/AfK5dX9bJAxecVxjxjmoCjg6O5mCPeXCwQxRbJ5cFPkp3LlZ0c854NUC0JhDTTeuEsrbOAWD+9PVacfdLfREKWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709943843; c=relaxed/simple;
	bh=m48oX7+m5s24ipjjo9BK6u8a/BIBnZVyTJXi0+/oIwA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lr/6PGyNa40SpbhhAi4tgwCf3anVjbVykr/JYvQm4zzMUxmEEPYZChNWOjF3XB5wvw3IsSyJO8Ld4FhcnB1Hjh7Sdd7KXvirFRrdA84j9wXXjcpW37Aomz+D5na92Ob6CXfa6M95vPSlKXmWXsIzamyRdqPJGzuLxAYMSGBT+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c88ec70ee9so142536439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 16:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709943841; x=1710548641;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFNzruI9+38j8zOzO++Z/K6VHh74kFYEU9XlGrBzFlM=;
        b=H8j8bQOMiCdzpIoMU6IQuopPtqtILgokyuLMnb0njBi5oEUxWwhdSlypwub51X7viG
         TiFxtgBZ9L1quUmhsWDuMImPdgDiIo5QWmhRi8ql+MH12cM8R+9pTjdlJXtPsBTEuZgD
         DOrospjHPOuyry0LtG09CEEwr6yoyFTnO73T/XwuacLk7UTqn5RwiG7MtnAwznzqcU19
         glT5tdN+0J5vwS3zQ0oA+e5HMZM+SU1GlegQlyD7QRpEW1YUnwzvMGuyIHGdb5VjhBmY
         KxZVz6T7W+SKcmKe357kytiPSvU0dTHE6SxFAo0Hp05B1TFlQB8FXQXmE9OeFmmLF4cl
         I5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhVwBrzQtyxZ2mvMG74FvrGFTHVT94Zd3VHKpVAeBBoLCRhIEEq+MxQpHVr3IJ855ztnNpwHEQh37hyh2P9w4ZfUn5y/KrqKs+YLUA
X-Gm-Message-State: AOJu0Yy8wA0yI+Pyj+VKsvyXXLSPkOhmV3r6mt9l2C3k8qKQmIoCDcBR
	7bQbyMRzj7WAklBU4VuJ34KX2rN8RQa8FXPBiOc4QHtz9tTEHeHYCkZ/jTmElHt39pIFEBHAcqv
	4VzgNVEuNxAMBhVzCFQiFTNBVEnTovk2kq7xeHtS+EWtmV+xs084R7aM=
X-Google-Smtp-Source: AGHT+IGQ2kpooODmF4kkxScY8szh+qR+NzKFr2lUr1iJjnYIaUmmEvvNNVihFwPmIP47F6j1+hUi+3mhJP0tYWh3pwyBUtOD1ivH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d0:b0:474:e855:df7a with SMTP id
 y16-20020a05663824d000b00474e855df7amr27018jat.5.1709943841659; Fri, 08 Mar
 2024 16:24:01 -0800 (PST)
Date: Fri, 08 Mar 2024 16:24:01 -0800
In-Reply-To: <00000000000032654605ef9c1846@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044ad2b06132f53c2@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in do_page_mkwrite
From: syzbot <syzbot+ff866d16791d4984b3c7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11595c8e180000
start commit:   33cc938e65a9 Linux 6.7-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=ff866d16791d4984b3c7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1048c7c2e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161fa8ace80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


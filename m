Return-Path: <linux-kernel+bounces-98084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235828774DB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71D31F213BF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EBC20E4;
	Sun, 10 Mar 2024 02:05:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3B15C4
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036306; cv=none; b=ptTfsPmzvQjU9WC+olX3SKBdFLxPZG3IXAbuFt67+i8pOAE/2/u1mhBk6/pGbiYwW4ZdPFa4wQEWeSvityGLRhKL2nK3lDappEVaU6zu/YLCwnzJaSfNlXBeABokxej9awwtu6EvfIsfJ6XZHM9BGSpuTbvMDpJEYjhkZB2+B0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036306; c=relaxed/simple;
	bh=AB9oIgX15HDPukZy2QrbAYWK+ICd94A+UY4Tldqk2xs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qSR/vJwHZmWrMger+0iDsGEPT5iRUaMahm4nMWM0BxWQfKfiCKPjC5y+qcM1lDbATQkGyhcAgdE838Hz+AnCz6pq6D72u/Pmp/PNHaO7/4kxGhRJrEe0J4YD7xOnmHiqIvveUA8p49Q4xXsUF8ExTMj9fXeTEPhHriB5ur9t6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c86ecb5b37so339556939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 18:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036304; x=1710641104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAtcZ0jcmff76E8g+uUmd6ptddX0gjsk2MQCSo48DN0=;
        b=lqRGgJOpLRi+v1nzlXlpvRRXfKgCSOH9ZS0ioAJTaJVJEdDqGFQBOFoeCNFQPKhq7J
         MZ7dCNtQfD4pAHSaHteuUw7y8htCQA3ZdBQfET0o+3+xFhpJDbSweJf5rNzj+/OG/2ob
         iTgj2i0RWDMfTAzx46UKdP+oFtPk6is+uxRWdiiwGdLmNfUrO2x0NBGLrCkRmCAdLxg2
         gxsuEmlvmcfAmWthXrn2Ad/E+Kyr89/IhDJIDvfYSKXz58dVmNBXsZisn6Ic8Povhrj8
         Bazfq30SNvdziqjl2ayuZxuLwNNnNiw7WaydmOiTrDcW8PYJ7ZQvEuwIiO8u7vLJ6EBs
         qbMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8FR6G5QetI9dOBKmxv8B2sK4fhgDYR5L3+w8Dx5fEvq9ZB+ob0+VE/t9Htl3IUHNagIqmyc8V4a4NENXrXrjGb1dORoHCc7bcnWIL
X-Gm-Message-State: AOJu0Yyo5gbNCHFX4kGWzgbszz18U6seHJNuSc90nU5EK1stzy8ZA8vE
	pFfaG5qIbhMJ3Z4KTP+9g53VEQV7Bu2A0S3MyYtwUXnSXmVjigkLVkE0c7vl92aE+6FicG518qr
	ZICKv7Tlb5wsu533OW9LcjSS5UOKdcuBmhPz3YkMrnqC0FQ9ebV/iDQg=
X-Google-Smtp-Source: AGHT+IE6e/IIewGxQAV4bqB6X0atmmjTjDjRrTeEujE/9OhtcHQe4bLNbPc1G6ogefC3EoR0pjUbedvrrFrSIyeg1cQ727HyyOZJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc5:b0:7c8:b219:4547 with SMTP id
 l5-20020a0566022dc500b007c8b2194547mr3316iow.2.1710036304535; Sat, 09 Mar
 2024 18:05:04 -0800 (PST)
Date: Sat, 09 Mar 2024 18:05:04 -0800
In-Reply-To: <0000000000002a6cba05eb5c7fbd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c3484061344da08@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in map_mft_record
From: syzbot <syzbot+cb1fdea540b46f0ce394@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b28b99180000
start commit:   e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151db82a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f0e670480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


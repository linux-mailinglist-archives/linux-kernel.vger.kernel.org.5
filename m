Return-Path: <linux-kernel+bounces-137774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D129D89E6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6288AB215C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34C38B;
	Wed, 10 Apr 2024 00:36:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028C19E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709365; cv=none; b=KrGrE5VK1r2YmA/Dy+0SYaNVpfzQlEv9DLNgKv5YcIO2oQL+Hm6EjtGnmspohwisYoBVvqcLO5P8GT/KtL6216yuEr0Jk382IxNDQ9KwVj/uQU8EJnoYS3cOoZX5ENsZqZrspRgAocynAvOjVfZd6uLt/NIHQ1PhLcGpAJj+T2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709365; c=relaxed/simple;
	bh=/gA9Fx0vUmG6NAqltuJ74N3CqvVBT9Y+U8QD6tApN+s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GvXIcQRZful20uD/4J1KqIaEQyKymmM+0dIqccp5EQjI16i+kIKZfNvsPgPVw6YOj1gck1SQtbGXpsZpLuVczhOHB8QjdG3+emN3XS1Y5Ws1qfI8eN6Dlt1McwR31KZHyFEr4uZRNPOHWJ7Fgk837yd5cvG0hYatyYM2r4OXvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5e2b1cfabso281843039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709363; x=1713314163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzG+pEav/ocLfhW3VfnouoEJoq+QOAun8ScpxOicnik=;
        b=fKNf1nkOx4tcDq9RwSsIkQwYh6cbO3+1U9PUoqf+WkfwNSPA0O1sxSlB9HZjpQZtyB
         Dkj29p0u6gQ9OYUxnM7cfbtlcBCSYAZiY+opVXKSY6maHkDkk9htyoJMhEzOFwjU9F4g
         /tI7hllSOJW+dnnRugkC2nxtAtB7Zicm4ZuYKfJhEa8T68E7zQnXqJazpVjMLU79tWQh
         ebR6ZC7xVDRSaziQ/5XcUlJkYk0UkhOGbW29D9yN7XHG16G02zTq3IJwTVK540y6zbh3
         r9uO4YBCcw2ppBBZeAC3M2Yw5zNyTdc2DZONFaI6SBovVUCJJxwdK1/8oc2WlpZMHag6
         monQ==
X-Forwarded-Encrypted: i=1; AJvYcCULMrjfDzpKaL1AbZhatger8kJugGqlNE3KlG3GWly+7XSUQSh4Y2gMDNYmLW2Z/zMCKXgA+N9QYVisWIOkYokV2Y2gNPHRJRDQXH/R
X-Gm-Message-State: AOJu0YyfBgetISCTz03bStazRXBeLGKc/JaZI+Twm4mzklKitS1sq9gS
	n02/AdGba5dmE9X+2BCHFMOBaftXZejUsfNFGJ9P2GjD1odfK8gFblC8JTgXVSm4vJ4UHBBOiia
	QIAufkYekD5RVY/rEn6vXohCJ5MClmfMJC5ogn2ASiJqc3idRSkFnqzM=
X-Google-Smtp-Source: AGHT+IHF7Z9lL6k4Cvr6arE6SylNL8drW8ikc55sQ4MzeMnLpU0CWZxmzkpnIE3PwCiQGYYCCfN7/gztz5mbs1tAekxjNkFvBOAR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370f:b0:47e:c145:c770 with SMTP id
 k15-20020a056638370f00b0047ec145c770mr62497jav.6.1712709363120; Tue, 09 Apr
 2024 17:36:03 -0700 (PDT)
Date: Tue, 09 Apr 2024 17:36:03 -0700
In-Reply-To: <tencent_12296C83BC04535760577A26D4336AA36005@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003160b30615b339ef@google.com>
Subject: Re: [syzbot] [erofs?] BUG: using smp_processor_id() in preemptible
 code in z_erofs_get_gbuf
From: syzbot <syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com

Tested on:

commit:         2b3d5988 Add linux-next specific files for 20240404
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156898b9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c48fd2523cdee5e
dashboard link: https://syzkaller.appspot.com/bug?extid=27cc650ef45b379dfe5a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138af0b9180000

Note: testing is done by a robot and is best-effort only.


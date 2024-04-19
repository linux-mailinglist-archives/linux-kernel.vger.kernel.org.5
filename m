Return-Path: <linux-kernel+bounces-151689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26A38AB21F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F9E1F23C43
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6312FF8B;
	Fri, 19 Apr 2024 15:39:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F87C08E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541146; cv=none; b=OPCqpv08CO/s0bvqhOsLvWgPVfcLYCHakVA90U0OcWgnVHuIi+u5Ad5ZdzZ+Ng3DgT5fNUmWVXZf5y5IDvJIWsTKsvK0A6Buk8onP7rsI9UuwQ/8+0TGtZyKwkiqLaGgMuyH8vg8I/wRqz1YLAwUhID3yWQCRu+KH0qZ0OD+ebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541146; c=relaxed/simple;
	bh=3Cmais+JY+zEStmIMYevCUnKD9m+GY58Ub0LuQ7CI1Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GhnOntiIP+K/MKl6uBalZwgYmeLwtOPEM7gsGvqvj/6adCrxNBoIqgBnK6FI1k1Y67DIpxPqRBYdZ/QbHG2k/0Rvvj1cXKX/HJF4AjkReGFxORfY0LbGpuS/fCknynr5xU2DNBMIiJkIV/XSVJdgQOQfRqkfRLnBqF6csM4Ojtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so205872839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541144; x=1714145944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOrNjXLQverk7AgbEgKqgAmY6w7+zMA5GnQob2qDRqU=;
        b=uB20UTssPXdp+Y+v8bFzXlSqbf3+rZ9wws5hWRKkwWcX7WYjLywZXsySDwWuAbI0n+
         pIxS7m2QVzjQOD0XEb5dpPQ9mBMlaZMmNBKT9e59JOSgvUuWMrT5nmilejPDAUS6CaNI
         USn2IqfEGDAeTlVZ1SEV1/9FcjvXBXOSPMZ/8PBUe/h9x04ajjn5sugu6KDn3/abKwbl
         PZ9Mfrya7xNt0C8U6gPq0dIyn2FqBwI7TQQUsmhFV4vlBhMSaMu/jUW0HfdmQ88qt3z4
         FxWVejjAYM6UOc7HoiBI2taDvXge4MxWVhBM2rz+x2kXEbVpdan4VZL22fVS9/jBlFQ6
         t3ug==
X-Forwarded-Encrypted: i=1; AJvYcCWBPu4Sktn2HdzYOnbKsRY093RHMt8TVZRI80jG+tBVMdyD+jYpxCsELFZe4RiyDh2TBZvk5ANpNnhMeGu9pY8bnAGjlXNQ0BTbLiYf
X-Gm-Message-State: AOJu0YxYKN6VZvuaIjztRfxC86UjVMCy55BHdnpXBwd5JsnrIcB32n4M
	Z17+ssm8/nLcT8kkv/1tD+xszkliZCbturxLg6KxTwUIg8qY/slOny+MwNA8nhETmAM3252q+/7
	yVlxdn3DddkzvH48TILH51lJTLkmI83USptw+057asfIu2MI5fWBRRNQ=
X-Google-Smtp-Source: AGHT+IFzvk2FBX5wAFxeIZp3jvixwQBguby6bhbSY1ylh6HwZATHPjyZz1ATDTzw9YsYBxtRFd7xi54407sVufpKlAXUrT9qeiVg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2683:b0:484:e9c5:f8ee with SMTP id
 o3-20020a056638268300b00484e9c5f8eemr45746jat.6.1713541144397; Fri, 19 Apr
 2024 08:39:04 -0700 (PDT)
Date: Fri, 19 Apr 2024 08:39:04 -0700
In-Reply-To: <20240419145619.12563-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000385467061674e36f@google.com>
Subject: Re: [syzbot] [virt?] [net?] KMSAN: uninit-value in
 vsock_assign_transport (2)
From: syzbot <syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com

Tested on:

commit:         2668e3ae Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1629bf67180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=6c21aeb59d0e82eb2782
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ef09d7180000

Note: testing is done by a robot and is best-effort only.


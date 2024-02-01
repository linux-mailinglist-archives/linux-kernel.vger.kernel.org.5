Return-Path: <linux-kernel+bounces-48240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94AE8458F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BCB284C16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9265339D;
	Thu,  1 Feb 2024 13:34:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C525336E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794448; cv=none; b=PP8cruultdv6V2SxWB1tAUUHHMs7gO0htXamWJETBFlQ/aAN4z5l1QASpsBN5oUh73roNBKvrW+mGHu6gYxMR8+J1YWnbn3ll62hEFc/sz8/GGFs6E0T2UUi92n2azS5TK+Rl5cY6xbuP59XYLc7z4DVEfjIOMdrTwiWn1t8CoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794448; c=relaxed/simple;
	bh=rd6W1x/KuaIZFGaRElImh44uQYLR6BIEILWB8MhkURo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AEGxhldHZRWL6Msd+fnZoBeSWay74jKI0re7kwmbYHhZ4/A42IFvfB1OsvlazZuieIIoyYLGNURmpbGn/IebFWXPFOCt04h/Uob69dFQSBweAX0s495Ekfl0kAU6FqYDYfj8omYYsEbwuecp5BH7s6tKYQk9yQXH5/bxf+w3mbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3637b396e6eso7193805ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 05:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706794446; x=1707399246;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6a91I90sAKh4gLsTKdd7mCIRQtdpvv+u7oJYdEoCJI=;
        b=Rr21JsGC3NDXtoNBsTjB5GBohMFJSbTfMpaZT1JnVY1kCTz3oS9n+QB0/W0G98pgCf
         c4SNNgE4rPTPBEsMi0vVORyqpqDAd67yArgcPxupkUQklAtt6+DqEvOx1aAJ+lyPTsv8
         EKgIPQm729c3sMyP8O+1/srIcAUULzV+9UDTtbT1kd5/aYfgZbrLJitXfFOoqeVmzxm2
         ZH7n2MRpiOPXJdPW4vP4RGplzl4bXQYtcXbNYJL2vmAKhGqQUoGYi8HdW1EH8pM8QJXR
         J7X9rpTrRom4MviPEUNWfWBcYmb6F7iKgC5/CqeKsSJKbAJf2U/qHBQnrtaAHpKP3sLW
         x6oA==
X-Gm-Message-State: AOJu0YyZLpxqkuC1JV46eForNVejheJVO8N9bf3VY1jC+ObmFx2l8l1x
	PQO+6QCjyhczHYDIMMNDIxUzDD1Tr3A6F+Aj9vIPAPC3sFto5CdLRzmIMx1VR8ocjl4c4JD5AlP
	cEXiNNkFczCFE7NSBG//87byp4l7nLOnQl/+UnnPnxkQKgkRB/oNB+LY=
X-Google-Smtp-Source: AGHT+IFSjLjJ4TUMmWaP57HZl7Y/QxcdqFht1QpORuYbRkbyZKrLixc0lHp3XFigeN8LlHmhtlAT9dIvZQsTORMYhKkq0kPo6ZjP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd81:0:b0:363:83ec:3663 with SMTP id
 r1-20020a92cd81000000b0036383ec3663mr394893ilb.2.1706794446188; Thu, 01 Feb
 2024 05:34:06 -0800 (PST)
Date: Thu, 01 Feb 2024 05:34:06 -0800
In-Reply-To: <tencent_2E074FCB8D8325A10DE7927D5D905DAF9907@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab7bf00610520cc5@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (3)
From: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/erofs/decompressor.c
Hunk #1 FAILED at 250.
1 out of 1 hunk FAILED



Tested on:

commit:         6764c317 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=88ad8b0517a9d3bb9dc8
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12541988180000



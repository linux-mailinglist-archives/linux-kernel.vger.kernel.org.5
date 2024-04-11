Return-Path: <linux-kernel+bounces-140393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CBF8A13D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1213A1C211AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC514B06E;
	Thu, 11 Apr 2024 12:02:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05614A4E7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836926; cv=none; b=RuctJi0hYRKjQjDPuc35/dmGJFTpTah5sjZNPIrK3T+0JCoX4pdZ+k41s4eA6YnvcFQcAwmnUnyPocXnluZ42Bdm6EkzOQNXyjM0nqlLWVUsYSRoxRQ4+6gnUJ+jw6YN6hMzEMtA41n3pSAM976DsfpZlqvQgbD9ITcc294niGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836926; c=relaxed/simple;
	bh=KU6RLErczAt5qV4XJtYO8M2aLxKgcKs3RMfOVtZ+W3o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wus5npVLVudQutCsV8NY4CfHnliR+l0QULOia+WrY6jVbCWcy93OkNrW2lBm7b2j11jejyClQ/2x/z7utPZlmRlSut9uuBx92bKMwhcaveoBPAvU8jH/yhKo9Tr8B315Mu2BC4HfuWwNeXh1vrh0AG7PNThlTeV80bxqtSf6oqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36afb54c186so6030715ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836924; x=1713441724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj8P6PNUaleXHZaBmO+91U948XFucgZX5j9k4eDOh+Q=;
        b=ohOsQ3P5u55t/iOkMovKqYjWY4Ko7yfk21Z8CZ9QxW+ohL7yQbTYKL5KjwX63nIoZ2
         ovMZJS9Zrp2/iVLpr8+MLATClzdxDh3nDfv2znS78gkkoawsqT9QT4c7p8Y8eVHXe7+/
         5Ydp6ZXq/aIwLEtl8H5LsvIRgOH+So45moWaPZMWG60d73Uf45yyDGOthUHheL0dbsqE
         ZTd6/+/nEHBsbi4e4NCcY0lTsArH8zEK20IOaBNtu9vsw0VvcpMql/THO/7gelwda+Go
         7Ntf1oqsvtOkTopZLCgKh560+hF2DFjBYH1t+/LTHC/uXxqPTQ5l9PolZqIWVnnxaggY
         E7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU+bbXpQKGVIWyii0Yw6a3E0L3lPLp5UDyFKmv9yNXP8pzVKvv3GlHQXfqIruwZ7KQ7O8dXq2f94Cwhf025GCP/0xcCHherULivpv0h
X-Gm-Message-State: AOJu0YzSDrxJ7MrVhZ2JXiC+ZVUawsZKiLkmhxZpNogheoSPzYTCE0Qm
	bZGH13Bf4ubBAGZuI0SjYI0Lr6GgoCvIbhwEffpNCH5qz7hUvuTQS3G07CpcZVrN5uzIfUVhc50
	bzbI2qhhQ4FFOWYEchOuz38+zBOeoRFMGUXicNRRBdB9+mbdLctWytjk=
X-Google-Smtp-Source: AGHT+IHz+fKO8BnsOb02ma6IMFCYkVcbMNeok75+F1ki2EaK8O/xE8ZvU+c1cDf5EmcrLYqqJQ1cYN1G7tOpDorEPDPaTGzY6kll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a24:b0:36a:2a2a:1a12 with SMTP id
 g4-20020a056e021a2400b0036a2a2a1a12mr318739ile.3.1712836924109; Thu, 11 Apr
 2024 05:02:04 -0700 (PDT)
Date: Thu, 11 Apr 2024 05:02:04 -0700
In-Reply-To: <20240411113939.749-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b8a800615d0ec20@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_xattr_inode_update_ref
 (3)
From: syzbot <syzbot+3ca210b2c10e57015b3c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3ca210b2c10e57015b3c@syzkaller.appspotmail.com

Tested on:

commit:         f2f80ac8 Merge tag 'nfsd-6.9-2' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17315a47180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=411644804960f423
dashboard link: https://syzkaller.appspot.com/bug?extid=3ca210b2c10e57015b3c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a085cb180000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-83383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F22A8696D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091FF1F2E728
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0D13EFE9;
	Tue, 27 Feb 2024 14:16:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982A13B797
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043364; cv=none; b=MgCKSHkcuGy55e8CxvFyptRJ0tEYddTnf2XIDnp9Ly4DyPCyDBYr6TiVng1YBkpI/8xTYxo02Jxu4Tpn4NWPUuVSHJPLdxn9H8FGs2K70RlGbBjuoCMXZebWaHHJAOIXJsAM4rLHaKSO3+LkDbdV3KQ/HHYTmymJ+WtQntmv9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043364; c=relaxed/simple;
	bh=ibUQ6aSikjHnr62k5z9W8MyXft4rI2I2ghTKPGfK6pw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=au8Nykt/oBYjnqbmcrllhAaTOsDlmuUwip1zUM8CP03Z5I18U/zAE2WJuf+RtupDCwGSgVBcM3vYef6LM+gMUvO08a9lBzLTYGtaVlJo5W/a4xrtAdgqA6aDVZQQpHTn8jFVqQRMUH60jdihPQtOBeJNIZgBup/RnpYncqTg+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3652d6907a1so39764895ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043362; x=1709648162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/VUP8SV6ZJB1u7Cj5MHX7VSgfYMHzxQechLAzbb+r8=;
        b=b5zHZtc/H2ppdMNF+bswr0pluqJpANMKRKHYFm3QGwTJXdSsnWNyrbOv0gX4Nvwqa/
         HrYgrbUzwZGfHE5wFz6UmqTDt4H9mjN/hgrTYSjiSUOHZfneReftD3g78LxtYttcBeeR
         2+XTU6rGPNyc5gstDJSrojWJK5yrHPWaacUFCHN/bQFI5mqZgEaKj5Fp8eVtByVOxKrw
         udUnD8EVS4g2i2IIl9R3KKbF6qxMlynh4BiPzidYMSmR/J2lcNUDPPQWpkiWel2DtXj1
         xQeNNu+5ynkxUy643bSAdt/jH9+GjMgaiYQmEzm7LWXJIKnrXP7O4/TJW5P2RyfoXe91
         1bdg==
X-Gm-Message-State: AOJu0YxjoZLYfafc41Q24vYdhP1gAy2Rpq946Oxrso7o4XtvaQZliES/
	zX+2vc3WWkg5v8zMi8zdwxxmgVM98m8CRtg91lTaO0h81yDQn7SepCz/kv9wGbmuXf1Tb4lvgL3
	c2/ulh7ZZ76UDumCGbnr18pHmHtXNdj/P4kEhXEFY6osegvzCX3Ea4B2OuA==
X-Google-Smtp-Source: AGHT+IG4pbm1jb0m+QTqQqIgl1d+n2Sr4dmbP41U52gE0nCJ6H2KAniB8gRSZQZkyh2cqBZM4F9PTwQap3AI02poIC7Zv24v2p2p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2486:b0:474:787f:d65c with SMTP id
 x6-20020a056638248600b00474787fd65cmr449528jat.1.1709043362305; Tue, 27 Feb
 2024 06:16:02 -0800 (PST)
Date: Tue, 27 Feb 2024 06:16:02 -0800
In-Reply-To: <87jzmqdnfv.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000841eae06125daa3b@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in dev_map_hash_update_elem
From: syzbot <syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	toke@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com

Tested on:

commit:         45ec2f5f Merge tag 'mtd/fixes-for-6.8-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1561a106180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=732e53182a46d9d9
dashboard link: https://syzkaller.appspot.com/bug?extid=8cd36f6b65f3cafd400a
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1387f502180000

Note: testing is done by a robot and is best-effort only.


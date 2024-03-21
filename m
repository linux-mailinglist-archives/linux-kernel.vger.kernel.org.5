Return-Path: <linux-kernel+bounces-110263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D34885C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360B71F24833
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E4D86AC3;
	Thu, 21 Mar 2024 15:40:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FA41775
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035605; cv=none; b=ucEiIto9tluwOz75Wjo5t13/yh4oOMeR8MKYHRE1Oql3cc68OKuI6bFCtiLApDbD/mL98LGuB6IGHorzvzfePsqLnvrUISC3eWxrEArye/B3w2GxXreDUXiYQAqZ975F5KwXrVRmdufrohJLHrKQ1bnRM+ulikpEdq+b/3DhXWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035605; c=relaxed/simple;
	bh=sRW1Rl93O/YmJcA4++68XP22RoceGRfnFEWiuQvHujE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RliRg0OcdSrUtOF0qpvHXusfUjkc5tfMtGmGvCS/eh09TmCK5g9VY6GpgjqZq+FbZ/Kscsp0EOqZDLjNX2WGCcJEbZM83/WtPvadnPXklcEUHhZ65KuFFlATk6wqUVujrfCjxN12L5Ts63lBBTuet83yVqmldIcF7FkVE5tueEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc61b1d690so82409539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035603; x=1711640403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul1YIoYwYr5MfqxCW0Jg/qhiWN/6Te8JE414749upiM=;
        b=khAp2oUFxrRiRna4DlTFszPH62JnQoNpU2muKUIIHL7NWhYL5u5bEfOUrpA9vvz+1k
         u925Y4ZMaMP8u+lQ/8nzsS/lkqlYWfvnYD4TuWRB3hLAR7wEGbmSSUhi3P0IyCoiOD5f
         2yRpvhmcfNyy76irfJHKyAb+aRsYzHREcdByX4WpWrjgII9+wOkug2i+TYNpT2VJk6WP
         de3eBJw6FN4awZZGHdQq14Ply8uDsEJXQFjbvkaEW8G0VGvQVug+UVVA9IKI4hFeV5vO
         0wIkIMiFggBNGu1nQv45PmUxZMpSuZjp4qURmJvwge3VveXq3zzT9pmeulp0Z7QCye2U
         CLDw==
X-Forwarded-Encrypted: i=1; AJvYcCU0eYryW2HsP0KykOmrqt9XeOAr/ZJJe5dEKQ99m+E2rM1J2gIS+uah1+6qN2p66QjJcrLlOWdS57rhtHqdjqGu7j+mQ5J21uFpLJEY
X-Gm-Message-State: AOJu0YxyFfHO8luRe53PmLd8rfdzU3mPA8/NFpdxray/TXYo9ILaE7fS
	PCaZDdzqukAmgh8Ifsnp6Pwe2us6rkTaEyj/f72wfTntICAHhLM7VkEV8z/+oQ3wXA2veESdbuy
	QLWr1Qody1iiyJ/kqpta361F2LzJBMDDWpL1M5kKsX+cIQBfgj4uio6c=
X-Google-Smtp-Source: AGHT+IFgwZAfW37hAw/ChfC7ceNFpoAtvwltCrLc1mYO+NgTAV3YeStji1qQ7KDL3hjyeyI3fZgeg9GhKTHrYYBHogxFXct4RK+9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1583:b0:7cc:202:7dc6 with SMTP id
 e3-20020a056602158300b007cc02027dc6mr347244iow.4.1711035603350; Thu, 21 Mar
 2024 08:40:03 -0700 (PDT)
Date: Thu, 21 Mar 2024 08:40:03 -0700
In-Reply-To: <tencent_E4CF8DA81272DDA55DD319044F9F8D88A507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005608be06142d85cb@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_find_1st_rec_by_cnid
From: syzbot <syzbot+65f53dd6a0f7ad64c0cb@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+65f53dd6a0f7ad64c0cb@syzkaller.appspotmail.com

Tested on:

commit:         23956900 Merge tag 'v6.9-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=161b324e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c1d7ee7e74661a8
dashboard link: https://syzkaller.appspot.com/bug?extid=65f53dd6a0f7ad64c0cb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11206479180000

Note: testing is done by a robot and is best-effort only.


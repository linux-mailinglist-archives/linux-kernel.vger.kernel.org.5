Return-Path: <linux-kernel+bounces-89746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D234D86F505
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4F81F2162E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B701DDBB;
	Sun,  3 Mar 2024 13:15:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F8D2FF
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709471705; cv=none; b=WThYOohBlYLrVFOmUiTrfiCZ6DkRrClKmfiyPjI3eV7MTiW3h+CHh3CwEMK/RP8eDYGizmjjFzq78Q2/ZELwd8+0gg95uwbPxO+2hMgkeQf8RqCAn9Fdgv/LFZGnJRr9rKN97mH1/+lKxtwUi+U05woBj1DyYCCtSVQFpIjV70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709471705; c=relaxed/simple;
	bh=c9s0goSwX57rJCwT25YATUib6aIeBQc4e9zIuWfF+8I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PbtUW4UTgDF1cLo4Helom8/bmruzLZIaQKBXLdpDOloMRXqyI5ZXUVGiXcYk+dE/HUchLToVmD3kPary91jU38WfX4BK3/33Hi+I0ROJtTIq7wWRwZXthqbryyYb24a8NSO9Ae5sjehivdG/oXe4R/CTlc0nX9P3B5MDhcnmI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bec4b24a34so456857339f.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 05:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709471702; x=1710076502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gX/3k7rE8wn8ZrlnoJJkxbG8GfZ9413M7gqlV/wqjCM=;
        b=JNWCGcqMBQ97dKwAU5Zdtx98Clab8fLGHMpIvLeFGxrCc4oPYqy2Cy9UM8lKQMwYON
         WRobU0q3PtZDzGrmr32cUUQJ8lsLHOtQWW4IjzH2nEwnw2GVj/6TDHcqXur/vVmcPw4W
         TX7qyMJVkbQWzNAhH/OqnChexD8wSeGirVbnPncW+joK43b/OwkxeicXBAwGgN9lqLV0
         OYFHRUZ9pQ1/ioY0oTJE5knB4tuS/6JqM2n/FhziayCqGgkHR0FmUF2mHnX2Ne7LYhbP
         cbM99QgUdAr3S/L33p11d+z9+ftWFwBZbBbonqcaJUzilfYB7GLShWqJEzT1cmL+lfeC
         yADg==
X-Forwarded-Encrypted: i=1; AJvYcCWza9vNgwgNUPk75dkCoVZDARi/OOjF5Ikc6Rv2Z5sEZiGACPfs9XRVJwz33cvIa+cw+yknD4VTobprD/q7bTsd+mllMFHsGSTMTKpf
X-Gm-Message-State: AOJu0YxLS553HNum3jbFw/KKmCTveBnC4sf7g05bpadfW/BKE6kZCaNS
	KoIjfKFfOWvmUyxmRu/sZtD+32KSf13pYy8xqQbxWy6/edwjTgJrnFllTZOzBncQlpGb0EMIoKB
	m27Ckumr6Q+NWMXGQ5oQSiagWjrxVuE+XF3WLGKnHYkgsf8XBwCUT4bo=
X-Google-Smtp-Source: AGHT+IG148S6nbAJIBwhHzHoGEiywwBuYzzUjwuXZpMD8MtNfra6xyAe8QDQL/CAN6PUPnAe+ysxOoVUOlhO2ceQmmrIrXrUwWUv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b28:b0:365:1780:2ca9 with SMTP id
 e8-20020a056e020b2800b0036517802ca9mr458956ilu.5.1709471702799; Sun, 03 Mar
 2024 05:15:02 -0800 (PST)
Date: Sun, 03 Mar 2024 05:15:02 -0800
In-Reply-To: <tencent_146CC89774EBA6EC92CFA4783E6CA42D850A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000995deb0612c16585@google.com>
Subject: Re: [syzbot] [hams?] KMSAN: uninit-value in nr_route_frame
From: syzbot <syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com

Tested on:

commit:         04b8076d Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17b893ce180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d811a2180000

Note: testing is done by a robot and is best-effort only.


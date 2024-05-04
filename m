Return-Path: <linux-kernel+bounces-168508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA208BB964
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 05:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5B7283B3D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 03:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A521810A14;
	Sat,  4 May 2024 03:46:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD8F4E7
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714794366; cv=none; b=hgivtAuTmho6dYbjJMADCsuZtIriwGL4M9MpHew+Bdnms9xcFRXicm7pS0837afM5IX0SaVqrq0l7eP0wbFOCq4/m8IkXNhhBcFJup6BZ0saunkKMVjSKiLdB7X1LEj1Xc0a8DgwVQdjIF6way67q1zTZv498iTWuzpzmyiMJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714794366; c=relaxed/simple;
	bh=Uj6gHXRAOCQA22u6lQ2XoBL88FnfHIKhi6XKOPYplr0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i3KdDK++pnmlGWsBj7wa06p0RhyKtkGgljLu7p11I8+Q+kjxTHT1LUStqdbltKkd+jgOEUY9oWCJxmrqIZnLXjfE6pC8BdeBjFbyCNC7lFSOZQn/9MTO0ixr9caZUawa7GW+Vphka9B65zlTW46O0wKdu2B1kxfMALxUdP1hRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da41c44da7so38794639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 20:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714794364; x=1715399164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXYB9v7etsP2z5wYe45vEDLjB+sPQ0ImMQpPQl44HHQ=;
        b=E1dmCnd+fY09IILrPp2+6IvnZODnwVBhR+g/ry9+11M89vf0Xh8EceWyZcWOKetge/
         TwQejQ4X2XUcVIn+1JMvUPATVMwK8VjB2pkNkX9pLuxXt0Vhd6DWwKR4hXVExdxXl8dQ
         0zbqkHnpZds61GV+k9htpKQnzSH71e606hRTWMvv4SLyhuAFtXuB/CjZgm0JulnxQnI6
         M1c5i42gvx8lzAAzZm7oqWJwvJIuz68LBeeZiZCeCfpaGBZ7sQOn9ehNyH/r3qbV8Ckb
         P+OoexCucp/86dygBnCpv96HJGI5AgvjOwoY2Wt3oV1dz5+7LUg5woBXV8cAkmxet3Gb
         tz8A==
X-Forwarded-Encrypted: i=1; AJvYcCXnvFGgzXlzUpef2fhnwBchhBQQi4DLOTchSEX5kxydbU+VpoCNuyjyJkH/SCmSde4/zEoWHjXkkfWiqandolt44/tBFPt/RGpH02z0
X-Gm-Message-State: AOJu0Yxasbs9INxfhWS8CDpp6Gj3UeS8evmO2Y6zlxT7lYEPXBVOpelE
	AUJPbw+MG6Ynpk3mgOR7UpJdP2xjuEELRdor4KbnZfj6U7RZXZxVwtNHKVwmRxiH6EQgL06GU+r
	jOIByPeEVGciiTTrusYdx/iTLyDHTasbxCg6krtZX+4Z3jgstaVb3zmU=
X-Google-Smtp-Source: AGHT+IFqEXvYpYEl90hHkOZy/ZK1X8Dpgze00KSbXX+ny7mUnshq5ucZ0HQnPtT64LKsu/CuMOekN7EI27d8I/eYTg0KmQdhWHA6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f0f:b0:487:5b21:e66f with SMTP id
 ck15-20020a0566383f0f00b004875b21e66fmr206068jab.0.1714794364254; Fri, 03 May
 2024 20:46:04 -0700 (PDT)
Date: Fri, 03 May 2024 20:46:04 -0700
In-Reply-To: <20240504032345.1992-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1c99d061798ac6d@google.com>
Subject: Re: [syzbot] [fs] general protection fault in __ep_remove
From: syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com

Tested on:

commit:         480e035f Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=137a0b54980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=045b454ab35fd82a35fb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1046b2a0980000

Note: testing is done by a robot and is best-effort only.


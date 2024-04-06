Return-Path: <linux-kernel+bounces-133742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A900689A7FB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA6B21D71
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C539C1FDA;
	Sat,  6 Apr 2024 00:52:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071D5695
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712364725; cv=none; b=UuQKvc+QxdMS47rmBY8pzv+hvXf08XEOyJDWTu33tR2Jq781CrqBoIW0DwoVW156RP3jXoK/35Nk89GPPSNdS0b0AQo455oTXmd5/d06CEGZqe/w8gSQ8gKnMcX45PlwA+EEe3kFs14PZ8mX1dOScC1XqEe3Dz7TK3zLy7+agaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712364725; c=relaxed/simple;
	bh=VGztUnVLGbCL3a4PObztJ1Yrfmle+LD0zcwfXdXqYu8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RZSulq9StXRvRCWPoNsuRNnNffVzHYamPcpMX4y9gqIhlXby4LUEBL0itoSmy5HuubPvmKItx/2W5A1GBCD4la1mayE6RFHynK8neXWFpSBYg1T2fBT7NaEGLVYaMm90JvCcF75qKjSmCncscxVkw23cbMi0Fyjh2/MHwG/zO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-369ec8fd545so24789315ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 17:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712364723; x=1712969523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QD8x3EzDaGagyFeF372vtMH+JV1xhBto5LAJRBo/PH8=;
        b=CVx03nlSlzdtdL2hyBQwKXGlTmaNvo8JARghYcNI6Vqtuqvr31/3nMQAoVBTBD3omR
         m+u7CxqGvBwOBRZ4rvpFRcPfhhMeP2rTrTo6rSQHLuY6RK5/YIPf2OJQJCP+izyP+yUW
         Y+lKrBib0I5NFL3w35LCgpq7SvByNRfYmYD/HVGEQxI6atm8gD9Jgk1Pz99+UDladI3w
         9dJ6FdzIoCdo/ZRwLDEs3YbPOrBAA3sTGMTQvrhhG7xj5QFPEYWrxv9cdffv1P9w9eny
         8xcRp0QGUGTvEaW4PlIV/oQsqE+3BShKdcVYpKjUkNp904g/nOzkLTgrpc6gOIlEXrmE
         b1vw==
X-Forwarded-Encrypted: i=1; AJvYcCWS1N3xdKwz+qDObt/CyBdQSmaXtxIsBpFWsn6rjEAC+HbB8M4sXgfSZHdWtCpKtkIfnm9KIz7XRsTXaSU5PGW4Kt1gys+MVKr6i5Yp
X-Gm-Message-State: AOJu0YyhSg8fxhX4i7HIwWtjnS5tYHb9BhkgUvIDrDRGa4s4DJWQocWR
	mUc/1BL5F+625qGzRqbZLPSwYGJK1VHtn5MR2X2TJMXbzhgAjlP/Xx+wMMrP0iXeyhNL68z4OEM
	B+v4u3lhLVJvJFuyIjyvQC1XysfHLRcu/xfFOIDi4SVdxI7HRENmH/DA=
X-Google-Smtp-Source: AGHT+IEK9Qzg4Uqvr2Xtz64sD3bjfo8vpFEfygEwRK+7O/J0TjaBD7Gn5akQcEOmb2y4F5r2iAkGGxFyvAzvg9GqUZDWCJrgBAmN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d05:b0:365:1c10:9ce2 with SMTP id
 db5-20020a056e023d0500b003651c109ce2mr157507ilb.2.1712364723128; Fri, 05 Apr
 2024 17:52:03 -0700 (PDT)
Date: Fri, 05 Apr 2024 17:52:03 -0700
In-Reply-To: <tencent_53918DA792625DBADD92991DCFD98DDF2507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d1bd0061562fb6a@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in rfcomm_sock_setsockopt
From: syzbot <syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=112db3e3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=d4ecae01a53fd9b42e7d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f92ead180000

Note: testing is done by a robot and is best-effort only.


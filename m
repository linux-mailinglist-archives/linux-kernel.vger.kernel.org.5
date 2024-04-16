Return-Path: <linux-kernel+bounces-146425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55F8A650C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339751F2225E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006C78C66;
	Tue, 16 Apr 2024 07:28:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BB3B78B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252487; cv=none; b=KHmPfbaLycrOV6fgzUES1b7I6mnkBGIGLLFZ9atURyGt5mmh2255b9F/UXrFRRkA1y8r4ii0rb8UEmSvbq4M2tuV1zHRrfDK7VJG21Dr0sgHJvo1XyjAlfJaAwWS81P/0kppwHqlEkCwK3IhwrXK7tDp8K69L6gRjC75h+xlb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252487; c=relaxed/simple;
	bh=dBOS1dsgw3gyJy7mjbSylK/Bajt7FVKsVBXOvHub2Nw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZsSwNiNChVNntMFif3qbt8uKbX8TmxtKcwLGUYSMWE8tpHP1z9HRgsK7xKgJ1fMChjUYlclDJa+tZ+LPuuG2IOGl7G3YgKH1ELe+RG4VNHbSkEcwnTEYaExq6JneBch/avY2Fam/ALs+kGaFBrbvU2VGj5oljKv8yot5cbol37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36a1989a5ecso46584205ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713252485; x=1713857285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3YNb/BQo9qdNgnowLsQAsmr6DsyiaoOlrRVzxGcNH4=;
        b=R6MREJ2J1o0ruihpJVXkGSb1n/mskjj0IkbxBTshhv/Vv/uvbnklkGvqNGctfTI9ps
         VDn68Ys9KG0P/BfHANHI+K5ieEPj3rkHhYJir+Ue22kVBnDM12TIC2bGgIaO7NMNFZcx
         qkiHx4gMPIA7qNZRWX8RuH1uxBfflB+vVlT3uE/+4kIaN7Gm0jDPRbhnVcVJIwN0jATx
         QgrnggvAx3S0z1OippTtc80nciJEo2sDUY4q1pwLD0da8O1B2oH4kwgg6zLBUpw98gui
         JN4gi/LM8J/Lcwp82SXVc9RKBUX+xhf7qN3aLl4vIQDUqzUt9Wprzzsvh4FiffIgtAMi
         4xdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/K7JV/1aMVmzkl69CP1zquCpwFvL0kUDTC9TrMJfFrHOFHAilqxFgOR/T2Thl01PsXUHibSHj3/6+giMibXJTfr/caNEptxvfjarK
X-Gm-Message-State: AOJu0Yw/H6eG4E/4YDoo7jtbyZugLuvyvADFI6HO6Rw+BA2bbuDfNmyC
	foKdCN3HW68UG8PvHO53QExGIF3nG6byjk8qyBk02RaCxUShGejnTAS7kDCvE3+SRk+kK/kvoW6
	6uo8F0e7zUnvkhvPiakXaOCoEnzYH5MyeNgZms03Mz9T8wx3fu0B0KIA=
X-Google-Smtp-Source: AGHT+IF50829uF3qaEI04PAWHiUx0GXukVLUYFzAlylN87l17rHHOY0lH7LB1h3+1yKlqpOdZDvHSrhY4/eFHaEHtTghgdGLLvJ/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:36a:2a2a:1a12 with SMTP id
 x13-20020a056e021cad00b0036a2a2a1a12mr592273ill.3.1713252485144; Tue, 16 Apr
 2024 00:28:05 -0700 (PDT)
Date: Tue, 16 Apr 2024 00:28:05 -0700
In-Reply-To: <Zh2kuFX9BWOGN1Mo@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9b3d4061631ad9c@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
From: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, 
	vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com

Tested on:

commit:         9ed46da1 Add linux-next specific files for 20240412
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15f0023b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
dashboard link: https://syzkaller.appspot.com/bug?extid=ad1b592fc4483655438b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1065003b180000

Note: testing is done by a robot and is best-effort only.


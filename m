Return-Path: <linux-kernel+bounces-73054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E585BCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0BF1F21B80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46A669E1B;
	Tue, 20 Feb 2024 13:05:14 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241155FDA2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434314; cv=none; b=kdzmNTYgGr5HV/HZ9pryNszMPuuhBUubPo/D2VMzrWTSWkcCLiLPrOhgieqhi2KQRWIUkJ2xgK/D8XphI0uqmr0CgrdXKt60plMMvHrQakHkkg32z/2umTeRJoA3mLQKeo1rlRopYSg8Nk7ihpOOuazTYBRfTLAwOccKowXCAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434314; c=relaxed/simple;
	bh=M9SW/M4n7MBdCPIjc+LJuHXNGdig2T5hiTRSCD22dh4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P5fU+ax1WadtAT3X09f8+jadPoFuA6hEcuJZLYaxux8KCsDC2oXknKW+tWbPGjZmVzE9zphHqt28J4MFMAykgItMwzuXcV3Pfz1WSYuKDC5gDj8A4f8gCpTQ5hCaSwxs45Cs0KqPu8CQ8YfTII71tdiUVJQKpdt6haiaXAnc70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363c88eff5aso41519965ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708434312; x=1709039112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9SW/M4n7MBdCPIjc+LJuHXNGdig2T5hiTRSCD22dh4=;
        b=JjZV4rxxdSOoB/h0zCmY50ersPmzWTSloNad+LrpZMCefjn75r+sOUk2iIJ0H0KVvO
         uFsSSRv/M4TQWjQ3GBEl8PjCa61rd+KyTt6ZDr9pchxt6iAxICFShJhu3N8iCo1Z4aeu
         cIdCRBGqEwQrHlkdWTqYnkR43gv3KucawK5zYMyOC/q1Fe0E4ETQIvT0eZxlanb/Sfd9
         m1PRr9BUI6AwDForCHoYCMPpNBA89DqmuLpSU3l5bx9Y/Mf7Q+bm+B558TRC/eyuCDAm
         9z+Okhog9SGvAyPiv26jiA8fKiMkWcrO7njj8jTT4N59jz9vuZ/rQDkSU34KF80V5AiU
         HOyA==
X-Gm-Message-State: AOJu0Yxy4SYgiXVh2Me0/LomOczCMAWlEwZVRqEydf9sOUkV7MdC9EDj
	LPyk45V0jzHxNKafvb3t6nj8R03hP+ZG2MVnJnK9vE6cYXMi8+wvpF94/vVn9Y2wiHHFX6CaLFW
	imXyyODEpL8nt2fj4uDdeVrTKoAenXQTXgPM4qUU93m1SAyqv5mYws528VQ==
X-Google-Smtp-Source: AGHT+IFk8iobOve9rKL/ntMXmgHQXwcj2mnRbrSuqGIDwG4CXIPk8x61/Zob/8ppNv9EYPvuV5wqRSVCAexGXhoHzwuPL8x4IFvb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b81:b0:365:1212:3f0 with SMTP id
 h1-20020a056e021b8100b00365121203f0mr937792ili.6.1708434312324; Tue, 20 Feb
 2024 05:05:12 -0800 (PST)
Date: Tue, 20 Feb 2024 05:05:12 -0800
In-Reply-To: <000000000000498a02060de59162@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ef0cb0611cfdc9b@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __skb_flow_dissect
From: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: use-after-free Read in __skb_flow_dissect
Author: fw@strlen.de

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf.git gre_cap_headroom


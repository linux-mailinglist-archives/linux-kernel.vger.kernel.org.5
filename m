Return-Path: <linux-kernel+bounces-101496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354A787A7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D191C22E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6027453;
	Wed, 13 Mar 2024 12:55:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1743AB5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334509; cv=none; b=On0fyk+jQUwlBaEegNGoZ/I39PlA/p5GyuUwbFueevhzb87SdW/WgdnR0NvTtnR2G5Bjz0NqCquhF6OS7ZUFa9UiO7s5DvSqf4I9Dx+0fmhKsoWWiGJZ/IP17TIXlMmL14ofCkZCr3KwdkX0tBN3DsvI4pf8jLifqpNH15Um0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334509; c=relaxed/simple;
	bh=OA7n4WoWGbP3oWnO0FZJGlhIW/L9Y5KPqj/OWmrBB0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l5LvC46cfv24xLNJV3/jI7jNEpJJRxZ258UvbtLRbZABwd6Hu6E2hU4fAevac+qPGIETnM0Bz085SYo+l3ZY+ardmq80AGSZV1d9CL5jM8KtnaV3Tcn8GtM79Ri8MNhup0KF3iXbEcfe3A+C8w6hzsGFZcg0+bVIt9OX5tyJjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c86ecb5b37so90885139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710334507; x=1710939307;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTsBJsTIJoCtZSifJCwcmREyobfdSjlUs4dnDW12QoE=;
        b=NqPrw5Us7I7DnMEVmUcqVvh9EXabtE7fNOVzHCVw1mTUsCagSwpNwfU3+T4WvK9sj9
         1jEjeJcrPZrx4LvPOt/CHlRkew+CWbCMtLbgR5HaaAFzvkYf959mh56KJATsgUbouh2m
         gUDOi0kf1OOO8yjVyGWQjDmJ5SDttby5EMe69wnQ+ISi3D0/QF6Pc1oekEmY10Qaa3fD
         r66XZvoPFMD+zjj+uoHs7q29oJDpYhem5lE06q+PuEXWLOaOBMBglR0ZEn83asVfJ+Qe
         2sMg0w2S3Djd/Br/2RXLAUD1TAUoRWSyXJqRsQ8lUudxwrZafSVuBax7+QVqVuTmMw9h
         IPgg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Mj/2HtgHyZlYgJ9juucyLLZ0fuYojKnbDtqMlDLPZHYWfpTvG+1DxBTRhAXf8b4babM5TOMuVUGGRW4Mc8cz0Fy0+GOXfZnkVfkm
X-Gm-Message-State: AOJu0YzqpKaNXH4xxctX3r2uPpxaPI0m2y/ca6RHwkVD70Z4glYtXX0Q
	HVbVnGabZS2kLsS55+5xE+Ej8mm/U64wakOSXmuKOpWo8LZ94npdNl2XIlofppLDo/VsB1VqTTc
	i/TJukYkvwsyOWFnIKev4gIT74/LnN39ViZf9o0ztp8wC0jZTvUka3Fc=
X-Google-Smtp-Source: AGHT+IENFWtw/fGe6TW5joyiNJYfM5EpgKtZ7zqhvwGYgsMjoQqO9yN3YRFWktcMZaZGtbQ6m4h18RZJlVkywC6rxjrWx+WOAIpu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b26:b0:476:f337:688c with SMTP id
 fm38-20020a0566382b2600b00476f337688cmr201085jab.0.1710334506597; Wed, 13 Mar
 2024 05:55:06 -0700 (PDT)
Date: Wed, 13 Mar 2024 05:55:06 -0700
In-Reply-To: <tencent_0CC819694F840D98A5AA8DF9923F5DA6DD07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6908d06138a4852@google.com>
Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune
From: syzbot <syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com

Tested on:

commit:         b0546776 Merge tag 'printk-for-6.9' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1507ceb6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9b5ec5ccf7234cc6cb86
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136276d6180000

Note: testing is done by a robot and is best-effort only.


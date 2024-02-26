Return-Path: <linux-kernel+bounces-80913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714D4866E01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3CD28582D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCBE4DA0F;
	Mon, 26 Feb 2024 08:33:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278EE39FFA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936385; cv=none; b=sFtExEhaDbr4FoK2iVFj7hASeSd5i4ECakFmek/ifFlcl9ANj8ZXu6kEepnqr7rL0FBMEVC+2u2djLH3Bb0GVT4NAIgEN7JFZgS3dKhDUWCCVWXpYXy8v5r/hPcBbGZ9ZPd3WuvjOgrtrosd5lLAQJsDaNIxYMMAoiFLS3Qmf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936385; c=relaxed/simple;
	bh=sFg3Bue0RjE/q0rJ6RRsG8lFGuBuxnCDFsgJoW7Tpog=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DtUdxDYmMql2QR28WmpmW72NxuAK5JNoaFSkeNnAFZubv7etiq4BEdpic4cl5EkQgAsJbiYEWwc/+0ZPL0JFCg20qGYaNN3TDXPREw+YVm0K+pvwW/eFwRjtv4eN9EDOBj6qy48cGUC6S5CCkCRziPrvNHDOtTtp2SGU2Zpjh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36560f1cfaeso28457305ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936383; x=1709541183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/qOo82yrwnBfpaGzzEF0rDHMHxNOUl2Wyw8qHLHclE=;
        b=KPaRObvXDQ/xpw3aMsaENaYHfu8h2uwUSZ4oP/KggpsFaI9Coz4b0Lvd/UqnSiB3TK
         eVm0IhsNICWp0Hf1CidLhYk8gC8ZmtdRzBsplm1EtnjHpEEo0ila96VCCV3WKobQnWmQ
         MfTL5tvnMAoK0IQC2i7MYuOzC/X24mIp1hdbWoDZWbEfDGcjQ8S+MPIntQQoeFiWwdn7
         xXVBnXfHreX8f7o59/NkreTveWp9GbBtEwG+R5DPozoLr6xFAmbVKguoddiywLgw3qNW
         OIFgwywNYaQ5E/TY/9BXihxSH9KrBbHs6DeO3VNvJpN6Pk6GPog0HWHV/k9IespDQZg3
         kfNQ==
X-Gm-Message-State: AOJu0YzT3ouWRABo+aI8Sy8FyQI3osIbDKPROigLfzo1VDyUi+w2i3F7
	axXTOwh68GbOt6f5QQxmCF/CDcsx0GzkVZgyW+qlVEEMRCBF4R4xYhN0Lp8J/OyCKHj3LxIrTPT
	TdS9OgF8NcDiVafg66VrpnOiAteqPlYcOjNDT9DuUmVd5dZKTZUM5aHVXOg==
X-Google-Smtp-Source: AGHT+IGHgS21ONnp7RGydJ9XYeZwtrNpntoOmhBAo08bBZNwrbskRHezey8k0ND82JwrgJZx7JysgW18oYdOdiy9RQoiXZyz8Av7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b83:b0:365:21f4:700d with SMTP id
 h3-20020a056e021b8300b0036521f4700dmr320140ili.2.1708936383286; Mon, 26 Feb
 2024 00:33:03 -0800 (PST)
Date: Mon, 26 Feb 2024 00:33:03 -0800
In-Reply-To: <20240226073001.1248179-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011d729061244c264@google.com>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
From: syzbot <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         d206a76d Linux 6.8-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13e0b622180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18dc188a654638a3
dashboard link: https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109e4e54180000



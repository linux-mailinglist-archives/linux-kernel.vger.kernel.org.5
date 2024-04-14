Return-Path: <linux-kernel+bounces-144084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BC18A419A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4D61C20DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317DE23774;
	Sun, 14 Apr 2024 09:53:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1AC21A0B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713088384; cv=none; b=B4Tl9dhWdavLu+yg455KUT9UmGy7gDT4V1Pu0VQ/5LrUHlWNAjSZDB7mJXGfRYZ4OEQIAXcstizlo0D+51clZbnx3Ke+W1nUcYvNpTmrC2oHlhuBUu6PU4lDr655COSr43xhqPaSiOeuFfplEJhftarKTP86aBGexkZp+V9wfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713088384; c=relaxed/simple;
	bh=ZWJVCcdLyDNSx2BPZ/f6uRn3mCsM+AsOpCUxHpbERvM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CWbWPUtj6tqD+hHtDlp9abB8Pc7PJMsvTPuDHqxqbKQaSB4yrmcsZwxR3srq+4WZQL9ZmU40FLTlUcYBLkxmT3xDSKBdlTAitLCsXV9//w0kSI3kLE/cgyl0ZXESeT/1zuJk9i6EdQA6+JYenmid0RgA5m6TMRquD+4x+hjnGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5dbc0e4b3so243418339f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713088383; x=1713693183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJewcxTY/LExiWT3nNcq5uUM1JYwojfPqG1OxrV0lDk=;
        b=JSYOiwn5RBmizZU5fdQIBpMbxlY/394hNHFkH3q3yBIPSzBadVa0fFe8yM98TACtS5
         rGgfhb4BNbvIk/UWaSIF18/TJYnmQbck2iO0NhsWCQ4lDYGLgI9UA3MlpWItTTLkdodP
         Pqhf9+ZfEIOkjVB7Fv+0drA/Jngl/ZY+TGqJfu4fE4G14JL7cWy2a209cvwatgslABgJ
         sp8EP25YOLtz8lQ6jeVMAmkpItuPx7rEyANwtFJFEkc6G0I3vTEeche3yYP/7QQRv1OE
         JwLNs39qOaAY8pnyVBo0WKigy0DMjrsDpWwc+1H5MJtnfPCQk4XRbcHacdcUsXXKdDlR
         UI9A==
X-Forwarded-Encrypted: i=1; AJvYcCV1sDJbKuJmohffdieFHzGMCwxBnWrJ07NE+lRfSepqtlw0uBahznLF0xfu6NdvB4a8+2bL2vt1dwor+6CMvBTeso0Dd2DWhxH60m90
X-Gm-Message-State: AOJu0YxrDsEfibKnQ+ol0Jl5Q/2v4FCx68dCowyJ0uVSIMVuQ302/JwK
	GXBOJB1+SbHVzC95YSfL8Xsd/kaR1NsZZD1s9zMuALQB/4nmfn6drFc+Uwj1zJyVZlKmS+V9LJ8
	ZTCo/Zi6Y4hY6iNPOoOQuRePaWuLNJu6Dj4kLrfuWN68dImCvAPuasxc=
X-Google-Smtp-Source: AGHT+IGjPwajUXGlbfEVeOeTjEhC50MCa3xMEUM4RwSV/9jjLyYtz9LgWFywM6ZrP+9SoVnntTajHPF/syxL+elEGnaItnpgq5x9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8320:b0:482:cb11:50de with SMTP id
 io32-20020a056638832000b00482cb1150demr213823jab.6.1713088382888; Sun, 14 Apr
 2024 02:53:02 -0700 (PDT)
Date: Sun, 14 Apr 2024 02:53:02 -0700
In-Reply-To: <tencent_6C9ECE2079B26EC02F4D6CC095D8EA56ED0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087fc9306160b7893@google.com>
Subject: Re: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify (3)
From: syzbot <syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

patch is already applied


Tested on:

commit:         3d122e6d usb: typec: mux: gpio-sbu: Allow GPIO operati..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd8c589043bc2b49
dashboard link: https://syzkaller.appspot.com/bug?extid=d0f14b2d5a3d1587fbe7
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1797dc0b180000



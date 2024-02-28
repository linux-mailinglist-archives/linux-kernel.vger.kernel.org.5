Return-Path: <linux-kernel+bounces-84529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8F186A7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A31F22DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211A4210F2;
	Wed, 28 Feb 2024 05:20:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCB210EC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097605; cv=none; b=SseQj/1q8odFDmulSgRbDKZtshaQvwSH+cuHOYSXKNcp73ncPAJ9R5qRsyHfal0VfxSiVOEUBhrW76i056Aie15Kg5Y0ANBdtRCBpkyIEGb6vKtRHw+mWMb1tC1fUjxhj06ICiZO9ds3CxmIKM08c51ApGt7BwLeNAJQ8i9w99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097605; c=relaxed/simple;
	bh=WxQrT4gLYNDVl0XjNABL7fIkgq44GNeMlzUDCjsm7Zc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aXP4dR4YcayrgkNUKeeXBToOn1JGueJxulN2rkycCd+UDl+78MGnlYLy8O+MLaTPfsWBcYdemHi/8ViB+cAk+/bqqT4JBrasGCrWlRyVwqJuDvUZ+p6MKFQhCz+Z9O7djV8bHIWNujSKQy/v2rkZK7eddO8AgirDMLpDMrFijiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7e91ddc42so26174839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709097603; x=1709702403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dv6V2O6lQg2n9LZQBOk1bc2tXIQJwFPskMBoRcLDz5g=;
        b=FD+/jRv+noBmExDda3BqPlw4heusSkP0w2fjH2afmxPHimLpgUDqqRN5ZC2CNs2h8p
         topxt5BB3EibHrzYB7jFStZh4UrhWpf2vHwa88NsDNoMzXxW0qXO9KwsyJqf/6YGYLT6
         e882YOK+0cVo2qkwo0LWIsBewnTK1UvYMBaaKrnpWrJ8QNt7xOMWX187xUWrz7ObUUvq
         m3rXhgY6CqWygczTDAxLvxpSCXuPXtVOrDx9RNcfoNJII10TSJDqRFY6tbms71XG0Twe
         ZSr0ZxQrDLeoW6ocjPE8OIQk+zSSmzdRL5iM1YQ3ljxHSrNZVm5Mot01wCMdDpMdmo5Z
         lu3w==
X-Forwarded-Encrypted: i=1; AJvYcCWoQ4EZEVhX1IXaa5W7tWYN0P9qugsKpfMiIFTTZTckAo8+I7i/S5QSKfFj8HV96xigBQed/1X7X4vH5sI7E9k0BGBkA9slyRFjDF7t
X-Gm-Message-State: AOJu0YyMUCZjuKPX8/xdtYGMpDfZJJT1TJmPHBz2fCtI4Br8aB4SJ/PY
	5UfC+P87GkUgCVsba1Hln8CT8jc0DPvzMe5MVxs3eFFChgz+Wb9Y7XTyHJ3SX06H0nLmhG4CJhk
	ISYYHh6nIDr2sRrOIWk1tacT+wHNPPcd0hTrjwQ20HVCSjsmdf8326Z8=
X-Google-Smtp-Source: AGHT+IHFpws7RuH68mE1HYjJIQQuWSpRs++cRXaZ6NLbzVNFAb1c3ZPabIvF/DPFC/xfmllw8CS5ebbDD8XmByptSQpnDWItU8Ij
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:de02:0:b0:7c7:96ac:9408 with SMTP id
 e2-20020a5ede02000000b007c796ac9408mr18782iok.0.1709097603496; Tue, 27 Feb
 2024 21:20:03 -0800 (PST)
Date: Tue, 27 Feb 2024 21:20:03 -0800
In-Reply-To: <8fe3f46c-4ee5-4597-bf2d-12a5d634a264@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b026406126a4bbe@google.com>
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
From: syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>
To: bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	martin.petersen@oracle.com, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, tasos@tasossah.com, 
	usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ on commit f2e367d6ad3b: failed to run ["git" "fetch" "--force" "--tags" "7b440d1b40dd93ea98b5af6bba55ffca63425216" "f2e367d6ad3b"]: exit status 128
fatal: couldn't find remote ref f2e367d6ad3b



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ f2e367d6ad3b
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=28748250ab47a8f04100
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14296a74180000



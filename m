Return-Path: <linux-kernel+bounces-103688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AF987C302
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C491F24033
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB4B74E21;
	Thu, 14 Mar 2024 18:48:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F311E480
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442085; cv=none; b=p14U8foppXJ9K3ObCYQ8HoZz4wtxGEpt/cNVZ03psEfjgCsjOKNKtCGFu077VEOFj3j0HLA54/TCy0pWO8mIWHpcLV92wLcbGIA0AqA+3US3w0iikaJWPXfsqDGO3XRS0GZKUhcu6AQ+MO1gNRg3fnVt5Xyb53D1lbfY4D5y5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442085; c=relaxed/simple;
	bh=oDMsNI5OY11VLhhqRPMUlb3eND3fQrsnxWHbOxman6M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZererQk3ZUWpDTDvP/TPME05yC9hGOedG+0OSBIEtKoDLQvSFeGbQJ0deue4QxzlPWqR9/whGgsRsS7BlO+Vg2Xo17lMXiYBkfVSw8htyswriF4T99jnjqE/X/Xl/3RhO0gia8bbmABoJPL/n1QAvafweNL+6yaWFxCUJD3K4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8742bedd4so200500139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710442083; x=1711046883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdA05tLv+9atPn2grTiMn3VQGhShHjf/kXNU2Dlw4pA=;
        b=qQUbr7RpAk2/lIRXO2HGtR6QvIL+fktaXr9onmu3g3q3GI1eK5MRGDPX320Q1cotV1
         q1msJLyhb2JOpdO7NuPXhH+oRSnuP82vJay85450bb9NVQ3+IGR4dvuHmDzZq43T3YsN
         eoMVxA3asPIejsB1G9P8OKfHY4/ehCwFFZ8OiE2VIJvnES/kDyfYjmnU3Ex1j5PLCYsr
         Ck72IYemCqaFn5tLn18meEvsOVnl0gixKGo/Ii2SsL6AxusRAZzdwCUdm37A8s2WkpSz
         Adsm3UCCwi29WgHvUVrzNLohhlCBeLaubw1Cssap0kn1O46Z3t8GE9JRKc/2Gkto2OVh
         vJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWIV8zFwPele5JoUY5WsIwXm+K7gTXxVUpXpVjkDgIaOFKoOHN4nVuAjfl82plXBuKEwjzSWBV2rEn1m/647MzO55MTQAZnU0MShFo
X-Gm-Message-State: AOJu0YzTrpbdbzYkydl99L1T5ywqm+DAMmVjfJWuZzleKOO1xs1Q9A+D
	7idlJOSasn0yklrjwV3Ihd26av998HC3LRbixbjVDlgoRd0QxZh5S0Ote3RaIlDgcgvIOgSkifE
	GtjMxdM7Xr6kM8w1YyX3IUxorJZIXqk9tyHu9XHREG2bweOrFQrhPyvM=
X-Google-Smtp-Source: AGHT+IHWe42QWy4l/yzv0BlT0Fzh2AH41KmFn9Vq7zBHNBZk7Z5kbaqi6iUGt28UvYPyyXvZ1V7qfGv6U3kV7m7WysZyazNCPrYK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:379f:b0:476:b3e5:4392 with SMTP id
 w31-20020a056638379f00b00476b3e54392mr127824jal.2.1710442083368; Thu, 14 Mar
 2024 11:48:03 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:48:03 -0700
In-Reply-To: <20240314-impuls-hofiert-3682a611e841@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9d0d90613a3544b@google.com>
Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune
From: syzbot <syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com>
To: brauner@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com

Tested on:

commit:         9d9539db pidfs: remove config option
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=163fc311180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d8d7e8531ce5633
dashboard link: https://syzkaller.appspot.com/bug?extid=9b5ec5ccf7234cc6cb86
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


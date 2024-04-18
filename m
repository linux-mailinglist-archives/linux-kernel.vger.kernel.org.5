Return-Path: <linux-kernel+bounces-150597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296498AA16B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52951F21623
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BF2176FD3;
	Thu, 18 Apr 2024 17:51:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227AF176FB0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462665; cv=none; b=ZgvRo1HMhykSlSOQbJPsziS/8JaabMx8El8gAqbkvnM/tqD6B5cHuprKuSk5fBMaK5EP3OYRGqShnW0o/PqwRSSG5hXxr5bV4KtAescxCv4W28bhmlp4AjasPa7gTyFaP/i0U6X1IjlWzJ+j/lDEJ1D6wKVEnXr2WZEllzzw4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462665; c=relaxed/simple;
	bh=053jrm3rbROA5OWPfP4StZh3u4avv94NNVjPrNZ41lY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=juy/ADr6daaB3Vybch3RzaC/vKo+tTeVZwu3QidShx/N3Y68jPtnscoH1RKq/7xKIwIDUDBL+48pDCokz/ukSYXmnSlkesXoRILn2GqKtxKEbALtaSsIKe4tt1NcYrfp0/sMToe8xURW7SZoS68NpdyoTZJB5ztBRAGreYlW8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da18a77b4eso148146139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713462663; x=1714067463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VF8LZCSNJI+NdS3+F0FwamjpC+fjCn4iGgRfKFc2zKk=;
        b=i1NYUIUEj8TbjAC5CJeuK3sFp3Fms01rF5CqRAjT/6RL0WyYe0j2UNI1WJcVBrFWZc
         HLzVwYL61HSWTTkcCF6H+rA76b+0eP8Kb1Tg2Yw3L+UpYkdu7zaO25fG3w1k4lPSlCDq
         et4mRfSx4iwlkXv5VPW2dXHU9nowO08aQYEbpPBuIeKDXXUJvMp5sFKb0rC3oyDRBExZ
         6iVB/PLxFFa4Z71t1Iz2UQM6IIpHiKr1g6hJhWLTbKvfb+6YgQMKfWM1aMi51hT1z/pK
         KxPwM5QpLoS71F5+dFrqQWBKzFBIczt7MHNNe1GRv9WWSpRpQc1soyJDO3tAzHV/n54N
         eA1g==
X-Forwarded-Encrypted: i=1; AJvYcCXeFlq09LQpEjS0+tX4BBfdFbE5cEwF02jw17YI6dMhh/qBLT5VNqcEI4OlHRurluMU2t7ceIDjFdnld4o48nZeKdUcPt5qpsyrY+Bp
X-Gm-Message-State: AOJu0Yy9dpngGdtlx6YUpU+l2AkM8r38bixSDg934OznhLEYZbeLQWM0
	FOldrISNa7dm4wDfVyGNYjcRRFjS2PZtDpkA+XFERpATf3bAMTQ4SgQuisvoTt4azEEVV7dWg1N
	1Vm57vm9qR/BXSatOH/o/G16O+lpTQJGOl3UG5ciZ9K+R3gjFzGSYLtU=
X-Google-Smtp-Source: AGHT+IFRNjZGY1hRDbMwPVgtkQ5SQ1lLARGta+xRlcEkDDsYxdmPUiPwFy3+U2TPsN/gbgLVO6ev3IHq51OBCzzeKkNd0xuRATTd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4115:b0:482:8f32:97ca with SMTP id
 ay21-20020a056638411500b004828f3297camr245691jab.4.1713462662708; Thu, 18 Apr
 2024 10:51:02 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:51:02 -0700
In-Reply-To: <20240418104952.2615-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058d4c80616629d53@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in hugetlb_fault
From: syzbot <syzbot+7fd4b85697bcf2a9daa2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7fd4b85697bcf2a9daa2@syzkaller.appspotmail.com

Tested on:

commit:         9ed46da1 Add linux-next specific files for 20240412
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=147e17b3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
dashboard link: https://syzkaller.appspot.com/bug?extid=7fd4b85697bcf2a9daa2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c94a53180000

Note: testing is done by a robot and is best-effort only.


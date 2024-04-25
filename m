Return-Path: <linux-kernel+bounces-158024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B317F8B1A51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3C285087
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E19F3B78B;
	Thu, 25 Apr 2024 05:30:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D03A29C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023005; cv=none; b=p6Ljxz1Dmxu0Z9vWtH5F5NUQCLNodo8Ez9hQZUWB2tq7LSrO1oK4CZly2rUMAM2Krk/ch+t5ArRUsvTbWtmw3BGCHffCapkDJfIonvsQ1wZ8YiKsHFKo+3txZtXnXWc6XpF0efM7ADx+gxY7ZrDIJ7o+Nx7UMIdn+hb8z7leDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023005; c=relaxed/simple;
	bh=VjUYhlgp5fbXX6hu2N0aqTzhSdSV+ThS9o/NyaYKy1w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cl2ITGxbPUrp/Ymi/KMqHeGFU/z4kttuZ1mTPUiawwaA+8eDpVZVekrDO/0XvkVYdyEFwZM+aHPDWHeTytPw6bEJW1XgwvosPOB5gVP+H/lviqmbFQh7KIAPvvJWnnxZTW53OsrXcL0oqb3NzfDadLv3dzR2SomTkVTT91UEeIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7de8630f6c5so70917639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714023003; x=1714627803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr7mKLY9WKYBT8mentmznqGqjClNIlNbLghlPQX+jAE=;
        b=VkgdrCvRVYqT3k6azN7jrx1S6cN6ZtFaAi39fGSrCSC2PT23QFedMXKEiABOvs84Mk
         NK1C7xNRYaz3GtBFklWn8/TNNrbVgkXGShOihTXZnJr9HjJLCeKOt7mzjMuTDpJsU68M
         rLhBHHe/JzoAVAfyY0sd+R4MnHlUD81oIOSbrpgzPIexZCxr9CIFgMyV4fmauvuUkpr/
         cgW/KMc8ItAuABXjfdgFK35pmVyjHeEMgKw5z6Dp6fxGM26VIvGvXFCQ45F9dYWEWj3I
         +OZV6hOiXGc3R495lBtx7Whu4/BR+3UKDhEuNuN58S68cY7ZQVdC9AAPapfw5qrcdEz4
         grLg==
X-Gm-Message-State: AOJu0YzAVCmuDair0YGmAtTtw1Jc0qJk3RA/0j/5ZJDZslZsGElvN3QM
	c8HX5AgWRKwdZsn4N2U034pRvfxL9Qnd05+IHticSEg7pW4k3RnPjbZP5CscUg2usV2yqC9Kack
	3JovxE27Tb4VLJiqw4HQI3w4WwVJbhjGEXblAcbu+NaXZB8C5zItBLdA=
X-Google-Smtp-Source: AGHT+IEqKTYpOF+u7PZU4QDao8wNBE5ON5tg6UYi4TBwk5BenuOn6hvFjZnhoyDCyGA0L4c1NpEseaoepvrpUMfNlCCg5xXoRxM/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378c:b0:487:de0:b631 with SMTP id
 w12-20020a056638378c00b004870de0b631mr92542jal.6.1714023003716; Wed, 24 Apr
 2024 22:30:03 -0700 (PDT)
Date: Wed, 24 Apr 2024 22:30:03 -0700
In-Reply-To: <ZinGFTKFFK1f3fvl@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004611e80616e5142b@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com

Tested on:

commit:         e88c4cfc Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101daaa0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b43eff4125d4e9fe
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f4cd6b180000

Note: testing is done by a robot and is best-effort only.


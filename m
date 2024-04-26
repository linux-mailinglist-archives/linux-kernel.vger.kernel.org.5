Return-Path: <linux-kernel+bounces-160202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18D8B3A84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFCA281ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801B1148854;
	Fri, 26 Apr 2024 15:03:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D791E504
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143786; cv=none; b=F3CGlRfL1NBvl08b0DYUNUBEz85sPj56lppbypneQM+gpZyHfyh9L1CXzwSjhbfIuLAnaAC1re5JBwau6r4o5fILNeXATSWqDHAFwB6dPN7yIyMVlwb/zOATRtWLqKrA+ohNGqyL8tnJTBZ5Kin8JSnwtP83IwHy5uOdc1o8g4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143786; c=relaxed/simple;
	bh=B6G9APsRzVquNYMQntsv9a33uFB15oqO0Bv3pg+ecAo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sXNHEYudq2C8Plfx6kpMuEKt91VnDSGC8SwRPdNFFoJyL0v2cVrr0QoWrGG6CEClSTQIxf///17AwGI6YHcLR6w4Vu1SdnA48w3CD8BCDYYxD1cFie6c+1cfgBQIvzxAvzbtk+KpAa9ijxkUQ3GFKUicizwE1LLYGgPixZh5HWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dd8cd201d6so224170039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714143784; x=1714748584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjq+JyuEW9pOxMxucmhmo+GK6Yz71ALcj0tKvYkbvdU=;
        b=Ld/QYXIqQLtBEzpIuTN0OW+/IyW5bjqexL0AYndOOtk29pN7S3o6KitjKCrQpC1vje
         2pywd17QXmNusA6Aq+n9ko9gcsYoQs16Us613vRgfxtv0S79E6SR7+4fxTSaA1OQhR7/
         S0xEEfBlxIYSosHnA2eiqBhR3bHJII1IydcVQsslQu5y6A4IAupPoOM+KAhXLuDDKWMx
         UjSDCj8tlhmXwqeNe5HfC8+vtvse3ILcruoAq+r/9pao+zNRqQoHWl5mkIYt5IGlej0l
         vjSkXXQqHinJQvq1ZqBiDzDAUiDng0cPi+5xDDM2qgqxmsF0IqgKEpEl6sULsYfn1bFu
         1eFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcmMAVmhhjcKI1QsX9tGp29XbO8dW9UsSqqDA/2mm3PoOw5ayAfDiP3c06tR+JdAjv/DIXv1aVTWT81Z52cui15UHQm1aQwGpUKZfd
X-Gm-Message-State: AOJu0YzQD5q2VDw6fiLsC+KT7v4JdpXSgBy5JgQ24q4G2XbSyrEkAo9L
	wBDks15gCEIzfo3vBSYFGVqrZBNBvQyQ5FZA5hi5mS5WCSA3JIRD0poBzrZOSVwO2bjaRTjEiiP
	QKfHwN9MHylWaxdH7B5MWWJXUweQuEZpKovDZmDzVYfEvgdJ8N23r+GY=
X-Google-Smtp-Source: AGHT+IEcQ5K+OUGiu4O1qgSNJ+PLhnaijENTRs4mkvP5uInZnmkAHYAYo3Aw3EJ2d7BJqaJCzJhwd1+SJqHb7h0n0T5eXwxZOYVy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8709:b0:485:7a8:42a6 with SMTP id
 iw9-20020a056638870900b0048507a842a6mr231070jab.0.1714143784030; Fri, 26 Apr
 2024 08:03:04 -0700 (PDT)
Date: Fri, 26 Apr 2024 08:03:04 -0700
In-Reply-To: <20240426143539.3478-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000578f4a061701330b@google.com>
Subject: Re: [syzbot] [input?] [ext4?] possible deadlock in uinput_request_submit
From: syzbot <syzbot+159077b1355b8cd72757@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+159077b1355b8cd72757@syzkaller.appspotmail.com

Tested on:

commit:         7b4f2bc9 Add linux-next specific files for 20240418
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17674890980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
dashboard link: https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d6cb80980000

Note: testing is done by a robot and is best-effort only.


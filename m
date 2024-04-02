Return-Path: <linux-kernel+bounces-127443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CC3894B67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D475C1C22540
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7901C683;
	Tue,  2 Apr 2024 06:29:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8918E29
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039347; cv=none; b=hnCvLuYydR5B68IGaZTBm6oyRyfC+yJj4hgkClxUQQB4HyestdFbMq2qCrKwYxKw1MM6dvg8Fpep+aqUbebPrwfOG8m+ZBUV3HXPSdwXRhVirceiO1KdC6smHtwL+t1z7mQuprARwbqqE95AuNWBY2Xubr49mV7QXA663akQ3dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039347; c=relaxed/simple;
	bh=0A1AUuX/Y8jIOE5BjNkYgaHyh6Ham05W28rEc1USRRE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pPHCQciXZNk62v9n6BBWnMYFaYNSHM0ubXAx92rZjrKOGHpcQ5dzChXtFQx6vj1D/RF5buBm2FzEOSDGKBSwSJoGtDmfCJTabnLYXTJ6JCFLuf6D397pwqi+m3ijF7DFpSPUGxfE6EMqrxE/NCoF4B1qPNLBZTn5NqiaexTnWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-368a9bec953so46646335ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 23:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712039345; x=1712644145;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPBT04iktt7xPxA4oD9A29dkt7/V5iebEyLVaMzCNGY=;
        b=B7QUmZzRXkUww5kqBlS3rjzLmkL11+dJwahQ6W+n8kc+G7LNy/HwioW2G7tqqgF/jm
         5mN1xyKU/JYv3ktgs4zsprkSBmkiMXI5Ktv/RmkYCAEj6/3LloXmhEeO5VRbVm0GhL6v
         hLNYE2kL4ruQqxD1dyBMLeMuxoJ3et3AMaqR773RUd9RsWMW5ldR53dGyrq8cnLlj9qg
         t2UQgbOG9Djh9t7/naHKqWjKewrj6O5M757KFGgGbQ96YwyzIiwsa6cqxXnIMf88nM1Z
         H6DmF52QbiUFHcuDCpzllJua7yH0BEcXXoSkBg6tZTn8rocgvHIh4YCU2AnhKH7N7POP
         fUZw==
X-Forwarded-Encrypted: i=1; AJvYcCWkLRCulwHlBjxoIx5Hkx+Yo9VuXwgXMpn0UIWLd2aLcDJzoyBDjqYg95+flN5V1rmJ4txJJUQe1vGoh+HyoREUaarn8ie5OKS9IlSZ
X-Gm-Message-State: AOJu0Yxf+R1C9ZKjjY1wQ2hT6SnOqay0XeqdaBOliQUT56te5h8Mqwed
	+HEJjSKH22TyJcPs9EMgOH+Y4I7e05yL/r8GTSXxY6Gj6IT4X2tl/sdizkl7w2J7qkLA61VRgnl
	D77MVsdNYQ3zr2mADTTIGx7wLjgKQ9YKYsq1IzCJo7SfDklLuGmusSgk=
X-Google-Smtp-Source: AGHT+IGZypN/5Zt/eo87FBDjYeqhcm6WnLSy2l/wntdvJptY2/CuEXm9N1U9bW2Y3f4ngvjRnCKJ8YqlkOL/u4j9EFBAGwPIcWol
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3207:b0:368:9aaa:2920 with SMTP id
 cd7-20020a056e02320700b003689aaa2920mr676808ilb.6.1712039345102; Mon, 01 Apr
 2024 23:29:05 -0700 (PDT)
Date: Mon, 01 Apr 2024 23:29:05 -0700
In-Reply-To: <tencent_A6BE4B38751776D567BC3C2337FC960C3709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001b2d4061517398c@google.com>
Subject: Re: [syzbot] [usb?] [sound?] KMSAN: uninit-value in line6_pod_process_message
From: syzbot <syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com

Tested on:

commit:         026e680b Merge tag 'pwm/for-6.9-rc3-fixes' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15e939b1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=7fb05ccf7b3d2f9617b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17da6855180000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-144161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C828A4290
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D69281A38
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFED23EA90;
	Sun, 14 Apr 2024 13:21:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A018AF4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100865; cv=none; b=TQapE6GhZ5eGLXIfA9TghgcVqxVSMAsjF0ABg1oQMqGZTOFlmj0xhdOagKZ/bQkwYMz10RkpSgrtlpOBp6XiDQRDUIBkFb125hPuDxk7ynWXLg+l73JTIernVL4qpvWVxU+OBy4UBVRFpSWCdWrvKBWhar5QNC0QU+Fy5MGBinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100865; c=relaxed/simple;
	bh=+UCHK7tbG//9ug18P+r8XDKU8XjXhKi2RnpPesTbDwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gk5c6y65tKxSO2nkS+gfMY793tnx+GbsJQ474jNurVhYjQgomp7HnxOhQMcUH9W/mfGXLmnxpCl0XQEjK6r1MUwpl4WqLv9FP2ZF2CLu9GTRnIL3u+mf0jrEHBgf6QMp8JaDOdG3i+OYgJsIlJIZA3io/0WJTSvkc5tS4SgN8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5f987a9f9so263026839f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713100863; x=1713705663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdGiYo+Dnh0uIIGoCxoo0gDRHsIGj4vm1CSYv2dlQ4c=;
        b=Jrb9nXkjucCMkhiZklRQ5ETMtnPQLYJnkW+FwnenhsR5p/4C7jPnYISeCkfw0RNUr/
         uOHk6duQjrGUYu/c/16e3X7jdRxVdpMQmiuaOPyVP4yg7LXF2XzV6zy6oS/hcFb1PUew
         pquKAjI9tPMOpteAfLv3g3NX53zAZ2SyzMxGDE/7RVNLATf4VWM4FMB40PRydU0Hju9C
         0rxrOlXYg1dIXKO37JIjpBs9tZdCrYSN0RGlPgUnjBEKfYEz+eyqMm2jrVuEPo58JknT
         gGyVfiwXvDS1NdSSNw0iJDVLlVcHbftrOb28phO1fgkX6T7IKsK8xFu3bZek+0oMfWBn
         7ljw==
X-Forwarded-Encrypted: i=1; AJvYcCXT1EXlAgphYfSTBMfuOBKoVIgb88JYzx9z95zZTngFImT3aljIsadoHOYUptW2ypdaNzH1hRwchEnJ75RU88uaP7sGo1MblI701AA+
X-Gm-Message-State: AOJu0YzSlWzvHTsr97GJAUxNoehZtAHBTylfCuRQlNmQKxq2E8ZlE1/Q
	5iWqYd8B7Fx7S5I96UOhyIvgw7rZ7D170yMfJTsYQVjAWYREJt+pTPtX2GGz0SbssfbyHH0gu6D
	aTIy2Ywb2UtXr7HbFNMJX+MTTfuddzgtQTRUt9SmT8fSJkSBuGxDBq3g=
X-Google-Smtp-Source: AGHT+IFjnmw3uLVA4AnU0tsuMdzIawT0yaGj/kn1xZjSZhH1YCc3nF9v69ymqCmqO9ChHvxPqyNHX0UrfQMQ3nQyuKLxSLKWxf5P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:36a:fe5f:732c with SMTP id
 w9-20020a056e021c8900b0036afe5f732cmr532162ill.5.1713100863480; Sun, 14 Apr
 2024 06:21:03 -0700 (PDT)
Date: Sun, 14 Apr 2024 06:21:03 -0700
In-Reply-To: <tencent_79835DC09931CFA58DEC258D8DA51200DD07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006eb5af06160e605d@google.com>
Subject: Re: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify (3)
From: syzbot <syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com

Tested on:

commit:         a788e53c usb: usb-acpi: Fix oops due to freeing uninit..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1026f36d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd8c589043bc2b49
dashboard link: https://syzkaller.appspot.com/bug?extid=d0f14b2d5a3d1587fbe7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17043c43180000

Note: testing is done by a robot and is best-effort only.


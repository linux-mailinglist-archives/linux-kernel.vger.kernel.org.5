Return-Path: <linux-kernel+bounces-31374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F8D832D63
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1547C1C219FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4E55761;
	Fri, 19 Jan 2024 16:42:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3AE54FB0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682527; cv=none; b=A8iiUwanlwiNNeKboqX7YonaxisKloLnxPYO3BAu55ZwX9ttq0PsupIYY1YFI2F72Tou/e7r0axmOLNejaIkGu/hO3HiNu/7zSl+MIN+DeB3FRFnddQlHh64pSjSJjiaCRQ2K5l950zmInufnZW6TbKfITcGo5X0qZqdT9a/SRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682527; c=relaxed/simple;
	bh=tUSQar8SVefVgA9+h87QJT7KM6nWmLZ2629LUeZ9WvI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YbmqRTu//WtI51p+XOnnEBKIrvgNItw5sBiQedmrYHzkNCi9ZUGTHsgANv0f2hTsewQGnmfEgGwvaTRbyhHC/j0+J0gcaZYpS6lKb7U+4h0L/us/XiSmQp64joo2CHGmH++Y6DhjwrXVIMVhQAAGOIp+C8EdX0pUyTt6fa+rkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bef5e512b6so97212239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705682524; x=1706287324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IejfW4T+WHysZTqhHnecqYPGpf1eqvzR1Ji50p8rGU=;
        b=jgBsNAoraHPVaJYnOoOykssXB5ZSDNvONz1Na6WNXQpAiZZvZua6Mj3eeonlkWslRW
         /KnTPGgq/laeBH1TUPyWvpeTNrGP1gIaHtvdKf7HeQjHVASLB/AsSOtuvAefilY9c7wp
         AYzU/TYvSGTQjy/wC52myriWKt23cNhj0VWojiMU5GlHzI0/bVbTjPo4IUxj1HEyRTuv
         s4utjERNdENrVGccprkfaFhAzg/F3x68NUSCVlpkUJDUrJJTKADlqx58ALILhZ7zwrCG
         8pV80avo/eOthJQdlBA+ElFjYXDBIyZSPZVuvDldHAxnS7pxUd64oga2Rnq2GcZlTqA9
         63UA==
X-Gm-Message-State: AOJu0YwFwpMLH9cCoK6w8oVGeNR/2FeF385INtBwHiSPTKwTFNCmfm3P
	x0YsQNPbKt2hEOx6Gik4muoo+sVaKIsZG+svleQ0BpNY/piRSn+HWf7mriPavqEAAaJGtWJTD9K
	YZiIYYD0tbR0ciJqirQhBLYMayQ8P1+seycpHr5lGQ0Rz4FynHXrzYEA=
X-Google-Smtp-Source: AGHT+IHPddwIGc/pOEQCDIARsZ2rwlm/LrGw/x7JT8qz/D6AuELL/dT3oSNDKSNZmpjRIrZYCAC2ddtwKCNdGrUI6v0QBKU/uDMG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6408:b0:7bf:2bc0:c8cf with SMTP id
 gn8-20020a056602640800b007bf2bc0c8cfmr170440iob.0.1705682524850; Fri, 19 Jan
 2024 08:42:04 -0800 (PST)
Date: Fri, 19 Jan 2024 08:42:04 -0800
In-Reply-To: <20240119155614.4501-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe4ef1060f4f287f@google.com>
Subject: Re: [syzbot] [kvm?] KMSAN: uninit-value in em_ret_far
From: syzbot <syzbot+579eb95e588b48b4499c@syzkaller.appspotmail.com>
To: glider@google.com, linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+579eb95e588b48b4499c@syzkaller.appspotmail.com

Tested on:

commit:         d1d7f15c DO-NOT-SUBMIT: kmsan: add the kmsan_exceed_ma..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1726e677e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b301bd980290807
dashboard link: https://syzkaller.appspot.com/bug?extid=579eb95e588b48b4499c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


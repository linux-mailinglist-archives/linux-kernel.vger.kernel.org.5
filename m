Return-Path: <linux-kernel+bounces-46402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E930843F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A77C282AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0E7995C;
	Wed, 31 Jan 2024 12:09:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854147992E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702970; cv=none; b=KXhqCOB74kWhS7b13486jXb8YS6HaAn30J29wVgNRvIhNGxuB1QlB7ZzB8VomQ2AMyFqIHjkBiqP/AZgd+uZcB7jBBl0b0Kth/D0v1srG2MWMKM/NuKL00EHCNkaOE7wKpHLgc4q3/VvmoRDAwqhcLP6S2uR7IGsCWcUiJ+eA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702970; c=relaxed/simple;
	bh=MqWGFuUXDyr4r1R/PvdHTstrP9780Yrl7OsGV4zVN9c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g5FumPP6jQlmrkklYeKnhbVPZbLei0pUOLExAxpY/cln9ctDW/mU0t9ygPblJiQB5We63WMLqlnffGmP46//EWUOrMEXwGH4e85CwgdBruv/hAbRtvmx0LL89GBh800KhVVE8piFovJP0xwfFEyWk7yA/iIma+t0TL+Nls9dCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7becfc75cd4so376772539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706702967; x=1707307767;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqWGFuUXDyr4r1R/PvdHTstrP9780Yrl7OsGV4zVN9c=;
        b=sndB1/b6+89elUAJITHNd9M6zpbvYGGogItuTxWOGfHBfhK2D0yXA/BsXKRT4j75Zk
         O642dipybfw1zchWnXCCuC1P1JjtvFn1r4s/TmlZAvUVx51ecDFQSStrm1E/hMyUl/IF
         ZB0+w1Psn8Ubu4+SHuiJ3nzY+ho1zOJAmMxkzOOeGgASquep/mmO2wsk++kAKJ88kKt4
         a2oJ8tg7JjhXzu6yZVoZaCnPF4XTjoOZrrNoKSLf90td6flYIVdODqt0/BFfWVpt53fJ
         cds6E/az79Do4iO5giWZwkFJ0+hJn76eoOMcPtX0Fxl2WuETnLKGwSTkauozxnparnOb
         xC0Q==
X-Gm-Message-State: AOJu0YyHpnLBgTOFc43AlLnEuEV5JmBjAjWtTOEZBy1d/b+rLLBFo2Yu
	qMGTl9rJyP3O3orGW9MYdmrLk8j7W/nAxPYObyTTq0NMbqK0WbAW1e+s31BbekOqg+JfacIMrY8
	97WKJ5OWEh+1BJgf1jA5m0/z+OcamYSVB2WIy/RmSBbIPBYW5e5y2OycjXw==
X-Google-Smtp-Source: AGHT+IHO132Xm5w600BFoVLBKeH9W2f6gHdriPoE7fX66+ogMs39vi6i1EHEYO+Dh6itN5rB8611hEpMm5v84hYwQzQ1Bz0tTw3J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be4:b0:363:7aed:f073 with SMTP id
 y4-20020a056e021be400b003637aedf073mr144022ilv.0.1706702967667; Wed, 31 Jan
 2024 04:09:27 -0800 (PST)
Date: Wed, 31 Jan 2024 04:09:27 -0800
In-Reply-To: <000000000000a63c5f05ac118b29@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000200d7106103cc0d2@google.com>
Subject: Re: [syzbot] Re: WARNING: ODEBUG bug in netdev_run_todo
From: syzbot <syzbot+f9484b345f41843fc9a9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: WARNING: ODEBUG bug in netdev_run_todo
Author: pchelkin@ispras.ru

I believe this was fixed by abac3ac97fe8 ("batman-adv: Broken sync while
rescheduling delayed work"), regarding the work timer related issues
during the device deletion process.

#syz fix: batman-adv: Broken sync while rescheduling delayed work


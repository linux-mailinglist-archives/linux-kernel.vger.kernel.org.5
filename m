Return-Path: <linux-kernel+bounces-65380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A777854C24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3191C26F17
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53525B67A;
	Wed, 14 Feb 2024 15:04:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2453E34
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923063; cv=none; b=shZGHbPlFxIQ2uFxAGMl2bDkRbHAQ5vkI67HZF4uYfccdS+DPuTyVetVBdmYDDI3sjoavxdbY0JZTxsxQlVm/CFBUqPEh1INLwu4g2+jBiM4+Kl6GRzmp0jP06r9y2SqAjpmEZtmNyFZCSNtr7RcOgnM9daX0GSqMSlUQeKXhgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923063; c=relaxed/simple;
	bh=09SyK5r/P9n+Beu+pmBHhdk02BIJkQ+zPdGY8S+fkJw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jbf6K4IyEPcfBlT3vvIM+D0csXh87LAxBiTCxGVc3rCIl/3g4NtcbFCy7BaK73KGFEhXDctM1O7EN50QCcqQup8BJKTfe8Jggm6BfC1MuerdzHsdkV1d+yAmfSneQ8TiHtLC9dx3vqG/DkCXASw4LJpw8wDfSsOwJbgnYwkhj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36422f71c3fso9568265ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923061; x=1708527861;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3LH6TBYOOzcaF8RvQJ7tLm9fKBFbm0Mfdb4zQWz77g=;
        b=PhTgm/i8p9OqL2Ef/66ymBAwNqqMQSscMO4AdBQHyxm7Y9g5rK9e6+z4TQ2UCUjkzT
         pSHDrG6z4OUv8Pix3fPmbL0fUxv83b0i0jPjG8ucIDYDZFUx3/TLW142tToi1D29TVAv
         PcMGURbAZtSVGMmNP4fKHxah9clQGfMqiVh6qtRBsWpZWKm+uuNVrk7kfbZTzbjRVbNB
         PZOdnZ4GeaD7rGaTPZS6ZZfUl+IsPU3G3XmlB5jiROU5esNl8FfmjonKhu1JxLm2qONl
         crrU3NSz99mkIwkVyJ3HJXS16ybrw5+yMsqvnOHYF4wW7QRQ8kM8TnGPQsBeqAJoUp0r
         fYpw==
X-Gm-Message-State: AOJu0Yx7Gw4ZZw93HJHNl0SjBkmyJ0ACAMUXhJjtWsYyWN9/D2HZXrW1
	SE1j3BGxJT9yYc75l2UAR4roJw8OsiVRHVmtAHXOzyNFhaFPgdc4i3hQvPJ5+97F1cM1j0WBb1z
	VS6EymCsPFh0BKmPiliYEZOn7tK8GuZnXvuMHd28q6ByAHrhflsPjuoEL5A==
X-Google-Smtp-Source: AGHT+IEzw7z+AvohmDX4e1SLnYoxthXdIQd/0SB5vSxXsMVMPTZMaT/OKhm2ybzsBBTA90Tio0uVBTa5Egfcqdhtktgzh5KH+w5F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:363:a059:670b with SMTP id
 j10-20020a056e02218a00b00363a059670bmr182822ila.4.1707923054430; Wed, 14 Feb
 2024 07:04:14 -0800 (PST)
Date: Wed, 14 Feb 2024 07:04:14 -0800
In-Reply-To: <000000000000b8f8610609479fa3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6947d061158d228@google.com>
Subject: Re: [syzbot] Test for fd7b34375c1c8ce29c93
From: syzbot <syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test for fd7b34375c1c8ce29c93
Author: syoshida@redhat.com

#syz test

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 93ecfceac1bc..fd20aae30be2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1227,7 +1227,7 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 		rcu_read_lock();
 		psock = sk_psock(sk);
 		if (psock)
-			psock->saved_data_ready(sk);
+			sk_psock_data_ready(sk, psock);
 		rcu_read_unlock();
 	}
 }



Return-Path: <linux-kernel+bounces-41183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F187983ED01
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E4D1F2319A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D6200DC;
	Sat, 27 Jan 2024 11:57:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9021DDC9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706356625; cv=none; b=IdYUHmHwpcqmGTQb2U4Dy/6G7tFqBJ4FXJ0+Sf4iqkik5A7jPp1nyUZusqkYL1GWoRG7JBK3J7XIyVbQjZV4N64i3pp98xUGOj8mN5IrsHWj/7Q9F2JxDtAZxYUWAuqv/JkLjeW8kd3NTJm69TFiCzbsZEu279J8e8wMisjrwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706356625; c=relaxed/simple;
	bh=ELeQLKSfUrP4nmRORmqTMiHFz5bQLj8g/Lp+1YPSxTE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MU0u3Ipdb8zfKTM2ArVnB4J7Zeurm3OWNpKxFQr1h9hawfgS/Pk9+isZmQC1zl9TxuXWXX9RM799/gzZ4gRX+9VoqTX5yUWA0KW96Rfj+SF+PJ41srHg7WAhDpqV6xbjgl9SlWlodzcDe1hmdpiBotRMBRfCOJmJafXibK63r+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf4c4559daso80539639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706356623; x=1706961423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLvdhTrqJLeO54h5WiprafX5rWVS7jzBQvDKngUHNyY=;
        b=KUPlUfZPCXJ2gfnK0DGYzxb4S7BTekfDUxlxrCK4D3+Jj51pb0Pqgjms5NCNQqO1MO
         TI2mBH9/me9pM2u/gGfvKlqTK5movsrjKMEz5rfMSddaJlYzM3RsGwDj0Tb+r8obNcba
         rNGbqoiXnoUx303psXo4ommzO9af4ZnUq3tZG3/UtDc6B1GS7JOVXS+ss6q2DKJvjatQ
         8FagYFuFmhm50O9NECYzP+WWW/PVJ/V8viJV2pVv0DCVJfs9887S4VjCHK56jT2rITHE
         yxUgXbrRKPba3ZUSDAfjraHtax+zYk0kdmTlE7nBaE089C/u8XNILa6OuSahnoZUAG5n
         +FfA==
X-Gm-Message-State: AOJu0YydDI2mDfIxqV6a2EnYeQHGV3irxHvKL7u4+9/N2aiJpRPhE4DK
	2JdyutjoxbenB8Ewy0V4xms8llTy9PPLAfL7N7KCSSWFCFFWPfM+TiSzwTCcE+pgJdaAkjRisAm
	DsVEI1Z0Obl3PzoRiwrJiQ02XemyD42jcR0be0eZqDqo8l7Eb1NwPLA8=
X-Google-Smtp-Source: AGHT+IFFIUhnSzB7cgzrY23iiAd6rc4vD/XsigOEI4bkV7WJjXzrf9DDyqW3XzgqCG4J5bE7AajkDYK7QSQI1gYvTbgWhuhFY1x1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:361:9b75:b64 with SMTP id
 b14-20020a056e02184e00b003619b750b64mr146643ilv.4.1706356623075; Sat, 27 Jan
 2024 03:57:03 -0800 (PST)
Date: Sat, 27 Jan 2024 03:57:03 -0800
In-Reply-To: <20240127114610.961-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060f13d060fec1cf2@google.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
From: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 2cf4f94d8e86: failed to run ["git" "fetch" "--force" "--tags" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "2cf4f94d8e86"]: exit status 128
fatal: couldn't find remote ref 2cf4f94d8e86



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2cf4f94d8e86
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=da4f9f61f96525c62cc7
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102f1930180000



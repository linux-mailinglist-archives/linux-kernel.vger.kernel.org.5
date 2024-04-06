Return-Path: <linux-kernel+bounces-133958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A989A89AB71
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B541C212A4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC10438396;
	Sat,  6 Apr 2024 14:53:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33C438390
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712415185; cv=none; b=SZDUIejKkibkvMWEPXfQXsaXpuvIWCp/t7QUT5+DlQEXlPgRBa3tWlvMJPapDu5+3Rj4fydLPGTUimWD0A886YqWP8IUU9cNwMINLzcChB7L9LIwdRJ8/sywsTTOaDcpSeV6mp+OL9gJo+ciY2CoueiUqcFQPMI92NRRmSeGENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712415185; c=relaxed/simple;
	bh=auYPgHpH1fvE3vDTd22n48x/is2PnNEzGgQkEgkMTXc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BeojV5R5R4rX/4WpL8E3Fkues96srFgjkEGZuofXidfd1uC0i0QVTSs0eEsTzX0LaX6Z3Qy/Vvdk2Bmxb/3U+FtEqwbDXJ1TX9rKGlrV0FluB1AHh3H58CgnYBMnFFb9fb4FbL1ozPDyK+AK4dL2OhaFwO8GmpbefbcwEm4mDd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-369f5bcab76so27866385ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 07:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712415183; x=1713019983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEusqzjyCIPwi8EF8zc7zmzz3Fnpc6T0myuG8LrsPzM=;
        b=xFJ8dXJquzgEB+fYMkCTrnq/8EFpPdwflpy6C0O29weL9PW/6/Zd7KkBQZOoQchezI
         38Ol4gEBAsdCm1Vde25+awFyddJ+K+OzO5ifdsjDY8/NxnaO2N1tBmMcXlKml3wBN1Ks
         LtHaVmBqRpAQMGcnXrBtvTL7Yd7EgJz98ct4wXzWAAwLqKabLVc3NIgIQlCU8ceBuseo
         DdIQ5AOKXResfMJsMbHMMzdXL8vkspAKSFMp3JAyNZmt+PV0a/NEsacVB5eI/UR4HN1+
         fu4q0m9Y0IkKjlqsPDuNZ5tiwo3gYKsRJtnYznmyQZzd0K8fEzMTCnWdK81Ay+taLQrJ
         75Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVsswSN/94JCEIJV8RcQa7fb7GMIplDeyb+m2eLfYytUgm+2TrxpQpWdmH1oBPOcIrjXrPq8aD4LdoOJ2gUIoRV3ZcLrpFMY7Lpwu6p
X-Gm-Message-State: AOJu0YzDlbObb9FUHs/6JozbMM/W9s8nQJUJB6cBsJnVOy/imWkqPk3n
	WUOTAy/qJxQkKNxlCPfpE7HPGwfQBhvilp1QAPvDyAEokCTh+Ls+ueHqwd2SCrRTrcGVIkHPPJ9
	1wk3ZRuZWpIrVgjmpY7qwy7wGKa5mvPIgHTiYcgHTjBpw6dSnV1Fda8A=
X-Google-Smtp-Source: AGHT+IGqWeZF7f7qxBteGm6LpkGvg/h+4M+Y5AMI0eMsyZbEkG3/n5Zic67Lt08n+DG5lWhDcKmH9He2yIUjrlrdfLA3GvZEURjq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:368:9bf7:6b6d with SMTP id
 g14-20020a92cdae000000b003689bf76b6dmr260400ild.2.1712415183224; Sat, 06 Apr
 2024 07:53:03 -0700 (PDT)
Date: Sat, 06 Apr 2024 07:53:03 -0700
In-Reply-To: <ZhB6Qt48rkC3zMUb@surfacebook.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4522906156eba46@google.com>
Subject: Re: [syzbot] [serial?] general protection fault in serial8250_tx_chars
From: syzbot <syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com>
To: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@bitbucket.org:andy-shev/linux.git/test-8250-pm: failed to run ["git" "fetch" "--force" "f7e55974102a831d64e9ca077790e9122f71f6c9" "test-8250-pm"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@bitbucket.org:andy-shev/linux.git test-8250-pm
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3761490b734dc96
dashboard link: https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
compiler:       

Note: no patches were applied.


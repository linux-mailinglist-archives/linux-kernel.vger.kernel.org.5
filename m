Return-Path: <linux-kernel+bounces-45254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99E842DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E861B25513
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF20171B51;
	Tue, 30 Jan 2024 20:21:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005FF71B3B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646067; cv=none; b=sGtsk+CqqiHcO5Gb2kAivuIM/NaE+sg8kp8a0G7Xc+74Addh+SRjO8wMYhFvjAw+oQHcw2KPwAqmMplnf2VUttmEcz5MKpVDVGT0ZdSw7BtafvOu/Bw1pYFYnjxmncJFoQ++YOtWcc1lSRSpy5mtCNGkbXbDGako37gRgDnGaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646067; c=relaxed/simple;
	bh=6Whe6AwLEBralu+vWJV9kUE4FgCkTRWquwlfb9ua0rs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LO1NQ2U6nuPl5VdCzsB7sgfYzOM8+jL/EkBtdyBpLz0dmoMpIf6xEodTzkCwn5yDPr0++YLFB+MsfM17oM9jI/x6k6j20IDhq+DWg+y4B732xxLXBqSRbacQ0BKzt0GDGcw2MHnimAqwT5mS2/M/5Y0fPloxAXMoojwLpbE9Uec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3610073a306so29814415ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706646065; x=1707250865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tY7TbbY+OxqDcNCFbZlsa7ixgM09Bspcoz0Qg8jCXHc=;
        b=D+9Xo7d9mfOoPkYMhbb2pZiISrzkelRg3jsg9EkYcSqEor1DetUHA7/vVf4kTqY6s+
         L3WKliM6Lcn845G12U/Px/LDwTmB8c6B/E2eZUHebw8ZDeF37y5KZi/8dGmLLtA5xzZM
         L0uyC8TCgoLFO3AFvHMU3YOY0zjU7xqs26pMaqpQm1DkvT7Hs8IqZL7NJZnwhcvN7url
         6qePYe97UyBVEjtnqJAXMaeewQOi80r2kwuZWCPQUlt3UOQ3tZ2fTkI3fkG7zOGTGtUD
         09O/LS7G3c/td3NSVPQUzxpJlCnjPtn3bHNQ8iGGtw27SyndlMjIFPmobjqVfH7eORjA
         o47Q==
X-Gm-Message-State: AOJu0YyzQDgmn5UmKp654TZp0smyOOMyV9aac8G61bJoPdHBkWGsP7vZ
	OPgfnvhOss0m5qm19rCMKmYhUq87pEiXkyzGUDHYWUwXav0JaViZl5vOlqIPZKIRrO0jT794caz
	eF0kYEf1BK24p9pvUjTFT/h81ScIp7pFOQaSXFv1uHJmFLU7+eEfEBLQ=
X-Google-Smtp-Source: AGHT+IGeiVZ5nz9aLGqzhgIKYZcNwLrt+k01v3LB4Co+3YrC6hBg6KuWFlAnQ3kCJodaONqKV0BEDysufldVxCo/3ZrZVVF+RYSB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d13:b0:363:9211:a723 with SMTP id
 i19-20020a056e021d1300b003639211a723mr12008ila.2.1706646065155; Tue, 30 Jan
 2024 12:21:05 -0800 (PST)
Date: Tue, 30 Jan 2024 12:21:05 -0800
In-Reply-To: <5ce906f1ffaaf0c28b1c71f98815347f5b972175.camel@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078981206102f80cb@google.com>
Subject: Re: [syzbot] [rds?] possible deadlock in rds_message_put
From: syzbot <syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com>
To: allison.henderson@oracle.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master: failed to run ["git" "fetch" "--force" "17ea04619614dbc19af5319a14e2d91163abd37e" "master"]: exit status 128
fatal: couldn't find remote ref master



Tested on:

commit:         [unknown 
git tree:       net-next-old
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ca07260bb631fb4
dashboard link: https://syzkaller.appspot.com/bug?extid=f9db6ff27b9bfdcfeca0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10bcb337e80000



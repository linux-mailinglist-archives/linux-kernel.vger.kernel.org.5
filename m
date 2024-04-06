Return-Path: <linux-kernel+bounces-133805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EA089A8F5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2DE1F226D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB971BF53;
	Sat,  6 Apr 2024 05:09:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9C208C4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380144; cv=none; b=jck5/v82lUCobusFisTr23tPNPhDwIAesrR+Pbo3YGAxOXH25dCCIUX/1cjQfI9k2IaJe1IDV0vqYRNz+2qZuAtuyb3QKpiBvbho4sGcR/Bp3CL/PQTiZCHiBMXtZzjiHlMJ8Ccq/KQFQAcZpA2Lg4e5xOm2Vt4aai4V1mchV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380144; c=relaxed/simple;
	bh=itdSvRU32vZ0tVM/xZfb/YoaE6ctlnJgll0P3UDpHJU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cjs8tTJibpx7IoMd45pPuM1rQiGNzk17ROHiR+ZLrTVAPQXAL637P4iOmIB26rCSegMzvCtxm/gqT9ld48XYdel2VbIsYjWFKddiH2VEGbxxOYv+H6CcV5VSYKTneXjY78uAZlbvJdiof59Z/q8nAJIhrvyElv0fUzX6Q9u6nfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso318762139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 22:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712380142; x=1712984942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KV8SwOnj3w62SIgU4hu/Zw/a+SW4UyN+uMik/TiSHsw=;
        b=Q7ClOijpmHkHym7xGAPXK64Pf1lfNYUXHx+xrXAThNY1M+we8CKHc9WwH4T4Ymf74f
         OF01wU27jpRCc9ypUQQhUkSpg67nt9Znakfp92Y4N6jIg+1PKa7teCdpT9nz7FnyTAvc
         7rFODGZ3Of6WcqSrD9AUU/9qYFJgTm81qU4Up0njAgOUbtefFRK1Bnhg0moWyexv8GCA
         0eM0zEpMEzCtUtPRXD4h8WqhT2clIvttAJc2YOcpHlf1WBdhD/bglFXiEb+Prz9mRL68
         zH7kjvdMa3jPEdAzLe2QIV0CzOvUHPA+bTCgAy7NT3LOqivOn+bfzfeZqCE/jvqjSlZQ
         5lSg==
X-Forwarded-Encrypted: i=1; AJvYcCWl5SrayPwGgs28lj7r0C/Yu9ER4HbumvjsLLfjAFEeeBmDy7c6WypkmbiwzgnG6zp+P2Yp1H3+NbOIK1nK6A1+UXoxnsZULMyLoXGX
X-Gm-Message-State: AOJu0Yxz4RnY3KvyBjhwRwj9Skq1a+ZAXWUoSc/iFRqVCCMMQ1DWyEvh
	fXfu4Cz2rAuL/uEiz3nI8meDUa8p4Ov+Nu2V6369pJmUuz2uQJlpNfGwJjzl7tsIDrsohg9yh/J
	ybqJkF7l574Ewlte42U2tZWxVpyNetESpGMNZcy+MhyZTNu32/aFDol4=
X-Google-Smtp-Source: AGHT+IGbRwU/epQK8baEmLsNnzl+MmBJTIHRcES6+lKhSPmBrZIjBuYQ3wDchEEkz1DGuExOgPRJcXgN/DD0ZG/3tT/9xxSiytpB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d95:b0:7cc:8980:5ae4 with SMTP id
 k21-20020a0566022d9500b007cc89805ae4mr89738iow.2.1712380142543; Fri, 05 Apr
 2024 22:09:02 -0700 (PDT)
Date: Fri, 05 Apr 2024 22:09:02 -0700
In-Reply-To: <tencent_1604493766D774A6CD337CA363296C63B305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001df6f906156692b8@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in hci_sock_setsockopt
From: syzbot <syzbot+837ba09d9db969068367@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1590d38d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=837ba09d9db969068367
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=159cfde3180000

Note: testing is done by a robot and is best-effort only.


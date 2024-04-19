Return-Path: <linux-kernel+bounces-151762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B35D8AB390
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8964B1C20F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2313666C;
	Fri, 19 Apr 2024 16:45:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA36D7E783
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545105; cv=none; b=bPjT0sTwL5yINTpeWqhRtmic5+lqBnYB45lDAvpzPEyQLuJbMVuaesIC+KCFQb92H2YZEwaz2s9V7VyHcv9HBzlFRtEQ3aTpKI3GSnpFG7/m/wTTjNhFWXS31NqYCkdr7TAP3Rp/U72/POWLHRXcdRKfW85DYSbyfRAsdGaOSt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545105; c=relaxed/simple;
	bh=WgqeDGtJ/flOJVlMcoJaVHiIAS28lDnmvjeUgGHlj54=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tebLAI4c51XuB3ZHtiVVKJKHRmRd1n77z6pnMaYL33ow/gesiUCyMgG2UTYKxUUCrlHDP+rkLCsQ+dMMWtMBJkE1vsQS5vlrmLWauKUjJqXgKxf0KmKsXT422rNzJomYYqxcKfuxRaLnt7UcWQNHLwCIpGL4gwKOTDjBwqTZGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da18a77b4eso278299539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545103; x=1714149903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETZSceMKeWmG6Z8GggV0FKkZV2BQdNu36VKqFO4Dm2c=;
        b=kyiHlRLJndtOTGKUZqWcJ1ULm5c7R/fCk3YxbUD+I9ic3J9A1+qbTgnm3CI1Qn1QjL
         scToQrdYAUwLVn6YsxXADiq2+/WK7+BxjlGcuOVD/gmvidLb/8ZJs98WttQqBOlinLi7
         Mxhja/M50JxCmAN/RixxY5Sztbk7g0pJoHzNpvSKQdKQUk/lzptlh+6xukOY3aOVZflx
         RIvYgYqzzu6yx3yViwAN5svhDX8ckmn9eNajMtV1B4eBiVPGHkpXeW5kXuKubd7B1WZc
         KUtQC0dSqgezqb4c9pCQRdmZcq95Ph5NRHO19D6H8C0JOrVqFViVfuOXQMYQChMoZjoF
         Lh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV11GgGhZcr98LU0Ahn7Bi3xqfIfkBKvTLsjiSKed/Di7O6+6KSC3/2vK0vut7+0Foue7/uxA4upUtVhsju1rC+QcE/L0q1IFDyQytO
X-Gm-Message-State: AOJu0YywQHpYKPvyXR0FRj3FwE/npqAqlpLjsMZoSOSjpsc3fYN0j9sh
	LgGNfSB21tE0UZkqA154P61lCApl4da1NC/e6zrmNMtPaCdAheNXfYX6UmwKZ6dwq04zQTCHoZY
	kCd4sHQouJRj+csf4jZ8RrFrx+KuGOd+mqsSBMn9vj4Gq08XlD3nZSA0=
X-Google-Smtp-Source: AGHT+IF3yW9Fdexe92n3pRPjsK3A+lvbdipPjC1PLPNkj9cdgg7bSLwxX/lez+qW8q4KDFuX0PbB/KdPjrbM9SHfjseb3RTida0W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8785:b0:484:e71e:4966 with SMTP id
 ix5-20020a056638878500b00484e71e4966mr62722jab.1.1713545103137; Fri, 19 Apr
 2024 09:45:03 -0700 (PDT)
Date: Fri, 19 Apr 2024 09:45:03 -0700
In-Reply-To: <20240419155120.15602-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ded75061675cf78@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com

Tested on:

commit:         2668e3ae Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113f5af5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10feef00980000

Note: testing is done by a robot and is best-effort only.


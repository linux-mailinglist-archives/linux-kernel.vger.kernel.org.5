Return-Path: <linux-kernel+bounces-111327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF8C886ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC52B283DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E773D3B3;
	Fri, 22 Mar 2024 10:56:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC717575
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104964; cv=none; b=JJCAteZL/RPfFRHCGlUQUv1ctozFRIggZEy54nIKXG5sfHghwenb1sozh1YBoh633EM8XGrfVjlhPDIsSRRdbR61/wEwIhNaHZsDUGLc7BZWjJtE9GXkiVvrBzh2NzQmWshJ+b4SdVW/gXpuuDQYjiLuYhrlvzylnjNecAmozyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104964; c=relaxed/simple;
	bh=mqZ9L0OdbQcERbbNJQD5l8r9OzFfI6NKBfKJQWCYhUM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cj+hOU29ufbhSVceXcyd32DnNw99wB72ET3veAGi3+Aa8w+h693sL7c8iK+vBibP7MzObyn5PfDa47F9bt0Dt9dQllGmXybmt8N6YNy/Vp78OUiPOFF/a9Phc5TgRb5dDTRxe4E8kPo1JK2B7qk4rFlfNZK9RNvI/1TEcf+/MAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf1aea97fso205707839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711104962; x=1711709762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBHm4qBfIyCo4AhznlSyYWOu4s3AFnaEtmt5p6by+dQ=;
        b=hNg5iuDIGGxmeHOgXeHBeVGnHV67gtDt6iuSobFNr6EiplZbrGUJOP7rinHZ39XrQC
         lLr8ywKCtzmBtU24hmHxiiZnfoXPuvJDFf2xc15M3IwJt43yIDEEhghDKO70vck7Mz5y
         7B+0rMrrOz2a8HWVK8KrYFHuNcVkKGl4AMWo4k6v5HKfIWpdeM7HTLHAOsf5XHeOw3Hs
         rwYlA3iJIpY0AvzmOn7ROOcNsXeZOfRZncYg0PMPXW/UKkYbdt9rnJdIUEwe5T2f/eDf
         Y9ZwUKUmF1fCBHv7LMLr5DIG1veMfaseJiHPfKCOtoxWWcn8K80CIz270p8Q7BdDxQbU
         eR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3l7JjM+rpcV77jOob5JeyyvfzqXmu/amG/EW4HTly0mv0nZ2F8qnabKxLZ4yfpfLVLsHQ2k/jPPwYPkx6APvYV44nj3tw7Gi+lh1D
X-Gm-Message-State: AOJu0YwWM9okQwXgM0e2JaaupEJV2A9YFJbb0+qa8ezf6BJyUqAh5TOZ
	VO+jZu1i2eHzeAmIlH1X+CvwEL6f/dObaXEH4o+WAqG9Uf4n/UrUxiEvtFOo0SyTabg8GCzu1jy
	QEKYdZsDuyWsmq7dk0Xy6FX2QG5rhaLbY2nKnSrP0cIRebnhJlENH4Xc=
X-Google-Smtp-Source: AGHT+IFVymCg5ymHlTKl+5p3k7Xe9W6ZY3N6dm638Pe2JGO8VFyofRzM73jO9+EX9kefWNMJBewHXhM/VY4vaHBZEU+ZkNuTYmFL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270b:b0:47b:ec1e:e32c with SMTP id
 m11-20020a056638270b00b0047bec1ee32cmr97657jav.3.1711104962510; Fri, 22 Mar
 2024 03:56:02 -0700 (PDT)
Date: Fri, 22 Mar 2024 03:56:02 -0700
In-Reply-To: <tencent_C325838D999249DDEFDDAA191E4FF08DC007@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076db1106143dabbf@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in rcu_report_exp_cpu_mult
From: syzbot <syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com

Tested on:

commit:         ddb2ffdc libbpf: Define MFD_CLOEXEC if not available
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=170141a5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=c4f4d25859c2e5859988
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b44711180000

Note: testing is done by a robot and is best-effort only.


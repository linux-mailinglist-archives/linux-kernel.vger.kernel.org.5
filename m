Return-Path: <linux-kernel+bounces-75939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B051B85F0F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB04B23DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F092CA50;
	Thu, 22 Feb 2024 05:30:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9F1C14
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708579806; cv=none; b=j45bVIiz6th77UY5QfZoqKydd3+dbt6rrSpkCivNeQs4rBjYTtaFyOKoXS10eP6aYBVCOKXdtUuaBD4hfToDQ4Ko6YbGUvvNNW1FQZpGZHSV5t65rQXGrD4rJRSzLpNwuf9u4aHqluVEbdxAmrCKqdWjQ8lVyRwwjaqdwJ9VOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708579806; c=relaxed/simple;
	bh=Dz+ALvIx61ztw7gL0ECM1lAfY/VFywG4Fsc0e3dyWCo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=le4AVn1vXuUZ1Zt3cRZRLpOt4WhVfjbni00DQf1Z9MbkrdSZpHzC2/4el0eL8gVCp+Hs3VTIb7PterXQsFeMZsym3/47qPz/1pF9SNNXN3UKC6QH3nA1Lsl7/8dDnr2Ov6pD64sY7ixcw4kgt4w15T+bR52ZqGdgz1pfRM0LMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36516bed7c3so4905705ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708579804; x=1709184604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jy0xsTv00wL7/s3tQmtiwPpIDLD5sC80I4RoVl6g3bg=;
        b=f6j/hRPtZicKOa9+lLN6GZGHTnRwkDCkB2i7ZyRU+PNUHOHyeZNL+HE8IqRoETLXwu
         8RQ+N98DoBT5v1Au3P2jipSEkd+2xFDNdW3mnX+I0yXzQplQUf38VFuCtRRFDXS38lYi
         Ml/2x6CNy4w2uwtQ+a96dY9G7f5Z0m+KYh1AZrkEsd3xpkjymPcyDNEzAJijrM/+PQ9R
         AS1+Xk5tjji1LW0NbRmmLuj9hkPmOusb6PFZWLSMy/jAH/ddmMIlQaSenU3VHsIK8rHW
         jwLg5NkReyhZlF0X3vcqejGNyMCDZMPzkn4Ptcf/oFfTS6PluiYcdpfM1k6jvB6/QcYp
         YK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmuaXFaYlXZ55Wq9sctzcb5w7HEsfJROOkyjKE87q2mGcRRvvz36kTQsnUmOjw3asjpp3P+bklp5/Hr2mO9XqPvGHzcURuY3n6nZfj
X-Gm-Message-State: AOJu0YwmcmSsHcVQ19f1E1oF6WbFlnX34XaPLJbyCryOmJcgc/iPLkjF
	Ng50HcMHlJenn7Dk5FtBS74ONcX4Grt/LtIECOGYR9Mwg41DmANmDI02qc8XkNKGpmYzov37WIG
	W4cR2UnHFl1Tk0oa0id9MqMlDCxnqDk7B2UVSxADOmUmI79gIbG2PMwM=
X-Google-Smtp-Source: AGHT+IFRmjP3tDGuGjJg0K5pbZRXbDcyk8eWoaOOtD6Ts488Xcc4/klcqyb0iZOAh09jqLeF9VnqI0iEkfyXDvzWiHG5jL8uRmJh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:365:616c:59de with SMTP id
 h11-20020a056e021d8b00b00365616c59demr82621ila.2.1708579804715; Wed, 21 Feb
 2024 21:30:04 -0800 (PST)
Date: Wed, 21 Feb 2024 21:30:04 -0800
In-Reply-To: <20240222045815.101-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054a54e0611f1bc01@google.com>
Subject: Re: [syzbot] [media?] INFO: task hung in cec_claim_log_addrs
From: syzbot <syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com

Tested on:

commit:         59a96b71 Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1474b4f8180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af5c6c699e57bbb3
dashboard link: https://syzkaller.appspot.com/bug?extid=116b65a23bc791ae49a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1369628c180000

Note: testing is done by a robot and is best-effort only.


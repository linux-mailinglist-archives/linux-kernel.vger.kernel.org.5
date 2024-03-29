Return-Path: <linux-kernel+bounces-123858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E369890EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 796B9B23245
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757DD184F;
	Fri, 29 Mar 2024 00:11:19 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2EA29
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671079; cv=none; b=Sfc2VkIKykCa70jmDNtwN5AkccpEe5loS1Cp75HmXQGXWbELGd9hFlRGPS6qQXZNYdWSrp3fnYLPVIdyrBYRnibnnKb/JnLdsfSRL2f4U4U+hB9pPemQvnME30RkhhXFXw7ZtytPFqGZgsX9Hh316oHctlri3f1SQK6PsEiOkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671079; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J4VEnUKx92rQYaKAzgOAzUc+6vWm+HHlKD5/gJgTOQRKTxK95DR9naZWvZeO0i2HmzvJ+NKjSXPxNbngymHvmFIirdl8tEwlmeZEqiuEKXbNyar3UZgpLFszE752lqT1hnJmF8alsLcB1GbSyoY7k3CmmIAuEOgYs+SgLf2aDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbef888187so132856039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711671077; x=1712275877;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=PHr8eDHuUZYCMLc1lUOvEUcTzQBeC1nf6xkkqaKCjl6EKfAsZnql+2KwFj8ZvDIABt
         +AFFJCM4ZBlRovM35I2sunC1R4XaXGL5RII6KL801KAbKRZkLHX2V1fQT52rtqWSM+DG
         utq+SjSwgjrYklYAbigZdzbMmFGCorQ2LmCmb0VKxqkDpxJ0MrEeojT40xU53fYR6kWS
         f2D8spBewtyqmTcwZRlR/Ucd5tZtLwZMX7k325enDSucLigCAyGr65H7umHhxe95Mh8y
         dTvN+uO14oPsiaAxAPBG6bvl962gx+ZAaaYqXERmEGQJK9pxyN1PcsSAkLHQNJV6wYiC
         SP3w==
X-Forwarded-Encrypted: i=1; AJvYcCWkqtQ56MS+aZQeoqKYOE/BQqpvf31wZ9Gk+mys8GooYyJaK86pn3OMM6B5yB5nLBMMc2zQUpzLB+yVNh3NEj4B2PntcfhYRl2Wb4k2
X-Gm-Message-State: AOJu0YzJIQ0dl73XhCfdSGcdE3XXA9+YMBbADAtzQkhlEhdUq8vOeQhk
	N7WbDIR4EIyY1Ac/ESVTWZrVnOxA8nBxytCn+0w1jU48OZNktdQSLaaBkPwXu7u0X2cB/0zqebz
	IXIrz4CXqIwOBjD9BOfxakAlcdXJNSM+Jl8ZJpEh34+ng572ze45/SEM=
X-Google-Smtp-Source: AGHT+IFkuzBOXLL0qovYepiBhl4jyh5xiqBtn4XTNWP9BC4uhLKwBQok6OoN5qt/kdcWfaL0mr2Wio+as2oxhYmU6Eq/0T3j6aeR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c90:b0:7cc:8980:5ae4 with SMTP id
 i16-20020a0566022c9000b007cc89805ae4mr21732iow.2.1711671076996; Thu, 28 Mar
 2024 17:11:16 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:11:16 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008461a90614c17a44@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos


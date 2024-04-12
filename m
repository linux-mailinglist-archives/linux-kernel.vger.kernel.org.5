Return-Path: <linux-kernel+bounces-141738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 988A58A22CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5C8285DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A51373;
	Fri, 12 Apr 2024 00:12:18 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF7195
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880737; cv=none; b=k5KUnMKTOi19yCbxAi73Iks0WCCvhsMRdk+XUWe1lNXfm3EQCDdWm9tYYosdHL8t9uOFU+LMSaU4xugezqx2galRXrvRJ+5n/dOoxKkJAPh7LMm5RSxD9Ajwb5krMWL5YQqwrbz7+FVVrBrddu4r314hNiW79GnReaua6TpSFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880737; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=keydOdugzFdKck6ku3rwHIsvHqmXs5CBJM8eurdKqzmFxDdScqiJaKk+sjfnS/7T1GcytI0jadyJIPBphSU8lp/WH9AcOO7ueczTVNXCgGaUOgvgL+ZrfoOvfoJ32HHHe2CtgpYQgplInlv/DrpW/gAKY2HuhjgFacmAZ0EMD20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d663e01e24so34679739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712880736; x=1713485536;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=lbbSNEeJPYyY/Y92oUA3eiCKyzABv5gNP1HSGJgMCMqdOx3xi6K/h4JG4WQ1C3vmyg
         mdxfM8ExM0ebaBbYr8QGJ4PbBvnfnk1wjiq3iZbISmolTyAm9ThtZxmdyh4uDIPOL2sV
         kH7WaKODmItQ5YuE5CJO56P4RU6gwBV8kR0VoAg+5Li0Wt2igoO8rNUjqHX4Tcd5NAkp
         3qpZTq2eXn4xiG6iFEGtUX7ylT2hQ1Xns8QOFc7d81VSqSzEtmMgHy+K9yTLXPlL3hq7
         d4keh1exLSZ1RWp1Sm7VuUauwDD67CkiTlMtqvgZG9Y20kXDgJKv+cepnQgVx0qV8+kO
         ycSg==
X-Forwarded-Encrypted: i=1; AJvYcCWr/evnNuimp2QESttdqDCEul0PiiisSVX0aPydZnQYsBIan64swy1oJP4Gtspl2YjJWNrrPbR8Z3w4ri+YAqwLvnPsHTTIUW//sMgF
X-Gm-Message-State: AOJu0Yz5mmPcSBH1cT9I2fzamCyUgmLmnfDh2jxsnx0J6ZTR9CRmRzuD
	HybNe/41r3BroKluooQtA6ULQiK16xt25RAKYz7sM/1mSXKRhoHsrszr+95PkaKYPuzTozl0Cgw
	N5FdtU8WfVQQcbWWFt1TcvdwGNTiq/XZ7cdYZ6iBm4oSQGy0HNdZNTBI=
X-Google-Smtp-Source: AGHT+IGPlaDxRGtKaU/DMRiUe5PWJiF7LrwgzS8cpk8NZFl7S4weT6qQdoo/zfgG27V41YqUbOIssZBRjBGouLo6WMnLWoMak0UN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2199:b0:36a:3f1f:bd4e with SMTP id
 j25-20020a056e02219900b0036a3f1fbd4emr65843ila.5.1712880736039; Thu, 11 Apr
 2024 17:12:16 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:12:16 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d091340615db1fde@google.com>
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


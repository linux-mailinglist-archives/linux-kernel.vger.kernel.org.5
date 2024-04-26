Return-Path: <linux-kernel+bounces-159376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E48B2DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B31BB20A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1B97EC;
	Fri, 26 Apr 2024 00:13:14 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B61184F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090394; cv=none; b=EPmqhXDaTQQg1V298Yns9ACuo5UpNZ/n00jpgvFc7YzLtsIyM+AnWU2TFP0jRPoAOgNvtgHFr+jLlZufTXNNo5G28qI0jpXxTioX1NSjV4RbMKXDTTeG603Ivux5KTHQukhHyAw2YMtKfDipshvXQNIw9QDfJK8soH4YjBB1qpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090394; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YelYIqsjOLytsmQ0PTlUvGxygEm2/o6lV660ooLJWjoI1NlDEIotYGjXIHdhx/2FJj5TaRLssKK87PuFRITIxr45dIpCxoyz3cTvL7Fz3DBBb7i+6Bp7imekK9i73l8jlA9OmdJnmlLM7qw9fod6h1/a+0BokXXbrOiI5W+203c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d676654758so155084439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 17:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714090392; x=1714695192;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=o0jhMDD/wITTtAOjSNRLp4A150c7m9la4n5P3dNXjqGgyUTAT0DSAXUo6SAtnkbphl
         ZTc3wj5ID8zEAJyWElX1EGv5a7QM2ElVmojEJV/MqOP74exyNLF2IsexYiAWHj1TUz0K
         VKdOhmNKei6ZZ+QA+AoIVvTUmaq7FyLtZN/pbNBAsbusqozNOh6++oNLsOfBqPoaCOQQ
         sOWjzqZ6ahT6KmRpO1BkJrAKwt1uoS/woLWi6Xuieq+9WC8CD9PDEIyC1vYi2OjyPSs+
         L7UIzkF4QsJTqxAkQe/TQKLUU/oKbaW9cBHsBl6532ZZV/wF1MMIvTjpQBH6CxRF0jrS
         RIqw==
X-Forwarded-Encrypted: i=1; AJvYcCXx7Qu4+nSEFynC9R3MZ5GLD3370XQiY2zVm1VRPxYzK9X7r3sdMllms5F5pXmZRqYgB6T9i6PVUS2Sx+8cKnx8DMOqE9tokSpPn8Y1
X-Gm-Message-State: AOJu0Yz0IEl9zP/+RpHbZg8CPlrlJn/d4611699GIgK/EmdnmSFtyU9Q
	3/z1AQkbmZMFTH8d6OGCopWmFLG3H5iaLshM2mX5jD6VbNy4hq5mIr6efsy2wIE0wc7ETyQgvsi
	EmE74VNhzOuHq1Ll5aER85QKkvmIY2Btd2uqXauSJ/D2sJH4Kq9JdR5E=
X-Google-Smtp-Source: AGHT+IFBQ6KqJ9MNkuWzmeJmcldi6/iLn3+SLDTRALCbfTiQw3sNCK/oxmXwAQU4/o+70OeMPCwCoi+4DthNibPndYXd/wtGmW/5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:870c:b0:487:666:652e with SMTP id
 iw12-20020a056638870c00b004870666652emr77404jab.4.1714090391978; Thu, 25 Apr
 2024 17:13:11 -0700 (PDT)
Date: Thu, 25 Apr 2024 17:13:11 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed56a80616f4c41e@google.com>
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


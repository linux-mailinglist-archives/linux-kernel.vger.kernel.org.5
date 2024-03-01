Return-Path: <linux-kernel+bounces-87717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6573986D821
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401F61C20E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7083964F;
	Fri,  1 Mar 2024 00:09:18 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3364193
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251758; cv=none; b=mbXDIs1cHPO/MB0/Ix4dTXWv1rgib33cmfVd+r3JEPdlm98tMJLcNQy0TJEvDWABhjBfQlpBL7zk5lOsF+prFSyG5nIVkC6pfQ2alHapD+58SuyqGaBJve40/l1ZqDo3bIhRngWuU9lGmeKVosyycsBzwvxLlDrNyo07lRBLnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251758; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OEEDTIK6Jc23QYP6Ihk6IZAp82bI2rNMdEZU9g+jybGTSt/JyvMgJ7s4vmWLbujBjesltvaVjHa9JeQctbIQHOJ43PNnGbfkTmMAgXwofU91pDyY6o9IVMPUVE+oYGJ5RrEUBi8hv+nkxm09sOp2KN14rZhpYpkOiGC//JCJRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c79b35a7d9so154904739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709251756; x=1709856556;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=eL9EbFsANvZTLGSD9/JEc0kMcreRhnMIeAJHYd+8qR/fJ9tmvTN164Fn/Pc66uM+W+
         HUCQVvR4W2fVEJI62mB7lLiOI6D8654hXe69mHBUtmiAn6+Ch+FRd8GIqzj+cQdFlzfL
         OCyJivlJTnGDyOq2i5eA33zINQykk5e+o5e2G9eMCYnMDuzKotrqETX9VkYh+Wx2RN84
         gXAo3jfWEM2DsLrdIfBSpilxg/kWBmqhPHrYj8Q05u7tS0CQ4a2ZPDbRHykJD8ecAYSl
         ug8vE666bzUI24ltuDuZvcoj7MYzM2MSAJAiYWb9eKSLe+KehEGv9yrZEEtL6DAY1l76
         IAyA==
X-Forwarded-Encrypted: i=1; AJvYcCXI8bL4lf4llCMN7unsgDhTs6ioIbpKG+7ks/uUdvPqsHx1Vjbxo5lfcL91epgL9/SJYvgOnk4Ct6GAzYKRYfrzbyUKSZBqvza+3iuc
X-Gm-Message-State: AOJu0Yy0iVW4Wavj0wTru0woJpp5UiNXql5uRxs3DPs3BtC88dqHC0jO
	yEzG13Rkewqg1QkZIPFJQfu4WRW12L8OmN1kvjMezlrUXxlS51JAxwS/jqNACIpPJB9BevCRq4P
	sXdjwXVtHNsL2joRKkdDydnDRNJEBdkktRgD/H0SdLz9sgmGCHYoislk=
X-Google-Smtp-Source: AGHT+IF1nnI/87DSuYVyJHyFMx3cgCkTnpwj/TZE+2xMgjsyUFkCxBPx3hKByELUpmmAXvAvuDSZjzuY42lMZuW35NVDWyAj9IiT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378b:b0:474:b754:3544 with SMTP id
 w11-20020a056638378b00b00474b7543544mr17329jal.0.1709251755808; Thu, 29 Feb
 2024 16:09:15 -0800 (PST)
Date: Thu, 29 Feb 2024 16:09:15 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc9e2d06128e2f0f@google.com>
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


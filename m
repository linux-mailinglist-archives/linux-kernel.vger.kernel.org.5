Return-Path: <linux-kernel+bounces-56425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC1084CA01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D26C1F27C74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED66C25622;
	Wed,  7 Feb 2024 11:55:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1825605
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306909; cv=none; b=ZwILPLwP0db3nmo+IK1Nbt/c0TUEJdHuSX01BUS8lEk+1k9/r3ifBzd3r08n689wJgTqnZzu0cmdz8BW/TbSmc6AozAwtXUub6DaTNe+mehAeYXQ+ohgmJUg/ggZ81PWkbBGz6iYqF2tuSiiA3bYWid7BbJAVdP4ofx9b6PrtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306909; c=relaxed/simple;
	bh=4zcDBL9jkLCqNHK76jhmIK9uVG5xCinXelIWVblUVpo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iKXgClw184mZkX/bFN435n7Djh1pU393QAXAGigc2BCZenrvZyvQN0Ca4dkxXBHVegsdvU5uadPPEmvs3BZh85obJ+DHGdt+EKIokoCy9eRkxT0a/EBSB/wT0r/Ocspo3eF3S8yMcA9Kvm7JYJrHtgXqkkocPtdQazeGEBCrPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bc2b7bef65so43590839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306907; x=1707911707;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4mt/43e+sg0oB5biNE4cwwawSlvqQ5Gok3sTrWWbcY=;
        b=mRQNeiGPGZEs2dGl3g1BZPfHCeTGITkmYrXL46TAYEpSRbiyLzU0342x18a4tE1LlR
         H5hxuxX9cUoY4Bx3Ma5QqR0msMARSRuC1fRvOLD+7oR+/asMQhhX1Wdas2W5wMyLoDKl
         7E+9a03c6dqAZPXibmHFTqMZAxYfIy9cWbrZ4l3PsIWwXxNfZLb1YUQ3nt+1QCrOAiqb
         jcwmlKpEozvw/cMNxqvcXXlZNmZcF94Qs+mU8BLvbWVIZggGGviSQ0Nk8+1l1LCcdw92
         JrKMU/EBEWAWgTZvK1A8MQGUN7WByHhIVRkMrh01eFC6vlM/Zn/ql5PbO6ATJJkb5271
         j9aQ==
X-Gm-Message-State: AOJu0YzAT1xFTOBbIHyQu7e72D0zAHbYE3NhHOxjHKW0XFC4gZjtxD2E
	ynPQZiLheOxkUTYMWEfnOMzj3y1p24QDpPWIesyXdud3aJIkmY+oxVcctTIBAKoi/r7Py3r8CeQ
	jpqAL47Uq8+0/J0zmrYm6Ov40I1aukoRN8bIJTCHLVOkmMTXOTUUaixc=
X-Google-Smtp-Source: AGHT+IH8CMTjJ1WUCD+EwMkxudoQ0sQ0AxE+AN9+lsX7yRNdrqd2UQZcHRyWA4kJPXVh3upa+7bvAJiWpOMU4pL6YxRHT+GKNm9w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6414:b0:7c3:93dc:cb5a with SMTP id
 gn20-20020a056602641400b007c393dccb5amr136126iob.2.1707306907214; Wed, 07 Feb
 2024 03:55:07 -0800 (PST)
Date: Wed, 07 Feb 2024 03:55:07 -0800
In-Reply-To: <20240207105801.878-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba2bf50610c95d96@google.com>
Subject: Re: [syzbot] [ceph?] [fs?] INFO: task hung in ceph_mdsc_pre_umount
From: syzbot <syzbot+4bbc13a207327f82b3b0@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git on commit 076d56d74f17: failed to run ["git" "fetch" "--force" "--tags" "fc608f7504e8b3e110eb6e7b798cef357818c5e1" "076d56d74f17"]: exit status 128
fatal: couldn't find remote ref 076d56d74f17



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 076d56d74f17
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=4bbc13a207327f82b3b0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121b9f3fe80000



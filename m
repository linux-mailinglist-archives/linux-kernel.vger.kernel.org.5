Return-Path: <linux-kernel+bounces-65190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF385492D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF32F290845
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9AF1BC4C;
	Wed, 14 Feb 2024 12:26:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761B1B95C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913566; cv=none; b=ZwqqPVEXXGSIl0xkFPDTeH7vPyebWNO4WjF63cZlV9anKPddYAU+oqDz5+a7CvFejEdmR1b1pqP28oIR2x+IPZNdygpA4PA7UEigtlKHlpirqTZDgYjX7VgqUloZ7+7EGwH4c6sEaCy4GyK+Oc1Q4erRU3EaiCgZkTCdAMH/z10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913566; c=relaxed/simple;
	bh=tkVUwxVXfVNVj/4bgUygoYgJAr6t6T2rJxt68o2zTmA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rSl+GjbFwHvl1wbqGI5ykKhrVvNh3Ogba+dZ+UuXbh8L1yRnlVcO8df3A0gkEk1d/b3qtrGawDGmLfTqg950VspF6o1UD+6S9CUpX9MetgGEzXiWwsUhmFwq1SK2CoGM6qYlORh0J/uhjIn/EFJzf42FyrHMeDVsSmxkWM/7o9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363dfc1a546so53624465ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707913564; x=1708518364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuRuKWD6XthRWvA/f/KGCLnGbWDHfKrqFO7OLr32afM=;
        b=IgNfLBQGALJo0Ljzg4BvCA/Yteln0UFp/Uic+cwcUaA8y9fM+DcVz8rql/BbbP7gFT
         8jr8lcK3OAOfG9K4vbzPbjW5tgKmv0L2ztm6Dhc0UK75Cxx2EddlT/9GYmIBRcfBKUcc
         QjUQE4AW4+biPUeIWDG2n031190wiVDKlEYhArLrSYmIqaVp28ji8K/AH/vqWQ3Gtzth
         ULY/XUQltKrwV0GP5ZZEF1X8hGOK8Rf1/hHt1rtCSmdEtlplg6exuWqmwigUo0cjmVqo
         q13I4YYvyLHgXkr089bxpznYwesMdQK8kVh+fSm627UBW5UyNn5BQ3l73iwPiNTZCv3g
         FV2g==
X-Forwarded-Encrypted: i=1; AJvYcCVbVlV013j3uIQ9aWtAsyp82Rv/XMVjRLD+CxZXFUcTdugkuR07QhAiLtsKn7NY1Xd3TCG1/na5mt/Y3sWZLvvGf+cGa28QnsuRyZaU
X-Gm-Message-State: AOJu0YyInd028mqO1qy0ekdK2C7Z1DAVroduE27+yA9rNR2LhDgpn7yC
	nSLYXzWU7d7uA0f1tsM9dlVGVnrCBcI3yNja+8xi5ck20JTSF1PwYWx1mIx5opFnvccXyxjoVxX
	r3paZetI/O9CcgBB5XkOvd1TY3q1IDUjAR6kw0/gOMhZf0OhnRgSXdtw=
X-Google-Smtp-Source: AGHT+IGNe82YxvJ2ohDsPDZDFeLM7AS3nrLOqV1J8Ne04s93LixBM022c0i1KGzF3kzg2M1r1qRmGZChCEXe3+8U39zgn4g0ozNl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba8:b0:363:9d58:8052 with SMTP id
 n8-20020a056e021ba800b003639d588052mr176077ili.2.1707913562636; Wed, 14 Feb
 2024 04:26:02 -0800 (PST)
Date: Wed, 14 Feb 2024 04:26:02 -0800
In-Reply-To: <20240214112230.185-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003557320611569d45@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in ida_free (2)
From: syzbot <syzbot+dfab1425afcdae5ac970@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dfab1425afcdae5ac970@syzkaller.appspotmail.com

Tested on:

commit:         7e90b5c2 Merge tag 'trace-tools-v6.8-rc4' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=175a2c52180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df82262440d95bc4
dashboard link: https://syzkaller.appspot.com/bug?extid=dfab1425afcdae5ac970
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d404a4180000

Note: testing is done by a robot and is best-effort only.


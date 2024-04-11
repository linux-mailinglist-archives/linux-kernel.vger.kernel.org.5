Return-Path: <linux-kernel+bounces-141457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBDF8A1E82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD6F1C25054
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B621139CEE;
	Thu, 11 Apr 2024 18:11:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFA139CE4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859067; cv=none; b=sI8ouIy/PDRqmrJXoEwlvfaMUS00I6bznsTSF9aXCQSkTAn72FnIYt/HQ/1tEOo9csB1PUF5PpYoeE79pxTE8cu/hV5S+EuDVD2kCC+ebigwi08PdcJmvvwddJlZ+8VQ+q1cB1eTRkKvy8FJwfnEuI73QNH9Llz74rTCNP5I1Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859067; c=relaxed/simple;
	bh=N2eWeNdUOUyxvg3NLHDeFLVPotmK/ehqXRZFmDWrBsg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MiUECvZFBQU0AB5EN2QIMZRpsJRGMwRznyPBABDBkobCPinNfD8lW361SMxbqVhbLcvzWKFC/A6Kd8rOy8nsFhaTeG55BDiVWbyG/vgvQ+lAfuE8veHemhw1dXNavpELjQXy4ONB9ECo5D0HCYx2JZ8sy45UVUViufF0Ry5rbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d663e01e70so8118839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859065; x=1713463865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lyoSxH82aYSO25/sFNZ9XGUXietc0ibQgDv4W1nQwE=;
        b=M9YVxw89A1W/PWpyju+33WRIwNfXaq5AZZuSgm+VutGKF7bOblg3ZohNjF7O+2TlT4
         kKIAznBCIoeytzygmI+wiiNQ8gZFYxI4mFax1JDqY64vASXZn/o4JWEftNwwX61tzUlc
         Wu13wA9eGRH1/N98lh7c9M05uXVHS7fBJTaMdp+MV1h4R6wk4+wxekkTM3Ol06aYa96h
         ZKnzZ8J560WBeRnwvVTnQyP+GCIIuVrwBYfmQ5gdEYgg/O986Ng1YSaNH8qMeiNdTexg
         Th4lnKYRUM4odDkFc5K3PdaZLQ5P4DzCgZxSyK40E7n3lGGvboooV15zxrvGeR3X2dBe
         uAuw==
X-Forwarded-Encrypted: i=1; AJvYcCUVYqz6ZVwP9Ut0HMnlFf9PxizlNi6AxKeZiEhiQISiD+XjL5wGw97M0NB/9jQgabecopihVF7ZCjOtLDqZS75S+dQ6JGieIIxuNqKo
X-Gm-Message-State: AOJu0Yx3VKy79bGgFDu2/PyWJQIhNEAdPzi6u2X++9YtMz0mfkNOSiDl
	rl3ETIiADi0xMzQ+HXj4Ah7A3X5RI9j8D841Y6uKoH1Q5fOJ5foslGMRQoLDeYMLHBW95TEu+4Z
	bu5Pl+KlzL9tWKJeSjgGA5C8mpH6niRy3fIYn2uAabzSC92vEM02plhs=
X-Google-Smtp-Source: AGHT+IE/A0Gk5bdrQeAMztQulHfidtQC3ACkh4VqpAbHt6I9LSY4ilqyJllDWcpnZ4cgTBjSugGrXecn7HSByQ32khJ8m6PXYr7g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a2:b0:47e:c0f8:75b3 with SMTP id
 t34-20020a05663834a200b0047ec0f875b3mr3031jal.2.1712859065071; Thu, 11 Apr
 2024 11:11:05 -0700 (PDT)
Date: Thu, 11 Apr 2024 11:11:05 -0700
In-Reply-To: <20240410225258.631-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fcdbb0615d6148a@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in unix_notinflight
From: syzbot <syzbot+38b3aa8cd529958bd27a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/unix/garbage.c:330:21: error: passing 'struct sk_buff_head' to parameter of incompatible type 'struct sk_buff_head *'; take the address with &


Tested on:

commit:         443574b0 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=38b3aa8cd529958bd27a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164eb66d180000



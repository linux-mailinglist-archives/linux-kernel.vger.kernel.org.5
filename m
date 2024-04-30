Return-Path: <linux-kernel+bounces-163571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6A18B6D41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B27287AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833191272DC;
	Tue, 30 Apr 2024 08:47:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9B3D0D0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466826; cv=none; b=Mquus5ErFjnIj8GG2nyOqddkTIqgb/pKuqXjZTl7fGXBCKKHwT05b/G2l5QVf7mdMSN34+nWskVlVETjYN/qbX9nJ7CRDAIT0XQcxR6FmuHCW6sEh7+BOHaBjCfQIhCscSAdIMKKefP87VhBNqZ21p8ADagSnBPl8OPbDV1k6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466826; c=relaxed/simple;
	bh=EjrUr9DLDTNFv/gx0gf9OZeVyf4rO0R647qOEAj2pvc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bYXcZdYjqN+Ys8k5BhZq6ploK6xK9+LzKT1z6pswJOIfuWb9I/fzjTRRiXT7D5ctPd1AMtY0EPIpjvscPM3pioPCWIh2aGnO5QuV87LT9YFg29bjiShrcRugYOx5AV9gMSnZ9EEiv9qi1qxXPGaOvVZ8xXH04w1FCg9igAghXYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ded69927d4so122884939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466824; x=1715071624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M14zWY9OzCzHtM5kQjhNsP+LLpg0redhymucCdZm+3Y=;
        b=xRTQxMyuIv+slOAsepCj+jytugIK2IG5LgEzbjsQapWEtXjVZeaLWD4RnUCmfH4Na1
         hcloGYgZ2wiNAIdMybbAGhnZyefSgv/QQnW85Lh0q3pUihEk5K8ohfyivNtxakfv/5MD
         DIRHxA2ukBQnuRSJ32YpkGmcTPF2VsJyr+icmDF2CP13CkGCWNKRtX/Mq/hiZczG+jeU
         OX+FRWHft5KM+3MU5HFuD2cH6q+bOOz8xeerEt4IEricNPr+MzMoP2qode82Thx8oW2E
         ydS3tCiCuiLVJeQuF4115DY4MslcgZ5hINBzUSdeNPdeowROmhXTk0GLqZ+mZfY5Tn2p
         Ef9Q==
X-Gm-Message-State: AOJu0YwAIk6e+hzN9QeVCXLteekH9+lazeXv70xVGpBPji9/gF1nRMHv
	orw8+TLK+N93OLotaHLdoleyRoKPkV2sRbM5Bf8g/aL935o9KA6SBmaAmqP/9uCeR5FxEWJa/Fh
	HXIrBzueGmyxD/mXmf8VfL+535awQZAMzZxkhpDx1pWZhVIqGWajdwKE=
X-Google-Smtp-Source: AGHT+IGuOzLMJjTfAQ21g52xERYrG2pDBi1g8SphX1qyWzdngXdL2F7EC12J+MFHhYL4fYac2SmhC6m12m4VDKTjgV++wynRwMck
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0b:b0:7da:6916:b435 with SMTP id
 ik11-20020a0566026c0b00b007da6916b435mr251422iob.0.1714466824137; Tue, 30 Apr
 2024 01:47:04 -0700 (PDT)
Date: Tue, 30 Apr 2024 01:47:04 -0700
In-Reply-To: <CABtBSaYXM0jR-HovWtxiX+KWhmL7M0aDwo6w488igKgkrCOyJg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000848a206174c6a67@google.com>
Subject: Re: [syzbot] [ext4?] KMSAN: uninit-value in ext4_inlinedir_to_tree
From: syzbot <syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, shenxiaxi26@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         98369dcc Merge tag 'wq-for-6.9-rc6-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fc9e40980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=eaba5abe296837a640c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1771da0f180000



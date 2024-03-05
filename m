Return-Path: <linux-kernel+bounces-91614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EECB87143E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC074284766
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E673CF7C;
	Tue,  5 Mar 2024 03:28:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCC3CF59
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609284; cv=none; b=AFalGRTGyfuhfy5qk6iS5uJacIWLj6NfftzuV6nKTE8b1/FP4Nu44e1mvRZ42eq9xHGYILYWddk5AYadvMx+DIsOSrkAczinKza5xCFdHRVWjaATnxDuyrziB+0PwdekrB6Hs7v9h5SufM8SHE+ojVkmTyhsmE0G+CCtSTT5aNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609284; c=relaxed/simple;
	bh=tet/bS0EsevuzlkPvDlUh75AZphggbmCYcKGWkej580=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DyDc4tN++WMCdFji4SE/nAMkkrVLP/5PsLJVO1e1U6dIhjjhjUBN9ETj724Fm4X6zlyk7r6g2PivoNQQNSGUa5MPDeMmbZlw89+2RTcXVJmZaME1fYitjkcE3RdLyX1qwx3RH+ZdwTH3QRnRsNnVee7Vv/ddjX/OXbUs9ksWjWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8364e4a31so265847239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 19:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709609282; x=1710214082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSFHSo9Co9P7W5fZK5szvuZ2AD6NbOPhoGxNOkUeAew=;
        b=gDVCeo4tC8Et1FboX7frnWdD9kBNNQMbHuN8RnaHQx0ASt8lM1z4CSRhlYEcG+/KPX
         UrZiLC/+Fa2+IOjHBcE9Y4bPNUA+2uDs95OPg8HFKOVezOLJo8nXFoqUeaHb3l+34hlO
         QoiG/hmVav6nXSSG/MiRvPml/F33ic+VYWAGBGwlj+tQf/8Pkvxu0Gc2o5XSa/GH7Euw
         KkNjU4mpM5/xzLnbcsKWO9DGkikmfg8qGPQvFUQ8MceO+H5u+EydPgD7PVJGc9gxIn0e
         WTbrGgcImkNT050ja5PKekXpAes6/1REXWFVYT/Z0f9ppQqSgsEF9/LLcaJQUe2j81yW
         bX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO4IXQc5E8gKoXZasjsyqMtlvqtDJqHqo4wjN+gZRwioXj/o1BWbYP4LL9byaktWN3ZurnSfORKAdd9zYHNaZM0Xqx6RLMG+z7a/wi
X-Gm-Message-State: AOJu0YxIZvk8JwCJQfhEutfarnrqJfj3bYW8G3K1Umyrg96/GsBHqaYc
	QYDPMHNR4jCYYrWLatl6GBNY2ohBIwaAp97b3Nn2oa95hFwwUuua3+Lv5TPKFcSC9Wz/SQSzTd7
	uJ7Gvhe3PbyY5JExp+OHybsVp907GG36l1jgbcmHSxVrwCAxBq5sMjHg=
X-Google-Smtp-Source: AGHT+IFMGkSMv/9LccFdZ0cI7+p4p4ow3EycQRRvLmH59EMd4xya29i4GNQ6GJZlJvPXdGgieJFiosxwL3RY97Q42wPuR08S/OKw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:6f0b:0:b0:365:fe09:6450 with SMTP id
 k11-20020a926f0b000000b00365fe096450mr8729ilc.4.1709609282572; Mon, 04 Mar
 2024 19:28:02 -0800 (PST)
Date: Mon, 04 Mar 2024 19:28:02 -0800
In-Reply-To: <tencent_2749AC6EC9EEFD0CA1A7D706C792C0467906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe1ece0612e16df3@google.com>
Subject: Re: [syzbot] [fs?] KASAN: null-ptr-deref Write in do_pagemap_cmd
From: syzbot <syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com

Tested on:

commit:         90d35da6 Linux 6.8-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1279a07a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7212ea23efeb053
dashboard link: https://syzkaller.appspot.com/bug?extid=02e64be5307d72e9c309
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1111146c180000

Note: testing is done by a robot and is best-effort only.


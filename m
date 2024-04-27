Return-Path: <linux-kernel+bounces-160961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C65848B4528
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4965B220AF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F61241C84;
	Sat, 27 Apr 2024 08:45:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938BD8BFC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714207506; cv=none; b=TjKnwKN3UBsf03CpBXS0JfC50s2cABr8MVhKYUhqbf2Uc0QCWpP27Ky9BgBM1y0JYqXv+1PtNkEvwEANU/wW27IkK7VGh1yR4fNYRiwdiPda0IQmIa2nuSZUM3aCiuNdgxTzB5DfxjClt7hwr/dpOw2y9FuTNdaRpOu1k4hliqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714207506; c=relaxed/simple;
	bh=DM9jX6G7gd4KPBusHIWo7AiJ+eVeRcVXrQUk1Khfb20=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Rcd8KVNdzhMVTMIAv08VrCo7iLE09bW2MQI7IZphGHuSQ9nDjR27UFSoP+naw07lc1xBo8enOCY2rrJeTUM3R4Ai08gmsaxM+4DYuCEpluN7lozpUqirkN00EJwIevTngV2W1/He9kAeEMENct+HVqeBQos9O2iGWuIYji4cRWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36c1127c5deso30692285ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714207503; x=1714812303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVEXpsLW2+IZw0Si3tq/O6jflvI7ZAA2BBSupAQv0ls=;
        b=lcjum3CpNmbbu4ktjV+0xr1kAbJvpDNsQk5nEZOl9ybrzzyisjsk/lWxZqcAYWyWk/
         SFaTl1rGcGcJWvPn8JEH+MgjWdzboshBxsiBBEf/Ui6T/J1Yc+5KtQwuclnIT7MkXfmf
         krRS4KMsR4nZ/fJI88YUVaqJOhtyQwYFCY8GrwhGl4cO/O0pOltsDIyjIuIAisYqjEkg
         AlNTDSHI8SiJ9V1aGTs4OmbSEt6tcWxJq4J1mNQKAua9JIAxTy8xfpcTOC4lrKLK7/P6
         uu3wGpJJWSP/nstCvLPvbvxBxAChHBUMvCCnq25QD43ye5dL/E3cqrocV6eob8gVEdJe
         TnWg==
X-Forwarded-Encrypted: i=1; AJvYcCWj4aXrfYXkkiBSkeqgw844GXhji3F8lYml4PhHTRuTTlzOpvyXXqi7YJ3wkI04nZTOlsiOUaIoLS9bBNZq2FxQG+QoS5CdS3xAyCfl
X-Gm-Message-State: AOJu0YzMnkqLSFK5963C4aY64W0pW6Vu13+l8A30wV1ml6DVmGgVyGl6
	oxQ//3Qg6CC0HlCf6nQjPOKAHYN7uDjxQ+DiTIrmaz0IEK/OtzlsW/eXSMFj2WE4X/xvLytvZK+
	mbCGF+7qIK4cKCCgDVlmtCN/OcBPHceh/HLevFy9BBBYVJzu+zgkZJ6U=
X-Google-Smtp-Source: AGHT+IG9wvyJJlVzTozPpPWigGgSs/dKpCCT1lj9or4J1Dyvuq3M5mlz4DUk4K6HROsiojL6x4DHbQNVlSiWQZQDgV2NmZIDMke6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4f:b0:36b:1b8b:75f4 with SMTP id
 u15-20020a056e021a4f00b0036b1b8b75f4mr63094ilv.2.1714207503710; Sat, 27 Apr
 2024 01:45:03 -0700 (PDT)
Date: Sat, 27 Apr 2024 01:45:03 -0700
In-Reply-To: <20240427081536.3770-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000548fd70617100951@google.com>
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
From: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com

Tested on:

commit:         b2ff42c6 Merge tag 'for-netdev' of https://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=141a3d30980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118d1937180000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-112274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C148877B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385991F22150
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E94DF9FE;
	Sat, 23 Mar 2024 09:08:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1DDDA7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711184884; cv=none; b=otM6GNw2UCtL6pocv0bV1Ve16qmaj/iZH1TAX9s7a1mcCFAGLbbzeNykj/KqmXH079BicNnC5eR1nt2jX6DCHLRo7NMgjlR/4FvP8QjmF/bKew6GpMkKEx1FApcxRzE3darSQR8x9nNUbE7vGgtCtKx0MvlsWkHjtONJmSlhvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711184884; c=relaxed/simple;
	bh=Br8MeOs5a9300AMrrA+/hdwrZlfjyAUoX8I1ayrYhkA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WKqW2JGKEYIMJED6LiGZg1VoirgcrzTZhV3W6El5/eSd+aFx9HM2wM9YLyHKe/QKPA/je1CGr5G+3iWRo6x8LQgBbHwf5okZtTQRGRwEuNXjyBsB6Rwl4RwGRIEDW99Lx012oE9Y8hGMI/Xb8TLyVcwIW0pdcVoF2bsQEe3yTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c75dee76c0so199284539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711184882; x=1711789682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FD8ZdqEGW7gBem8b+7d768dbXKE+nM9vkOJ3M5FAUwU=;
        b=qzWzr5ONIwZsEpj3Y88iKF5Ubd1KYkn0/JHaP3nCuDXxTH1buv9hr8kA0baGBBvPjB
         oNunLl+22mJ2luQ5xhi+6jxNUvMiU5p8+xqOi126BdkvvySPhrkySBO+7+8JLJk684JN
         jjv++InsnB++JEPmTNpAizGXwuSLJDynRqhc4Db/FLBnDFvBVP+RILBGwfox84HJ2zDV
         l38XOjgw7FM8vRqE9+zrvRKvE/G69aaE8X/3l3MTJ69ocqAORKkuPBi6S79ojLl6scpJ
         kGD4D/WPP/yUI3suVcKVOGf5zxwYqjglAlJTNqTFt9Zgwb5rsOTDg6nPj2NexWcZ0ok7
         qusA==
X-Forwarded-Encrypted: i=1; AJvYcCVRS0joKJFUISY0qZuTdYtRJFGfkvemXibC5Q2YpZgRF/zYnv0hbpTyNhBVnFpRFZl7NMyq5QDzvPVeJA/oI+zNPHTml2tzIiBCJg0y
X-Gm-Message-State: AOJu0Yw7Re7LAzf2ve7FNasZnlvk4cEzJoIjVD3DTS15gsKgkygb7qNa
	MTO+7jjWEHD9WSt9SiGIOrJBhn0mf9tOWnn2c+d45uglUDXbizGbW2GSjeduXkJD8exZmoRk+RK
	SMcWn7eiTOeOjbnsJpsTtUn1NW1RTE+uvOUtGdrVAeFFwopqsGKWlidE=
X-Google-Smtp-Source: AGHT+IHhobMfGekA0dHopSvQqHn1xK4fKkor2gWJwV0ixhmNbo5GUp1wWobAbT+FXM+hOkkbc6UJoMm+YYB04TsUnCq3OAB3gFnf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d85:b0:7cc:6b9a:8f77 with SMTP id
 k5-20020a0566022d8500b007cc6b9a8f77mr119543iow.1.1711184882386; Sat, 23 Mar
 2024 02:08:02 -0700 (PDT)
Date: Sat, 23 Mar 2024 02:08:02 -0700
In-Reply-To: <tencent_D8BA24BB3B33559EDD1B644B2D1B16259808@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f5b1206145047af@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
From: syzbot <syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com

Tested on:

commit:         122fdbd2 bpf: verifier: reject addr_space_cast insn wi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13dbb1be180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=33f4297b5f927648741a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122ebbb9180000

Note: testing is done by a robot and is best-effort only.


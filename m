Return-Path: <linux-kernel+bounces-109370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C86F0881827
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EDD1C22BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62118565E;
	Wed, 20 Mar 2024 19:53:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1854969DE9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964385; cv=none; b=Gjng8pXZ5W8WA0G9BbzjTagSvAPUqnm8aMneMj50hoVuqJzB7QCdZGXFwT2NoLaSnhMwOfoouloz1fE3RUqilItaXz3bZMUCmom1MdDf3CZsGkBZ8HqMzsUEvcoU8cxxTxQKct69ubMVnzcNwoJhob0rYtF3zav5FRwaez6++nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964385; c=relaxed/simple;
	bh=Wp4zg/z9iTobavEVC5sgi9cc36Lp3sCE1Yl06MCm+z0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ieUbZHUpBKm5E4CndX3hVVZR3ex1RI3qtcELema0kQYphqCDIpvhP8FLUAN26ezaLQVElxtNnJK4Tds0MXPyoKqIzrs5bmx03+quX3BYkqU0yIHwhg1e0FjYvTPURYWS9x0ZIUA9NjEpB3SacwhiTSlbHZjH7iGFpEY5uBpodno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso22009339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710964383; x=1711569183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/aYiKvwU+iPzn4sRAx1inEmDmRuRqUqLf8asrwXPZo=;
        b=m6dS3Y6cA+ybrrP7fPMd+1vp+xG54ksY9qM9Mw1CmgP9iij5Apq8WO1XhlkdLfSn1Q
         d9h6M8dGXt2xeHEZNXSJt5qQ2HzkqAY3J7lvBghlblmpCGv/TlzXNxZE0h64F947Auo7
         Uuc8sQyQ3Ky6biurSLmRMHomG8n7SYpiVJ0Kp27C4/dN2HcbOTvLn0GyjW7C+9R8HNtv
         d6TicVHf5OW4Tn2i063qodDCsUxCNymiNfHcY31N3NcAx0+tJSAvqPJZ+GSQ5VjaSh8J
         V4GFMMrlZMAP1TTzJoCWb+lXjuDGUMN0wUhKpYT9k5Q9LxGvRmshl5ZbryArVPIgJcmt
         3DFg==
X-Forwarded-Encrypted: i=1; AJvYcCVzAMBrqSYglO9x6r1ZGoxBoTQtQAqGvKtu7saU/RRwV5UDoGIIWjkI9G45FFpvwzVLStCnwDa2saQHSPFDfEv/XEol5BoTWRExNAFH
X-Gm-Message-State: AOJu0Yykm+CTsn4Zbp/XbEmbnG4u0a1BL7iqaK7l+QcqFaHYRB87ZYey
	yWZtBJsE5g1Ro/VQV27bNFLuuT5wNkwoeViZ+A9kNdCmm/bH07PBSwR0hdbw+SF0LV13tzqXhFT
	0U40Xrq8h0S0zh60E/SPYD8uU6p7uvOnJjVgPFb3TeVIN8WVrzp/tBRk=
X-Google-Smtp-Source: AGHT+IE921cxxN5rrCjAvrB9Z6SL7jabK5zBU26ga6lFT9PV46cihwz8kV994JBX3g+91wUkcn3csgMhCAEb5TW6ZRb5mQjZL41v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a8:b0:476:edba:83a1 with SMTP id
 w40-20020a05663837a800b00476edba83a1mr1060490jal.1.1710964383399; Wed, 20 Mar
 2024 12:53:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 12:53:03 -0700
In-Reply-To: <tencent_7DD17367A377E97CA3B5A443F776776A8605@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bdf4906141cf049@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
From: syzbot <syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

kernel/bpf/verifier.c:10263:13: error: member reference type 'struct bpf_call_arg_meta' is not a pointer; did you mean to use '.'?
kernel/bpf/verifier.c:10263:28: error: member reference type 'struct bpf_call_arg_meta' is not a pointer; did you mean to use '.'?
kernel/bpf/verifier.c:10263:53: error: member reference type 'struct bpf_call_arg_meta' is not a pointer; did you mean to use '.'?


Tested on:

commit:         114b5b3b bpf, arm64: fix bug in BPF_LDX_MEMSX
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=33f4297b5f927648741a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11495c6e180000



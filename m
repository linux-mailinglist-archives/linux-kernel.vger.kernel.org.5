Return-Path: <linux-kernel+bounces-163484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B38B6BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E7F1C21E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657F3B185;
	Tue, 30 Apr 2024 07:35:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309B211C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462509; cv=none; b=EZQZYsN9N/66C4UmRsas8lzKUip5Umu2IWm8zPP/ZiQmtjtYNY52gNjqen58mQ8LNNMwWKS7RqOx4eXYBEWqFHK8QtZ81chI8v1Pzq6IoluJafo+UfNLwkjLLdYmsohUd/6XIhb0hfXWYq4BiZSybOF3t5/XCF1qjrB98rwHXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462509; c=relaxed/simple;
	bh=9UPeIh7mtYBQzrxTBiA3FDDJwCgiBGosV6I2nCmr1GA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sV2NzUAdENMfvsu2cwr5VSBLNM34aiKbcXc//cWC26n2CDDQhukFzW0dH7T+WJ0VSN0KR+6xBxEM/ABk2htJKw4lXvSiM93GZXxb6CEQevjkkn9q7RcszD0Ir5Uhf5Yf7E/VbBNr0INP26YrbsQLZtmKX9v7fcj1udH2I6Zwk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da3d17a35cso559280039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714462507; x=1715067307;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ9K/yhR7kV7qTCkX9qsmoF4Z0K/0agFCXAnN8s+pRI=;
        b=CghG60DwLliMKBrK2zDMGUbFfJkJqPQaqO+Xxrgkk8AL8tWBcysIfTLUMTfHnAsPCS
         1xZke2HS3u2yguo1s1x78V1zpOikM7KS5qGw+2rSwjZYholBw19lp81FgKmM1EtAAxjG
         uiqo4bUN/Jct+sOL0ukNoXLiY6cI/y5WHb0PyDyfrF9JbSDB+JuIPQCTMSh0P2545vDk
         lZcreeJoJ+gK23V/Md9vnOrXoh35vQym69UYsyAsJoKa21xlJ3fdCGHLIkNCM6lQtYJ4
         eU5L2uYcHGHM3/5uWodHnII5JLu9YryZD61SUyFB8SzIcMJ9VCHU2/zNy6JgluuYB2SX
         flCA==
X-Forwarded-Encrypted: i=1; AJvYcCUyCNyrfA/xiW3JDaGbyJcj1Yrw8ezN9Ow2dGbU6s3jmlYO575e/Y0Z2E57PDdA2X2XqsKDx+quUyCamZsHvYM38Nkv9/JZyrJ0aV9f
X-Gm-Message-State: AOJu0YzeWVNxDuPUrWcgFFkVvnahlVIpHVP+nrj+ev01WZd4JyEP6EH+
	asm1UWmLH4KDuZZoTKSthc4xZ4mrVdtp2uGKTRkGwgYwbMKmMzg/fuRXD1NrPad59/KgUedOzU+
	/SVj2Yn7H2NayU89p4Tm+Fv+c7ozneyPEpRaz7BzNpZF+0nxF5wvkVNM=
X-Google-Smtp-Source: AGHT+IFh16A3UfNvvKTyJfZ+0v1lmG9Pzb2jtFqVdhwPBKMVD9B44IWqrk6VXExoNjA5XRQd88smD1GzqegvQjM36M/zjcIhjiAS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29d0:b0:7da:18b8:397c with SMTP id
 z16-20020a05660229d000b007da18b8397cmr295497ioq.0.1714462507190; Tue, 30 Apr
 2024 00:35:07 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:35:07 -0700
In-Reply-To: <tencent_7437344BBA742F76EB67C63D0F362897D209@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8e00706174b683c@google.com>
Subject: Re: [syzbot] [ext4?] KMSAN: uninit-value in ext4_inlinedir_to_tree
From: syzbot <syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com

Tested on:

commit:         98369dcc Merge tag 'wq-for-6.9-rc6-fixes' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12ca42f8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=eaba5abe296837a640c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=100abe7f180000

Note: testing is done by a robot and is best-effort only.


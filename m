Return-Path: <linux-kernel+bounces-107374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9F287FBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC3C283280
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430E7D41F;
	Tue, 19 Mar 2024 10:17:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D47C6CC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843425; cv=none; b=GvbnvR1x6qj1zPWz3XpZkhJMq3qjEXqwCE6WPAc3A/yltBD/6UJYXkzww6VVmlVpz5kGf85+8W4e572yBkRk3g+xsx4DJXZztlh5zL9stKr2kqXOzzmkW1vVzLE6IEDYOaTNBUW5EjT3MrRoJ7AJE0mxSouPKMSBiUSXAjnnz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843425; c=relaxed/simple;
	bh=1S4U8RLV6I+uVBYZzttTLY7EfRADJOCDRuWzbmCb9/A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OjW6ih6/Vu2tamry5hzA5ltEZsZ/dc4qKTPXNz6hiPDbAz/Gby9td1StI1gcIT1qLZ/H9TPleSe+2Hkwk2Rii+JCzUxc6/HDnXUe/cHh+QGxrXcgQJesUAig/1PSxLwrC+IdpC9J49PVIMLylX4Ntc+CCol+/vIjXE2w7ZE0/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc70b85c48so140325739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843423; x=1711448223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wadArb7ioUuvUbDXFt8TyPvnnpuh5PkttRsGrkiB34M=;
        b=nnR+Pq38N8BJqafRuyJ1CDEApZ3bChkFC7TCA4rV4H2mC2wW9lwFrEDHRRcF5Y17te
         oav9x77yxJz/SvMcotmmaSu7oc5hD63dHNK1+mft38zDFiJpcAK8SGMmLbPmJCblEBXg
         MK6eihewwmkb1V0B6Y2f0AvzL2WNYeMJcOC2aj3PgrXC9rJdRvhN2wP3fRMBNI7daAKM
         2QGf+vbLWrfh2TbufTeAHoF69RHeWMrkm+N0daF885l6FWLs9xEKFjxmaYzO7U08+AFp
         rRusmjFrDSr9OZznVhiEhMjA2IWiN7sYfYwSrG9S2DmnHk7voXpnxZ+iMCL8NhZsmLp3
         JefQ==
X-Forwarded-Encrypted: i=1; AJvYcCUURPpY9DM7FBOV0JuUdfoARk53p1xNTs4n8OMIasjbIJHgCeAIr11VLw4XVKUgitLcu9ljctU6USFxfbiLbdqHNovInTNcUC4FmhBB
X-Gm-Message-State: AOJu0Yy6iirew4IicO+RFA4cKImd1NpRnDBNs+zC1/QjUxziuQ81ib9+
	HwSNFSy/9U/m8wS86TlVcQDJxvm4BPKswdd2o/BSVJ7F/KXimqv/pAnNyxh9Cnnjthl8G7q4/69
	jf31WF3KyonjnrR1TuXwB6DvkGFAWxXrfSZ6uHt7y4iCHtRJ6P+IJIa0=
X-Google-Smtp-Source: AGHT+IGRQsfBjCGsWM3fwH85+e65cL9FrhgEtaxanxYQibCmBtEPlngDGB2JJhqAW+e6QGmHjUG2sYpRDZYn208fTyvoUyb9Y/pu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8923:b0:476:d06e:8f1c with SMTP id
 jc35-20020a056638892300b00476d06e8f1cmr99181jab.2.1710843422961; Tue, 19 Mar
 2024 03:17:02 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:17:02 -0700
In-Reply-To: <4b007533-8d7b-40e7-9f06-52304b46cb8b@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e031e061400c64d@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (3)
From: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com

Tested on:

commit:         b3603fcb Merge tag 'dlm-6.9' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14395479180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0f689e0798c5101
dashboard link: https://syzkaller.appspot.com/bug?extid=88ad8b0517a9d3bb9dc8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


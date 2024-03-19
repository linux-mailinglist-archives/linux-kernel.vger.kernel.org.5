Return-Path: <linux-kernel+bounces-107391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4987FBDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EEE8B21E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4F045940;
	Tue, 19 Mar 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RBrvZGym"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDC64CEF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844475; cv=none; b=qiD2fh03pVywzHYrEc7hB9oVsAbzzWj8fi1wniMd39qp3W5rSwghok5ih2smoaSSSS+M7vrYekYARZGRZTZRXxhTdSvD4NYvQR5NwrOt3V1rf+oIoaqtZtV+mtLLH7REeaP+apn06bljYDF8hig2aeYSsLeRJM3yuWmw4XfWTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844475; c=relaxed/simple;
	bh=WQotiF9PO4tG1fzncMhr/j24pOwu+BHAbB5N5GOTq2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ApUVYRXwu+dKYCFLhdxiRm31bDS4hPygVlDES7wib8YtmqbvJxvQrVKXgvRQUxSnwM5z+aAsbfxP3PBUwy9GIHtrWDE4FTYqrCbf58a3hWT/h+IezmVUYXE/8/PFy2hOZsyEiYFbE4QZHzlQCIev9t1BEX2ka8ixQjHyaY7SQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RBrvZGym; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710844465; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Bdadq9GunDiEhKHRiECvDiVFYuvED6FoFIbywdNUegA=;
	b=RBrvZGymJjd31/UFgyL0HeCTvuGTdUeuWAhswm8yl1jV4EDCzJEJ8v2WspKxf5FfrwOAdUxO9rVpzsolFqpb8Y5MrLyDCXAP1KVCbd3QRRSZoT2Zp84NpKf4ItYS5COKwhXUaZVHInG2amWg2kwmnwdnTkl7MImi9a4KlHmGhp0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2svsTi_1710844463;
Received: from 30.97.48.212(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2svsTi_1710844463)
          by smtp.aliyun-inc.com;
          Tue, 19 Mar 2024 18:34:24 +0800
Message-ID: <fad8f767-7870-486c-b8af-1f260b6bdb65@linux.alibaba.com>
Date: Tue, 19 Mar 2024 18:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress
 (3)
To: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <0000000000007e031e061400c64d@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0000000000007e031e061400c64d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz dup KMSAN: uninit-value in z_erofs_lz4_decompress (2)

On 2024/3/19 18:17, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         b3603fcb Merge tag 'dlm-6.9' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14395479180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0f689e0798c5101
> dashboard link: https://syzkaller.appspot.com/bug?extid=88ad8b0517a9d3bb9dc8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.


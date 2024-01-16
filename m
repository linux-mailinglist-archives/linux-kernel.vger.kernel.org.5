Return-Path: <linux-kernel+bounces-28136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFF282FAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39371F27B63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA82159569;
	Tue, 16 Jan 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IimP4Pc1"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD3159578
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435234; cv=none; b=OIHvBLZ4jyhscoYEtaI+jg6Xr6VNNkV1qxNpDkOHE+0rBkEMlmNPWHxlN0VZYE3RNFr1lEm8u+fkOotryT4u1iy161ElrvU35XsWYEHqItLNB2lRQCjDJVu9ieniN8vYA5aSLGnUvpjcmgdA6mm5geWGfPSWiCTULK0OUTbBTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435234; c=relaxed/simple;
	bh=0LpxdPDwIhXx9whWgjBylXCRhboUwUu+jIA/F2NRoWc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=fu/Drv9sQlAzwNTeG2w6lsF6i1RBD3dI1mH8lxIuinuUznMAJQqtEeCwp4pwlMxYC2PxkoQh0ymCXehEj0hQy8RtdUidpo6C7avLdYiuHECUb+UDr6aNgynXs/SGv2m+WkhvluiRwxbkwwYXNn8QQ/++Ge0I7dtlrwYfJmzMp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IimP4Pc1; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-361319083daso1459145ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705435230; x=1706040030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Bzi0VNEZLd3xkt69kN62PfQd5yOGDUdslJTECLXFRg=;
        b=IimP4Pc1UlT1Dxvn4rthZMYDf19IAeO/EBFr2fLbWHMWHQjjlbujtucKNyTHweQTI8
         n7sWGwfxGb3TB7t1++rN5fAN5rRwxq07taKD/AwzUSiJPkbjrTVwg60yhn0ZhuRuaa8B
         b3KbQHJxndhscKKaJmye9Kve//SiKKfNlfFJxpWCbifNWgQfVnmO00ZBmFFL19bDXmkz
         7VMeRnrPGgsNj3AhzWQzWSdQcq0ww4/76/fZcrUGwupAmfQQ1ykoCjwfcGgZSnhlJB9y
         +ItHxEb74pD+c9EBNnpijdHENmIYJdCqY/D3sZIe/qWH+r56qXn5KAKiW65hFQovuL39
         KARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705435230; x=1706040030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Bzi0VNEZLd3xkt69kN62PfQd5yOGDUdslJTECLXFRg=;
        b=rlS7T1KR6z0Aft5n3QaIucbIPefiZPOEt8fI2uu+c2a3jc4uA8RHb30ODP0DJvjA62
         FqTILWYevfYrE9mCeHzt0Eu4uUZJ760u/+1xDKMuefwvUEWdy+11BsYLsczU1yakMCpb
         uiVf6xXMHhjOglH7P4eQlvyArVsZ0ShjenIHNVdBbq2ZA9gxo8RN0YUho2LaB+GcaC7e
         a+FzyH2DySz0aU/wBxawTLFkAe+Q8DEPmMizzKw6zWnQMZZJnZt1bcLfAYejNB50hy0o
         cYaPfHqWTucJEfp/Qk/Xo59urCgyqFA35s/bGSdJ5WZfJgVZyrVJc3HXmzxUC2FVFjUh
         Qq+w==
X-Gm-Message-State: AOJu0YzWJWrQP3jgNVnRzsSn+HP2WwiBrqBDjVuSFV937T0qCsHwtczt
	QX7T+uZ35vx9ZvgLFjVFSToksU4WkTBjCw==
X-Google-Smtp-Source: AGHT+IGD/c0B/2oUpgwDPKxeGeaTpllkQKnSoDSKBOTPLNpwFPFn9e3DteSXI03hU/LqVgKuvSnt4Q==
X-Received: by 2002:a6b:c845:0:b0:7bc:2603:575f with SMTP id y66-20020a6bc845000000b007bc2603575fmr14558885iof.0.1705435230304;
        Tue, 16 Jan 2024 12:00:30 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b8-20020a029a08000000b0046e1efd2e1dsm3079962jal.74.2024.01.16.12.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 12:00:29 -0800 (PST)
Message-ID: <e2e2bfad-c1be-42fc-be83-b0cb894887ca@kernel.dk>
Date: Tue, 16 Jan 2024 13:00:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] BUG: unable to handle kernel NULL pointer
 dereference in __bio_release_pages
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000dbe2f2060f0d2781@google.com>
 <4bd438c0-75b8-4e28-939c-954716df7563@kernel.dk>
 <ZabOF3/P/jQmjudb@casper.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZabOF3/P/jQmjudb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 11:42 AM, Matthew Wilcox wrote:
> On Tue, Jan 16, 2024 at 11:00:52AM -0700, Jens Axboe wrote:
>> On 1/16/24 2:57 AM, syzbot wrote:
>>> pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> pc : _compound_head include/linux/page-flags.h:247 [inline]
>>> pc : bio_first_folio include/linux/bio.h:289 [inline]
>>> pc : __bio_release_pages+0x100/0x73c block/bio.c:1153
>>> lr : bio_release_pages include/linux/bio.h:508 [inline]
>>> lr : blkdev_bio_end_io+0x2a0/0x3f0 block/fops.c:157
>>> sp : ffff800089a375e0
>>> x29: ffff800089a375e0 x28: 1fffe0000162e879 x27: ffff00000b1743c0
>>> x26: ffff00000b1743c8 x25: 000000000000000a x24: 1fffe000015a9e12
>>> x23: ffff00000ad4f094 x22: ffff00000f496600 x21: 1fffe0000162e87a
>>> x20: 0000000000000004 x19: 0000000000000000 x18: ffff00000b174432
>>> x17: ffff00000b174438 x16: ffff00000f948008 x15: 1fffe0000162e886
>>> x14: ffff00000b1743d4 x13: 00000000f1f1f1f1 x12: ffff6000015a9e13
>>> x11: 1fffe000015a9e12 x10: ffff6000015a9e12 x9 : dfff800000000000
>>> x8 : ffff00000b1743d4 x7 : 0000000041b58ab3 x6 : 1ffff00011346ed0
>>> x5 : ffff700011346ed0 x4 : 00000000f1f1f1f1 x3 : 000000000000f1f1
>>> x2 : 0000000000000001 x1 : dfff800000000000 x0 : 0000000000000008
>>> Call trace:
>>>  _compound_head include/linux/page-flags.h:247 [inline]
>>>  bio_first_folio include/linux/bio.h:289 [inline]
>>>  __bio_release_pages+0x100/0x73c block/bio.c:1153
>>>  bio_release_pages include/linux/bio.h:508 [inline]
>>>  blkdev_bio_end_io+0x2a0/0x3f0 block/fops.c:157
>>>  bio_endio+0x4a4/0x618 block/bio.c:1608
>>
>> This looks to be caused by:
>>
>> commit 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55
>> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Date:   Mon Aug 14 15:41:00 2023 +0100
>>
>>     block: Remove special-casing of compound pages
> 
> This looks familiar ... looks like it came up right before Xmas and
> I probably dropped the patch on the floor?
> 
> https://lore.kernel.org/all/ZX07SsSqIQ2TYwEi@casper.infradead.org/

Can you send out a proper patch please?


-- 
Jens Axboe




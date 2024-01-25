Return-Path: <linux-kernel+bounces-38961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C9583C907
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B32C1C25ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969D113B789;
	Thu, 25 Jan 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hI4dSVRs"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E6134757
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201506; cv=none; b=nHZzmiQDnamZ1ET0+kaFCcnqabBWg8Dj0hscpjx4XqL1NRLaJZwGSo7uk55gLRtOhiYXXMDUKioPPJXp6SrimYoxhp2umD6vB6Lekrpn2utcRJJEKMtRMgQG+wVapWFyqvi6YVwUReAWzviqjmb7HTw9OhdT3UTk5Gq61OfBR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201506; c=relaxed/simple;
	bh=PRbPnZWKYw3E0BBu5EbbqHAww0THKcX4aUuGG2NtDt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUTx9upmtye/7oy94dfWJEHD1Ww8DAGRxiaIsHZfm/0lEU4OW0jmgEPGYq7plaX1XN0vvPZNgmsGIaSzDK/B/K58UxWi3lHRzIimv9ceb1qEF/TYctEv7o/14M/s1dHhsz0IT2uWw3MJHVATzKsrjvOdHKxr0HrafA/I75qCYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hI4dSVRs; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bee01886baso86053339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706201504; x=1706806304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzhzH8W8YKdG1UshrLmsWOmbS+mnnML0ID8FiPyQS+8=;
        b=hI4dSVRs66bYIAgbiu/F5KqqWzWKuUFcD/vrENRsiF6wTRclUZAzHfuui7bdwYTCWo
         Qfn9rgZbL40W+qRSFW/qbsU5OLCKMUYmydMtA38ytK/S0Kr76sfwzqcz679nkW5mUq3C
         WdCV6y0NhMK6mTi7q9oh1nLJ7tR1Wl8k3zHggVijXpD0K5jnzVuIK8XrQ2HbsKTn97jM
         3fR6O+YpG73VkP/9ZsdcGYTrOkFqTpjYHvJvqG67hzZQBRBRxHpd6oRV21ROjUKvN/UN
         AtBW6Mfg4RZsjZOOr7/cJrqXQ8A6SeRwS2iG/aS/8T6L46iNUZtgpq2/Nmukyxtg9WAu
         /Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706201504; x=1706806304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzhzH8W8YKdG1UshrLmsWOmbS+mnnML0ID8FiPyQS+8=;
        b=cVEQxPbk9050Iydv5tSe5NqIeGfgdpUrDZiF3GTaKOystr/vAa0BQZRjPRYbpukJW0
         rwvLt5sIU9uJ7EoZwQrDAfzPZrgOnrWQOAdIXXDDQw1Hl3kzV/b/k13aqwDNKmyVxS9N
         JLpl1Dyp8S0b7PZMEeb5dqvvj1ib2lYw32hueTivlMStA8daYjIfo8y04ffibNQpuKGE
         irIiXz0sskb5tCa7tVngCYImRes7QKLse/LbVuA5CfEQGIC3bvMSz7U36Fp3nz7Qw8VJ
         5jsdfH6uvDRXfJwRgIgsIhtk/xjW6HOgu9g3EkM1Iv421pm26QQtN/U0fEh0RFn+H2JL
         Argw==
X-Gm-Message-State: AOJu0YwePfyt3WQIxe0HoFeif2gro/py7o2HA/6qJ7iGt/+IvfJmEpr2
	fwGNHRwgaf28e6sf3mwYbNRSuWQjYtZLDLc3p6MX5cIZ3idQ5hxq9g7MRGqZA2c=
X-Google-Smtp-Source: AGHT+IFYyrX06cAtSMCgkVu4jH5S0PUJ1onbfIiXVVqaFfJSd2PAAPJR6d43ujLUGSWzHqTxQglpEw==
X-Received: by 2002:a05:6e02:1b04:b0:35f:fa79:644 with SMTP id i4-20020a056e021b0400b0035ffa790644mr2670864ilv.3.1706201504039;
        Thu, 25 Jan 2024 08:51:44 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v22-20020a05663812d600b0046ed5f51becsm605331jas.39.2024.01.25.08.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:51:43 -0800 (PST)
Message-ID: <e0a1fcc8-40ce-4c96-bba5-95a9641cb076@kernel.dk>
Date: Thu, 25 Jan 2024 09:51:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [jfs?] INFO: task hung in path_mount (2)
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>,
 hdanton@sina.com, jack@suse.cz, jfs-discussion@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 shaggy@kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000083513f060340d472@google.com>
 <000000000000e5e71a060fc3e747@google.com>
 <20240125-legten-zugleich-21a988d80b45@brauner>
 <11868eb4-0528-4298-b8bc-2621fd1aac83@kernel.dk>
 <20240125-addition-audienz-c955ab3c8435@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240125-addition-audienz-c955ab3c8435@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 9:47 AM, Christian Brauner wrote:
> On Thu, Jan 25, 2024 at 09:11:34AM -0700, Jens Axboe wrote:
>> On Thu, Jan 25, 2024 at 9:08?AM Christian Brauner <brauner@kernel.org> wrote:
>>>
>>> On Thu, Jan 25, 2024 at 03:59:03AM -0800, syzbot wrote:
>>>> syzbot suspects this issue was fixed by commit:
>>>>
>>>> commit 6f861765464f43a71462d52026fbddfc858239a5
>>>> Author: Jan Kara <jack@suse.cz>
>>>> Date:   Wed Nov 1 17:43:10 2023 +0000
>>>>
>>>>     fs: Block writes to mounted block devices
>>>>
>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13175a53e80000
>>>> start commit:   2ccdd1b13c59 Linux 6.5-rc6
>>>> git tree:       upstream
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=fb337a5ea8454f5f1e3f
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba5d53a80000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14265373a80000
>>>>
>>>> If the result looks correct, please mark the issue as fixed by replying with:
>>>
>>> #syz fix: fs: Block writes to mounted block devices
>>
>> Like Dave replied a few days ago, I'm kind of skeptical on all of these
>> bugs being closed by this change. I'm guessing that they are all
>> resolved now because a) the block writes while mounted option was set to
>> Y, and b) the actual bug is just masked by that.
>>
>> Maybe this is fine, but it does seem a bit... sketchy? The bugs aren't
>> really fixed, and what happens if someone doesn't turn on that option?
>> If it's required, perhaps it should not be an option at all? Though
>> that'd seem to be likely to break some funky use cases, whether they are
>> valid or not.
> 
> We have no way of actually testing or verifying this stuff and a lot of
> these have been around for a long time. For example, this report here
> has a C reproducer but following the actual dashboard link that
> reproducer is striked-through which supposedly means that it isn't valid
> or reliable. And no other reproducer ever showed up.
> 
> As far as I can see we should just close reports such as. If this is a
> real bug that is separate from the ability to mount to writed block
> devices then one should hope that syzbot finds another reproducer that
> let's us really analyze the bug?
> 
> A separate issue is that syzbot keeps suggesting as all of these being
> closable because of this. So how serious can we take this and how much
> time can/should we spend given that we got ~20 or more of these mails in
> the last two weeks or so.
> 
> I have no better answers than this tbh. And fwiw, apart from this one I
> haven't closed a single bug based on this.

Oh yeah, it wasn't directed at you specifically, just the overall class
of bugs that get closed due to this in general.

> And yes, ideally the ability to write to mounted block devices should be
> turned off. But we'll have to let it trickle into the individual
> distributions first and make remaining userspace tools that rely on this
> move to alternate apis before we can make any serious effort.

Hopefully it's all fine on the distro front and we can just make it the
default some years from now. May even make sense to backport some of
this to stable and get it in their hands faster?

-- 
Jens Axboe



Return-Path: <linux-kernel+bounces-147003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350EE8A6E19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E059A2811A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249C12FB3E;
	Tue, 16 Apr 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f/jiEdZ+"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778F12C54B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277378; cv=none; b=L0i9YNWCmbLHpb+BNIPK0e15QxNEsAuqNWu2J/dIxQHCZKzh0Mq/LVDX/8ibdNUxBkCSBlbv3SbSJ8500C9XzBKqENwngzZcB7ifkORjGhUe4nT1blK2ClUzyBVoSqLdPo5hziuksAhIBi+IyU+6b2rxXHSXEKL2gp8luyK8CDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277378; c=relaxed/simple;
	bh=KkhLAavCbkxsrMJ/g+XwkIEHN5YZSrFkpEyCXUbE+yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWE2nzZ1ESzx8xxoCmjy68EqHB7Pp1BaODvLkyWSOrxed2oPeIgvqm2PETx1PGa0hKq433DPXn8YGCvdMpmLhDzuicS67Ny6Ky7r6sYoveXgtK8/9L3SWjgUyxv/qRcsekCkHLOgfSCU/EWg6bUVhA87+o8WtYAnLy28gN99cf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f/jiEdZ+; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6b362115eso71775839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713277375; x=1713882175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2fMNvEI24QOeRYU2Q7J/gXsOX3YqVKsrm8shQ/4hw8=;
        b=f/jiEdZ+puxc2vACOmS4yHpNeRWkI3dQKzuHhOJ2Jm4NtOW0nZnQEL1lpRX0w+U7Lw
         Y53F6Xsx+Tfqu+B9B+ooeOqUXGWeDkb7vw4o8hlJNQ9sJjj4izUqJCleldgaN/EN+6rs
         AXeYUqSIb7zRWPMygyCD2UZ2STWah8pJjpmHOODYVqxkQDnSxrtDr77gsYjRFNUdtdFK
         015mqTE0d8V7vc4EL9iXMpwrTAw8HzwH43XyLqolx1nAIv4eu66vIt4swyujee/K7MNr
         EC3rKLEM/mdxK/tZOLTlgAiZFr68CEiVx9uAZvzzmCeMZX/UKUBn2P/95uycq0i+4O7v
         r/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277375; x=1713882175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2fMNvEI24QOeRYU2Q7J/gXsOX3YqVKsrm8shQ/4hw8=;
        b=Nnl7P8qk2mMUJ0GbFP9THDd90xRyf2gheKE7Vu45EmVWjjeWazIjpMiFH0YbTJxTFx
         1fGJeGAS09SemEq+a7rf8WO8A3jRO7yQ8fu84SwdhtERphaTa2r3249LebNL75XJazGi
         +SfBAV9Q8w2mk3QVFk0Edzk/Bhaghvlv/5seynDbMPRCu8vCQn7iqwfYW4BLEtnRz8ay
         jbAGVDj8NC5Bz69/fb4/OhXeoYiZiQXRLOcuvXWq8kZwE/znlCXgzBjwzcp1UVQbrCae
         PSlTc3V/E4sTiKluJj9ycj/hxfLX3YNkhTpnAnTY0nDHUZxnKIEGWFZiHl2poW736VEU
         nFxg==
X-Forwarded-Encrypted: i=1; AJvYcCV2bFxO4oevBU87cOxBEU0HDgptvJbK3Y3zrdxQDQKk4+bHxBMJx6pjCDN0c0QrRCpcUSb1/aM6pSetlmcg8ADRMdNjTWrwMED7+jkT
X-Gm-Message-State: AOJu0YwDqKiHnF8Yqyaq2jSDvKfondutoXE3RudUGgc9LUDeRf8md8UR
	tk3SIWb23ay85ucfYeV7Bfej8ydvB8W5VNilk3bhZ+y8MwT+yqTAWSKHTGL6UyU=
X-Google-Smtp-Source: AGHT+IFHQy//HeRmRxLtJ547eHKcIHb0Q1z3xF2183VnfWuSC2U/dBI0HyNuCFx3DBhEW9NP4bivYA==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr12062089iob.0.1713277375372;
        Tue, 16 Apr 2024 07:22:55 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b9-20020a05660214c900b007d95d6ef5c0sm1671531iow.9.2024.04.16.07.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 07:22:54 -0700 (PDT)
Message-ID: <b74f99e8-5a50-4e93-987f-0bcfc0c27959@kernel.dk>
Date: Tue, 16 Apr 2024 08:22:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: API break, sysfs "capability" file
Content-Language: en-US
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login> <20240409141531.GB21514@lst.de>
 <d7a2b07c-26eb-4d55-8aa7-137168bd0b49@kernel.dk>
 <Zh6IpqnSfGHXMjVa@gardel-login>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zh6IpqnSfGHXMjVa@gardel-login>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/24 8:18 AM, Lennart Poettering wrote:
> On Di, 09.04.24 09:17, Jens Axboe (axboe@kernel.dk) wrote:
> 
>> On 4/9/24 8:15 AM, Christoph Hellwig wrote:
>>> On Tue, Apr 09, 2024 at 10:19:09AM +0200, Lennart Poettering wrote:
>>>> All I am looking for is a very simple test that returns me a boolean:
>>>> is there kernel-level partition scanning enabled on this device or
>>>> not.
>>>
>>> And we can add a trivial sysfs attribute for that.
>>
>> And I think we should. I don't know what was being smoked adding a sysfs
>> interface that exposed internal flag values - and honestly what was
>> being smoked to rely on that, but I think it's fair to say that the
>> majority of the fuckup here is on the kernel side.
> 
> Yeah, it's a shitty interface, the kernel is rich in that. But it was
> excessively well documented, better in fact than almost all other
> kernel interfaces:
> 
> ? https://www.kernel.org/doc/html/v5.16/block/capability.html ?
> 
> If you document something on so much detail in the API docs, how do
> you expect this *not* to be relied on by userspace.

This is _internal_ documentation, not user ABI documentation. The fact
that it's talking about internal flag values should make that clear,
though I can definitely see how that's just badly exposed along with
other things that document things that users/admins could care about.

-- 
Jens Axboe



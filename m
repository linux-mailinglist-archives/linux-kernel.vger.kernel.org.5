Return-Path: <linux-kernel+bounces-51109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0BD848692
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F964284BB8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A05D906;
	Sat,  3 Feb 2024 13:46:02 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D695D72E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706967962; cv=none; b=O0IA7J5p5zdODzzA0IikcoTbdJc0orCNPA7nCGQWx2Cnt0P0/MSSy8NAxjjZO/iZhj+2pZaleoBpjzI2ivYxOo/pvXU36WrdTk90061we6Lwd8u4xIwR8Y2MAQTL8RJxpIsicKbI5aXXDXEouTQG4jFy7/ZtQL+OYJOug3CFFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706967962; c=relaxed/simple;
	bh=W0wBnDoFWYFf/fgEW5y0mUsGhftarMHvphikt96cvcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXY3vonwWZ6hCETvsZWvnqB3xWifxWcuohAaL4S0obFdflL1eI/czHCEvpADTTjNM/WI3LfQeWt5Ey7PVJVEr/Fscux9Q++7xP7qelUvHxjb9XDZTJny6TvzM2E+DHpx0jSz1iuX95twVuoyF+fmd4OHMHEDzHdD3fJsuWd/UmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 413Djv0F005712;
	Sat, 3 Feb 2024 22:45:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 03 Feb 2024 22:45:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 413DjuwW005702
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 3 Feb 2024 22:45:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1eab9734-8e4a-431b-8996-fb30f0c6b173@I-love.SAKURA.ne.jp>
Date: Sat, 3 Feb 2024 22:45:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: n_gsm: restrict tty devices to attach
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
        syzbot <syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Starke, Daniel" <daniel.starke@siemens.com>,
        Lee Jones <lee@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>,
        linux-kernel@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <00000000000039f237060f354ef7@google.com>
 <83414cb6-df16-4b6d-92e3-d54d22ba26cc@I-love.SAKURA.ne.jp>
 <9cd9d3eb-418f-44cc-afcf-7283d51252d6@I-love.SAKURA.ne.jp>
 <82aa07d4-13ac-4b1d-80cd-0970c71752a5@kernel.org>
 <7dc23b9d-5120-4966-b47b-fcabe270d498@I-love.SAKURA.ne.jp>
 <42d17017-1d30-4c54-9c28-9d9ba2494e07@I-love.SAKURA.ne.jp>
 <2024012418-passover-habitual-5a92@gregkh>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2024012418-passover-habitual-5a92@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/24 22:14, Greg Kroah-Hartman wrote:
>> @@ -3630,6 +3631,17 @@ static int gsmld_open(struct tty_struct *tty)
>>  	if (tty->ops->write == NULL)
>>  		return -EINVAL;
>>  
>> +	major = tty->driver->major;
>> +	/* Reject Virtual consoles */
>> +	if (major == 4 && tty->driver->minor_start == 1)
>> +		return -EINVAL;
>> +	/* Reject Unix98 PTY masters/slaves */
>> +	if (major >= 128 && major <= 143)
>> +		return -EINVAL;
>> +	/* Reject BSD PTY masters/slaves */
>> +	if (major >= 2 && major <= 3)
>> +		return -EINVAL;
> 
> That is a lot of hard-coded magic numbers, why aren't these defined
> anywhere?

Well, include/uapi/linux/major.h defines

  #define TTY_MAJOR 4
  #define UNIX98_PTY_MASTER_MAJOR 128
  #define UNIX98_PTY_MAJOR_COUNT 8
  #define UNIX98_PTY_SLAVE_MAJOR (UNIX98_PTY_MASTER_MAJOR+UNIX98_PTY_MAJOR_COUNT)
  #define PTY_MASTER_MAJOR 2
  #define PTY_SLAVE_MAJOR 3

but does not define end of UNIX98_PTY_SLAVE_MAJOR range, and
no file defines start of minor number for virtual consoles.

Does fixing this bug worth updating include/uapi/linux/major.h and adding
include/uapi/linux/minor.h ? Since these numbers won't change, I feel that
a line of comment is sufficient.

> 
> But really, this is only for fuzz testers, why can't they just not ever
> bind this to a console?  Why do we have to have these checks in the
> kernel to prevent userspace from doing dumb things that no real
> userspace will ever do?

Fuzz testing is for testing unexpected arguments. This bug is nothing but
missing validation that should be fixed on the kernel side rather than
trying to tune fuzzers.

> 
> thanks,
> 
> greg k-h



Return-Path: <linux-kernel+bounces-38871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 025D883C79C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352651C2506B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D398129A72;
	Thu, 25 Jan 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WpSZFiJC"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6986143
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199098; cv=none; b=EukUrt0ERMOg3Tg3jLytCirqFo6vsFzmKfkMVu4pvRnhNz5xmkVu5f0pHdqyqb6ZBi+msNlUxPyL7AJjcrQNhDVMdgpeM2DphEPIK+WyomelD12Y5B3ubntjvMCyAV+GadLW0NeC/OH3U6F05t1vNZQwaw34mBTSHEgfEqYf26c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199098; c=relaxed/simple;
	bh=sJvQIDfKJSXmACGVyDxOuvYeKXaNLXeOpOjnvIPcb60=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=foKx5hg53cdCdvxEczt505yXs/WCI8V1dNpDXoetE6BXBX9KIk9zhG4FhPO0iO4t7r/8Ccjd/689Xte+s3kzpJHyQZ/mD/5Q24uBEzw6kJRPzdY+DUb5/HErlX4ZSsPoRMIEe/pwwAmd5+CVMFPJ97Fhvj/wjQdIq/XGbwrk4b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WpSZFiJC; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso86958839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706199096; x=1706803896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oXHpAvGT0l+OrcMVhCzIisM9di93nFyOAmu8umEvyYc=;
        b=WpSZFiJC+gCkaTAxVghL+0TziKvTsW3cXquxSB2MDTRybISiN/VP7Ez5bVYU06ZP9/
         TtFdqwmte6uhom2hQRBG7O+XasO47sVCGNXdKmFJzEaRQpIZmJVQm/B5KZO7mckPynIl
         pS9U7LAvO+P0kFe6dFEJu1UQMEYFqDP1sSCq6kyhBsqJ+dzD9KpQez5pWC6n73ClE7RQ
         8dG7YRBNKQABMDWVZKi+jY22+T90d4d41lkkHwz/S0Qg5QGEpMgP4yXE1SbXaj9Q/Nfo
         yeOSJW3b/QugMVgTs8FWYWBCQ/PhmsPb+VKByWydTbLncZshx1pkDtwKeodXldxBh10E
         Ct8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199096; x=1706803896;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXHpAvGT0l+OrcMVhCzIisM9di93nFyOAmu8umEvyYc=;
        b=qr1savO8M38HXZCdJGsHmai+BfAjyLQ2SbdtaT9VC8sZjhkKOgN177/FQxFg9F7uah
         OztOXVubNxNJM8xgAXVjtbxb7yhiIPLbHshHTs7xT0hBBtUJmrjWaikPDnFsroRjfnfp
         kRwjVyUDoBwZ15vPwGiRRIyO/a/VS9teVileVgUev3gCC8ckou5claeDScdcJzUmCEIa
         4VhyWDVJXb5UFfZR2scQjpbpl3P4V0KGnpPvAAv8s3EN6eK4h9dDUROckygrcjE56F6n
         RJcdyiiDnNTKDdOKvgUFpf0YSSCTUAlmxQ+sXAJeXkW2X43bQeiwuFXIXIFbOR2aGw4g
         QKyw==
X-Gm-Message-State: AOJu0YxI/mTlgt1m/HMW1YVfs530gRrTHEBkBy6P7SlvWppqyU8v5y3f
	uD68baqPuWUmc6yxfsoOKCVwnCaw3/wqXrZpRWXkdMkRpLXRpLJ8gk2osgT3jEg=
X-Google-Smtp-Source: AGHT+IEK/ThZ75X0mSLf5JYVYvXq2E1lW6GL1EM0E56z9MRc0RzZ+JHgPgmxc0oiVIA9uU/EKwDlBA==
X-Received: by 2002:a5e:9205:0:b0:7bc:207d:5178 with SMTP id y5-20020a5e9205000000b007bc207d5178mr2457404iop.2.1706199095804;
        Thu, 25 Jan 2024 08:11:35 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b18-20020a0566380b9200b0046cf80c799fsm4619524jad.120.2024.01.25.08.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:11:35 -0800 (PST)
Message-ID: <11868eb4-0528-4298-b8bc-2621fd1aac83@kernel.dk>
Date: Thu, 25 Jan 2024 09:11:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [jfs?] INFO: task hung in path_mount (2)
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>,
 hdanton@sina.com, jack@suse.cz, jfs-discussion@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 shaggy@kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000083513f060340d472@google.com>
 <000000000000e5e71a060fc3e747@google.com>
 <20240125-legten-zugleich-21a988d80b45@brauner>
Content-Language: en-US
In-Reply-To: <20240125-legten-zugleich-21a988d80b45@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jan 25, 2024 at 9:08?AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Jan 25, 2024 at 03:59:03AM -0800, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> >
> >     fs: Block writes to mounted block devices
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13175a53e80000
> > start commit:   2ccdd1b13c59 Linux 6.5-rc6
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=fb337a5ea8454f5f1e3f
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba5d53a80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14265373a80000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs: Block writes to mounted block devices

Like Dave replied a few days ago, I'm kind of skeptical on all of these
bugs being closed by this change. I'm guessing that they are all
resolved now because a) the block writes while mounted option was set to
Y, and b) the actual bug is just masked by that.

Maybe this is fine, but it does seem a bit... sketchy? The bugs aren't
really fixed, and what happens if someone doesn't turn on that option?
If it's required, perhaps it should not be an option at all? Though
that'd seem to be likely to break some funky use cases, whether they are
valid or not.

-- 
Jens Axboe



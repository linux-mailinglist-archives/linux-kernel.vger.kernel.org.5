Return-Path: <linux-kernel+bounces-75547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B927485EB01
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E79528A09C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF8127B63;
	Wed, 21 Feb 2024 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="twlEEf1y"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB90126F0F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550774; cv=none; b=dPCLM5OSk/N6fCU/KIttgwDZov4HmKTpIYa3hIVJl1QqBAy7Iu41I4trnfApoHHTEcRhuI+2Uk3edRPlT+zNlIz618YKsz2vc2OjuzYZwCWr/5iTNFrA7SHoQ7aHGGliSQjk0HLRCx7s5ZUyI3SIJD8KW8HOkgdjVDfBQSwUNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550774; c=relaxed/simple;
	bh=1oEaHzezRAll9SQ0JkGYVz7chMh/UI28PlbGaomS6oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9SFyzQBhiAQd0jKc/VUQ27SAj9RMtHRPyDhVh9lFyBQ3zH4sNMQcVgNmFY56vEJyrxJN9uS/SvNYJMoRH40F2SzKG4FbNsmRmuPe5pmcgHzL4BOw0oG5964KaGCTnPsE46Rnu6tNT8dadcrRLN07sAc7uRqhe8apsZe2aO2Y8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=twlEEf1y; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c15dd2a1fdso2682692b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550770; x=1709155570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oEaHzezRAll9SQ0JkGYVz7chMh/UI28PlbGaomS6oA=;
        b=twlEEf1yUUSQY4M7jcQpxVobd+dWC5ezggwrEwNE60AZ8QeMObLxP14XTPx38VQ2eQ
         TyrB4dnaVh7ipn13+vKwt6sJKS491Skg4KAMlL9NyxSI8HytAsFXSzZSk+umh+bpebcW
         YHwErdKYko8+z7QnDr0g9jOg0w3y7Juvk+0CXSSikE8fwrDLZhKCz4YDBKFAX8UfBeYy
         jUTHfw76ke8UM5rMB3x0u8xRuKsnecR7d8tvj0OaUwXWM9ceEuSwr94Fi6j2NKkbOyG0
         vuocKoz75fJUtkV5Hsf7vnXoE01wfziYx61d427gMjkLIq2cHgMjI++ZqF99CfNbPmnQ
         VnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550770; x=1709155570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oEaHzezRAll9SQ0JkGYVz7chMh/UI28PlbGaomS6oA=;
        b=p/S7zIyLBxsJRxUXJUmjLTTFJex4r+nfZInYxeauRHCvODyKpErKLrs05A630fEbSV
         9zXY71Dt5aB061Hv0rfRkumfnvQhYzJtwbXr+vDnMatyz9BQh7u5uL33OqecYgS5jfC8
         ZakZOF873sHluZdWF0R+nan5Qn1131+LjXHsXjIrfn3R3Pq5pmLLfrgoPXAq3yJo2tUB
         L6gweNM1fqP6QrTk0Nbv1C4GZnCGxbThkNgM4/MwVYPRkfir/shIypmGS77Xt/4nve/8
         tYvk3Ns9Jg1V9rloQgCBF9qEi9FmKUbEyMbXiZHNwaAA3f3g+K3CGP7ItboEZ4PHjQA9
         ZmAg==
X-Forwarded-Encrypted: i=1; AJvYcCU691ZhFO31YJ73GdJx4aTxDqeib9+DFzW1Lnmua21OEheI+IN+cqj/5brSboihDVBMgsuIWN1wq5Iz4N92QR5HmkLj3wxNY0D1U/ya
X-Gm-Message-State: AOJu0YwedpRAjXXVYFN0gcwwzB/Wv1BbZVxi6+wYRB6rP5yZmgi7M0JN
	2/lmCU0d2px8bDS5gjjvwTvHgUz2i7eWAMynsgnI1akzpDHsHNtWhOpojRZYpqq1jtqgFdaQe4j
	H4uHqB6kNsUY7fgCY3yF20HCe6i77GQ2jRxuADg==
X-Google-Smtp-Source: AGHT+IFZSNXNYlAy0AiXEzXx4upknBW0nGNBljw/bbiwmtTqAeSgHzhF6z+ApQTHTR9DUqPj2ju2fMwMSbPw53G4Luo=
X-Received: by 2002:a05:6808:1208:b0:3c0:3d12:2002 with SMTP id
 a8-20020a056808120800b003c03d122002mr24802049oil.13.1708550769929; Wed, 21
 Feb 2024 13:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-7-surenb@google.com>
In-Reply-To: <20240221194052.927623-7-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:25:33 -0500
Message-ID: <CA+CK2bDX7v8+NHi2ioxQ4KF+vBYA0JhR3=Sj6ZxBS0jD7i2Gmw@mail.gmail.com>
Subject: Re: [PATCH v4 06/36] mm: enumerate all gfp flags
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Introduce GFP bits enumeration to let compiler track the number of used
> bits (which depends on the config options) instead of hardcoding them.
> That simplifies __GFP_BITS_SHIFT calculation.
>
> Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>


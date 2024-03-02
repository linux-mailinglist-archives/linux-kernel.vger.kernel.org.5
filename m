Return-Path: <linux-kernel+bounces-89594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D086F26E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C60B22CC5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9063AC16;
	Sat,  2 Mar 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MkrmYQ8b"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96B290A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709412931; cv=none; b=GhJZYZhf3ZxCNXLzRcQatGCp+5UXxiFseNEiYYysKQf312SGHawIR3x6yF0hp96Z5POn2WrJzaFIwk2nHMNA7X5yym4D5vRTftgn8QGukpj4RvK0uE8TreH19zJl/KY9G2ySXgS6ZF0bwRurmjKTPAt0j4tdIuA8MJs9kztn45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709412931; c=relaxed/simple;
	bh=/QVxWrdYsSXRBS7b8mXmlIY/6mM9aW5HigWoXPzuTn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRQJwVMp/vdxN/YLk09NCkdShAZt2sUSgp/64zD3mMvLuvnaRnlBv8qrikenkltKad0q82NLEqcrAe3pD55XeiPqu3+lz8IXVm6bFDn8SYAwOTZVp6LwzQ+io2yzwQYC+ADGJCCzLmVSncGeZgFZ4TohvaJ4+VWg7nqzwRiQSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MkrmYQ8b; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so727900966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709412928; x=1710017728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Obv4uKrlrUZYJu+9I1ptVHxDKBrZGgW7K/LB2+1toSc=;
        b=MkrmYQ8bHXOGf1w9/cJiHGXOwDvjm17kwf8Qcp7yLAxOJoPUI/bXvDtRZo4RsZcfO0
         oTfqD+5A+GXZKWzuNIfdYUBosAmyG+VSsCJGBN50aesQy4pIUeM9vnCOj00r+DYN3PhH
         05N0HOhgMRVCgDq089S5IMtPhC2yrnM2xcO3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709412928; x=1710017728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Obv4uKrlrUZYJu+9I1ptVHxDKBrZGgW7K/LB2+1toSc=;
        b=LhOaSiN7M8xZGM5NSx67j2PyY5hw5fcMf7kpv6C3WTnXTE4mN7zr/Y0yZV2CKDt+sL
         q5uC6a4W6Z16ruMPeK1g55DLO+ODQo9R/aoWeI7MOjhoPXM5Ltm3Plaiavg5C0D+J91W
         fmZIeSeMdIQh8sjMgMWXqWiD2Jte0YBUWFMPa3Jc/9hnHsSnFvSFxUatbGX12OpR+TWA
         aSEuegzqB93ANtMtaDaJQ/BEZQvjzT0e5WFN5hiG1LgufZrzFSPZuh/ECE101tKQywH3
         nDPRmK6X0IRjO1Vdi9BvrKccI7fQnWSUAuTw/zqVDsZ2YWQDOtQdhzvxruBkkFZpPmRF
         i3nA==
X-Gm-Message-State: AOJu0YxY990UI6LcNMxXdm1Ka4l5euTEA+Aodw3NBzCiA5/9IDBqPZ53
	dZgz5ozLCnuw/AQjLRwQrytUuzR8xJYYdoqWtR86bj0CQ7m4/mF/UH1lExPeRm/IuXHi3sLz59F
	/k5tsFA==
X-Google-Smtp-Source: AGHT+IFeqg7onW2fP/6Xi2w1kzQaBfw/J+tjktVpT5zH/T353jF1kI49wsGfOwYAspLwFr7BRfSKlA==
X-Received: by 2002:a17:906:e08d:b0:a43:f924:d63 with SMTP id gh13-20020a170906e08d00b00a43f9240d63mr4202069ejb.26.1709412927891;
        Sat, 02 Mar 2024 12:55:27 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a445044287bsm2789777ejc.123.2024.03.02.12.55.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 12:55:27 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a446b5a08f0so355566866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 12:55:27 -0800 (PST)
X-Received: by 2002:a17:906:3445:b0:a44:99ef:8645 with SMTP id
 d5-20020a170906344500b00a4499ef8645mr4227052ejb.14.1709412926876; Sat, 02 Mar
 2024 12:55:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302111244.3a1674be@gandalf.local.home> <CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
 <20240302145958.05aabdd2@rorschach.local.home> <CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
 <20240302154713.71e29402@rorschach.local.home>
In-Reply-To: <20240302154713.71e29402@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 12:55:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
Message-ID: <CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 12:47, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm fine with just making it 4K with a comment saying that "4K is the
> minimum page size on most archs, and to keep this consistent for crazy
> architectures like PowerPC and it's 64K pages, we hard code 4K to keep
> all architectures acting the same".

4k is at least a somewhat sane limit, and yes, being hw-independent is
a good idea.

We have other strings that have that limit for similar reasons (ie PATH_MAX).

                Linus


Return-Path: <linux-kernel+bounces-164879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A768B8467
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC301C22A70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F56A1C69A;
	Wed,  1 May 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="HNGdH8T2"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1931BDC3;
	Wed,  1 May 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714531231; cv=none; b=rZlH7B7Q/Uc1UlBYY+AEGjQKJnbDj3pvahdiUaVBjYcVVRaTCNtK+IW0IuQOxoqE39+csKBCL/I5RHaLx9tCzX6PxQ83Os3JYnS8FbN/tV+dAQ325+/FUnoVVZsK3D2LJLUEZ+Euz1vf1MhshhVcx5p9PwFka+uzIG2NEHFGlic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714531231; c=relaxed/simple;
	bh=qujjLLZn1dYnPnloT6Ei0EJqKblua6wMYeE71eljMcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2zp8iifBZHHsVLQIlasdlsKvkPM3QBwOqBzrEcfuEL7+PYT5wcUymbpum4BOrpNU80hpjxeKuuex98t3uyIYGHu5DcoiMtWeDIg0PtOX/ZO+SXcCpwRS62TUHnUEEwD+Cwbh63+xFKXguE792fii/KHlan2Gsq1WJf6JkD/WqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b=HNGdH8T2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so9859787a12.2;
        Tue, 30 Apr 2024 19:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1714531227; x=1715136027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qujjLLZn1dYnPnloT6Ei0EJqKblua6wMYeE71eljMcE=;
        b=HNGdH8T21mqwQgOIJEF3gQg7TzE9hIoX9Po/NWkwk7SiuQol6U/W9w9PKTlu6ihX3h
         DIaMKfZhip/lPqgjMB2mb3qNcB8+Exoh0smAPhNnNdt5uKamFcGi03NTUjxtQIrSxpfZ
         lsnmn/WsebbWi4379QHr/3DrVA4Zk64P6bJZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714531227; x=1715136027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qujjLLZn1dYnPnloT6Ei0EJqKblua6wMYeE71eljMcE=;
        b=gMLmsnaQfgIjDmM6TeRzlG6etiLhmjTsAXLZjznxcEShHQLo+wwQRIXdaMpwS46Yqw
         bkU26sbpjwvTObo7T7hI5eUs98xgwENPw9gcIfE7k/dsJV6XTvSznxcZQTUQbiYtj3GR
         nsN5JMqUpdZ6KfBxWUzo1fGOwUV9zfY6+N4SVPEmbIiJsUeut5FrMWG5nzXHZsAL6VYz
         MHbh83RKH9WKC1M6ao6sPy4rp1jMpjyIUzpaBiiOO+764aDAQN0h8k30VcAqcmQyrboE
         huZZKEHfXMorvD8gP/4bj94+0KnjYcqa8JIua8Bm8sPMLt6Xy6zXtX6wBE/rkECpOwcG
         1daw==
X-Forwarded-Encrypted: i=1; AJvYcCX5QlKZC8dVQcJxe1kVv3hHY5tX8as+UxzNOZPTgs7B4wvCe/ZVsECCk8iBMODW9XCiRB/ODtvMCHeD57IFkbohg50KfaW7XxB5pg==
X-Gm-Message-State: AOJu0Yz607hqmkUi5iMeTydywMcwj6SPsFpALyFe6dPG+7UeoNZaT5nt
	mldQQyaXocMJp1n79XqEWpfwVTPmoRq+zv9VtJ3c8ZLdLUOWPx0DcazRqwRS27BCu5/khlPPSvI
	ZGDe7XGEW+3rA5g7KyqMUXhr3eoibAS4E
X-Google-Smtp-Source: AGHT+IEFKDGzuFm8Fc25foRnb9gyGT4KZsSqApZuo4AQVmspY5qXEgpj39HGAiFOYxIcDpFUbHDfPtNpp5kGIOLJlng=
X-Received: by 2002:a17:906:a058:b0:a55:b488:27b9 with SMTP id
 bg24-20020a170906a05800b00a55b48827b9mr1259682ejb.38.1714531226654; Tue, 30
 Apr 2024 19:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430173042.09beb33b@canb.auug.org.au>
In-Reply-To: <20240430173042.09beb33b@canb.auug.org.au>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 May 2024 12:10:15 +0930
Message-ID: <CACPK8Xef6bjbrC0Go+2wDEWpVi9eTueyodRjjaRjZfkjw07pog@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the aspeed tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Jeffery <andrew@aj.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 17:00, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits

all of them!

> are missing a Signed-off-by from their committer.

We were trying some dual maintainership but having to drop some
patches lead to a rebase, and this mess. Fixed now.

Cheers,

Joel


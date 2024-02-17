Return-Path: <linux-kernel+bounces-69762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C159F858E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774ED282ED1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BA71CFB4;
	Sat, 17 Feb 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYcjx91A"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEA149DF9
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708159951; cv=none; b=ottWK6bPBqC+TJ02UVB9+XC7kyjUx/tcGv+4xa/WNrmsWkkAcTbK0dNOT5oBO3Yjvi+w0HvBcT7KMMnVoUsmyjk67Q3bxBtJCkqIBe5zB66D8CcfRJpffr0WuMZAQzHlcJDz37W3CdxfCPtCC9mdE0jZ3okd3UwKmpccg0HIhzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708159951; c=relaxed/simple;
	bh=nVcADDj0nEymChB7ziMte5ZKS47sKPhemhFyVJVaOIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVq8HHwIo+WFFxivySx2tN+9UCAowbimJJ42GzIf0dhZKz76WNg7+A1hfGvCRWkY4BO+MGQVG62Je2wocklk9A6/fa73msDMVhLn6QZncDFFvrgAZ118bdaij5wJC6tWc9J89uKJjoYlziHYb6OsLxf7BnQ/VQlHvu64e1uT5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYcjx91A; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c3e01a7fe0so118124939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708159949; x=1708764749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVcADDj0nEymChB7ziMte5ZKS47sKPhemhFyVJVaOIQ=;
        b=MYcjx91AvrxuxO6nT8rvL2JjIKxehzoTWlDaVqM8GKS980NlkIu2FR+IfSYjxuplFH
         cHAuE0NnIgY5PsespbieUoAGs+x8QhLBpuj3RGD1cbC7DsCgH9+ZCyXW7S76hpsfYGNt
         r0Lnq2WjNHSjHnF4461rT9DRjc0BcpUHhS/QOOXdRpP1A8nHxfqB5E//QtziNXDEFo/7
         TKQKqFYxm/l2Ts2E5OYcYBqKhLzS4fLw1w4klpCLEs5ZBCR4cF0o8gDw1O2MHmbarVrl
         DYwyDoFOvRj1ZOJuwZtHRNrI7wJUTg3GQ0H5ePKezGn+ASIxFtFqN4Z9AS/n37lljdFT
         915A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708159949; x=1708764749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVcADDj0nEymChB7ziMte5ZKS47sKPhemhFyVJVaOIQ=;
        b=UvGh1EhXvXLq+lDUkVq+IBcs7fqeCeoH/W5NZJrCjep0p1n8XxqHvBM1vLHjeSCLqr
         qLn6TOnjLls+erwWqVVfKYV4bGJFrQ0KP6VEm0mdVS5O5tyV9cp8BsRHGRDF3XGlYN3H
         jLDHkiDfeJpNFBseVVzqXBwqs4eelEAG3lND0hKFUf/irMMuJeLUrj2327nOceKsv/b8
         egKe/xAfTlTWsYa+te/8W0voyybg0Hyxkk0TpDTgSYDIER7UMAYggue+QuvjrhcL1Xra
         5ds2glsrSHelubBwEmwYS50LjHAyk2ZLe3wg2DAFF7LLSmpLAeeQZP3JgzHx6pWbLhnz
         s7CA==
X-Forwarded-Encrypted: i=1; AJvYcCVLiK/YORR6oLBhjrUpjIcM73S/blG2Juv2tQWUIr7qaiM65Rjqq7mddD5oTtb9mn++F0EAZJzUy2yVhYE4JCdv+55wdQNjCjerf+M2
X-Gm-Message-State: AOJu0YyG/yqFfUjGFzXNViFpSVbHO0TeV3LryWeQug/TImGI8ruIl8Pv
	1brMG0wrWRIy5R19P+vI719jCPYDNCv5rR7zYh/3IQMHunf+ie2CMTHbr6Rm+SMaa8PMyi7UH8b
	OyXtXJroZ26sS0WiEPUTEcjcSbSY=
X-Google-Smtp-Source: AGHT+IFnJx52DSiIMZjoNsoOtv8syD71vB7wTyErRdSiRACxA0ljiaGtrESflzGZtF4GlcfjZGVMM4ws+4SzXrDfLho=
X-Received: by 2002:a5d:964f:0:b0:7c3:e13f:a41c with SMTP id
 d15-20020a5d964f000000b007c3e13fa41cmr7885899ios.18.1708159948921; Sat, 17
 Feb 2024 00:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217053642.79558-1-21cnbao@gmail.com>
In-Reply-To: <20240217053642.79558-1-21cnbao@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 17 Feb 2024 15:52:18 +0700
Message-ID: <CAKEwX=NzVXF++b0=01R5u=acmzRw4dLkL5uP_a_BnqhGB04=4w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org, 
	zhouchengming@bytedance.com, senozhatsky@chromium.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 12:36=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> We used to rely on the returned -ENOSPC of zpool_malloc() to increase
> reject_compress_poor. But the code wouldn't get to there after commit
> 744e1885922a ("crypto: scomp - fix req->dst buffer overflow") as the
> new code will goto out immediately after the special compression case
> happens. So there might be no longer a chance to execute zpool_malloc
> now. We are incorrectly increasing zswap_reject_compress_fail instead.
> Thus, we need to fix the counters handling right after compressions
> return ENOSPC. This patch also centralizes the counters handling for
> all of compress_poor, compress_fail and alloc_fail.
>
> Fixes: 744e1885922a ("crypto: scomp - fix req->dst buffer overflow")
> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>


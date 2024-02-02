Return-Path: <linux-kernel+bounces-50022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F23884732E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E991C22136
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28011468F8;
	Fri,  2 Feb 2024 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eErp11Hu"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B540145B3B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887910; cv=none; b=BKhkjWI2RiH5D+OeoaJX+08y8lOOHlhu/e3dAmZ7LY6bmLs0pNNB0iwakIfAL7Rgvapc8I+aVlOag9dFnxxCe60+akPa42LwT25of48BOTG8cBPRmxhxQ9Wu0ArrgzuDJ3ELjj/45uekA484ziLSGNaPNoK+cycJsPy4JnRjicY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887910; c=relaxed/simple;
	bh=X7CHp42Qev89FZqIAikgLbDlNbexH9c5Zo5LqW50PQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7m4E72z2LKvd8jeBISbRPloPnZm17U7licMsd+0DxLea3RKhk8rDluWdebQHcuGgXdPpk0SC8zSa9/WT7DjXnzmf7HpXcqij9v1mXy2TeE0atsZGmbEBvp6ri+86Y0jIV5x1S1smz0Jco6+cLVp7x+bu2m9s6clooFht/X7GuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eErp11Hu; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so2128091276.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706887908; x=1707492708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyvOAzMFIzsSlq2kiKta6LgOvAhbSJpfLskxvPgpInU=;
        b=eErp11HujsPY4cWoXSjHHOZ7vPmZED3O/U8ftVzZuTZ9g8qtb1trzvxG56JUjAaxMe
         RYQwlFbhMdnu52+jdMDjo+xHKRRUCrDwB98PFLqVAyWEsuG9nYI/1bWr1/WZOM6GR7PM
         mDqgxLlkDkuKH2n5zT7fADQz6mAC+zklOOkx+B8YzO7FhSG76XI6cXN+GrD0tZyXOpWL
         /i2EbwUNkBn8XW1MaKndDq0v+JxbYX7Qh91kOTTym5JUIT3CA2kn+df1ZilHYqBBUqgs
         mZuCQUU7pJXm9KOFOp8RiJajcoHhpoxEVR3UUobSDWfHKC7DEv+J1y+X95C6sSgQmRFi
         DEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887908; x=1707492708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyvOAzMFIzsSlq2kiKta6LgOvAhbSJpfLskxvPgpInU=;
        b=a6qqiAqAYGdOpLfVJxMGqZ4S9xwf4OtQK9FkuDIy1xPR7HVaJkOWBLQBOzS+nab10e
         o9XryreBHDZOIqF9VtRfVyaQubYG0pWFlkfupQGDVcW6T47rnmj9vdwN4GCAYL6298Qe
         4HLwHC4rQivEXT5CwCLKsOV87XuwN5VP6V2drbyJ4GTePa3X55WGQjQVdAtM0hIEaqoL
         YuKvBDcSHTxMT0opOKrz89e1YH3YXNhPPVWVLl5rvJUsmiKRLtj7aPhwgsuSUT090sp7
         wyXz+raPYPPz6wHB6j0LqFXtMlQ+k9ar+erYYZsRG279VPSLJI7vDSAlfTUl5ji9v24L
         w2/A==
X-Gm-Message-State: AOJu0YxiFuWO7rb00KAv8IOPmH9oLDJ1j2gF+qfofn9YVu1alF1su60d
	P2+mLoxYDGLtPBYUhS/B6gH+GUIdMM+AIYzV++lxMyrHOyaMDcX3l2WW4C6JX7OnQTlgwiLlHTd
	gjGcnXLfwpWFQ4MJOQSE5U1K4e/RrRs1LvMXj
X-Google-Smtp-Source: AGHT+IF23FJH1CrfkAGumfzPLOg3qie8GMPsuoo1BWOC2z8criLcQmZEuP8ymTXXNdxx7AdItEawlzLieCj8emW2AW4=
X-Received: by 2002:a25:df91:0:b0:dbc:c56f:465e with SMTP id
 w139-20020a25df91000000b00dbcc56f465emr8987242ybg.3.1706887907968; Fri, 02
 Feb 2024 07:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202034448.717589-1-dongtai.guo@linux.dev>
In-Reply-To: <20240202034448.717589-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Feb 2024 10:31:37 -0500
Message-ID: <CAHC9VhS2F8LkjRNQv7=x1DyRqDjatpuHJL5QNjqz7ru8-0Y1_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Modify macro NETLBL_CATMAP_MAPTYPE to define a type
 using typedef
To: George Guo <dongtai.guo@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, George Guo <guodongtai@kylinos.cn>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:45=E2=80=AFPM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> Modify NETLBL_CATMAP_MAPTYPE to netlbl_catmap_map_t, which is more
> readable.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/net/netlabel.h       | 8 ++++----
>  net/netlabel/netlabel_kapi.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

I'm generally not in favor of minor rename patches like this unless
they are part of a larger effort (code churn with little benefit).
I'm not going to block it if the netdev folks want to merge this, but
I can't say I really support it either.

--
paul-moore.com


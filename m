Return-Path: <linux-kernel+bounces-44217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B524841EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F9A1F22A76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5669160869;
	Tue, 30 Jan 2024 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlJnblv7"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5A5917F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605931; cv=none; b=jDtYmCodtqnw7Y6N3bWsCOpTuhrmDdhhac9UOUZWABtadKNTI6/O7ONWAKbWFIgcnExW69ES+JJTs3U0WHJb+ku5ZwV8J9MV8ZYH2GlX3ouVQUwd+m/LbUE8zlz9qhc7WMm4PbgJ4rx1cjzSVHhep5vkpu18Se9jsX3ikwIp4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605931; c=relaxed/simple;
	bh=c1F5HUyDS9pz9g1srZVHjwRjPe2I54aJjAWOf32bJAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TERuYKRoG+F6MSImVSyhpP1fOoHvrogHlVW6Xwb0+0jYe4Dk/Qg2myoa9x35HWnHj6CzbhnslZHei8bK/H0BgO5ibuDpElAABEJTqT2UU27+9DDLRuFLZflo+t5WDjs/UZtJXoZzYY77BwCKHLYShBeBHlZngun/kMK7m/hM/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlJnblv7; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bed9fb159fso128334539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706605929; x=1707210729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnbgnwm8mX0qqmyFdPhMbkalXQKPaabeF8Z9Wu1HI/4=;
        b=GlJnblv7K9itJppI5DFAQPUj8tLNOPMtIxFOs1S6zvVT1+XKaMYp1Dej3owmlnNHkI
         zXCu7Pqtr4llUDAL/ipYPTk9nYklVymyvUK/KgxezQKpiztX1LBxUeaCeMXW6mQrNPcX
         KBdKa/iCMKszk8/XOi//PQHbcUgg16tMQ86mpJwyW7JpIigdt/5HxFmBxTVRYADjclfB
         IXulyb6F0LiKZb088g/IAgFCJ1w9xaemWMjE35GJALMSFxuH1zKEu5fvdQaOTTGCnJ0w
         jKkDJ/26SIyvEE8vMPpWHAYuiK4R+/G1XP7767lX19tnFaL0zj/Cp6r0dfl4xyU4hWj7
         8oeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605929; x=1707210729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnbgnwm8mX0qqmyFdPhMbkalXQKPaabeF8Z9Wu1HI/4=;
        b=tdV4ObMnkLqVUeg7bJ7kmAlDIh5gBsqlQ+D5Jc3Nych+LC/9Euy/yrJfVFsi1au2VM
         sEPuHj6Kl3DASIveLw8LgVnW+trZHgFmgdbvIBByxc076SHQZXyQdUPNwuu/zsO4A7DL
         XpOiaBVRsJkUz1O7K+3UJHZz5UGYSHjzJoRVBQ6jZe7gy3fe15KrJDVFzA4HTyEwyF6K
         7/inWPVB30ayNiUxFcnE5lOm80MnMkhrPyE2YyXpJ4srFDjcvKQHX0waR1qaepIob97q
         fkuU8NVk/RnUgnzm5/kZFFN7rXf9X8TSk6Wo1ShY/SsVjpdDAxUfQPi5kp9mDOGDHCA0
         M++A==
X-Gm-Message-State: AOJu0Yx06MMJFkU9LTz2eZQY1MlZVXhQ1K11aLZFiyPAuyzhtGqib5aZ
	6TcEaXaj9FkoTOM4QaIlz+qDynxw7PRyVltoR/buVivv/LvxWUHMLhPN6xDOHYjH1DkjAdnUS+2
	bHa+ktsj7u2jiSl6DcwfoQc8Gd3ZxGM3/Lfk=
X-Google-Smtp-Source: AGHT+IGSqOqPVind6OqnxzJZZaJI3aTGoi16WEMWn2uwjgvCzSlAT9qvLAwCLqQKFmhSa7LYAzgKAM+8cOvA2cbx3uc=
X-Received: by 2002:a05:6602:29b2:b0:7bf:fa4a:990f with SMTP id
 u18-20020a05660229b200b007bffa4a990fmr4054925ios.10.1706605929213; Tue, 30
 Jan 2024 01:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-2-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-2-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 01:11:58 -0800
Message-ID: <CAKEwX=P7Qsz1TdKjOYpw7E5U1VFJ2gWWPTMfBrvKdet0ZsA3Eg@mail.gmail.com>
Subject: Re: [PATCH 01/20] mm: zswap: rename zswap_free_entry to zswap_entry_free
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> There is a zswap_entry_ namespace with multiple functions already.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  mm/zswap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7f88b3a77e4a..173f2e6657de 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -520,7 +520,7 @@ static struct zpool *zswap_find_zpool(struct zswap_en=
try *entry)
>   * Carries out the common pattern of freeing and entry's zpool allocatio=
n,
>   * freeing the entry itself, and decrementing the number of stored pages=
.
>   */
> -static void zswap_free_entry(struct zswap_entry *entry)
> +static void zswap_entry_free(struct zswap_entry *entry)
>  {
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
> @@ -555,7 +555,7 @@ static void zswap_entry_put(struct zswap_entry *entry=
)
>         WARN_ON_ONCE(refcount < 0);
>         if (refcount =3D=3D 0) {
>                 WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
> -               zswap_free_entry(entry);
> +               zswap_entry_free(entry);
>         }
>  }
>
> --
> 2.43.0
>


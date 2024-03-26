Return-Path: <linux-kernel+bounces-120017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3AC88D04D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830512E6B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB79D13D894;
	Tue, 26 Mar 2024 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVA+APJA"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C53C26
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489784; cv=none; b=RPEFv2njXV2y511ZTKcLSNgxH5LvJS3lzHXWNEpcb/hHzS1+0cu3wojAccafXmnyEgslagdLkw2Q3g5sVTAQHne+el1LNfeFoP1NoQM4pgZEuoNDDtEF+cSi6ADyLnYoh/B/Y5cfObt87TghwYGQ8pmwbgsQZ8dLZMTZiZMAGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489784; c=relaxed/simple;
	bh=lwSWDCf6521pCIK2wxRX5q6L/z8P0K8KTFLPzlgmrQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt4mNvjx8Dd7a8BFLF1ONjovADMG66JIhvhqmJx0qkoOonAOu6gQked/9IrrXxpml9vQY3S3U8xz3ewpQxAkL0ShOqojhg9b5wSNUfAAbzcrAUxjp/t7uGVEyatZMeBJ+PBqjR8GQiK+Q/Cup5Z7YaTaUlDJq8SxhLVuTr2N5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVA+APJA; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69682bdf1d5so18342196d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711489781; x=1712094581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEGnANGCVnpDGUZcTQwIUkqQ/IKd//G8yebAW3mMqzk=;
        b=cVA+APJAN6GNQkJ5f0+0p9fsifpKsqeExpSQAIfr6Cx4aJXcz6Ei+iXoyRY/je81e9
         ID3jGRlhoLWpmTIQMCybbiIvuUAExmVF6TiCKo3XJYXrQqdpUHRegwG4mn4BHlOP1Ttb
         aqxpZBwdmwRlU4Ze36LVmCddeR6DdnylXkJiVQZKesWj7zoj/yt8+bOOiRUEPuhnp7kI
         hwBZrZDkMbvC0bK6g+u8qeDtll2FWHYuNV5H3CmM53aE/BtuoX9jf2vrdtoPE4zsdI/o
         fUHqzJYbyilvvM3GsyqU+x9M9PN0OznXteC4zkIUSM0aEyy7ibFmHMUG+KgTbPoCirN1
         msCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711489781; x=1712094581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEGnANGCVnpDGUZcTQwIUkqQ/IKd//G8yebAW3mMqzk=;
        b=r7fLA5+EsDr003kp+olPWRoZicHHwZ07JInT733cVg3ImRfnjKTfISNJ7B5DO9JosF
         kOhHQJOsWgi5ypuOLi6A4d6KO12oX1AvQOlrPd0WTMsCiXSv/oSL5DbjUhWLlK/L9LXr
         jSoJbdgyphQ8ummjO8rcSmHtLc3z7sJQCT42Zm0IXTamq65hy1fqzc6Z3xOg4BiXS4P0
         s2KaOgj1DcmEg2Exy0g0Fe1vv+W9QIbU1iayxwi7bDmqre+ehMEh74+Rhmcc6O8dsc3o
         QtnndwjLJ5HRY0O6NyXjvo0M54hoNFJ8RfsOAwHB/FDuGFD7/XCigS44ybqYTEE9unaW
         //5w==
X-Forwarded-Encrypted: i=1; AJvYcCVCKbkrGXKQO24Cniz4patYR65TGHa2nqP39Hq6pMRJNKucB3wXnbGdo07Af+RJhsDdTCz+YFHWmQpRcu4eCxbi6c/CobyOOTiUmm5e
X-Gm-Message-State: AOJu0YwDy8jOk103tV2NKuZ4psFPDUP0wgONxMPkhwzrnHFbAwMU6yOj
	pKMjGRHZEPSSs1o1/brkTcNmsjL7BdZW3YIJfHJVbQTUj+CF9BKjf7+jOQPMTtHkUpsCHUsr6BC
	s7mVInIXmGpHF7rfeUJjuykoLZaA=
X-Google-Smtp-Source: AGHT+IGZRfsZKvzxxmjKHJcU8npENvv6KZIBvRhpv0stws6LsEWKrN5MKxFXWH/RhYDtrr/SPkvIL9YRckODznyn6Us=
X-Received: by 2002:a05:6214:1cc1:b0:695:f40f:d7e6 with SMTP id
 g1-20020a0562141cc100b00695f40fd7e6mr728029qvd.28.1711489781475; Tue, 26 Mar
 2024 14:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com> <20240325235018.2028408-2-yosryahmed@google.com>
In-Reply-To: <20240325235018.2028408-2-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 26 Mar 2024 14:49:30 -0700
Message-ID: <CAKEwX=PXUCnubYJEzF0wKU3B1aVGm3oS4EFmtMXUj4LsPyLK8A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] mm: zswap: always shrink in zswap_store() if zswap_pool_reached_full
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:50=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> The cleanup code in zswap_store() is not pretty, particularly the
> 'shrink' label at the bottom that ends up jumping between cleanup
> labels.
>
> Instead of having a dedicated label to shrink the pool, just use
> zswap_pool_reached_full directly to figure out if the pool needs
> shrinking. zswap_pool_reached_full should be true if and only if the
> pool needs shrinking.
>
> The only caveat is that the value of zswap_pool_reached_full may be
> changed by concurrent zswap_store() calls between checking the limit and
> testing zswap_pool_reached_full in the cleanup code. This is fine
> because:
> - If zswap_pool_reached_full was true during limit checking then became
>   false during the cleanup code, then someone else already took care of
>   shrinking the pool and there is no need to queue the worker. That
>   would be a good change.

Yup.

> - If zswap_pool_reached_full was false during limit checking then became
>   true during the cleanup code, then someone else hit the limit
>   meanwhile. In this case, both threads will try to queue the worker,
>   but it never gets queued more than once anyway. Also, calling
>   queue_work() multiple times when the limit is hit could already happen
>   today, so this isn't a significant change in any way.

Agree.

>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

This change by itself seems fine to me.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>


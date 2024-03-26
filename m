Return-Path: <linux-kernel+bounces-118296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB7788B75B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C454C1C2E90B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1F5A10F;
	Tue, 26 Mar 2024 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hMKZIuKS"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F429408
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419727; cv=none; b=DCIREuWMvrNos9ly7CzekiBFxkBS9tAxGBiGIW43rMZDIoNI5MvHm7v2vQoSyhaeKVxdqAhcRbuGBwpXje6TCUHtXuAUPIjNG9YrIXTLYquBfIDfllVF+s1YfAwkd2sVE0whNc0i6uJpc6iNIDswGk93Vb7PrV3FnFSscVqzicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419727; c=relaxed/simple;
	bh=oWW3styOUA5P0B+ryLw+EUTBtxFvFF46PeCkmDW7XT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtCbwb+5Q2K8SaaRqI8YY5JC4F/pT1b5p7dv2ec4qV4wKbkU9/l1JIuZFg8lZkPm3yeX2lDhcu7MgoXC8cm4n4rXT0vgtCSyt6fvejs4au1MtsmGOFRffytPgwB7y9i2LuTBpFLTIDPAQriJRFF8FKrgkqGsmapY/iGVCNWSU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMKZIuKS; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4627798276.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711419725; x=1712024525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTPjE88Kmtvbu12Qel97M6QMO/75XMfszQTW3mH8I1g=;
        b=hMKZIuKSvfvEYKmO5+38+4qx/Ol9OMjVu8F5+1uvLirxpdPZ+nfS/Pf76ovEGfTyDf
         ZDwLiDgi2Cxig7ZYc/tvAvDA8tFVNm1k884U8VOuSDwqYPieQyuPcgRlZWiG1kCKXqoR
         Txr2WVX79R5Fn5S4KegGDv34AsTQ0BCuodWlUIcDfQ8epLDfuuCsTzljdsXbmGXrsQnD
         2xyuWxeAXHs4deaVZ9y+lrBtZ8pO9hHZKtzwvow7zIjAhRwptsMVjZksovcQhsRZByhZ
         I3FyvE3yynXYrNBkpmtzll+4P4MbSo3o7pn8ukvb+6V1yHiPM6Qo+3pINLMGkRFsKnPG
         2Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711419725; x=1712024525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTPjE88Kmtvbu12Qel97M6QMO/75XMfszQTW3mH8I1g=;
        b=eA2cgRxZdVd+faKf/iRtAzvqJvYzKJppXlwQhxMQc/AXT7kCTgKntQTh9GSBnkJoUf
         qHT/iIwHTv9scwAzPsMHnNEJBOYlW3W9YBqoI/8S2J2jnUDe9Feq/8UmFkIxQtwXQdnT
         hvlmFX3bwOl0ggSkxXUXYb3GjAPIMWgudM/K7CkYocKOatjAjxjCHXkNSfUmun1+nGTH
         seIxsXvl6t9LkM0HAcAAhbIKFvpMP7+7Ho5UZ1YGvwZGGH5zNjE9g0XHmR5a9cw0IC+9
         aL8yL3UiojGvsLST5LtPZUlJr7e8eO0w9p05LTJFcf3BDRdIZzyNWPKGt39cY4AckJuP
         OaDg==
X-Forwarded-Encrypted: i=1; AJvYcCUKNvMPhOjUdplUJxWNtcsWTtfASfThRkZUHHg31dWrWz2e28X6xLYMu9S1ywA0GOBg2YY8bilrzk1ak67k2ie9FjK5vUOkrPGn8yzu
X-Gm-Message-State: AOJu0YxLHarOkaSldSZO90UYrvlkgnhr92M5b5qBJgZw5DSae/4pF4IU
	C5oybjw3BWo1Xva/6lRBKGMh98pQzLVMCSFIWBhgT4la9XCo3R/HlytRXeybz7CIYUB0b6Gbsrq
	RR1Sb3f5hfGb8JAxbBl58/DJbcTF82szOn4oP
X-Google-Smtp-Source: AGHT+IHSoMSpNTzqMHCg5QsTwg1AefarF5WUToxGdaGVWfeb9A/dyetvKDSoRHbIs+FmF+hPpehXodJ2+ajME1xY9ac=
X-Received: by 2002:a25:aa0a:0:b0:dd1:48cf:5c8 with SMTP id
 s10-20020a25aa0a000000b00dd148cf05c8mr6479203ybi.2.1711419724858; Mon, 25 Mar
 2024 19:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325122504.6f46a5ae@canb.auug.org.au>
In-Reply-To: <20240325122504.6f46a5ae@canb.auug.org.au>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 25 Mar 2024 19:21:54 -0700
Message-ID: <CAJuCfpEHdrrym1gGHj6imzNccRYfCLH1JMaJ_ZWSkv-U5U7xOw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 6:25=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> After merging the mm tree, today's linux-next build (htmldocs) produced
> this warning:
>
> Documentation/filesystems/proc.rst:958: WARNING: Title underline too shor=
t.
>
> allocinfo
> ~~~~~~~
>
> Introduced by commit
>
>   d08b311b6d49 ("lib: add allocation tagging support for memory allocatio=
n profiling")
>
> from the mm-unstable branch of the mm tree.

Thanks! I'll post a fix shortly.

>
> --
> Cheers,
> Stephen Rothwell


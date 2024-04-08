Return-Path: <linux-kernel+bounces-135890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779AE89CCB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FCAB246D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C88146583;
	Mon,  8 Apr 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIK8PiHu"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11053368
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606000; cv=none; b=lbNLaavuIW/1mFNFvG3vIGXJsu9grXGbh8mkkPG9y9DhTEkp9fxuFRiWlxhyi1zQlkhE/XQdRFgKTYfHiwjXK36IL6X38wqDdZMy47mAY/bc5D9YWl5pj7lsyA+svjTN9fWjuEdBk+JKIBfikZvnjIuFkS5g1R17lOl9IgjJeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606000; c=relaxed/simple;
	bh=J1CPpEryYaTGUfxmUhg8z5Ww9EQAIWCkFK5iQn4gbp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcPpunGqdg2ix1RCK11h+XUlwllr/loOX0H2S1AOP8qelNjRVI5kpXW5JGQaQKEkUvy1QqilnVdnn3N92lMLSFnsCmUHvF2iIZqfqZOOIlUZ6giu6XE4NB/JSZkF0haukDrV3dsJR64vqVLfYiG+b2ICK8teCRJEpota3gr50pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XIK8PiHu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d0161e13so5244366e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712605996; x=1713210796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2AGkVcZDY5nhM/OCU0iqlvLzvTbYOvupbbnUFtFSug=;
        b=XIK8PiHuYaqH4sxrkxjXvaIKRnC1tY+A68uZYV0pDJYLA+fGv0nWlATZdho2LFiU+R
         CdKN3KN+9/DyCWhwWdLzHjE2kRsgExVK46vWB13tOuAPT8Uf22pyuNobX4RIm6QShdUp
         ZbNbU8dEJk2YamtX1Neg2/7FiageqZQ/7iHf7vT1p7JxoTOPzbu73SPexoh0EBR7oza4
         fjIFzqnxc7DyRKl1Nu51gXg3yVz07rehxEJgvvVtBxeR9ThMl8HERtjVoNb1NIVCN2f2
         qX+TQ3HHqk/GuGOtDSPbyWtBAmmN8o9nSgpst5G2o6C6Yp2Nb4NxksMGjRe9wTMqqj2k
         m96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712605996; x=1713210796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2AGkVcZDY5nhM/OCU0iqlvLzvTbYOvupbbnUFtFSug=;
        b=KpRh9Kr6dhM6bWeCO+LR/XUuvsJV77Ce7G7CI542kTQQZcWbeKzGhYYFkGNYKOPqia
         kVqk9dHCkdAb+eDyAqDsj1bc8S+4+5Y9AjSBkGtTurgVuHJS5UdHBCllb6bjAR1vSr69
         0WGK0D6qhrwjzs1l4XlRZ0KYfx0/rfKUzA4S3St08zMJwS7CXzoaMhpl+Yw+yp2RdpIX
         9v0JYeXGQx5IXKHAsQn2DzSQhSWdYNBkcahuOOfvZ8MciT/YE002xa8apuwrKVJSo5E3
         6u2B0InAYh1y2k7SNZwCjH6S0PNWyVusZxY+gGCq7sKvzw1fdVc6PrITXLbQwHp6DxF/
         irMg==
X-Forwarded-Encrypted: i=1; AJvYcCUXCyX/EmvvR8MKx30TyT19pqj8h6HH3cseK6S6CSsgZRE/ytskcH2qOF7oDnDWzwZ7U8RsDaC6ZaIk+E+/MGLdg3D42vYXMfALymXE
X-Gm-Message-State: AOJu0YyKKBEab8aCJA5k0a4U2AgLw148e+Qpa19Uz5hX3kh85wDsichz
	LeCFHF2JiqiaKPXLADTD4yFqy+H9r/1W779TkVqNchqAjYROlakjtEdjV6o8eI002BdEsWPGIhw
	L5OsHG/lc6zzxIrm0PPUzwlB7bCFNM9oZH+6f4Myzwx7gai3ZU+p6jTo=
X-Google-Smtp-Source: AGHT+IGiq71xWSq509Fbj1QHKbgzIq2ht2tqsCjNzDM2T/bLNUHKRpyAgp224hMy9rmbMhotvYvlEf49G19GEnYrR8I=
X-Received: by 2002:a05:6512:3993:b0:516:e8b1:177d with SMTP id
 j19-20020a056512399300b00516e8b1177dmr4743559lfu.65.1712605996374; Mon, 08
 Apr 2024 12:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328140512.4148825-1-arnd@kernel.org> <20240328140512.4148825-6-arnd@kernel.org>
 <u7hc4tkkwr5eua2p4bdetox2lqtawzb6dwimuipejhoiitbzhh@yu3e4sljhgxg> <8b771062-7ce9-4b00-a488-91b231a1476e@app.fastmail.com>
In-Reply-To: <8b771062-7ce9-4b00-a488-91b231a1476e@app.fastmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 8 Apr 2024 12:53:04 -0700
Message-ID: <CAFhGd8r02jSj5jxny-6Jpr5et75MQzkG1FeLZC4ftu9V7KAn3g@mail.gmail.com>
Subject: Re: [PATCH 05/11] test_hexdump: avoid string truncation warning
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 8, 2024 at 8:38=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> You are correct. I do understand the nuances between strncpy()
> and strscpy(), but I failed to read this file properly.

Arnd, I know you understand these differences. I did not intend to
patronize, so sorry about that. My intention was to provide ample
context for future travelers/reviewers. These replacements can be
tricky sometimes.

>
> I'm still not entirely sure, but from my current reading, I think
> we can just use memcpy() to replace the strncpy() here, as both
> the input string data_b[] and the output real[TEST_HEXDUMP_BUF_SIZE]
> are sized to cover every possible 'len' value. This also follows
> what Linus did for the other original strncpy in b1286ed7158e
> ("test_hexdump: use memcpy instead of strncpy()").
>
> I've reworked the patch based on that assumption now and rewritten
> the changelog text accordingly.

Great! This helps towards https://github.com/KSPP/linux/issues/90

>
>      Arnd

Thanks
Justin


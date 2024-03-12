Return-Path: <linux-kernel+bounces-99707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BB1878C09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538ED1C21854
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3B6EC3;
	Tue, 12 Mar 2024 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DvLTzMyQ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568363C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710204670; cv=none; b=bjtazg0nT/FGg8OBvpww3fytK/bdRCYu4iX61M73D1NohWGM8TqVqfe/+hLUvS/GXSP0LFsCv5O60QgL0R9MhYHCWux9SYYsOPM0uzuhRuNlPNL/c6k6+4lLWh11i5dSEUJQVd8RpcCoT4qMhSLQJz1sEj3NYTVBSgcdHjNFKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710204670; c=relaxed/simple;
	bh=TVu2ddHW7OJntidPfkdMAn03h9H8bWXdC69rdaRrpoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhCfT104MAMgtLU3h+DkwGIfajgBx9IbvUQRMmxnZj5M6MAr3TIIDTXo1lGbw0csxPMfhU6LCGpEOhvkVbWN3igVMW7CoZToZP1ypluHWbll7LyTwpPvwlW9Tp8pCBclTnFjO04LM828CYIshpaKljXif3O+cIGe3y/dpFtrBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DvLTzMyQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5682360e095so5852686a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710204666; x=1710809466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2NX9NOb8w5OYlJABNw8QS2FIfeKbdgR8st5EaZjrGU=;
        b=DvLTzMyQ0gxNKkvbPAOS6eAf/mlc+n1ImktLnqUBEaPfC6j0VRaHWq2dXiMGl4nCYI
         Q9SqudX1z3BlFsDbZ+Ereqg7ujAnNM9CExzSY0XbryzxrUajXQBy4Me1oOPgEWG8Ldcq
         b5Q4x27mEw6mKydb9na9NkvsMQSV0qGEev3xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710204666; x=1710809466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2NX9NOb8w5OYlJABNw8QS2FIfeKbdgR8st5EaZjrGU=;
        b=fWQodDmAuow7R9IssudpDzH9F3WUJJMpKBY8VO4k4IOuwW9ngsUTDJtvKEDn7OK3Di
         WpvIVesfze58/D/YK9Jx3XypvA+ZcLRPeSC4UW/kXgig6Y5keJgHJhl2VikN1fjb6G3f
         EBtsa9Olvi2Sq+cZTdMgmjnZ3uDuAhjAORtOXyDEMYJIUO+8To4P8TUmYX8ls/L6qKDh
         Hr5eaYsvNYFgB2lgj5ozhviKE2LX78QziE+NgQLzIyt0SUccsPoBzNYsqhT7BQq8O6mt
         ifTkS+3Xh4TUYaQD1rRgcX1M6aj8dPvERm9/YrVAILaBtYkTvb4C2/Ge0BZOJAu2h9gV
         jRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVftWrlDPzcB+DOJytMdKmJE9cGys8N4E/jkWssq/OIU1Xsr4aXX4EBN9p8Ipk0gqD97vXY+2YtE6tcAY49iXpHJMPA/e0cZ7J4qWVD
X-Gm-Message-State: AOJu0YxSl8BIElqdcJB6UCtZvjxh9Z9sxMOKrdCYE7b/vv7KfnDAqmN8
	g5I1wjP0v+ZOLwex6DMLdy49bEwkbbN+Bqfwxk1l8IJSglOpzOsvs+xgJ62TS8FC11Iy83peMXt
	gz2Mpcw==
X-Google-Smtp-Source: AGHT+IGffNi0I2iXY6MfMBeMfAj0QPaN5mi4dQ94r9g6WE0L0+ay9VmiyatriJTf5x891qefEPXf7A==
X-Received: by 2002:a17:906:ac5:b0:a45:ebdf:b071 with SMTP id z5-20020a1709060ac500b00a45ebdfb071mr4951612ejf.35.1710204665740;
        Mon, 11 Mar 2024 17:51:05 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id ae1-20020a17090725c100b00a45ffe583acsm3208803ejc.187.2024.03.11.17.51.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:51:05 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4417fa396fso348198866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:51:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWinucJCzVXIAb3wc7AJsbbHdwocwfn032hdymn85Jzq0u8PWCItwLraPgDu96QPco1nCBwke1kMndNmubVSmGxWoZLXQ93gyX+yGzB
X-Received: by 2002:a17:906:ac5:b0:a45:ebdf:b071 with SMTP id
 z5-20020a1709060ac500b00a45ebdfb071mr4951594ejf.35.1710204664861; Mon, 11 Mar
 2024 17:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311151909.GAZe8g7SqDKRcP4XrO@fat_crate.local>
In-Reply-To: <20240311151909.GAZe8g7SqDKRcP4XrO@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 17:50:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=witL2fFR-FK_nt5TTLHKffueUQnv875-aDGUqn8O3+o_w@mail.gmail.com>
Message-ID: <CAHk-=witL2fFR-FK_nt5TTLHKffueUQnv875-aDGUqn8O3+o_w@mail.gmail.com>
Subject: Re: [GIT PULL] x86/sev for v6.9-rc1
To: Borislav Petkov <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 08:19, Borislav Petkov <bp@alien8.de> wrote:
>
> If you're merging tip pull requests in the chronological order you've
> received them, you'll encounter a couple of simple merge conflicts.

It's not exactly chronological - I tend to go by areas and by
submitter, but it tends to approximate chronological most of the
time..

> I'm adding how I've resolved them at the end of this message in case
> you wanna compare notes.

Hmm. I took a slightly different approach:

> diff --cc arch/x86/include/asm/coco.h
> index 76c310b19b11,21940ef8d290..42871bb262d0
> --- a/arch/x86/include/asm/coco.h
> +++ b/arch/x86/include/asm/coco.h
> @@@ -10,9 -11,15 +11,15 @@@ enum cc_vendor
>         CC_VENDOR_INTEL,
>   };
>
>  -extern enum cc_vendor cc_vendor;
> + extern u64 cc_mask;
> +
>   #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
>  +extern enum cc_vendor cc_vendor;

I put the 'cc_mask' declaration inside the #ifdef too.

Because those two variables are defined together, and without
CONFIG_ARCH_HAS_CC_PLATFORM the whole coco/ subdirectory that defines
them won't even be built, as far as I can tell.

And I don't see any _use_ of 'cc_mask' anywhere outside of that one
'cc_set_mask()' inline function and the coco/core.c file. So declaring
it only when it's all enabled seems to be the right thing.

Let's hope my artistic merge resolution doesn't end up coming back to bite me.

           Linus


Return-Path: <linux-kernel+bounces-47784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E838452D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E817B1C216E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB8415A4AC;
	Thu,  1 Feb 2024 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyiMk19w"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8042067
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776581; cv=none; b=eKLoBfK0W7xefgCbWBTBgKt5L5ggvbcpHE8yfr34Iyj1dMKILWc86Pi9d9mzOdkCs6d3WvT+KBp7OFWJF4Dxpkl33o/+VZ9oC6UkhMHP6RqWeQbSEuen1mm6XqaJkJtRdRCUYvWBByNc3ouFp/iKJwSRiYJU7+EVcElos1Y9MCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776581; c=relaxed/simple;
	bh=URAbcGOJJOVtRbliw1Z2VqfxkQeuzBfO9ciuWBnjr64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6PDmqtSWcv+AtLa0dqWvzCkyYeRsLJj8Yjj1cXS3NXci/PCmZ9xkzIqzWdzAniGy7jtL0TG66KF54KJeuRl4oR6bWdKwXohx44FdxBjcQ9sKaFNz4rRAt2v2PMvcLzscA2BwWEJeNkpZDEU6WlWmTOJ3Mntw9t/3ocV9lPRgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tyiMk19w; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4bdd39b62cdso244958e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706776578; x=1707381378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aNWGy3aMj6Es13FsqznlTHFzLMxc1/DDzgiYp75ZJxU=;
        b=tyiMk19w2VrXLIy+JtsvpyNhdAWkuf70KO6Bq2erDXOOuJtWyVoqcu3U92KZ5JXfKW
         fW4LjfGZmNnbs9rLOy15j0sA5FG7+31SebFwufeBt+UYn+nLiEt97B3c7CjmcaXOdYhI
         tu8eSiwgiazFshbnGmsDYpBMuJPhYFIqcRSGDXHpJEUevJxatFzYm72dx1hvlHfM71Lz
         yJfFDBJAanP2KJyeGda5cewqg/6ckpE2n7pIMJs/nKzqNIITfliap9K5G6Q2GhVeb7Bv
         LOKILTXKRyOeFjP/w3dkT0wnf90aUfja6a7JidEfyLffGVxtBzV6g2boGO0Xz5v18v2Z
         THrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706776578; x=1707381378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNWGy3aMj6Es13FsqznlTHFzLMxc1/DDzgiYp75ZJxU=;
        b=ZLNeReIPOF5v9e0IaDxa1jN1Jei7192vbmjetXedpCAjkcNWLE8w16XLS/nKFzke5e
         MCe8FC5kwRYF5UucCWIV1bEHF+90oXzJ9DlyO24/jfYlrC7jyqY0bG9nCOl/u+ObAkfj
         3BzsnG5RC6Fhf+Dld3rRoMHysN8pRR5PVOmpol1T8u6ALxrat7UmTHNWenTPSNd5KpU4
         r42WPeRKLGEHws3xG15vGbQhG4ip8/+nzOOqBl0eaWxQa4/Cj5lSPqIk9ZIwnqVU3a7p
         RhqrU0auko9l8C/69W+EXgOPAAFyF+HnICfRS5KjzD4iS3lBZgo7uQxINmCSXOYCFTPd
         pnYg==
X-Gm-Message-State: AOJu0YydrIqWu1PREaqrierSoBoE/VTQ0LzsH2sXnbBk5ifMfgeaZIGP
	Z/Ml51DamriE2UYJxgRDzWacn/R85WajjHxW+6pVE3mqGq72y2ZIb0kjNTHg0fY3+NFZhC+IQPV
	JGzjxSzjXEPrsXyyyTIoc8py1MeHRyKjXPplM
X-Google-Smtp-Source: AGHT+IFxmaX/PS5XiugiUred/geHgTCYyWuBNSHvpCYMHl7WfgQ9z92CT9vUATBC8i4qxWz02ONq7uV4Qfi0FAqwBHk=
X-Received: by 2002:a05:6122:178d:b0:4bd:4736:5226 with SMTP id
 o13-20020a056122178d00b004bd47365226mr3262306vkf.11.1706776578390; Thu, 01
 Feb 2024 00:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201135747.18eca98e@canb.auug.org.au>
In-Reply-To: <20240201135747.18eca98e@canb.auug.org.au>
From: Marco Elver <elver@google.com>
Date: Thu, 1 Feb 2024 09:35:40 +0100
Message-ID: <CANpmjNPG01_70DMC4mdswN0a7sHCRoUZvsALD9=z_N80oTL3sQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 03:57, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the mm tree, today's linux-next build (i386 defconfig)
> failed like this:
>
> In file included from arch/x86/include/asm/string.h:3,
>                  from include/linux/string.h:61,
>                  from arch/x86/include/asm/page_32.h:18,
>                  from arch/x86/include/asm/page.h:14,
>                  from arch/x86/include/asm/thread_info.h:12,
>                  from include/linux/thread_info.h:60,
>                  from include/linux/spinlock.h:60,
>                  from include/linux/wait.h:9,
>                  from include/linux/wait_bit.h:8,
>                  from include/linux/fs.h:6,
>                  from include/linux/debugfs.h:15,
>                  from lib/stackdepot.c:17:
> In function 'depot_alloc_stack',
>     inlined from 'stack_depot_save_flags' at lib/stackdepot.c:688:4:
> arch/x86/include/asm/string_32.h:150:25: error: '__builtin_memcpy' specified bound 4294967295 exceeds maximum object size 2147483647 [-Werror=stringop-overflow=]
>   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> lib/stackdepot.c:459:9: note: in expansion of macro 'memcpy'
>   459 |         memcpy(stack->entries, entries, flex_array_size(stack, entries, nr_entries));
>       |         ^~~~~~
> cc1: all warnings being treated as errors

This is a false positives due to -next enabling some new warnings by
default: https://lore.kernel.org/all/20240201083259.1734865-1-elver@google.com/T/#u


Return-Path: <linux-kernel+bounces-103852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283E87C5BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93054B21BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA9FC0B;
	Thu, 14 Mar 2024 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UsCPAoCf"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA623BE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710457528; cv=none; b=jlv7EMUcYzPlMrrrD2jJ0WY6ofEpD514u2AIwqF24Yt/TF+SVD8MF3w3pZRcptpseGlllv+oqlkOyUMdorFTOzH9M9RjMQQeVqEm5ePFDRdzB/avl/wsZ12TVn6bMtJgicXUZhN4Mz6TcXwmKHE3XCNaznkQzGaBablzfqQaozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710457528; c=relaxed/simple;
	bh=EQZ/45evtuO+++qaNfNIk3sxSnAYQotM6BezQU2ECFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+ITMd5EMvg0Cny5Zf4Ha6vbA7CBftkWISjxJP+Xj2PvYNBZ1rhMgUaggqgSgXPyBsxexu5hRpZKV7zg1QVJTwAznUji4jWppnOcOFuIDYCvtNNQe9zkCvqboaw1EtChhNzt5hrYB+d0vDABsRKAPjRpsy0JvthNsjtDI7Xp6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UsCPAoCf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso19122361fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710457524; x=1711062324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOLqBJYl+Zv2uwlXW3yqDcamvgCQRPjZY652QVEqHVk=;
        b=UsCPAoCfBOPZYHUTjgPdFz5ccAlp8B4IlngO3ur60FqxQx9E48nV1Xrmb+k+CvbLkJ
         3Js6071GDxmiKfTYtc4M+DNnXSDKeQBqhlLN/hTAgH/6SJVspDmO+0uWK4lfcXrkaM1F
         vJ8FDd+4F/aN6C1a9ox9H6fikS1JqkTsfIGbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710457524; x=1711062324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOLqBJYl+Zv2uwlXW3yqDcamvgCQRPjZY652QVEqHVk=;
        b=W2AWV0i6K9tkmgLtoiNp4lERAUyUvrFi0A3DN7qFid5/Zab/3uMAlpX7DrTyg++ubj
         ER5g45DS98Z+vbWfHL6rBbGybuj3WVEfaj5cG5FqqkdZ3KG4pVM5tt9iPBJXR/tzA9d2
         kz0W9M+vKPENz1VcdgbULU/UgH014Y4IK4LhkOcavMtTUQQrSSvV1MESw1obEsCvZj5x
         5T5CFv8bWsszsSLXtymdHyGCpYZ7x32dAQ8K07Wvf9zHbYxjbwOxBfDrWcVE/JPoUcFQ
         kgnOVytnpzLxuSQO1bQ4lAK2fRTFOpmx/PttISK0pfKfyuWv25fCaGhzetJfDiPay1B6
         KIeA==
X-Forwarded-Encrypted: i=1; AJvYcCXLNdPfFx1NtyXY3JZX4UfoQoTQ26wwHx/sCJG0bmBgCDAsDGzefoLxR4sZT9s1XXa+ckuoJRdWFRiT+p0VscpzRp6nvp1QVtKO7HKX
X-Gm-Message-State: AOJu0YzZDUUa24u4hIvWlLDOkhe8c3TRASV5krhgLzMbArLGACBrGuVz
	Et0KMSQV7Ijxi4W3uVYngDiTwhGAGnAGu+l+Ea8YVvr2UUHXZH98joAXNkESklourV6p1T+1GXK
	91GY8dQ==
X-Google-Smtp-Source: AGHT+IEItCpajb3qCby/62GwdN3F15gqmiNAJx0DVeFCMYVdFSWYYdrM2tNl8KxisuMPtLASmthT0Q==
X-Received: by 2002:a2e:8ecc:0:b0:2d4:422a:3ad1 with SMTP id e12-20020a2e8ecc000000b002d4422a3ad1mr853981ljl.27.1710457523639;
        Thu, 14 Mar 2024 16:05:23 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id cx14-20020a05640222ae00b00568af798c9esm17206edb.90.2024.03.14.16.05.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 16:05:23 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so1957919a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:05:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxCXpMWT4B8ztnQg/LwYG3QzYrQlliJHZ6IbJfb+DSAIFx0VFOY57P30WKKgMdFke/M56GXdxeIWcGnd/2FfB8FK8+eCa2oiBncEsd
X-Received: by 2002:a17:906:6858:b0:a46:5f1d:f357 with SMTP id
 a24-20020a170906685800b00a465f1df357mr756853ejs.10.1710457522597; Thu, 14 Mar
 2024 16:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f2a695a148db9e1daae8c07d9ce5c85@paul-moore.com>
In-Reply-To: <3f2a695a148db9e1daae8c07d9ce5c85@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Mar 2024 16:05:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXK3ZDtCM754mQVWzcZdQd50dBU5Y+AoATWcCGCMWzgg@mail.gmail.com>
Message-ID: <CAHk-=wjXK3ZDtCM754mQVWzcZdQd50dBU5Y+AoATWcCGCMWzgg@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240314
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 13:31, Paul Moore <paul@paul-moore.com> wrote:
>
> I would like if you could merge these patches, I believe fixing the
> syscall signature problem now poses very little risk and will help us
> avoid the management overhead of compat syscall variants in the future.
> However, I'll understand if you're opposed, just let me know and I'll
> get you a compat version of this pull request as soon as we can get
> something written/tested/verfified.

No, attempting to just fix it after-the-fact in the hopes that nobody
actually uses the new system call yet sounds like the right thing to
do.

6.8 has been out for just days, and I see it's marked for stable, so
hopefully nobody ever even sees the mistake. I can't imagine that the
new system call is that eagerly used.

Famous last wods.

               Linus


Return-Path: <linux-kernel+bounces-20243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDD827C5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB9A1F2425B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087A4A3D;
	Tue,  9 Jan 2024 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KTAy93Wz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A74418
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e47d74824so13066735e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 17:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704762186; x=1705366986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SK/U7sMdUF0m3232sJNLcxLQzzyq9KpShnd9w+HBMfo=;
        b=KTAy93WzaS0nEYohR0bwVB5dTBpdtnmmFs+bQl6J/Gzf9idhpsTuoJJNvN9jFcy3D1
         3Bgu+a0Jv9ccXsbOcLN8aEK3mL+zPKtptAXf2SKdI/v6INoolAILQKug5B/PpQeFxugD
         8dc9uDyQgjVb3qzIi8U2dHtt4U7BCE9c42MM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704762186; x=1705366986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK/U7sMdUF0m3232sJNLcxLQzzyq9KpShnd9w+HBMfo=;
        b=QCGCm+ledFw6auydIYtxBl7ScAN41V6xYADifYeaHEzpL9HwPq3ccUzTSla4yov4+o
         oE/YAjhqTEpFUa/2vOFNAzjlfxyZbhmGH5fLislF3G/h2sg6dI6Vd9FBTl7hx28x22js
         yQAqohmrSssbYuo/plelpItX8rOMoFJ1OcXgdoQzRhD5vGGJFAmS+67AMtn8OXPBMhfM
         BLz4OhJBL8TVTM4TfZK70s0bpCwExg1devHltakluaVWDy4lfHW+q2HI7TbSoRlcOyVM
         iJGmdYnQuLzAp7U8lv9RTyF3sdxlDHpStxV/E5s4/VaSNzwaiu83li1S7pn92CxTwsBf
         xuWw==
X-Gm-Message-State: AOJu0Yz8sY7HAU4/+iH2CKQbA09pnfBrythMfcF+vW3ymFL5CgUShD9j
	BN5Umr3wyzDCyY9xkz7swT6slTC0hd5ZKrWPQEFszKWA87oGF/v6
X-Google-Smtp-Source: AGHT+IHaua7pDGo1OQOuzHO+T+SUQSnaS4ux8sj1aFmcod8qU75L19LYJ+54KRFNcwrql07shzVrHA==
X-Received: by 2002:a05:600c:5404:b0:40e:4ad6:16df with SMTP id he4-20020a05600c540400b0040e4ad616dfmr306837wmb.100.1704762186292;
        Mon, 08 Jan 2024 17:03:06 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709066b9900b00a28ff7b8049sm431625ejr.224.2024.01.08.17.03.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 17:03:05 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28b1095064so260947866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 17:03:05 -0800 (PST)
X-Received: by 2002:a17:906:1389:b0:a19:a1ba:bad0 with SMTP id
 f9-20020a170906138900b00a19a1babad0mr58005ejc.118.1704762184865; Mon, 08 Jan
 2024 17:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105-vfs-mount-5e94596bd1d1@brauner>
In-Reply-To: <20240105-vfs-mount-5e94596bd1d1@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 17:02:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>
Message-ID: <CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs mount api updates
To: Christian Brauner <brauner@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 04:47, Christian Brauner <brauner@kernel.org> wrote:
>
> This contains the work to retrieve detailed information about mounts via two
> new system calls.

Gaah. While I have an arm64 laptop now, I don't do arm64 builds in
between each pull like I do x86 ones.

I *did* just start one, because I got the arm64 pull request.

And this fails the arm64 build, because __NR_statmount and
__NR_listmount (457 and 458 respectively) exceed the compat system
call array size, which is

arch/arm64/include/asm/unistd.h:
  #define __NR_compat_syscalls            457

I don't think this is a merge error, I think the error is there in the
original, but I'm about to go off and have dinner, so I'm just sending
this out for now.

How was this not noted in linux-next? Am I missing something?

Now, admittedly this looks like an easy mistake to make due to that
whole odd situation where the compat system calls are listed in
unistd32.h, but then the max number is in unistd.h, but I would still
have expected this to have raised flags before it hit my tree..

                Linus


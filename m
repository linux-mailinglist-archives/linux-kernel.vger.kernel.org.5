Return-Path: <linux-kernel+bounces-34262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF448376A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54235289476
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2414262;
	Mon, 22 Jan 2024 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HTC5bauZ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C9FBFF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964092; cv=none; b=ASujX7nAbX/YPab+R4nsCD4jk7xFdde8pjzHCIvIVYmtV3lUsGeKilwf3iIAAUOB7kDhcKKAayGfdSBDKLPcrsNm8m5PgouT86aM+FpHtcQaioCbn0PKG4JX4wQy85AdZ7Ra5xxqflvkchy3Oz3i5FMaE0jpjRqR844W6fQDL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964092; c=relaxed/simple;
	bh=Vv4GoVLQbcboDBK9JF2IcWRLvU3UCl3aQM4sIGzFBNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ff5lDmbWKNm3TCP9vba2Cdhxh2CiykR4jFmFeTFXWxACpf8iDtFZAwNPIEc0hQatj1idkniF8EUQ2XC8syOgAJ6IXywWpobGlRXJ7Na2K4P3/CoL+VkbSLPYprtigPKS/zTXmZ2urrhX7pAdBKGEBYDKxm7zvjx3u551MNECQ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HTC5bauZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-559edcee47eso3120480a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705964089; x=1706568889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JOEb90GER7mzhUcx62Qpw2hCQjGXAjl9en9ZzJ8SQUY=;
        b=HTC5bauZzFgfwmwUWbkTaKbGr5SLZegCsHkpQ/SvLm9jFvdsSO8N4n8gIK9Bt2stAQ
         NDvcCSZKVE8H9Fl+CFtssBoVBaRmkUpFLYDW/E/ueJoON/yVlecfKjF6cTFUaOnIYhoS
         rI23U9P/hYluSReuBMKbSCBUGCvbpXrxYg8Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964089; x=1706568889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOEb90GER7mzhUcx62Qpw2hCQjGXAjl9en9ZzJ8SQUY=;
        b=GVa1aJtm6ZkUIjwv9ixXDp5fwknY66qQllBvN8rEKIntT7CAyHLkrY7SW3TbezkClU
         9CSBtGpM/AjnnpS9T2bIejHCwlAqTZaU14KD+PiJJK78n1YMDEvbLCgswaNNzlZJrepo
         uJ2MbAWnWHGgUAYV6gisEszZSWIEwJkhRewk/JOUDKnD5i5bMT9CXGwuoPkvCLceHlSJ
         tG1Nbo1kWCT3sD6+J5B8R3lz0yidR3JOohz2fJiquZwE3tUBr2KDmiKjRpg2gCENOj4n
         1RVfcG7UQ2TYyIEBxC86+MWp9RbkUtmh+tB370Th54TpgxO1jDq/XJBrK92pM1c0W9dU
         7lpQ==
X-Gm-Message-State: AOJu0YxmAqPR6kDivy3Ob11JUh90Y2DFS99MAsC1Z/sMVromJ3ZI/eP6
	Oruwfd+XBSuj5/Fma/adpHUt499SZYwqf6lqblkBjiStaE2vmdozTVvy3ZCwt8haTEbBxGGXM3z
	SU9lJaQ==
X-Google-Smtp-Source: AGHT+IElkiBOQddir70ASLbwfEdE5HO6PNCchmLHgKPwAaygk5eD2b7nJ5/88sApHcc9n5dWBxLltg==
X-Received: by 2002:a05:6402:b4d:b0:55a:9192:a56f with SMTP id bx13-20020a0564020b4d00b0055a9192a56fmr314674edb.26.1705964088867;
        Mon, 22 Jan 2024 14:54:48 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id ek7-20020a056402370700b005594ad2235bsm10427538edb.12.2024.01.22.14.54.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 14:54:48 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eb2f3935eso4344135e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:54:48 -0800 (PST)
X-Received: by 2002:a7b:cb97:0:b0:40e:8bb2:6bcf with SMTP id
 m23-20020a7bcb97000000b0040e8bb26bcfmr2474196wmi.151.1705964087839; Mon, 22
 Jan 2024 14:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com> <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 14:54:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
Message-ID: <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 14:34, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Bah. These fixes are garbage. Now my machine doesn't even boot. I'm
> bisecting

My bisection says

   1e7f6def8b2370ecefb54b3c8f390ff894b0c51b is the first bad commit

but I'll still have to verify by testing the revert on top of my current tree.

It did revert cleanly, but I also note that if the zstd case is wrong,
I assume the other very similar commits (for zlib and lzo) are
potentially also wrong.

Let me reboot to verify that at least my machine boots.

              Linus


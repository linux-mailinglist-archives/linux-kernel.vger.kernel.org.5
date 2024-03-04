Return-Path: <linux-kernel+bounces-90998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50498870834
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5E5280F15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2166027E;
	Mon,  4 Mar 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVO9AwN1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254160267
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572995; cv=none; b=Gf1RJ2vvsuWpknC/jDX94YWWNp+dUGw8dBK3iY+ntE5BDRPKiNchATt8oZWt2ZoOZyDVpEGQBPzYcb80KaqojDhJujRtSAytbZ7bW6uXw/treditNKhDgtF6dAFg+pjdxKLxhhhgG9EKecVDOObwWgtEt+STi+pQ2wvndlYNUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572995; c=relaxed/simple;
	bh=2AXGixQ7Gc8HjdKyBY3Whs9KBXsRK1tfn6h6cRM619Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlgSlA4UzQQq1OhVlqblWtzC26hPc16HfyKfrqNKN9Uh14dxQWpmg4jjnJnWj+WrOZu1oDPc/eeeRoK46vwjgJXuNPNRcdj+1tg7LzlBlbPsbc5HVqU6LIrsSNjin7Hp/we5EvLePpWH7ziTMb+Z7KjTbdPj04hp3VhbEXeNE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVO9AwN1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dcd07252d9so431135ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709572993; x=1710177793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AXGixQ7Gc8HjdKyBY3Whs9KBXsRK1tfn6h6cRM619Y=;
        b=kVO9AwN1XqBKB6TtW+wnexVeMilsO598kfJ2GZlwYrhhVREP6ovuGlyPm/6bOfAv4j
         +HEjj31gHdvX2npn7St/3KMhmWpWt0YKJF0PbX7V+WBDdEW3/31FlgkYKLOCS5vIXeDh
         bGXIik1bISsahBvUH5oUcJkHXvnZDT7PrUVDh4cPotLEr0iwjstCfu9xo+Hfd18ihrG5
         W3yYCq+T8tPPUElF937uZI/itK2VTtDySU1+3/hbZBeCV+ZMebl0erlfz9Qy8eK4ScLn
         gBpuzE/wqgbUPgfZPBlR0Um7TImuOFsK+npW7NIJRHq9DP3OjlDrE8GHSVOaw8nd1A8l
         FVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709572993; x=1710177793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AXGixQ7Gc8HjdKyBY3Whs9KBXsRK1tfn6h6cRM619Y=;
        b=jrM3JASuGCJbe2m9UxamIkYF4yDGUBF5VtUlJlJT4eCViivXGDs13UzNObxk0A1znp
         WMFThxFRyJIFOsVRbCazCmcQhfVCWBFxYGkB4r207YaGikxoJeTy4Bg0UuE8ulg5r9dw
         z+vYKoqlUOMwX+AowfOc9Jeyb85s7f6Co0WW00yiSpwowfO1pU0wKJNnJwRIOksyFNFk
         rneW7vibpYyLF4PFViJIpYI7VeeXtbtUnkAzNSXJgL/ZxkJThANJRpHND3EqCMhS2GOX
         7mfGrLrA1PgTIegwcRaiav8W1Ppl9bbQl0rxH8M6aoJQ5tNHFHT+ussv03FECy/XO7U5
         alfw==
X-Forwarded-Encrypted: i=1; AJvYcCV8cK8Eh7S46gEAt7jspiqGgPi+mSRAMJ4VP4pwia8KVmocA3sdcaW7dTc0vwuOf1FNupJ0gwWnJ56oCt7WDSLpUkPvzDxfbLKAotKE
X-Gm-Message-State: AOJu0Yy1X/pFT/I8BNTyuQSAFfI8daN2+9BuRwRUevdXhWh6swqpJVyT
	OkpwqJsI4rgKTQOJpwjwmVHBn4R/bE+OuL5AU+RE0hJCVkUOWmBB2KFMUrMtBUyZweCuyxYzs9G
	X+qERg6k5YttPQhu8C6K1by8qB5MFnDgxuTEf
X-Google-Smtp-Source: AGHT+IFKjskUOj6278amt+2i/iRaGbWnqwH8V8ARQXyWAa4I5jxF0hWUUBHSTDwJLrfzllQF5r4CeHTssO8S/qZNiYE=
X-Received: by 2002:a17:902:ecc5:b0:1dd:7db:69d0 with SMTP id
 a5-20020a170902ecc500b001dd07db69d0mr266118plh.11.1709572993014; Mon, 04 Mar
 2024 09:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com> <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com> <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
 <20240304-rigorous-silkworm-of-awe-4eee8f@houat> <CABXOdTc4MXcjwgGuJb4_69-4OFELD37x0B6oMr=4z=nxZ2HPXQ@mail.gmail.com>
 <20240304-ludicrous-grinning-goldfish-090aac@houat> <CABXOdTeDydWO9mf2yxWjjebHZ1bE=R2HPs1P4XYwNhzznNKxmw@mail.gmail.com>
 <20240304-benevolent-brawny-urchin-0af0ad@houat>
In-Reply-To: <20240304-benevolent-brawny-urchin-0af0ad@houat>
From: Guenter Roeck <groeck@google.com>
Date: Mon, 4 Mar 2024 09:22:59 -0800
Message-ID: <CABXOdTeza3ZJRO7eexp8evm8o1B81fw9cDQbE_nHwqhufMCfGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
To: Maxime Ripard <mripard@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Nikolai Kondrashov <spbnick@gmail.com>, 
	Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, 
	gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kernelci@lists.linux.dev, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:09=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:

> And singling out DRM because it regularly allegedly breaks things on
> xtensa or m68k and claiming we're not taking CI seriously because of it
> is completely ridiculous. If the all the subsystems were taking CI as
> seriously as DRM, we would be in a much better place.
>

The failure I reported as an example was on arm, not on xtensa or m68k
I'll disable CONFIG_DRM in my build tests for xtensa and m68k going
forward.

Thanks,
Guenter


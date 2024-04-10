Return-Path: <linux-kernel+bounces-138066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696C789EBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B5F284005
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C50113C9B4;
	Wed, 10 Apr 2024 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtN6lt0D"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F513A8CE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733573; cv=none; b=DO+0PGtJluh3s7aQyKmRGXROP5YbqzESBwdQZ7nGYMx34nLm0mvVlf+vbU0kRkqHMr21i93edLe1DiStcLwRRMcLLuljAderr+nIMpPxDH8DuP52ROZHEs28ldObfahMhtA7KAfdswxDtrt0aqJf8QvAqRudweiiSpAqieyaxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733573; c=relaxed/simple;
	bh=Xk1Admx7MIzrGsfX8zRP0T7PyL0wgFiVGzBCYwXkw08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXHOzWVWGbVjBPsUM4vdtq+etoW/3dGv+YJcm+tQBku3X7xWkLmN/zmyI+muyVDDF6WiRFPZRS0iT4mwn8V1zOuhtkA3pZAYbcXablEAebFwUi5rSk79dqAti5SDE2lfNiFDIqJ66uHVJQFC3lPAuCfld6nLKpH/hr9TwjVC4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtN6lt0D; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so8140661e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712733570; x=1713338370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk1Admx7MIzrGsfX8zRP0T7PyL0wgFiVGzBCYwXkw08=;
        b=dtN6lt0DR1N1adbmsR6MOpTncWevqXD++k5rmiLVRpaB0AHJWCl5Nhsd8mXKoV+86w
         r5MAMiq2yDG7LtLbkQGhRlL1UW437RP9FFmE/da6USqZaFkoZJo8emMaKGlVdjZ7uAFD
         dfyJx+hyD7vSMUyohbUNbbRsnjn9ChHA/GHIw6nmIevr4I2WUF/FjO75CNSSnqsPcDFW
         YBarSqXhNuCUEWdxrhrabNHJf6ESbi56J84twjUu5HTMpzjGkpy0OiKjjq2aIk65Mr3z
         ocYM8nfxBbjD3kTs74LP6ra0X12mPo5HgroPN79mNeWbalTDbH5vghccqwciDYdYkMDQ
         bDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733570; x=1713338370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk1Admx7MIzrGsfX8zRP0T7PyL0wgFiVGzBCYwXkw08=;
        b=YniTXhIOCHs0wSOnXzDK6cbFAuGP/e/nFmsixJIQMP/NoQoY7FK02Y/VQUtS9KhdSx
         6jailiMEFgFHqkaKsWC7g34LOxe9XpN8Z/WvLWCrWkY2Mqi0ezu/a+BGa8logVon24rq
         PVGg5wJO2FP7jYNF6HEdBPZmJVipk8xhEhZWJXXWBmHZsUxzultHMMHpHsg5jwu9CY8S
         gd2lWbXNRVY93GEToVreHhD0N1uMHY2iSN8YrnTFk1cAu3YS3z4Iyx2Kn7+yQCNq151Z
         VitAET7r4g2r0bAxiAdKZapJLl4AbtbBL5hLl3ildCbuwJda53V6rFrs1PAxvjBeyYrw
         3Rzg==
X-Forwarded-Encrypted: i=1; AJvYcCXtTJ/mUPOZGt3p98Rz0xh671OZWp/FmEW1M7+R1xp6HJBGK8jx9Ze5JGudU/DE8q2Hc9DI8SlC03GJuVZwR7uiCYN1a8ISv9oBnYBf
X-Gm-Message-State: AOJu0YytvNUqbh/2Ng3CyRHEf38PSiFObppZdOyT90+0OmeGUNxN4Bsd
	/h85mMzCOw7uAj9ODiAGd9oKQyblsf6s2z156+ydxHya3qywOU0GNKe6XeyEXQh9++5k680uPuu
	7U6poKSAMXp8GiaEkhfE01UAXtdJGDj1B
X-Google-Smtp-Source: AGHT+IFJkOM+c2FBQgti9Bl4CgLt73ULYBTLadRBlGSY4yEmzpllD4ijLFUz0kuwMwcVPps4VDyp3PRKDEGxaDdg4Us=
X-Received: by 2002:a05:6512:230d:b0:516:d27c:f6c6 with SMTP id
 o13-20020a056512230d00b00516d27cf6c6mr1250477lfu.35.1712733569630; Wed, 10
 Apr 2024 00:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710915736-31823-1-git-send-email-zhiguo.niu@unisoc.com> <ee24b313-a168-471e-b60f-1404c69e61a7@kernel.org>
In-Reply-To: <ee24b313-a168-471e-b60f-1404c69e61a7@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 10 Apr 2024 15:19:18 +0800
Message-ID: <CAHJ8P3KaQF8okMOyagH80+BmUUZ=ENSoAApz2H-p_1=Pu5ZTbw@mail.gmail.com>
Subject: Re: [PATCH V3] f2fs: add REQ_TIME time update for some user behaviors
To: jaegeuk@kernel.org
Cc: Chao Yu <chao@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk
Any comments about this patch?
thanks!

On Wed, Mar 20, 2024 at 5:33=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/20 14:22, Zhiguo Niu wrote:
> > some user behaviors requested filesystem operations, which
> > will cause filesystem not idle.
> > Meanwhile adjust some f2fs_update_time(REQ_TIME) positions.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>
> Reviewed-by: Chao Yu <chao@kernel.org>
>
> Thanks,


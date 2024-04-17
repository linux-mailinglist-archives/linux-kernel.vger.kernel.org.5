Return-Path: <linux-kernel+bounces-149042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DE98A8AED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC91C210B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D2217333F;
	Wed, 17 Apr 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2I8vo6dq"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A3C172BA9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377993; cv=none; b=lq7gacprPz5XKCKniBi/yMtX99yDMBKG40I3e+kpfhJX/jyp6oA7mdFT8HBnSWQ45n8JvlAOZK9pj28A5ObynXbujXqOtFn4GnlNUU/aKS0fuLLa516AaI1kuwpvoT9x8mQAFP+jeU8UV1qPN1FFoqQHhbAsKBwXjQXnNSw+fm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377993; c=relaxed/simple;
	bh=E5Lt+ffHfRg8xmAsCNmgFbUyro5LbYYD1lfR4zsupLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppf4dBS9kYtnjp4Hsjq73PvwwXJV31RcQHc2YBYb5GzVKjIaEWmv6rvaHLCYfEjcz54ik2O9Hc8Aunl1QS1rbDqroHu9VnPAaJBccuaPRp6hSHTu5uaFNBmtP2tk3Pmo+yZuJR4/Wnr4jB2yKJI/HmB5VfFPkUCMdDxbhoKYj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2I8vo6dq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso7339396e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713377990; x=1713982790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5Lt+ffHfRg8xmAsCNmgFbUyro5LbYYD1lfR4zsupLw=;
        b=2I8vo6dqpHYJgCyKvc7dwSSaxfeax4S90sVL9Y+AX2Ah10np9gzQ8HA51ZMGTFiZvB
         jmi04F0pWpnJEKHDm+X2vRQMMwYTOD83eJhJSF60dJUFwGzFmy6NxuKmWZDrvom2J98F
         EMJutou7dT/pUkD1KQVNEnx6qVkT1sNKT5lggRRJFzjkD0HpE7ShXVdDHfyrpJwdSSUX
         kB/HMBOi+YePp9mnPYvFA87sZ0Y9hhYFRzu/lF71osZZ9+HBJHHOAopnnofP0ey/G8M4
         5OLUmy8D9ckZLReb24ONklv077bTm47WIXCE+MsFCizu6RYYZARHibIcDE5HbyYUHoeD
         d1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713377990; x=1713982790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5Lt+ffHfRg8xmAsCNmgFbUyro5LbYYD1lfR4zsupLw=;
        b=fz+B874iQGhZgx4G+sxxE51JCBB7iXvzoHAE3IYnf6IilySsY3Faxf8BXqFhgI4J9O
         Cy9QqHafgt4SxKqasJAdf7SnfN7F1DYmVl5uTBu+siBUvpf6BvxJKduprCIahURk0Tl4
         FpCqk8lv9A+qBZv7nmvXeLV1gG9rBafbO8s4ulSiKRLHdHDUxTkwKBAU8s+JZG2r+ZZw
         1Rm5Zsi3GhmuQR1hRhLV1hqY0aGO39Y8fNqbuqqDQbLhLTZTIkxlbu6Wakg1rXaN4PY9
         ftTW1B057Ws2zfUD6fN70/Udow0oTUBIud2BtxvaK4HBY+G72RpLqFLolfZ7o6AoPbRL
         pIjA==
X-Forwarded-Encrypted: i=1; AJvYcCWAP/bHxhdxUGPtFwaNoHu8MQpfBtWUpQP3zswoZ6A+7C+pVmVq73pA2Bvl/5ShwHhwoBPdPC7EwwgsEm9I0I4teGTz2mUgWAJyhBrj
X-Gm-Message-State: AOJu0Yx4+Sxd4yHnJYEpH/DMQkhGv+EQgTQSdl+49FDKtpev2cQxt/ij
	gZq2s1MmvUao+j4lkrcEbPpUEoqVsawHqJX6ZKrF7JxCzszZThHy6qZLiM1Avah4zBz1e2Y5ga+
	LHg8Z/+Qhu+RyxUOI03ZDbvFLHk6/DvinhC2sfA==
X-Google-Smtp-Source: AGHT+IExB+6UnFXh8LvppjsLRD28Zb6Ma6bPnzodalh1mlBjN3At7SXOwFqlauJ21IgBLjClpCHrPxVMBB6VsGrO2nY=
X-Received: by 2002:a19:9148:0:b0:519:a55:7ee7 with SMTP id
 y8-20020a199148000000b005190a557ee7mr60964lfj.26.1713377990047; Wed, 17 Apr
 2024 11:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410072102.1200869-1-andy.shevchenko@gmail.com>
 <ZhpC3lLD-BHqJEZz@ishi> <CAMRc=MerqbYue_uubSkr0ta3wr+yQxfFMfk+vAUZa+C2oR+udQ@mail.gmail.com>
 <CAHp75VcofgAQLFVLdsA-A1AkjVzQBJWtam=w00+z9-rueZyv8A@mail.gmail.com>
In-Reply-To: <CAHp75VcofgAQLFVLdsA-A1AkjVzQBJWtam=w00+z9-rueZyv8A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 17 Apr 2024 20:19:38 +0200
Message-ID: <CAMRc=MejJTnawn1=_x9Va-QJRctjoc3TJanVqQ0uZbpmDzpyjw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: sch: Switch to memory mapped IO accessors
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:05=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 17, 2024 at 12:17=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > On Sat, Apr 13, 2024 at 10:31=E2=80=AFAM William Breathitt Gray <wbg@ke=
rnel.org> wrote:
>
> ...
>
> > I applied it as is, if anyone wants it, this can be sent on top of it.
>
> Thanks, but I assumed this should go via my tree and as PR to you. At
> least I have it already in my for-next.
>

You didn't respond in any way about picking it up. Can you just drop
it from your branch?

Bart


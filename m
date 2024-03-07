Return-Path: <linux-kernel+bounces-96171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE07C87580C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AF8B25C04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE013956D;
	Thu,  7 Mar 2024 20:14:30 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B61DA2F;
	Thu,  7 Mar 2024 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842469; cv=none; b=XBhPC2iIfV6f7keCgITHLFtoEWsoo2tr5yobftxyJ3pljzDl1yA5iV55jXzxaoh2Eg8FQudcNy9d3Ns9oxFFyJ5NV9LvK2ySCyNY1B7Qw3NV688QadPZgs7JmNyxHyz8FQmSkMSAB5YFxvG7aI4yvXWFpfy5i9f+509gF9+fdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842469; c=relaxed/simple;
	bh=UGJzzYkfDdKkOjnlty7YFmm4I4PFag7shNz/wSGmHls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1MI9Tr3QmdT0d1BmtH4MxPb9yZYIbnthFxRIlSdZPfxymTmxk+M414qm+urq7fC0sQ6mF5UtQNXb1BALST0F6mUIUjy6yDo85RgdqI2nKsVyadA0Ogeh9NqiFnVDp/JtjVxUX9OpSNK5LJECnr8EklQhc11ncuUFx41/BulKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2b466d213so253905a34.0;
        Thu, 07 Mar 2024 12:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709842467; x=1710447267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ1nk67dG3LM1VN+vZEbHn5Ol1vo3NNvxceJvm4ef4E=;
        b=Z7nkiFuQjVNUMjtWMqQXID5DQCXpRc7lxhxjcBzXY/sSzdMS5bjTcdIX3srtkRLQIg
         wOJkzyy25Ub/Ts1r0B4uSqjJ0Jvi6q3VQvjxm7KFJbNtKEE3n3py5OqUFeM+mulQJ5ZA
         vnvUtRAG6d+YdnjuQMKT/Bk/cWFQWbvSUr2AKIz/riSrpbTB7nt5H34cvxeIPP/dS0od
         lB3JUuSFlBu80j9wclvnxfaI7RPM6sNuXWlmDsWFVhkP1jGtJ+9zDXShFqUlOFhPNJqa
         4Lo7veaw+bSsjhI1WsukdvsF4KogGwu8h1rEJz4YXpD35yi4BoQ6PvaoWckzhb9HiKyz
         zVUA==
X-Forwarded-Encrypted: i=1; AJvYcCVNrlrYa7KM/zGk2LEEaoDFgg/IHsdp622bnqrplk0jl1DNpCxOaLCrtYafS/qTN0J0Eb7WCh0auvspxzwJ4GpU4rKYwU8D8mEvcyWLaMjC+gXhEudu5EG0b1gq1iugSvN5bcZfmuE=
X-Gm-Message-State: AOJu0YzKW6XXLyGLnFEnofQNGMlB+9OabyNInC0qTUdDcb92ey+Czpns
	au4Kt+bIL2m3cDQ2de2j281+WxUDvWABE7HQrYuM8rrIobfiCF/YkVZ3uZ9wHcmtaqQQHK0VBbz
	vad7yRwbdhZqqxi/WBlh/O75KZ/XKjbgf
X-Google-Smtp-Source: AGHT+IE/HMP790FSOKOzWRMjrESdSTJcpXREuN+NywBz976YEv9PMVM63tFwzwuRUFXFPNFgiFVS7v7KQcWFynRuIHM=
X-Received: by 2002:a4a:c80e:0:b0:5a0:2cbe:43dd with SMTP id
 s14-20020a4ac80e000000b005a02cbe43ddmr20401ooq.1.1709842467204; Thu, 07 Mar
 2024 12:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6eeb5f78-a38d-4f00-abca-db417d08d6fe@linuxfoundation.org>
In-Reply-To: <6eeb5f78-a38d-4f00-abca-db417d08d6fe@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 7 Mar 2024 21:14:15 +0100
Message-ID: <CAJZ5v0i+DOikYLA6ZyfJHptPxpH0UVKzLBT9QGzingYxGZQQ-w@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.9-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Renninger <trenn@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Wed, Mar 6, 2024 at 9:49=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower fixes update for Linux 6.9-rc1.
>
> This cpupower update for Linux 6.9-rc1 consists of a single fix
> to a typo in cpupower-frequency-info.1 man page.
>
> diff is included.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de=
0d:
>
>    Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.9-rc1
>
> for you to fetch changes up to a114d9f1f2cf4896d838ab0a9c30a75411736829:
>
>    Fix cpupower-frequency-info.1 man page typo (2024-03-06 09:27:57 -0700=
)
>
> ----------------------------------------------------------------
> linux-cpupower-6.9-rc1
>
> This cpupower update for Linux 6.9-rc1 consists of a single fix
> to a typo in cpupower-frequency-info.1 man page.
>
> ----------------------------------------------------------------
> Jan Kratochvil (1):
>        Fix cpupower-frequency-info.1 man page typo
>
>   tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> ----------------------------------------------------------------

Pulled and added to the linux-next branch in linux-pm.git, thanks!


Return-Path: <linux-kernel+bounces-125066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC8891F83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAF1288864
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915A136E35;
	Fri, 29 Mar 2024 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Zl/ML22h"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACF1369A7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719091; cv=none; b=smJcb27ENIAeRAMqSizIh8AhrupOMZ9J8TYMu9c2KzOSpXNIPDkMD8ld31xpCXf7mt0/0F7i8GvCJXiPal+5fFZn8QUkh8kfpuV5ULimkzTAUQ42Kn4dgkny1oVsLgipkcplrYsERrkzYTPIOMUft2xdrVTXfNk/mDR2vBI7vBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719091; c=relaxed/simple;
	bh=6QyiqZgx66IrMCmeiZhxZQ2qj79CFNrO3JaiQuSARUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaYgn8ORYw0ztHAyVIh+95cfmCLinkNCBg41CVriwILX1HYqlDUpzHHuzgsHrHn34CwtdQBg48b9XKCWEcwRjeOJYwj0pQnBup5xSsTUqIG3TXAR2hDYeQs4BB39livADqWhOTMCavkTTQ/XkFUbi28pgczJF/ylIQ3tOTKZKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Zl/ML22h; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d700beb60bso37844081fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1711719087; x=1712323887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QyiqZgx66IrMCmeiZhxZQ2qj79CFNrO3JaiQuSARUw=;
        b=Zl/ML22hf24LEZO9lqnzyNb8yPD51XTIjAaHWsw885Ngx41KXsYAoOL+FX7SAqMTYl
         6xI3NUvnFWV6rnF0Ul84MTF6VkmuDhaGahA9WT6De+0KaMXdgHQqqXHzGn1ND3Qw5OaM
         hHh3azGpKZCUGvp9/KUd2vAI2ckE/nJrmdc3QfclkHw/3SqAmT7r9JxqM9lJBCAXpO82
         lez1Lc59YK8chw47MX0xVd95l0XHjP0KdQLf3zXn9yJzxeR8OJprDIPJ6Fi9xjfAncZH
         3+g2ci54TGpbjkg8V13iUF96Ca2dA0p/9ST/Gm5j6k26/OaRZ0omUFEKpOt7Od253l0n
         9MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711719087; x=1712323887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QyiqZgx66IrMCmeiZhxZQ2qj79CFNrO3JaiQuSARUw=;
        b=si4gejDnpm9ZfJ/xR+mWKbGmWYJNVKBXDzlbC1GM7CX0d/MabO0Rira2ztUnu1XQkP
         Im9hto6dHrFd61cYsvka2zx4ndL9uHzab43n56NhavQG31ro2aep4t5X1hOQiEexgKy9
         rj9pNZ8nt90aRrlZAkZoMzqzVDYzLIXw8wQxTSvy7WzZvKapfHpyMlPzpU9nuvPFiU22
         CgCsCfjNhDAHA4kbNTSJLMxOTvsyBsamakJO12zjJ5YEpgmhvBVHGjn7QIx/bqYyAiRT
         X/MCEKNnJCrSN4Q/Sl4zGLP/y4AYJgOJZKHE/amUSun+4g/VE8G2SAETq75zPFoj/Ztb
         k8ZQ==
X-Gm-Message-State: AOJu0YycsmDhlRMw+G2Paqn13ebFnQbZ2zG272QHobUlgU0gIbFqfvNM
	RdhtF8TDWE5FZ8tMT2MLTW4RLgUQ04P3kmP5LzxOISrsdP+V2sx4avKpsguMOInJQ5sKhmiup/J
	VZHNXp+pgm2h8ZQJ5zm6JipkWtNnWJcbmwz42iGOkyvCR1kUV/vk=
X-Google-Smtp-Source: AGHT+IEF+GUPuQs76kFHWRkmcmlohYaQ6VJUUNnnv0bjAes+xMpnyh+kY/5o+1Koz+D9PiH8l9q1s3u2TalIzAnBK00=
X-Received: by 2002:a2e:7a04:0:b0:2d2:d35f:4ec4 with SMTP id
 v4-20020a2e7a04000000b002d2d35f4ec4mr1666882ljc.14.1711719086962; Fri, 29 Mar
 2024 06:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209164027.2582906-1-max.kellermann@ionos.com> <ZgF2khndC_QTu5Bw@smile.fi.intel.com>
In-Reply-To: <ZgF2khndC_QTu5Bw@smile.fi.intel.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Mar 2024 14:31:13 +0100
Message-ID: <CAKPOu+_TDeMoEze6-yfm2Aqam6E02hpEXX2gUAdt8hxQ5bwttQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/35] Fast kernel headers: reduce header dependencies
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:06=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Are you going to pursue this (with probably refined kernel.h approach
> as we have Ingo's patches and an additional split that is already in
> the upstream)?

Yes, but after some feedback on this patch set, I decided to limit the
scope and only clean up mm.h for now; this is the latest post of the
mm.h patch set:
https://lore.kernel.org/lkml/20240312094133.2084996-1-max.kellermann@ionos.=
com/
v5 will follow soon (with better explanations after suggestions from
David Hildenbrand).

I have already a branch that cleans up kernel.h, and I'll post it once
my mm.h have been merged. After that, I'll rip out more parts of this
old patch set and resubmit them in more smaller patch sets.

Unfortunately, feedback on the mm.h patch set has been scarce so far,
and it doesn't look like there's enough interest in merging it. But
I'm not giving up yet.

Max


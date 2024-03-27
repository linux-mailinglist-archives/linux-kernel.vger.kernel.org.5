Return-Path: <linux-kernel+bounces-122185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FD88F335
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0290B21281
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9909A154423;
	Wed, 27 Mar 2024 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jY01f4+q"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522341534E8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711582355; cv=none; b=B0PkRHFRToMRqDNIoZnvRB7WYKsE7tka5yrPA5HSY3tfXUN4j5Qp3xDETFNdSevPil0BhmF9q/+MqF3r8bsJSvB8vbA5yTabOW8zcrJ1ng40ZMWYZa8pFHMVZF34SKTs53wdK8HAmixgxKs1XqodbpPAs5elK8c0TqALLnjf2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711582355; c=relaxed/simple;
	bh=4lKPLbh212nn1J3R8IMqlEWT8QVsO3oW2MM/iClklVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCLugdIRCmo9wxl5d++hcrSyrLMDP6KdkCP9nIkAWWq5ahhZh3xa6U/mlGxb5G6s0ti2s2ravmo1luQWlriry0xx0eTLxrxkqmSJ6DlUMSh9MJL26aBqOmPEJtXHoSTLhZHhGkKJTaLa+cFZgQKwrFT2jENr8mBz6wmpovPfwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jY01f4+q; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-428405a0205so85821cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711582353; x=1712187153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzRgd4Lzb951VCLO81xH04jUHM3EgKoI1UuVp5UFbtA=;
        b=jY01f4+qWD71l2GInHO8UA+d9jBvS5Dvkq9nudrptIGytrtlrP1x3HPMf5orfVWAFt
         BuG9MKrPYop/dhzxzZs7pCwkUW8kHhxh00J95EChtL5qmtVa1pbXTQNqMOZezcjZCxvC
         2IeADjgezEj44KrFMD8MVngu1tDIKoLf/OvVwCE6BZiGPzZn6k8B54ok0zp6VYHr99a2
         1jh0UGELxsb0VMNgxNAiaxa6wkK8RhN9IxxhxZCBBvyebFHaxIy5dDR6q41SoyjE4bdK
         88R9TLJ/tFJTnsOleOeUXMpk21Ml2VAWvuLoYi1qZX5eJN4yNCFHxc3UwL25SoT6xDYu
         O6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711582353; x=1712187153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzRgd4Lzb951VCLO81xH04jUHM3EgKoI1UuVp5UFbtA=;
        b=vEUXY1FI6g8TGz8mwk5pL4FEFIniJzcM3Wc7XHLQaUv3AQu3yTpTb49277sZPUil2M
         e9NzRqqkAKch5KnCdQ1s4sVO7yqmAwlScFPTG55sAV/AByVvOECtKgLp0gShN2/BELNO
         NHHTWBo8RS0gb7cYbZyvsEsP95YD0LQ57d0AHhLX22hoeyK6OstiY4mFs3o21Bqwr1cC
         52Ds4KMhiaWGjz+D6iEIGRYjrmwaTTBoL8AlDeCuIyxVowxv9S/aXgHa0mHkoouEGMnA
         1VXgJJtxkoqJWdhJ3M0sabx2SesY2/ZnDFPja20NJK9ZIxE5o3kYlU97e+bS5N/vfH1N
         A9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCX/pqtTR6kqmmln/70/gvpCLb9mh0i4UVER2us/Iea9SdSkCZw48v4fc0tZBY0tkUoh26BbR8KA+FZA/OJFFCN5z08+4FNlYhewrrLl
X-Gm-Message-State: AOJu0YwhhYFWxJdsHjpipIy67o2KCg7fEX+SVs4yTt0LaLCbCjY3vJuL
	FF1V/NPGyU6nNwDBrAQgT2RSeyUqwyHYCnJCDavmCP81HZZ3zFq/ujakqvI6aLsFUhnGXzC24Sg
	ywERwP1KfbZpVv7aYG7t6M9T2ZKOX4Gxb7s1p
X-Google-Smtp-Source: AGHT+IH3l1ArfOaKqAb+rx+5i3b79wDzfvkqQHOHsJaPejnm3xgjV3o8I7pfl2e/3FeBq1yfYGAUUUedO2D5/mlX5QI=
X-Received: by 2002:a05:622a:5c99:b0:431:5aa3:313f with SMTP id
 ge25-20020a05622a5c9900b004315aa3313fmr57222qtb.11.1711582353081; Wed, 27 Mar
 2024 16:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326100740.178594-1-davidgow@google.com>
In-Reply-To: <20240326100740.178594-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 27 Mar 2024 19:32:20 -0400
Message-ID: <CA+GJov6wuRDu2JiUsw0qtWehpbUPnxM=fK-dJxVMtOr0TejP+A@mail.gmail.com>
Subject: Re: [PATCH] kunit: configs: Enable CONFIG_DAMON_DBGFS_DEPRECATED for --alltests
To: David Gow <davidgow@google.com>
Cc: SeongJae Park <sj@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 6:07=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> This is required, as CONFIG_DAMON_DEBUGFS is enabled, and --alltests UML
> builds will fail due to the missing config option otherwise.
>
> Fixes: f4cba4bf6777 ("mm/damon: rename CONFIG_DAMON_DBGFS to DAMON_DBGFS_=
DEPRECATED")
> Signed-off-by: David Gow <davidgow@google.com>

Hello!

This looks good to me. And it takes away the issue with
CONFIG_DAMON_DBGFS. But since this is deprecated now, should we move
to the DAMON sysfs tests instead in the future? No need to let that
stall this patch though.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>
> This is breaking all UML alltests builds, so we'd like to fix it sooner
> rather than later. SeongJae, would you rather take this yourself, or can
> we push it alongside any other KUnit fixes?
>
> Johannes: Does this conflict with the CONFIG_NETDEVICES / CONFIG_WLAN
> fixes to all_tests.config? I'd assume not, but I'm happy to take them
> via KUnit if you'd prefer anyway.
>
> Thanks,
> -- David
>
> ---
>  tools/testing/kunit/configs/all_tests.config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing=
/kunit/configs/all_tests.config
> index aa5ec149f96c..f388742cf266 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -38,6 +38,7 @@ CONFIG_DAMON_VADDR=3Dy
>  CONFIG_DAMON_PADDR=3Dy
>  CONFIG_DEBUG_FS=3Dy
>  CONFIG_DAMON_DBGFS=3Dy
> +CONFIG_DAMON_DBGFS_DEPRECATED=3Dy
>
>  CONFIG_REGMAP_BUILD=3Dy
>
> --
> 2.44.0.396.g6e790dbe36-goog
>


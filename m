Return-Path: <linux-kernel+bounces-61506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0226E851301
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358FA1C21F18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B313CF43;
	Mon, 12 Feb 2024 12:02:09 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038823C68A;
	Mon, 12 Feb 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739329; cv=none; b=pt7uDO+QXw+7qze7WCksetJmi1aqC1W9iYD8mQYmAxERIR/isoA5wHwvRmeJBT2RCPrtHwAvEaQ2QarFfCUw9O9r8IXWz4gwBFRzUBmBOgKo5/8BHXAGi8K9qyCa2WQqUT0Uv06oKp9FeaINAGikSYaSgSXgv0IqkKOEVoT029I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739329; c=relaxed/simple;
	bh=gDhbOtYCwuVqnz0HlPT9ocuZIvCTWklfNNaFpflz1y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqrDSCSkC8UOwO/anTp1ArHK/fals5b7Hqi9JT/NwZoz5pQ48WRRuSrk9DYAVLkDTF6HwUjYxrj6jtlE3vkmIuRr1ZsWYgjxoY4lYzrGicVy3+zCsG3LJWi0w6VKO6NAhPQnxQWyfaz0DqCqUWA3pKjqjRWzzjpuLkd7JEwsWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a134e29d2so560385eaf.0;
        Mon, 12 Feb 2024 04:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707739327; x=1708344127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDhbOtYCwuVqnz0HlPT9ocuZIvCTWklfNNaFpflz1y8=;
        b=Jy64iNJDmr5RIUoIEDP1mP/Kwk8LKxssy/RKMhvJqwtaTwLPzTAOrzhSaFM6mRR8Wb
         OWjPHLZ83mQ3bMbc9cGGq/F+QUc7UiaEWOx0eUVkt3J9YdKUWO8Z0aBqq2K2ROkJ+Pa1
         +FGTXMf2YM+KZFhz1jRojQKIeevbllEZfVOC6/0GTaqWQPGfGBerFa0UCmTsSwqYbxqd
         czw+I8zOjTHli55V6QAtxhMt9HhY3Bx5oA0SqCu3GPOa40wp3r2D4PP18haD+LwlVc7h
         cVk2skVr7YLTGOPV9XTsRNjT9N+QmyqNCaaS7wn83zWTovaahWV3wjp0Kyoz+dpDrSp9
         LNyA==
X-Forwarded-Encrypted: i=1; AJvYcCWFebHSQL+Gd3fPPxLIXiQRicMEasmVc3Iaupl+xXsg3LkdkgidZgOvK45WMoTwzr6QpytBxZ+PcmgU81CVmVxYSZM7Mae0zgv4zE/oegehgsNLq1q4y/RhtKT/4hmkAhn9Mvqkc+XENb7eRTm4cCCftU0MOq0Fy1znMUaQIL1zlmr6cVgYREDXKnMuuGf+rqzJO1OfovXJXIydsPtyKA==
X-Gm-Message-State: AOJu0YzCelyIft01jLPUopkPkq74pfki9sRWJZrb9zSeEQYpaFh2Sgok
	29iB3RZxa7jutvTsMpjE3otxV5BJmoM95Ar5jKUvSo8SmALjA4iLDK5PGKEZBl5uTgVwqu3gTzq
	nSXc4FIOYzV8f/u4oPLHYq5Q6hdE=
X-Google-Smtp-Source: AGHT+IFUqiknTTQ/bURym6p400yNeTpv3paWbXVMkFub/nybeRaiaIiKtT8uKho0JRbPkk5ZcwqQnoRnG4G1oD5Fsr8=
X-Received: by 2002:a05:6820:a8f:b0:59d:6ef2:7b01 with SMTP id
 de15-20020a0568200a8f00b0059d6ef27b01mr66460oob.1.1707739326755; Mon, 12 Feb
 2024 04:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3232442.5fSG56mABF@kreacher> <3757041.MHq7AAxBmi@kreacher> <87eddif8cc.fsf@kernel.org>
In-Reply-To: <87eddif8cc.fsf@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 13:01:54 +0100
Message-ID: <CAJZ5v0gzyK5EhfS3DjL99RY8x41OHk+7qZi+qF7KWhcvEebLTw@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] iwlwifi: mvm: Set THERMAL_TRIP_WRITABLE_TEMP directly
To: Kalle Valo <kvalo@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 8:30=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is now possible to flag trip points with THERMAL_TRIP_WRITABLE_TEMP
> > to allow their temperature to be set from user space via sysfs instead
> > of using a nonzero writable trips mask during thermal zone registration=
,
> > so make the iwlwifi code do that.
> >
> > No intentional functional impact.
> >
> > Note that this change is requisite for dropping the mask argument from
> > thermal_zone_device_register_with_trips() going forward.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> For wireless patches we use "wifi:" prefix in the title, if you can
> still change the patch please add that.

Sure, no problem.


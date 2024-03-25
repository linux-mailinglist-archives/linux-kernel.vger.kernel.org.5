Return-Path: <linux-kernel+bounces-117832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451C888B036
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769751C3F8B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651DA1C29F;
	Mon, 25 Mar 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iA/LUXns"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ECB1B978
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395610; cv=none; b=R2P9lxHxGOTVJh2QXMTV7PivwJLEN5Lt99gRel1USfWVsqA8NP0d9IWkVpiG7IJD4PHTxo6wLV5TCvermaoxJzGf4m9dPbqi9/OCJeELN6mSmx+TVR9Wnf7wFJKnROojMRAvOibmo2YryNRdH0Ad1d7Omt+pO+zvBhoCGxjFNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395610; c=relaxed/simple;
	bh=KlDcReSHkzr3q7MI7ZjcywQz9k72vldHzd9nToqdlAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9JSNL0NXfrvAo6Dy4lE74NYMlGr87rfUh6I9E9LTtxGN384JbpKoCbTREHCvuvEsPqseAXKzWMztloH3ARw4z1ZViNpr6p7Co31Vc1EFfOZr9axn6B/bRsb8lX3JG61+TqzmHqI7QKzhPPBvES9BOdn3TTeEgufP/QGV8bq0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iA/LUXns; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-789db18e169so367398385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711395607; x=1712000407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCSW8ugAsHBM7+R2hVkV4HgvR3WEY/XblW4OKhzKjhs=;
        b=iA/LUXnsU+cF2FQLrvvD8o1D0KazyIqqobie89ph4jpmh4YifsNqZ9lugcML6p9uRc
         at3vNU7gL35Kt+S+r4OmiwIOFhp4pnXJKRVSRIfbp/Awevw3UM1fY/P/NgUgpsim/W9B
         dVk378yrxWeNdJ8mTf3v/CgV75X/2/U9apPpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395607; x=1712000407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCSW8ugAsHBM7+R2hVkV4HgvR3WEY/XblW4OKhzKjhs=;
        b=l5Q+id9ElezqFaKlDoIPcrnjf3HqkbzZyPcUuT5RE5n+eQEg4/aJnETUQHNrWDkGUi
         HusnMdSL38dBBYoCCJGrtsncE2NmIu9to9uIwFaEOiPZKnnySiTF6ILViZZwr/iF2d3f
         VBnEpxukNRUlXQy+T8BXt12tCaoctQgpSIxLMerwYtM0NcBWaxX0zvZsbTVRmn2pOA8Y
         FchTW69utdrSBCmoottFmobtDrBIOY+8uJfUEom79OcT2bShWNrlYmx2cyJqrnqsyP2b
         KqUwxIGaHySTo8KU3lXwsXAv4bP+BrbRCkEpeYPfkYzdvnyJsDrHxFXQm962U0g4W6qg
         4fqg==
X-Forwarded-Encrypted: i=1; AJvYcCWqGxJna6KFp675L0pTvb01QVglZZPqsQoFozofcRePns0ZrRE2CCekPJRlsC63zPR5IuyJpM8ykOc+g7iX0uwkGkkM+NpkASNRs60L
X-Gm-Message-State: AOJu0YyebW5S2/eJEFZ4Bis9UStM79STP1ohQWED/e9yPlVqaRc21fNK
	QlXtqLCKUa8xp8BmRSRMteU579bR34I0bDZRqv3Bd52ZiCdo1Aam44PDZ7wWwqqlpj978gPEwZk
	=
X-Google-Smtp-Source: AGHT+IGth+FcJCehzT2OtRbzRFjofUxKqpdevD3KyF9MOpCv6QRI7QLltanjcQ19DtBlInzESfd6oA==
X-Received: by 2002:a05:620a:2ec:b0:788:2e47:b290 with SMTP id a12-20020a05620a02ec00b007882e47b290mr8401211qko.73.1711395607052;
        Mon, 25 Mar 2024 12:40:07 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id vz15-20020a05620a494f00b0078821519902sm2388855qkn.20.2024.03.25.12.40.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:40:06 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42ee0c326e8so3061cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:40:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDiQbN+Tp8K6YUGApTHx5CVRLg2e70TG906+zZrpJfOEMUVSeHV+E+RrIgbXGi+LR1WifkW90W8ayg09PGxzFdAR0OWTy75EzN7NwH
X-Received: by 2002:a05:622a:553:b0:430:b590:e88c with SMTP id
 m19-20020a05622a055300b00430b590e88cmr1295243qtx.6.1711395605673; Mon, 25 Mar
 2024 12:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325184204.745706-1-sboyd@kernel.org> <20240325184204.745706-6-sboyd@kernel.org>
In-Reply-To: <20240325184204.745706-6-sboyd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 12:39:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URo0V1JGJ=sOz4i7hW9EqrCHyEwW4Bc1P7hsoxdw5tAA@mail.gmail.com>
Message-ID: <CAD=FV=URo0V1JGJ=sOz4i7hW9EqrCHyEwW4Bc1P7hsoxdw5tAA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] clk: Get runtime PM before walking tree for clk_summary
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 11:42=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> Similar to the previous commit, we should make sure that all devices are
> runtime resumed before printing the clk_summary through debugfs. Failure
> to do so would result in a deadlock if the thread is resuming a device
> to print clk state and that device is also runtime resuming in another
> thread, e.g the screen is turning on and the display driver is starting
> up. We remove the calls to clk_pm_runtime_{get,put}() in this path
> because they're superfluous now that we know the devices are runtime
> resumed. This also squashes a bug where the return value of
> clk_pm_runtime_get() wasn't checked, leading to an RPM count underflow
> on error paths.

Ah, interesting. Thinking about this, I guess it means that a single
device that returns an error from its pm_runtime_get() will fully
disable the entire system's unused clock disabling as well as the
entire clk_summary. Crossing my fingers that doesn't show up in
practice...


> Fixes: 1bb294a7981c ("clk: Enable/Disable runtime PM for clk_summary")
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


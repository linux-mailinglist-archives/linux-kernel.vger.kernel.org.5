Return-Path: <linux-kernel+bounces-117453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F01688AB97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083EE1F3EACA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC5213049B;
	Mon, 25 Mar 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n19dpSU2"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA612FB1B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383613; cv=none; b=AI3pnmf03PELapJNYrR5uu/nV0qdVXc4XPYcDVZvtX1QI5y8lVdG3+hDVWzJIpKkiOZIXF5VLaMmpRaxTDiR8a7A4BWtsAzYOdIOc0YAHsiQ0W2kDDn2zL1MhXHHYGLADpDiAcDk7TvlaoH+/po2xlCRlABEAHC6Ur8ocZ7HI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383613; c=relaxed/simple;
	bh=A843Ssrq3Y9wYnaYppe8XjmG2PpCDGW6HiDXf0QJKws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjtPJ6AZM5DsBNYRKd1N8W4jmlSQOclSrjPtl6z1j4xzjmSP1IWmLoFDwKShd2fqNVwvQQHHgNI/gCVG7AO7TM8C2BVXVHDB9m+hzyRUd8yCPDhbfxBuLC1lHMhcxHkProDesNGkPns6dJBhJSHK00zhXkRxnNKTZ3JG0ww5Rm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n19dpSU2; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-789e6e1d96eso315691285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711383609; x=1711988409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9xAtZXJvpwpsev5gWghEp0MSIRB0SQuoLdXgBJreDE=;
        b=n19dpSU249zLiPm5edX5Zp2uHEo3MCkOcxs2fSxJybq6D7AinHeGetOAXgwzGEtTAS
         yn948OrHgMhG6D0oLEuw7ZN7//CKVGgSvEOuIF8ADc+jZly5EbkMkhfjeXUk0gLTYMWS
         Pa5oB7+l9N+TT/8dqvJcRXibDS/KVKTYsqQ6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711383609; x=1711988409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9xAtZXJvpwpsev5gWghEp0MSIRB0SQuoLdXgBJreDE=;
        b=kSd8Pb8GAlyN5uJFuvbNVsvgff7BdTVYTZkoi6CQ5UFDLy3UGyoW4b6lpGzcXNCT5g
         kE3HwS5ez8mR2lJS4qI35JClwaUmYC4an7JicAqTnClqABvtzKmdHe4a57EXwg8fQcoU
         oZsnSRJdlwMnw/pLHzPtYqP5GqzDaGc5N76tsemv0Nxyi0XylCzzlCbuGNNJ3SxZgFSE
         2X6R0qYMrSLRBkTMwrgUnujnNMrWSEwMAv2hOBmgBVj4dDsCvSRUD8DwJqc2FyDqSYYW
         5NtnnLoSNn2SX1dTvv3ssKcwNpGStcriLDQxrFtfhV8oCp3yPeDUmNDDzDQqgH/pjH5Z
         EnJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIGsp9I6wSyYOKlBKpeVIlpmE25gtxDyAF3ga2SHvTJFUtijXmO/MqTgXqpAIwVmO0gGsLpOds6UO49BGmpwdeOkr2bldGzdakKi/C
X-Gm-Message-State: AOJu0YzRsvsQTdT4KTNkG+mt0TNKgGBF8xQb8cjVzidKyqraYapeb/KT
	dRFebbfLiWTufOQLaTHJIGmR/VGimYPMkhgDf5qbeL1yY5seX979q7pvTXklYAirABZc4kx9ZrI
	=
X-Google-Smtp-Source: AGHT+IH7iJ5cCOgTatwvC/o45z/l/cD0Uusx8FHPcWaL86GE7THCCGNXEZgfc6ym/8URrisJmheafA==
X-Received: by 2002:a05:620a:31d:b0:787:79c3:93e3 with SMTP id s29-20020a05620a031d00b0078779c393e3mr7378350qkm.33.1711383608760;
        Mon, 25 Mar 2024 09:20:08 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id o30-20020a05620a0d5e00b00789f64ec397sm2251682qkl.97.2024.03.25.09.20.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:20:08 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430d3fcc511so468021cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:20:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJGtYxFO+rZ2vMtY6/btkJ5mbMythjG9eAw8W/UzH0IwWp9F9JjJL1FvwvX78FLSvtN8WAiSo7Yui6i4UsdoPsmQCKPVxtE6KepQTm
X-Received: by 2002:a05:622a:3c7:b0:430:a5df:a3af with SMTP id
 k7-20020a05622a03c700b00430a5dfa3afmr1093586qtx.5.1711383607574; Mon, 25 Mar
 2024 09:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325054403.592298-1-sboyd@kernel.org> <20240325054403.592298-6-sboyd@kernel.org>
In-Reply-To: <20240325054403.592298-6-sboyd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 09:19:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X13_5Kubq3A=y8gnz==6tt2bsfc0PiFAj06HX9V7_+mg@mail.gmail.com>
Message-ID: <CAD=FV=X13_5Kubq3A=y8gnz==6tt2bsfc0PiFAj06HX9V7_+mg@mail.gmail.com>
Subject: Re: [PATCH 5/5] clk: Get runtime PM before walking tree for clk_summary
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 24, 2024 at 10:44=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> Similar to the previous commit, we should make sure that all devices are
> runtime resumed before printing the clk_summary through debugfs. Failure
> to do so would result in a deadlock if the thread is resuming a device
> to print clk state and that device is also runtime resuming in another
> thread, e.g the screen is turning on and the display driver is starting
> up.
>
> Fixes: 1bb294a7981c ("clk: Enable/Disable runtime PM for clk_summary")
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Shouldn't this also squash in a revert of commit 1bb294a7981c ("clk:
Enable/Disable runtime PM for clk_summary")? As it is,
clk_summary_show_subtree() is left with an extra/unnecessary
clk_pm_runtime_get() / clk_pm_runtime_put(), right?

Other than that, this looks good to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


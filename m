Return-Path: <linux-kernel+bounces-117447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72A788AB88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B302A74CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5712B16C;
	Mon, 25 Mar 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+mrT5se"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D4B6F060
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383555; cv=none; b=WmcUfnot6qLmOYYTOlkClmhf2oEJhxdwu0Vc7wtoN7YQ1UdjoexaoxArAj/XKYj+dF8kp1/bbMTX5D1ewd8RuINXv36Qvdskaw7C0Di8B5PEHMKbhYnY/QytMAurX2jN1vEN61Z+Tj2WeCk8r9TRyeYlxSPqtHmg+umy9bxgayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383555; c=relaxed/simple;
	bh=C0yANzAlSzgND8qqihTlSMXwQ/R0JMuPRLxdKZ8jvZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcgzcqb2UKIdxL3vgBgzv+TVm7cFi32MgIeLwT2sV6/HjBbod+deacq094H3t1H9m6mpWvpWuis2dmZtn5mJFCCWc2j49DIyloMStq56Lh8+V4veao1TmzrBZ8QBmoH19AWEEblxbi6x9gNrDBdsCnfat/37szrmVmhd19/Mnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+mrT5se; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6962a97752eso33006066d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711383550; x=1711988350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKP+i5jnsTv1b1X+grUsnmPFecRRLS4nYrDFL9hNpXg=;
        b=W+mrT5se5SXV/eaQK3UVwLxVAIcOCDRowUpmtMn0lB9w2c8+LvZXRRQ2KTUFWYnjW7
         P/eE0vaSXXbgSPvmPF8CUwFeEolCLBA8nKog6EVUn+OaYjoUBxwzCgn69bmDLLskYq9P
         wdEnXAixjhyiz5HQ6Z0tMw6hMMhgtM/nkEW7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711383550; x=1711988350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKP+i5jnsTv1b1X+grUsnmPFecRRLS4nYrDFL9hNpXg=;
        b=jkMXi8D75s9WlIbV2nrBooSAa4HFe9BNmtwbubj9EZWQkjWisOpggnVu4+g2zQWqxu
         utXRe64L1Ih9gmsCLCny8/T2+6STsJfVL3kPM2SFTRnhu6mmU8W4lP037RaI5VOR9QMd
         WPWV8+O2Go2JWf8WOwo9Y46XAw1o+Rz4RxmNOYAK+0cY83LrhXSdYcavApeORCKih8DR
         0SzT9PXP2XT13s1uBfC1AFvkHPDzwU4evmxkcVI7Vzoufz/WwuXrAQsXuQCOsAK4Ndfi
         pwlm6ju4TPhvS7IetTNdWYL3M2gy1kBZOjtVlOzRIgC9EgXVg6G39nwU7pfqqJ8Ck5oD
         +vOg==
X-Forwarded-Encrypted: i=1; AJvYcCWbotb0xkouaxKaPS1lO/LCp/S86QoOwvZkP/XfUpOM0yW7ZW/7b1QKzsPa9b95SuQID2EeE1aHr2qB4FQ75ixTL9FU0A8z2WZaPFVg
X-Gm-Message-State: AOJu0YyBJ0BsMfEHCda/670nZ7wPqdgDHENoYxDSZsqUrHQt6eaeSgIt
	KD0N1zjr4RejnvnePve4jno2yJf9AXCIAoJM1kabQ6r/YONeVIZQfMrqqjJXtyVvjeTVTLADjtI
	=
X-Google-Smtp-Source: AGHT+IG2pcIyOp5sSCKNK5Cx1qUwV/0NTk1E4qtUoGN32smYlwqwRzSgM+sKUhzmriDWXMs6P2iUug==
X-Received: by 2002:a05:6214:d4a:b0:696:9756:fc44 with SMTP id 10-20020a0562140d4a00b006969756fc44mr1320479qvr.26.1711383549760;
        Mon, 25 Mar 2024 09:19:09 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id w9-20020a0cb549000000b0069686d63c1esm1948332qvd.69.2024.03.25.09.19.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:19:08 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430d3fcc511so467401cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:19:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXS3rnJycu/qOpk51Wg3FqdrpT+qSepiyngZqXRWsKI3ZN62IVSlsno9bqpax+15fqzBHJhx42onijf5L1kqofVh1h3liK8MHln20BS
X-Received: by 2002:a05:622a:5447:b0:431:4eea:ef20 with SMTP id
 eo7-20020a05622a544700b004314eeaef20mr283279qtb.16.1711383548431; Mon, 25 Mar
 2024 09:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325054403.592298-1-sboyd@kernel.org> <20240325054403.592298-2-sboyd@kernel.org>
In-Reply-To: <20240325054403.592298-2-sboyd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 09:18:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vo2vpemyH1ChdHtUdaeKnGckBUeqKfL11xn3WsN5+BUw@mail.gmail.com>
Message-ID: <CAD=FV=Vo2vpemyH1ChdHtUdaeKnGckBUeqKfL11xn3WsN5+BUw@mail.gmail.com>
Subject: Re: [PATCH 1/5] clk: Remove prepare_lock hold assertion in __clk_release()
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 24, 2024 at 10:44=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> Removing this assertion lets us move the kref_put() call outside the
> prepare_lock section. We don't need to hold the prepare_lock here to
> free memory and destroy the clk_core structure. We've already unlinked
> the clk from the clk tree and by the time the release function runs
> nothing holds a reference to the clk_core anymore so anything with the
> pointer can't access the memory that's being freed anyway. Way back in
> commit 496eadf821c2 ("clk: Use lockdep asserts to find missing hold of
> prepare_lock") we didn't need to have this assertion either.
>
> Fixes: 496eadf821c2 ("clk: Use lockdep asserts to find missing hold of pr=
epare_lock")
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


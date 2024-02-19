Return-Path: <linux-kernel+bounces-70968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF022859ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF6B234B3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42751224E3;
	Mon, 19 Feb 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLHxIk+y"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57F224CC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332677; cv=none; b=O5NPyiia9ginROV0A0pFagQ3UzDWwaCoLFzVZB72fve1RUex1OvEl3F2JVc0PC1NpK/WK7imKLwWmfPptVy5a91jfvHEN+AWWOdmQ7Ki/AwZfdjDZ91wmwGvmoqw8ZepefKASPKa9psBY3bxO0X81x1syo7/FiyQCJFzYonvaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332677; c=relaxed/simple;
	bh=8eKREEc7F0lAf3GTw+lhnrYpcGZiLLA3+AD1RWpjJ1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nebw9WCsKgyPg3N2jtWyWhWipO5/VMAzpHd0fGihXucSi1Y17JuDDc+rCR7SL6R+kgk7mdWRUQoU946+1Xg73qcwswXMUyOt1LP2qypUXRMyT2gLZMVO5seGq9HWQBGoHaqFm2a4JAtSWR5vRvhj8MO//5KMUPdBge8Y8JJCZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLHxIk+y; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512b4388dafso575118e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708332674; x=1708937474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrPQnhq+uifNDW6L1wLQ8gkUjpW0jaBliebCRq9SQQ4=;
        b=OLHxIk+yc6lty6vaK7xRBijROLZUE4tKD98qDYRgxk8GsjMsUQaAqwpv9kcGzqQ6K/
         HK3Mz3RZ18YyEG9EgENJWY1UFKEgwLmtmWNiY+okmcjMgoLceqThELAlB6d01dj0j1yq
         50ZMMdFDNR13o9c7yyQkB9dGz9pbe3CcYGVD7ap5XyjSSbfdhZmfJZ2l7amoKiBRxwsP
         xr8JiWHxE9ADz4YbdBicIX6vEioFYDUISSZP3xavw8Ak+EtBlRgw35/+1kPS/+48xk86
         2OaCzzMQOrpQq2ZD+lhyxTirTqW2zqgLikmm8AWxXwvkyoPa3hJTOEWv09JBxrpIkfmz
         +Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708332674; x=1708937474;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrPQnhq+uifNDW6L1wLQ8gkUjpW0jaBliebCRq9SQQ4=;
        b=Q1fYp5OyLXsP0Dq6DjR+Bcwsy7vpvQuVhxsCfSm/Hd3z6diFZ2au2pGOjMcTAcPIzR
         5dmOEy6BZO59x7kKoQvb0b1ssNj8Pp3pMO+wJo4tASNbYBYa7u+Bj36LVP3IQDcdNS19
         IG0RkqJ/LOF7OS0aFtDcPU9dcoKLYEYJ9uJKdkpRVQC7wQkr/ZRhq4/jnj3M4xnBJa+B
         57vpOdJUDhpUrNVGo83kpOopNCXc7gO/b60NcQ6ajeFMJTpu+gbc3FeTYkaBezriZWWr
         UWnBfO+Vz6YBnk5X9tvGcO9NATiIbQuXWOwEViimuMM3eoqlDnAySzsOrqOQvjinlx/m
         WrsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTHjpjEw9ea5WyWpV6BBxJAduCwG8uW879oBZ23M1Sr3UsdP7Ozpir544npR2J2OZKvnhHDmR/Mbq1vedGRDQ4wae7zLTs9/tMQpno
X-Gm-Message-State: AOJu0YyyoDUSlEc6uwwH9epa/vSzJBMoLxN8LuCVJv0QjotJtJrBmKOT
	HZAYCINTRBc5/6MHj+sWGe/fXkHYXZoyXW8PItIrSdEitEHCiv1vGec1a9e0YQg=
X-Google-Smtp-Source: AGHT+IEp94VAwIV8UDUHZQ6iK2j8S1+JA1YOJjp/Q1c61r3h7VoeVocWfcqAQMleJ3dGtbsARm1Nsw==
X-Received: by 2002:a05:6512:2150:b0:512:be4c:b53a with SMTP id s16-20020a056512215000b00512be4cb53amr39287lfr.3.1708332673938;
        Mon, 19 Feb 2024 00:51:13 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c1d8b00b004126a0dfd11sm409187wms.29.2024.02.19.00.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:51:13 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240218175035.1948165-1-martin.blumenstingl@googlemail.com>
References: <20240218175035.1948165-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v1] drm/meson: improve encoder probe / initialization
 error handling
Message-Id: <170833267304.1737509.12815192021500266320.b4-ty@linaro.org>
Date: Mon, 19 Feb 2024 09:51:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Sun, 18 Feb 2024 18:50:35 +0100, Martin Blumenstingl wrote:
> Rename meson_encoder_{cvbs,dsi,hdmi}_init() to
> meson_encoder_{cvbs,dsi,hdmi}_probe() so it's clear that these functions
> are used at probe time during driver initialization. Also switch all
> error prints inside those functions to use dev_err_probe() for
> consistency.
> 
> This makes the code more straight forward to read and makes the error
> prints within those functions consistent (by logging all -EPROBE_DEFER
> with dev_dbg(), while actual errors are logged with dev_err() and get
> the error value printed).
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/meson: improve encoder probe / initialization error handling
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1a9e51bef89af0f0976cf4c83a1e682895695dcf

-- 
Neil



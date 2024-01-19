Return-Path: <linux-kernel+bounces-30909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A988E8325CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6861C212DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3501E534;
	Fri, 19 Jan 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cv0McJjk"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E804DDDC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653386; cv=none; b=qunU9tsPmgl2UMiJ++D4HrnZqQicekPO8IRP5VryuCuRFHEPpVuP9CMb46d3vQh7PscnNCWGKlREnbVL4iXxkHheJYSnL1x8wbvexRbAkrpC8iIt2u6ileeEkrOFEz3yy8qT/f3gAjYCrrHjCHMitGcjbWEbUdQmZxMe09TlpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653386; c=relaxed/simple;
	bh=gqJH+Q3N0WE/KAJXf+jqZvwxlUI54xxzFE43xBViHto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxW9Ijcu9JtjU9NnMov3bj0uownA9qocGHMkjFwo+eLLmQPJ4xrIDS3/eIZ1RLFL/d9dBNDOxO4mDr7rpKgl94udEc+R0vgqBHGRhtlzEEn7Jp1pWem7ByqZjsyJezSonZwr1FFgVOxAIUEdst5uh7LpwzpAQ3fkj1xR/RcVy1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cv0McJjk; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ce01779f1aso1324241fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705653383; x=1706258183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gqJH+Q3N0WE/KAJXf+jqZvwxlUI54xxzFE43xBViHto=;
        b=cv0McJjkSzluZflw69DMla5BETmh6NaGYKadKR8/IHgpZyRXnfqcz06pAKhx9nQpCF
         nWMdWwTO6dUd2c5dbNEYT5ELtocIRKGcqOl4QOBW5Rb7vZMNmdMpiIlz7FPDFtUXo/9l
         8M5TaCjjxIQ9HLVDJ9Wp6eafXxGt+5deqvfrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705653383; x=1706258183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqJH+Q3N0WE/KAJXf+jqZvwxlUI54xxzFE43xBViHto=;
        b=tB3sH+/64ZCoXltniNAiP2ekTMvCzECc9hDCnr4buR1CuYuu6AXRqlfIxRKMKgEKFI
         cThB9QzHwVyUE85uAyUM3gyF0NR8XPgpYZQCSfCpAnDBr1tdrzklGBLGUIapLELbIqOu
         PIxNnl1e/tNGde9M4H2v0lEl1MDePy0BrX6T+NZdxOGjwlmYFD0QtQ8bIEfSqz6OHEcU
         2XmIKDrd5TZly4PWvDqJ2haKQsJocrZ2tHho2w/B6laqAI/dIV/H55KXPMlnU5wWJTeD
         MTqwj+XSSRMKd31rs+MrsGyi5iR07akRg26s10AmApFzrkgOb2ta9UjX+c4JT1k0C/2a
         CXjA==
X-Gm-Message-State: AOJu0YxCCAlrAmLamP6Uho//v7pP2aHupGBM9SuYUMsOuLdpgQup2Dg5
	Zf37TjfkRLR3wIvj3HaoTdK4/vTC2mt/zKSJ70mx0OtzZiT2BljWnqzeS8QLNHxNxDWR8amdvlF
	irPZZmefd3nHlzkmSUfTFijIJ4xMr4K66kRE7
X-Google-Smtp-Source: AGHT+IH4bVEhLEi75Db43ItzAD8XcRylKzUeEaDfyXD/kUVcUWrY1OcFmcof4B2w+mM/L10iyzCfvsBqk2QLZ0VxLPc=
X-Received: by 2002:a2e:b707:0:b0:2cd:36ff:4d7d with SMTP id
 j7-20020a2eb707000000b002cd36ff4d7dmr1397341ljo.12.1705653383174; Fri, 19 Jan
 2024 00:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118195325.2964918-1-lma@chromium.org> <20240118195325.2964918-4-lma@chromium.org>
 <afc0a32f-4352-4ce7-a57d-9c5900ba91d1@roeck-us.net>
In-Reply-To: <afc0a32f-4352-4ce7-a57d-9c5900ba91d1@roeck-us.net>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Fri, 19 Jan 2024 09:36:12 +0100
Message-ID: <CAE5UKNqz27LMTyiRBxQCwmeDCMEtQBPdUTWKQ2HOTxPqFU9ODQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mfd: cros_ec: Register EC-based watchdog subdevice
To: Guenter Roeck <linux@roeck-us.net>
Cc: Gwendal Grignou <gwendal@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Radoslaw Biernacki <biernacki@google.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Assuming you drop "-drv",
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Thanks,
> Guenter

I will do so, thank you.

Best regards,
Lukasz


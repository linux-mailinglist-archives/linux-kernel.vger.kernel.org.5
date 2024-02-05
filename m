Return-Path: <linux-kernel+bounces-52272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A1384961C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7675280E06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3082C125B7;
	Mon,  5 Feb 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zxyc86tC"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A2125B1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124414; cv=none; b=Qz9xxc6cOnLY2ffqdtkofP5/F3hJuZ/MtFhtDqnKo+EUVvRfNkvFGS6xATiCRwSHF3j9/+TBGFCpr4BehbL2LAeBg2kLqix+zvGGwjDZR3cFY24rnsf9ptZoi4Z/CU3KeNDnOQF6++m75Qeu+TYCRge/AwIkN5xMEn8dTGKKsG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124414; c=relaxed/simple;
	bh=gEzQAfMnaqST1rznq33RwlCpX9G577Bc1r+wGDRRL1k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T+dfu+NNk7NeiLu8ctFiWgOtHbMmm7IaIA240PcQnRRONJlwvVjPVdTM8baOMCnoxc5GDI1jZTzaTZnYX13cm7h6XCNbjdh2Vx2SxX9PCnQrMsn2umo+GmALsIvkc88S4t69XnjpeYPaD7nGodtxrJOqQo+YWib09axV/FWa2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zxyc86tC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b189ae5e8so2138434f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707124409; x=1707729209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIlBCGAlAOP/xnINBhUIazc/5EX/rAUDsP4Mt1wIx3c=;
        b=zxyc86tCMLi+jx7I7uDf3CpMB67jpdPdmZgGa7F+Km+z5xJKc711BzD9ejbnBoOF2G
         6ObipWUliSF7rmuI2Iz838oQRS3rWb76S49ZhHC8OvRlWQQlCmva1B3I+9a8jloqTx/s
         gTa/N02UerUrwKyl+ACcISvcG9X1OQQTNlAjgHu264J/JIAnjEEKchrJKo+jykdV5c+d
         d0pQfYx9SuEfW43AViqVtLdX818eH+UawUoqrKHLypLY3NeKCiGL0OyaM5ii8UTfG8t0
         QfYR12UOtZmXF1Bmvism0pq/svfWuzNtPWqG6O+mDNVme2GpDKkC+/0lcftTv4WjDhNh
         C6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124409; x=1707729209;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIlBCGAlAOP/xnINBhUIazc/5EX/rAUDsP4Mt1wIx3c=;
        b=S+S8Dj2L8XKz4aB4txMP+ALj35RcVVpI+pyRLIZzFUgdMs70E8K9447TF8CRDnzyku
         NjgoH8HfLPiE3WADTmK3jU/OavcKu1P2LnPBTB4pniJsFG4wtkyaunEYSCGRsaRSiERA
         j6BfT17z1xjPK9/PAGUWP9rDRIc1XmZJsfyPyYPUi/t8tf1VFkvhQRcuC4UvFpnj2Vtp
         dz5FrkCXpbBSNBSd1p6ODdJXl6wUOcq0LFrvvYe2Op06ALRW7ggQJSF43foLJQQ7tpvJ
         tl+U5GVK5+BIOmagydwhV5jRxvgGjpqk/FHKvOIkrowu/96O/LZt8IaI6+dz+7Q7Ci2K
         emrQ==
X-Gm-Message-State: AOJu0YwfJeyNCLx7b2AT18EXJbRuXe7BiMFybBLM9LDKiDfbRN7l39XK
	s2Op7Hz565bs9Xp+IT7x5ujWgOH97Kviy7FDyAi4QeSqUYyNEuxmeA9Ubp/yp78=
X-Google-Smtp-Source: AGHT+IE7cboWWkouWaojklpHcDELlxQ+5B75F5Fr5svEn+rxuGcVzMQrua+ZWs7f/9hdxCV8eGsXUA==
X-Received: by 2002:adf:a399:0:b0:33b:3774:ed0 with SMTP id l25-20020adfa399000000b0033b37740ed0mr2754187wrb.2.1707124409402;
        Mon, 05 Feb 2024 01:13:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXquMu+7rRjRo9xuJDvLq9JoqQf/DoHAKt/zk25ZB+5A+y0DrzSLFNbAAODEmVEe2wvVG/kCkGsEW+etLt+zyd7NU/KhnEXhApgEsNw5tQpDF5T/qWdHIPebgY7gNNvkIXSUMLamc5GeTN5H8KZx5UiyBNC38XBNBYlbA6d+igsDHpHrOndEVmv/+LaGjDyOIpT/k72In8n0Mg+7xnhOSIIwbbj5kLZOkkt82G9mqUeIByZfN7CYxo9xetJDOp/kN29GjCtuwSaEW+VboPYjuBs7S7YRrcOZ4/Kgfmmv1oSq9avjA1Qw4AgNNcO1AfhzyDDomcrc4qY5FQVnAka92dO5+hn9zeOPxR9NpEY07JDe6VhqeSPuDH0/vVclMJ8J7BsTnkSKGwmZIIDSOMLR5xqwx9YdXjOtHijk6657B29TlwSAW9NvnY=
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:455:1a2b:40a2:1766])
        by smtp.googlemail.com with ESMTPSA id t18-20020adfa2d2000000b0033b1a4cc2a1sm7711368wra.7.2024.02.05.01.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:13:29 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: neil.armstrong@linaro.org, Igor Prusov <ivprusov@salutedevices.com>
Cc: kernel@salutedevices.com, prusovigor@gmail.com, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240202172537.1.I64656c75d84284bc91e6126b50b33c502be7c42a@changeid>
References: <20240202172537.1.I64656c75d84284bc91e6126b50b33c502be7c42a@changeid>
Subject: Re: [PATCH] clk: meson: Add missing clocks to axg_clk_regmaps
Message-Id: <170712440863.617794.2380345437565943814.b4-ty@baylibre.com>
Date: Mon, 05 Feb 2024 10:13:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Applied to clk-meson (v6.9/drivers), thanks!

[1/1] clk: meson: Add missing clocks to axg_clk_regmaps
      https://github.com/BayLibre/clk-meson/commit/ba535bce57e7

Best regards,
--
Jerome



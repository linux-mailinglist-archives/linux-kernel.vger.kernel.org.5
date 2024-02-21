Return-Path: <linux-kernel+bounces-74203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA6985D117
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7F3B25AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371F3A8CF;
	Wed, 21 Feb 2024 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fyen+hYd"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D2839FE9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499861; cv=none; b=MiaTcfvwZA/0bGaonWAvXgc1RcZPF0mfwXdGnMlAD0v4PmiBmaKLgolfhwG4w9M3MlFRqAczSacbA1hYBMVSRzCbaMQxzb2WWl3Ml4C+Vm+yRKC32NHp7P2Xnfnc9TxQ7Iwh+kn0DxSJPYzGXdjYJ/EvytGvb3vDeQS/N3QWikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499861; c=relaxed/simple;
	bh=BizncbHOJu53xMldBTXky3VBzNOrGSOrbUjAHdhSMz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t7MC5rxiMUyQ1hRFYyZAhz85SYZplGv5JtA6DG0bN3/tQbnbccdqC1CYNP33EG9M0geJ+FWeJZt7HsP0c8jLIDTv3Ii5SECAxTSXtNeY8M0LYfcy7fq7+OP9nFY40LpgSryPxImDqa+gwIn+J1BFsZTe5Me2JcpQhTZLBhR+5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fyen+hYd; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512b84bdaf1so3651592e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708499857; x=1709104657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDwdGzlFA6tuZPbulz/VQAvLOcdCb4uMPbhP3kDR05Q=;
        b=Fyen+hYdQvDMPnxrkLxk1bbCmD+xkmK0+0Ce3tKHOBQTjvhQk03fBYn0XJVGExfcLW
         kAFHUyfuHxatAiEEwHQJslS/UxIKHBBHayTa3oMAugmgrgNriCsvkC1/WMQa3pcniTcD
         l5ah9HhW+PUr+QIxt3ncuvt6KfYGZiJqgFUv5YSBtV50cMxX8HRVJJlAbAY7l7w+GBjk
         PStNjg35lcuF2wNr/xo7PvvrXRu9TcA6HTH8UM8rhZVxzs8kSn+tc0gK5W0ulCLk7IQh
         mYd44eCdf3YlP3wKAPY3y/QuCEZwcrIgikijQBjZ20j9RFnAdC0I87mAvRjc8cwBtOxQ
         Pnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499857; x=1709104657;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDwdGzlFA6tuZPbulz/VQAvLOcdCb4uMPbhP3kDR05Q=;
        b=aNftHgwnINX/lDNmxaTwDKEFiU/OHsOzn6cjYwejMQbkXHSFiUy3PnvQVxjZFeNuAF
         S94aZZh2PO0MoCsFgHWmlUES2B4wj/zh2dh4v0Io/Dd3VRXNYm5h5gVienzeYoTSR/Dm
         zGzUsk4jULkQ/wpHVH2/o+SeOz1PEMRh5v5fQaE0msQdRuEZiY2j2/6gDVVNuNIL9Z8T
         I2U4p3Yk3L0S/87i7BFnCsE9HkugBH6a8VYU63yXvU4h+awnj5G0Tpe2gS017kXPdKKg
         2Hd8YdYVs0fYhQIJXQn5qfyL3TJBMqKwipkVvO7SWAhDDTdhODci+guY8b1jPrQRvqa6
         O4Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVZY2ipn6DJPszubAzRbebNWNCfVUb1PMu9VAHv1ZIZGCUroAUv/ANPTkOyf9qILna0P9hulV4PwqPkIc0GMIYzc4Wnd+8ZbvHgJN4k
X-Gm-Message-State: AOJu0YzBfvA95EGfVGnPq7XV3ldXzS83Vu1TffRF/G1rsCKaYszXz7Wx
	u6nkqZPzlZPWB4QMrtdm3MOBppV6C43PXfzPs6HBs1lF7RYhNVNX+MmvfVJYOrM=
X-Google-Smtp-Source: AGHT+IGqkGtQA0L2uq9EpwXq/4XZe8OGGMFaJYlXvE9PH1RKEoAlc2YmPJMRPCXfm76f6tpYvUvrKA==
X-Received: by 2002:a05:6512:3f06:b0:512:8d30:6dce with SMTP id y6-20020a0565123f0600b005128d306dcemr12181479lfa.52.1708499857438;
        Tue, 20 Feb 2024 23:17:37 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c248100b0041061f094a2sm1459212wms.11.2024.02.20.23.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:17:37 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20240213142831.3069049-1-jbrunet@baylibre.com>
References: <20240213142831.3069049-1-jbrunet@baylibre.com>
Subject: Re: [PATCH v2] nvmem: meson-efuse: fix function pointer type
 mismatch
Message-Id: <170849985550.23383.15344631998215438769.b4-ty@linaro.org>
Date: Wed, 21 Feb 2024 07:17:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 13 Feb 2024 15:28:28 +0100, Jerome Brunet wrote:
> clang-16 warns about casting functions to incompatible types, as is done
> here to call clk_disable_unprepare:
> 
> drivers/nvmem/meson-efuse.c:78:12: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>    78 |                                        (void(*)(void *))clk_disable_unprepare,
> 
> The pattern of getting, enabling and setting a disable callback for a
> clock can be replaced with devm_clk_get_enabled(), which also fixes
> this warning.
> 
> [...]

Applied, thanks!

[1/1] nvmem: meson-efuse: fix function pointer type mismatch
      commit: 6b475e23544a560b4bf2acfab8dc54c4e7b1749e

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



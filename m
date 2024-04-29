Return-Path: <linux-kernel+bounces-162750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7F48B6011
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1001C21AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED161126F27;
	Mon, 29 Apr 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehmtYhlB"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C486ADE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411807; cv=none; b=cU9FqoKLfNxAx47tiQxcHetMHnS+mxQ8T/4iI7dwJBkiRSulSY6exia/d2j7K1KbPRn79rN2MSMWpRN5UzB5N3IF4Ku9v+KvZjdcbe5B6QbcKb7BBeVKtl8K0YtsvXQDhDYp/UMKH2h7MrU1LdqDYXTsptJ3M29C3R4/np6VWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411807; c=relaxed/simple;
	bh=EW6kZKQhnee/+u7Uh1ONzwe60Iv1cp1olLQqZFlNuL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DrA10mQllcd42rLMYi73ImeblV2f6JsBEIGPdw38N0c4BgE8bvDp7i50CrbLEyTSjPq9dbVso7dy87eOiEN7o5DTagCS+AOsLUY5FKsBdy7/XVgrmHndDS40jKhaTJNP86F9iFgsNFQZs4gX2sIaHR+YAZ8/aBVhf7rRA5Xhx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehmtYhlB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58c89bda70so404353866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714411804; x=1715016604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9Zpib5Bk7poFRJsSfMceDxizPwFYK7Xs1pErXif+HQ=;
        b=ehmtYhlBGxM24yxRKq2HcQQWHEw/nAU7bLEUBLPhbJosP4uZ0o0QFIJa+aLiT8DUvc
         56Iwdw2xBOrMh9sbIir6sAYluv1le4viyOT/Loht3/G6zC2DeFUixwk7MGVc7xahoidI
         Pjr7fdt6z94YEcjop25pxFcAykKcbXojTWpB5B64M4ftGS84ol99VYwjSAioAr5u0S/l
         zuwqt7oaflaozTRMgw8wsnSzXXWuu8jGlPBhar+bQIl4QfL3mOIMZz9GeheFkWYClJHP
         IsLI8PkklXPhelf1kWr+TsPz7a7bB3vG/hgHPif9rLePZ2p1lOXX/XzZVgjXTRyvlzTr
         Gy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714411804; x=1715016604;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9Zpib5Bk7poFRJsSfMceDxizPwFYK7Xs1pErXif+HQ=;
        b=HiUUV5cKoFUFvbx98SYiBjUvZjV+GwGAbaXIr6FoiQSRw5TOuGVlx/xBHh8UjrQuUF
         UPrYHqoV+73ZJ3JFsJ709xfiV0RiTiSqX6cf26njmxueZ4fLgkW77SxUAQF6xwkJpbIs
         Rb38K4uUc5S7cFQKqfM98VV2A5w5niIPtjgUrKVfTywmrxYbeVXUXLfFWsTYCw88iqs4
         k3FoHPCtdNUn6x35Rerw7F7BqISwVu7nUC63IyB+d3iC7EXyWwOEO2+SYWjidBJN7kkz
         BOaw6YqbSsNbY/SgS91enX3+C2xeY27d17sKuOLtWmBTzEh3g3BKRSlF0xNI8QDIXFPL
         Q2mA==
X-Forwarded-Encrypted: i=1; AJvYcCVdSskCt001sN8+6NqQLNXsFZqRxbW3HnitSJjwS5SVZchQ+8E3SAh9c1STNI4iqfAAjqanmQCbTW0NgpBs2zZpRuYaTidRkRdLweal
X-Gm-Message-State: AOJu0YwB6zU5L5ItRKA3TmU51b9p26SvhvceiiIh6b+Hq1kceMWu0lE9
	Dpk9WkdtxthFOCyY/lvi0bo+9RxCeDwdLKSNe/JadAsGtYveSVQAGyAo3pGMou4=
X-Google-Smtp-Source: AGHT+IHp2mXYqvqQkWbaVr1BnjkMifTqCDlfD53aEUSPi59G0Ej+G1+n004plXgbLnmiVGUeBSlDWA==
X-Received: by 2002:a17:906:b03:b0:a58:c5a5:2050 with SMTP id u3-20020a1709060b0300b00a58c5a52050mr7789079ejg.53.1714411804208;
        Mon, 29 Apr 2024 10:30:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906298a00b00a58ed644d6dsm2770173eje.127.2024.04.29.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:30:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240429-hsi0-gs101-v3-1-f233be0a2455@linaro.org>
References: <20240429-hsi0-gs101-v3-0-f233be0a2455@linaro.org>
 <20240429-hsi0-gs101-v3-1-f233be0a2455@linaro.org>
Subject: Re: (subset) [PATCH v3 1/3] dt-bindings: clock:
 google,gs101-clock: add HSI2 clock management unit
Message-Id: <171441180193.306855.11401796662556688423.b4-ty@linaro.org>
Date: Mon, 29 Apr 2024 19:30:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Mon, 29 Apr 2024 14:02:17 +0100, André Draszik wrote:
> Add dt schema documentation and clock IDs for the High Speed Interface
> 2 (HSI2) clock management unit. This CMU feeds high speed interfaces
> such as PCIe and UFS.
> 
> [AD: * keep CMUs in google,gs101.h sorted alphabetically
>      * resolve minor merge conflicts in google,gs101-clock.yaml
>      * s/ufs_embd/ufs    s/mmc_card/mmc
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: google,gs101-clock: add HSI2 clock management unit
      https://git.kernel.org/krzk/linux/c/01aea123b11c7ebbdd64b2df3a4a5a7ad86a460d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



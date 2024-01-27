Return-Path: <linux-kernel+bounces-40963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949EE83E905
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3174A1F27E75
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BC0947B;
	Sat, 27 Jan 2024 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCkJjqS0"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1C8F51
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706319448; cv=none; b=erLDUgZeVvZTD3Qr0wSnZcs0yzpvepHwlwD+ryWFIgRYKyZlXBQZEveU/OdFa0cGCW9Gdyft1VzjpVFq4vJP+451p87i4+crhyqeeKD/jUBEe2zjFzxB+WDn5DRU0Asr9QzIyD4lIvR6qiyNtz6HsySBUB+vKjBJAjQgAok3pJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706319448; c=relaxed/simple;
	bh=DYj8tn+3Am911Ik0jx3jOUWXXFDXDOrUv1cfVZEFjMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SKWFho4Oc6iqY4pnOA9W/obPyT9gam1rdyzxTCqWwV39t6Scl5Zyw3jvk4rrLz6VagaEwIh+OCGuLnSBWhpS7DveD+oRcS1XtkSh8JxDAlmc7F1XaYSm+RdZgE8iun6sw7WoK7qNTPtpXDBGcfXTQ8kJMN1UQ1BBvF0HQGiF0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dCkJjqS0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33934567777so1219223f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706319445; x=1706924245; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zeFz+NtLoAQ99uBFeabvQ2L4PFgMX2DpcEuv5deUslc=;
        b=dCkJjqS0NUJGE1e+H2OGV08Z6njmaesCwefjhnF3aZFh+4MPGtK8Mf/64RqHZFx80z
         iyw71WAHZQDFTDAzZGxlooQikMbWQym6AdX9pWzu/mvo6vfpifL5FsKTZ0wdRBzGf0O+
         SRPnh3+HCDS2lq1uREIxLP21ScEN4ncg8P/w0+eoN1xUR5ym0Y2/mqgOlhyhpt1DO/qY
         YPdE3HcrGioqvHfIqDZvJ/U5UIfSvJCTmA3AcI5+73uc4BArb54YstPB/R/dEhHioqHJ
         CgnoGnxSisFnR4h42CUWhM4GdWpBUeWFIPk4eXhRhwx+ISjHiwg879eTmRw/MhWL94CE
         NFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706319445; x=1706924245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zeFz+NtLoAQ99uBFeabvQ2L4PFgMX2DpcEuv5deUslc=;
        b=VNZEYPMLrmrRAxsBRojxiZcglx9tEWCvggmd8RC2q+z+i1qPrmZcYPVhZoW8vYzGUW
         UY1w1JqfRnSfajtddl4cSOBV6Uw9XZ2vtXIOVwafRDTxMhF6ri3F3ndMx41Le7h99gEz
         CvfdwvClPG6C0FdVZG8AxPpNHXnf4AKcZBjR++tjDnG0NJH8Z+0R0cmcH428a8cUJcDk
         ezOe4WjvWBQf/k4q6jw+HOUiiNVu9JBlE8c7Ditye4Iun7K7a9gq5jfiQKc9DQMyqbDW
         f9jBxmm7xvoOpZvpLWHncJGlvLX37/GW6Haw1Vm1MdnzQNrTrxbgwecvEsR5P/25zTyx
         /n5A==
X-Gm-Message-State: AOJu0Yzw+iLLy5QjQrYdjvt0RmMExKInGV3NsZUoyOyhbDujuyRUkieb
	qQ/xL6/i0sT98mPqf7BWVyAulwelAhAdEMzfJKz+XklmIfla4ya+5g0ZGOHmuhM=
X-Google-Smtp-Source: AGHT+IG7o3FTd1/T/dXyz8w5kUpeTwkLM76RKnG6DH3eIKmaAhEFR0fu3enxkI/xjOD4tjrr2K/sfA==
X-Received: by 2002:a5d:54c2:0:b0:339:357b:f61a with SMTP id x2-20020a5d54c2000000b00339357bf61amr325905wrv.32.1706319445215;
        Fri, 26 Jan 2024 17:37:25 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id fa7-20020a056000258700b00337cef427f8sm2377408wrb.70.2024.01.26.17.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 17:37:24 -0800 (PST)
Message-ID: <67b2686739e64bad4fb4f84cec0d0f222831a2cb.camel@linaro.org>
Subject: Re: [PATCH 4/5] arm64: dts: exynos: gs101: use correct clocks for
 usi_uart
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: peter.griffin@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org,  alim.akhtar@samsung.com,
 s.nawrocki@samsung.com, tomasz.figa@gmail.com,  cw00.choi@samsung.com,
 mturquette@baylibre.com, sboyd@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Date: Sat, 27 Jan 2024 01:37:23 +0000
In-Reply-To: <20240127003607.501086-5-andre.draszik@linaro.org>
References: <20240127003607.501086-1-andre.draszik@linaro.org>
	 <20240127003607.501086-5-andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-27 at 00:35 +0000, Andr=C3=A9 Draszik wrote:
> Wrong pclk clocks have been used in this usi8 instance here. For USI
                                           ^^^^
This should read 'uart', I'll send a v2 after collecting any other potentia=
l
feedback.

Cheers,
Andre'



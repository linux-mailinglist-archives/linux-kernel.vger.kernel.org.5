Return-Path: <linux-kernel+bounces-80185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BEF862B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE042816F4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1BD17BD4;
	Sun, 25 Feb 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g15VIONH"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3A175A6
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877456; cv=none; b=P1yAkKOmdEW89LnPIBeEbWr2bwiEbL4tvrCVvoU1NLxay20fnGZJM+JFtbRXPfIJe7/sJR1SHTtmSqtrt5SVqJtkoTTI68o6OWDPyxdQfrdx8nB/L67T1bPP5G5CrstWXXF4c/AMgUA1oAs3jDHXpdziuh5gAfKU4uM/Jki+G14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877456; c=relaxed/simple;
	bh=YzRRKfqAKlmcDVCvJx2kYkiRDNxsbq+K4cM4aaj2sd0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HtJhkaRjPGOlv6DTP/OUpgpyTAW7RW564BYFL1h1HKILCyUsvRle3IH7oEORFSqty1u5bwGZQMjFHNr92AWmir3RJYXjStuJtAOe79JDDwpZF7pOaFOoQEtD4kELwXXATLbfBKcB0Pt0pCrYcfYMzWluIvxW99LFhg4n35oRk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g15VIONH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d24a727f78so33354081fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708877452; x=1709482252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeIrigf/o/54acxHXD6tnRhSt0qc1LJXEqpXg7y7FtY=;
        b=g15VIONHeNP7V8chU+NbuViNXFc4UwRU8vlJFTphM8UiQ5GJXh7q2U/UERV96M4hFd
         MovBhHTC+csXbDxY60XQ9xgMfc/+l+DeyrHcFG5s4BAggltw6CrkZUVbs4zWwe6JLVnh
         dw/s9fMrMmqlw4SRbJlpKoUcBU0K07xUPFRAdZ5qsXdvg1rbT6J+0Y0Am/oJctjDZF6O
         HMVrgXuOp5j4xPoPaqZigrgtE3uqV9/58CRObv+kWVlcRsrbdxvdjMbvi07plyINW5LB
         2EqXjnGyPBf04+rJ3rEFrdFp1ZIWKXSPEY/Kbi5/dxV4QdEFb0W9jzU7dWWxtOMYLprE
         AMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708877452; x=1709482252;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeIrigf/o/54acxHXD6tnRhSt0qc1LJXEqpXg7y7FtY=;
        b=POy9YjQ8DCdxlpapnhAlXFRbIYA1yMsXop8coJBljPjhaYyhDXFaobzQILT593PT5j
         jkpwsDyPL/ntiPonRL2xMtvv7J0fpwAZG0hea2GsPhGbXU966ZtKWOs1ib2gKw+BsEdh
         2saA1Nq77KMd2TNvWFjvSwFAkfRFQuKBbO5RiUSsFzxv4arTyD8raA5vmR3kAHSy35+b
         q4NGcG+I14mQCv/EvKCCzPtWUCYdFUqzP0kjC5YY92Nxh7bKQEj/ItzDYo4s7k4Vfaph
         h3+K84EcrXuVdC1iiyNiHJ5B0gZ+No3Bjf78/hpvrJrDDuNO+dDviHidKAFm0emi+KOv
         JFpg==
X-Forwarded-Encrypted: i=1; AJvYcCX6OFRphbtwvqQ4X53qmj+HudixEvwoAdmRBcjdlgeWEPm7C+8zKyhec/6rbsZRZjP5HswGJhq78xvJRGn3zAgEqqsw5QB+kDt0FH6V
X-Gm-Message-State: AOJu0YxT55fsAR+litUMkDcs/LoH3HmYTzy5nycpyKNTv9W7B+lG3VMz
	pQTvgdsOBfGs7mBIhjDc+08ZDb5rUJE/aLSonOrKKr1RYFAPc17S5pQxmP0UWS4=
X-Google-Smtp-Source: AGHT+IFQjFH3XmD6x+ccMkBsm7sC6QgfjLLX8gJsM7oMFx5eKmvZFkjAXFz/GXSviKhar6bJhAtUFw==
X-Received: by 2002:a2e:a227:0:b0:2d2:63bc:952 with SMTP id i7-20020a2ea227000000b002d263bc0952mr2399001ljm.35.1708877452737;
        Sun, 25 Feb 2024 08:10:52 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e7215000000b002d2697570fcsm579184ljc.93.2024.02.25.08.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:10:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240224202053.25313-3-semen.protsenko@linaro.org>
References: <20240224202053.25313-1-semen.protsenko@linaro.org>
 <20240224202053.25313-3-semen.protsenko@linaro.org>
Subject: Re: (subset) [PATCH v3 02/15] clk: samsung: Improve clk-cpu.c
 style
Message-Id: <170887745089.215710.13953112422812922615.b4-ty@linaro.org>
Date: Sun, 25 Feb 2024 17:10:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sat, 24 Feb 2024 14:20:40 -0600, Sam Protsenko wrote:
> clk-cpu.c has numerous style issues reported by checkpatch and easily
> identified otherwise. Give it some love and fix those warnings where it
> makes sense. Also make stabilization time a named constant to get rid of
> the magic number in clk-cpu.c.
> 
> No functional change.
> 
> [...]

Applied, thanks!

[02/15] clk: samsung: Improve clk-cpu.c style
        https://git.kernel.org/krzk/linux/c/f707e891eb8b655aec1b74c2171e8d529ed9c455

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



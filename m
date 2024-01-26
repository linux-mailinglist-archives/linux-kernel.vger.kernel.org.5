Return-Path: <linux-kernel+bounces-40185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD983DBEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940B91C21200
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7B1BF53;
	Fri, 26 Jan 2024 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qn/RCAV5"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52D125D8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279574; cv=none; b=AsUw4hG5PLDJB1dJVg/uHotpUajbtFkVde+ozd6/LHD96XnyhyeIfjT4UYO4YKfGEoP7VNEvGZGo4z9w9VbEzm0tn5+h+M67wljE8HwHKoe+wumTtJCsfQ/pSCGZJRwhQXuSl4SIHMrf9+vAiETxMyRPJN8it37S0Cz4BtF6Vbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279574; c=relaxed/simple;
	bh=g8+ANYE463SBRgI+9zMHW+pfoPGPasNupDSu1330TsU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GFzxjbdUmcE303vZpfSQkrmPSO/1zpEslCuEz0fJzMl7Jp9PBm7kp5K2Q72i7P8c0VLHBaq9e4bO1WWOy/M4mxz5Oojyp7gVErdYxEPVGuekDRIhO8kyasJPONBmwOHZqdfCJDvmKcJU7CkupCMw6PD1QIMVeErUgnIqsjiAFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qn/RCAV5; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a34c5ca2537so42104866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706279571; x=1706884371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqfQfh+cyfy3Q2jy9tkqaZW8vxRTyiGCDQ1xVIZ6Y9U=;
        b=Qn/RCAV59QWXXw9KI+pGJF1miQ7YAZr12Sr7QCt8lPubMcw3y93IcsGhgjceOiEMGS
         CO9O7aROJY62r1YhnOT3BgE6MHNtYPZ1OBN/IK7xmV+MBInFpKACfvouQ6D2dtpqaGRg
         pYljUrJ9a9yVKHrq5WU6xfZxh7KZM9hLjwc7W3+S8R3H1GFT3v0aX/flPP4b52ivKuRw
         NwNRom2oC4JrqdKQHuNkLWeZCMc9RYOPbroI1tfgrxOJvImF/SgA0n/FqGxQz3+fv0ZX
         LSKkOG3JHw3Ysu9l22YYSXrTHfDae5/rf3Cj6RXOgqrh5fowrVRDG4X5/+9dV2fd11bI
         jYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706279571; x=1706884371;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqfQfh+cyfy3Q2jy9tkqaZW8vxRTyiGCDQ1xVIZ6Y9U=;
        b=Y5F1UN/PJqmvwOg91Srqd0Q9hAtC16tZQ7nb0acyMTll7Kl7y3kap9h53rJCF/jo1b
         Rgbrw1/5FehIiX9K12YRKoyi75MPR8fwDZaMNtTFROEkWTPkWpKxXwPve52N7maZ3cGL
         jMPEnsf3TMqpR4+VgTT6HQfwk3d62gnTEto9wujOZ2JGZeY1zu0CgaqPAPijIHZ5VBUw
         VV0It0BVFQBPZEM2ILmxRkje4p87xSq1AlINHA2y63/+AJAlpdct6aAhN7yMjqORWx74
         lGLHHK7vE/DmY4lGHEi/a/jQNj24c/p52ntOCp3ZlB7qp6ZDP+1TNX8YlG7gr3Nc2d+S
         S9gg==
X-Gm-Message-State: AOJu0YzDZE2K3d941uL9uzXCBhf+kUI99x7S37JJvJJUA/6RQ2CsJc4/
	D9Saq4uE7g82eldf6rDUlrwvLugtgxNOmtLuqE4ti4cUY7bQOCqeo5xyoa++J3SdFKekEELF+pz
	G
X-Google-Smtp-Source: AGHT+IHYRZBkoyHgAvvQGObPJv+Ad8wVNl6ZG2gsZwVIlNBH4eKZ7OTytr7Eu29tfbHF7pWqqJee4g==
X-Received: by 2002:a17:906:3454:b0:a31:408:8552 with SMTP id d20-20020a170906345400b00a3104088552mr864404ejb.27.1706279571273;
        Fri, 26 Jan 2024 06:32:51 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090699cc00b00a2cd74b743csm695318ejn.3.2024.01.26.06.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:32:50 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231127093438.20512-1-krzysztof.kozlowski@linaro.org>
References: <20231127093438.20512-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] ARM: dts: sti: minor whitespace cleanup around '='
Message-Id: <170627956918.89562.256744792890892390.b4-ty@linaro.org>
Date: Fri, 26 Jan 2024 15:32:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 27 Nov 2023 10:34:38 +0100, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> 

Applied, thanks!

[1/1] ARM: dts: sti: minor whitespace cleanup around '='
      https://git.kernel.org/krzk/linux-dt/c/8c82b4eef2972200f6171aaa260d7bba2ad29889

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



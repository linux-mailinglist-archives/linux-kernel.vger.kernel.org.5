Return-Path: <linux-kernel+bounces-32900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E0C8361A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBD01C261FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667904F1E9;
	Mon, 22 Jan 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKjSUQrd"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530CA4E1CB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922130; cv=none; b=hDL9yrXMB3lw0hnC2pYzsvQfgU1PBL3Tcbypwq23Eyvjb4LtU+tLQdYlqSkirYO/ibwfYhHnDeht7xgVXvZxB8wsiizZKff6qJd9kL7uhm4gWuEzl2bic/bsTgrJOIcy51YWTDFTCZXk0I6zprO3w/lnMEC80FvrLUwCt23KGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922130; c=relaxed/simple;
	bh=8AVSfvnvewYVpFEg5OnwBrC4L8m18vBtE3mGwILSVBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CYWDv+fuHkeqW8zgM07HTm3Y1WRCqjagLMil3EMTq4vrA0O9HobamCzM3YvV1bcPeozdI/UdM8b1sFUn1dEn9oITGvSu4iMttOxUuKVEjFBhd2fSEnFNiRjhm1SLfGwg+Ot08dFjr9H0eFljdBQzBLI5p33CkqpOWTePZJhdM+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKjSUQrd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so1917836a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705922127; x=1706526927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP6BeipGGR5gRd3jOo2QMg73V3joNZMaftoWElxnq9U=;
        b=QKjSUQrdXwZ4IvC+dxpH7050m0XiNABjfR6bHagdxfduHIl4Dpcz2CkRgIv5M5DBEY
         zT26gErKBqKsD05SpSGRE3l11BEDenGCI+tMT8akDRTluy/pg+0pQ1asvZcfetlZHOrN
         aJEGLn8kS0iYNsoUqr1oVoslmxSDv+ouASysHgOZvh61h7wPFUb0G6Hr/28Bhnx6Cd6f
         CcbsXXELMCUeXo7IaKSREPHB4sRozo2SffYrIssqePC5I9bL55AXLWxJzmAnf7+jKVHt
         W2ZhazGV+5NVEGKMFh6sjKtQKr5vjrAkHUdEeoMS2/R5xu7i5YmYqz76lrX5/utuPhTK
         Jy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922127; x=1706526927;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LP6BeipGGR5gRd3jOo2QMg73V3joNZMaftoWElxnq9U=;
        b=afFPpSIFZPF6nxmuIcpenLcl1evdJqjaW4TF01yB0FWrDgU04MYKeavGzhh7Sa2CC0
         fCb/3N3cl4Zwz/4QT+B4mzRUsp8LLA+CsFOjRvFI/E5GQWsWQArilo8eVrknuuwexvbO
         dmg56DUmIv5YElZg9FiFJSTNvvJQjN1bYbT1554MOD6S10Vd/m6eMd3LvvMHYTGQVey4
         xW+EETXvvq+SL9Gn+GJ3MUSy7CPgiu4WLKtJq3xkkvwm9jRMzKcld1Be/+sEpt/XMcNa
         V4aOj1z2fgzP0zbkVxLp+27aT1l+FtFjfWIGQRHV1NvzNaMh1VhO2PhsFALhZZYpleh2
         VKGQ==
X-Gm-Message-State: AOJu0Yxjkpw8wUnGAq8gzeO40jxbXasBJobn1YAe7YQ9yAlUCJeO/9Ph
	Rc/jHighf1iYXaB+uqWfIBLmOmByzADez8UJBT1E01mtLzIJR6W0sXx0Uk+PHyA=
X-Google-Smtp-Source: AGHT+IEjwyLnsRLcG3m8gzbVSEMmyhC5QV1u/gscFQ9ZtxBzMBVlkEgknIRfi04FHE1btxcI7pzbgw==
X-Received: by 2002:aa7:c318:0:b0:55a:6d56:b41e with SMTP id l24-20020aa7c318000000b0055a6d56b41emr1103088edq.70.1705922127685;
        Mon, 22 Jan 2024 03:15:27 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id h27-20020a056402095b00b0055c643f4f8asm179422edz.32.2024.01.22.03.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:15:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: andi.shyti@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com, 
 tomasz.figa@gmail.com, cw00.choi@samsung.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 andre.draszik@linaro.org, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20240119111132.1290455-9-tudor.ambarus@linaro.org>
References: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
 <20240119111132.1290455-9-tudor.ambarus@linaro.org>
Subject: Re: (subset) [PATCH v4 8/8] arm64: dts: exynos: gs101: enable
 eeprom on gs101-oriole
Message-Id: <170592212617.45273.5124040864049049802.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 12:15:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Fri, 19 Jan 2024 11:11:32 +0000, Tudor Ambarus wrote:
> Enable the eeprom found on the battery connector.
> 
> The selection of the USI protocol is done in the board dts file because
> the USI CONFIG register comes with a 0x0 reset value, meaning that USI8
> does not have a default protocol (I2C, SPI, UART) at reset.
> 
> 
> [...]

Applied, thanks!

[8/8] arm64: dts: exynos: gs101: enable eeprom on gs101-oriole
      https://git.kernel.org/krzk/linux/c/6a06935ec8263be083ac897a842f06d66b138ffb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



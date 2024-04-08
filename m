Return-Path: <linux-kernel+bounces-134902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0B289B86A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57920B20F6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAB2576E;
	Mon,  8 Apr 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUeU27Sm"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A282224B2F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561470; cv=none; b=Ov7/j5L2P36S3ctmq+kODvvN+1XUE29Chnx/8GXKaAGGwy4tdlNW0soWLBhNGJKEy8zJRzvMevcLxh/tkl/RKPtTD4PTTvO59X9mz5i3EIhR3BMJB9jVsI1oTPK3GXaVDiwwgPp5AWexGaUBfbjKCeKRk5lI5RE5ME7Uw3Q9E30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561470; c=relaxed/simple;
	bh=gvPPUa0vl7EbqiToeyDUXWTagIoF8MXRo9SBkPIbo3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrX57BoQ9JjOnZteTTkSCUb4HAEV5OcO6Db63ZjJqNBRGtDBbbEmn3QzuXUBB6eiwC1kJBZfRs5HDL3OM7zbtApnks3G+i14gN91whZuOB2sIb1ZpxGKVkQQ6x+fn10DjpshhBuYSy0PvOY/qgRr2bzaHvv+nZMGWdD15BtpXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xUeU27Sm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51b5633c9cso213606266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712561467; x=1713166267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=layzcbV9sKx4ytm9o4T1Bhv6Ti19VyFlFmhQB+yf+nU=;
        b=xUeU27SmhaEZOKpMh+0h5WXXSsMFsbJobUZtzI0wcnlC1H2D4qEucZwy1LUJjrDgJb
         ZwDGCDQZj1ErJMHkEyw7E3pKeyOksrW9RYc2sl7Uh03pFTqUUOv115nhWHfUnTUfuJeV
         kJrBKxBA7vrt3jBQ8No10F3M1iw7qSimtp0ZRPLBV/sjg3xnMaV/jc3Jku9UjPpOZKTa
         9jUQd4Nepb+qXL7Vac/Qzkyi01LuYA7TEn55Aavut0DALvul6Qa3Z7PnLbMwO2G2m7Xo
         YanWWuB8+6QPYYRNlVlI+VIfuS5wymbPvO2Nr+/LaXkLc4J8TQjV4zJfuTwKNzyjFe6R
         qgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712561467; x=1713166267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=layzcbV9sKx4ytm9o4T1Bhv6Ti19VyFlFmhQB+yf+nU=;
        b=V7N/lqb30V8gzgl9xIjIM0KlX7ArPc8eJxj0RK9b/VYSQFIFcqTwNBCwHj5c+uS9i8
         xTtTfWp7L4I2xuOqom3iSgD1aFL5qUN+twK19wLU0yfuzKGUIm6tvGHHxs1nAdAdlCxx
         d2BFpXgt14hiksqgg+ADgk70vUlEFxd/I9cr8LjH9BKl8IqpuwmV2w1M1jlvCptUPIj8
         B7H99t+hEJ7JBJBNYZu1oh0La6d7UO4GAhxXMDU6kuPuV9+rUjQd64kNmqeWoqOaCEbK
         LRUe9zQr4TNx8HSfZkKsdB9hHDeW7D1x2kUf/i83BdYoSj6nDWVpPk9bUQsu7miM4N7E
         GaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIGVOVnkhHiUI2xJElA6muIcoaOrPhgAYfathqV62k4J6x/fILNnbBxRbRxs0QWdP1X8uPG+XvljdZByM2SZY0vdm9wyQft7HcLSJ6
X-Gm-Message-State: AOJu0Yz4qoA5fTZkm/yNGzDpBkYOCjKyMaGHRmI1u6T2JRNkyD6n/8Aw
	taxTFWLsXIG6aXSuG7WVfNPyPz91D/UZ0Fkxd0QxA+kXWgrFjfWV/uKCyQxu/pQ=
X-Google-Smtp-Source: AGHT+IFROZVhMl9yTG+kjy+p2ZQnYlsNW6lszZjXW/K8pEvc08uSmVIEaO9mys2gBbNnSzYgwzngtQ==
X-Received: by 2002:a17:906:f754:b0:a51:7a72:294d with SMTP id jp20-20020a170906f75400b00a517a72294dmr5206812ejb.2.1712561466991;
        Mon, 08 Apr 2024 00:31:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d3-20020a170906544300b00a4e48e52ecbsm4030508ejp.198.2024.04.08.00.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:31:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Alex Elder <elder@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Yang Xiwen <forbidden405@outlook.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache info, maintenance irq and GICH, GICV spaces
Date: Mon,  8 Apr 2024 09:31:03 +0200
Message-Id: <171256140981.12523.5652563259173425537.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
References: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 Feb 2024 23:05:25 +0800, Yang Xiwen wrote:
> The patchset fixes some warnings reported by the kernel during boot.
> 
> The cache size info is from Processor_Datasheet_v2XX.pdf [1], Section
> 2.2.1 Master Processor.
> 
> The cache line size and the set-associative info are from Cortex-A53
> Documentation [2].
> 
> [...]

It's rc3 and almost one month after last ping/talk, so apparently these got
lost. I'll take them, but let me know if this should go via different tree.


Applied, thanks!

[1/3] arm64: dts: hi3798cv200: fix the size of GICR
      https://git.kernel.org/krzk/linux-dt/c/428a575dc9038846ad259466d5ba109858c0a023
[2/3] arm64: dts: hi3798cv200: add GICH, GICV register space and irq
      https://git.kernel.org/krzk/linux-dt/c/f00a6b9644a5668e25ad9ca5aff53b6de4b0aaf6
[3/3] arm64: dts: hi3798cv200: add cache info
      https://git.kernel.org/krzk/linux-dt/c/c7a3ad884d1dc1302dcc3295baa18917180b8bec

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


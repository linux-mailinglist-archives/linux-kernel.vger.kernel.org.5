Return-Path: <linux-kernel+bounces-140215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123418A0D50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438DF1C22733
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EBC145B13;
	Thu, 11 Apr 2024 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDfWFNlQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8814430D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829760; cv=none; b=AwF2lbjueqMwsREiG5E2JLd3raE57M0d//2zXpt1EE4jkVT7u0T09tw31WunDwgWbNwb+cX82yVecHRAl4BbCh7kLNBvtzZS7x6EGc6vv+b/0vf2x7hGDFsppnF+kn93UhqCse8oi6Q8yiFB6DFSbjX90Z2SmlAAfRygcLfhqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829760; c=relaxed/simple;
	bh=QrC1BibEBbfwG9NYkcZQa2WaLpV/UZ4wPIEf3tMCeo8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SHOZKfK//X1gmuLFN10vbHZ92jdB77kqWUXNRW9uOOhPd893zsM+FARsVICzlH7Uu8CwNyRAw9pg23tmV0WVR6pRGal67mf2LB/SCtiZbPpTKpngquOwG/rBWjVXGLDZM3Bgja7DDuFK96DHi7JKd5TIiEfwVlFlCNgCW4/xE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDfWFNlQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-417d14b39feso4606565e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712829757; x=1713434557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHjRnv3zn3VWRmLST7NBJtQFKtM0e8fa1inbfbi5UZc=;
        b=oDfWFNlQrNmJZgk6oPMUPsurhE7MNxbpWUFMlgb2JuD+iWyGYv/3ZyVwGcBUoxMgqc
         sqfJsfGUh97dlpPc1W5sRd9UqygbOrEt07y0JRpJxFuHAP6gsSiZ4F1pEvofyNfTIKPD
         CByyWZMWddCJjCoQV/You+puytaKQrwSGig/jQt1pIg3K97QTpQzxnELGXNACpRRgoFy
         mXIIjb0DP0jZRIDpalT4Lbz6axSTJ3nAp1IGECVQmHTvg2dZr0/5CKRPn2BOYbEk6spp
         BOjCTcX3rA4zud1Lly3v3j5mrzmLqyZTA8Ut6aWtH3RK84ZIO7VWRwrmOxgE8nwpFFSD
         MLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712829757; x=1713434557;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHjRnv3zn3VWRmLST7NBJtQFKtM0e8fa1inbfbi5UZc=;
        b=NEaj7Iu7A7QP0HKmy5sVL7p4F7VaFEbbYDimJe7tWgBZT5rddekSaTepxgxG5cgfB0
         JoNNw5Q0CuLOBpHSC9G1Cq6lyKUoKk1wQuo/7Y60GqfoHxJ8hRyWmtwuSNOzlk+8N2bs
         cUwZQ4di7cPQokD/rJCYPiNX/blseMSkuBvt4sgswp1/1kvFQQJsAy9sY6RwXlAEDajP
         nIOa1vWirm2jd0Vvrz/Loa8B3pAdeGg8LeB+Lx+ddxo1XeZImOkVBFtuIHte079kg/+U
         YfD/4JIymftxIpfprlM01ioopewOxqLxhMmbbOAVDuCr21u96N3YskyrQfARJ3T5b4/O
         AkNg==
X-Forwarded-Encrypted: i=1; AJvYcCXwKvF9EjT0Ad8k0fGqya8CjoMFK6VE1JAQAWbclDBKK/RMIl4t8yaMdYkh4F+8JgW14umfyMo0UblVcQs36E6Mxe1YPZ8LnzzWlQMi
X-Gm-Message-State: AOJu0Yz1S/sC7PjtpbqoSOsLe50SgxN5/qj4f5Y7L5z3wKTk3xad+tjZ
	/WHbGwGRLBh4KPYuzk2HEsxUf2H+P8rR1YEoBt+8cfcv54m7o+CVGw2239YPrAU=
X-Google-Smtp-Source: AGHT+IFfF2Ta+hlSfCu284Xq3Q4nSwGdMU1l5GkrzuDhIRJGb6w3eJTvSVeZV5GqHEjxkY1bIZ0J+g==
X-Received: by 2002:a05:600c:d3:b0:416:3365:b9c7 with SMTP id u19-20020a05600c00d300b004163365b9c7mr3763489wmm.13.1712829756797;
        Thu, 11 Apr 2024 03:02:36 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c358100b00416b28651e1sm1827381wmq.36.2024.04.11.03.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 03:02:36 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240410172634.255480-1-krzk@kernel.org>
References: <20240410172634.255480-1-krzk@kernel.org>
Subject: Re: [PATCH 1/2] nvmem: sc27xx: fix module autoloading
Message-Id: <171282975615.159249.5037935876880487448.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 11:02:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Wed, 10 Apr 2024 19:26:33 +0200, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied, thanks!

[1/2] nvmem: sc27xx: fix module autoloading
      commit: fc7d05b8e427937591e3cf6c2ca493aac9ade5a8
[2/2] nvmem: sprd: fix module autoloading
      commit: fbd0d725d4fada00426611a5d6ac70602509be94

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



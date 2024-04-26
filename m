Return-Path: <linux-kernel+bounces-160299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E08B3B97
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05777282050
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD08149C44;
	Fri, 26 Apr 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGWYqeO8"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D2148854;
	Fri, 26 Apr 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145555; cv=none; b=dM03r3w8OtHRgHPCpa9ykouPVkVikq7Ha5c7XJIIWZyVepNVmlv0aa8Xz7sCPvhDfp99PT6z9yrWNAG+dajnkAALPq+lzeQnT1Y2N/4FcVzuVU3NCRXXigF2HplnjGosas8qM4A7F/CPiB4yp7TrMYCVPPUJ0pcEr085Tz0yDCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145555; c=relaxed/simple;
	bh=H17B+6DnZzINO/+Q3sKBERX+XWxjXi63JD9MIzIkFu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFPufLhkqVMih3UEEvieHUKjLcIcAuL3VTZirgjHeC+RRWznD/tbFF1+5861ZsExGrw6DofBm3/ibupzXlSdhjqQwf422jNgglxFuEnEo27TVopObhGv/Jqp4L0cdqrSqisiDkOW8WwhVBPu7+GM+9I+4STpmrzTFflxkdqxDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGWYqeO8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so5816662a12.0;
        Fri, 26 Apr 2024 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145552; x=1714750352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJXC/5vAoOZwUtcvINfBAZrBvMOr+O+V8uNP31uYJMs=;
        b=KGWYqeO88kCVTeNxoH3MbKozk3VI54VFvwoWJHmaTcr37ydhff6djqCUtPwTmItYWI
         5e0LLV6MmE74Vg8r9kOXRBPy8WT/KpysuavHozb4cohCXFEfqMPAyaKozTu1Hr1LqiYq
         d+V+PLbF6gP/XxNkoStnnuDSSHod48cQBIhqUXzAksk11OcCrQ4k1hQc5ZhrHt8W0/m6
         JZJawERPAfTSLd64qaP0jXN0cqljIOJrNjIh2GJNTMyVszs/54lRVZ5oMQhgfkpB3K0X
         Y7hLYcDJt02OQx9pHZeC9PmZOE/OUpTf1veV1egBImYJD+m2nq+aXdwR28VGGJlhWsPr
         zDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145553; x=1714750353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJXC/5vAoOZwUtcvINfBAZrBvMOr+O+V8uNP31uYJMs=;
        b=fXwQBuXx7a1YJiJrOqDni/5LkGDBCYmP7mhZGfPfE6/9D0bX683o7pU9Asz27kOGS7
         lWxT2m2OciIwN58a8sm69KQfWdGBHZhevy6fnuO7Dz6QoL2B10yZ/f0QnS+9NtXoTJGP
         j7W1hnlCIEM8RMY65X4F8QLDwmptEL7R56SUYipwNeBsVytW2KKWMuNo5YwDfPUQsVcf
         hM5BjSVz2T/h6Ok8cpNDX0DypbDzqXAvm9jG6mFZ5UTg6OXbdcf9N28UWslUALmP1HUx
         xQ8hvG8fZYemaOoSPS5L5+UkgtpF0aXc9ztRbTuQbhtQu456eVY3d37V7AvZ8rvwzTd6
         ZSHw==
X-Forwarded-Encrypted: i=1; AJvYcCWSxuCH1aAuHwqurIPw2y9whuabD/0MXwElYnBEbfv/bWbGLUhqGTEAsofuyFxaH/sESrUCpV38S09BeVU7d5H4VN8t2YqDOWIBdzDeyxGZFiIISzpIhxbI5yHgCUGR74eLsB8wPza62PruwOoC5YF1GtlSDtXKBT/ohx1idrfskoqtlnHwnqo81zxqTdCzJ5qCp4aFewCr2QzHssSB1lfcyAf3
X-Gm-Message-State: AOJu0YytUGI8UBIyDNIAvD39TE78KSR6hKx8UhV5NiHRlp3TIwkZcc85
	ejMA75Rh61/v3wsIfmsrvw/xBay4TUdEW1el3tv0vxdY9AtX9WdZ
X-Google-Smtp-Source: AGHT+IHULtZbR/4hjUfKh64G2f3BnxFRCTlvgkv414w4u51Jyt7pp+dglbscvZM5LOhe9A6qttVJLA==
X-Received: by 2002:a50:d6c9:0:b0:572:3b3c:754f with SMTP id l9-20020a50d6c9000000b005723b3c754fmr2680979edj.4.1714145552381;
        Fri, 26 Apr 2024 08:32:32 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y43-20020a50bb2e000000b0057000a2cb5bsm10542044ede.18.2024.04.26.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:32:32 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mperttunen@nvidia.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	Akhil R <akhilrajeev@nvidia.com>
Subject: Re: (subset) [PATCH v7 0/5] Add Tegra Security Engine driver
Date: Fri, 26 Apr 2024 17:32:30 +0200
Message-ID: <171414552137.2298337.4837480787385115790.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403100039.33146-1-akhilrajeev@nvidia.com>
References: <20240403100039.33146-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Wed, 03 Apr 2024 15:30:34 +0530, Akhil R wrote:
> Add support for Tegra Security Engine which can accelerates various
> crypto algorithms. The Engine has two separate instances within for
> AES and HASH algorithms respectively.
> 
> The driver registers two crypto engines - one for AES and another for
> HASH algorithms and these operate independently and both uses the host1x
> bus. Additionally, it provides  hardware-assisted key protection for up to
> 15 symmetric keys which it can use for the cipher operations.
> 
> [...]

Applied, thanks!

[4/5] arm64: defconfig: Enable Tegra Security Engine
      commit: 4d4d3fe6b3cc2a0b2a334a08bb9c64ba1dcbbea4

Best regards,
-- 
Thierry Reding <treding@nvidia.com>


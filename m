Return-Path: <linux-kernel+bounces-76154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042F385F38D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4151F229CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862D82C68A;
	Thu, 22 Feb 2024 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOQ+jNpe"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C152C683
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592131; cv=none; b=GnnCx5wNjbgSoUGQ4kG2m9MYZ6p5W2LVhjk7a73nTKcYYXDE/2fA1zSmKWt+5s3Obrf84X2Qz0TV66fPDsHDRzkEG6Flwe2baPAIN0OTLf5ZEUkm5iCCQWrmP+W353h8O+y4N46ktZsSCLKpfG2TcIhfNrJGtOoTP5QLk/i/pJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592131; c=relaxed/simple;
	bh=5i5jWq9DnIH3DlIu00Vc7MJBkT8ExtWdHY6NMTt9fS8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GcMjWcBQzkpJdjDbFgn+ByeArif9VTwMb7Q877UGJsb6QU6HDCQ2TqtX9C4C6HkQIWVB9CkEtsw6Io8BjzqbXQlwt5VeGMi7zjhurImhzJ/D037FfGvGX+4cXlkH9qHx462PI0Y3jwt4RemAliLwm4LFubrstLe8RUjmcqsliGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOQ+jNpe; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so7558924a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708592128; x=1709196928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dVwQPfQWz5c5f90/AREdLy2jpdXItaUXCVXismVnZg=;
        b=AOQ+jNpeZSfpOUUKL7S2jN6Nmlwg7lWRPEArHdljLFebbSybMlpIsuLTo/g2TP6L4D
         3xQ4Rj63Tkx/YxuwIhfe/1B7b3+aHCMMUNI/NZ2u/7HXKNSPlinbXPxkADUZ4qMpiECw
         PugvCAwAHpLgo09KAWUnoWFebX/gzsR/zIY8BRWYiXiXP7dmOrqpjwCojzt8N0+ixE0i
         Zp7daGtoiAekhmnJAMO0aQ8IDqnW0RohXaQJLo7nlf68AbU/XVH+Vxr2YNd7j6TTRaCo
         d2RwHRUWm9raqUrccYE0CPSqRRc6bobjti5hOMRFizK3TsHnRvsGhJD3TkM65anIxCsb
         TaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592128; x=1709196928;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dVwQPfQWz5c5f90/AREdLy2jpdXItaUXCVXismVnZg=;
        b=Ndy8oAx0FW3PhE41Alp1FOan2Nu7KG9skYxkUjLTRt9q7g0Hg2OROt122uQJe0qTBy
         o+uR5t+tTVxdYr3whmHClJTsB7yDF8KLZEJt/S5nu1vQKG8Zo1kPz3k/okdfiOiw8bDR
         s/XrUXTZ0L4wjUx4I8vi0dXbtOID4ES3N0h/jAV+L8ADG3xwCxOXFXMKI3wifDWYbwFz
         34EJBnNvhWN5hXIdGYSWvfBVpNKBof1AVlKL5/BNgRdkO37BJmHtz6jfqJzNivGKgcMd
         KZ5YtCOZVO4t0AtejuXQCvvs2Ojn1FSlCV+q2Od6uOWG5bP7BC/E/ic2988iLrtGNggK
         oABg==
X-Forwarded-Encrypted: i=1; AJvYcCWP/ZBBKWzpoIq6woTKxPH4tg8LC+ESQBG7LjmGq5t63KPYUQ9blamj2IzrhBpfDtJgI8xuLm1nhb25eDthr1G9X68XR7Vy0NUc5rHd
X-Gm-Message-State: AOJu0YzwhPGyda3paHXsfNcifjtr0T7H2uzrDDOdoL/gj66sT+zZ1ibg
	r818COvt3zU3EeA9Su+tXdOd2sN9ih8y1UMw2PzlUwC/JhIZjce1i2xkW9IG/jY=
X-Google-Smtp-Source: AGHT+IGL+YtqEIUR4QxIfx4HWjVOJQw8MXI0vRI83fodpBAUEiUtIV1FNqp9YQeKt4pNfoY9Jn3zpw==
X-Received: by 2002:a17:906:c293:b0:a3e:ff36:c83 with SMTP id r19-20020a170906c29300b00a3eff360c83mr6234774ejz.29.1708592128486;
        Thu, 22 Feb 2024 00:55:28 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id tl19-20020a170907c31300b00a3e5bd2482csm4623503ejc.46.2024.02.22.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:55:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240219125453.103692-1-krzysztof.kozlowski@linaro.org>
References: <20240219125453.103692-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: samsung: gs101: match patches touching
 Google Tensor SoC
Message-Id: <170859212673.12469.13497019748127862340.b4-ty@linaro.org>
Date: Thu, 22 Feb 2024 09:55:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 19 Feb 2024 13:54:53 +0100, Krzysztof Kozlowski wrote:
> Maintainers of Google Tensor SoC should be aware of all driver patches
> having that name.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: samsung: gs101: match patches touching Google Tensor SoC
      https://git.kernel.org/krzk/linux/c/9690b9de81d1ad40a70b3d34b9d7e26486a5e83a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



Return-Path: <linux-kernel+bounces-140217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F028A0D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7431B240F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4CA145FF6;
	Thu, 11 Apr 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLC0KrfP"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815F314532F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829793; cv=none; b=YvrFNNm3aArWACrgNT1lyuk0+13TgWKHi9fDQRqwoYU6djJZDF2sjN+I60EMkdOX/y+NYMAPtGmM7WAGQKSevMCAQHnoRCK2yNpMNn/lb8IwTRg3nnaWm9g2mldsoCgKxU0NXcFuHvQ9eFsM2bMwAowqchnhZU9bIL4zffY+/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829793; c=relaxed/simple;
	bh=GImcGOPWfyASSJZXMUl4SNfH+w1jdBYYISa7KR3nsBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oj6WnZqbSdmNiTs1ItsBQyhqcv88QKLRCe/EeekKHTH0S9xZ2B0EdwGS9WhRlgGqyZu31hSUKnoFnSisgg1bQZ8qsQsVNz4jSzBMNokiysqKMEBzSGroDE6+cS5wjXyC9w6wWm8bcQRM/eWhejbqF4+9KFykktC4+tLMiVEsdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JLC0KrfP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-417e51e7aedso1355265e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712829790; x=1713434590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJzO/8AIoZITVdtj3PXAYJ5AJqY6Jdcq/UBPNLdK9q4=;
        b=JLC0KrfPzv/IV9FLmYpMv5xQbLVfe+3Zfw9Fit4adbKvEV12xr/X4VrLkF+YKsmuvm
         Qlk8mBHXDjJ/+yiR6vM7b6aQrQdXDTk4PfeaYptjfwGB9MxAOUkM2Bc4RD4lVNakE5Fq
         1Ri9VRc9kkxrpQqwgcRqKQrA2nIYf/q7WeFQTDy2rCbgBOjtwKfJXjOvzGtjgRkLm1NU
         ui0yfjyzYtd7XxCbg8t+QJ+R54PLhTJWO3I17VmGN86nuRrl97D0Gts0N9qUlL7mP+86
         QSOk6e/4qnA6o/8LiBtcxA9m2aHHZYdvj5R+J4StTHkfzQShbqYaWl+Hh09rvsWREsPv
         YpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712829790; x=1713434590;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJzO/8AIoZITVdtj3PXAYJ5AJqY6Jdcq/UBPNLdK9q4=;
        b=KPJ3fHDtjz93ZgmPGHAn7f4D6H60ZuOtvLAszNbHN47b7Y9DYCidjGZ12ZcbYar5NH
         J3JsGZi0qE2BHJJSh6wVUrBgq96umnCbjtlMZDRfey5Dm8G4oadQJDuGfWnyXcbUU26K
         rXrSYxqFcVG8GvxB3Yq3Ap8YbksP8tOSuBzyO7iAjKezLMUyWV9qon29wbFcS5rM5pzu
         vTktyO+Bs+OmoWoGlgne5+GUDT/ai5Tl1TagfKeMVb7hokK80qMRiyAMyjuK812cuR/x
         h9eCycYqMPn8J/JfYnGRlnDyHi4g4TJGPRRsHIXyrD0kqsHP+1MEj04OJAyDbe+f0bzh
         l8rA==
X-Gm-Message-State: AOJu0Yw3ZqJcnSEcZDgljAQ08eZdc0h6cwgqGwE3mC8hKEA2f/XwnxFz
	TGISwPzbKZb+VMBdm9QUSJOIYwxSIGYWIMp7xnytT8zBAlmjhzgCYAp8bIJMeV7FcGRcW30soCZ
	y
X-Google-Smtp-Source: AGHT+IE9CA0TfvhO3/+w4hi2SNVVAiB3SlcNM+TLS4kcXmYTwoMrPHs5hu/RQIXXZkfDTT/qS5zEkQ==
X-Received: by 2002:a05:600c:1e18:b0:417:e563:4aa4 with SMTP id ay24-20020a05600c1e1800b00417e5634aa4mr378800wmb.5.1712829789900;
        Thu, 11 Apr 2024 03:03:09 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id t1-20020a05600c41c100b00416b5e6d75dsm3894685wmh.1.2024.04.11.03.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 03:03:07 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2024032745-recycling-state-4c32@gregkh>
References: <2024032745-recycling-state-4c32@gregkh>
Subject: Re: [PATCH] nvmem: core: switch to use device_add_groups()
Message-Id: <171282978668.159354.9727436857997739781.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 11:03:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Wed, 27 Mar 2024 09:11:46 +0100, Greg Kroah-Hartman wrote:
> devm_device_add_groups() is being removed from the kernel, so move the
> nvmem driver to use device_add_groups() instead.  The logic is
> identical, when the device is removed the driver core will properly
> clean up and remove the groups, and the memory used by the attribute
> groups will be freed because it was created with dev_* calls, so this is
> functionally identical overall.
> 
> [...]

Applied, thanks!

[1/1] nvmem: core: switch to use device_add_groups()
      commit: ea8f9ec2bbb75adac49dbaaf267f8727ee26b91b

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



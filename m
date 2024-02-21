Return-Path: <linux-kernel+bounces-74510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2337C85D54B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9394B22024
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C493D965;
	Wed, 21 Feb 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3mUGj4J"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40E24B57
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510697; cv=none; b=Nn+HJvfFV/ZlNEEry9X9Lzb9c8fDvl0ZdX4ikFWEFeRLAM+siFrB9s+5ASMhR4rB112jPhUnBKhGOXjAbGbOeq2VCSIvq/7zFK/5MBkeFrYIqJYiwkwnG65B7yZNn8K0880AAO4DKITXFdli7CPK9j8mL9vDw10byFm8U+EbN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510697; c=relaxed/simple;
	bh=trM2Kz8pPivdf6IGVzlH0ZCKq4rpLOnpoP0R6yUBqSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oweo/GPLdm4ln9n2bYPeV0NkzrNHV/Jf9c1R7lP8+b07w0B2tTEssGuKVzN42ilepW5oLiGM42Gba9H5wDzDTEptNsXbjU2HM2AbkO32+jv3VNCEuyHeQqdAXYOR2leBX7+PqajZjDbOvzgk/GNjIysBh6Jmk1Ttxs+XXRWWxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h3mUGj4J; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412767742a0so2807235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708510694; x=1709115494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn9WH08w7X3KaRpsc+O+6J3F2CObpMe10qvR2Y/8t6c=;
        b=h3mUGj4JHNWOgqDCA2jll6MnX23swac2O+3XVSmgMoXrCbCI+U8YxnGynxKVbcQjUC
         6ylTDC2hj3OivteXr9/3SsA+h53Ouyc+wn7pkB3l/gwbN/tteOcjLClIzZvs9fpAq5GA
         gyHYZgC8Kth8vW+MWNkHCHsuThciurbRv5QA1LhhhHRd0wCzy69b4eV2MhLRunSGcAkF
         Z2fkpZF6fnbzjG8cHJpVFBiei2ZXncw7Qk8KCzm1gRHW9Ts410Z4/ZVv9W1gNSgNfdfg
         FNjigOkh/AmdS+KIAcv+LRfLNmtaFAYzYYjgPXmgg5EnKrXfi7DFXPN3jIpA2Xpz/tH7
         jF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708510694; x=1709115494;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fn9WH08w7X3KaRpsc+O+6J3F2CObpMe10qvR2Y/8t6c=;
        b=Hz+VSQU/5Cy+n1LFaqILMhfVCE717OD7sRVxAxWWuZOIyqCE2mnQIA7NEfWeTcfVjx
         AjYXoralNTpPZtIw6KhrkJ61Y0P4TTkFf4So6Gi7a+wkZoPG3IzaMSGNlNVpnDhYcfMU
         sQnmYVE0t7dTrhkMTU3Y/2SGcHnI3JQ7CgLPAZnjzLCXSPyYJcXYTLiIyb1gupWnnXDs
         HB+F9MQ2RoctTNfPHWnOOJdqr6wVN5jBgsE1D49zCPH/7JU9a0z4OLboM6s67OmQrBVX
         nYAuOlQB+Vn4R6BBGezh+6AMx3YEvRAexYCvcv3blw1OsOP1pI1kEcLyiBv3FdLacygK
         oqZA==
X-Forwarded-Encrypted: i=1; AJvYcCWL61cGuCNTG3cXjcJUleYbFpwn1HkJPF4/1kI4hAc4M6t7rtCsryvo9+HXCIx6rvtNwtJCEVzuNoNgVZOBreNqSbz2Phew6U0CxMWP
X-Gm-Message-State: AOJu0YysiWPjrlzj6BphGKEiI3BdOKuc1SGVPfP2IVWQn73usi8DW+UM
	usqf7TfPXF/sUTkpZAfiiix6fUkTpvV5UXAbilPuKCnGB152dV9+xKsPHgrD+B0wBiAIvO/4vcW
	S
X-Google-Smtp-Source: AGHT+IHuTENwbRX88AmyJuMsriSXVqIUvDmx1GZlXQCUQh7dhnbVs5FGJ+kArHCimI5/Om88TN2ucg==
X-Received: by 2002:a05:600c:1e06:b0:412:78d3:18d9 with SMTP id ay6-20020a05600c1e0600b0041278d318d9mr255680wmb.38.1708510693780;
        Wed, 21 Feb 2024 02:18:13 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b0041262355aeasm1959554wml.16.2024.02.21.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 02:18:13 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240213-bus_cleanup-slimbus-v1-1-34f06d82de6e@marliere.net>
References: <20240213-bus_cleanup-slimbus-v1-1-34f06d82de6e@marliere.net>
Subject: Re: [PATCH] slimbus: core: make slimbus_bus const
Message-Id: <170851069308.25406.6494531304453736550.b4-ty@linaro.org>
Date: Wed, 21 Feb 2024 10:18:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 13 Feb 2024 11:40:35 -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the slimbus_bus variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] slimbus: core: make slimbus_bus const
      commit: bcb0dafbb3fff9f017d5d915a55831616a36ad75

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



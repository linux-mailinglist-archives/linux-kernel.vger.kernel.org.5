Return-Path: <linux-kernel+bounces-52602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD56C849A46
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38F11C22C83
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A811CA96;
	Mon,  5 Feb 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2ZRvuIa"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31541CA89
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136258; cv=none; b=M/HoyL7/Z5dbFZHHjvlv4p3HOnRG9KVFYG9PnEN8kKl6TLWSWI72Q1DxfarbLh3M9wHWbC8YOScvQ7H2LHUCd3aRyZUq80DRWjSCnwR0F9Q1q6+JNHfaMglg0Y7yu+MhrnoqEJs2mPyILIXBCaJvbc0gW8M4qPc+LcGXYvgZ9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136258; c=relaxed/simple;
	bh=wBZ1r/EP4RsD3QE48qCeadh8TeRK1wREWtvuArXwM+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X0+M8DwUcNz9A2DqYvegrmnO41bUaD7fl6NfnfuKVfcG5pmTaUa+NYnhTBaDN6W/213lJWM4lgqEBnAAwZMRlBBybzYZ/TC0xkfZcbmEKxcnk+Dfn5esPybW2G1hnJMmJ4SSCGgm++qBculfYtwuujjISs3XENx0veXBYKC+SVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A2ZRvuIa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fdd65a9bdso4157845e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707136254; x=1707741054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHcyA/WQ3BJ94WzdMaFW3smTjrOpiVzn+0jSFSepZRI=;
        b=A2ZRvuIarFyrr8/JQESFBwejWaj2p0ZEiV9uAu3yJbACuQU9D5T/QJtd+AvxgSgCyi
         JqpMPCspuOuSTl567+9fNJfNhBEYznG65ZXMf6uBJG7XauPHVjGuhv726I0Y8HRBLckT
         xnzqydR7zk7R7WBDJZIQp6kultzocGjkU9XS6goBkwEdd2l9OLvGgletKUwK747gY8mq
         I93iQWFeyoUWPH51QLilLGi3xoTw1fJkmbCzHHOUMxLp/UyS0772vF1JFgsM3ybPLnjS
         0cJ6QYT1FdcViDrxTwYB+xPq07M1MtMSXPF09Cs+I418vvN7uuFZoDJ/OO6tS/Lv1FMR
         Mtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136254; x=1707741054;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHcyA/WQ3BJ94WzdMaFW3smTjrOpiVzn+0jSFSepZRI=;
        b=FgkYaOhu4LSNDpuHpPVWvtMb5VVQBARdlT5Irxy+FaYwK5XsuxDnN9UvzIXVSXhUDd
         jpIek8uWSQrAjH11BsqepTVoUynD+FR3kIYkuPOk7nSVK58B1YlCOE9hl8WIKcjacl+P
         R7otcqd/CzWGJa2hNZI5QujFKpM7lEXHemYVDEasW05Y9BbsB5ZtLcWBAAKpBxEnBuVV
         ZLeo1pdl1aXnzcRaQE4+zBqw5+nj4LK5fqV1g3rV/iMs5pXf33ul4SaKWY8MXbjudjsC
         BgLhSdoFF4IVsdaXgHG0SHPR/6jQTDqJA96/mlrcNf2uwAU1fpHXJFZP7HO/9DGmkhDf
         tGxA==
X-Gm-Message-State: AOJu0YxhDo7qz1TTx3BA3hq+kVuuRhoZ7Q+/5KkeqjI7HjzpJdXaFCd4
	42Pkbv650wO/t+Fw7WeZxiH48Fdti/zDNqB+fFIlApEGDSCmK23jvVFeS4S5mdJDo3nSNVZKNnA
	kFtw=
X-Google-Smtp-Source: AGHT+IHzKST7xLRho9rmBY5eNj+sfYwwKlr96YfPNF+fgGZSlWaYJj4E02KzDIVEi+8tEfIeYvujmQ==
X-Received: by 2002:a05:600c:3541:b0:40f:dd09:2854 with SMTP id i1-20020a05600c354100b0040fdd092854mr853942wmq.23.1707136254613;
        Mon, 05 Feb 2024 04:30:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVXzZ0V5GMGeIbrcOOhkn6yRU2NEDVKVWOxclyZeafrcO8XQ8Bs26MhDy+cbdtBjvbb/FJ6zAfvG1Cz1YtihdSppTxcKaH5OZElAQ==
Received: from [127.0.1.1] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b0040eee852a3dsm8471905wms.10.2024.02.05.04.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:30:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240204-bus_cleanup-w1-v1-1-a0f4c84d7db3@marliere.net>
References: <20240204-bus_cleanup-w1-v1-1-a0f4c84d7db3@marliere.net>
Subject: Re: [PATCH] w1: make w1_bus_type const
Message-Id: <170713625314.36753.2151896155454565907.b4-ty@linaro.org>
Date: Mon, 05 Feb 2024 13:30:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sun, 04 Feb 2024 17:55:22 -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the w1_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] w1: make w1_bus_type const
      https://git.kernel.org/krzk/linux-w1/c/8650843ca42a7fd8255f4dcddbaa20393e01fe11

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



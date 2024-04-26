Return-Path: <linux-kernel+bounces-160489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68368B3E26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BE6281825
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D428116F91A;
	Fri, 26 Apr 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKZ1DFP4"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941B016EC0B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152281; cv=none; b=Yv50MS7c+iejUoawpGpKn13QzI3Wm0BxOcdAp878e1wmKnvOHoAb2kfd3noptwyYsriPyVCNZIze7ZOoOZTKCXmMil7wqMizpNTGIhpM1ZhLezfOGuTJTfTTBc9NZ0eEa7sEkcyle2gqqtzAfByIH49JcWZ2NXRn1QFi+Zz7NH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152281; c=relaxed/simple;
	bh=qc/JvWpjevARSmtI2Z/SPg5dqcpbBUtwW96LFF9lvso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FvQrIe0kgpOkO3ErMxHdM4GH5Pq8JrPbeGbhFE5mA8Pna9yvaNjiMGDNk5psVXqFjQmEPmzftdNATvGTJdVgeXAXWT3WxVu37ak5aPniR9kU4phpalQtDuIfVyMt/WCCt5Yw74yJE3zP6D3dlK60xtxaOHX5d7/5jI6bqGa6m7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wKZ1DFP4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so4935775e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714152278; x=1714757078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qqKoN3Cs2CMvL9+4IpXPpoLPFKBjdTNuQHYkWXdJ8k=;
        b=wKZ1DFP4BVZBkwkt78hcF8rQc3aguqKy7a/3a+XSQl9KdHE3U3bcAMgMHNIYT0ysYD
         D8YEtRV8h4ICXC3wp3e3U32F30ZNENZ6G3cAnAdWjVGrK93OmthMuNVOjiCg+9+cP+oa
         tkyknrVzK7bkTF8+o58HjgPAB6nNefGptk/9eV50nO8Nalugrno2QrFZLBwtGnJPjaWd
         /k5RQkMRW/dUB7AtiNlCDf1Uk2/qTY2eRc+i2KK0RhUM8w9LzcWx+XdWiItLjglTIRSL
         Iw2I8LBTDweJg2WZowGGUj1xK0tHiE+xWsPBP9OpV2pk2CsncoxwDnSzCOZ4m7C8re32
         vIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152278; x=1714757078;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qqKoN3Cs2CMvL9+4IpXPpoLPFKBjdTNuQHYkWXdJ8k=;
        b=PzHYx3Ma34+eSNksjbnay1GN0qKyqcIXTVa1GDMARf5A/EyrA+TzMbUUDwZ0YlVNL9
         FNB+nSxr1WyLznfTVU6zL7eUD/wzhDHO2mYrmCcpMlGxu7PhKEtpf6+YU9mmLbh5El9T
         +vCys9rcrUB3Xcs6+lUff/RD4DY1PQJSzInAz1Dyo1RkbB5PeWbLecABqNtx2JstHYPN
         zDE6hQFYgVPpeu7CtOQ5pfIcAsU9V7JJeKnL/cwtkl69c+mNYv/KwrllLDQVjLv4jnWP
         66wxcdlEhoXs5hdOMc7XJtQx55oiCxOUArY0KHS406fY72CRylxyn/b0esty15hjzL7A
         TVhw==
X-Forwarded-Encrypted: i=1; AJvYcCUjwFO4/NGC5YnLXv5sYlLtMtZZIxSMTrAULYHfQqlzmj/xeEs2ttwSa49d3EBh64v5KQ1wZS3D4AyRjaZzRLnAFJDsM7h0gms6fJFR
X-Gm-Message-State: AOJu0YweePxPjCwlqSlLSvunuRW7dJCt+yFYrFlivJs2ojxUW6xOKl79
	ryrWWWsF2+dJOVnhJM8JsH0jSLpZ9l1rwhWyziDn5vZmtk9YyAekReJq3srktFEQneLCTXCvqNX
	afn8=
X-Google-Smtp-Source: AGHT+IGiLctEE5oagDVIXdCcyOY9hQhgwc3V8m4ovCCyUNb1qls37u6auNYTNu3nuXEcmxVuCzgDxw==
X-Received: by 2002:a05:600c:1f95:b0:41b:13c4:b9f with SMTP id je21-20020a05600c1f9500b0041b13c40b9fmr2238549wmb.24.1714152277603;
        Fri, 26 Apr 2024 10:24:37 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id z2-20020adff742000000b00343ca138924sm22893737wrp.39.2024.04.26.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:24:36 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Liuye <liu.yeC@h3c.com>, 
 stable@vger.kernel.org
In-Reply-To: <20240424-kgdboc_fix_schedule_work-v2-1-50f5a490aec5@linaro.org>
References: <20240424-kgdboc_fix_schedule_work-v2-1-50f5a490aec5@linaro.org>
Subject: Re: [PATCH v2] serial: kgdboc: Fix NMI-safety problems from
 keyboard reset code
Message-Id: <171415227582.138568.453198683698011375.b4-ty@linaro.org>
Date: Fri, 26 Apr 2024 18:24:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 24 Apr 2024 15:21:41 +0100, Daniel Thompson wrote:
> Currently, when kdb is compiled with keyboard support, then we will use
> schedule_work() to provoke reset of the keyboard status.  Unfortunately
> schedule_work() gets called from the kgdboc post-debug-exception
> handler.  That risks deadlock since schedule_work() is not NMI-safe and,
> even on platforms where the NMI is not directly used for debugging, the
> debug trap can have NMI-like behaviour depending on where breakpoints
> are placed.
> 
> [...]

Applied, thanks!

[1/1] serial: kgdboc: Fix NMI-safety problems from keyboard reset code
      commit: b2aba15ad6f908d1a620fd97f6af5620c3639742

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>



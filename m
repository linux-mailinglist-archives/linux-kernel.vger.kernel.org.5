Return-Path: <linux-kernel+bounces-74193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D549C85D0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A80C1C237F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26743A1DC;
	Wed, 21 Feb 2024 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BEvTarb5"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56F3A1D3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499459; cv=none; b=CQQYn/KR46uVWCz1rJYsPaLZUwg/ZGSLIWOlsmAbLOfIPhzf7Yb9mrVQqrScOoiDzS/SWqxsryN4H8DtxU95ozVlZi//NS06Nd2IXvu34zJC/2TNUFnaHorXhtUSH7jIwDW0xuBUh0wMiIM0YIf+K8T/xYJsSg7E3q9tSZtCP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499459; c=relaxed/simple;
	bh=AW/P3zUXt5WFy0J77s/rqmTA4Bw2eEPb/SsMEDNl4AQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YdVB/39mO00rhz1jlPcYly15wBy1nwnNd8oGOY1EB8SYX1xaImsVP8hhOOH5rEqRdR1FfTibbJ736pMleqnyiI1PYIytAwJVopTiaOfqvMmkfc/0V97GmQovsLLTzFovOZqU9h2cB/VqbCno9FKgbWajUCFzvshvu/qq3LIxrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BEvTarb5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d3b72f710so2143827f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708499455; x=1709104255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2NDlz1lO0+HiKyCAoV9swbwYdnGLlz4Uc8nFBRQ1Pc=;
        b=BEvTarb5CRoLv6irgezP/bxJs09emWDU9X15+jRP1olU5naTQeVuLCDt/cq/UXipXj
         c9DIJT+CwK5gsmFi06CXc1pPkHJVy1FedAcgTtqSVQlrQhbirPalEqFkPYtVcfwdivgD
         Rq+qkEgF2j0dBL0MTPmaJhyW5XxjMe6uvNtU4CcTAnfKidBisDsm3+d5b/r0Q04alD0Y
         FyCtT5u/3qu06BCWYP505ZI+Wmrw6MCmwPueMuARGsbohewCM7AaXEw5GZXo/h5PgF0v
         sXg2mzDLe+RrYgwvLVZ5yZmor50sQOiDd1/oLZVm5RcDQSJCAqPgQVZD9eI7pnHO0CY3
         fIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499455; x=1709104255;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2NDlz1lO0+HiKyCAoV9swbwYdnGLlz4Uc8nFBRQ1Pc=;
        b=jnMhnq5Lye0rBAbqGvufImFlLrzsFqWBd219cHzI9byO4eK1uIk+3LTt5jBlzL4660
         kdOfxMAwR5Oi2NMPnaJjmC0srZLUoCK5xp57VFgPfpmIzh0lG1YOsacblu6jLt3UXu5s
         kPFvumtRjddaQkPMMRnKOYFhTHmWu7pRIUfrFlanDVJJcgkN+H3H+UF1UOoXNzKLb0vO
         97XYENyvEbTQ5C4Uh3s2u6peE7zJQGLGdfxSQ7GQBeDT+F4SqDuEVjzGAPr1SS5hGo2z
         8+PbOIvD+3abzXBo+S+QkMKUZR3eK2tbqAH9f/DDWygTIvPfA1EGaI8XGX5V/ZV2kVv4
         qXEA==
X-Gm-Message-State: AOJu0YwnC28sy5uvUoLdcHBymL31xnxsRNVMLP+IpWZsvcL+hwj2l4xJ
	2qG6+Z7sRQLsehisqoxMo/GbhzAJ05rP+9MJOhm4jOz/rtT/ausTN1iPGGz1Ope9ZnWs5n/Ew71
	s
X-Google-Smtp-Source: AGHT+IGa7sQe6T+DVzehPbCBijCWbgGOZfxiICse7asDsQ3Iwk3iYfnCEskEBwHy7im3yXHO7opWnA==
X-Received: by 2002:adf:ed90:0:b0:33d:14a7:c4b with SMTP id c16-20020adfed90000000b0033d14a70c4bmr10627004wro.40.1708499455444;
        Tue, 20 Feb 2024 23:10:55 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q4-20020adfab04000000b0033cf637eea2sm15972152wrc.29.2024.02.20.23.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:10:54 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240214-bus_cleanup-nvmem2-v1-1-97960007da18@marliere.net>
References: <20240214-bus_cleanup-nvmem2-v1-1-97960007da18@marliere.net>
Subject: Re: [PATCH] nvmem: core: make nvmem_layout_bus_type const
Message-Id: <170849945365.23141.15779885270802266507.b4-ty@linaro.org>
Date: Wed, 21 Feb 2024 07:10:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Wed, 14 Feb 2024 16:04:57 -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type, move the nvmem_layout_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] nvmem: core: make nvmem_layout_bus_type const
      commit: 18e31aed2096896c76ce2867216180fce9cf7275

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



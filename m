Return-Path: <linux-kernel+bounces-90757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7C6870489
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1A3288618
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106E4438F;
	Mon,  4 Mar 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNqZ8Z6t"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C03F9C0;
	Mon,  4 Mar 2024 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563913; cv=none; b=T2qOAZCtw+jzzJWKWGP7aQ5Q7b73/bdwH4oiUlRV6XrU0CwaGTnFNEHiwTQYNG+Q2KXHm2eRcbuj3NFyS0dBeSsXxf9gmOHF2wnn1k0zvhOq4zNhcT1NqjPxCu9acUIYLO2wqnMU3fE1Wl2KCg/PJC/LxqwMX6NVOMs/opG+QPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563913; c=relaxed/simple;
	bh=FBrOGsh5xv9/HCNVxTPsEbEIIxOX+UvVmPXRgPFaPEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elUM1co+DxjeX7ewxXDZtjXI3IQk34FRZKC0e44XRhqzfMajqpbjitFiHo99lKdiW3TBgmc0Hl1cZF7KPyZiof4oZ68RIre2UQsaNJVHoosB/RsvmqXpLGkG9X/QPUyC8U+zKMNS0t9u/eEavi8Ya2whID7ka/aypQbK8piX3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNqZ8Z6t; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dcb3e6ff3fso19733855ad.2;
        Mon, 04 Mar 2024 06:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709563911; x=1710168711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+buNMSyZ9brTA6XcUMRnnsjRRgboTCbHH7+GZjb/bU=;
        b=LNqZ8Z6tOihgXfx3I5J4qpVYy/lWi2DkAQ3Q/pA9JGBaZFM6v6lKcAUz79kG7so2HJ
         Ob5KRneRCUz3OnicvH/sY9p5MLU22TLIdSDBScsmc8EGXrCrUFyJiVpgrb09ZwoALjmx
         RlD/sDzoNP9W9k+D/PGgRiNIb1SfoYTyajlDnE5GUAr0KVkEtkrN2/MnPE9Ca4dqJj4P
         rBQH4eYUHnfmaF2+PFSL0mwOpGy4LyYNoHB5u8Lalr+CurKmVhLGTiLr5DULz7XqxJ/9
         DICf17ARsDqjyZbBCegv6PtRSYdc1n0kCJp0hSjElnwNvDijwOSpS9i26IQ6qAE2uRt1
         +Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709563911; x=1710168711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+buNMSyZ9brTA6XcUMRnnsjRRgboTCbHH7+GZjb/bU=;
        b=eUu21xP6kBw++TIA3MKqk4UbZ5ICmodkHJxuVqGJiK/IEr36XyKvW6n7+n7fWJUPkm
         U3qM/5Ih4buOpvs8pPpdWYZbk7DNPOy/Ib/M2dK/rp2sjsLgRkAhjyqkwaog/hoyUv9A
         ybjpS3C1HPghqFezTcUfvh0ju/zL13rIgQUC34V4NN7ydSFcBvisKCecL5feTHXu/YWe
         rR7+j8N3hPM2UPxJaZrkvfwDuiiBEyOXYgIAL2i71EamVJC2hMmvgciqEEVQncRmb7CY
         6g/sor5Zwb44kcKXDXRbdzhhZx0xqJDKH5D77MUCrI6ZcxyWOv/L4KxNSpDZpBld2B5o
         buiw==
X-Forwarded-Encrypted: i=1; AJvYcCXhG27cdju2FL3lzwjE0tziPEvmXxbCJ/1Opn7wwVFfaYx3IlHhn1wHtdjrIGYwTFkYLhRqwLw3Tz1VrFmVlUv6s18LVcs2wZu3ND/n
X-Gm-Message-State: AOJu0YwBWkrW3YCUDY/LJaaaE9959IGcIH2YoPTpJXl/YInoThXJct9r
	qtSkLfgw2/mlSi/FnU+8XBPXAOqBiFUf4hYknuTpELWoDRAfQAiVmaPD2Fwv
X-Google-Smtp-Source: AGHT+IHM1vEaWmP4Da0UP7NmgT0Cm17ez0na3GOYLfG5yqkp8ZRLlHlLY7OFSIW3G+hfOm9xrTw4Mw==
X-Received: by 2002:a17:902:ccc2:b0:1dd:159:e2e7 with SMTP id z2-20020a170902ccc200b001dd0159e2e7mr5928354ple.39.1709563911166;
        Mon, 04 Mar 2024 06:51:51 -0800 (PST)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902e54e00b001d9641003cfsm7618409plf.142.2024.03.04.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 06:51:50 -0800 (PST)
From: skseofh@gmail.com
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	skseofh@gmail.com
Subject: 
Date: Mon,  4 Mar 2024 23:51:26 +0900
Message-Id: <20240304145127.165250-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAL_JsqKNGjKq3vcUPFiPa9JNq-8=oP=uBSD=tyKaPMH3cvAkww@mail.gmail.com>
References: <CAL_JsqKNGjKq3vcUPFiPa9JNq-8=oP=uBSD=tyKaPMH3cvAkww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: skseofh@gmail.com
Reply-To: 
Subject: 
In-Reply-To: CAL_JsqKNGjKq3vcUPFiPa9JNq-8=oP=uBSD=tyKaPMH3cvAkww@mail.gmail.com

>>
>> From: Daero Lee <skseofh@gmail.com>
>>
>> After page aligning, the size may become zero. So I added exception
>> handling code for size 0.
>
>That may be true, but when would anyone only have memory regions of
>less than 2 pages. In any case memblock_add will just do nothing. What
>is the actual problem you are having?

I modified the patch to clear this. Please check.


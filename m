Return-Path: <linux-kernel+bounces-130641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEFF897ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803EBB25F87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DF815689D;
	Wed,  3 Apr 2024 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C6WiZzrQ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C4156671
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180206; cv=none; b=BNxc/cyjufa/1qaqxt/euH4SlPv6vKwNljfhkDp2N87AfcNngU6BeymoNxc43Q54OJTsMOZwkZE/2yTTbFhT4Ur+XPJ2pvdBbmXXFxROXcipWBrbNXldqK2eeuvVtbp9eeRSpGm0JwXBZRDaBpIgrAwk6W8QlMX78LTqaU/9aU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180206; c=relaxed/simple;
	bh=NdBqKp0juwWtRnrAtCIbTx8J+qGB2w1A5P7tVAcCA/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dp4EUJSZZP+VlGIclbXkp+N0uPxYztSqJUYuqAL4Y2MeVY+OlQ+y05aa3e//0l+RJAt+BRbBfAKm/0KL2RKhHS7fYmXMkUc0UMwIWfwl7WM/NKu+hqrw8DALvhTJ3DlVlRQbqgKs2QAbn6nfO5XDA82CLx7vJMwpLedN/knhcRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C6WiZzrQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso199751b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712180204; x=1712785004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXb/hya9MuzyVUKh4KO8Jgkudhwo0tzYCFb8lkCPFT8=;
        b=C6WiZzrQZjQ6VK6yvW5QziXTcszW83nEtpB6wyTc10Y7Sr9HjaQiSogPBC1YdQ1Fu+
         HKIv18chG8/woMzNvEmRWRJHR6ukIJ02y2gdP3lGXPYIZyUF8kQfY4BaZ3qoj50wNZ/l
         xsi2zm1iZ/HCNksvn39iZXLpdAFcmbbkcMuhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180204; x=1712785004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXb/hya9MuzyVUKh4KO8Jgkudhwo0tzYCFb8lkCPFT8=;
        b=b8kiEqn3DA3k6BnwhfKUYdRhqfEQknYmdKlImfdH5PPdaTE7agtW057EOCJ0TB2fCN
         G5nCOaBISbCEKEZWx2MwTadvfMgY5zsCrCvst2WwxWP/08l0EuLWvwMXPbl4/S9TbKQb
         Gbu8cAf3YKkCE52fluTU1KgkKWahdrPkvWWOgIPYOKpKfkpagSqs3bRn8rrTXmbpG626
         WyTgmwk0JT2TtsCYLZxdJFnpX56UuoudNgjnEDR1cGONbD62J2i4Ni3Ks9QmA4Kk/kJa
         EK6jpGR19YiYRBz0kO6SgFBibrEP6FwR6+r2BoTqdjDSm2oDV76sVc7sfl5MLQhypPKx
         RmjQ==
X-Gm-Message-State: AOJu0YzJSaHh4+jDs1Eh+dD4ia2igI1ckQn+hJVr04mA45Op1yQdyadi
	8sRdV1pSv7z6fRztbyLNcAfXiWJlPFsHNU5AWO7zUtYfPutdm/+3tXZOEpBkXg==
X-Google-Smtp-Source: AGHT+IFQ8/7XnV2Lir+npGRY/WkOn5joFd7y+Pw7U5KvNmhECatsiBYh2vrisoxpgesvx1BiuveZZw==
X-Received: by 2002:a05:6a20:9151:b0:1a3:adc3:ce29 with SMTP id x17-20020a056a20915100b001a3adc3ce29mr1090942pzc.15.1712180204577;
        Wed, 03 Apr 2024 14:36:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020aa783c5000000b006eac81fa1fbsm12273046pfn.66.2024.04.03.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:36:44 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: Re: (subset) [PATCH 02/34] ubsan: fix unused variable warning in test module
Date: Wed,  3 Apr 2024 14:36:37 -0700
Message-Id: <171218019557.1345248.1235044277725212529.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080702.3509288-3-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org> <20240403080702.3509288-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 03 Apr 2024 10:06:20 +0200, Arnd Bergmann wrote:
> This is one of the drivers with an unused variable that is marked 'const'.
> Adding a __used annotation here avoids the warning and lets us enable
> the option by default:
> 
> lib/test_ubsan.c:137:28: error: unused variable 'skip_ubsan_array' [-Werror,-Wunused-const-variable]
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[02/34] ubsan: fix unused variable warning in test module
        https://git.kernel.org/kees/c/bbda3ba626b9

Take care,

-- 
Kees Cook



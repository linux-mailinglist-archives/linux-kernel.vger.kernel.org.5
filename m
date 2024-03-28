Return-Path: <linux-kernel+bounces-123694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BFF890CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC92294004
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0AE13B58B;
	Thu, 28 Mar 2024 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RamvnTJB"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BA613AA43
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662977; cv=none; b=LiiGYspsxpTaSF69aMxwzbD6doKO+7ZIKSaodwZh0sbh6pkh/y1pEk1uC3RSYdoKJ6YH3k99ZGqf0+fg5F5cfett1qriLkPrsURNQMxhvzMxJi6oPsKNGWpxiB1kCzE71DjoUndQpeAN9Dmiu3GIH1gMw37nI/CtJWAXLv7wRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662977; c=relaxed/simple;
	bh=pGaZr0I0VXtsY65MGDVwpcayT+W78gHjXNkg2BHSWwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJIDovM8MS7dDeqBz5fU0rmrnYmpGq5lQVKe7vaHC/iMZXuQTnzLjRISu0i5qTrcOONJO3n4Uny1AlG8Jk0wb7u0iVkcmgqFPmKRcgjxRbn83VikaqlIFeU+YRfpQfqWXBo6D7lWbU2pBwV8dPuIdo9WVidgAppr0CGxuMVD1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RamvnTJB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0b213efa3so13525345ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711662975; x=1712267775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utbXcMvoS/4yMiqoNGvBfvTA5qgZ54Dl0x2lTMpmBl8=;
        b=RamvnTJB8z5JMnpA4l7WLycsDmPk8k4VoWG5B7lOBDXt8JCK2p6JaR8KHhMGD/B5YZ
         MnGViXm22W2k4gwQnRiZ7Q+24WKuccf2NK3TTpCMfyxi2QIM+Mb+zXe7TFur0aFIgPd8
         1aSLXneuzDit+gehn/mZpbzcgWOFUjRpPeANI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662975; x=1712267775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utbXcMvoS/4yMiqoNGvBfvTA5qgZ54Dl0x2lTMpmBl8=;
        b=PmsbWn+Qk9rg+owaJizadBvnLwJtwP4zGa6fSgUnLwuKPBYcBM+O+E+0Iq80biRJIk
         UDEUEsyZ/frOafniDvB6mNWrXeQ/JW2VVngx2Wvw4u2AYGyTqNCD0dP+ILfYA2yS9X/N
         3IIo07ql5y6+zHunkrkr8dzywEgInA4BYcNnyXxNgmwvORc941P62kWkm2f9m0Xqurwg
         UOMB9b9lVdSn8GIb9poMheQF28FV2VuZES+qVTYYuAchJIQultuQD8z+yOE60NLd6nLW
         Odm2nn5DJywINekOgCvq4mQxyWEBwBtQwQXs1kUXaqXdpbRbdHbqBumSNtVvc8Lcr0AO
         xbkA==
X-Forwarded-Encrypted: i=1; AJvYcCVcmccMQzOSGSeoxhdoI3DRRHoraPi2G7Ca7vxKwgCb5s8ooQcTppPrwXOZMNg6P3d3n/IXSZ8t/cr5Lf9rFR/g5mLrT9i2JukkQYhe
X-Gm-Message-State: AOJu0Yyl+jWHMwu8BMnC7QXwLDqiEoF74iJJVKm5kajqETVsf2cGRQIO
	QUGhjM/n3Ducy7AOefSyxk6bf7AlsSPQq93R+cQmToI5aF+VePZ3FhW2BKmrow==
X-Google-Smtp-Source: AGHT+IH0vwx4I06MSrNEDlBuzerdk685tCIwfv4qmmnpqnH7QEZOeqH+rWOw3zrbbN180XVtRlKswA==
X-Received: by 2002:a17:902:a388:b0:1dd:b3ef:4528 with SMTP id x8-20020a170902a38800b001ddb3ef4528mr748393pla.52.1711662975100;
        Thu, 28 Mar 2024 14:56:15 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001e0b5f9fb02sm2156087plk.26.2024.03.28.14.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:56:14 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org,
	Ard Biesheuvel <ardb+git@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	kevinloughlin@google.com,
	thomas.lendacky@amd.com,
	Ard Biesheuvel <ardb@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] gcc-plugins/stackleak: Avoid .head.text section
Date: Thu, 28 Mar 2024 14:56:10 -0700
Message-Id: <171166296859.3578759.529846502989874977.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328064256.2358634-2-ardb+git@google.com>
References: <20240328064256.2358634-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 07:42:57 +0100, Ard Biesheuvel wrote:
> The .head.text section carries the startup code that runs with the MMU
> off or with a translation of memory that deviates from the ordinary one.
> So avoid instrumentation with the stackleak plugin, which already avoids
> .init.text and .noinstr.text entirely.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins/stackleak: Avoid .head.text section
      https://git.kernel.org/kees/c/4ac9a796ada0

Take care,

-- 
Kees Cook



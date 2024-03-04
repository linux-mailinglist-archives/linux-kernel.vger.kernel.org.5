Return-Path: <linux-kernel+bounces-90166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D3486FB4E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37391C21ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8831A168CD;
	Mon,  4 Mar 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qE/goJ9z"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104E15AE0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539663; cv=none; b=BLIbHSYfgYdQVmWRi2nAyROjMCIX6SruzrXOs5n49CSazAAzOiaql74hp6XJ2i0DhG40Z8HKTl02XOHjI285WHyHISIpp73vgAyhPr+HyA8MMf2C8Y0tviw5FqHsee3xS69pNrDrFoUMNbiCBKcULPh9OOmAjiWlOJ6zf/K7TNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539663; c=relaxed/simple;
	bh=JrEfQ5lsb+5XbsDuc82K+zIwkMVIR394kZZUVAvcIAE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Db8zOvaYYqJ5WnviafqyRT+cj5C+6Z7+Fwv+zaQuTKmUjSuQC1pB9Z2lm+18tTapvBcqorK0sKrNflvWIcEOPKO23xrUcrB2Vbm1V4nO1ZSBy+cvOxBr2FSM/OzKWqUrJcmQBQ/CS//agTxCP3G4PVF0cRbV6fh/x9+ipFVC5yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qE/goJ9z; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so2168482241.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709539661; x=1710144461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I4V64q1EnS//uojIpdSXO9kfi0xqru4ymFKUT9EN5ZI=;
        b=qE/goJ9z5+XXNxR4BS1NEo73Q4xXYJj/IjwPyiVgVO8m+cbf2UEDcPVi4k6ChBCLel
         81Gb01WcO0fN+qoU2diByeZ0iQZdyvyxG0E1VQVBg986/1kObEyEWywvTv1ff+2ggOvf
         aKFde5KrAH8ys0EsS3aV0/MWRDwCvPX7pPI6fn0gckE7Fe+31Gam2XQWSc+j6Ikr6+XK
         NrOygpPnONQ7VMyAWLL/4JSH9JaQI7uNgZe4KgnkWJBTjvXm5y8eAqelk/r5xgJL+ihF
         Xgv3Y7/hn6bNL50PFQu/AHEWRNhoAW7z9Z9Sm5y0h7SBS1jFgyZs6uNa9WvXJQCeQtLE
         dcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709539661; x=1710144461;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4V64q1EnS//uojIpdSXO9kfi0xqru4ymFKUT9EN5ZI=;
        b=dvAqzc1sItaGnbTceMkN9D1Qf/9caXs/pkt04ASumVKguFQwKGFEJdU/n3SAqWhS6S
         al0pptWMudrf61MggpB7MMCXtjJdxFgQhp2pq/FeBZXutwHDCNU3y+YcvZUb2ezayY8i
         PAQn5wcogq32kV/KtAzjdKVD/KvthxYOrHQroNDBtXdP2NDiv5Qtym/E/Qh8wFZ1jusk
         qcg0kJrwppyQ4XNlARWoCd0scXZlbV5VpYusl1AKAgYEIQzCvQSqz1pBOa2kkl/PU46x
         KyEZkg2ELMLckZo4Hddq1cm4Dj4aAL/HrJFhmfSWAG1QPmtoikaDk4xXg1hZc4J6rrHE
         thqQ==
X-Gm-Message-State: AOJu0Yx4fomgLdgWiIXbrkhDoBbdU0QoxMLZ4JzO4qNq1meoc4Tif55U
	1VDbLs8jjkhM4u2ttbirD0W0w3owQ+Stwz+pZxUDBy3x1OVpN7Nem7BU/dGOFxpoRj6UfBkk4ty
	ohkZY7XOcvBqYqMpjF+OtDCeU7RZtTZRcCRg11H44wCuydmP84S8=
X-Google-Smtp-Source: AGHT+IGe/sEs/lbpDzYz9UckYPkNs1+8EFlDGUFzLUMP5Sy5o1K+biDa5g/KZP7WE5+fr/wSS0T9+F0Wwd8AmHuOlTA=
X-Received: by 2002:a67:f1d1:0:b0:472:7729:69b with SMTP id
 v17-20020a67f1d1000000b004727729069bmr5396096vsm.29.1709539660578; Mon, 04
 Mar 2024 00:07:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Mar 2024 13:37:29 +0530
Message-ID: <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
Subject: arm: ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko]
 undefined!
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-sunxi@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org
Cc: Maxime Ripard <mripard@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The arm defconfig builds failed on today's Linux next tag next-20240304.

Build log:
---------
ERROR: modpost: "__aeabi_uldivmod"
[drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!

Steps to reproduce:
  # tuxmake --runtime podman --target-arch arm --toolchain clang-17
--kconfig defconfig LLVM=1 LLVM_IAS=1

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22919744/suite/build/test/clang-17-defconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22919744/suite/build/test/clang-17-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22919744/suite/build/test/clang-17-defconfig/details/


--
Linaro LKFT
https://lkft.linaro.org


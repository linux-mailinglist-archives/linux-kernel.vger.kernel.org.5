Return-Path: <linux-kernel+bounces-131276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFB3898597
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D701C215B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296180C1F;
	Thu,  4 Apr 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBaPvh0+"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A680635
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228408; cv=none; b=Wd18dcM5pm3hxcugVmPbRSkMjMdZm4yw923ENEPHV1ownoGbnLYr1OsyqwR57OqwKDkbGMb5/PqI8DGj74j5k1B8i2IgCaJNbBox8pyilTqHUTOUKee7dS4w6AjncaDyK+EYfLEix9YjtLss5evBTPxNO+uBIK/H3JzlsHnAZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228408; c=relaxed/simple;
	bh=QZUH1a52jMmfuHXnlXXu1W4aybSdzgNJ2CJHqixfuF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=llZfcalo3gTQ0du8jyN1uors9YaRW/xAnw0gIUT+bFCTCVeKtjExDDQAGUQA4OZ1dwSK2YA2WTrlMrCJk8l6nGFIXx+gXUwzh0zC7bhlGi2HV+mQBTByxtTP+Lhc+o0Lob4E7mtluJ6NHECgA3c/hAzLDczsW5xAbe/Mxc7/zC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UBaPvh0+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so18247951fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712228405; x=1712833205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/4VrhFwIx4miS0ZTEG4Oh3FbRsUqj9LhWZBkvCX24A=;
        b=UBaPvh0+jhPb7SCqBikJW7IWSp9qcbYkBFYzrI9TslS4mK6417e9pYrgZrHKNXtU5Q
         be0NjlP/y6EuruRyYWLDEEl9+amH4LbPN4bMUJw8pm7WqXdFxHdPwAcP9CYZovmF+hnD
         W41Sq9jksB5XAgc9HPBaE8tJnIJm+XzO9uNIB7r5jr5EoktdKjmuUWqGlpMU0I/sO5Au
         w8XwrdfgOqfQOJPYyegoZDU1gZPe6VUV2V3/5rT1KxQ5aKAnMEpWcoxuh9W1rDpy301w
         RKN2c84tPTRJGAuO4VTPb37P57wQmG7x3kVkROZpa70B2vDhsCT0f5ONT+fiRrcJyoLF
         sfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228405; x=1712833205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/4VrhFwIx4miS0ZTEG4Oh3FbRsUqj9LhWZBkvCX24A=;
        b=PCRSRR0rr2cVFawllF3BazcP11w8UxXbBoLvOktgoSuTK6CInuxk/w2CvePO8be0wV
         dbGif1DrGLaFNizGPkMRY/OOQABoA5LU9XoL3RqW3KnJ9FSXc1UqSCqwnRjP4kIj7aUn
         Q7rVQgt8N/FJTVA2g9B+rmONn8qHBdYXgc1JoXw/UhKcIoL7FfyxyxpcsXSZDPyMkGC+
         j8mYoB62Zm6+g2PoCXDLIOhNuaSVY4ja2qyucWUp7wwr7rZn0zZEsQxC0VTSKDb1n1ak
         ljJ/enoEBb+JayiBI3ACcXcugYQQP5PsZi3SjyrQbBK5/0VH/ATy2+TptGdYjKQbih1+
         hnzg==
X-Forwarded-Encrypted: i=1; AJvYcCXaJNHcZl6DwTKYxdwf9EldcU0rWZJy0RFa+lRwgqWd8UTGKn0fmyfNu5qyYkYmuYQj7oAGTPzf4aOY5+NweMOsKLc+46nTlHS35iil
X-Gm-Message-State: AOJu0YzpIZVrd0DE4RnqzBbY9egQTYPCz6loXvMKNjTjesxQXwZXBbJS
	zJlUQuNlv+8KQBoXraROtiAvVFGhh68ZWTfHFQUlZNi3UQ504LgRTkS8NVH8Mm0=
X-Google-Smtp-Source: AGHT+IFdsz1dPl+XP6/LnYzHYCfgyWAYaamiQYXNuyslyHX2CpEcMsg1VYQm52tn0PFfQ/QqgFpr9g==
X-Received: by 2002:a2e:9cd7:0:b0:2d7:1cd2:d382 with SMTP id g23-20020a2e9cd7000000b002d71cd2d382mr749307ljj.15.1712228403147;
        Thu, 04 Apr 2024 04:00:03 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id e20-20020a2ea554000000b002d3f3da0702sm2069719ljn.107.2024.04.04.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:00:02 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] MAINTAINERS: Add a git for the ARM PSCI PM DOMAIN
Date: Thu,  4 Apr 2024 12:59:52 +0200
Message-Id: <20240404105952.562885-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let' make it clear that we have git to manage the corresponding patches for
the ARM PSCI PM DOMAIN.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..7fb5b93dfbfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5578,6 +5578,7 @@ M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
 F:	drivers/cpuidle/cpuidle-psci-domain.c
 F:	drivers/cpuidle/cpuidle-psci.h
 
-- 
2.34.1



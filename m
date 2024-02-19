Return-Path: <linux-kernel+bounces-70977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB91859EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6341F235A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1782231A;
	Mon, 19 Feb 2024 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euIY5KVU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40489219E9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332935; cv=none; b=HNf0G/MS3u3O1gdLefyJDipwoou4U2qMItMcXdSEkHkg+SeFp2C0o9Al3hCvT07dHNBIYJ9c6lnK+0pkPrfloqlrH1BHSpaMUjJCMsunr1hPmZR1TYe1cq67fHhiGYZ5beSJaO0pDfpuDo2RAC2pactoixCZ4rtmftAODkGpf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332935; c=relaxed/simple;
	bh=v3jG8NE8mdAouMj5NdjEMZU71geyyozFyI4FC8QUgo0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tcUemJLc2hcjMZmXWh42OezvTI4ne7Sh2fp6l7lIL+c0+3yz+9npTrtaRvHQTsHGxjg2o4hl/JoKItZsGuomLheNo85ZpP7Oe/0Ns7PqGJxjVM43M/JruRKKrkEGvoKlYmb62iEnZN5D8op+M9MrkrF/BJYLTxiaeppvanASPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euIY5KVU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4126aa42402so2375e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708332927; x=1708937727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA8hL0vmryN9XM9ciwuNyT7l7HkIEUflQrFOUN/duUY=;
        b=euIY5KVUzXFzVnvWfwSpnPOkqzu4zGRU9O23YszpCpyJKpmmLzljZIvimVTd1tpj5Q
         JX9CKf0/96KnGkLfufybftBnFHlvQK5qWnA7CskI8TegoeAZ4GaaSSGoDlD4bgXKAv1c
         hFbJsGyYU+Xf62zd7xgP72RN8Qb2XldDppINPNlutGJbrt8mziHx1oMyA7GmFuRpEd/d
         9kXkdDgwoMSjR+3u90sBVsEyjPaAzcmEO+Sy97mK/rw52yM9kJYWJFBzxU5VxThZjaFE
         I+wnju4eo/pOIz+rWyv3ZQBRk9m2V9gPJGA6aSSpNqLKVkKyZRvo4LV1cXZUXwE3ogyI
         acFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708332927; x=1708937727;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA8hL0vmryN9XM9ciwuNyT7l7HkIEUflQrFOUN/duUY=;
        b=lckxzvjgdfsWmitjTtl9tx9aP+HbeZL6XEopqbIjAc5pyN9DSOF6lt+J+sTLTIGfRm
         Bn8X0wM78ya0bo4e445h4o//Xco3iPjSQ8UqITVL8KnzXBz36DtvOcAXSzNd7U7DIsfp
         X5TiVmgRKf2tthGyMvyG6GOctitOEJOorY8MrlvMEE5JPxRyLgnIDScogtagnwMTfCLx
         6Gq9JIc+UvjVDq1bwQ5UZGtW9/gZSeVACoCusIxfbzWwhmXCl5VuF7SXDR+q6k0uljYX
         CAyr/mezOG7m7vCGvCB8whUVG0dAjve17TdS7yghlWE+Jtw3yk5iI2YYt5IGSQSKk2Fo
         IqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7skP5SWkExzCCOroKrrOP8dfNpotB7zDvfHymbqZ7TUKZTXYOkNPZZF9NEGbA/hk+2YDwcoYwvoAUPFKoo03G1OcXI4FO8L5a2SJ8
X-Gm-Message-State: AOJu0YyxKl18Bf2syUObvT61ROyEhJOgPcs9quq2yx6U6SJr0q68mhaU
	UpMgG1Q5O/9KGX4yw+Ki5j3/ClQDQf+MWcUh3NzvalWF5RXX8ZsHE4B1iN1K0/k=
X-Google-Smtp-Source: AGHT+IGXNRor5SWq6PVxqhZAe3rTmCqaW2L1WMllERpSnnHE4+0llmEdPEPP8Xj/3W+6Y0poTE8lkQ==
X-Received: by 2002:a7b:c415:0:b0:412:e80:be4d with SMTP id k21-20020a7bc415000000b004120e80be4dmr8310293wmi.36.1708332927387;
        Mon, 19 Feb 2024 00:55:27 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q17-20020a7bce91000000b00412656ba919sm2952458wmj.20.2024.02.19.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:55:27 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-amlogic@lists.infradead.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
In-Reply-To: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
References: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v1 0/3] ARM: dts: amlogic: Three small binding check
 error fixes
Message-Id: <170833292669.1750802.15916025234070714227.b4-ty@linaro.org>
Date: Mon, 19 Feb 2024 09:55:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Sun, 18 Feb 2024 12:19:56 +0100, Martin Blumenstingl wrote:
> This series contains three small binding check fixes.
> Nothing functional was broken before, so no need to backpport any of
> these to -stable.
> 
> 
> Martin Blumenstingl (3):
>   ARM: dts: meson: fix bus node names
>   ARM: dts: meson8: fix &hwrng node compatible string
>   ARM: dts: meson8b: fix &hwrng node compatible string
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.9/arm-dt)

[1/3] ARM: dts: meson: fix bus node names
      https://git.kernel.org/amlogic/c/0a20438f4531b55393a2e85bd0cb9cc45362a6a4
[2/3] ARM: dts: meson8: fix &hwrng node compatible string
      https://git.kernel.org/amlogic/c/6f2cc11b4340cb5b0f81fe72eb732144bc7b6287
[3/3] ARM: dts: meson8b: fix &hwrng node compatible string
      https://git.kernel.org/amlogic/c/778a2c000470ee56551d0833a0eaa387530e4bec

These changes has been applied on the intermediate git tree [1].

The v6.9/arm-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil



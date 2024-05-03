Return-Path: <linux-kernel+bounces-167376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793388BA89E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335232830C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CF314885A;
	Fri,  3 May 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKYOko+8"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7910114882E
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724642; cv=none; b=nk8vLCMr28TKJZkgzM3jR+KW7FhWCLdgYF11JV9okF7R4hd9xJYc0g70Rb3qlc5X/e3+DBmhR8U9FB2lEaeY1JoAVblKHEpoh906OMnvCWrYRd6zaArrTCNKjmAceovmWYnq3MBRiEMu3VUHr/2v0Ya7ae++x24odVq9+cv6SYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724642; c=relaxed/simple;
	bh=CGnQNTm/qqU9IBROhR5EBNNaq9Y0pf++RJ9C0wJT1Xo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=goLRncIPCgY8QJugVt07sjihdPd8JeafA3Wst/dHwHatXXQfh/crGkiJ3xkF4Y0iUuwCb5zEK+JkJuKNLqLr4RhPOgOPojoC38orLZmSchfDI5FMKV0aGkgdehSiwQ/R1xEjJCjzvseIWQvWhWHtZZFl/MIDQbHjgFlZPYlkVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hKYOko+8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b782405d5so76870205e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714724639; x=1715329439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=et6LYnCnjjrqaS0ajC2g4eAsd21FS3OIwXp1rsweKIM=;
        b=hKYOko+8F7pKWEeGPtxdqqRGDMC28V34f0AvPuuEaXGZS/lhF1nUECIAFrg0+tY5vj
         SlNurk+8hBwdPj8saIdfkJwJ1Z8JLvIfZFN9bL9saGI/gsoRx16VO8auj7DskkgSB0t/
         DlxtatV9DPBjnuIrk3+NgqXR8gVIm97GGDL9Tcs3XJYLO9RANEiCYwkqAJHmbbzt+Nsg
         JYvB+3Bh8rCoTKKIIpeixqJz9FIiWh/Ovuhkt2Yv8i/Roq9agYxomUSJPv3dIUV7INWn
         lmNJ28sCONomyqfip1h92zxQM2B5PfN7VX0kBFbuBboEAWZfph6EiihNHiESHC/XHV5B
         Cv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714724639; x=1715329439;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=et6LYnCnjjrqaS0ajC2g4eAsd21FS3OIwXp1rsweKIM=;
        b=mh9sppKVlhpdu9EvmykMAlM4BGIt4hGrn54nqqcKuikflPlXSA5WszkP7Jcj/CO5xx
         w6GwLm1v/3g1kxLhzE54dctZ5AqSM4W09EODnnki0FMyGBSSmzPmiyoEMdLfGjSgBWbA
         40u6SeuW0RX6h26yo4bgOqvK/zXOCwzdUhhNuPKbHf4EzbuPTwDpimEvVa+Kr8i3EtA+
         ciqPlMJZ+v9xSSFLaBJF/Rh9tZAGwJ9nXb4SJTc6Vflq47DebhyTWKy1fLoE2GDvTeD9
         P9Imw3uKAo/B49CLFZc9AxZq/EHlVN63jMRuVYIW7V6kd+yH7TDvECDiQ58y+23YiQ0y
         S4mg==
X-Forwarded-Encrypted: i=1; AJvYcCXnPiPumOlKoopjZBOyrEh86u09bZpPf17dBS4yd7IK17XHUMMXY+U++UXXT+38Yt8hBX3VkV93cWWuVdwHQKSwEupF50qAQULqHPv6
X-Gm-Message-State: AOJu0YwzsJR+GMqtCwfJX5ZQ481AmkvqLih1w3GTMKQV9XDAgTJ4hR/0
	CGg+h3u351juTlQJeQQZd9p+zDoEO/NrV0MG55Y9+sIXEioYmRy+Pt+La+TCNns=
X-Google-Smtp-Source: AGHT+IFbJvf/A1i/LY+L7YNCn2NMJ6Ar57AENdV/ab6ZsQGTGBVmw4kitluYmeYo8l2QW3VK+WFZ2w==
X-Received: by 2002:a5d:480e:0:b0:34d:ce14:c419 with SMTP id l14-20020a5d480e000000b0034dce14c419mr1886518wrq.7.1714724638437;
        Fri, 03 May 2024 01:23:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id s3-20020adfe003000000b0034e8a10039esm136834wrh.10.2024.05.03.01.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 01:23:58 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-amlogic@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 khilman@baylibre.com, jbrunet@baylibre.com
In-Reply-To: <20240422-amlogic-v6-9-upstream-deconfig-dsi-v1-1-01511908477c@linaro.org>
References: <20240422-amlogic-v6-9-upstream-deconfig-dsi-v1-1-01511908477c@linaro.org>
Subject: Re: [PATCH] arm64: defconfig: enable Khadas TS050 panel as module
Message-Id: <171472463780.344144.1485415806892562407.b4-ty@linaro.org>
Date: Fri, 03 May 2024 10:23:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Mon, 22 Apr 2024 19:18:25 +0200, Neil Armstrong wrote:
> Enable the Khadas TS050 panel driver as module since it's
> required to use the TS050 panel on the Khadas VIM3 and VIM3L
> boards.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.10/defconfig)

[1/1] arm64: defconfig: enable Khadas TS050 panel as module
      https://git.kernel.org/amlogic/c/fb73c312a939cfcf9bae0d88fdb382516b424e50

These changes has been applied on the intermediate git tree [1].

The v6.10/defconfig branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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



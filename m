Return-Path: <linux-kernel+bounces-143689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AD28A3C4C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E67282845
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FD33E49D;
	Sat, 13 Apr 2024 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDxIiUHu"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C713E47E
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005376; cv=none; b=UMpeR4HJPl/vUIgks18tOZq45nlw84So8ekB+HPuxztFQeMXSlaw8CrzKqUP7EiaAcC5tbghXlgy2gDf02hpsUZP7cwzW65SGeuxyNYfGEuP+s4E6t/WbJcv0UZpV7NIi4+YdqkRBXDHQRdjmeQgRaGVnET7WIMkyrZ143I3x/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005376; c=relaxed/simple;
	bh=nzJbSnFdVVzUkaHaWzkTJAdmSnVWyYZV8bT9oL+etNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RznW+J9rc6L/GExiVLYTAOGncItEEdknHIX5qDAneVoFRUTlUP4mLWraPWcUfJfqsRpwk9DxwSkB6tiaKLWr1QzrjXov7p0PJh5UWunpsNegvlpKsQWWugA+u5c+n2nPpLpUwZJNjm2WKs+r8Wd+OqYXDD4qSMV8FaN2qnk8DyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lDxIiUHu; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d87450361fso20204251fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713005373; x=1713610173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8Z3HuYTbXEsN9VPtxZx1iO8X6HOC2T5LUFkkwLy2CY=;
        b=lDxIiUHu08T4td4Ep7N/1eXZ6DFz9UAPFHpzlXj1bD04eWBjIlly8HJ3kLMdeIDdp+
         PO8oDx73iQt73RPGuNiI8fR8LWYZPs31M8/xwDRMBijhqUBIaeUQtzyUvQC0BvPARNJQ
         oCjLeYgvCxmlhv72cROnyMI4xMraFPXaomy2RxIIhzvBvGiBMbY3Aui0vvejkivqxe+5
         1Pfmj0+s0HHgIjyqThAP5qv2lx2m8KGRaGD+ge/fAsYOcr2+3dhx6Gl2WxGsEqEejM4G
         e20icyTLoeNCTpCIChW/Fvm6ZTN8wKKx9Uh/mNE8I8B/uHdsNnDTu/gZZioEv6O4LYbv
         mPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713005373; x=1713610173;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8Z3HuYTbXEsN9VPtxZx1iO8X6HOC2T5LUFkkwLy2CY=;
        b=fg0ai4y1a+pushTf8EeMTP4Suqxy4IocZZlgh/XbgrUIJIahK5CCU8WuzPpZxGtNqN
         h4kvBCH1RW6zrDgdmXoZ8dFTG/bSjryNRbvwtl7ed/Ylfm/OAAPIsqhxsNEcV8HsJzcT
         PpZnPfuI0u2sFNAeiFCTjCv0grDlB86zKsZ4Et99GhNog2r+wYZkLiHo2IC8ZefUZrS+
         64bPr/CG1WRegtpni5DF+W0CG6NsPnF2PhzkXpRmUmdnifx/gBvlTvWg93qZwH4td5mY
         lP522VRNopGjCQHiv7MSr/Hx+3FolhZTKdRDBXNAhOfehPxTThu3UIVWDFeFGCf+Kd1S
         8X3w==
X-Forwarded-Encrypted: i=1; AJvYcCVTUTzVj/I8/LEQu0DzLL/b+fxyx4cEqzruYIo5x3N0DppaxnfSAnMB4ISfcvCrcQI34crzO3iMQzRGX4ZtK0gmgK1wUswqS1LmPk45
X-Gm-Message-State: AOJu0YxUgV3hqqDY2ANtheXiRSYzzXmEgYsQXg+8KKQlX+CD11TDU9s6
	W4vsyKwtjQDyLqhls7sL8e6soR88GV3yZ/X7Ly5rjs/cGBnhvCbL3qOoFo9IVNo=
X-Google-Smtp-Source: AGHT+IFRlSclFgsL2wUSNBWFP88r1//PYF242qEGLw4ADw0HNI/ly/0JDW3YbP3D5Z8Od3QlOEEW+g==
X-Received: by 2002:a2e:7a19:0:b0:2d8:63a2:50d2 with SMTP id v25-20020a2e7a19000000b002d863a250d2mr3328521ljc.6.1713005372978;
        Sat, 13 Apr 2024 03:49:32 -0700 (PDT)
Received: from [172.20.10.4] (82-132-212-30.dab.02.net. [82.132.212.30])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0041665b6e111sm11732864wmb.12.2024.04.13.03.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 03:49:32 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: neil.armstrong@linaro.org, khilman@baylibre.com, 
 Mukesh Ojha <quic_mojha@quicinc.com>
Cc: jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1710259663-14095-1-git-send-email-quic_mojha@quicinc.com>
References: <1710259663-14095-1-git-send-email-quic_mojha@quicinc.com>
Subject: Re: [PATCH v2] nvmem: meson-mx-efuse: Remove nvmem_device from
 efuse struct
Message-Id: <171300537169.23753.14785841851692564085.b4-ty@linaro.org>
Date: Sat, 13 Apr 2024 11:49:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 12 Mar 2024 21:37:43 +0530, Mukesh Ojha wrote:
> nvmem_device is used at one place while registering nvmem
> device and it is not required to be present in efuse struct
> for just this purpose.
> 
> Drop nvmem_device and manage with nvmem device stack variable.
> 
> 
> [...]

Applied, thanks!

[1/1] nvmem: meson-mx-efuse: Remove nvmem_device from efuse struct
      commit: 9e29a1dba59bcef937af7015e53d113309f49231

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



Return-Path: <linux-kernel+bounces-143668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F58A3C24
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B371C21393
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3638FA3;
	Sat, 13 Apr 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MAev4S6o"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAB1BDE6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003077; cv=none; b=apfh4d7yzYf//kacYgCo6oIxmSXxismpxjQQc+eVD9+Ow6VDZDTt1vgvHNFKak4fa36MG7IoU1akc+f2gZUnlaF8zazJcHXvPpYcjHTbvludFTlS2oFXbLde2REmeA0OxE4BebjS5h32X2bpBI9mlwxiZckgou4MY29CwLXFXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003077; c=relaxed/simple;
	bh=GTnx26jyD576A9spBEofCrW+259pzNhlga+m/yDLy54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p8CfXNg36vuE+1w32v7N+dh5Hqa9PHLBou/PLl4tDpMgBjYbw1MmXPNO+madxnTAUE8bACcy/9AVdQ243qmkufc18kdGO1QiZyN2bEkBY0sGF+p9zoDJVQziRqpnmwKkuoUJx7FoVGdjAsqLcVArY7qIVhQ/UsDjfHxL4pkNOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MAev4S6o; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-418247057cbso1778025e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713003074; x=1713607874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCfWmtiLGf5Dk/iFf/fqzadXNsrCvt07/+qhRgK3ZMs=;
        b=MAev4S6oFM+U6IIAyXDPR/JciWkN4602CCssZ597vQPx19ylQA+BHcveHa+MQO80cm
         hBoikERzB24VHaWvqKzGXKKXVLjT452rQLZ6SOqLSl9I1GwPc8Rz0wLovJU1NZkjbgVA
         jdZst2PgvLLd6EgbA0pSs5lXh+GQaomH2TZ1QH6VkaYFfU5VYV8kKLb2LL6eUnFrgF8F
         s9/1smFO6roIV7U4/e0EghQfTP7eYPc17FQI69c+WQSa591l1aOSB9p0U9weK8j+t0nZ
         Y+vEzfmYyH3VhB4SIZA5NmlzKZslIAUgP+lJ1U+ocv6x1teqcmhfYebiyaQAGbE1jEel
         VytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713003074; x=1713607874;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCfWmtiLGf5Dk/iFf/fqzadXNsrCvt07/+qhRgK3ZMs=;
        b=VgbMJAR7FX8Fbvvun9Y9lbux7aO+RHoTOA+o8QqO517q4FiUTfvKyQ2EbFLpiPU1A0
         C9u1NkHnFMVb7+gHLpKPvRrKt+JySaDXNEDNVIe8NIgIkcrVMrENYm2AMay5Wjl4P+ka
         vr+mlTBIf8qJ0RfNv8sVrHxjEuHaS4sNxIBjMri7SSc06hqU5scpcoIGDXHDmly6/8Px
         LqYYKJN14nMBIEmgR/veWqu5F/2CP8juIi0HMdPfmro3Kcgy9qVIecXUku62nDfbKt9f
         jfvvHyKec9Ix9psjac0buYWfCfkjup2EwZkfmv8mEvM4X3TbxQrOvzhQNGR7hUuq+I/S
         rELg==
X-Forwarded-Encrypted: i=1; AJvYcCV54KaExv0JSs+EWuHk4BEjLrfO7BWBBOM/P3hjEXOZOksW5A4EhUxLHIIZ9LGi4n1DNGQ77N4XVtjxSdkT0cxGs4WoyPAl1tBPVBTQ
X-Gm-Message-State: AOJu0YyPyYaIVAwN6HEnSjJaK3bPfQQMQHkegiqtB6R7dn5kRamVI71G
	cf177L2E2uCY83s0BM0MyR0h4scL9xCqvj7MJeCYGGVNc0SW8OS8FmfkOcqv/Vg=
X-Google-Smtp-Source: AGHT+IHnEx7mY83f6FxHfhh8wbkbgUNNlUcijZBsKkq2m9fO6al3hltka+gyqoXoSe0DdGsWQED7jw==
X-Received: by 2002:a05:600c:35d5:b0:417:d4f6:1aa0 with SMTP id r21-20020a05600c35d500b00417d4f61aa0mr3363740wmq.6.1713003074305;
        Sat, 13 Apr 2024 03:11:14 -0700 (PDT)
Received: from [172.20.10.4] (82-132-212-30.dab.02.net. [82.132.212.30])
        by smtp.gmail.com with ESMTPSA id gw7-20020a05600c850700b004146e58cc35sm11773696wmb.46.2024.04.13.03.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 03:11:13 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1709662869-10569-1-git-send-email-quic_mojha@quicinc.com>
References: <1709662869-10569-1-git-send-email-quic_mojha@quicinc.com>
Subject: Re: [PATCH] dt-bindings: nvmem: Add compatible for sm8450, sm8550
 and sm8650
Message-Id: <171300307263.22846.5421120272134098432.b4-ty@linaro.org>
Date: Sat, 13 Apr 2024 11:11:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 05 Mar 2024 23:51:09 +0530, Mukesh Ojha wrote:
> Document QFPROM compatible for sm8450, sm8550 and sm8650 SoCs.
> 
> 

Applied, thanks!

[1/1] dt-bindings: nvmem: Add compatible for sm8450, sm8550 and sm8650
      commit: e5630036dab1a99720b129360dd398bd0f19d1bc

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



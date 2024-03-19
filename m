Return-Path: <linux-kernel+bounces-107742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2D880112
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495ED1F21C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDED5657D4;
	Tue, 19 Mar 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEw8RiMv"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668AF46BF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863357; cv=none; b=jN7Q/BzOpWQHCeQ1eNk1+UBhGGlj/1PHy7j7QDLtVvcVm8ds8BgkvwqwKZLPiwAOYyZgsLPvQwElOYLt7ftV0it1YZBMpGQiKD6f/zQTkGRMk5RfWp3NfjYAj5pZEDUyozE2niM4rECYgedc3s1eGdLgnRXUBwyYpoo4TUzmDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863357; c=relaxed/simple;
	bh=2pyYCimS//Qq6yBYv8hqGm6lMX6inWdKtpT/73DHq4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fRaPGGAEXdeBVSXdMeXigqQqeIW07GBC4iK2//GHNqb0MG47lGUaQcfC/7TxJyv4hMXNG6JwTWf7WExxa+x//GnSR0KnKv9a+7kKSKWKUZdIRVeUKRKFgIZkvuTtaP7f8j8PoMn7iwRK+K71L3yLaPifjm9xnx7SsMuO2+QTibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LEw8RiMv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41467d697a2so3679065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710863354; x=1711468154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADtjyGn0eFpMcL5tcHRmk098Oppmok1FxnjO4slrBOM=;
        b=LEw8RiMvdDcBWTPLnVUdK8ELyXyE/23UjjnhNp+OpukaMJKXO4ZwyGoyV2bgw051Ft
         83ztXeLP6s4v+IRQdlx12l2hkxyyyZfj0v7th6Vt179yOdoYiKZp14t09kd4fuTyKnKa
         T6F6DTB/nD24RhuO3L1RGJTG/h6wAybvolK9n01CiT+FmJARu/AFfgvMFyra+JMXty3e
         dhVF2gfeiNMHvSyBQ0mZ4y11plAVMjgSNlHpUfPGO6ZExsfU45on6dnMewWkihYMHaQy
         iz5TxrkErQAjtMyH8w26zVxjNv4+LoRiIHETviM9h68Zt0XIw5gnJoBna/4StYr+wKGv
         b4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710863354; x=1711468154;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADtjyGn0eFpMcL5tcHRmk098Oppmok1FxnjO4slrBOM=;
        b=MtGggNs3YxsXhPHVicsiL/l2fl/paRrKGMH3rWizNjWsdsepaCdli9C10ggkXDkBuu
         vftf5XVU2Mxp1ko7xToRBGXCgOs3UT1i041ZPmt/i6O/LhtOs5JrXb0bRLVi4dDjUPy3
         MrvOXheluA5P6KnOAr69KrAmIMydbyKG/sIgDVLaFaMunRAWlXQf8/1WFvP88YPUiN6J
         JwRhH59y+yuLiJPW/g8VWYl30bs8OlFkKMgK4QfBZttA+4IvgoPkQYgiboo6jvwha4JO
         neFaiLpL4hh192XqWRepEaalY+KT1Upu/mLg+iVOJf+aEspSKjIVXsrI4U3NQTIbaau6
         0N5g==
X-Forwarded-Encrypted: i=1; AJvYcCX/XCEcgh4OYeV/l+S3+Lc3wIeIIDKfQyiaO3yeUrkbMpxACrDP0zHnLBoDfCHpstHv3jq3RpgkCwAlphdcOPclv1OPwrmEUif6qA/p
X-Gm-Message-State: AOJu0YwEHOtPKPogbq7bW47CPvUlMuLyF3Z0zSY7jd7wtgbRl7714V1f
	LHh9OCgB0R6MB1QjrF5PF+CGlOXyT367CtQgq+/VS7a48I0O9/21wolY+RAQN/w=
X-Google-Smtp-Source: AGHT+IHrOnj4CaHghcEG+9l8AS5c9AIXpcElhpR8lUv76uiBOgUiYCWAhhNkUgilfTUHBoAMu3DNnA==
X-Received: by 2002:a05:600c:82c9:b0:413:e956:6893 with SMTP id eo9-20020a05600c82c900b00413e9566893mr14388206wmb.41.1710863353717;
        Tue, 19 Mar 2024 08:49:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b00413ebaf0055sm18742915wms.7.2024.03.19.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 08:49:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, sam@ravnborg.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 thierry.reding@gmail.com, Nathan Morrisson <nmorrisson@phytec.com>
Cc: w.egorov@phytec.de, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 upstream@lists.phytec.de
In-Reply-To: <20240318161708.1415484-1-nmorrisson@phytec.com>
References: <20240318161708.1415484-1-nmorrisson@phytec.com>
Subject: Re: [PATCH 0/2] Add POWERTIP PH128800T006-ZHC01 panel
Message-Id: <171086335278.3926836.15356889496427917031.b4-ty@linaro.org>
Date: Tue, 19 Mar 2024 16:49:12 +0100
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

On Mon, 18 Mar 2024 09:17:06 -0700, Nathan Morrisson wrote:
> Add the device tree bindings, timings, and compatible string for the
> POWERTIP PH128800T006-ZHC01 panel.
> 
> Nathan Morrisson (2):
>   dt-bindings: display: simple: Add POWERTIP PH128800T-006-ZHC01 panel
>   drm/panel: simple: Add POWERTIP PH128800T006-ZHC01 panel entry
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: simple: Add POWERTIP PH128800T-006-ZHC01 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3b2304cfeddd141523cb50cc1a3ba7624b865011
[2/2] drm/panel: simple: Add POWERTIP PH128800T006-ZHC01 panel entry
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/fd6aa8f2dcb7236e511c1a58d82c2a178170e6ff

-- 
Neil



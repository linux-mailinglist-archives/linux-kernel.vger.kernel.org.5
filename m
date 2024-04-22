Return-Path: <linux-kernel+bounces-153167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A558ACA81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8091C20EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4A13E412;
	Mon, 22 Apr 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6V0Dptt"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C34502B4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781385; cv=none; b=fItbg8F6Tv0PmnG37zTXXCykXsfOMHmZOW8fJkvTw/bPnIlHV093cvfd5LTbzU3WvwHc65fueeASxP1ljowMaDj4ACV2T4hToHZLIkfUo0Ifh1uMyHFllnepuodf+05gjNYXlg+1mQ0g7sjAsN0COGBdswWgFBtpCzkQolkFVyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781385; c=relaxed/simple;
	bh=07OTTh3dMLAPH+A9FRxh3NIAtWMJ48u3f6OlZGS7JpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eUaOT2Inj3Wl+8wgxNCcRRwK9D8uNaUELkFDN0V0GKT3MYQtfjuCYy8f9UZoLptG2IPHxdVNbPkWDflZul5Ehl0GgNCTCTgu2h6cfFgONYYpbS2oMIbAcgtQycOfLjq/rA92Cf0v9FxpQnsNP61TJAxyWYKJYaDR57rm5crt92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L6V0Dptt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572144e4dd9so395595a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713781381; x=1714386181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4MOAzp//r12KAAFcyy7AD2TaQ/ckhSJhCVYAqvJqv8=;
        b=L6V0DpttSrD55U8KoZPpuyxUyhyyFKozkdnsUnVWgD1FNUYPZC8d/lWHuJZbOV91KE
         IIJmxYT39SSe0jpKLzYfAVHnin6osbeUEdsYKvxIkSWo+fp61THQoabdWHr2z75NcI6y
         sFAebirSrxtq+KdUh+Ke7HmHjcVpar5eb0QV5QFPOheS2U+51zJ+EyCfFttAJWPW8YX7
         iEIhITpIq00c//34n35si8/2CoPMybKKKSQK0KaNCc29KEHCVjF+CO4L13/HZp0RqYiN
         GCcwljzolJM0CIE3lpm5qgWHy9K6wB0533C88PnQfjzEzTo0xEEbPgXRD0hpgLtQeA0q
         jWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713781381; x=1714386181;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4MOAzp//r12KAAFcyy7AD2TaQ/ckhSJhCVYAqvJqv8=;
        b=gWUantU0z44mxd6O6VAxIWjJPYy4t1+8rV3Ff5nibfNjaQJ6w/LPJNdrMK+E4GPZJn
         t7PkubWiSZttqSEwP33TmWKC4MjP1Vq13U3261rWRh9SzJ12/uKpYzvhQ0c1wb1oJQQb
         09W+EVhXNbD12sBbyo9Nga1UHSkza4fNfcJ7uzn/4IgdHeapoISIa9UIaBq2w5Gvb1fs
         gFZFkt1GiY3IkZoxprkHaJHCzphignDvX+pECFMvVJabE3OHamnKKHuMktSnBIvCqWI2
         BSia0ZVGXCXF1OfEo1JBNo1lu7uahdE6JL11LYWLH0EZHqI2GV+yaqgOkNyHSQNgJxFA
         O+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXsseVBKVHnbKnTvINDhgAhLoi4flXF3e64wjCHYLa+jdR/TRutvpTDkNbJbzhBGYw3+0hRDKm6BcMQnir9sfJ/47i99dr0TI1CYzh
X-Gm-Message-State: AOJu0Yzr+jCnoLDkOAWlANVFN8aBs+vjhOJbWeek8DuOr+Bq2u2331vS
	iwlF8zVQcozwPgJfwkhzXPeuoOYTIe6/vjGZ9U8st3VCWAOk5E1fIbwJR+XQpkVEsnzMwlBoCHr
	s
X-Google-Smtp-Source: AGHT+IFnyaraDFtScDsivKAmXIVP6iLhVp9T8zalf4+MLsH1Tcsb5njnl6Kyb0jK1oQE4aO/N+eAEg==
X-Received: by 2002:a17:906:794c:b0:a55:a126:ac29 with SMTP id l12-20020a170906794c00b00a55a126ac29mr4331781ejo.62.1713781381229;
        Mon, 22 Apr 2024 03:23:01 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id bl18-20020a170906c25200b00a52295e014bsm5595887ejb.92.2024.04.22.03.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:23:00 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
 sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 shengjiu.wang@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1711026842-7268-1-git-send-email-shengjiu.wang@nxp.com>
References: <1711026842-7268-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v4] clk: imx: imx8mp: Add pm_runtime support for power
 saving
Message-Id: <171378137990.2925916.18282394508064276962.b4-ty@linaro.org>
Date: Mon, 22 Apr 2024 13:22:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 21 Mar 2024 21:14:02 +0800, Shengjiu Wang wrote:
> Add pm_runtime support for power saving. In pm runtime suspend
> state the registers will be reseted, so add registers save
> in pm runtime suspend and restore them in pm runtime resume.
> 
> 

Applied, thanks!

[1/1] clk: imx: imx8mp: Add pm_runtime support for power saving
      commit: 1496dd413b2e0974a040fa93a2ddc51cc9847fd8

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>



Return-Path: <linux-kernel+bounces-165205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515528B897B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741CBB21A1D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FB5824A3;
	Wed,  1 May 2024 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qG305f/l"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A197E777
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714564480; cv=none; b=YHbopHKmrh7h9DoeDLVMgrzs48MOlpO0QPCsqZf0H80Xl6qh4epuDOAfx+ge7buvpgW8oH6Pm/bGaISCI9MJk7syLIiZnXM+xd9LjR5yI3VmHEs8YKPH4HpcsFkxmVYZDmNOh4WfRqA3e02BnlsU7IMiLs+cSF/y0cf0ijZfPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714564480; c=relaxed/simple;
	bh=VgLKkmgQwkz24VDfpIkR7Ysk2CwmG6rtIKGUvwJr2P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbxsoXrK13YdlMLIrpjDDqXbmLrkfw9X9/SlBvtwblomVH8Pmh8CT76dwJAG5QXwnSjREt6j4pkCNepd9CcO06zGTZMNBp4hNA4iC8V7cesq5CV/iddZqGInH/h6pOjgBatogkPPLwvYS+cvvDXAfPNunPCV2/cOLtemtXI6uRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qG305f/l; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so7177182a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714564477; x=1715169277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWU5y5fq+7Sh/5YAl7I0WzeqGM8D5DqoKBNmDtAfIbo=;
        b=qG305f/lb9AJMQuRS9UYKZthKMnhVNFyInSeRDj44yi0rR4Yfl5Ze1xzMJD83ugUDL
         WXl9R8YOnqVpt+EkYm9e7lxXERl4QyAyhzzYbiwqWHfGGhu2c17L3MJ3H+VdXg/0XFWi
         LXLNm6tDt8Ry447DCFmb8yirTE73D7RM6iHEam0npJBneZnxsvPsvmv5LM9vaikDhab0
         brU7qzp4VisoydZ1gwIpqNBGg4mYNEDyzwTligLvSB8FMWTXbRKna/ktU2lNCzZfSbRc
         LKmTdvu7+1Q9XYw8IRMF+NKr+8WxI/XgzW1Y/spjLI6rrEXePTLje6h37sDtuEfDuchi
         iXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714564477; x=1715169277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWU5y5fq+7Sh/5YAl7I0WzeqGM8D5DqoKBNmDtAfIbo=;
        b=iPBcsZ1g/pirEYUWmpb6N+7B572NJ1MSnQU+batJ5cgSa0as4Fzv+ee9fy1olQg0Ru
         SnzaODcDBgzKmw21KmzLhAEWagc3YOanU56CC3J7o9epJHYQWRCQn4DYX07GtAWS/hQu
         hl3t1V3i1AePbt+me2Z+yYJZMM1HyMt5YtjV4ixohIXX2LusIu3PZtALPy5NUlmn677g
         fPWLYge0lblsKXdNRiOfCcNMM4yzS6ZT8t4/N2uZj0wzfHB3/OuPiQtE80gthadIz0+0
         +JQPapVpJd66pennZSKAyK8q5W+bphp+jnK0N+G0HrlNIvewbGkp2ZS0EtCEl95/FEy+
         hqng==
X-Forwarded-Encrypted: i=1; AJvYcCVnQvpczutlSMuWbYZiE7K4TwJU+Nf5ZM28aljLCYQ5DakeC1kGuU7IjOF67pBZPKWzn2a+/TFRSLgHxbWVTZZlXPFAY6aeCDjBUVgh
X-Gm-Message-State: AOJu0Yx1CG1tloxEObRFPGQufWe2VXRppshiW/NvFI3uQn83MYjqXxZC
	z4KnkRv9/GLP3HRLNZ6yJ406OoOR0f5pvXLnbsW02s2BtEHzMo6fGIY2QytIlC8=
X-Google-Smtp-Source: AGHT+IFvuGfM78B72ca+Oa4xepiLh6v1yafhkqQhzAn8IImg9PFRUyZjFCtX26ZD8B0uUZkAFvpSgQ==
X-Received: by 2002:a50:9b59:0:b0:570:374:d6ab with SMTP id a25-20020a509b59000000b005700374d6abmr2113395edj.3.1714564477326;
        Wed, 01 May 2024 04:54:37 -0700 (PDT)
Received: from hackbox.lan ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id q25-20020aa7cc19000000b0057203242f31sm11334987edt.11.2024.05.01.04.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 04:54:36 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abelvesa@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] clk: imx: imx8mp: Convert to platform remove callback returning void
Date: Wed,  1 May 2024 14:54:30 +0300
Message-Id: <171456445302.602991.15999220730191213802.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423071232.463201-2-u.kleine-koenig@pengutronix.de>
References: <20240423071232.463201-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Apr 2024 09:12:31 +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> [...]

Applied, thanks!

[1/1] clk: imx: imx8mp: Convert to platform remove callback returning void
      commit: f5072cffb35c122ec85d91ef327fa8814f04297b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


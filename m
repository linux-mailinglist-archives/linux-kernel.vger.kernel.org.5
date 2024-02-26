Return-Path: <linux-kernel+bounces-81032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB4866F98
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D49FB2B5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF1438DE9;
	Mon, 26 Feb 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTF/xT18"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE51DA58
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938989; cv=none; b=d52hpsHCRskhO1Mbhp927ZOiWY5yam/MBcNfXA21siGdRW+jLYWGdb8Cg2ZowqMwGB3PDC/aZPy4ANMMxJ0FTkX0f1Pz7nJz6Hkw/aIhTDC0PD3eTA+tYdt/4yTvNWckVygvapA4OBnySfE0Xquo1Tw2VBAaHpZqG7pmC94iWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938989; c=relaxed/simple;
	bh=u2D1K14aSbuHQlYPlwf4/XUKp9ima91ZltaPpSb69vQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AmKSZzGQKRDK45i6WtUwdBDnp7isUnTrS2IbDVooo0saSVOyCLLdUeZ/JnDWvaCJSw+n+5HM9Fr2f6ouEFyjVuej2gsXZaY4QoZcB70aQBftcDspGRvEmYt+JPv9N5354ebx2dTKgSfFLO9gy1+nFrqJ7rNaCZE4i7eHJwJ2yGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TTF/xT18; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4348aaa705so85395266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708938986; x=1709543786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q52e/ahqP4T6pWmT8jNQjktGuVz+xJCyCIgv15kYLW0=;
        b=TTF/xT18ttL7w3NE/WATQKpUb1vEcT2wNAVqyvvlXGiClSWuUP35FkzBXf+1o8aLvi
         Oani2opPgFLnjc0fGpfcJ5pVlWg678QxNsCp8Hu4sQ2HdCLjjZ2zKcQED3NxWvfVI4xI
         rHTwar/4ZrMbXZz3m0OplzztlluOkSNOtb9KQfWPT7Lp+ImDqtay1w3IExqIliASmNBn
         JJ+sBC4qxMrm0ZEXiIWdlGxrwNtD0mU8qh9V+Qdmku0Gu66Ow9hEDyfVXXS6ltxPzoK7
         UZAeOIaJ/YHgDAYmDk9W/Tvdof342dYv9p7p5CleVL+4KFBUC8jCr1t3uDTobcQX6e92
         pRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938986; x=1709543786;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q52e/ahqP4T6pWmT8jNQjktGuVz+xJCyCIgv15kYLW0=;
        b=RwLm/+t00Eva1yRjds2VXurYRmasFg9J9Ae40ZnK/F1dG4BAVSMatUayCvx0VhqxGt
         VxKHREIo1tTCkF780kFWxaPXzpXDP8OYJDo4E7zXlNLjeMV3AkQqTwQAq8nyyTJ21VJz
         mUchY8X721z1BotSxs25FLAvAdqCWfhr1treXlSoLIQtIsEPO2l5NGGc8mgq5fNsrnYp
         oIekTOzq+lhFjprchcom5cbHJNnCbJpKdj7I2+X9DVQnfsAMm6MWVod4AYW5Gfox1rOv
         2Z8UyW6i1NBV86D17fDMxmSV4AkCPnA4ywoIXDkLK5XkCvCxw3TkAVU1AIoVbrkjG0IZ
         E/ag==
X-Gm-Message-State: AOJu0YzZ+lqO/O2eegmWIFucOYp1ShAWvYrI9KvrZbP8CqKBcs5wsOPu
	ymW3RmjXfNHa+0P+pwS/QonBcCebHGkt7KLPbXJbUX9EtPiUzVgFfwSIBo+MV+A=
X-Google-Smtp-Source: AGHT+IHCJnITCwMOFBnEouaFM5+XWHwJ6u2WI0iCbuf0+DskJlC6ES88lu/X8WYpnPi+CJgpZf4dBg==
X-Received: by 2002:a17:906:f6d4:b0:a43:277b:96b4 with SMTP id jo20-20020a170906f6d400b00a43277b96b4mr427569ejb.57.1708938986160;
        Mon, 26 Feb 2024 01:16:26 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id r18-20020a170906365200b00a3efa4e033asm2202076ejb.151.2024.02.26.01.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:16:25 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de, linux-imx@nxp.com, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel-janitors@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr, 
 Kuan-Wei Chiu <visitorckw@gmail.com>
In-Reply-To: <01446ce9-c0e8-4467-8b2d-fd736bc5b8e4@web.de>
References: <01446ce9-c0e8-4467-8b2d-fd736bc5b8e4@web.de>
Subject: Re: [PATCH] clk: imx: scu: Use common error handling code in
 imx_clk_scu_alloc_dev()
Message-Id: <170893898492.1768204.4132765783691588048.b4-ty@linaro.org>
Date: Mon, 26 Feb 2024 11:16:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 22 Dec 2023 13:03:08 +0100, Markus Elfring wrote:
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
> 
> 

Applied, thanks!

[1/1] clk: imx: scu: Use common error handling code in imx_clk_scu_alloc_dev()
      commit: e4818d3b3f621e996b5a1d1a4913d11ccf769c24

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>



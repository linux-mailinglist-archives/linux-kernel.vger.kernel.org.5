Return-Path: <linux-kernel+bounces-81033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA81866F41
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6E7282D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA5E47F5C;
	Mon, 26 Feb 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ic073+E3"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EFC1E516
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939013; cv=none; b=bgSJOuhu4hxEtdZ91P9SxHXt4W3m4iH1CkbG/xQQZBjwMQcGW2zHewdDM1ZC4uWr9Uv7kgTks7kOgDLezhCbg5InzIf5dAb6xqA1oxsh3kpOPcHBpKOM+mDnqj9tTUJQjNfxYIuAsnRrmF0CHWr07RvmvTh5lZhspNFfCsZp8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939013; c=relaxed/simple;
	bh=Upp2iFcc875yCuJA5X9ShBlOF4WCgv9wR6a1vPVlUjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DoFnAP3BQU3g/x5HxupgCdLVaC8HVGVx1bXwFh5wieSxiX/28TcXnrKZBOAXVCoFcc+oOaYnjF7Amf8ReA90UNarnlc7Xlnn/bawTH4c8Q2bggBKzx8cxvUIucJZ6WpmjQBJvrJ/OlDtPUxkBbY15sDY1mk5O1FQeR9FMBX2WTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ic073+E3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so3197512a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708939009; x=1709543809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMmWZOmsO0vyhq4eNQPTY608ecp9OvqMQOtT08KRhk8=;
        b=ic073+E3eft5HhZVlZT0LmN2JXx3kQv+clDS8krEa1fTxt6G8qnc/9zSvadM9SSlQ+
         x9IydCGoG6gJwpG8k9Sb6jZlGBxI/KcmUz2aSXfZualiuGjocjGebCN42zgwge/PUcZm
         3z76Ld3SxpGQtW7LxQSrQRSBhQZjQFjWtmbDSIZ2ACEYQk0WlypuOyLGZS/FuN4w88a9
         hNFFo7Et9b4TrxMmZN22yQMW3uTO+2H5wcdzShuqAKSqPZUKfnkSfofOQ6Z1LhASnaJL
         gNJPwQn7DmViTvJwtqL/XD6gTl8fiK4BoFatjMDv/KP/5sqNTqgcYjcDvb/nAObtvT0E
         WuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939009; x=1709543809;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMmWZOmsO0vyhq4eNQPTY608ecp9OvqMQOtT08KRhk8=;
        b=vQCOPjs5t/Kx5XRpxk0rhmsQYDty6bIpYMtr1rEStkY8Q5AyUZgsrrjRey2lTABZZT
         VlzuXpCKw7kkuWP51Gvnjhun1MaQlyU2xh/apk7JjE33128sUw4oVUq2Cde9coXw3ysK
         m/aQDVvc9dbVbG7n1oVgaW+RWQ03KxpbL/232LN8ekul4uDlWFY8AXbLs793LBGoblaA
         JYaqWa2k6XPwgeWNyjPewR1g6oVMzzl5rhc2V0jz4WQ3VT8Xp2duTlcpE0m/9Z4n4Oio
         BV3rwiWPrBdqpJMJLo6hUpBvO5/XVQAAfv9eTp/wokKctx7nTe5DIKGcIzcckFbwZ2Pd
         Zo3w==
X-Forwarded-Encrypted: i=1; AJvYcCWndbNDdugIwDpI2dQZBNY/4q4X5f5YwFvBebfAISg8Ar/zEWqK44claY+cKhRkaIJJu9fsDRW35wbEDO/PpjyumlEU41BeB3B+msv/
X-Gm-Message-State: AOJu0YzISVLyG+4aW+Ha9uOhw482BYm793NzAJhGiXusHzXyCAh2CuzD
	TRU05bAEOYyuntHyxGm5FJRjgT4LvPWbxqWiXFi/NJYeCy9ApkQXm3sKVd9nyVc=
X-Google-Smtp-Source: AGHT+IEyIbiGGcmhV5IKj2JAF5rpef/IBwu4K0kyDJ0jA11wqSHhARelVSGWrrVgdR5wuJbi84CiMg==
X-Received: by 2002:a17:906:408f:b0:a3f:d927:4c0d with SMTP id u15-20020a170906408f00b00a3fd9274c0dmr3937942ejj.26.1708939009689;
        Mon, 26 Feb 2024 01:16:49 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id ts4-20020a170907c5c400b00a3ef17464b1sm2225053ejc.9.2024.02.26.01.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:16:49 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
To: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
 sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 shengjiu.wang@gmail.com, marex@denx.de, m.felsch@pengutronix.de, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1708683351-8504-1-git-send-email-shengjiu.wang@nxp.com>
References: <1708683351-8504-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] clk: imx: imx8mp: Fix SAI_MCLK_SEL definition
Message-Id: <170893900836.1770969.7795991183882277509.b4-ty@linaro.org>
Date: Mon, 26 Feb 2024 11:16:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 23 Feb 2024 18:15:51 +0800, Shengjiu Wang wrote:
> There is SAI1, SAI2, SAI3, SAI5, SAI6, SAI7 existing in this block
> control, the order is discontinuous. The definition of SAI_MCLK_SEL(n)
> is not match with the usage of CLK_SAIn(n).
> 
> So define SAI##n##_MCLK_SEL separately to fix the issue.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: imx: imx8mp: Fix SAI_MCLK_SEL definition
      commit: 13269dc6c70444528f0093585e3559cd2f38850a

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>



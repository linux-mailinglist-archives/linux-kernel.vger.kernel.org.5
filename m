Return-Path: <linux-kernel+bounces-160487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2385D8B3E22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE901F284B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E023616F0DE;
	Fri, 26 Apr 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAewqCcQ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D4B168AEA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152279; cv=none; b=uSwqjdUMZLJV8kz9mcOXtqdUrViaCNXYItfx86ZFA969GxzmENeFcMraDNG9RfvP30O/t/i8OJmLRXwyFZlvO8WGBvyMRgHS3zmtH3NOCwYS3DFO7oe85t816W6L/XiqmjsTL7y49tAm6MKkMUykFpR9IcHQnORFFnARnmAh0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152279; c=relaxed/simple;
	bh=NrJQfy/dZX+0xrd86EB8gzFj4x74J+OOJ6P+xBVcn+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AGA78Vi8QvrlqTfhcpoaDachPfJBuKi6YBvEUfuXkBRwhKIfU14+HLLm2V+BIDrK+RUfqfumSXNPD5y93ReWrkiJzlDjJTvLyWplUxggqzypr8ySzR/xQJc4XZW5ys4iO6z7dxXdWDAh9LH8OwjBf/fJgLlDtk4u4xy608U0mJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AAewqCcQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso10150325e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714152275; x=1714757075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQGS+2ImTjWNnHCheazuATbvqdIfWl3c0w7fDTpZPcw=;
        b=AAewqCcQXl0DKqxze9tq1KreJhsV5aH48p62LMxVUhiyuwaTHQ14JDl0tslC86ZOLo
         mg2d5A+9P8gjYBILOBXawqltsmwKuYW8b3BQAS8+Xmr8+UzRGqGHQSQbgadQ1oH+pD2U
         HgBFltNb5lc+OHFQ3ViNlDfkHhtc4k1sqS7T8CL6PCIrLKqXKYFK6LzU2CrhbxmIrPfb
         fdZnej/0E8UEYHVg51S6kkuUqprgRX5g3WcvdTtOWNd6FaiVuH0QWG4aODVO2rE2JnMn
         56lX37AWZFCZOv2yidIY+zdNkMb7bGy5VXn47MY9a40WXGjRVmRvQ49l8mSJv6ho7P5R
         R00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152275; x=1714757075;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQGS+2ImTjWNnHCheazuATbvqdIfWl3c0w7fDTpZPcw=;
        b=mrNDAFUGMF6Kji3AQ36FOQ0OTp/2EhvX3m87RCyR8U3017C9v1rMrl6HS+hPSe9NAm
         YoedkAIsUDwuYEQJ+jW62RhtDY4sVS1jbHFlFiSYWWIpS/DriRNPCwQ/+bQ5cJ8Bcgwd
         ZmSknW6qyeKhlD0bjge9bszy9bDsbW9TAwVzz76xZz2OdpH78YuDM5zFPtU6LUNA12OX
         YKLzP28pTnun4vGjgOQbHgTCZcNu+3XKLwJAgcsPvplLqqKoG3+ur+oEZRg7/ft/TYWs
         5Ufs4IjIwBkbjCEMh5pN4WkPcITc8N3XGM5Hw7ZtfGb3vTBYhNHfa8Vg7WTazu458z60
         7WLg==
X-Forwarded-Encrypted: i=1; AJvYcCWaLyrWbqCYuou7qertbLu0nS8KTzg15mzUoPaJ5LcGLdd77RhoQhxs916H1rnYKKOuRa/TyLlTwoNdlB3GBSsXXk+VO2VWcMKp+dG+
X-Gm-Message-State: AOJu0YzPbbgh9EYlNEuhOeFy5jPXeeu6OhNj4MOgNcQIwdnjYjLZZrPl
	EYxhiHi45kOKc5s+eZ8RtDdOuZvHh44/VGETsZ0DOH1lnqU2gd2ixEAC/O8SVgiRQN+LgeATITg
	d+28=
X-Google-Smtp-Source: AGHT+IGEmzyhWJuTwU4JvwYETn4/dggvlzPnepnpq9zXXd+fIASo1x9F2is8E8VscY0zJsyUCyK1sg==
X-Received: by 2002:adf:e4c9:0:b0:34a:ce8b:7b66 with SMTP id v9-20020adfe4c9000000b0034ace8b7b66mr2500715wrm.4.1714152275069;
        Fri, 26 Apr 2024 10:24:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id z2-20020adff742000000b00343ca138924sm22893737wrp.39.2024.04.26.10.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:24:34 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Thorsten Blum <thorsten.blum@toblux.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Yuran Pereira <yuran.pereira@hotmail.com>, 
 kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20240328140015.388654-3-thorsten.blum@toblux.com>
References: <20240328140015.388654-3-thorsten.blum@toblux.com>
Subject: Re: [PATCH] kdb: Use str_plural() to fix Coccinelle warning
Message-Id: <171415227396.138568.14982776315029700963.b4-ty@linaro.org>
Date: Fri, 26 Apr 2024 18:24:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 28 Mar 2024 15:00:17 +0100, Thorsten Blum wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> string_choices.cocci:
> 
> 	opportunity for str_plural(days)
> 
> 

Applied, thanks!

[1/1] kdb: Use str_plural() to fix Coccinelle warning
      commit: 5b6d8ef6f056d8130168746c5459d7a3fb494859

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>



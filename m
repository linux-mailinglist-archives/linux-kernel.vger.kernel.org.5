Return-Path: <linux-kernel+bounces-74529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A990C85D58A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9441C21282
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDFE3E487;
	Wed, 21 Feb 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8OhAzkE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F053C47E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511404; cv=none; b=DtuI9phFUGM7Oj4aPb7VF3wE854DvDW1qJxF3+qJMQtndHo3pZ8tOt9JMD0JRyfv93SnWjFMJWB14QeBInKSh3bB9WwxZEatlhBLXfkPxLnPyhngq1nfmtIcQmGo+rb8uCsBZpUpdhr1KlzIJNyrtEml4j1HEujWp356sGCcZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511404; c=relaxed/simple;
	bh=zN3CUjyqFa6s+ccG3j8jMp2uTOIsTEDMHBCEpbfZTso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fWYmmZwsRVLLIn2ZL+tKazFvxdGT1hAQkQNO5EGtvgwe5Pk7loxP18n6aeuiU2svKJje3CsUgXWRSkCpr1EFAuW12ARsN4EZf5lR0ZyIkb11kKAoV1WGnoynAhJzwEsNdFtdxRGj4LrVIT0oTj9cle3Emxj1/EfgTbHNc3WrwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8OhAzkE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512b29f82d1so4637463e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708511401; x=1709116201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+mM4r5l6LdT+myeKsizMxXaYG6u+Ya5ehvtYFAaVog=;
        b=j8OhAzkECgP/tYLEZi9tFPzSxd8lh7rf8dwRqD7p8Nz1BogRGbQgqogX+OWMlgPqgB
         6Nh0YMCD3LhcefTaXgRwnMKNwDt+FwAAc8b1kJ3+lUP5IeiIIvPKOwga19On++z7yLHN
         YOtNDw+bBJLiU+U5UNw7P2cfgWnisIgU0KTpalgroN7BvUhpoUgBz/aioyAAa5TOCfsm
         Bqdu8k0zlKJkpMtfSQOn37sXvm45VmJAOkWupklAknpFf1Dp+VqDi9oK1NjhuEzuyhcA
         +zTKafZXEn34h8L4EdIAr55y05bxzY/4L4DeO1fGkJTTD00JbuaIs3rPFwcICNh6IVr0
         6BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708511401; x=1709116201;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+mM4r5l6LdT+myeKsizMxXaYG6u+Ya5ehvtYFAaVog=;
        b=Aihf26oe+VOcuJRn4iEWESW0vQ5cxDUYPgbgOE6uPKAaRh+mp8K8hFQecPCy37hTAt
         mPd4GIiYTQPXOLupj8wFTbujU9fj9EH2wzkpeZEFRHrGNNHNtD0bFR1k0iTCiDx+3idK
         /XAFzErg1DpArl4OHWDiyFvZmwInTlfglmFiXSwenKY//YwsFDK+woptTsvNdkTB+y7j
         WDFYgO1VkmFYCM9Ank/2RZkzWgJz/q1AMl8Q7oST3Im/UT8VHyKiIcWKXAxl2hYjuvWw
         p/dRf/R4J+020Rf1PSIFebXzSkx1mp9lo++7P7JmeqsLfixXQtHYeGpYjbYGS6B4s92h
         XZog==
X-Gm-Message-State: AOJu0YyqgDiaXYD4aXKk8zRoObp8SsqmBXAynIURGer7fZRdoDq6OHsC
	BFhsm3MPYvqVgdSyg/PzsdfUhEcT/VcxqGOPlLUZ6tA0vk1rqPj4sDYCulgRCZs=
X-Google-Smtp-Source: AGHT+IFFL+ABu8gjgfDs2IgE7A6VsxBjDJ7JgNFs6fxZ2tfP6QvuaXN9LjhLHtJOCqL0CyKELz72vA==
X-Received: by 2002:ac2:4834:0:b0:512:bda2:7bd9 with SMTP id 20-20020ac24834000000b00512bda27bd9mr3913100lft.64.1708511401064;
        Wed, 21 Feb 2024 02:30:01 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b00412590eee7csm14681095wmq.10.2024.02.21.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 02:30:00 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 alsa-devel@alsa-project.org
In-Reply-To: <8402a9a8a45937fe2e62617ff0c7408503692b20.1702745212.git.christophe.jaillet@wanadoo.fr>
References: <8402a9a8a45937fe2e62617ff0c7408503692b20.1702745212.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] slimbus: core: Remove usage of the deprecated
 ida_simple_xx() API
Message-Id: <170851140025.26081.6374799105426333526.b4-ty@linaro.org>
Date: Wed, 21 Feb 2024 10:30:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Sat, 16 Dec 2023 17:47:34 +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. So change this change allows one more
> device. Previously address 0xFE was never used.
> 
> [...]

Applied, thanks!

[1/1] slimbus: core: Remove usage of the deprecated ida_simple_xx() API
      commit: 6e8ba95e17eede7045e673d9e1b6b8ee1055a46c

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



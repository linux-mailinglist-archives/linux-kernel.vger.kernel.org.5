Return-Path: <linux-kernel+bounces-62184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01348851CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3178A1C212AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D6B3FE4B;
	Mon, 12 Feb 2024 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D/hV02gh"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2C45BEC
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762674; cv=none; b=rRlRh9TtlR/j/9oc9QpcnCR/gbcEbLUekOW7P/W0va0JoCr18yLJcG4A920h3XVx4eXbQd0nVb5mNm+uG5Bx0zfg9I09KpuHb2l6F/Yox4r556g4Lnnp6hzrKWtzkbSAvWu73I6yfNSoL8JjiAtLQdDBQAWYZ05KcGokBwLl9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762674; c=relaxed/simple;
	bh=Vi6c5axLczsjAfZ/jdvV6TZrVwfcoDXEpjFAYHPKp3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xa6o/woY8jESl4sFBERodWcp5wZZBrIkQMqFotHpXbqkPHS1tclcmBiHBt+zbcXRAIRthIIJn+mTG67L2vq50CJTSSfQcUes0LOCX/A2I76VVKKIvZRIpq0CWfvmfflzfAcZi2P84+QT2mP8ImXQrnXLWedA+WKfg53V2dPr8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D/hV02gh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d953fa3286so27313025ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707762672; x=1708367472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxYKfxVc01RvCqlquCukYbiHiXMELvJ7WajMr+fzZiM=;
        b=D/hV02ghUOW7InC8DBjnupW8sppG3rdPN97stTmQ+RJrVoAlwtCby26PXszVlz6gMN
         IQ/2x0kHiBbshyjEyJHdyWlay+FMLpZIFVVU5XGxS4Pzcf9dLeVWvjDKtKOpt/ix07x8
         4eD816rufukq9CNHbq4IUZRxgRy/vyHL/Z8jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762672; x=1708367472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxYKfxVc01RvCqlquCukYbiHiXMELvJ7WajMr+fzZiM=;
        b=n7gXiqe8A7mlm8Rz/DDDTeZIch6fHbKBf6Mlyzu4vqRtCbZlVlvBTsCa9dP7R2AJ5B
         cYiH/uaNL290TruoOlOOW8+ZRdhByqGkvHu9iGE9VbWRMLoxJSMTJaF6L9OnnKirPhl/
         /TT+qyZeBkbYkgSfBwalw1oiQI7qnSjORwvBljVTil607v4vAJVHUhJGJKZNw7wR1VV7
         BtmavDarUDmXZMgpQ6kFjrrPy+DAVFxL6FrUhV0RbRsvd6znOn4gcICrL9vHQYZOQh6G
         opW1aNyPLNSbigtD8xt0VqKXeWbXQBH6Ml098ZqKLQOXhKHdsvJ+i9176XrAJtLIdN+9
         89og==
X-Forwarded-Encrypted: i=1; AJvYcCX5A7o2p4L1DXDo9KUiLZopm2k3t37BgM8VECs/6HvfxOLUN553FxWlF+nf4OsV2Pim+Jh/ggHmorgDtyY857bjs59QWoK3ZuV2Liq7
X-Gm-Message-State: AOJu0YyhofsriR9Xg9chdoaMaUL0+GVv6KWG0QY5OWovmctKWYcJvUe9
	8l01m7OeJHoT2aq/yHrca2AoPHiMZCgciZfsCfGuzA/wdFUTciv8Es7pw4W08lJoc/Qm9XQsK/E
	=
X-Google-Smtp-Source: AGHT+IGgwfZ85ig5seHJCbnXSbj93G7dxG+Z8HmWUBYItrse6pgkNnMFfriCyi+RacTqAQ3g9R52ZQ==
X-Received: by 2002:a17:902:fc46:b0:1db:28b4:4475 with SMTP id me6-20020a170902fc4600b001db28b44475mr1656842plb.9.1707762672359;
        Mon, 12 Feb 2024 10:31:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtqiIrorFvqjkApbF3idZ0NNZ5ryhVf4jv0lvSRs8BQcLjw0NMWxaEQu8LPuqrHMfyobiwwul93Aab5pCDYkBrY9W3bg2i7mqlQcoAFQQyYmGUTas1LBvaN0eXhGp9H8cMyHhB2/Q3mp7GKvlkANpIW9Wsyj84t7uczus2LAnei8WalXriCMZ7LUDrnMYTV9IHk/9NA5/PiUoWn60yClB2etHXG0QPKoMNUOUSMw4PXsAhnJztLYYRnfzHD0wF74cnM93rATXrgJcTQSYTLZO6vb+CIVa6/29VJsTH2F0UCAA90uUT8BRGcKcK504=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f7cc00b001d8924d8dbfsm644712plw.265.2024.02.12.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:31:11 -0800 (PST)
Date: Mon, 12 Feb 2024 10:31:11 -0800
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Use kcalloc() instead of kzalloc()
Message-ID: <202402121031.4649560C1@keescook>
References: <20240211175143.9229-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211175143.9229-1-erick.archer@gmx.com>

On Sun, Feb 11, 2024 at 06:51:43PM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because DMAR_LATENCY_NUM
> is the number of latency types defined in the "latency_type" enum.
> 
> enum latency_type {
> 	DMAR_LATENCY_INV_IOTLB = 0,
> 	DMAR_LATENCY_INV_DEVTLB,
> 	DMAR_LATENCY_INV_IEC,
> 	DMAR_LATENCY_PRQ,
> 	DMAR_LATENCY_NUM
> };
> 
> However, using kcalloc() is more appropriate [2] and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Looks reasonable.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook


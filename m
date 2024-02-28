Return-Path: <linux-kernel+bounces-85080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFEC86B019
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528F91F2668C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B2F14AD2A;
	Wed, 28 Feb 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QLZ/qBuJ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D2149DE2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126289; cv=none; b=HVELWgL2Ad3cYArozCclbQomGdIMevCI7LXvpoWN89E29nUNRhH1vo/OtviWhOlX/ZxfRtLuvWn8hszEE1Eqg2gYyw7FTKEK9hilPbf4cZ+pn8aOQ5iXOUXviFcU53VDyXgfFLwowJCT/wmn6U68+cqiJuKMKD8xrr0A3vm1j/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126289; c=relaxed/simple;
	bh=T9bbLfFirb6Q1nmM2phZcrUMaD0qpbEtTd0EvaBl3FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpf1XCYFfMVtmyUZUqhme2st3QTW9DQ3S8oyK95er+3F4+K4lEk1GWvci/UaJgSgMnmmlrSq+POMDTXTCrX6c+PQG6QeakCnoZQA2A/sieVSEGJ0oP8iqPDCm9RGZHKEa5vKThVDnaSHO53wtBOG9qP48t1Q7oz7vhYB4IsX5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QLZ/qBuJ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a43dba50bb7so156657766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709126286; x=1709731086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9bbLfFirb6Q1nmM2phZcrUMaD0qpbEtTd0EvaBl3FM=;
        b=QLZ/qBuJfbnVkACL67qi5CM5l2c5DUHAAQvn6jxgBazY+u+Uc6dK4xMlXdULIt4K1+
         cjSTITePHBNifoSNyfeG35lpr9VejIJYmD9Da1R5C4pv1C3H4GWEcvRSG/J4IXFLouuM
         cufOW8Y03Qa+ntkmXoEttbApErms30V7HWAflM4vkFHSnMQ79ocmfVbXh/K87yZAwJ4c
         EwY7sI4x8aQiuiAAzFbIY94J6mWdhWNDwFXCEZbaQcrBJIQbbXECaVPEmhv+yZBOjnVu
         TFbjBf3DURhmtM8YSgPl1Xd80aa2RUoU8r/kYZwhEL/Eovk8Byx1bEQa7luXACNx7FLB
         YQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709126286; x=1709731086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9bbLfFirb6Q1nmM2phZcrUMaD0qpbEtTd0EvaBl3FM=;
        b=VeZDo0pfBN24NeGNCM2b0HPa6p8JnWnubCA7MeXbg7OfKeXWXC/USG2KQOpZW3zOtP
         mTFr0UUfkjRikx0QyXDbUxHttCkJDNxvsUxoMfII2rX5n0WfH9h3JmV8wOObraYLaDfd
         bfvlc5W5R9F5R2SPPbhzooCgGha9NQerd8rUneoppoXCMSwRQpx7feMtoVCWMRRZ1/BT
         +54y8xim9QBZIHmYc/9Zintx03GIFtgme9QvQqiFr7iZjZP7sF/imFdTjZkvEcH0JiCP
         /NJ9mDz4IUnVSF2/9nBSE1nyJGVIMGcRwYGqQ0feBck5HocGfwiBmiB/4FnnOwVa/xsd
         vjMg==
X-Forwarded-Encrypted: i=1; AJvYcCV6DxvbbnYAs/h+wecxCldAXUMe1lJjpmrsisZDl58lF/nDbH/0vakbyhKNZ9nRvEMThtdEQu/TrxC3yXMYLceLz7WwLk5EQ1zlfTCg
X-Gm-Message-State: AOJu0YxzWh1/tMhPc39vkjku44lZ2S2N1l/SKtJex1UDiGLvU14X49+y
	4oR/jLMVSociyiOAuaTICwc+zA/VS/Kf7LtMVE3XlyqlFgmL6mnajOU+/ZcYm90=
X-Google-Smtp-Source: AGHT+IHdtqRhyNQ/e0c4lOXcJPjqGyZ/p7KGJ83ZXMCkNFH4ojscfmGB3OOdDdX9tI4QyD8O+M4oCw==
X-Received: by 2002:a17:906:34cb:b0:a40:2999:5404 with SMTP id h11-20020a17090634cb00b00a4029995404mr8669065ejb.3.1709126286223;
        Wed, 28 Feb 2024 05:18:06 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id gw7-20020a170906f14700b00a3eb1b1896bsm1837802ejb.58.2024.02.28.05.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:18:05 -0800 (PST)
Date: Wed, 28 Feb 2024 14:18:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v1 1/1] net: lan78xx: fix runtime PM count underflow
 on link stop
Message-ID: <Zd8yiio3w_X0gR_a@nanopsycho>
References: <20240228124517.1702476-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228124517.1702476-1-o.rempel@pengutronix.de>

Wed, Feb 28, 2024 at 01:45:17PM CET, o.rempel@pengutronix.de wrote:
>Current driver has some asymmetry in the runtime PM calls. On lan78xx_open()
>it will call usb_autopm_get() and unconditionally usb_autopm_put(). And
>on lan78xx_stop() it will call only usb_autopm_put(). So far, it was
>working only because this driver do not activate autosuspend by default,
>so it was visible only by warning "Runtime PM usage count underflow!".
>
>Since, with current driver, we can't use runtime PM with active link,
>execute lan78xx_open()->usb_autopm_put() only in error case. Otherwise,
>keep ref counting high as long as interface is open.
>
>Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
>Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


Return-Path: <linux-kernel+bounces-89598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C886F27E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A6328254D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B9F4120B;
	Sat,  2 Mar 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="QBJYi2pf"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3E40BFA;
	Sat,  2 Mar 2024 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709413911; cv=none; b=g00gz9j0tZFs6dEHkq63XLttaZh9shcd494A+HRMLGts65ovPwEkF/z7bTn01XdUR6T5VFfbvzsUj64TopcmsbCyFIRUEKpP7VG+W9HvGsij0A14dgPpZVJ/O5Rjf/0ynMSbOAFJasfDNkT+WjWUnAjlcBYTYq3VXYCJ1QzA/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709413911; c=relaxed/simple;
	bh=+nKuWcSkrCgulQpup8ts4ihyRWO8OA4cRuW4ej5DjjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnSCbEacgjMB7bVcS8eXaBJjsGlgG/vsM0vcD+lzE2nYZAhlbdsh7dpj73e4aPkMHXQiTTEkCUsbHSRnQVeQB5dVK9RS92myTUqz31qUNXfbbO6uxoZSAH5Nm/ja9s9//LwLdVVurgIgSRrvVsBQKGYj399oRNA9ZHa5u2AQt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=QBJYi2pf; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c83788bfabso33665339f.1;
        Sat, 02 Mar 2024 13:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709413909; x=1710018709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=02ZLstAgwjx9+b3U1+SFQSp/H2Y/sSK2Rqk64E1/jYo=;
        b=aan3X3tyvX7LqCI7TBBgvV+UgMMrAncgzci/rF2LjTlRWIkKzOOtwt/MOqm2WPRI5w
         BQMAiARDbThBvZ1J9k1QYUx6pQtklLQgI//Xlp0+7NC59xE2vQLgRr7ckxm1AEhhfMuW
         mpZqtkgPtZnWI9OJheLnjokQFwtnF0fgmXjQrHXgmIAI9ma6iTU7o1d71AbGrLwM4yUc
         h957hhA7piW28NrSe8NcPkLDsGb/VlGefDc0CDUjuwxGdLyFuiYj1QuzG7aiwtfO/YoB
         XMTLi2EA/sv1OJYzAgKzBh47Q4vt7dhO/zMsIwVCPZ9gxf7tOMFgIhSqDmcXISSTcpTt
         UimA==
X-Forwarded-Encrypted: i=1; AJvYcCV9cUFW0dFWUImDHr+dSzr97iX4omDTD+b9y/BYGjvJz7mg3N1xqCKiuJ7nAh+VMacelWsjfLklCA94A8SgeWDekbxagA/8IGWjv9r1YtM6DGSRMWq8zie3m40XI7+kQLsHpN/R4S4=
X-Gm-Message-State: AOJu0YzNB6w5O1R4hR4JRj0+0srr0dqFhkQEYpd+jm8Tfx3P1/m2VBGH
	fFZBccAI5R+CU9TfF6c8tSQBqLSf88em7aE62rg6HVC/HsdGfEHH
X-Google-Smtp-Source: AGHT+IHTF2N0RUAaLJM8YxDxWnQmOFYXVA6wPUgWp1BVnzjesXNEDELPo5a0PLLV62C3T5tuAREwkQ==
X-Received: by 2002:a5e:db4d:0:b0:7c8:2702:404 with SMTP id r13-20020a5edb4d000000b007c827020404mr4389717iop.16.1709413908980;
        Sat, 02 Mar 2024 13:11:48 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id t4-20020a6b0904000000b007c7dde97be9sm1552642ioi.50.2024.03.02.13.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 13:11:48 -0800 (PST)
Date: Sat, 2 Mar 2024 18:11:48 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709413907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02ZLstAgwjx9+b3U1+SFQSp/H2Y/sSK2Rqk64E1/jYo=;
	b=QBJYi2pfH2Df2n1JHPMszibTUg3VIN47AMNfhIvd7dW3h1hQXREKAhItHUZlt5V1UE+QLz
	+OJ9GTyKYPpW642MvXZTgUSevxAks21pDgQZF0SeR2Fll1eXrqCO8QsykyfHtexdWEtqXD
	JZLV44eJ0bjWBOIq+lhzkyd7QjADkGyIPt3LhvzjYZp/Ux2OXOkG/jfyrODfVce+q9hbxq
	nF5gLvj4pW06Bh1bxtUNvfVOGUQZkJdc4eJA4DldQnQ+/EnZfurHYekvFDikjJmfoWQCsR
	lk1fs6x85fVU74uR4Fl/CSiSlSs9vtSJ7/7SlfpyzestGCsNRTIHTBRCoxnk3Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] power: supply: core: class cleanups
Message-ID: <pbcgp4e2q5qdid4xmyslpkidlxmhhtal64binfwxi7ktl66lwb@w6skhb5yoq4x>
References: <20240301-psy-class-cleanup-v1-0-aebe8c4b6b08@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-psy-class-cleanup-v1-0-aebe8c4b6b08@collabora.com>

On  1 Mar 23:58, Sebastian Reichel wrote:
> I noticed some further possible cleanups when reviewing
> and applying Ricardo's patch to make power_supply_class
> constant.

Good one!

Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>

Thank you,
-	Ricardo.


> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Sebastian Reichel (2):
>       power: supply: core: add power_supply_for_each_device()
>       power: supply: core: simplify power_supply_class_init
> 
>  drivers/power/supply/ab8500_btemp.c      |  3 +--
>  drivers/power/supply/ab8500_chargalg.c   |  3 +--
>  drivers/power/supply/ab8500_charger.c    |  3 +--
>  drivers/power/supply/ab8500_fg.c         |  3 +--
>  drivers/power/supply/apm_power.c         |  3 +--
>  drivers/power/supply/power_supply_core.c | 43 +++++++++++++-------------------
>  include/linux/power_supply.h             |  3 +--
>  7 files changed, 23 insertions(+), 38 deletions(-)
> ---
> base-commit: 71c2cc5cbf686c2397f43cbcb51a31589bdcee7b
> change-id: 20240301-psy-class-cleanup-6e6711d595aa
> 
> Best regards,
> -- 
> Sebastian Reichel <sebastian.reichel@collabora.com>
> 


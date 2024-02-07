Return-Path: <linux-kernel+bounces-56979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5E84D220
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18772B253C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E2285656;
	Wed,  7 Feb 2024 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDlba+cu"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3B85286;
	Wed,  7 Feb 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333301; cv=none; b=a8LMcn8F1sZ+I8MDHknlSCyQPguuIlo7NVyuuXJ/Yci8YVNzcQsgbI+QlfA3lBfYixsyB5mgLWEak6EDZqq6NcMCLuh7FJkya2XF5S92hTPlzaYy8QWRwU4SOtur51K2xG8smr50bsVsydvnYlLND31ivD0Q7spYKHKvGqweL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333301; c=relaxed/simple;
	bh=W5k1pVrv5LT4aNFcxZhVlTsA53EzW+dLt1NS9jhtrtM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hC3782fUkmGw1IjNKPAdoXXIKi6PV3uPBpd3TCtI0pNMqPxGTBiNBCmf+ey0+o/8AHGroClt+rcWIphoYta8QyWwiUat9TLM00TLYecA4s8ruDhNDwdVpNQ/tQXnHU12kqx0LqpJ3Dg7T9zEVNVrwZ0mU0AydiaMBysHEIF76yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDlba+cu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116643c64eso1784454e87.3;
        Wed, 07 Feb 2024 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707333297; x=1707938097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+zCCH6HGB9saSmIAWX6wClWcswuwqRqYjvjldtPTEU=;
        b=CDlba+cuUfRuJE9pqgkXHQanIQxAAJK2Lgx9mkKE7wbRUfWMCu0XMTqnHYwviioVND
         BsY2/d1EdKOPuc5g5LAbkhqRzG7Rj+yPB1PNPCIeGgzzZlZUx8wTqbgtr/zIXs3X6Thy
         DVNCmfvaGKHTln8qjfNCkckR3mb7VcvdK0t6wYw8j6ac4vcEmBIe9Z0EBWlv7f8Jq9eR
         W/g+dPwPWGjp9MTiueGHrLzgmUsF0qXpJ7aQROjQ5lEZbS8XX/u1IDPQZHBLYobdzxdb
         sAeIi9k7pVE3zTvS03IEB3YelQaJX5bdQb3d25+8oa/L8MOVSoYYIJnMUN45MA1inDrN
         dm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707333297; x=1707938097;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+zCCH6HGB9saSmIAWX6wClWcswuwqRqYjvjldtPTEU=;
        b=LYsbGNceIEJyXXinEXEdtjDC6RkGhRnkhmVZteYU2Ux1bXUJnLMx1ucwJEIpD7JEj3
         NZe/P0E0X5KzMpNND1Nt7TN3zsHxiFWjT+8HYlZdr2UqNP7o++3kR8ia54Cmg2xHFvef
         +DB5cY1qWYKCCR2VJqHlzQuN80OTT/dcoKOw5HgGzlS6pHotmGnZOT/RYhDcM9XKZzv1
         Ydknn37Tv2XYidU+Z+Hqmv+HYgdOLrlPjuRvJX/FTGdiY19wX0HOhqeRTjaXp5Oj78Je
         KPC3HYhha+YvYPdJP4zx2jOpfzoWjHNURCEaZclHm15YS4awJg6t7fLA95Bx82tDLPA7
         Vz5A==
X-Gm-Message-State: AOJu0YwIliP7rkaY+Rj+4rVaA2MxQp01OAkR1gaB6VND8rYCjuFFKbGp
	Kz7rWJeCMwqfybHNszul6h9GvtC8+zE82nnKasgRA+6LUe4d4kzW
X-Google-Smtp-Source: AGHT+IHKcU4DfAYC+ybYnEs2gLTCHxySWNSBciYIelNeHYnUZ8fPh5fzMREyBiwbBGy3clFkEm9THA==
X-Received: by 2002:ac2:5e9b:0:b0:511:484a:dacf with SMTP id b27-20020ac25e9b000000b00511484adacfmr4036038lfq.30.1707333297152;
        Wed, 07 Feb 2024 11:14:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJaf54joY5YOnJj/Ss0Nd4hGJAqbezIWP2b1kTCrTyJg/4kpV5SggnJoOmsqVTGPnvnHvEnferyiH4GbdzBG4LQm6pn1iv5BDIMNxUvBv8VJNm5N/lsBsxwJlU2jGPAXj99f37HvrMGAhcqUqsHlqSaMLf9B9mFARdFI3KYtOcBzv2VrnLMcW1GP09qRny/f/1QMGzophtFIEHK81I9Jm+bAEUXLyGy02Cx51YApKq4yUsS6xGpdIcDZcN5uLo0nJqvgm5ffecpOmPbapHhRS6FYUFZv5zUO7xBo0pqspczxgnOn7H83ParBlVQJTnltkFQikDVnT5Caxo5F3+rDzhbqQ4kEF4fbH8Ebt9l6aVY+tqMx7MvyHX2BKeif1ecj1CUK2UZ8WaihZYC8VVckXwl6PWXhC8Go07t/NE0Jmx4rziXLS7lqofKKfwUlNYF7av+h6hnlLknUWNTKC7d/p9PE56nMIFTG6SBWwApe+Y7PyjgIw=
Received: from [192.168.1.105] ([178.176.76.58])
        by smtp.gmail.com with ESMTPSA id v29-20020ac25b1d000000b005115365c4aesm285924lfn.292.2024.02.07.11.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 11:14:56 -0800 (PST)
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Make sure the USB
 role switch has PLD
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Prashant Malani <pmalani@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, Emilie Roberts <hadrosaur@google.com>,
 "Nyman, Mathias" <mathias.nyman@intel.com>,
 "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
 "Radjacoumar, Shyam Sundar" <ssradjacoumar@google.com>,
 Samuel Jacob <samjaco@google.com>, linux-usb@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 Uday Bhat <uday.m.bhat@intel.com>
References: <20240207145851.1603237-1-heikki.krogerus@linux.intel.com>
 <20240207145851.1603237-3-heikki.krogerus@linux.intel.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <338756c8-af83-c023-c5b7-757d57c76fa2@gmail.com>
Date: Wed, 7 Feb 2024 22:14:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240207145851.1603237-3-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2/7/24 5:58 PM, Heikki Krogerus wrote:

> The USB role switch does not always have the _PLD (Physical
> Location of Device) in ACPI tables. If it's missing,
> assigning the PLD hash of the port to the switch. That
> should guarantee that the USB Type-C port mapping code is
> always able to find the connection between the two (the port
> and the switch).
> 
> Tested-by: Uday Bhat <uday.m.bhat@intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 2b2f14a1b711..5c14e8db08b5 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
[...]
> @@ -66,6 +67,16 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
>  		cap->prefer_role = ret;
>  	}
>  
> +	/* Assing the USB role switch the correct pld_crc if it's missing. */

   Doing what?! :-P Maybe assign?

[...]

MBR, Sergey


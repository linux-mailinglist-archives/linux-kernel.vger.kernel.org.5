Return-Path: <linux-kernel+bounces-128468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95E895B38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B177D1C21AE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D11C15AAC7;
	Tue,  2 Apr 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCO2dV+z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D80175A1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080599; cv=none; b=qihl88zejRjwzD4R4EfhBMqMstigHlAHR1NDb0JBx7E/gIJoxK1CT0lWYXZZr6+q/tdo2Bt58GR3peksD8L/LEIAOsTp32vMPxxsdoO56xfskISu0581u5gymStlqhlxfJhm1yihQXTwICwQ8WI9FBoDjPc2uL6O5nsks8vyUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080599; c=relaxed/simple;
	bh=0Y6h6f3cPtEsQDZknsO+IagBdcnjM+3VtzRY1FTs2/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArDw3CCnjwKYdysFv596jYbZgQWr/neo7UJppJZIBkDfJGN+7vboINhLh4SA+1D+8mEMydPg6UEJYgVByuflgONoJ5nMw/+T5QBzWLWmqMqAgfqxHm0SopuKbGN1lhMW1fisuIDE8aIiwIpnr+25VwYUeza8MfakuElLJXLvS3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCO2dV+z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712080596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LgMPjza/41g8vlyeiXDj0QiyYeEN86lA9UA/Jcby8CQ=;
	b=KCO2dV+ztWjBkl8LiXA0YRS7qCIK/fHpy9mzZI/rD0G6E/huAvAMMo9btpaB4bbjek5Tfh
	hzVOd58IaEPivIKSE2DHlf+SkpUbRM6xzjt4JfLp3qARxFLMAv9G4PSJnvgeEfkCzNUbci
	JPHG8DswtycOrMvT7i/qf09brRrh5As=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-FL2hgjdbPOift-5d2tL_vg-1; Tue, 02 Apr 2024 13:56:35 -0400
X-MC-Unique: FL2hgjdbPOift-5d2tL_vg-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7e05a1de71aso1511309241.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080595; x=1712685395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgMPjza/41g8vlyeiXDj0QiyYeEN86lA9UA/Jcby8CQ=;
        b=mSwjtecyk0ZPOo/XvsFcPukDVwm3BDvgIGNUsTGuq4631wmtpZdjRDB2gjzilMGE8v
         M9eP2jClwQevY82ym03Fdgbst+JkUqvSzpSMXqCG7fTpQXEfxl68wREQ2AFd8BJNjtU2
         iwxZ/3cx7EIfm3VMnC4uHaSqjw4Jp1Y1AbC23dBEVdLFCwjbuhgY/V8tPSK+5Iw8C62c
         3C2ejYG5Jwz11VPLBoaXpqMlH6d0MpaANsuix9O5SQ9WM8uUWzJ9MSTbKbbPRl18YE3F
         j/sgST3Az0Ha4IQC+rgO5Qj6MeXatIxq1KWu5n+1i7y7l7LKyFKBLCwAIkj1hTJqfXNz
         xeCg==
X-Forwarded-Encrypted: i=1; AJvYcCW0xJZJM65aqfrIg9iHWWhxk43ieIyqLPNdD18Sz27Zd1Q0d03ve+IOdGT65032aH0/HXUTXCnmGGH3peGBlZ3SYIzF8SET7vBmXbZ7
X-Gm-Message-State: AOJu0Yxb7EUoq781CkUjKDJxbJyWt+UwEWCzV6WI64fRXGl5sSYEHKm/
	bg0fUwvkGhX5J/meF01YVjkwZnjk1u3tSHGVODvAXzIK9kj/+QHIB5UFIS4xX2zOTblITVvDlds
	q5d2r4exmNKzVLidsFYP//1lyZbFWehBY4vhc91dHjaxNVEN690RGLp1ArUCb7Q==
X-Received: by 2002:a05:6102:f99:b0:478:7dd0:7488 with SMTP id e25-20020a0561020f9900b004787dd07488mr727572vsv.4.1712080595027;
        Tue, 02 Apr 2024 10:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+lfB7uf7k84U2D44uUXyWufZapIjUE6tvJzLJYPJoE/4FXuwNIDcI9vGzqEr0VES/yLDjqg==
X-Received: by 2002:a05:6102:f99:b0:478:7dd0:7488 with SMTP id e25-20020a0561020f9900b004787dd07488mr727549vsv.4.1712080594706;
        Tue, 02 Apr 2024 10:56:34 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id gw4-20020a0562140f0400b00698fd28cad3sm3465470qvb.80.2024.04.02.10.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:56:34 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:56:32 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: pmic_glink: don't traverse clients list
 without a lock
Message-ID: <bnxrstkmjmmbhzrqncfwwnxa5vpx3ioysykqr3sbiirlatneu4@vlewrjturppo>
References: <20240402-pmic-glink-fix-clients-v1-0-885440b81c65@linaro.org>
 <20240402-pmic-glink-fix-clients-v1-1-885440b81c65@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-pmic-glink-fix-clients-v1-1-885440b81c65@linaro.org>

On Tue, Apr 02, 2024 at 08:07:06PM +0300, Dmitry Baryshkov wrote:
> Take the client_lock before traversing the clients list at the
> pmic_glink_state_notify_clients() function. This is required to keep the
> list traversal safe from concurrent modification.
> 
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/soc/qcom/pmic_glink.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index f913e9bd57ed..c999358771b3 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -168,8 +168,10 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
>  	}

Does pmic_glink_rpmsg_callback() deserve similar locking when traversing
the clients list?

>  
>  	if (new_state != pg->client_state) {
> +		mutex_lock(&pg->client_lock);
>  		list_for_each_entry(client, &pg->clients, node)
>  			client->pdr_notify(client->priv, new_state);
> +		mutex_unlock(&pg->client_lock);
>  		pg->client_state = new_state;
>  	}
>  }
> 
> -- 
> 2.39.2
> 
> 



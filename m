Return-Path: <linux-kernel+bounces-130080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CF689742E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F03B32261
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678BD149E18;
	Wed,  3 Apr 2024 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddjtJdMB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2A146A91
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157474; cv=none; b=B3pU+xSR5l3w6KzhjXizS1ZMaZQ1nsvZYH0uMFjnARZVCkWVd9Fre7igc7V4XwWu3Gip1JLr4i3rEO460it1RPiwNOPddzP+duvPTq8a7ib7OnCxcS5R9cN5u23tn3fFFLWzXvYrFIi3IljnCzS2n+5f8On6tYKQZbt4iabvTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157474; c=relaxed/simple;
	bh=63M5+iENCP6o3+OtSya6mLfBZXgHKXiowr8g+FUgFKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd6ZdPghW7hQQTLifaPtmHDOiDRI/XmM90+zOkpvD4cUgijrRtkzG6fI515pjTV/vdlhpV63xdTKUOFmGMYVh7WYU1fr5uVe7K6i3nC/snmGYlMIYytdavH5FUlq9qEEqw3DCnOEVzQnQtfj5B8yK1u/O6VskbSaPtOmjTCUzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddjtJdMB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712157472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AC0NMQx8eq5E1d+G3VcUzmMMCOpidmHhVgTwE7vP0Is=;
	b=ddjtJdMB57Rmi7FpwwmYdlZ3mshZDgW7CVS8ZwuoJa47HHfcvDlfr1ByyXa8lagJCNdDkt
	7eToaR1/1GJnLM5TEtUxVwJQnig6BsJxyVv89nL7WKkzGeMkTdb7e0cJBHdADSR9YmGNZ6
	eBO5Y6mubZAqUuW+J0mZa8nLnFAoOAA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-dcDJ7Mp7NVa__emAI7y7DQ-1; Wed, 03 Apr 2024 11:17:50 -0400
X-MC-Unique: dcDJ7Mp7NVa__emAI7y7DQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-430c139c096so67237061cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712157470; x=1712762270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AC0NMQx8eq5E1d+G3VcUzmMMCOpidmHhVgTwE7vP0Is=;
        b=E02Cw0RbwiwNfddSUNhbPTYrb3g4vb6lVJ2kKsQR8KGOu1NdA7qrcTE4/FcFSlzIBG
         /icjd/b6v95YQQ/y9wjpWXZpUfje0ncNKVC+jrWh8D1i3FOOQBhPzjGan30QfigKs/ya
         z8SUr8FuO533u6aW02JM7Fmn/KFVoIT0on7Svqaow/IXgxBP0RI0ew4stPJwVjH9+A5k
         JNNktj3EaC4K/trmw0FvPWUiyUBN+KJ9r9VrsuNrV7nvyYAxT958q2oHHBBjYKaT9E0r
         uO23iIS+aOs7h/HzgIF1CRGSgAxFodOO4qv7Fo+8P2ZKEVpte/iE8e+r505TgOkvyGou
         5Eyw==
X-Forwarded-Encrypted: i=1; AJvYcCUz5H00NACm/Qg0aU5kIP0WcfgwYZNI6y/r8nPuD5LuxR+Ok2xcbXW3i+QABsV95jCB64a0jXdqVucFT4uRyUEyb2aq4Wn5RlWJO6Og
X-Gm-Message-State: AOJu0Yz+kLj2ovreK/d2+vItMeCOT0DjuguHM79SJoeZYOmt1nHjgaSE
	OodvSkL2tr0DpvT5JL6BSLbU2iBEclY+jTtnYlFPlw/uYSWEEJv42OM6i0I0+pNO9PsZAv134zI
	ImZGRRVZOkGDxRMdsh0uhz3C6D0atb1Lmnv48qmRrOa5d8WJNDG79S9iQL5Dixg==
X-Received: by 2002:ac8:5d49:0:b0:430:d175:5a80 with SMTP id g9-20020ac85d49000000b00430d1755a80mr3590044qtx.14.1712157469955;
        Wed, 03 Apr 2024 08:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi851ZLhBiO96hLqacoDLGsW6KbgoLdmI/JpdNzUViwbLr6IkVm2P+PHQQDQajvuPPYWlLow==
X-Received: by 2002:ac8:5d49:0:b0:430:d175:5a80 with SMTP id g9-20020ac85d49000000b00430d1755a80mr3590001qtx.14.1712157469395;
        Wed, 03 Apr 2024 08:17:49 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id ea3-20020a05622a5b0300b004315aa3d5d7sm6686783qtb.0.2024.04.03.08.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:17:49 -0700 (PDT)
Date: Wed, 3 Apr 2024 10:17:47 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] soc: qcom: pmic_glink: don't traverse clients
 list without a lock
Message-ID: <cnpl3m4r76wbpqgjb7vw3i6wldavpvrprd7nxrbor3s4v5kuky@wixormy7sdmx>
References: <20240403-pmic-glink-fix-clients-v2-0-aed4e02baacc@linaro.org>
 <20240403-pmic-glink-fix-clients-v2-1-aed4e02baacc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-pmic-glink-fix-clients-v2-1-aed4e02baacc@linaro.org>

On Wed, Apr 03, 2024 at 06:10:57AM +0300, Dmitry Baryshkov wrote:
> Take the client_lock before traversing the clients list at the
> pmic_glink_state_notify_clients() function. This is required to keep the
> list traversal safe from concurrent modification.
> 
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/soc/qcom/pmic_glink.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index f913e9bd57ed..2b2cdf479654 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -115,10 +115,12 @@ static int pmic_glink_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  
>  	hdr = data;
>  
> +	mutex_lock(&pg->client_lock);
>  	list_for_each_entry(client, &pg->clients, node) {
>  		if (client->id == le32_to_cpu(hdr->owner))
>  			client->cb(data, len, client->priv);
>  	}
> +	mutex_unlock(&pg->client_lock);
>  
>  	return 0;
>  }
> @@ -168,8 +170,10 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
>  	}
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



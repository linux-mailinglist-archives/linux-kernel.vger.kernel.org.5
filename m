Return-Path: <linux-kernel+bounces-128473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B15B895B45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D171F21A55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8DF15AACA;
	Tue,  2 Apr 2024 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jt4XxiLu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43DA60264
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080800; cv=none; b=IW/PN5WUPQc5xKNMFU55uaIAutARXc+0XEjHNkgmoT5TLhLO7nD5v1DHL/xAxsCkBG4TQ1DVnIeEsGZ4fbaC9Bfs551hmhLBxX4zfPefLBFen8RPBq3q5afC2uWsm2OZtErMb4WdS5uWGuluu6mgWod5La+I+KAqqcU99iuRgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080800; c=relaxed/simple;
	bh=XuH/Mn3d9quSPPFx4KukBbASBGyIymuiYnObzB8IZLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwcjSx5fnUKlx/4EYjJdPYIdxfyf8T1IU89P0GMnsr4nmKE9a1Mj965mIm+mByTVaENhClX03zAJPjVH8uhpRIUSTOgccYIMrM7wheMdLF13hPduaHTcicIJ4+mHXJcnjuF+I4uHkVf9SgCQufwNS0ff1tJWDGpiuPKJW5sfBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jt4XxiLu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712080797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgcE9nccHXFxfGc///KBrqv9RnPqQu1MeIv0SuevzR8=;
	b=Jt4XxiLu5fm51O4ue49tlqtnToQtaw6rgUQG0EexT/sL9liqOyzFDfyz9MPR5fxONnnhqJ
	Dq3W9WtZEdezfZBSeW/cn8mMfGB1786h5iw9ZkLJRksZAHEpwkncwqlOXG4f8ooxXLGorw
	HSlfFCJk8scyCFKKOwH94EWBKrURBV4=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-qzWQ_dqkMR-nFk_WvQQHXQ-1; Tue, 02 Apr 2024 13:59:56 -0400
X-MC-Unique: qzWQ_dqkMR-nFk_WvQQHXQ-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4d43e4a4c0aso2709700e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080796; x=1712685596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgcE9nccHXFxfGc///KBrqv9RnPqQu1MeIv0SuevzR8=;
        b=kmp90Dnh67E144+K115eOK6Sw7iC9J9vHT5zUo79JDV+BvDBXbZ6sD5vfInCRegJN0
         vGN7co/XIXTDvdRNCphC1PF5vYFLHl9YmU5IWFMLWHu2dMMnTvzvuam1OsAweGxnOGRU
         vnRMI1e2upxT44hF1XWg/QS2qaxtVLB7+6wTtv1R2JCOCOud1Z1AgWiC5gDT4OU4svDJ
         xNelTD+dSIoX8dJcHarlj6+ASCXtekkRg/H7KE59UlK4QGlLZLyIm6p4kzDQDuhHM7Kn
         TAaB3rfyCRirFWFU6q0R+GN3VC8WMcF1j/rLakNukLqXCvcXFKQKYZETDEj33agLFVZ/
         hFKw==
X-Forwarded-Encrypted: i=1; AJvYcCUBi2S9T8INxM/7sr4QGXX5wIjfquYk3jb5uoszgDvZSxg6IQSMnTUwLT14aChP6nDdXMAhjEIQtYwnaAK+I+dKYCmDiD1LoIW7Md76
X-Gm-Message-State: AOJu0YyJ7L0U7Vh7orIPwJUUUjw7TGOpwpiw4Ps6PckrXshmXcjjdxTn
	fexSMWf4GeHuf5hGWBIARKT4ODcLoPUGKjpg9Lq98tWZuV4qG553qrQhYOKaDHuA8f54XmtY85y
	SxMqE8bpDIGUEmm6wjgcn30gccxJve+O4mQ4JYQwsM9Qt+jlp1dqHEf5F036u3w==
X-Received: by 2002:a05:6122:2809:b0:4d4:be1:8196 with SMTP id en9-20020a056122280900b004d40be18196mr505302vkb.11.1712080795873;
        Tue, 02 Apr 2024 10:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeb+2S+Ps4Yp69Gg7jKl2j0TZKgn8/ehqbQLCWCnfgI3PqE8IK+fDwOGE9mlwKHVkZMcNUoQ==
X-Received: by 2002:a05:6122:2809:b0:4d4:be1:8196 with SMTP id en9-20020a056122280900b004d40be18196mr505284vkb.11.1712080795484;
        Tue, 02 Apr 2024 10:59:55 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id iu12-20020ad45ccc000000b006986e15fbc8sm5606379qvb.141.2024.04.02.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:59:55 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:59:53 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: qcom: pmic_glink: notify clients about the
 current state
Message-ID: <2bj6m72cnuuscp4me6zwygehyf6fo7b72q5f5pkp7d4c4uwdmu@6arpnxh6wsw2>
References: <20240402-pmic-glink-fix-clients-v1-0-885440b81c65@linaro.org>
 <20240402-pmic-glink-fix-clients-v1-2-885440b81c65@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-pmic-glink-fix-clients-v1-2-885440b81c65@linaro.org>

On Tue, Apr 02, 2024 at 08:07:07PM +0300, Dmitry Baryshkov wrote:
> In case the client is registered after the pmic-glink recived a response
> from the Protection Domain mapper, it is going to miss the notification
> about the state. Notify clients about the current state upon
> registration.
> 
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")

This looks and sounds reasonable to me.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/soc/qcom/pmic_glink.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index c999358771b3..089cdfb1c9d1 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -83,9 +83,14 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
>  	client->pdr_notify = pdr;
>  	client->priv = priv;
>  
> +	mutex_lock(&pg->state_lock);
>  	mutex_lock(&pg->client_lock);
> +
>  	list_add(&client->node, &pg->clients);
> +	client->pdr_notify(client->priv, pg->client_state);
> +
>  	mutex_unlock(&pg->client_lock);
> +	mutex_unlock(&pg->state_lock);
>  
>  	devres_add(dev, client);
>  
> 
> -- 
> 2.39.2
> 
> 



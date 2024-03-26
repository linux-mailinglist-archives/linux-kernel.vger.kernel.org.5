Return-Path: <linux-kernel+bounces-118417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B261A88BA79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4681C2D9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F0973504;
	Tue, 26 Mar 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wU+FD787"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735571B5C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434708; cv=none; b=eV+YlhhEtKLjPdThXnzU0zCXyEaEjfQX53+vEzMgjPp3c5uunrcFFF5kPGYQsF2aYnlDKxVHPXUboPlqhsyuBetbNbzyrhVUOYST/KYI8kHIz00/FRATjYK9/MzGUjTCqkAIGXYwfcL9AfOU+zbVjmrDZmpjrhEOiB+Z172jQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434708; c=relaxed/simple;
	bh=woda4IhRSYdLKE4CGfVddcLjIWN7cR9ISpX9NT31M9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaJMfKFmfDQHI5vSccZ0KAK3ct6PRbEjfE65IEzy/yVYawnZVFBSNoNecRhfRtcn3Ghx2V3q29KIk5cQrPnqHrIlfW/1AjKQryjbZEYe1V6+KOm7CciQ/PPZmt/P8L6Z5NS8XiTv6kQZr9drSa7mJQ7QV3OMqpH74beVlDTXL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wU+FD787; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7e1026a1c3cso307916241.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711434705; x=1712039505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YctYs7kdin6cPDpRchLG2jgUpLaFzkmZhAQ7snqIC/Q=;
        b=wU+FD787YFIPigIHlsEDlBTG+nDEqV9iqRo258/Oxy1HSrJ+nGVDPwoIKRRYpSgrtz
         c/96LCORH4cRCMcLvBunVc6vMbHM9pi08sD5xm0wCt4jiSFCwh+N22zMT9tRq5zwpezX
         qadq8iFMm/cLGWpzc0hinHHj3c/vJr2rxI73vHlAvAl1zJ4HEy3KfkjGwGYzttXqSG1B
         HEb5eh9kMuFsFbP32wZUE1oAQGQpeTZ3Xa9ObYRC06nXPlqnbmip+hQLQmOfNmXmaHM6
         h8IR+bXraYdxMTdN6HrbS/9S1LaYQLuHAB9BE2uaxBIdyAQqcEXIlZpMc2VYaTsWpaqb
         jRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711434705; x=1712039505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YctYs7kdin6cPDpRchLG2jgUpLaFzkmZhAQ7snqIC/Q=;
        b=wVpYpvFrwnqEBRuRmNt0epKpve5IB2CqQPyfWG7E4+c9d6IFDHEjSFYfuQV6737D15
         gjfFd6UiwNcFhIoWr7jypubmiD34mx56UdsoYh0hhNKFrtc6v0eXoCyR6lSgWp52LV0A
         OQPVLuBK3php7y40lje+V8WUUN89paNOjRl8q4yBIXem1WPQNw3jVm6i3OSVLzu2heol
         5UuJdtthw5rD89ohcPuDPREHso8tFIxW2yyrEFrl6pMdmcEI6j84Gf1w7a4fBuCrw7Cp
         b4GeLaH57u0DusXsud/hgc+y9TB08jSGwWhQkhFHZUqLSxDLi2wldatCOg6NFo0gs31J
         M0sA==
X-Forwarded-Encrypted: i=1; AJvYcCUzwyVBAWmBWllrZXHtNVDzU64IHs/Fic4wLcf+CP/Sj/koj+FVpJIMMeJbeKzPQ9f/yZkRsYkDLpxMDRi1oU9f7Hfv22ae6kfKJoZW
X-Gm-Message-State: AOJu0YzJmjP/Qa/6JrlyokrdWGUjs08A7wGtNGP4mwk/aC8hfZxboUea
	jaWouw3FxIusjwRZR7y7skuKSVgCg5FkYFHBO+/3LDA0oaopi0uwCdPX3tHL8/Ee4n9dVRux1mj
	ZgXOKWAkZ+AE+cKTFfl5LVs5YWqoMzFmXnXGeog==
X-Google-Smtp-Source: AGHT+IEkqDIV1vYx54TwRHeqtyGyUvzEln98uuXYKNulu1dgHGTaEnLD9+8LwLIu4ccMpPwNYU2HKFigQiVlEzK8jg8=
X-Received: by 2002:a67:ee8e:0:b0:476:df35:630d with SMTP id
 n14-20020a67ee8e000000b00476df35630dmr7185909vsp.26.1711434705311; Mon, 25
 Mar 2024 23:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325151105.135667-1-balint.dobszay@arm.com> <20240325151105.135667-6-balint.dobszay@arm.com>
In-Reply-To: <20240325151105.135667-6-balint.dobszay@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Mar 2024 12:01:34 +0530
Message-ID: <CAFA6WYPghVHUG_4WkT7b00CxP=jWXfK=twPEn5DrbZabQon9Qg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] MAINTAINERS: tee: tstee: Add entry
To: Balint Dobszay <balint.dobszay@arm.com>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	jens.wiklander@linaro.org, corbet@lwn.net, sudeep.holla@arm.com, 
	rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 20:42, Balint Dobszay <balint.dobszay@arm.com> wrote:
>
> Create an entry for the newly added Trusted Services TEE driver, with
> Sudeep and myself as maintainers.
>
> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd221a7d4d1c..eaa89feabd25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22470,6 +22470,15 @@ F:     Documentation/ABI/testing/configfs-tsm
>  F:     drivers/virt/coco/tsm.c
>  F:     include/linux/tsm.h
>
> +TRUSTED SERVICES TEE DRIVER
> +M:     Balint Dobszay <balint.dobszay@arm.com>
> +M:     Sudeep Holla <sudeep.holla@arm.com>
> +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:     trusted-services@lists.trustedfirmware.org
> +S:     Maintained
> +F:     Documentation/tee/ts-tee.rst
> +F:     drivers/tee/tstee/
> +
>  TTY LAYER AND SERIAL DRIVERS
>  M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:     Jiri Slaby <jirislaby@kernel.org>
> --
> 2.34.1
>


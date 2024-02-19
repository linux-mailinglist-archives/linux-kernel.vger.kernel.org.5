Return-Path: <linux-kernel+bounces-71217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E305D85A213
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCA0281AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E951E2C686;
	Mon, 19 Feb 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKuJsXLk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B612C1BF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342590; cv=none; b=i1qZdJrBDrh+MQ7vkPKmYD8mmcH+28hIUURQkQqbfrSv1l1xbmYv+eXmlDZ5BcavIrTWMB5nGP20XPqgFZnsNKVNC6UHZhTt72I0jYwxDEBIlKi3Dk8JUzLNphPhlg733VGmlo9cDB2CF2KGsXMpPuyymf1CmwJWV1lY7P/cSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342590; c=relaxed/simple;
	bh=EWkBavHLn+OopLzpvPPHkNXk/lsnfjFePZMUx0qJkqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lx81qaU42yMGI5Ax8lbinVQfqr6mTDagQa2Aoat2aXGRiRcJ1Ff0DiJbDizJTwmkCPk6AYQFsvCGT5lAJKmpKgR+pJMwenfjuajYWbMMsZJ4A3fEXSWdbNuiV0dZ3zdxw9mm0dTaKDqqrZRhHm0KOM68AaoqlPCwZx1Np/cStQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKuJsXLk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708342587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaZBYDrNrWIpQuwZRoJJQwbTIgMqN6IhSLTRJ6ho8ik=;
	b=KKuJsXLknA/fuD/vGlDHaPD+uyf5SUc5UucQ72bMe+9o5boU54RqAELkCAG+JwAzGoeIHe
	a3xN9HqS5QfPFIT21C7pMYA3l5HKvkGvEVIMOSG41OvZpBMwAfES+penSPMgE7SNtswKgz
	pOY5DD9/afAI6wDz/A6GaghaWbMML0M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-CM51Mj86Nmm-iGrUQn_J4A-1; Mon, 19 Feb 2024 06:36:25 -0500
X-MC-Unique: CM51Mj86Nmm-iGrUQn_J4A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3ed504b0a9so11954066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342584; x=1708947384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RaZBYDrNrWIpQuwZRoJJQwbTIgMqN6IhSLTRJ6ho8ik=;
        b=ih8qkRcxcbJQBIAB3lWHEAvWBkbl/S5PEZVtNtTKxo3RUuZralG9zaip+1H7qCyplS
         V9qpNHt9hnWhu7m608KisTLAsYVnRwG5lJp7Fr5zmbR4OGv7GEeXn1gSjI4Npo05vqsO
         0SnNFkmd6V9OI8TPUhmCDz1+iJSt2MyIINciPwvNux4NSHcflb9U7yB8dKKAzkDDelZX
         ah/CjoZWVX7KTMo6/+4TTYzEhNqoCUpa/NTqhmC5DvqplmA/HarDU5cAPYVxEMRl31xl
         RmJGvcqOuKKzbZ8jd2W6okr5NkWCWIK0nS45f1quGazH1o/ZvafAqO6t5XvqFMw3LOCY
         rj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXDolN09yglzljXDl3FupScnSTWoh8gU1nHXNm5KaaOAPue1gzWNjyG/AysvmPdOUHQvRZZRPk5ymNCRIxm+og4o7OKicr4191J9f2
X-Gm-Message-State: AOJu0Yy0XaNWRiXAT/gxKSkGegcZGuQ6YuoW/RhBBrFf6KhY0qg5lObZ
	Mp5qatWXpHwqV4FSDsoXuy9rR5mjr3nsIsw4G4frr0/fqtGDQe/yX6N0USEKMuY4Xb9vYsBpeQL
	aY2PfFwF7bLrog32P817nZf8i1ekFu5LpbXarzXfxnF2tDkmmQAmtLnuDtTiCgA==
X-Received: by 2002:a17:906:495b:b0:a3e:97e6:dc1d with SMTP id f27-20020a170906495b00b00a3e97e6dc1dmr1492138ejt.52.1708342584341;
        Mon, 19 Feb 2024 03:36:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPeDNv4cXcgUWAC9iho6U9B8/ESsy4IzGVIwiKZk+yOmu8MJv0kiojeheRtgqEd62dyLttfw==
X-Received: by 2002:a17:906:495b:b0:a3e:97e6:dc1d with SMTP id f27-20020a170906495b00b00a3e97e6dc1dmr1492124ejt.52.1708342584045;
        Mon, 19 Feb 2024 03:36:24 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ss1-20020a170907c00100b00a3e0c07c1a0sm2739493ejc.23.2024.02.19.03.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 03:36:23 -0800 (PST)
Message-ID: <a6682692-531e-4a21-abde-8c2df518a1eb@redhat.com>
Date: Mon, 19 Feb 2024 12:36:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: think-lmi: Fix password opcode ordering for
 workstations
Content-Language: en-US
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20240209152359.528919-1-mpearson-lenovo@squebb.ca>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240209152359.528919-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/9/24 16:23, Mark Pearson wrote:
> The Lenovo workstations require the password opcode to be run before
> the attribute value is changed (if Admin password is enabled).
> 
> Tested on some Thinkpads to confirm they are OK with this order too.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I've also added the Fixes tag and Ilpo's Reviewed-by.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans


> ---
>  drivers/platform/x86/think-lmi.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 3a396b763c49..ce3e08815a8e 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1009,7 +1009,16 @@ static ssize_t current_value_store(struct kobject *kobj,
>  		 * Note - this sets the variable and then the password as separate
>  		 * WMI calls. Function tlmi_save_bios_settings will error if the
>  		 * password is incorrect.
> +		 * Workstation's require the opcode to be set before changing the
> +		 * attribute.
>  		 */
> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> +			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> +						  tlmi_priv.pwd_admin->password);
> +			if (ret)
> +				goto out;
> +		}
> +
>  		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
>  				    new_setting);
>  		if (!set_str) {
> @@ -1021,17 +1030,10 @@ static ssize_t current_value_store(struct kobject *kobj,
>  		if (ret)
>  			goto out;
>  
> -		if (tlmi_priv.save_mode == TLMI_SAVE_BULK) {
> +		if (tlmi_priv.save_mode == TLMI_SAVE_BULK)
>  			tlmi_priv.save_required = true;
> -		} else {
> -			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> -				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> -							  tlmi_priv.pwd_admin->password);
> -				if (ret)
> -					goto out;
> -			}
> +		else
>  			ret = tlmi_save_bios_settings("");
> -		}
>  	} else { /* old non-opcode based authentication method (deprecated) */
>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>  			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",



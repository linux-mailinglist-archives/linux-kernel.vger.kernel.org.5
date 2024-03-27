Return-Path: <linux-kernel+bounces-121969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E262888F004
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E25B226F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1516152501;
	Wed, 27 Mar 2024 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5eMVIev"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD114E2C0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711570990; cv=none; b=hczUPzyUxEMvDC8d7/LLKy7Q7rQAMP+KGuTwz/co8+RVTTlbIHF1PqW6TtAiJrBTzoiMNdDBGUJV5CPrFOu2vz8Amx/n/tXaciWIJ0A8ivWSbjcwxk4ApOFUpTe1nAtkIzrrBPvf2kuwpvONL4KwF83EAaGQ5Ho4QW4D/B5D3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711570990; c=relaxed/simple;
	bh=gGFUEXzP38XKxA/VBY3QFi4X1MhaX2ie5+FhShTud+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFcXruud407AJSod3JhQnKk3ie3ifXkiy3045d/M0ZPcEFytCK4lx8TcrXZACHwMn3R4DUqJEisS28QNp1UEOezysdYzoLIrFHXMqDHD5nG7ebYmzYtiFYd6H3/vNPrLakUlEqjuX6zE8Db69qaxEtH6roNOehqX2gzKPELh3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5eMVIev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711570987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSamWa+KJaP8I2QU1s273bisfEt0jWshOBi7xx7K3D0=;
	b=C5eMVIevmAZWYGvZyQ7KaK5K9K7mQRqrY18Ea2vqmpE6sW/VzOlZ1FFZHnRwOIgxUx2vrN
	KoKxBOdw+9MV5qJTBcGbscUp1aI6pU3+ngiWIPzJv90zXYLN/V5kKaTpwv3xFj/SajkGWP
	YMbEnn9EVaz8gvZtdi1b7UN7bKxP60Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-otMSR-1aNNu4HD9OeXt21A-1; Wed, 27 Mar 2024 16:23:05 -0400
X-MC-Unique: otMSR-1aNNu4HD9OeXt21A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6c8f170e2so1150261fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711570984; x=1712175784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSamWa+KJaP8I2QU1s273bisfEt0jWshOBi7xx7K3D0=;
        b=ig+SEXyiF7YcdttZ3ZgRBnarVDVsE9nivhhuJUAP6nXGPK57eSr+fQDgs4lYVrZtp8
         ocsWWYfl1fF+3T/0ki6NW8Yk8t+P9ANRgG71VbUVGPebol58DfjPfFtFFAjw7WUV/74j
         qo8g7b+ik9cMzqX/Hj3jYJvtfSKkNPZUT51RjJnYfxZZ5Rz/XvUpBkqbeg3CNc5Lo1uo
         5+mSh6mDg/ounxZDn6RDqzzOpccaJirhJvRICRl6y4DwzCSyJ72RfOQCoHYQYXV43LZY
         bZADLWOBa0R50W62A4imSH6rR8qaBsJpvnHKrdtzBuKkdD+2oYW6yxeshB0rb5YYeUi6
         AFfA==
X-Gm-Message-State: AOJu0Yz6wfnnmPHDkf38vEMwFCsI1s+OwvKUQvBvaG9BwGloEbFbjv7a
	gOMupIkdVD/JbZwkXLMGW8RNrD16PJqzGK5Gqtk6PEp2F0kTOtpNKYD5lMavLCW5LDrtmdbAdLd
	D0JalAcZ6mbVVMJDydoUIGGAU3p4hTQn5PAIdxhehpT55jSiS+aLbw15VjlmrOg==
X-Received: by 2002:a2e:9d86:0:b0:2d4:7373:2a5b with SMTP id c6-20020a2e9d86000000b002d473732a5bmr1016982ljj.47.1711570984283;
        Wed, 27 Mar 2024 13:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+/uSBddinToR19Kfpe0lSiXp/wCHGG764P+8y9fTcKtyY3XFLg5eLdVUVh1XfSlMcKNPsDA==
X-Received: by 2002:a2e:9d86:0:b0:2d4:7373:2a5b with SMTP id c6-20020a2e9d86000000b002d473732a5bmr1016967ljj.47.1711570983910;
        Wed, 27 Mar 2024 13:23:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170906e90200b00a4a33db326csm3963869ejb.194.2024.03.27.13.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:23:03 -0700 (PDT)
Message-ID: <a281d426-1dd4-42c2-b688-f11fabaa9a32@redhat.com>
Date: Wed, 27 Mar 2024 21:23:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86/amd/hsmp: switch to use
 device_add_groups()
Content-Language: en-US, nl
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 naveenkrishna.chatradhi@amd.com
Cc: linux-kernel@vger.kernel.org, Carlos Bilbao <carlos.bilbao@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <2024032732-thigh-smite-f5dd@gregkh>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2024032732-thigh-smite-f5dd@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/27/24 9:08 AM, Greg Kroah-Hartman wrote:
> devm_device_add_groups() is being removed from the kernel, so move the
> hsmp driver to use device_add_groups() instead.  The logic is identical,
> when the device is removed the driver core will properly clean up and
> remove the groups, and the memory used by the attribute groups will be
> freed because it was created with dev_* calls, so this is functionally
> identical overall.
> 
> Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> v3: change the changelog text to reflect that this change is identical
>     to the current code.  Rebase against 6.9-rc1
> v2: rebased against platform/for-next
> 
>  drivers/platform/x86/amd/hsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
> index 1927be901108..d84ea66eecc6 100644
> --- a/drivers/platform/x86/amd/hsmp.c
> +++ b/drivers/platform/x86/amd/hsmp.c
> @@ -693,7 +693,7 @@ static int hsmp_create_non_acpi_sysfs_if(struct device *dev)
>  		hsmp_create_attr_list(attr_grp, dev, i);
>  	}
>  
> -	return devm_device_add_groups(dev, hsmp_attr_grps);
> +	return device_add_groups(dev, hsmp_attr_grps);
>  }
>  
>  static int hsmp_create_acpi_sysfs_if(struct device *dev)



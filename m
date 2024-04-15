Return-Path: <linux-kernel+bounces-145325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4458A52C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA9F1F226AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D988B74E3D;
	Mon, 15 Apr 2024 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqpP07jo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7074439
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190281; cv=none; b=rWj79IOJ7cJWsUpGNxQVW3t5x+dvfARmNPW19YORm7j5rMZBkx2hKTuAyIs51R5JoD9uDVYeuTsGH3cNn7lVwvOV/L74/20RsaWaxyda9PtyWPQeUba3GubkRVbyCMW8xZ9chtmNrpuN4+5NzA4eINNCKTro04FRuJqDUiRIytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190281; c=relaxed/simple;
	bh=4UaU9zFwhxCtMXiEsZ/tAndAnGkb0E4UlcAo8P3HWE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ejlwU+u05/VK9Iskp5zf0k8tm8FjUnxSUKv8KcNar/EXZChnr2KhX8+HpJeitiC3sF6EjLebVOPSYt7p7JGdzZXD4Wi30gdk2BmaVfu2UiU3LR535Mz8AL4M6thdCklXW3VVdsiXzK+mXBF7kk8SwpE0iDBMCpeJJiKkGHi++ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqpP07jo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713190277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YR+qKcWAqCaplzcT2MxW1L6RiBbL+LHsEU4FUpE8GN4=;
	b=iqpP07joffvhG7iUEZqKzyT6VhCz12OBA3ieQRT/YhMGTOZBhYHhtH8hvsyv9fJBE2Nt+Y
	4jArpwr14rYcz0s2qPyfFfxTnBiYYDTT2lxQPlE88IsxZx153Al6LLbLZ4XlAM/zf37Hbd
	ld9ps3+YgC3FijCOht3NUqMAhNwFHKM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-GHnMOtpdMnqInicSMQaYDA-1; Mon, 15 Apr 2024 10:11:16 -0400
X-MC-Unique: GHnMOtpdMnqInicSMQaYDA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56c3dc8d331so2541903a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190275; x=1713795075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YR+qKcWAqCaplzcT2MxW1L6RiBbL+LHsEU4FUpE8GN4=;
        b=tvgd4Pea4PRzpUDTYPCrzNDkC+yh+wOokAIBddW9BxPrYBf/Rddm/RPebXTHgehCNt
         cARyveEXM964WLXYk96uqGqQtR9lGPc1TcWY8o/DCIyNavScxB8EkWu4Ox8G23vZzIVQ
         NxlRuHivdyPPr0uWDQxBDZLt3N7nExzqEulgIOOgdh+T2dVMlO90QrJI1TOncvQ80E/8
         uDJrMWESI/tGz2bu/ZrRK4at3+noaQk4dBbG5qOzzpVokPZoGwifesRMjYaeucilh6m3
         bHvxEAywN5x9DWIOZPBSU/nDKu5EaOTRBlzQoW00t9KhTOLkej4hXMIXUn+IuUvqqNCz
         G5mg==
X-Forwarded-Encrypted: i=1; AJvYcCVzIhzaOF2gkiGo35LdXqtMJ96/3/brc8o4W5LkJPcuKa52uwwZm0j30tix9XFJwA4/OAHWJNJCCWvpr1xadzJz8yopYEGQgzUJlj4s
X-Gm-Message-State: AOJu0Yw7R3qVfl9WQTVVbtbxoAPxtLpkw+NXnb6D4QvL4WbAiSmDs6/L
	7Hc9HFSd1N5JbmvMrSw5W+masLYXx56ZZHDybXZ/XXlKaoFsw1fPtni7RAAvluCbM+QzpKRn46D
	Dniw6XDKjMkFx+wWAE77NvY4xXF0Sn/UNTPbbErmq0lA/Z2ikvU7IX6QLB8kNaAIgKlssUWee
X-Received: by 2002:a50:cdd3:0:b0:570:f6f:fdd3 with SMTP id h19-20020a50cdd3000000b005700f6ffdd3mr3973869edj.18.1713190274835;
        Mon, 15 Apr 2024 07:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWVZZVg5/n9O03rAn48o768swWWI5+1vdY3/FeWDl8Jw+fsztEuiPqs5SEC4/6My/L49LcNQ==
X-Received: by 2002:a50:cdd3:0:b0:570:f6f:fdd3 with SMTP id h19-20020a50cdd3000000b005700f6ffdd3mr3973852edj.18.1713190274483;
        Mon, 15 Apr 2024 07:11:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a15-20020a50ff0f000000b0056fc72bb490sm4832310edu.61.2024.04.15.07.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:11:14 -0700 (PDT)
Message-ID: <aef6b5dd-0a3f-41a3-b1de-89434ad78779@redhat.com>
Date: Mon, 15 Apr 2024 16:11:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] platform/x86: think-lmi: Convert container_of()
 macros to static inline
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <markpearson@lenovo.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240412130903.2836-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240412130903.2836-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4/12/24 3:09 PM, Ilpo Järvinen wrote:
> The macros to_tlmi_pwd_setting() and to_tlmi_attr_setting() are fragile
> because they expect the variable name to be 'kobj', otherwise the build
> will fail because container_of()'s 3rd parameter (member) is taken from
> the parameter given to the macro.
> 
> While at it, move them into a more logical place.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

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
>  drivers/platform/x86/think-lmi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 9345316b45db..0f2264bb7577 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -175,9 +175,6 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>  #define TLMI_SMP_PWD BIT(6) /* System Management */
>  #define TLMI_CERT    BIT(7) /* Certificate Based */
>  
> -#define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
> -#define to_tlmi_attr_setting(kobj)  container_of(kobj, struct tlmi_attr_setting, kobj)
> -
>  static const struct tlmi_err_codes tlmi_errs[] = {
>  	{"Success", 0},
>  	{"Not Supported", -EOPNOTSUPP},
> @@ -198,6 +195,16 @@ static struct think_lmi tlmi_priv;
>  static const struct class *fw_attr_class;
>  static DEFINE_MUTEX(tlmi_mutex);
>  
> +static inline struct tlmi_pwd_setting *to_tlmi_pwd_setting(struct kobject *kobj)
> +{
> +	return container_of(kobj, struct tlmi_pwd_setting, kobj);
> +}
> +
> +static inline struct tlmi_attr_setting *to_tlmi_attr_setting(struct kobject *kobj)
> +{
> +	return container_of(kobj, struct tlmi_attr_setting, kobj);
> +}
> +
>  /* Convert BIOS WMI error string to suitable error code */
>  static int tlmi_errstr_to_err(const char *errstr)
>  {



Return-Path: <linux-kernel+bounces-117280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86C988A991
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635001F60D67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48613D51C;
	Mon, 25 Mar 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdloBwjr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9A13A25E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377781; cv=none; b=kgMxI6HEdk3TQll1sxi62DGMp3dfWpQOqZOiLMpMWgoWLoERSWGAFrEcIt/EaMUfIDdUfGDg3kUmhRVLkwgKDBLgQFx2ZO1mGr05SWPMTacmOq/Vr/qHbD4FG29cFkHmv4j6l+pG0f13zKfLEsft14srANEsYeUCf4p8+LESX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377781; c=relaxed/simple;
	bh=5jdIAyL5Nl52H2NC9rZQRRrPZk8Zr0XF/yLD5SU6UtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GMV7IJY0mQC1ijXvvCkyAnnh2oPOBxfxHAoBp9gnNpdxBORqC91hL0Ti/QTO13oIVEKRYdQNw1LDfXmem8BWjiMROCtqLH6VqhUTW+RXwShZ1K3p+UHGXq58gje/U1TItfXyO0Mtg7+H9Tswc3xr3Lnn8AzA8dBRp6PEQGcvkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdloBwjr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711377779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETN5NBRtpqJskURBjDW95adl4iwgaOcYeDShy16SJFU=;
	b=SdloBwjrvWevCoCRHF28/fT/P1ffi+7hXOX4BQzPiGVYtmCX88d4UPdg+tgN5Va3WiqoJG
	q5bXROT/8FbbLDjutETu1ukH8BPKERdAL8N9BjVXi1Pzkg47esfMRiibzaTno3+bp3M9bN
	jMG741gJ6pKIodriFC+7Ew9phaigzuM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-jvQ5L07aOYmbJUixKMlH2A-1; Mon, 25 Mar 2024 10:42:57 -0400
X-MC-Unique: jvQ5L07aOYmbJUixKMlH2A-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56c0d3514baso523295a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711377776; x=1711982576;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETN5NBRtpqJskURBjDW95adl4iwgaOcYeDShy16SJFU=;
        b=xTjxbjfJrfXdyun4bm7/atIkownQq6z68ETCIQ9A8Gd7gzYTnczsd2Mewscx09YGqw
         A9Dn7pquWlHPolbIreFuh8kpDO7cjF3DmRtRe9N6SBIMyPO0h9RL49qLjLCRw94vJkiO
         vDdvYYVGBZrahXH1yKkfSWBYkB1olw6GnJSd4EWxJmpJqq+hrjW5k+KHjpRsORx/lmQZ
         slKmBe9rHVy1C6iqCbLonuzv11jV7PJ7ECbXC8mhxCVsQh2nlo2CkTa8DBPk6B0qsh3E
         7wbQcq3qKfANhmYZHFLH3dwAFG7EZVPY1Y2gL4jqhtSwZx8gZ1HTbRbK1fFitC3LcOG1
         E+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXefutEKr/4irovRkQEv982jfeyc8OdKxO1ScB8LYQaS3LS5x0BdGOP3rI8BFJ+zAAk8EokzR3Q6XL5re2Y+aoMDeu4OvMePUCOKkMf
X-Gm-Message-State: AOJu0YxPYMxxCGt2zon/TDp/VGYnB0Vznvrs1/296T47rN+lkONKIP9x
	USA8M14KNYXwg2+63/ZZaiHKHVuvAY41anCK8yUuVl1BFQW8rXoyzuYOv0c7vUJkHFWyvGVgVlr
	RoNmOcQeRmFil1PylI4k8YhC4evwylo4ScjJyJhax61m7a83uKVXyPfN8tHbtbjut4fnKqg==
X-Received: by 2002:a05:6402:3591:b0:56b:fd17:3522 with SMTP id y17-20020a056402359100b0056bfd173522mr5015486edc.14.1711377776302;
        Mon, 25 Mar 2024 07:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/XqIZA8tExCVkcSHrmF8fMRmzzlmqLhgV0WMmh0Wu72gVutD20vblcpm8B0yWR/4m9okLEg==
X-Received: by 2002:a05:6402:3591:b0:56b:fd17:3522 with SMTP id y17-20020a056402359100b0056bfd173522mr5015472edc.14.1711377775967;
        Mon, 25 Mar 2024 07:42:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g7-20020a056402320700b0056c0996bf72sm1794239eda.83.2024.03.25.07.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 07:42:55 -0700 (PDT)
Message-ID: <61bc04d2-1a0f-4a8c-9ec7-88bcc0bde169@redhat.com>
Date: Mon, 25 Mar 2024 15:42:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/x86: uv_sysfs: use sysfs_emit() instead of
 sprintf()
Content-Language: en-US, nl
To: Ai Chao <aichao@kylinos.cn>, justin.ernst@hpe.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240319070038.309683-1-aichao@kylinos.cn>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240319070038.309683-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/19/24 8:00 AM, Ai Chao wrote:
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>

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
>  drivers/platform/x86/uv_sysfs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
> index 38d1b692d3c0..3f6d52dea5c9 100644
> --- a/drivers/platform/x86/uv_sysfs.c
> +++ b/drivers/platform/x86/uv_sysfs.c
> @@ -129,22 +129,22 @@ static ssize_t hub_location_show(struct uv_bios_hub_info *hub_info, char *buf)
>  
>  static ssize_t hub_partition_show(struct uv_bios_hub_info *hub_info, char *buf)
>  {
> -	return sprintf(buf, "%d\n", hub_info->f.fields.this_part);
> +	return sysfs_emit(buf, "%d\n", hub_info->f.fields.this_part);
>  }
>  
>  static ssize_t hub_shared_show(struct uv_bios_hub_info *hub_info, char *buf)
>  {
> -	return sprintf(buf, "%d\n", hub_info->f.fields.is_shared);
> +	return sysfs_emit(buf, "%d\n", hub_info->f.fields.is_shared);
>  }
>  static ssize_t hub_nasid_show(struct uv_bios_hub_info *hub_info, char *buf)
>  {
>  	int cnode = get_obj_to_cnode(hub_info->id);
>  
> -	return sprintf(buf, "%d\n", ordinal_to_nasid(cnode));
> +	return sysfs_emit(buf, "%d\n", ordinal_to_nasid(cnode));
>  }
>  static ssize_t hub_cnode_show(struct uv_bios_hub_info *hub_info, char *buf)
>  {
> -	return sprintf(buf, "%d\n", get_obj_to_cnode(hub_info->id));
> +	return sysfs_emit(buf, "%d\n", get_obj_to_cnode(hub_info->id));
>  }
>  
>  struct hub_sysfs_entry {
> @@ -304,12 +304,12 @@ struct uv_port {
>  
>  static ssize_t uv_port_conn_hub_show(struct uv_bios_port_info *port, char *buf)
>  {
> -	return sprintf(buf, "%d\n", port->conn_id);
> +	return sysfs_emit(buf, "%d\n", port->conn_id);
>  }
>  
>  static ssize_t uv_port_conn_port_show(struct uv_bios_port_info *port, char *buf)
>  {
> -	return sprintf(buf, "%d\n", port->conn_port);
> +	return sysfs_emit(buf, "%d\n", port->conn_port);
>  }
>  
>  struct uv_port_sysfs_entry {
> @@ -470,7 +470,7 @@ static ssize_t uv_pci_location_show(struct uv_pci_top_obj *top_obj, char *buf)
>  
>  static ssize_t uv_pci_iio_stack_show(struct uv_pci_top_obj *top_obj, char *buf)
>  {
> -	return sprintf(buf, "%d\n", top_obj->iio_stack);
> +	return sysfs_emit(buf, "%d\n", top_obj->iio_stack);
>  }
>  
>  static ssize_t uv_pci_ppb_addr_show(struct uv_pci_top_obj *top_obj, char *buf)
> @@ -480,7 +480,7 @@ static ssize_t uv_pci_ppb_addr_show(struct uv_pci_top_obj *top_obj, char *buf)
>  
>  static ssize_t uv_pci_slot_show(struct uv_pci_top_obj *top_obj, char *buf)
>  {
> -	return sprintf(buf, "%d\n", top_obj->slot);
> +	return sysfs_emit(buf, "%d\n", top_obj->slot);
>  }
>  
>  struct uv_pci_top_sysfs_entry {
> @@ -725,13 +725,13 @@ static void pci_topology_exit(void)
>  static ssize_t partition_id_show(struct kobject *kobj,
>  			struct kobj_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%ld\n", sn_partition_id);
> +	return sysfs_emit(buf, "%ld\n", sn_partition_id);
>  }
>  
>  static ssize_t coherence_id_show(struct kobject *kobj,
>  			struct kobj_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%ld\n", sn_coherency_id);
> +	return sysfs_emit(buf, "%ld\n", sn_coherency_id);
>  }
>  
>  static ssize_t uv_type_show(struct kobject *kobj,



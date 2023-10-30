Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842AA7DB3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjJ3GwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjJ3Gv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F29C0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698648669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/plvhVyykkxJgC+LDzB7nrVde68eR6Wbay50l+w4Jo=;
        b=bv87x68nSZSyuT168scufqbFCBUtb7QmCDG1X5jfaYRs6t9iGQMYtVIoo8bS6VvxkNeuG7
        r7gc82GZn9tyOGvsr0BMxWWfI9u2sSOaD1Z6QzE3zTsh+/8a2ucyoWESU+pFdY7TGreaJ2
        et0lgpeUPKYEPtXB9FVYZzR8uaOuLD8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-aH6aKh8YOXqnHhagq52rIQ-1; Mon, 30 Oct 2023 02:51:08 -0400
X-MC-Unique: aH6aKh8YOXqnHhagq52rIQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-66da680f422so54620476d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698648667; x=1699253467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/plvhVyykkxJgC+LDzB7nrVde68eR6Wbay50l+w4Jo=;
        b=haS651lpPw72uVHQJOBBlxPjXxSjcR923f4dMFIVk6I5mmd9+9w6G4MUwwtn05CaKM
         KNnMWqawtUCx/ZzcTEjMuKaNpQ4tE27aIkwutvp1mLJ/juor6I5S4yiHeYhzlot+hHQM
         fgZ0ukvHt6UM6Aec71pmSv8R6OwJ/MbD+qSdAmeY1vitFptRxXPx8V/VafXPJwEd9YC6
         /coH0evSdMHGGgIGlD+6484Rr9TyBwX5nBVgyltO4S32p2S+etL/bfh5BQMZMiziIrX7
         ZqE3XZol6N93O8SfSroeYuLh7JN+hQnUsVw5jL/3p2dRERbCqLWMductRGCrdYUoet37
         1UJQ==
X-Gm-Message-State: AOJu0Yxn/L2jtWPULVXeAJg3cUzqSB+wXfy1vZ/9ztTvJT2G2JZo3WMh
        L+p9PuCJ9h+t3VjlQV81IL9MrbLnatF/uXzg4vAhb/3bTIncySKU+feD7AGt47FcbQlPHC85b9/
        VAwSZyLgQTwR6x6B+YKj/DBpp
X-Received: by 2002:ad4:5c65:0:b0:656:3b4c:b98b with SMTP id i5-20020ad45c65000000b006563b4cb98bmr13663446qvh.11.1698648667670;
        Sun, 29 Oct 2023 23:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcWTyJ/ls0PM/ts30s4JrMKonOhY6WcnFIQsH/9qqUm8IcFB7cyTLHbt51Omk+YQiO7SvxwQ==
X-Received: by 2002:ad4:5c65:0:b0:656:3b4c:b98b with SMTP id i5-20020ad45c65000000b006563b4cb98bmr13663439qvh.11.1698648667424;
        Sun, 29 Oct 2023 23:51:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0? ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
        by smtp.gmail.com with ESMTPSA id x15-20020a0ceb8f000000b00670c15033aesm2179985qvo.144.2023.10.29.23.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 23:51:07 -0700 (PDT)
Message-ID: <356dd79e-9079-4bbc-9b64-9468b6f7b6a7@redhat.com>
Date:   Mon, 30 Oct 2023 07:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/2] Documentation: add debugfs description for vfio
Content-Language: en-US
To:     Longfang Liu <liulongfang@huawei.com>, alex.williamson@redhat.com,
        jgg@nvidia.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com
Cc:     bcreeley@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
References: <20231028075447.41939-1-liulongfang@huawei.com>
 <20231028075447.41939-3-liulongfang@huawei.com>
From:   =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231028075447.41939-3-liulongfang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/23 09:54, Longfang Liu wrote:
> 1.Add an debugfs document description file to help users understand
> how to use the accelerator live migration driver's debugfs.
> 2.Update the file paths that need to be maintained in MAINTAINERS

Should we have 2 patches instead ?

Anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>   Documentation/ABI/testing/debugfs-vfio | 25 +++++++++++++++++++++++++
>   MAINTAINERS                            |  1 +
>   2 files changed, 26 insertions(+)
>   create mode 100644 Documentation/ABI/testing/debugfs-vfio
> 
> diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
> new file mode 100644
> index 000000000000..445e9f58f924
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-vfio
> @@ -0,0 +1,25 @@
> +What:		/sys/kernel/debug/vfio
> +Date:		Oct 2023
> +KernelVersion:  6.7
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	This debugfs file directory is used for debugging
> +		of vfio devices, it's a common directory for all vfio devices.
> +		Vfio core will create a device subdirectory under this
> +		directory.
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration
> +Date:		Oct 2023
> +KernelVersion:  6.7
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	This debugfs file directory is used for debugging
> +		of vfio devices that support live migration.
> +		The debugfs of each vfio device that supports live migration
> +		could be created under this directory.
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/state
> +Date:		Oct 2023
> +KernelVersion:  6.7
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the live migration status of the vfio device.
> +		The contents of the state file reflects the migration state
> +		relative to those defined in the vfio_device_mig_state enum
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b19995690904..a6be3b4219c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22591,6 +22591,7 @@ L:	kvm@vger.kernel.org
>   S:	Maintained
>   T:	git https://github.com/awilliam/linux-vfio.git
>   F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
> +F:	Documentation/ABI/testing/debugfs-vfio
>   F:	Documentation/driver-api/vfio.rst
>   F:	drivers/vfio/
>   F:	include/linux/vfio.h


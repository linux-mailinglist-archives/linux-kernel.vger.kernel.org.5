Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2143580C65F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjLKKY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjLKKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7CEA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702290299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EkHNWKGI03k4jt/36VeYdeQHQ4kAe1Ed9JP4ATBzPOI=;
        b=LFdgWwwce4ac2xCOxLPA8q1vbNce3fBo/C1HBSdxTSkYMoLshbYaRqQOumAIVqmK1DCalP
        qr1FQoLf5XvbVp9CLjFhptn0OYzrofWaP6cf8nM8U9JToTkLoklnq3Qti2wrKOvupXJzk7
        bHMb2V5j06ZvtXwC3TkW08QAJC8IS6w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-S77ZAtXvPCGFMBzXfqj0pw-1; Mon, 11 Dec 2023 05:24:57 -0500
X-MC-Unique: S77ZAtXvPCGFMBzXfqj0pw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1d72320a33so252519466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290296; x=1702895096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkHNWKGI03k4jt/36VeYdeQHQ4kAe1Ed9JP4ATBzPOI=;
        b=MTAFKq/S7F1VLcL3aZbFNRbUTDmTjb1jCpLHQC8L5FvPnKQOFcWISqg+9jUfLPO9xH
         YViHX3TGSswJncI10pKsxXN12JrfQxtNOmseAD5nHL7QAXdz26hLbBIfBzuJIxqnBIlF
         8i0eSozD+n3mSVoz5t9FI/6gN0TC9epg6mkVxuR7JDiZkWRRIU1Fj0TgkL3+lvax70RM
         2QBy4zLUMpBXeADIO9c0vIiSP6ws56xvSjclnoXYPEwnWMZjYd0/P/LQvZrxiYW/TjAG
         nl2FPeR3gMD274rSaraMkEJAHyVwuBLO5WoiZluhRNn9iptXmfxJJWh2DEhVCzWPIItx
         Nypg==
X-Gm-Message-State: AOJu0Yzqa5puNFuTo1WjpwPgEPvw4tj3XFbyU/rtrCkdstJqWv2oGVEg
        uSOzxkCn5ur+YyPRhV28s3HjboWTXaUvq59p9L47nulXxsYHIU7NL7nnsi8rJz6dfyD7zZBoRu+
        pI0P+umPG0OmP103uAWwtRexDTiIW138l
X-Received: by 2002:a17:907:968c:b0:a1b:70fe:e896 with SMTP id hd12-20020a170907968c00b00a1b70fee896mr2295360ejc.130.1702290296346;
        Mon, 11 Dec 2023 02:24:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbHvDvDfb1Na+EoFufMVnvnALvsHRom59hQf/K126GVY985lax337NZg5MQOJhwcifefHmYw==
X-Received: by 2002:a17:907:968c:b0:a1b:70fe:e896 with SMTP id hd12-20020a170907968c00b00a1b70fee896mr2295346ejc.130.1702290296030;
        Mon, 11 Dec 2023 02:24:56 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id un7-20020a170907cb8700b009fc42f37970sm4634457ejc.171.2023.12.11.02.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 02:24:55 -0800 (PST)
Message-ID: <29bc74c3-b73a-4a5a-abca-3999e70fe71f@redhat.com>
Date:   Mon, 11 Dec 2023 11:24:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] platform/x86: wmi: Cleanup obsolete features
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com,
        corbet@lwn.net
Cc:     Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231210202443.646427-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231210202443.646427-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/10/23 21:24, Armin Wolf wrote:
> This patch series removes three features deemed obsolete:
> - the debug_dump_wdg module param:
>   - suffers from garbled output due to pr_cont()
>   - functionality is better provided by "fwts wmi"
> - the debug_event module param:
>   - pr_cont() usage
>   - uses the deprecated GUID-based API
>   - largely replaced by the ACPI netlink interface
> - ioctl interface
>   - used only by a single driver, no adoption otherwise
>   - numerous design issues
> 
> Since the ioctl interface is actually used by userspace programs,
> the only user (the dell-smbios-wmi driver) was modified to implement
> the necessary pieces itself so that no regressions are expected.
> 
> The series depends on
> commit cbf54f37600e ("platform/x86: wmi: Skip blocks with zero instances"),
> which is currently in the "fixes" tree.
> 
> All patches where tested on a Dell Inspiron 3505 and work without
> issues.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans







> Changes since v1:
> - add Reviewed-by to patches 1, 2 and 5
> - drop patch adding the driver development guide
> - rework error handling in dell-smbios-wmi
> 
> Armin Wolf (5):
>   platform/x86: wmi: Remove debug_dump_wdg module param
>   platform/x86: wmi: Remove debug_event module param
>   platform/x86: dell-smbios-wmi: Use devm_get_free_pages()
>   platform/x86: dell-smbios-wmi: Stop using WMI chardev
>   platform/x86: wmi: Remove chardev interface
> 
>  drivers/platform/x86/dell/dell-smbios-wmi.c | 173 ++++++++----
>  drivers/platform/x86/wmi.c                  | 285 +-------------------
>  include/linux/wmi.h                         |   8 -
>  3 files changed, 132 insertions(+), 334 deletions(-)
> 
> --
> 2.39.2
> 


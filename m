Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8972B753795
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbjGNKMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjGNKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2742D75
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689329468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6h8n6y8+PJ4gKntsTRte1y/a/DZfytgEmy6WKp/h+o=;
        b=Sh5g+el/2q8kbbLeVwF8+DJuFRM0kRm+0xfV1m0KAzraDbzyyrr8Rl+eeRVnWVrzbikEuM
        1t+fPWqB1ZdiVJ8QpMWEDwc+jxh3K/nAY9ZXcRoDmJW2oB8rxwDBC57aB1sPZR5wRaChe2
        J7n4AGelVDtZoi6lmRABOKpbzTzx+FE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-Kt8o6HFSM9KOsCh1EI_Inw-1; Fri, 14 Jul 2023 06:11:07 -0400
X-MC-Unique: Kt8o6HFSM9KOsCh1EI_Inw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9928b4f1612so98041866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329466; x=1691921466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6h8n6y8+PJ4gKntsTRte1y/a/DZfytgEmy6WKp/h+o=;
        b=Bxzf2kZOI1gqlDc+qME8ut90ppKk/hd1B/vFPDdjlt9njrc5w1jUKbq/6eX1unUb1l
         gbCa71SCaQZXZN7E/KiaCamro9H39UPU5JsuQJPjMSOOXvqcgqdnvfeVAQI9oMVNYsM5
         FHPKEnbdQAm6fM2AawsYl7zaN6/3BDfmT3cesY+5AIks0YTS1doDLdjJTLyPHozHHElm
         ar+Zx2AMEKQoh7lBXR6c0LrNc54U8eWPdAIdJPwIhfI2gOcOMP9PUMl4peB0a6CJokfR
         sEqKXLEykHrTZwA6TPjwER4kqevL6mNPcu1x0lbQFcJDZ724vqdkQwHcoygLBu8b8vRI
         yEWQ==
X-Gm-Message-State: ABy/qLbTsGr5hUuE/QL/waaDb9HZCQ5nyDsMx5cGduzeCgHxxwt0GaHO
        lMK5QKPfUiWFiVvmt1fbgoGExTOKrisbLx63g0hSjeGK9oXBmJ+MeqL6CBGJJ9jbhY9ek2Q9n3I
        Vqenor2YWx8N+EXTV12K8arY8
X-Received: by 2002:a17:906:224a:b0:991:caa8:fc3a with SMTP id 10-20020a170906224a00b00991caa8fc3amr3843243ejr.72.1689329466163;
        Fri, 14 Jul 2023 03:11:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGC1hijiNkUKr+wy7gnsAFubiIwRdiNE71erOBSHtFCTEGwGSRtlVxuWPGBDnSDCfKaCc0tag==
X-Received: by 2002:a17:906:224a:b0:991:caa8:fc3a with SMTP id 10-20020a170906224a00b00991caa8fc3amr3843226ejr.72.1689329465894;
        Fri, 14 Jul 2023 03:11:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906471800b00992b71d8f19sm5196588ejq.133.2023.07.14.03.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 03:11:05 -0700 (PDT)
Message-ID: <ac49e4a3-8fe1-b501-2a62-7c06a9ed36b6@redhat.com>
Date:   Fri, 14 Jul 2023 12:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/3] platform/x86: simatic-ipc: add another model and
 hwmon module loading
Content-Language: en-US, nl
To:     Henning Schild <henning.schild@siemens.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
References: <20230713144832.26473-1-henning.schild@siemens.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230713144832.26473-1-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/13/23 16:48, Henning Schild wrote:
> cahnged since v1:
>  - switch to using a list of modules per device
>  - add p3 and make the watchdog module load code use what p2 created
> 
> The first patch just adds a device that is pretty similar to another one
> we already had here.
> 
> The second patch loads modules for hwmon support, should they be
> available. That will save users the need to detect and manually load
> those modules after a machine has been clearly identified by its Siemens
> Simatic IPC station id.
> 
> And finally p3 changes another request_module call to use the mechanism
> introduced in p2.
> 
> Henning Schild (3):
>   platform/x86: simatic-ipc: add another model
>   platform/x86: simatic-ipc: add auto-loading of hwmon modules
>   platform/x86: simatic-ipc: use extra module loading for watchdog

Thank you. I've merged this into the new platform-drivers-x86-simatic-ipc
branch where I'm collecting all the pending platform/x86: simatic-ipc
work.

Regards,

Hans




>  drivers/platform/x86/simatic-ipc.c            | 74 ++++++++++++++-----
>  include/linux/platform_data/x86/simatic-ipc.h |  1 +
>  2 files changed, 57 insertions(+), 18 deletions(-)
> 


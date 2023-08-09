Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF007769B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjHIUR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjHIUR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C661210D4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691612202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hqXYNMBQ38+Di/U89rzXjLItW5R+yBS3eAdrZiaZJE=;
        b=ZeP+nB04GRVm7+1tMMoPz3XfYepVe+UuTRjvM5exDYx6kXwqj9w68PuSnMhmRwDUgr4nnk
        iD5EVz30swtWOLti/TsYLTOKX7FG2CnUnh0yoz1kMlqJzo5UAlmvs/wqA3nok+k5YA/W/Y
        kBUNsd2kXX5zu0ORdBvp5q9uYdmo/Yw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-QlVyV49jOT6VNLlBQDwqPQ-1; Wed, 09 Aug 2023 16:16:40 -0400
X-MC-Unique: QlVyV49jOT6VNLlBQDwqPQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99cc812bde9so177828666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691612199; x=1692216999;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hqXYNMBQ38+Di/U89rzXjLItW5R+yBS3eAdrZiaZJE=;
        b=QWg+aDntOb519a8j/CtV1ga2Ui+wFfAbf3Sgb2euoJtPzZgHYZKm1kkBR0IsbjplBj
         a2LhjA/hPjE5QU7APIDNhNinVGgAYVoKOaxlKg82VxPfGu5GpgqVJC0AL+SgtJ09r15y
         rZUud3QRxR2GFjHUO7oMX1VyNt21P3mebYFwsm8UsNZD04uR+8R/mmRMQrj1C9lYQxmu
         5kq9+kQ3zDedtL7wHevFp9ItDI5+JTftchFwY/PREIVETRADkGJ7M6E4vgCC3BFyP4s4
         Bv3OZEgndm8dINJJMRzOIsU9wzXliwTpPIi37AR9PGWHMWwnmo39RU0feNRAou1P1ovX
         fPCg==
X-Gm-Message-State: AOJu0YxB/XiZky02QaoTQRzSJdLfBDQKl78gu8jewBBl6uSIrd6eLJRA
        pQfxOH78ZIs+Hx8njwotciWmtQoq5bF0jKsRL/RHGXVPLMm+DK1/rzbZFR5ASzntFDh5ToM2/L5
        U1yybwdMvzMY9+Ny23XLPhyti
X-Received: by 2002:a17:906:1090:b0:99c:ae54:6654 with SMTP id u16-20020a170906109000b0099cae546654mr673658eju.14.1691612199502;
        Wed, 09 Aug 2023 13:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVZmosDshOg0tpVwWAYM4IxlYHv3S/Ewg3u5ajEuwyQtrQW9LvYjTvxymEl9edZgMsRlcwaw==
X-Received: by 2002:a17:906:1090:b0:99c:ae54:6654 with SMTP id u16-20020a170906109000b0099cae546654mr673635eju.14.1691612199183;
        Wed, 09 Aug 2023 13:16:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z25-20020a170906271900b0099b4d86fbccsm8586406ejc.141.2023.08.09.13.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 13:16:38 -0700 (PDT)
Message-ID: <5f9b3dcf-4551-c959-4cd2-990923c76bcc@redhat.com>
Date:   Wed, 9 Aug 2023 22:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/2] mlxbf-bootctl: Support access to the large icm
 size and setting the BlueField boot state.
Content-Language: en-US, nl
To:     Asmaa Mnebhi <asmaa@nvidia.com>, markgross@kernel.org,
        vadimp@nvidia.com, linux-kernel@vger.kernel.org
References: <20230809162857.21243-1-asmaa@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230809162857.21243-1-asmaa@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 8/9/23 18:28, Asmaa Mnebhi wrote:
> Support 2 new features for the mlxbf-bootctl driver:
> 1) Enable reading and writing the size of the memory region
>    dedicated to the large ICM carveout.
> 2) Enable setting the BlueField ARM boot state to "os up".
>    The SMC call involved will handle updating the state in
>    BlueField registers.
> 
> Asmaa Mnebhi (2):
>   mlxbf-bootctl: Support the large icmc write/read
>   mlxbf-bootctl: Support setting the ARM boot state to "OS up"
> 
>  drivers/platform/mellanox/mlxbf-bootctl.c | 67 +++++++++++++++++++++++
>  drivers/platform/mellanox/mlxbf-bootctl.h | 19 +++++++
>  2 files changed, 86 insertions(+)

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


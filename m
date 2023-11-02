Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009557DF087
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347263AbjKBKqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347208AbjKBKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB42AE7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698921954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9mBMnZXkfcn8X+S1uWPcpA8muaoQVjDKXTStMVPXQk=;
        b=EmXyCwn6/voZedyi3tlQaGSxPn252OT+AJFyUuOKTirpx2Cql1PU7XjujK0f2fh62edf/F
        TF1hkTTAxau4/sMaDXYUP0vR9u2I5/odI5uA4ScgG6Uw+PK6NZCcoHvW23r+liUI6qxZ5K
        70DfUwm7fo6L4ZdQYULdO49sVaXz7MQ=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-T-vozEQuMKeePl6o7eePPQ-1; Thu, 02 Nov 2023 06:45:52 -0400
X-MC-Unique: T-vozEQuMKeePl6o7eePPQ-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7ba2b284b32so112482241.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 03:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921952; x=1699526752;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9mBMnZXkfcn8X+S1uWPcpA8muaoQVjDKXTStMVPXQk=;
        b=hmsz4QFhvnADPzzqeFVaFr3Cmf4kVxz+iGyS7TwH7uLMSxj2hA/i74CEU66VygTYTB
         ECRyoJJxTwXawv3tjcEnlUF6B22VJ0zOxgGK+YfjcXDnRjhnMt5SmuepgekD4EJUNxVg
         uXj5ZKYswv6vbY5FyB1DCEKV8H85lsJ6y4jsVLz3LToH/LiR8ki6pbbbmXRDkKAC7O07
         t9KzELqU759Y0/oWQNf1GCB3wNl82jAJjrxjBV+UZtp6ZrSJviEv5zcKTzoiXB6nx9+a
         YfTE//tkOCWDMADml7T6dCYiPOGf0qMqXzcROrh2EWmdmpvUnL8NRTQA0ORQExNupe94
         4/mQ==
X-Gm-Message-State: AOJu0YxyWrClhTO7Y3B0i+EJt74AFU1ydSCCHxEjBWmQSyCAprb4KPmy
        KDP5/7WVIYVAxQZpxz6drEPtowSXA7++kkgplfG8XcYxR7rHwXh5BR6b5v4oAH3GiVoBppIbWk7
        r4E6m6b67wAQ8U+qvH2Im/PZ1
X-Received: by 2002:a67:ec09:0:b0:45d:6f59:75d with SMTP id d9-20020a67ec09000000b0045d6f59075dmr1132341vso.3.1698921952277;
        Thu, 02 Nov 2023 03:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEUz+8/oijfPH+hmrLS8G8SbahpZB+B82vOdVxZz6QZCauVC6ge20YbaMyHu2lpttGCmY9SQ==
X-Received: by 2002:a67:ec09:0:b0:45d:6f59:75d with SMTP id d9-20020a67ec09000000b0045d6f59075dmr1132326vso.3.1698921952004;
        Thu, 02 Nov 2023 03:45:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-153.dyn.eolo.it. [146.241.226.153])
        by smtp.gmail.com with ESMTPSA id f28-20020ad4559c000000b0063f88855ef2sm2252683qvx.101.2023.11.02.03.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:45:51 -0700 (PDT)
Message-ID: <9bc9514044063bc57155fb786f970ca1d69758b4.camel@redhat.com>
Subject: Re: [PATCH net 6/7] net: hns3: fix VF reset fail issue
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org
Cc:     shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Nov 2023 11:45:48 +0100
In-Reply-To: <20231028025917.314305-7-shaojijie@huawei.com>
References: <20231028025917.314305-1-shaojijie@huawei.com>
         <20231028025917.314305-7-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-10-28 at 10:59 +0800, Jijie Shao wrote:
> Currently the reset process in hns3 and firmware watchdog init process is
> asynchronous. We think firmware watchdog initialization is completed
> before VF clear the interrupt source. However, firmware initialization
> may not complete early. So VF will receive multiple reset interrupts
> and fail to reset.
>=20
> So we add delay before VF interrupt source and 5 ms delay
> is enough to avoid second reset interrupt.
>=20
> Fixes: 427900d27d86 ("net: hns3: fix the timing issue of VF clearing inte=
rrupt sources")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c   | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/=
drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> index 1c62e58ff6d8..7b87da031be6 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> @@ -1924,8 +1924,14 @@ static void hclgevf_service_task(struct work_struc=
t *work)
>  	hclgevf_mailbox_service_task(hdev);
>  }
> =20
> -static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regc=
lr)
> +static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regc=
lr,
> +				      bool need_dalay)
>  {
> +#define HCLGEVF_RESET_DELAY		5
> +
> +	if (need_dalay)
> +		mdelay(HCLGEVF_RESET_DELAY);

5ms delay in an interrupt handler is quite a lot. What about scheduling
a timer from the IH to clear the register when such delay is needed?

Thanks!

Paolo


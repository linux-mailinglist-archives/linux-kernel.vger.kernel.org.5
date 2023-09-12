Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6366F79DBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjILWkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbjILWkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:40:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69B610E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:40:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf5c314a57so44634675ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694558433; x=1695163233; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1O93Em0dGb2w1gcbLaR3b+qaKxj8ErGxsZztgFUmxE=;
        b=eBvbVQw9ClHZaEZA8mJtng0OkccL5LKYyjZ/4zLu3ZhgedPk50rXGQL83nEndraIoe
         ZzaBZrfLuaK8b0WfwFksHntz0lIUQ5x8XXIZG1fkNXgZSXw4qYmie2NPGQMtS9Zw79b3
         Oc/4dX2oVhgTj4kUPCXVSZgjAgx2ofX+vFTZsLLbgskHq41zMq0RVA0lpq9Dyepob2BS
         lHKjXR9hMaIqLvhztskGrf0TFMe2ZPoLGcMrwLQRHLO8ZQqRtVuqw+UHXivNy/JD3anj
         z4U94DEULyCsIHHunJkJqPc90R/pCP1SK4kES4VgZJrvkaw6o5zmvFRPaZu8ZoYKK0Wg
         tYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558433; x=1695163233;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1O93Em0dGb2w1gcbLaR3b+qaKxj8ErGxsZztgFUmxE=;
        b=ioemlH3/xRA89Ulh9lvXVofA9YSuCZ396/jCo95WcbyxWL2tw1Un9bidDsLtr0HIAO
         Yj6BOYxK7dFvYx/auA0ymdiBykOCRLZ6SlLpzYb/t7OPnduT7Bg+dU2EM01bOVD3CE8D
         zbLgRbVxkvdQdbRZVwbTMsbAL+soQ1LhzFdFw8BGB5h/nvHb8tJXooiDhepxI3XEDlSy
         Qb7FMRppC/uWyFfFGzB42HQo58xxK10T2jM0kvLk8ZW/idBET0+bD/yZvd6ysLioNwit
         xeD1b/xUbc8DsDtPWhx/HdrFyWyScgW7ZkpNyB4X2TjBC88hYr2io7WADyfjwGAkwqt6
         wynQ==
X-Gm-Message-State: AOJu0YwitH1FGMA108MdTeFxUh4e2+BYvMo/Eo4jbVpHp7DmC5laqV6S
        5wUA1o1mDvJMrtGNMuMtW1z9Mw==
X-Google-Smtp-Source: AGHT+IEJmsLAsW5l+VB/hOPMJJgw4AHIPmDee2zCHtRkWTNC/a9XAmGaVZj83Hcxw7dHfLY1DzqAdQ==
X-Received: by 2002:a17:903:22c3:b0:1bb:59a0:3d34 with SMTP id y3-20020a17090322c300b001bb59a03d34mr1264418plg.30.1694558433268;
        Tue, 12 Sep 2023 15:40:33 -0700 (PDT)
Received: from localhost (71-212-56-62.tukw.qwest.net. [71.212.56.62])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902eb0c00b001bf574dd1fesm8943675plb.141.2023.09.12.15.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:40:32 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Dhruva Gole <d-gole@ti.com>, Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vibhore@ti.com
Subject: Re: [PATCH] bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling
 for uart wake-up
In-Reply-To: <20230907062231.muwzvje726wlqnqw@dhruva.dhcp.ti.com>
References: <20230907055441.19476-1-tony@atomide.com>
 <20230907062231.muwzvje726wlqnqw@dhruva.dhcp.ti.com>
Date:   Tue, 12 Sep 2023 15:40:31 -0700
Message-ID: <7hsf7j582o.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dhruva Gole <d-gole@ti.com> writes:

> On Sep 07, 2023 at 08:54:41 +0300, Tony Lindgren wrote:
>> The uarts should be tagged with SYSC_QUIRK_SWSUP_SIDLE instead of
>> SYSC_QUIRK_SWSUP_SIDLE_ACT. The difference is that SYSC_QUIRK_SWSUP_SIDLE
>> is used to force idle target modules rather than block idle during usage.
>> 
>> The SYSC_QUIRK_SWSUP_SIDLE_ACT should disable autoidle and wake-up when
>> a target module is active, and configure autoidle and wake-up when a
>> target module is inactive. We are missing configuring the target module
>> on sysc_disable_module(), and missing toggling of the wake-up bit.
>> 
>> Let's fix the issue to allow uart wake-up to work.
>> 
>> Fixes: fb685f1c190e ("bus: ti-sysc: Handle swsup idle mode quirks")
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  drivers/bus/ti-sysc.c | 22 +++++++++++++++++-----
>>  1 file changed, 17 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
>> --- a/drivers/bus/ti-sysc.c
>> +++ b/drivers/bus/ti-sysc.c
>
> Thanks for the fix Tony,
> I have tested this on a TI SK-AM62x with deepsleep and am able to wakeup
> with keypress on the wake_uart.
>
> For anyone else who wants to give this a shot, the required patches for
> deepsleep and DT related changes have been pushed to my branch on github
> [0].
>
> Hence,
> Tested-by: Dhruva Gole <d-gole@ti.com>
>
> [0] https://github.com/DhruvaG2000/v-linux/commits/v6.5-rc7_wkuart

Also tested on k3-am625-sk using Dhruval's branch.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

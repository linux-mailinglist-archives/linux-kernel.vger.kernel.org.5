Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632D078197E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjHSMT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjHSMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:19:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB0046AE;
        Sat, 19 Aug 2023 05:17:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-689e8115f8dso1642904b3a.3;
        Sat, 19 Aug 2023 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692447473; x=1693052273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqFv/DijWNoxc1tP/BtYVoap/FTC5GEIpTOWCskdDOY=;
        b=gWiGDwhU5cPMRdRtHhQ1MUgMeHa0b7Crp0WJKcAUww4cdPmlfaVJHj3CxuEFNX2sU6
         mDCcx6wctGqajgNH3XD7az73YdNHTytXa5R2g9mZEj3PeE6q95Fjp9v3UkuT3Nw51tG6
         lN5e8lJAYBCNPVG2v3dppWxV8kh8trt7PNVccWWpILjb1PxVnmLJexQzb1KF1D4GrMj1
         kurnMrkJX4KpWV1ZsIwSJ0Ok7U5DLSs3idVtF70BJBUeiIxYWEX9B7/WX4ikoopI+H3k
         5o0zCFfV6uyca2E+Wj165a7R8bRzI1iLJO2mV/8TcGA0GDKH1u+C+vZZU85CTVwTZhmc
         slmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692447473; x=1693052273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqFv/DijWNoxc1tP/BtYVoap/FTC5GEIpTOWCskdDOY=;
        b=YDGBmOQFhhSAqkGff6KTw4CxfOis1T5Hme/P2XXxCibeS7Dqnco5N6tQSd7Zv+i6Ar
         oEVkcgOX2lNk4WmbD6qDaKNCaFGwYlovj0D1sX7WIaLlPRgOWkRRL3e+sAp70JHP81Al
         OhvQ6WOKjZ8HxQah0tNaT/EB6HFBfsiAYJF7MWRm/ERnNP2wl1jJPp7aaDk6yBgvqPDH
         ebJEAlpzXgqOtbYrn36hGWZrLKIuOMNhOfiay+8XbIihTeJXnVMUuQNQTlSZYl/KkMAB
         Wayp3ocP0jXMnIEZrf8GoZTDuFlr4H5EQus9rfkPgGX9Slz0u4XgQ2KEd+AvkC8RIFiq
         9x0Q==
X-Gm-Message-State: AOJu0YyR83DGKcNMSZpnHT7LD9ndCyV41wq7Lx6ohXUe/QsUtKWXanP4
        7S8fwmw7mfAbzrsK33IvWoVY6zU4REM=
X-Google-Smtp-Source: AGHT+IFuujq7/fsp5qxfiac3GcM1wRKYP05i9gXZVheke4Opxvwfhj2h8RFRMchjgk0pBhPUn87tSQ==
X-Received: by 2002:a05:6a00:cc2:b0:689:f746:cba3 with SMTP id b2-20020a056a000cc200b00689f746cba3mr2609461pfv.32.1692447472860;
        Sat, 19 Aug 2023 05:17:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4-20020aa78244000000b00684ca1b45b9sm3183241pfn.149.2023.08.19.05.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 05:17:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Aug 2023 05:17:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: pmbus: Reduce clear fault page invocations
Message-ID: <409c9de8-4f4a-4a6d-b029-00f881debfeb@roeck-us.net>
References: <20230817092527.808631-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817092527.808631-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:25:24AM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Observing I2C traffic revealed consecutive transmission of CLEAR_FAULT
> commands. While this doesn't cause issues, it extends driver probe time.
> 
> Avoid invoking pmbus_clear_fault_page for virtual registers, as they're
> managed by the driver, not the chip.
> 
> TEST: Verified using an I2C bus analyzer that only one CLEAR_FAULT
>       command is send instead 5 in a row.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> base-commit: fc8df28be7155ddcf8731b4c85fd3372811ba5ac
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 69a4e62b6c8d..cbfabdd69056 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -561,7 +561,8 @@ static bool pmbus_check_register(struct i2c_client *client,
>  		rv = pmbus_check_status_cml(client);
>  	if (rv < 0 && (data->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK))
>  		data->read_status(client, -1);
> -	pmbus_clear_fault_page(client, -1);
> +	if (reg < PMBUS_VIRT_BASE)
> +		pmbus_clear_fault_page(client, -1);
>  	return rv >= 0;
>  }
>  

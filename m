Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39210808627
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjLGKzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjLGKza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:55:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54925E9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:55:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c5ed26cf6so1029152a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701946534; x=1702551334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TXxDJGtmjiM22FEkVERK8ySPEzsoGKIm7RSPRTPokbM=;
        b=ntBFraEhWOPM9gWF8t2miBcfUf69YwQEucEm9cHd0YPrL+stwzOr+BZsv+M6QYugeV
         bAswLwnhy1qghfGv/KSNyFoGOozjByn4sYhoy0xxB5S+M8AK8dr75p4csDGihyskfkTU
         R1Rfl0DcO+pHxjhIkDJlYX0Uh1EXIhYrFGI2I8ReJk1u/EN2tEAuSGqhzGs9rsggRTfL
         OM6AWuHEWE/0+lHDKrEK9SaL3t7SzAgG5/XZrjhXPoIdKRKBAcZ2BHX6pnbdDJCjMMtx
         vgjrX26VQXZuA7JWznPpLzGjyTOM5CLmyeyVCSvoD+Nr7WsxEiU5dTnV8IJCWQHUZEUK
         dsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701946534; x=1702551334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXxDJGtmjiM22FEkVERK8ySPEzsoGKIm7RSPRTPokbM=;
        b=v2JvWb+FqDELscn5eWDa+U8bcVHPSt86MPTR3Fd89/ZTAwYRV0KWcSCpcsiCsl9P+t
         pDnwOQ7KgD2T0x6JNrfUNLfYc1HFNNDn7lDKdg8/x2jXGKIHITWTC3sSiwt2WevjKNrr
         gD1JcTOKqWXQR7gFRAQGthbbtbTi+N8Fq3E5Qj4P1wwPK+na+E8qPfkXPKL9oqSuaVvR
         9VioHav49c+yOUx9iIEVoTq7EGGamojsOWeIfSnEVtQ9L1jzzx6TgxMpMgvsW8blalBi
         YBinpMkOB0ULNjcuWZzBd7H7uf1pTaHQHI/G713HFpcp3XgxPGXTIxhzaa+UdUKg7t/h
         yY0Q==
X-Gm-Message-State: AOJu0YyrVBpfprKg+E5C47nB1wTAyfKbayiMgHDjrxnvuUXu85KcKz8R
        OJfL4aL+fbdxH/3PZdpjz4550A==
X-Google-Smtp-Source: AGHT+IEI2ozgLa9f4Uirnyi4SWmkF9wnW6TZz68sJgvSnNdkJ0YfUlzWdGUYslowf+6iG4cyCQ57Xg==
X-Received: by 2002:aa7:c3c8:0:b0:54b:5170:5cd2 with SMTP id l8-20020aa7c3c8000000b0054b51705cd2mr1387410edr.20.1701946533802;
        Thu, 07 Dec 2023 02:55:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q30-20020a50cc9e000000b0054b1360dd03sm651871edi.58.2023.12.07.02.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:55:33 -0800 (PST)
Date:   Thu, 7 Dec 2023 11:55:32 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Schmidt <mschmidt@redhat.com>
Cc:     Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hgani@marvell.com,
        vimleshk@marvell.com, egallen@redhat.com, pabeni@redhat.com,
        horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
        wizhao@redhat.com, konguyen@redhat.com,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: Re: [PATCH net v2] octeon_ep: explicitly test for firmware ready
 value
Message-ID: <ZXGkpGuJSCds5idf@nanopsycho>
References: <20231207074936.2597889-1-srasheed@marvell.com>
 <CADEbmW1qF7UvGr0rZ0NUMiP0Lybgz3CHLB3JVBn_Na-8md-tgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW1qF7UvGr0rZ0NUMiP0Lybgz3CHLB3JVBn_Na-8md-tgQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Dec 07, 2023 at 09:45:15AM CET, mschmidt@redhat.com wrote:
>On Thu, Dec 7, 2023 at 8:50 AM Shinas Rasheed <srasheed@marvell.com> wrote:
>>
>> The firmware ready value is 1, and get firmware ready status
>> function should explicitly test for that value. The firmware
>> ready value read will be 2 after driver load, and on unbind
>> till firmware rewrites the firmware ready back to 0, the value
>> seen by driver will be 2, which should be regarded as not ready.
>>
>> Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
>> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
>> ---
>> V2:
>>   - Fixed redundant logic
>>
>> V1: https://lore.kernel.org/all/20231206063549.2590305-1-srasheed@marvell.com/
>>
>>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
>> index 552970c7dec0..b8ae269f6f97 100644
>> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
>> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
>> @@ -1258,7 +1258,8 @@ static bool get_fw_ready_status(struct pci_dev *pdev)
>>
>>                 pci_read_config_byte(pdev, (pos + 8), &status);
>>                 dev_info(&pdev->dev, "Firmware ready status = %u\n", status);
>> -               return status;
>> +#define FW_STATUS_READY 1ULL
>> +               return (status == FW_STATUS_READY);
>
>The parentheses are not necessary, but if you find it better readable
>this way, so be it.

Well, since return is not a function, parentheses should not be here.
Please drop them.


>
>Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>
>>         }
>>         return false;
>>  }
>> --
>> 2.25.1
>>
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC497B2D00
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjI2HXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjI2HXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:23:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93A1B6;
        Fri, 29 Sep 2023 00:23:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso108792005e9.3;
        Fri, 29 Sep 2023 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695972208; x=1696577008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cux9VjeRfGaXQjmk5x5nxWjUwDhFTF5a1p0PHt2oJ00=;
        b=Vhi4neJ934jhlLlUL3FGLmpZxuE/V366nZDK/ztI8qCQVErFGdE7PK/hKV6JMjekBi
         B/8PQ4RqMduiulO4wrVP7nisd/pylifJAAMfsrJWgmqljdhYqRnmLEPOEl2tIfNymddV
         0u2tQB6SgMvoIxDF+fmFex0DZcA3F+saFtjOmfEDYc/IAtMPzghWEq8OR4BI9Xlwm42b
         jrtMR2i03uW7TZthcWV7wELuCUVSJwvPsvo4Onkex77rElS7dJ+ZX+8w1QWIhhoyD08H
         OSUAJh6QIrczNyGdZiGnkiAP5fXE+6rScvCTA+ocaG42R9aCaJosnTCfong70hmVY+Fc
         3LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695972208; x=1696577008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cux9VjeRfGaXQjmk5x5nxWjUwDhFTF5a1p0PHt2oJ00=;
        b=BuOn57YOAtLTE9NHT5+9Rg65bGACFfwhMmj9GitCNsv3tVUkAFBpaJMeuQreZnLN45
         ENAxpA8TJnvu+/+hVh3AxbN/Ic7zEWE2UVKkT4wQ/LJ9+XyCCssETY+bMIAsxhVZvkqW
         xk8bGiT4kGKio9f+nlejpTHNew69e3Yd8nuIBZoCwoYLkwJoUlXkdmzEL3w1zPdmCb/U
         LIvJ0gM1Z5PsG08k4zSnTWsn+OKFR/Y+1dGV/yhqxqsmy4jZfDVVSleCHP5UHwSjlp/D
         0qxaIjyJgNWbK5ivFQrN08xQdbTLF8sdFybtsbok5rZqYrAQrl5m0WBLOZ48dVHwJ2e9
         sgNA==
X-Gm-Message-State: AOJu0YwOpCo1Q4eGe7fKCdGPvWd7Svk5dW2d9MGqLGSLFsq8Lf97glGr
        lSr7mQJ+VNl1KbZ4R+cPO4EfaolaG1s=
X-Google-Smtp-Source: AGHT+IGOH0KkPpIYtfrxUyC0dj6fMEyFvjUrQ81XvR59jzV8VxRNR35hApEl5vHFizq4NR0pCq77gw==
X-Received: by 2002:a1c:6a08:0:b0:405:3455:d603 with SMTP id f8-20020a1c6a08000000b004053455d603mr3126701wmc.17.1695972207677;
        Fri, 29 Sep 2023 00:23:27 -0700 (PDT)
Received: from shift (p200300d5ff28e300aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff28:e300:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id f7-20020a7bcc07000000b004053a2138bfsm811061wmh.12.2023.09.29.00.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 00:23:27 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by shift with esmtp (Exim 4.97-RC0)
        (envelope-from <chunkeey@gmail.com>)
        id 1qm7qQ-000000002i6-2x9e;
        Fri, 29 Sep 2023 09:23:26 +0200
Message-ID: <c5611be9-ef4d-4e49-84de-7ce893e3c73c@gmail.com>
Date:   Fri, 29 Sep 2023 09:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary (void*)
 conversions
To:     Linux Wireless <linux-wireless@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Wu Yunchuan <yunchuan@nfschina.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@kernel.org>
References: <20230919044916.523308-1-yunchuan@nfschina.com>
 <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com> <87zg16iab3.fsf@kernel.org>
 <0b7623f7-561c-4f3b-91c1-aaf1c44f1158@kadam.mountain>
 <d41d0c98-82ef-40f6-8c5c-68a94b5a4655@kadam.mountain>
Content-Language: de-DE, en-US
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <d41d0c98-82ef-40f6-8c5c-68a94b5a4655@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/23 08:49, Dan Carpenter wrote:
> On Fri, Sep 29, 2023 at 09:43:03AM +0300, Dan Carpenter wrote:
>> I don't know anything which would warn about this.  Generally, in the
>> kernel we try to avoid casts but perhaps there was a static checker
>> which likes casts?
>>
>> If removing these sorts of casts were an issue we would have known by
>> now.
> 
> Thinking about it more, if this caused a static checker warning then
> probably every kmalloc() would need a cast.

Oh, we do have our fair share of static checker noise in:
drivers/net/wireless/ath/ (this is where carl9170 is located)!

I would like to take the chance to again point to this beauty:
<https://lore.kernel.org/linux-wireless/TYAP286MB03154F9AAFD4C35BEEDE4A99BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/T/#mf1b8919a000fe661803c17073f48b3c410888541>
@Dan, @Jeff can you please comment on that too?

As for this patch: If Wu ran some compiles with
what GCC version he has available and nothing turned up:

Acked-by: Christian Lamparter <chunkeey@gmail.com>

Regards,
Christian


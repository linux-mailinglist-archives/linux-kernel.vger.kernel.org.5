Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FC80732B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379038AbjLFO61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379000AbjLFO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7A2B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701874711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lI8W6CO+u1S10tMvsZNrVhiLtm/T33ov+fTqgOUmfWo=;
        b=i475HHpH2DLydJNBRo85fJyNhaDqqI6F6Wx7CcNHyWuWSllUfFWEalnBo71c9MbOhIUo5r
        V1XD6Xyzy/1z9JLb758dTqzA3MJaSzgGIZEd3tsnKKmspOKOtSFtTtgvzXrpXDnyZt1HiR
        xh22OgrJq9ibzvEx+xE/q/W4458lxWI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-IqVHfIo9PPiV4gfpXZ7htQ-1; Wed, 06 Dec 2023 09:58:26 -0500
X-MC-Unique: IqVHfIo9PPiV4gfpXZ7htQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c9f5bf236fso36091881fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701874705; x=1702479505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lI8W6CO+u1S10tMvsZNrVhiLtm/T33ov+fTqgOUmfWo=;
        b=LMS4raEQ4qOjBslWx779la4HjqVw7RS/R9D56GuwS2f9Yh1uPDU6UNSFCDBjtelY+M
         Rhf4txrdleI94OoaCIf54IHhTlh06XlC/PCPO/D1I+EYubQmclv5M+9O0e/gUDFf1GCu
         6rTvDwF4v9XkiqA6sO+JxPYw/mI4moj8fu7EQFUbCo4ivFejrEZz30QXsfLtcstYBBBb
         eqSDly5TEJAlHb6wh4BpERTn5IOO2IyFb7TTLx0TmpdlOCKb7+XaxrX2ig6hX2EALm+Q
         i1RTfaIdtS6aW/VMLgK5nlekvn+z5yxfbqbiwHK44DmfDAPdH8LeYl45eYt8M7pvuo3u
         8KDg==
X-Gm-Message-State: AOJu0YyzcqU/snP4clqXlU1eOk9vHcZ/HdZoSDhZdzfy2G7wG19tugb6
        JhwyXy2LR70BiGnIgIvuw2MnFkRd7lCHOH1IeSP85Tq2PgVHTlvj9zdQxklofT7j0S4+M5XbI0O
        IfxW4oy2eB38d/UnfcChVzFT4
X-Received: by 2002:a2e:879a:0:b0:2c9:f2ef:cf14 with SMTP id n26-20020a2e879a000000b002c9f2efcf14mr784403lji.67.1701874705516;
        Wed, 06 Dec 2023 06:58:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFAROg+Lxclo/3NuDIimFR4fm3oJ99oj3ElVJlPS5SozqYTKjUwT8fR42ApPqSVQx8pFmf9Q==
X-Received: by 2002:a2e:879a:0:b0:2c9:f2ef:cf14 with SMTP id n26-20020a2e879a000000b002c9f2efcf14mr784392lji.67.1701874705190;
        Wed, 06 Dec 2023 06:58:25 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id br20-20020a170906d15400b00a1dcfd8f95csm27081ejb.37.2023.12.06.06.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 06:58:24 -0800 (PST)
Message-ID: <6381d523-8f49-48e2-8576-b74a14eead30@redhat.com>
Date:   Wed, 6 Dec 2023 15:58:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] devm-helpers: introduce devm_mutex_init
Content-Language: en-US, nl
To:     George Stark <gnstark@salutedevices.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mazziesaccount@gmail.com, jic23@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
References: <20231204180603.470421-1-gnstark@salutedevices.com>
 <20231204180603.470421-2-gnstark@salutedevices.com>
 <CAHp75Vc=GAnzwhWQTifLzw8OA7Lb35hrJCDxK-RkgZnX8JmfOg@mail.gmail.com>
 <48ea90f9-922d-4a03-86da-cbb5aa9908b6@salutedevices.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <48ea90f9-922d-4a03-86da-cbb5aa9908b6@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 12/6/23 08:56, George Stark wrote:
> Hello Andy
> 
> Thanks for the review.
> 
> On 12/4/23 21:11, Andy Shevchenko wrote:
>> On Mon, Dec 4, 2023 at 8:07 PM George Stark <gnstark@salutedevices.com> wrote:
>>>
>>> Using of devm API leads to certain order of releasing resources.
>>> So all dependent resources which are not devm-wrapped should be deleted
>>> with respect to devm-release order. Mutex is one of such objects that
>>> often is bound to other resources and has no own devm wrapping.
>>> Since mutex_destroy() actually does nothing in non-debug builds
>>> frequently calling mutex_destroy() is just ignored which is safe for now
>>> but wrong formally and can lead to a problem if mutex_destroy() is
>>> extended so introduce devm_mutex_init().
>>
>> ...
>>
>> Do you need to include mutex.h?
> It's already included in linux/device.h which is included in devm-helpers. Should I include mutex.h explicitly?

Yes you must explicitly include all headers you use definitions
from. Relying on other headers to do this for you is error prone.

Regards,

Hans



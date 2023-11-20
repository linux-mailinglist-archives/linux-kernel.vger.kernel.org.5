Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D2F7F1D66
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjKTThf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTThd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:37:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF00F4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700509049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BlYDIXP3w1RwZl506oGiJVMb8cguIu5a7QZETE7Ax68=;
        b=Q/KtpZVtqDO0Ri+wn99KRVbe6gmO3GOLMdYYjbjMueMOlb/+9y+jzghujvsjL8pa37mXC1
        beiXEjQPzgGcHUJ4pRjq1mGbNJvud6jU1nlDcNLZEvuGTKMQZ+qhDa3nNsOGWhr9ObKlVU
        rwdjwXhw8GYTcwWW36yGeo4Z5MbapG4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-EMrcHOSnN524pijh9hZkpg-1; Mon, 20 Nov 2023 14:37:27 -0500
X-MC-Unique: EMrcHOSnN524pijh9hZkpg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32d83fd3765so2200277f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700509046; x=1701113846;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlYDIXP3w1RwZl506oGiJVMb8cguIu5a7QZETE7Ax68=;
        b=Khod7Zei2LLG9C5LK+bpduKWAwMzowwaBFY1RzLzZ75zFpuLzmxmZh/c/fIV2WFFvw
         3g26wib0rFxsSm8GP16BjyV8fq5oI2/53pbI+8ghwD/COWj6/MdHOLx/EUL/wNfqs09G
         NylR0++UiEVhd+ZejLaC62cqj4lm6qgy12TlPjRc8Vf6ofIUv2x4Z10Yk72GBHB2IvCC
         rBVwDsWG0Srr7d/g4omL+NeidqjKsodhS21p5uGQ7U0F0RtsaDCtQ+FzRoiFfI+6i+q8
         d0bgnqUcwEs1g3NbPP21wwKILkoGb5qm8gX/j7e++vB6OJO04LImle+hcYyQm25orlY1
         uE7w==
X-Gm-Message-State: AOJu0Yzib41TUw1WlXn2MlSqE8sIxD8ohEtgcC88L5+M/WYlGfQxBd4u
        NcXN4SoCz7bWQb4nYDgZ0Oy1hrb0GjzlRqt+LxwisxpXz19kBKNTpCe0dw5qyw6s4te8wvBnF8H
        Dn5FChGl7rAsI3Kiez0PMA/uf
X-Received: by 2002:a05:6000:1449:b0:32f:79de:8b7f with SMTP id v9-20020a056000144900b0032f79de8b7fmr6540615wrx.49.1700509046779;
        Mon, 20 Nov 2023 11:37:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjy7cAUf+TVSzll5QOp+4fMVTMb5WaOIECh3Za1iXn2WmoxuC6GE30PNx+sjRVl9ZTc2F8vQ==
X-Received: by 2002:a05:6000:1449:b0:32f:79de:8b7f with SMTP id v9-20020a056000144900b0032f79de8b7fmr6540600wrx.49.1700509046385;
        Mon, 20 Nov 2023 11:37:26 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b003316d1a3b05sm10763235wrq.78.2023.11.20.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:37:26 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sahaj Sarup <sahaj.sarup@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ssd1307fb: Change
 "solomon,page-offset" default value
In-Reply-To: <20231120-granola-sturdy-83d054f1b6fa@spud>
References: <20231116180743.2763021-1-javierm@redhat.com>
 <20231120-granola-sturdy-83d054f1b6fa@spud>
Date:   Mon, 20 Nov 2023 20:37:25 +0100
Message-ID: <875y1w2p3e.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> writes:

Hello Connor,

> On Thu, Nov 16, 2023 at 07:07:37PM +0100, Javier Martinez Canillas wrote:
>> This is used to specify the page start address offset of the display RAM.
>> 
>> The value is used as offset when setting the page start address with the
>> SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
>> 1 if the property is not present in the Device Tree.
>> 
>> But the datasheet mentions that the value on reset for the page start is a
>> 0, so it makes more sense to also have 0 as the default value for the page
>> offset if the property is not present.
>> 
>> In fact, using a default value of 1 leads to the display not working when
>> the fbdev is attached to the framebuffer console.
>> 
>> Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>>  .../devicetree/bindings/display/solomon,ssd1307fb.yaml          | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> index 3afbb52d1b7f..badd81459aaa 100644
>> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> @@ -35,7 +35,7 @@ properties:
>>  
>>    solomon,page-offset:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>> -    default: 1
>> +    default: 0
>
> I think I saw it pointed out by Maxime elsewhere that this breaks the
> ABI. It would be nice if DT defaults matched the hardware's, but I don't
> really think it is worth breaking the ABI here. Expanding the property


Yes, Maxime also agrees with you as you mentioned. It's fair to say that
this may affect potential users even when I honestly think that's unlikely.

I'll just discard these patches and point out to people reporting the same
problem than Sahaj, that they need to add a "solomon,page-offset" property.

> description to explain the impact of the particular values might help
> with incorrect usage.
>

I'm unsure how much that would help to be honest but I might post a patch.

> Thanks,
> Conor.
>
 
-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


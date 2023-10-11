Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB477C4AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjJKGj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345276AbjJKGjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F6F90
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697006344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AQICOphbR/iChM23xva2V4U+VZ5WTSVXUiRAK42TaU=;
        b=P3YpTGs54C/FVG/c3UEdcQWA+zzZNDNLjrqfcThgTJxWP8cnDrDe4siIviab3u0Vz/584Y
        0sX4bbh4tvr1/q0/xi3GM+5tFhMLGLiPIMno6JNjcR8AuMb3eqdndO5kT9vyc48jyPmMdu
        dD8eeeycgVO3FBgV0nYLLMpiEcncGiE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-PBKurAIOOICK_xvP7Xm-8w-1; Wed, 11 Oct 2023 02:39:02 -0400
X-MC-Unique: PBKurAIOOICK_xvP7Xm-8w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32320b9d671so4670411f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006341; x=1697611141;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AQICOphbR/iChM23xva2V4U+VZ5WTSVXUiRAK42TaU=;
        b=ftKRMiWntTp5GP6UGHdKXbQcfHSFR7FlAYZ5UNdYgtLBipYG8v00wDiGZbwkElchar
         EgIaTLijKDRIoEa0F6gnfI63N0X+Xzf2A3ZleinFc7hMg5BYYwx3XkU/h+/eEqFQKaHx
         0RirJMIr11GzMS7BOj2SVvyevhVsRepDMG5s65kD51E7A/3T60IZXqz5LGcvS/JPr8nS
         XVv6g+sY6Vsev4GNXrnFhcOG2rzMcNE+1cOUb84PPxikdtmQPnlC251Zl4E4+vf+a+AT
         fP5f28oP0MjOgJrZt9hJ1KPnKm8AJAADuZbRFKMwdHNb30Xopdzknl1/XsTsGmEDr+d6
         1t0g==
X-Gm-Message-State: AOJu0Yzic8g3SjcjUfrt7/c88Yhw4orLXanlhtmmx5gXII5HumVqWjdy
        wBk7M8COIDHkiIDPqJ/J1CkcD1pDSysCoC94BOcjwNuabV2ulA24vsupBenuyxmTJGihZrwt5dn
        P0Kdg1ZoWLiFCZ3VP8FXXlslf
X-Received: by 2002:adf:fc09:0:b0:31c:7ada:5e05 with SMTP id i9-20020adffc09000000b0031c7ada5e05mr15801538wrr.51.1697006341652;
        Tue, 10 Oct 2023 23:39:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP8vt8qsdEsiFmwa873YPkNT/MZf/VyaBdGjVbnmKBvLnf6NE1iPBeouliki4SV7iFb1ottA==
X-Received: by 2002:adf:fc09:0:b0:31c:7ada:5e05 with SMTP id i9-20020adffc09000000b0031c7ada5e05mr15801526wrr.51.1697006341282;
        Tue, 10 Oct 2023 23:39:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0031ad2f9269dsm14433335wro.40.2023.10.10.23.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:39:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 8/8] dt-bindings: display: Add SSD132x OLED controllers
In-Reply-To: <20231010165838.GA1039918-robh@kernel.org>
References: <20231009183522.543918-1-javierm@redhat.com>
 <20231009183522.543918-9-javierm@redhat.com>
 <20231010165838.GA1039918-robh@kernel.org>
Date:   Wed, 11 Oct 2023 08:39:00 +0200
Message-ID: <87v8bdslx7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

Hello Rob,

Thanks a lot for your feedback.

> On Mon, Oct 09, 2023 at 08:34:22PM +0200, Javier Martinez Canillas wrote:
>> Add a Device Tree binding schema for the OLED panels based on the Solomon
>> SSD132x family of controllers.
>
> Looks like the same binding as solomon,ssd1307fb.yaml. Why a different 
> binding? Why does that binding need a slew of custom properties and here 
> you don't?
>

It's a sub-set of it. Because only the minimum required properties are
defined. But also, is a clean slate schema because the old ssd1307fb fbdev
driver only supports the Solomon SSD130x family, so there is no need to
follow the existing solomon,ssd1307fb.yaml nor the need for backward compat.

[...]

>> +  solomon,height:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Height in pixel of the screen driven by the controller.
>> +      The default value is controller-dependent.
>> +
>> +  solomon,width:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Width in pixel of the screen driven by the controller.
>> +      The default value is controller-dependent.
>
> Don't define the same properties twice. Either share the binding or 
> split out the common properties into their own schema file.
>

Agreed. I'll do that in v2.

> Rob
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


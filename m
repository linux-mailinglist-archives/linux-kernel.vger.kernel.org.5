Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D97C687E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347269AbjJLIGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347259AbjJLIGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E0590
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697097920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5BfyE4ROg0DfC04dTnY4NwKgtFpCLhqUD4tbkNuiPI=;
        b=Tyj4UPIBNONHZxxilmCVQGmEihOzqmAre4fUvQREgFVvY/3ceZ8iI+e0tTjugYBABPbtQN
        t5fC1+aAnF8rRVL/iluljB+7r3lMzz4VomVr23DX1Wx6IVwIpw9/oSyKo+YGaMIA7LufHd
        Akg3YVC8eIE+vcZSNXlEREy+BEkw31s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-rzM8DeFkNW202jiBSjz5qQ-1; Thu, 12 Oct 2023 04:05:14 -0400
X-MC-Unique: rzM8DeFkNW202jiBSjz5qQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31f79595669so791160f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097913; x=1697702713;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5BfyE4ROg0DfC04dTnY4NwKgtFpCLhqUD4tbkNuiPI=;
        b=hf3WDcllYE0sMzYrtwmETQtikIh2Cx8SdA1vfyZeasAHlXL1CBXjJ12dNvFQy0k4yD
         Ylz5LI4C4Bc922syUSRajX5b5rxxlA+H4APdfxYOkQDfStJ+ID0SbguG7Gm6sAh0eMO4
         n1wXcXMR/KTXzdGfDaZgOt8buvzBUu04+i89FCGQj7B+oOM4ksHLPqlRuIoa47IX52h8
         aYcAAXQztwBSbMdnp9WENsZRue7JM9GUxllc72EWqKcpeqbIXvm12zoBkvWQONVH3y3o
         sc/LPMWKW5sdxS3MRWgYIhKcdOP9SbhvzvAuu11Tj8ii8Bp3K/vnGjO+l2jJYnF7UGNA
         NIUg==
X-Gm-Message-State: AOJu0YwwDf46bOWDQ5XqikvLYI1hJYhHtPTI1icL2GYqWlCfyRiXnsJO
        6razY6hKp/OvCgkkDeooV6vJA2g4GPvLwv6nxCRFqWdwPN8o26EuqkIfCc5ERpcelOE7r6XEi6L
        SRrrW36BvHkzh5ibIAfy+4A49
X-Received: by 2002:adf:f984:0:b0:314:314e:fdda with SMTP id f4-20020adff984000000b00314314efddamr18322534wrr.23.1697097913252;
        Thu, 12 Oct 2023 01:05:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFt1XwzzMhY09tN5qGTlWeEUZKQYgIaFEs1s2yqlG/dcK10DSfyCESrGI1Fxn+bzhxFtBA4g==
X-Received: by 2002:adf:f984:0:b0:314:314e:fdda with SMTP id f4-20020adff984000000b00314314efddamr18322516wrr.23.1697097912921;
        Thu, 12 Oct 2023 01:05:12 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b0032763287473sm17849248wry.75.2023.10.12.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:05:12 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Conor Dooley <conor@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/6] drm/ssd130x: Add support for the SSD132x OLED
 controller family
In-Reply-To: <CAMuHMdVuDvomz57RHr2NMG9+a=AXy1H39Tv5jN+1J2sqv4+3rg@mail.gmail.com>
References: <20231012065822.1007930-1-javierm@redhat.com>
 <20231012065822.1007930-5-javierm@redhat.com>
 <CAMuHMdVuDvomz57RHr2NMG9+a=AXy1H39Tv5jN+1J2sqv4+3rg@mail.gmail.com>
Date:   Thu, 12 Oct 2023 10:05:11 +0200
Message-ID: <877cns466g.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

Thanks for your feedback.

> Hi Javier,
>

[...]

>> +       u32 array_idx = 0;
>> +       int ret, i, j;
>
> unsigned int i, j;
>

Right, I'll change that in v3.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115E17DEEFD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345664AbjKBJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKBJe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307EB123
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698917623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RRqMBhNNsG2GgDNN4qWp+wu4mNgU5riKYWQ5XI3db/A=;
        b=VYR7byUYoilFUXGCDM3VkHfEqOeP/63nalHG9vkJ6HVpYGmdTBwre56G3GpNFJY5Z/g1wZ
        Jn5ezhOyVgppRK56lBSLum3Vsv1ivk8NJP6RBR2OxHPxR8/eA1wIo9TzDl75VDquSdEPkd
        7i+DYvgcKdgQHiOEjcIEK3Ooy83Rf28=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-sOBnofkDPbK6Tv3fneYlMQ-1; Thu, 02 Nov 2023 05:33:41 -0400
X-MC-Unique: sOBnofkDPbK6Tv3fneYlMQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507b0270b7fso677198e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 02:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698917620; x=1699522420;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRqMBhNNsG2GgDNN4qWp+wu4mNgU5riKYWQ5XI3db/A=;
        b=eF7YdOQ7SA8RPBPGa21gqxEtSD2OKr5mcmuDNFBPdKE8myOUDkGNKO6G2Z/PNYCRjs
         yk68+IMNMjG8DU2umZJ0Pqf2MAzN14yj/2pl0os7v+kKnMcSumFVnCBabtyqz9N/GzyC
         KRqKsXLEY47APQox2lWRadezfp1LfRz1zuWzsKWAAuzIFSlaMwBUY0oLqT2N8TwmE+gX
         wTPWc6Q/dhX7ytsRzo0PgHBjF/s7IjM0fTz34GgmEMBT8Ffr7AO5j90oVduvp/1TD5dB
         rWnHsB/k6F3LeskTYU4SxpSSaiBdn20V95BLLXGr45weIF2o+CrDXU85QPMnLLadYUud
         st9Q==
X-Gm-Message-State: AOJu0YwOE8aitlzlDiM3bcl/2AhUzrBJq4ZEdjvdGPwZAU9vNEzNQaOP
        tFOzvgOYGZDUedvdwALwuq+7EpNf2tHKAHJhJEsWEuQP9Vbj0bbw8mQuLklPYybgdwHlnsDzR2L
        5Zwj3bzzZce6SF0cXGgN6Forr
X-Received: by 2002:a2e:9b0b:0:b0:2b9:36d5:729c with SMTP id u11-20020a2e9b0b000000b002b936d5729cmr15014342lji.47.1698917620033;
        Thu, 02 Nov 2023 02:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk3Ur/kxbTus79HunF7kL0yxuSMj6fTan91sSZLYut8sHel92MvzChDXeoxbPnpM+fs9EnbA==
X-Received: by 2002:a2e:9b0b:0:b0:2b9:36d5:729c with SMTP id u11-20020a2e9b0b000000b002b936d5729cmr15014322lji.47.1698917619716;
        Thu, 02 Nov 2023 02:33:39 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b00407460234f9sm2208669wmg.21.2023.11.02.02.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 02:33:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Add option to prevent disabling unused
 regulators
In-Reply-To: <c1690b26-9004-4e5e-aa14-c61f679add12@sirena.org.uk>
References: <20231028102423.179400-1-javierm@redhat.com>
 <20231101045652.GA2897@thinkpad>
 <c1690b26-9004-4e5e-aa14-c61f679add12@sirena.org.uk>
Date:   Thu, 02 Nov 2023 10:33:38 +0100
Message-ID: <875y2kh53h.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Wed, Nov 01, 2023 at 10:26:52AM +0530, Manivannan Sadhasivam wrote:
>
>> On the other note, I'm wondering if we could use sync_state() for handling the
>> regulator_init_complete() work. This would ensure that the regulators are only
>> disabled when all the consumers are probed.
>
> That assumes that everything defined in the DT both has a driver and has
> the driver available for the currently running kernel neither of which
> is a good assumption.

Agreed. I believe the current logic of disabling all regulators using a
workqueue is the correct thing to do.

The only better option I think is to make user-space notify the kernel
that it won't load kernel modules anymore. But the delayed work would
sill be needed, since the kernel can't make an assumption on whether
user-space will notify of this or not.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


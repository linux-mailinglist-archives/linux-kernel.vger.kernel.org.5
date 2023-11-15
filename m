Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29787EC8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjKOQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjKOQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC010D5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700065949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HhjzATbTcHqeC2rLAHFfz8jbMJaW+4E6D16yI+56OE=;
        b=Tk7IgduLq+8dFe9AIg0gjeQn54F2BmQTiXnwKCuoFwGM+dcOyR9ssF5USvGb4TRX1ofGK0
        Vpd1BVyKI/hJtqfVzisvd5mFyviudiISvUzCrPXUA1epjonwoyqfOmtCgK/Hsi4+dzOX+7
        at+SMcI5ref59JrrHh1cReEl0uZ99i4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-PsdfG8yIMHueTG6hmKkLPw-1; Wed, 15 Nov 2023 11:32:24 -0500
X-MC-Unique: PsdfG8yIMHueTG6hmKkLPw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5079c865541so6675028e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065943; x=1700670743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HhjzATbTcHqeC2rLAHFfz8jbMJaW+4E6D16yI+56OE=;
        b=In9xMPigEUMfMSCPdVp+Pp7TEEvGwNcKmwiv1v0fPacRZxc00f/BOtErPoayHz737g
         TQ7EM7KkcqV8z1abUWVrIkdloiZaoysVySL5fa4SOeK8PqIgxSamFzg8vB2CBF5qgT93
         9Dnyjro4VnzNkm/LIQLfwM0/OoySEoYYvZv+WrQ1EvGYfmshP7kMq26Z9PfdT5W4WB/O
         S3wCpMLY/jFRDlp2A7mErf07eQ1sy7+YfR7NhaBvbEv+TK8AH2GT0m8PfSGCyPM+sYXx
         QEyBJaXoNusoYdYLo+cW08w7dv6/Hn0gmxaXY1RMqu91kjzZ0TwqylklqCsVXhT9fspy
         /QQg==
X-Gm-Message-State: AOJu0YxIyw8y3C383fYQ3rpt/Cx1bqDg3cdBtDKeLYetjfkrfEHhzjxU
        wV0s6dgAuqPj7SPQHS5UPYZLL3HolKV37mf7y9cMTf1dJhNK9dnE73NYWF9j2YeC/gNtprb+3XY
        +GIa3XT2bvWUoE38WgvqeYmPK
X-Received: by 2002:a19:f805:0:b0:509:488b:4de4 with SMTP id a5-20020a19f805000000b00509488b4de4mr8624182lff.1.1700065942967;
        Wed, 15 Nov 2023 08:32:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9q51kXBd1q559KpeLlyzqsk71cpoBYQo6qM5Bogh3LiVKerjNgBTCUZ5+S6NL1/v6/3QE5A==
X-Received: by 2002:a19:f805:0:b0:509:488b:4de4 with SMTP id a5-20020a19f805000000b00509488b4de4mr8624171lff.1.1700065942667;
        Wed, 15 Nov 2023 08:32:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512104a00b005092e621916sm1681840lfb.222.2023.11.15.08.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:32:22 -0800 (PST)
Message-ID: <02ea9279-7bdc-43ca-bd7d-898dee14884e@redhat.com>
Date:   Wed, 15 Nov 2023 17:32:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel-orientation-quirks: add Lenovo Legion Go
Content-Language: en-US, nl
To:     Brenton Simpson <appsforartists@google.com>
Cc:     Allen Ballway <ballway@chromium.org>,
        Patrick Thompson <ptf@google.com>,
        Jared Baldridge <jrb@expunge.us>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231114233859.274189-1-appsforartists@google.com>
 <70f12e96-0fcc-4954-8507-27cf5e15a3b2@redhat.com>
 <CAAL3-=9YYQBV-T-KhHdYrtGHH1RC29uzTuQ98roAY9GwrNrwmg@mail.gmail.com>
 <CAAL3-=-b3-RZNNfQEYzQxK=SW4PPJ7cmrX8omBniec+tgC2frw@mail.gmail.com>
 <4570d94e-b446-4fd1-a24a-db11a87846c4@redhat.com>
 <CAAL3-=_p4waxpf9a6B0Yvno0dnakZ6f81-Kfjxwbw4jA_CrcSw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAAL3-=_p4waxpf9a6B0Yvno0dnakZ6f81-Kfjxwbw4jA_CrcSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brenton,

On 11/15/23 16:52, Brenton Simpson wrote:
> Yes, thanks!
> 
> That's the email attached to my public git work, so it should be the
> one here as well.

Ok, I've pushed this to drm-misc-fixes now, thank you for the patch.

> Sorry for the hassle.  Very new to sending PRs over email, and still
> working through the kinks.

Your initial submission was almost there. Just the weird thing
with the + in the From: email-address. What also threw me off
is that the From was: <brentons+appsforartists@google.com>

Normally the '+' + the part after it gets thrown away to get
the canonical email address, so that would make your canonical
email: <brentons@google.com> where I now know it should be:
<appsforartists@google.com> .

So next time you use a + address please do something like:

<appsforartists+brentons@google.com>

I also guess you never got any of the replies addressed to
<brentons+appsforartists@google.com> since the mail server
presumably has tried to deliver those to <brentons@google.com>,
but because your normal email was in the Cc things still
worked out.

Either way for future patches note that using "git send-email"
is the advised way to submit kernel patches.

Regards,

Hans




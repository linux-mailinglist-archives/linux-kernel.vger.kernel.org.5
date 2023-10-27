Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540767D93BA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbjJ0Jbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjJ0Jbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC517CC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698399061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XNrFs0h07QQ3WzL8XWJs8qa636YWY8uqFNGGrlBPzmc=;
        b=LfETis/kcrpRc/K8jn3IyxUYjgcMxWOYK1++8qB3wrY+iU8Nc7aUIv5pr5uyA/lUJE/dHJ
        GHqpKcZTJsB4DoDb55jgWFMYA59CZxBWqR+rPUOYPW2kLFkB+tB1jM0ZnxSSKfHaqfWNRM
        dvIcABKMLtlUUy9rm9n+rsSWrMlJPL0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-0ObVcsUFOv-eR-MODt1PWQ-1; Fri, 27 Oct 2023 05:31:00 -0400
X-MC-Unique: 0ObVcsUFOv-eR-MODt1PWQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507bd5f4b2dso2073572e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399058; x=1699003858;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNrFs0h07QQ3WzL8XWJs8qa636YWY8uqFNGGrlBPzmc=;
        b=eB5NqIJqEoecRRXtrWrpYAxGCCk2znKIj5pkkemai10pQW8Z1cYBKrR2kxCLRUpJNI
         YeAvhwyLfVFLuO8p9XbYTcDlobav/kiZEBf7my4VY+ci9wvzxxAV/nVYjmIXlfhegZaZ
         M8/bg705Fq24HgSfFjUGPd8Jz1rx91H+Oe+5hbRs3zxYIsUHv2CHNeXECAebuUK/jyWQ
         pCQh8EvJl4cTbsc9rCvWqkvVsoZjwr8QIFqnUxHh7qPc8e05NWOadglDB8umqJMNqiJ3
         dMn9NBGtit++27YtZ9zZJ7EmfOlG4BtSvJO8E5JegQCTId3iS89dKPYWorYKVrcGy9ru
         A/PA==
X-Gm-Message-State: AOJu0YwOPFe4YCWFV++9BUuAYr50QS1IjYuwr8eeuLZF0o/yRhhdAGoe
        /r35wCFdRMVrHByzmuKfQ7AR0XkcCy+PJ6nNq5iFLfF0N6jygFyJeCpCjQ1wT4Hb1OcqpW08rgl
        nA/XQTILSaXg4IxOjnYfsyCy7cR9+w/cy
X-Received: by 2002:ac2:5449:0:b0:505:7371:ec83 with SMTP id d9-20020ac25449000000b005057371ec83mr1392682lfn.48.1698399058342;
        Fri, 27 Oct 2023 02:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJVuGYSYuMReQZAoVFqQtGlXfjg/2jaYA5k0xGLUkM/iujstFcVk8aJjyyfMM1Ijuxe8lSmA==
X-Received: by 2002:ac2:5449:0:b0:505:7371:ec83 with SMTP id d9-20020ac25449000000b005057371ec83mr1392668lfn.48.1698399057931;
        Fri, 27 Oct 2023 02:30:57 -0700 (PDT)
Received: from localhost ([212.80.183.76])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b00402ff8d6086sm1165870wmq.18.2023.10.27.02.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:30:57 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] dt-bindings: display: ssd132x: Remove '-' before
 compatible enum
In-Reply-To: <169801218855.747717.5658253186246322717.robh@kernel.org>
References: <20231020223029.1667190-1-javierm@redhat.com>
 <169801218855.747717.5658253186246322717.robh@kernel.org>
Date:   Fri, 27 Oct 2023 11:30:56 +0200
Message-ID: <87y1foo1in.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Sat, 21 Oct 2023 00:30:17 +0200, Javier Martinez Canillas wrote:
>> This is a leftover from when the binding schema had the compatible string
>> property enum as a 'oneOf' child and the '-' was not removed when 'oneOf'
>> got dropped during the binding review process.
>> 
>> Reported-by: Rob Herring <robh@kernel.org>
>> Closes: https://lore.kernel.org/dri-devel/CAL_Jsq+h8DcnpKqhokQOODCc8+Qi3M0PrxRFKz_Y4v37yMJvvA@mail.gmail.com/
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>>  .../devicetree/bindings/display/solomon,ssd132x.yaml      | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


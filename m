Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326F57D192A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjJTW3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjJTW3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51611D6E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697840909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WBYVjTA6Jk3GAZvnh+7RXQwGKV/swUxWZnIaQXvoxU=;
        b=i9cqsJdhoI7hzIvVqai09r6wd0A9H0adbEBJTYgulQ6OnQS5+i8f8pN86rvhfZsQ5h++Bo
        ye/UgUnLGPM4yAKXbH2dA+ZcTg85Tfbab7f+S/0qDJKVusXUjkk/xeQDZuOC5Kkx5JgieX
        5jA42gGzQ1Fv2ErwCLPtft3Lr0arKkM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-OzNuadQVOO-ZQqfWpB0PYg-1; Fri, 20 Oct 2023 18:28:27 -0400
X-MC-Unique: OzNuadQVOO-ZQqfWpB0PYg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4084e263ec4so7336435e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697840906; x=1698445706;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WBYVjTA6Jk3GAZvnh+7RXQwGKV/swUxWZnIaQXvoxU=;
        b=GVA8BdXms6uamCdHTC2IqPj+IoHZn9xhryAvW10q4BEr7T/TIhxC+gXcNyk24o7VF6
         0nVncowyDA8jvUCpOzNscz57bm5hAJ1Z4Ir3Bi7WPrrcbHFLJbSm6aRcVcgCaA9+tdq8
         aZdL49doBp/l9oH9NUiPMg+bIkCKgKJ5cC9a5KOAa4W6w7VWWgV5kTet851on8Oo2WL2
         DfPGWLquwuDoygxRmAWeQ56Rw9cqyTqA/5mstAKQ3InIPkd2WiJWV4oFM0yxXjj6QrFM
         Y9o/OVQlVySOgpufh7KwHhxInKrTkMVWX3rNO3JpIvD0rlnTD9sPuWjituki0qlyw2O7
         mWJQ==
X-Gm-Message-State: AOJu0YwdOTdIRwPnhfFd1BQYWGEBr92Bfh6flTu/IEgbfxnXg92Vx0iE
        A1mXthxTh+I9/BeGZtYJZFCjUPFeZsm+2y+Nry+rwvgoJaGU/MmePpl9JtNbmo2kJQ9DOwhH9JQ
        5b0bqi6GhHfFW0BKmIMzdTff5
X-Received: by 2002:a05:600c:3502:b0:3fe:2bb1:11ba with SMTP id h2-20020a05600c350200b003fe2bb111bamr2550034wmq.27.1697840906527;
        Fri, 20 Oct 2023 15:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTnnTeJTyNAw2QeFS5BxK7GMEmdb888js+Xuo4NjtnX6/IvU3LnEp5F1fCQHlS3MrK3LISAg==
X-Received: by 2002:a05:600c:3502:b0:3fe:2bb1:11ba with SMTP id h2-20020a05600c350200b003fe2bb111bamr2550029wmq.27.1697840906158;
        Fri, 20 Oct 2023 15:28:26 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l23-20020a1c7917000000b004063cced50bsm3079357wme.23.2023.10.20.15.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 15:28:24 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 6/6] dt-bindings: display: Add SSD132x OLED controllers
In-Reply-To: <CAL_Jsq+h8DcnpKqhokQOODCc8+Qi3M0PrxRFKz_Y4v37yMJvvA@mail.gmail.com>
References: <20231014071520.1342189-1-javierm@redhat.com>
 <20231014071520.1342189-7-javierm@redhat.com>
 <CAL_Jsq+h8DcnpKqhokQOODCc8+Qi3M0PrxRFKz_Y4v37yMJvvA@mail.gmail.com>
Date:   Sat, 21 Oct 2023 00:28:23 +0200
Message-ID: <87bkctj5dk.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

Hello Rob,

> On Sat, Oct 14, 2023 at 2:15=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[...]

>> +maintainers:
>> +  - Javier Martinez Canillas <javierm@redhat.com>
>> +
>> +properties:
>> +  compatible:
>> +    - enum:
>
> Now this is a warning in linux-next. The '-' should not be there.
> Please send a fix.
>

Sure, I'll post a fix. Thanks for reporting the issue.

This is a leftover from when the compatible string enum was a 'oneOf'
child and the 'oneOf' got removed during the binding schema review.

> Not sure why there wasn't a report, but most likely it didn't apply to v6=
.6-rc1.
>

Yes, I'm not sure either. I didn't notice it when testing with:

make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/d=
isplay/solomon,ssd132x.yaml

> Rob
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


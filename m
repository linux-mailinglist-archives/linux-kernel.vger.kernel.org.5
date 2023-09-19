Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14937A65B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjISNvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjISNu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C089F5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695131406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wyjlC6jvKki/d/AFtWf0GNSkfVlfpkzAsY5hgPuCaGk=;
        b=Gk9isi8ROt4xk+lJgBLo7hbo7E5I9QSZwwLBDB6F75Y0GAt4KbLrUHdRqKUtVfbMpaAtRa
        7iBDTgj5b/zeyeIHRaV10SMVf8NRxIS8m36xRJNIZSH4LU+QCMQ0SiEu5kqARJ74SMaZxr
        CUXVdUy2eNbZsb+UcJRhY5SXT0+QB30=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-E20OhBZzNNmcTt7tOmTXoA-1; Tue, 19 Sep 2023 09:50:03 -0400
X-MC-Unique: E20OhBZzNNmcTt7tOmTXoA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so44336795e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695131402; x=1695736202;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyjlC6jvKki/d/AFtWf0GNSkfVlfpkzAsY5hgPuCaGk=;
        b=jsNjsDrj+xRCQKc1gG2GCuFPyzDYI0d+q6GuhnMOCSNJpqm4geM9eFG/QWe1Gciaoo
         ftFyCDfQyDWnTJh9j5jLYNpIF2SkXV+Y4D4jntandB4qTpLIpB7g5phuFtF+rx2zgcTy
         0e+0ClPv99WHFIOWkPHEnBH8H1hzvB8xcFHEdhhyqn9i0ZRW3vMl4SoEzhPBtc6S/j43
         QOlTEtKh3lV1aZzk9JzEuamYeXkusCeqPMZ0IA4u3ja01zLbRK5zDLAKzvoNP9lTjf1C
         IgBjvMvZy3hu4ei4f8vndBagS+0hDn0LbnkI4eiXxaiYqu+fk1Zl67lFIwbKnsK7CVM+
         rjWw==
X-Gm-Message-State: AOJu0YxDujFKw519tIjkS6mM2O2ULVYBkuxn85yPP/d47sx6ZKHX/VTL
        PfD55uPLK+elQCI3m67jel/CoGAw683W/syXoR2sOWxWSjo0rh5UpmWfIhEX4nAdKK4719yxmf0
        Wx98W2GpkdZFpLH9RDwjMYNGX
X-Received: by 2002:a5d:6845:0:b0:319:6d91:28bf with SMTP id o5-20020a5d6845000000b003196d9128bfmr10172740wrw.60.1695131402525;
        Tue, 19 Sep 2023 06:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0iYYDeXqv2TFX2qqzd5kEt/uXjFh1qbfAteCkbBkcJsaT3iSm1X2kX0l/P4l0pxG9s5UzGQ==
X-Received: by 2002:a5d:6845:0:b0:319:6d91:28bf with SMTP id o5-20020a5d6845000000b003196d9128bfmr10172715wrw.60.1695131402076;
        Tue, 19 Sep 2023 06:50:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w4-20020a5d6804000000b003197efd1e7bsm15736497wru.114.2023.09.19.06.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:50:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Sven Peter <sven@svenpeter.dev>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Janne Grunau <j@jannau.net>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH v2] drm/simpledrm: Add support for multiple "power-domains"
In-Reply-To: <c6dd2daf-f833-4c2f-9a67-640fb2c424fc@app.fastmail.com>
References: <20230912-simpledrm-multiple-power-domains-v2-1-01b66bfb1980@jannau.net>
 <ff8e4a01-9a58-45bf-a743-08f4f6027251@suse.de>
 <c6dd2daf-f833-4c2f-9a67-640fb2c424fc@app.fastmail.com>
Date:   Tue, 19 Sep 2023 15:50:00 +0200
Message-ID: <87led2l1br.fsf@minerva.mail-host-address-is-not-set>
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

"Sven Peter" <sven@svenpeter.dev> writes:

> Hi,
>
>
> On Mon, Sep 18, 2023, at 09:11, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 12.09.23 um 22:22 schrieb Janne Grunau via B4 Relay:
>>> From: Janne Grunau <j@jannau.net>
>>> 
>>> Multiple power domains need to be handled explicitly in each driver. The
>>> driver core can not handle it automatically since it is not aware of
>>> power sequencing requirements the hardware might have. This is not a
>>> problem for simpledrm since everything is expected to be powered on by
>>> the bootloader. simpledrm has just ensure it remains powered on during
>>> its lifetime.
>>> This is required on Apple silicon M2 and M2 Pro/Max/Ultra desktop
>>> systems. The HDMI output initialized by the bootloader requires keeping
>>> the display controller and a DP phy power domain on.
>>> 
>>> Signed-off-by: Janne Grunau <j@jannau.net>
>>
>> As a simpledrm patch:
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>
>> Do you want to wait for another review from  someone with 
>> power-management expertise?
>
> I can't claim to have a lot of genpd experience but we use very similar
> code in a few other M1/M2 drivers that also require multiple power domains
> to be up without any sequencing constraints. So for whatever it's worth:
>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
>

Can't claim to be an expert on genpd either but it looks good to me as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


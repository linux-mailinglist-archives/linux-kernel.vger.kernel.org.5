Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1C5759F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGSUHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGSUHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D6B3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689797230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i4g3C6nzU3Agvgh/c0t6ZuWBnKAptGwQm3c5SNMdT5Q=;
        b=UOzucYoxwb456lbMd066+3iG06FYQO0ovpgdl5tZpGC8trwT/N5St4ew04N9Ruh154rqTW
        xGbGClIADcXaFW7JQhKITDz5U+LSD9J8j4e68dXFXWzXNGuaJ2TrTbHsGbYbH2zJl9fGNe
        ooAxkfgSzNy5XHdo/d+bpFyD6UtvuZg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-_vfvuc_rPpubSnCcnkmaeQ-1; Wed, 19 Jul 2023 16:07:09 -0400
X-MC-Unique: _vfvuc_rPpubSnCcnkmaeQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31443e13f9dso20997f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689797228; x=1690402028;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4g3C6nzU3Agvgh/c0t6ZuWBnKAptGwQm3c5SNMdT5Q=;
        b=aa+BX1e/sk47JkB5nIyY3zC6Cpg+Egnb8Nh429G0vi8nS/DRahzFzmOZPgxT1YxKPs
         9Qd45Da5QDqxLt1mpDgomCevH/QqBbKjNYKw4CLiE7l9NZYDH0TnxwxkJn96x2THatDz
         bn9EhArbdpOmZ0DjFGaavAOscpz6CxYH4PTFX8FqF9bUOxXB9C0MnoEgrhpSJ3kuvurV
         xx9T2NtxI8s046Jam+4ZYoPBAcUYT0zS/ZeOkgDQrbNA6aOLzt0OSz4Vgz/y0a3k26gW
         Bt1C6mxfkxE85o49lBBAGibEAgZ/9ncISPqF1J+L2gp7ockgjqe433mRLH49Jeof7Rpr
         xv0g==
X-Gm-Message-State: ABy/qLZJAZDV9clJcgvsPHTISotxw3Yv80ZkB9kPcCbkaLLrHdpiW1xW
        +y88O0ZXE4ujIdMoetwkjcr8MBEBIHs7p7euH5a6qEY0GJ/QVEDyWb3o25qP7O2s3mVShQF+3UT
        z1zvpsV5yzuzDaaU36LzSpc+f
X-Received: by 2002:a5d:4143:0:b0:314:133a:f04 with SMTP id c3-20020a5d4143000000b00314133a0f04mr694230wrq.49.1689797228309;
        Wed, 19 Jul 2023 13:07:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGpjl4pcXBRRgdFlcvKhEnkSCPwpm/o3Je+LPH5KIPIVm/X3+J0u4SMJq0uEAL2pKg5oBTQQ==
X-Received: by 2002:a5d:4143:0:b0:314:133a:f04 with SMTP id c3-20020a5d4143000000b00314133a0f04mr694210wrq.49.1689797228021;
        Wed, 19 Jul 2023 13:07:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r1-20020adfdc81000000b0031412b685d2sm6119194wrj.32.2023.07.19.13.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:07:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 10/11] drm/vc4: tests: Switch to atomic state allocation
 helper
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-10-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-10-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 22:07:06 +0200
Message-ID: <877cqvhdhx.fsf@minerva.mail-host-address-is-not-set>
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

Maxime Ripard <mripard@kernel.org> writes:

> Now that we have a helper that takes care of an atomic state allocation
> and cleanup, we can migrate to it to simplify our tests.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


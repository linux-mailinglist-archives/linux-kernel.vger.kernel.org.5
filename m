Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1843E768FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjGaIOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjGaIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266F33A91
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690791028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wsHzc5Afx1z/5KjDEZBNQHniASDdnavGgK/qk3C3lP0=;
        b=OaJMxhGl4Fc7Da6/zL4h+x20rnzf1n8IGSTnxAAtqdnp5LL0DDs5EWcIhqxqWn8ogmrq26
        YdED5ecVHSJ/0Xd+tjuXX4WxX7Rb8CvHFpMqbrr7c4zF5nCgku0yXnng0JDTpVT8GF5WF9
        YiP3BXHG0GuIovXk/i6IpMdDr6Aa408=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-6e3JuJivN2S7AgHsLpld9w-1; Mon, 31 Jul 2023 04:10:26 -0400
X-MC-Unique: 6e3JuJivN2S7AgHsLpld9w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fc08035926so26648395e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690791025; x=1691395825;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsHzc5Afx1z/5KjDEZBNQHniASDdnavGgK/qk3C3lP0=;
        b=C8EF/ypkXTjPW9wbgRIRUMb1ccpsfJC/tw3I1m4ooK6kcI2RyhJzyOninflTNuMEAn
         0Z+2gQvE9kuhmFUV6aPzNx56lRUt8+fdEEHTiSSMrE/+c7CmRE0ujFIHoGbpRO+vq6E6
         inO9MVkMiY9RHIKBCDCDIK7SznJMg+qAHszQH2q8oZY5mmuQNiDujmpLLuoSKYMCxySl
         5Z/RWlnjC8VTTt2+/r5w1xyeOhq62Zz3GP8X7b+TcolkXj0/g+0dEtLWSzP1HApvqJbI
         F+3JtD/XC812lE+30atn7DJ/9ZdwBWjhWluIRdfV6VBX9qcB/wl9gv62QcBrOYi7WD9J
         vNsg==
X-Gm-Message-State: ABy/qLaN3KJap8u0XtPEKCqxTZFgqsMEAbPpf41JZB3p1hrhgzlQGEN7
        5zoot4SklDOQM7UOLvp6/7+ePMZC4x5ceC09NL2YiI8Tcq5xD/9bIK0t+kI9TfE/fiSXl7X1XGH
        SZGPy+DJ+Cj2noKHRE5qFCcTI
X-Received: by 2002:a05:600c:21c1:b0:3fe:1b5e:82 with SMTP id x1-20020a05600c21c100b003fe1b5e0082mr2780347wmj.20.1690791025233;
        Mon, 31 Jul 2023 01:10:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6WxCPiuCjMbvYCs3Muyf80T7yG1isIk70DQ2GXEQ5HFv4E9qlsTMMGH0Y/lz+Uk1eIK+VGw==
X-Received: by 2002:a05:600c:21c1:b0:3fe:1b5e:82 with SMTP id x1-20020a05600c21c100b003fe1b5e0082mr2780332wmj.20.1690791024920;
        Mon, 31 Jul 2023 01:10:24 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c378c00b003fc0062f0f8sm10824433wmr.9.2023.07.31.01.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 01:10:24 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] drm/ssd130x: clean up some inconsistent indenting
In-Reply-To: <20230731074927.22755-1-jiapeng.chong@linux.alibaba.com>
References: <20230731074927.22755-1-jiapeng.chong@linux.alibaba.com>
Date:   Mon, 31 Jul 2023 10:10:23 +0200
Message-ID: <87pm48wlg0.fsf@minerva.mail-host-address-is-not-set>
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

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:

Hello Jiapeng,

Thanks for your patch.

> No functional modification involved.
>
> drivers/gpu/drm/solomon/ssd130x.c:715 ssd130x_primary_plane_duplicate_state() warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

Interesting that checkpatch didn't catch this, even when running with --strict.

Do you know which tool this bot is using to catch these inconsistencies?

> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6034
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


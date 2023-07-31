Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4CC768B53
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGaFk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGaFkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:40:55 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF4AE7A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 22:40:41 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3174aac120aso3772600f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 22:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690782040; x=1691386840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EqntRyYVeROLFmblRrq6B+q59krh0Br+1VNxRHB70g=;
        b=UbRitpOI/uh+PPXYC5gkIBTApFGf9zEQFoWLOPqy9nWJOkYNMClWgKA4ujevfmVcQ+
         uaUufQ0YdK1VvdNVL7Vb4Tbnis71hutzI42ggznzEaqQnkfJmNxWTJ1kckI7DbLy0LSr
         0Q4cHR6hPU4zUiYVl4UXj9CqfJr/A1z3+E/x1YAGmxRhrDmosSFzo0NA0NZuvJtuUXNT
         xCsYA/JGu7aSENEocnKZsCeJuUMRfSPjgcRZcQzBOjc6o42j6ePyXkK+km7Wlom+MfdP
         P0Holdlk6fS/SONMlsob6jbhABkxRXSsHudoJomObku2tblo9hjUQFLS2wHApdOpVf+B
         Sawg==
X-Gm-Message-State: ABy/qLYKQlPDK9npsBvb3vFmPyBQ2pqwVguOX2CLh8b7h5OIf5qEzN6G
        15K4pncXzFpOVMoNni9SFoc=
X-Google-Smtp-Source: APBJJlHnNGcdTUmhKRUVKD9rUhB+g8g5HC8ZUvGD5ZZf+xNvhBA/+o0ndAjbwxMUPSgygz9tLONK7w==
X-Received: by 2002:a5d:6805:0:b0:315:83d4:7dd6 with SMTP id w5-20020a5d6805000000b0031583d47dd6mr5948930wru.5.1690782039890;
        Sun, 30 Jul 2023 22:40:39 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id f11-20020adff58b000000b003143aa0ca8asm11846929wro.13.2023.07.30.22.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 22:40:39 -0700 (PDT)
Message-ID: <75f58741-a18d-2e92-ecb3-8f997a3ef404@kernel.org>
Date:   Mon, 31 Jul 2023 07:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tty: synclink_gt: Fix potential deadlock on &info->lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, bhelgaas@google.com,
        russell.h.weight@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230728123901.64225-1-dg573847474@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230728123901.64225-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 07. 23, 14:39, Chengfeng Ye wrote:
> As &info->lock is acquired by slgt_interrupt() under irq context, other
> process context code acquiring the lock should disable irq, otherwise
> deadlock could happen if the irq preempt the execution while the
> lock is held in process context on the same CPU.
> 
> Lock acquisition inside set_params32() does not disable irq, and this
> function is called by slgt_compat_ioctl() from process context.
> 
> Possible deadlock scenario:
> slgt_compat_ioctl()
>      -> set_params32()
>      -> spin_lock(&info->lock)
>          <irq>
>          -> slgt_interrupt()
>          -> spin_lock(&info->lock); (deadlock here)
> 
> This flaw was found by an experimental static analysis tool I am developing
> for irq-related deadlock. x86_64 allmodconfig using gcc shows no new
> warning.
> 
> The patch fixes the potential deadlock by spin_lock_irqsave() like other
> lock acquisition sites.
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Oh well, this driver deserves to die (or a massive rewrite).

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs


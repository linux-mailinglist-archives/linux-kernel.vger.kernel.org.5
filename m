Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4717C7EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjJMHub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJMHu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:50:29 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4277FB8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:50:27 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1dcf357deedso988993fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697183426; x=1697788226; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23xMJA3iDlwbznOB55jgMQYEBmFUfU91Z5L7TT7aK1g=;
        b=c+0IX97R0cWNhm0pOK+nQYdHr1UJCwoTLxxymdtZ236fQbh1sGPUQmwV3YQA9tmllF
         OIq04iot1gZqdnQqWTqS0H0u/VB7UzhSivUy9ygEPDRcjoDNRbpg3SJzTUMf8Zq19/lU
         jkTSM6on5eK56DDsj3tHbGKrlCFH7TAKW/jDC8jXj0kVA4+Wlv1uEtYaYgwLzHOkyQcN
         jvgLOaIKMOTN8rPdd1KL/XKcaNkgen34SCML6BieXM6cY+DfgC3cJryGeWCJPIlgJiD8
         70IUfkD6ul7a2yef+lt1zBWAURDqLy+SOKFPKLqbzvMtBZFcPtTtcgp8W3wa151cTM/n
         uUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183426; x=1697788226;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23xMJA3iDlwbznOB55jgMQYEBmFUfU91Z5L7TT7aK1g=;
        b=RCdZRrd9wvNjXeKEbuTdetTHmsg/J50wSTu1Sqwgt9cCWGGcotHMx836jmry7Ov3cY
         9Iv4YF5qcd8mpPA3fmOaAbFbyHyXomei8hss4bQ9f16CBX+sJ/a5pRZ+t/UwugnhYEIt
         FYZQQ8qmYiRH9zZXEY2G5rSPJKYM+YIZ/0keZTnltN23prIMa6c0XNGxL5ujiBkpdCE/
         a8Q+xkZIwtWsbZlUcW8jheBkrBLUeF/RNmq6ehycpqoJD9L2DNfuoknXTOHPAaf7fmjQ
         CSQNB459QnOxyOjiEBuyQ1u/w0Btfp9zgYvDINHIFAJp2QyaVVrzUFVMcCybiZgvbkZw
         u3rg==
X-Gm-Message-State: AOJu0Yxhi0niL8Z2XVmQTIjmcZXSARQdpNsp0tcyojSV6MSUNI+FNzQy
        FTCN3jr9Z/42PMWuOdL4gl6vUMtv9qaDKg==
X-Google-Smtp-Source: AGHT+IFx77SK6499gf9gmOkZuF2u14+xaVgoQ45920nZ5DnJubom0bQ/lTdbAKlCzZ9CHIA5VQlcqg==
X-Received: by 2002:a05:6870:b79c:b0:1e9:dd69:2fba with SMTP id ed28-20020a056870b79c00b001e9dd692fbamr1161326oab.9.1697183425874;
        Fri, 13 Oct 2023 00:50:25 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id y8-20020aa793c8000000b006b2677d3684sm740656pff.206.2023.10.13.00.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:50:25 -0700 (PDT)
Date:   Fri, 13 Oct 2023 00:50:24 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: gdm724x: Add blank line after declaration
Message-ID: <20231013075024.GD13814@Negi>
References: <20231013060202.13419-1-soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013060202.13419-1-soumya.negi97@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 11:01:57PM -0700, Soumya Negi wrote:
> Fix WARNING: Missing a blank line after declarations
> Issue found by checkpatch.pl
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 4e5cac76db58..0c61eaff6122 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -160,6 +160,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
>  
>  	while (remain) {
>  		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
> +
>  		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
>  					(void *)(buf + sent_len),
>  					sending_len,
> -- 

Please ignore this patch. It must be sent as part of a patch set as
suggested by Julia. I'll be doing that shortly.

> 2.42.0
> 

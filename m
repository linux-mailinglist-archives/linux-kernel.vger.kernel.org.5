Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A434809E76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573290AbjLHIn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjLHInZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:43:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3FF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:43:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c2a444311so16842435e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702025009; x=1702629809; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBUnhnOsxlBDNa8A++IKX6FM+LUAOdhW/Iwi43YJARg=;
        b=bo6Xooh7r19hZtqwcT5lwGQWAlwU2n6JGSYNAVjrZ7Q4F7fh8315FvkDr2UvxeJBQW
         dWREeY8jHqBxnZTQaNMoq4GmYapX0pgh93DMe/UkC103vQJBEnvxf2RIvXNPOPCyWak1
         VmlNuGLp9k8XGgXrYckkrq0UNKymm+yIvuFRIBWMxagd2alfNbNwZJ/mn3mpWlAtJha/
         L2A+SXWIvtj4+ByxSKwiA7QYd2Vnz82A+4E0FNYqkL+FduG70OjQ6wcOk49ecThFT5AU
         gqG9cRMwG40i86CWQIJnbz0YXtQXap2okKNx+nT3SP6aTg1go782w5S4p5lnZ5QarMC2
         8vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702025009; x=1702629809;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBUnhnOsxlBDNa8A++IKX6FM+LUAOdhW/Iwi43YJARg=;
        b=LlaopmXZZacH6yiZfW9blFduV7mk6axBMWS8/voLz1zOoCPJWa68UyVGH+zB/VQPxn
         SAjt8iPT4i6LdI7UkL4KecCcgu/8WFVtVkza1XT9xyAltKBlfwQqVbm2eEWiwKF9snJn
         8mF4L+HFBp/IxQcrrye/6C7UNJkhqjSse/hYRUdxkmy7bY3bLLaOVVwwrKLv3pFId1zY
         zSDeQIoxFr9e3uSg2CzrUM5QE7rkmf77jw+2Gga36SUyl3aN2wPSQm2zX+svnGwRrQHm
         vuXp/x8Ra6HT8nOKJ4Aar4jIcdJcU9zcJvF5XQH8T/gAE38MdEouhmaq63MHlQBY6UYw
         qszw==
X-Gm-Message-State: AOJu0Yx+ICMudJgsKtwlzSuVOBZSl4e3g+FuQxC6WlXFXnQADTmDB/7U
        hu6wuUkG7dDGUofAsMewKPVZCQ==
X-Google-Smtp-Source: AGHT+IH52KU1v4NdmHcMzpoX17x6A8/mjFx3r7sunQ/aFqoqs5RiE+XNCr/8jmz9Govl3MkYIRH0Bg==
X-Received: by 2002:a05:600c:190e:b0:40b:5f03:b3da with SMTP id j14-20020a05600c190e00b0040b5f03b3damr1274286wmq.252.1702025009141;
        Fri, 08 Dec 2023 00:43:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b0040b2c195523sm4415798wmo.31.2023.12.08.00.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 00:43:28 -0800 (PST)
Date:   Fri, 8 Dec 2023 11:43:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     James Tai =?utf-8?B?W+aItOW/l+WzsF0=?= <james.tai@realtek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
Message-ID: <f154673d-f577-406e-adb0-c567b604e7f4@suswa.mountain>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-3-james.tai@realtek.com>
 <d94c79bf-04c4-4e87-bd7e-a8755508ac89@suswa.mountain>
 <8f87bfca-ab5f-4b32-a400-a90d09b64cf1@suswa.mountain>
 <c558b1de9a8841e498f6dfc406a43158@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c558b1de9a8841e498f6dfc406a43158@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 08:21:10AM +0000, James Tai [戴志峰] wrote:
> Hi Dan,
> 
> >> devm_ allocations are cleaned up automatically so there is no need to
> >> call devm_kfree() before returning.
> >>
> >> regards,
> >> dan carpenter
> >
> I will remove it. 
> 
> >> > +   }
> >> > +
> >> > +   data->info = info;
> >> > +
> >> > +   raw_spin_lock_init(&data->lock);
> >> > +
> >> > +   data->domain = irq_domain_add_linear(node, 32,
> >> > + &realtek_intc_domain_ops, data);
> >
> >Btw, as I was testing the other static checker warning for <= 0, my static
> >checker really wants this irq_domain_add_linear() to be cleaned up on the error
> >path.
> >
> >Otherwise it probably leads to a use after free because we free data
> >(automatically or manually) but it's still on a list somewhere.
> >
> I will add 'irq_domain_remove()' to release it. 
> 
> >> > +   if (!data->domain) {
> >> > +           ret = -ENOMEM;
> >> > +           goto out_cleanup;
> >> > +   }
> >> > +
> >> > +   data->subset_data_num = info->cfg_num;
> >> > +   for (i = 0; i < info->cfg_num; i++) {
> >> > +           ret = realtek_intc_subset(node, data, i);
> >> > +           if (ret) {
> >> > +                   WARN(ret, "failed to init subset %d: %d", i, ret);
> >> > +                   ret = -ENOMEM;
> >> > +                   goto out_cleanup;
> >
> >This error path.
> >
> >regards,
> >dan carpenter
> >
> I will add 'irq_domain_remove()' before goto cleanup.
> 
> 	for (i = 0; i < info->cfg_num; i++) {
> 		ret = realtek_intc_subset(node, data, i);
> 		if (ret) {
> 			WARN(ret, "failed to init subset %d: %d", i, ret);
> 			irq_domain_remove(data->domain);
> 			ret = -ENOMEM;
> 			goto out_cleanup;
> 		}
> 	}
> 
> Thank you for your feedback.

You're running into the issue because you're using One Err Label style
error handling.  It would be better to use normal unwind laddering.
See my blog for more info:

https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

regards,
dan carpenter


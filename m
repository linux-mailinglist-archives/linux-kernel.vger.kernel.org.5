Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA50F7C8EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjJMVTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMVTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:19:21 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCECC95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:19:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c888b3a25aso19991815ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697231959; x=1697836759; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEpkSqStdpwPiK/rVH9XpS0uAjkRc6GI778X+nK4/Co=;
        b=PVt4Uk6bIGUargV6BJhzdZsEKWEcZfX2IZ6ubVazLiKvqdLsESKGbi2iQrFkizpHYH
         BWaZuOZfLBrS3V8bb86PLvzqSyPQWcZmueLdI0tqWnh5d1E99STgDSn/UI/shbcrS8EX
         RNi/5xSNIYrP2Q3ECt7qIJw7ytncO/FAYblzBIuQkuURPZaFWsDH0PVUQ3gdJCVqRFMx
         M9Lm2At7bz81pQ4q/KjnBVgtq70OnY0gaD8SO0anvtNFLzrs+NAfUMiL87lsGUJmGvj5
         oHECZUKXAXwAaHSFf1TeNxloOU05lLGSU2G2R48M8ZMwxWyoemZTunTH+GYrRH0Kba8p
         XUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231959; x=1697836759;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEpkSqStdpwPiK/rVH9XpS0uAjkRc6GI778X+nK4/Co=;
        b=GrPHTrEZxbatX0Abp3Y84yPJF3xziYq3gFqD4Ev6GHXMTUxHjH1gB9s1np2E6De863
         Blz7ShnGHHh4qqIGmk9wsahcRxEAQu9njgGO3cpMAoH5VUiV3jGXB5lIRwZQ7JuGSEUk
         HS1JqVucs/z9Ir807kzg+2vVmi4kcOteWga0K0CgYV8hQqsK4tAoEv9MqmJBvD4zocqK
         txJpDunjBEkaScVP/5lzKfLBehquvWZDpZ/1VTvspd8SOY7dP8b9FD6zO5xF8xTA6V3t
         QIe2nEy3UqbR7pcvafrlILxx1wPDLYhuFjwhVJEKSTUnYFZ1rH+jLaILaAXUXetGCfQT
         /z6A==
X-Gm-Message-State: AOJu0Yy5w96iG9AMrhsVnBRWBbOKWdjufG9f05VS2JBeFe6+oAHrB1N+
        u/sF/sSJIT9svQ4eLzfBRnO1Nxw3Hwu86w==
X-Google-Smtp-Source: AGHT+IGne9RAForm81Cux/ImQ6vwu8UtSeNW4OLKNkPG30bXI6R9jSzKXWlJzEYOoBTC2MoPirf6nw==
X-Received: by 2002:a17:902:a504:b0:1c6:17a4:afb3 with SMTP id s4-20020a170902a50400b001c617a4afb3mr22449486plq.16.1697231959067;
        Fri, 13 Oct 2023 14:19:19 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b001bb99e188fcsm4301830plh.194.2023.10.13.14.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 14:19:18 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:19:18 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: gdm724x: Fix coding style checkpatch warnings
Message-ID: <20231013211917.GC25352@Negi>
References: <20231013051502.9578-1-soumya.negi97@gmail.com>
 <663c85bb-90c3-4ae1-ab0b-5ab1a8abd2a7@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663c85bb-90c3-4ae1-ab0b-5ab1a8abd2a7@kadam.mountain>
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

On Fri, Oct 13, 2023 at 11:53:36AM +0300, Dan Carpenter wrote:
> On Thu, Oct 12, 2023 at 10:14:58PM -0700, Soumya Negi wrote:
> > @@ -271,8 +272,8 @@ int register_lte_tty_driver(void)
> >  	int ret;
> >  
> >  	for (i = 0; i < TTY_MAX_COUNT; i++) {
> > -		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
> > -				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> > +		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
> > +					      TTY_DRIVER_DYNAMIC_DEV);
> 
> Don't do this.  The code was better before. The parameter
> "TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV" is one thing and
> splitting it up like that makes the code less readable.  And I bet they
> had to indent it like that to get under the 80 character limit.
> 
> This is an example of checkpatch giving bad advice.

Hi Dan,

Will keep this in mind for other similar checkpatch warnings.

Thanks,
Soumya

> regards,
> dan carpenter
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFF57FE96F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344663AbjK3G6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3G6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:58:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49F12A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:58:40 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54b7ef7f4d5so486619a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701327519; x=1701932319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rkiyS/kdCFSJFM66wTSfzma10s1yKN57S6KSbUuWPY=;
        b=EyLjocVLDYePVJn921bkxr4AfheWXcAjlGHisDQMOB9G0CiqUyTJaf7M6bGgbzlfib
         aTkmUGE9IZADfbTgRQcOntbjtb0a8JzToCfdMkf7KjsbFA7CwwHEgEIhKeHP+8rn+LF4
         ZjtYeI2KtwsDuyXcavzSwTXjZTi1L3Ae0uaYN1wZnbL7CepuekQpu/yJGA1cM4hIPOLq
         F1g/pNXaKXMo/lyBfo/sLaBlbFvK8/CaNHG54xrg9usnRlKI9j+Tqq9ivKqJbRZ5mZo7
         /9Obvbtd4pYl3q9HMdChnRhrWhbQmhRSZZdbCip2kNvnHI1sZBzbgutIAfsen0m6+8M+
         fNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701327519; x=1701932319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rkiyS/kdCFSJFM66wTSfzma10s1yKN57S6KSbUuWPY=;
        b=Ae1vzRwGzYITED+zlll3t80EscTG+qXbc/qPBKSCt8xS/V2tWJrFUutwsWu0aUbLz+
         zTojdRrkoo7JtVETE4jX3BgBQc24n8ax2C11QdFcTTCz90+4LGgA96L5jEgvC9WInEkM
         2HR9A/t+X3uCr6LQ6OjGAtBlbdQJ2YFwMyrOKivGLBKEDwO8PKHHvoSd5sb6IzugaKy0
         SB6fvwBPrVCvJrk5EsPw48hoqbzpK0CukMXr3dUcyKn9RkU+b0vgpL61tNMFpVvg8kfN
         5VmcB0mqFAAHIzgiSH/2+HP364IBR7Sx6J0jTn9p9DvT9aSMFt6Lg2pY70mcME0yeZVE
         eFnA==
X-Gm-Message-State: AOJu0YzIMPZ4aRga+HHgoHzsY+Y8vKDPtGcU+rKZI9DE9XnZUohxDjXs
        CponTd7DrBMuyn9ZqfHBc74uByS8ag==
X-Google-Smtp-Source: AGHT+IFbiWzVxajhVms7bUBURjouYZZS5aGyferJaKebGmNxJ+NU9XbR/1wnVz9DGzee3VWVzrJ02A==
X-Received: by 2002:a50:bb02:0:b0:54b:28e9:b283 with SMTP id y2-20020a50bb02000000b0054b28e9b283mr12285247ede.14.1701327518897;
        Wed, 29 Nov 2023 22:58:38 -0800 (PST)
Received: from p183 ([46.53.253.86])
        by smtp.gmail.com with ESMTPSA id m5-20020aa7c485000000b0054c01fcb211sm248505edq.45.2023.11.29.22.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 22:58:38 -0800 (PST)
Date:   Thu, 30 Nov 2023 09:58:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: make struct proc_dir_entry::name const
Message-ID: <71f006db-5b08-4a81-b577-b1d6b3332e00@p183>
References: <d724d33e-7c0d-422b-8d23-3d677cc414fe@p183>
 <20231129140705.c1a7faa8f49572f5a50d2416@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129140705.c1a7faa8f49572f5a50d2416@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 02:07:05PM -0800, Andrew Morton wrote:
> On Wed, 29 Nov 2023 12:46:57 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Multiply ::name into "mut_name" and "name" which is "const char*".
> > 
> > PDE's name must not be mutated on live PDE, hint modules they should not
> > do it.
> 
> Do any modules do this?

x86_64 allmodconfig is OK, so in-kernel modules are OK.

> If so, we just broke them.

pff...

> If not, why bother with this change?

I don't know, out of love for humanity and increasing OOT modules
code quality. I don't think I've seen changing pde->name, but then
it is OOT modules we are talking about.

C doesn't have a notion for write once members, oh well.

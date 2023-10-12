Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49DE7C6B55
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347139AbjJLKkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjJLKkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:40:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55746C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:40:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4060b623e64so4761155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697107208; x=1697712008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fBGv66jYc2kP0EhTg6b4IeqJJdAfPC3InwDkFeTIyA=;
        b=AKzwN74bLWFYfSbHpcwoInEIDR7BGv9cWxDz2cIurqZYRCSUWjyjlYcBzMMr+BJAIU
         jO872G/bFm9/p7/p/13tuJZQQPaJLnnFvJDXYEB10CT5zPSVMRCpH7JNgqswslovxsh3
         lB5zQ+DdOElErZxffy/oyetPq4Z1vZeRkf8gUjc/4RM0PVgQd3vkSg+HICoPNla8LRKy
         cJbaYc26AbXcEQIrWtCIdanVNAGsk2WA4GPOZ/fchJmzCvL1WJglTbMsaG2IHYj2jeKV
         CJxh2uOyx4pexgHhX5faDltt7DpQGfucUGKWB5OiAgSraJnZXbiOtOD44NjuoV1yNXjv
         /hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697107208; x=1697712008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fBGv66jYc2kP0EhTg6b4IeqJJdAfPC3InwDkFeTIyA=;
        b=HVK5wV/IoA7JS+p3YtGiEe7gbinlf7q0C2iQe2r07kXisOf4x6JzRQaFHSFgOV/Ydd
         TaDtRrCFAxK1NSufPpGxjuITjAMlZd8JIpVq7B/2jAmYpE4mwWCo71331L25PEdFeucI
         0/fq6bAnkzLOvM3X4YE2WPTBVl1Nk1FAEpuxAA5HUKwlPu8kgjakdjXIkyLeOs/g/ODH
         zAsmTqy6rHzPCFiee3IhsDBZ2ofV7MMdz5AP1cSfViIeBEYHEckEQnV79XCvPcH6MvIM
         CmhGKGbdYE050cFkqttaZe8eevkO8GSTK4lkVeIOFhLPnN0nMcY4g10AkB+j0X1Arc/9
         F2iw==
X-Gm-Message-State: AOJu0YxGHmAQcNcaXdVpjEnt2rp861jiCIKdXi+OadA1Wyu3hBTuXVBL
        JoLmGuRHcFuoirG00vYxVDaVAQ==
X-Google-Smtp-Source: AGHT+IF8V6MtmrGJXfoKWdkMTLSXJ0Shox2IXfQr1G5ZzSCY11ydmvnI2OuBxMZRARrCQZrzayKNqw==
X-Received: by 2002:a7b:c457:0:b0:401:c8b9:4b86 with SMTP id l23-20020a7bc457000000b00401c8b94b86mr19040636wmi.9.1697107207598;
        Thu, 12 Oct 2023 03:40:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a12-20020adff7cc000000b0031423a8f4f7sm18050789wrq.56.2023.10.12.03.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:40:07 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:40:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: drop unneeded breaks
Message-ID: <ef43db1c-c50f-479e-8747-3f3a0915eb70@kadam.mountain>
References: <20230928104334.41215-1-Julia.Lawall@inria.fr>
 <20230929203259.74d4ba263b3455172ef37f06@kernel.org>
 <alpine.DEB.2.22.394.2309291336260.3137@hadrien>
 <20230930181902.eb1d089243deca0017046437@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930181902.eb1d089243deca0017046437@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 06:19:02PM +0900, Masami Hiramatsu wrote:
> On Fri, 29 Sep 2023 13:37:08 +0200 (CEST)
> Julia Lawall <julia.lawall@inria.fr> wrote:
> 
> > 
> > 
> > On Fri, 29 Sep 2023, Masami Hiramatsu  wrote:
> > 
> > > On Thu, 28 Sep 2023 12:43:34 +0200
> > > Julia Lawall <Julia.Lawall@inria.fr> wrote:
> > >
> > > > Drop break after return.
> > > >
> > >
> > > Good catch! This looks good to me.
> > >
> > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > And
> > >
> > > Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> > 
> > Thanks.  I didn't include that because it's not a bug.  But it does break
> > Coccinelle, which is how I noticed it.
> 
> OK, I got it. I thought it may cause a compiler warning because the
> 'break' never be executed. (maybe it is just a flow-control word,
> so it may not need to be warned, but a bit storange.)

I don't think GCC warns about unreachable code, but yeah, in Smatch
unreachable break statements do not trigger a warning.  People like
to add extra break statements to switch statements.

regards,
dan carpenter


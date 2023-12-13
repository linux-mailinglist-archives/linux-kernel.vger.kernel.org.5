Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081C881143A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441810AbjLMOHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjLMOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:07:31 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF808192;
        Wed, 13 Dec 2023 06:07:33 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cebbf51742so5051126b3a.1;
        Wed, 13 Dec 2023 06:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702476453; x=1703081253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25EgmiiYVaRkkOjR6UKESZ5QCudvUcIXlyIDaZ9KvKM=;
        b=UQBcsYXR08XJemYqQKvsAnlKIso+JfdHSBqmATJEhmEswn5dlW/RWaEfeoxwRpA1lZ
         rp2kq3nZd4gebIQ0UQClcaSHT26x+V6MxEUtLZMK4EVuBhiBVEC3+d9YdS1gDQlaSlny
         1Nf+cShhpuagqfjZqKZbqqeW5nxlIDtRXBN1NgOT2XvRU48wNqIR93tOg2+4xyK+5ocm
         9/3d3Gg1Wnnvwpa9w8yOcFIFar6t5FpZQkpYM+xsSaTUP1ZwcuGrWV19RkcEAukJSCpI
         eFs7QTqVkKXkNwk9qmm2Uy3nQGlbE6GSHmbsFZg43d1FuPG+pWC0Yy+WBXvWzXhq2msL
         Qtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476453; x=1703081253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25EgmiiYVaRkkOjR6UKESZ5QCudvUcIXlyIDaZ9KvKM=;
        b=FhnPrEidtwzJ8VoSSEOBvEgsW4Sr/d3So7/lbzRlAWLZA9/auULcnZanAGwZBqoLoM
         2fJMfb8cK00UVKrks7LhoXmT+CnrcrvLMN/pkJ7ILC38pIrDA5Gzdo38zhu9CueWjdBt
         ImdcswZN2DVTDBGYW2gfHR2DPCit4zdGsu/GwtF59os7h7OmuJSLATbWnL5KceDWd10r
         AcI4MgHaT8aLVwaDx2Wz/sou0X4vhAGT1S/Z1W3xj/o3Bb1YRUxJpv0wPYJWbutdns3M
         EtdGvuAjkF1egCcLTxMgpvMDDsyiKilNzmW7GmwxkbJ/DThX635eozCyLhBhOXnmLCXx
         lvnA==
X-Gm-Message-State: AOJu0YwhgImjICmxakBmA75TroOX9JFLuktVfBGZz2QqoxIWqh3ldzlr
        yE6IbTjzqBFka5+ybOBCO29ePf5TUC4=
X-Google-Smtp-Source: AGHT+IFWRDe2BufoLwSVksk4t30EebWUowdvDsWP67UA7cQL38d75wfqIxC0+dytZ8G8Z2+9x3R7xw==
X-Received: by 2002:a05:6a00:2394:b0:6ce:4047:7a6b with SMTP id f20-20020a056a00239400b006ce40477a6bmr8816758pfc.28.1702476453079;
        Wed, 13 Dec 2023 06:07:33 -0800 (PST)
Received: from rigel (194-223-186-106.tpgi.com.au. [194.223.186.106])
        by smtp.gmail.com with ESMTPSA id t2-20020a62d142000000b00690c0cf97c9sm10397110pfl.73.2023.12.13.06.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:07:32 -0800 (PST)
Date:   Wed, 13 Dec 2023 22:07:28 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH 3/4] gpiolib: cdev: reduce locking in
 gpio_desc_to_lineinfo()
Message-ID: <ZXm6oHjb7CRZ8-0f@rigel>
References: <20231212054253.50094-1-warthog618@gmail.com>
 <20231212054253.50094-4-warthog618@gmail.com>
 <ZXm4C7KVkMwL4_sX@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXm4C7KVkMwL4_sX@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:56:27PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 12, 2023 at 01:42:52PM +0800, Kent Gibson wrote:
> > Reduce the time holding the gpio_lock by snapshotting the desc flags,
> > rather than testing them individually while holding the lock.
> >
> > Accept that the calculation of the used field is inherently racy, and
> > only check the availabilty of the line from pinctrl if other checks
> > pass, so avoiding the check for lines that are otherwise in use.
>
> ...
>
> > -	bool ok_for_pinctrl;
> > -	unsigned long flags;
> > +	unsigned long iflags, dflags;
>
> With a preliminary conversion to cleanup.h this whole change becomes cleaner,
> no?
>

You mean the scoped guards?  Dunno - haven't used them.
Care to provide more detail?

Cheers,
Kent.

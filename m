Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5266E7F5BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjKWJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjKWJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:51:21 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635B3D41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:51:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so881323a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1700733085; x=1701337885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JEeBXgGm3ZwYihMXlMzQvKqTYu7/4kjUaEXoYDjYocY=;
        b=mHm6VElUPbNjFE5TXHUemSA99eSLlnQs3ZKEeHn1s73VRS9Z2JPiDxlJQXrPyrJjIe
         1gmlmDpy/d+oiI/HTJ+MeJ8X5YHDNur101ZYO97Q3IIJpFGotIBQ89VyeqrR0WbA1Cgr
         SQix2BSBANvloxR5KJ09+DEmiXyEuIJeSXHZ1/ceMiSnjm35BVzmk+9TJ4iVQcBGlk0Z
         HEi0BoJyaLyGPc4LhAYdiz5GFlK/wYf28y1f00AvLIkbkPNtp3CoPIaOB4pEFo3Zup3L
         G4M4ritRQPSNRanp4RlTG1IQFIHR9E35zT01Wy7fByw0IUU31irZN4W7vwNWj180xEJI
         cnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700733085; x=1701337885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEeBXgGm3ZwYihMXlMzQvKqTYu7/4kjUaEXoYDjYocY=;
        b=wG9SJvUh7q1fzcrJKh/VpjWZVQbzIFxHk6DcddXOD7yFD/h3X4s+qiAshU2D8PcJaY
         vSwEZT8xyjKCFQOoxfLqCUg6DjwqVAuElTmwr+GW77SnwvJDXCmOfxrE7TaWwpy0SYE7
         ZyHWFTpadCCQ8CldLQirz0l3H4WVwtBClFtcLrB3G9A1eqF32CeG0hV7HVyqC0GV+TZ6
         vF8Ls+7TKWl9Eao0e9K78UH4wtkSkCmob6uzI6BCMLVIo6toSln0vGevFanE1HnBlGad
         tUC6CPqXetf/bioAUyn/DJMNriidZJNsdsBbSnEyKF4UWlgSUj5Rd6t77FWO2rqsx14p
         +UtA==
X-Gm-Message-State: AOJu0YzoN4QauZBgWEDyfg6plw2LEkpI+hwDCq10vh8QF2F/1xzVZQNl
        W9Ixg3ntCpgjo3mCOmXc+zdxY0N75HjfeOLZ1IvesA==
X-Google-Smtp-Source: AGHT+IEOow8vSZ0E3phYafWQXYI7sepe++ApkXAUMRb/XPUzFDgEe88ByJ/yDXrDRjBKrb0OCBgE/Q==
X-Received: by 2002:a17:907:a1a5:b0:9d3:f436:6809 with SMTP id om37-20020a170907a1a500b009d3f4366809mr3188174ejc.39.1700733084655;
        Thu, 23 Nov 2023 01:51:24 -0800 (PST)
Received: from ntb.petris.klfree.czf ([193.86.118.65])
        by smtp.gmail.com with ESMTPSA id k12-20020a1709065fcc00b009b95787eb6dsm559112ejv.48.2023.11.23.01.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:51:24 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:50:49 +0100
From:   Petr Malat <oss@malat.biz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded config
Message-ID: <ZV8geQ/V+/u/k9Xs@ntb.petris.klfree.czf>
References: <20231121231342.193646-1-oss@malat.biz>
 <20231121231342.193646-3-oss@malat.biz>
 <4a67b4bb-d211-4726-8f43-d3f159127dd9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a67b4bb-d211-4726-8f43-d3f159127dd9@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Nov 22, 2023 at 02:47:30PM -0800, Randy Dunlap wrote:
> > +Early options may be specified only in the embedded bootconfig, because
> > +they are processed before the initrd.
> > +
> 
> I'm confused by which options are early options. Are they specified or
> described somewhere?
> How does a user know which options are "early" options?
This is not user friendly at all, I was thinking about emitting a warning
when early option is being configured from initrd, but that would require
one iteration over .init.setup section for every option present in initrd
just to show the warning.

Better idea would be to write a script, which extracts this info from
vmlinux.o and adds it to bootconfig userspace utility. Of course this makes
the utility tied to particular kernel version and configuration
combination, but for distributions it's reasonably safe with no overhead
during boot.

> > +	size_t embeded_size;
> > +	int ret, pos;
> 
> It hurts my eyes to see "embeded" here.
Thanks, I will fix it in the next version.
  Petr

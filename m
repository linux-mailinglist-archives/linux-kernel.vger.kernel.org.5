Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8915A80952A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444074AbjLGWQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjLGWQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:16:43 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5DD10F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:16:49 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-db537948ea0so1587725276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 14:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701987408; x=1702592208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGhdAZtfQ4zUr3uFCTfejhAlZUVIRxxcVWkGG98zi5A=;
        b=V6CxEC1+uxdd7F9wnfHeOFl39RdVeM3rS/rIqv89CpJfq7KUMLiSGAwjDkSBgybC2D
         mXt3UKnpGCUH8ON8CR7BtTCG7NMOzdCRRJ0E6XfeGptrDOe9mSWy0yvaD75PPCPKFBdN
         vD6ZMCFXReJbmta9XU9z5HOxiHXY3u2a5zbWJFi2HJ8b/vqhkUGHE1JKzS6PxxXw7vKu
         6zFzd0KaHhazlVLVR1bE+n8DLh98XnBbGfc5AW+GC+vNglcFimKP7vQ10uQj9/BO5T9c
         YmlqcP77QCXl9N+46kR42majSpt4RweWrhVG8TPebvzr7+TdQiCD2EFe2mQUNFlzpGPS
         Ajug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701987408; x=1702592208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGhdAZtfQ4zUr3uFCTfejhAlZUVIRxxcVWkGG98zi5A=;
        b=VCoQoeESyVWefk9m8LKO48gqXTBSowDptNGGp40TaVN8b7vJBaQdEkqxmnt40rrcov
         X+AZWsDYTXPQhPnuqsr6KWh9MgLxq6zYfgi0AKOTTAUZ8BQpnzNa/tBYhjOfPz9sF7jw
         c2qnP7w3F729ZFPxYaTR/yoFLmtdydR80b668eYxUOwBMIN8FE4AmsE2XV2Jmhcve24y
         f76uG7YIJGQlIz5VfLufkOMjg5pdqraUayiGG8zccm028BJ2gCfDeuEbRnK5nkgQNzHG
         kt28GJfeJw0d/I7xInrqE3Mo+E5boWz0v5j282FUMpH6sl3ucXHGAea+8NxYWuuNOCa6
         Fg3Q==
X-Gm-Message-State: AOJu0YyLO2F7Dx6S0cuTFj6m9zyROqRO3XKhyiIJW/72haRHa1VCWFgw
        YiqVnYRjS23H9DVq+5pANjY=
X-Google-Smtp-Source: AGHT+IFui4BgrC5wdZQxbVSc1C/rwZuJRX/1+i89fuoKP0JLPxBW2CRZsOgWqQms0wNPB9E4VzrLow==
X-Received: by 2002:a25:ab6d:0:b0:db7:dacf:59dc with SMTP id u100-20020a25ab6d000000b00db7dacf59dcmr2780858ybi.80.1701987408287;
        Thu, 07 Dec 2023 14:16:48 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:8f7f:efcd:5388:af4f])
        by smtp.gmail.com with ESMTPSA id f1-20020a056902038100b00db5331d70d5sm193987ybs.33.2023.12.07.14.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:16:47 -0800 (PST)
Date:   Thu, 7 Dec 2023 14:16:47 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/6] cpumask: introduce for_each_cpu_and_from()
Message-ID: <ZXJET4HjL+tpBwze@yury-ThinkPad>
References: <20231207203900.859776-1-yury.norov@gmail.com>
 <20231207203900.859776-2-yury.norov@gmail.com>
 <20231207134156.494973b8d8aa7e1aac4891d6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207134156.494973b8d8aa7e1aac4891d6@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:41:56PM -0800, Andrew Morton wrote:
> On Thu,  7 Dec 2023 12:38:55 -0800 Yury Norov <yury.norov@gmail.com> wrote:
> 
> > Similarly to for_each_cpu_and(), introduce a for_each_cpu_and_from(),
> > which is handy when it's needed to traverse 2 cpumasks or bitmaps,
> > starting from a given position.
> 
> A naming question:
> 
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -332,6 +332,17 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
> >  #define for_each_cpu_and(cpu, mask1, mask2)				\
> >  	for_each_and_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
> >  
> > +/**
> > + * for_each_cpu_and_from - iterate over every cpu in both masks starting from a given cpu
> > + * @cpu: the (optionally unsigned) integer iterator
> > + * @mask1: the first cpumask pointer
> > + * @mask2: the second cpumask pointer
> > + *
> > + * After the loop, cpu is >= nr_cpu_ids.
> > + */
> > +#define for_each_cpu_and_from(cpu, mask1, mask2)				\
> > +	for_each_and_bit_from(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
> 
> Shouldn't this be for_each_and_cpu_from()?  That seems more consistent
> and makes a little more sense given what the iterator does.

Maybe it should... But we already have some iterators with this type
of naming: for_each_cpu_and, for_each_cpu_andnot, for_each_cpu_or.

This naming style goes quite long back in the history. Corresponding
bitmap iterators have better naming although...

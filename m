Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AD98094D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjLGVlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjLGVlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:41:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A410E6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:41:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66D3C433C8;
        Thu,  7 Dec 2023 21:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701985317;
        bh=pxbkvWPyG5KlmzsHOZAtK+EcaWVG6n3b0d6X7OmmU7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZU9/Zr0tP88r/R9PJyHSUKU+soRsm93JiBQYxf2LeuEFQnJiUJoB2dRPf6aWueGU/
         hKHyqALgIjmJJUXZTLmx6ZoHGqX4GsiQWSGWQKv5Xrtu0YpqP4wfqDIQvwEmOdAmIA
         J0oobNdRY3HS9JadQdXkjUZDJtmQLPFX7J5LihK4=
Date:   Thu, 7 Dec 2023 13:41:56 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/6] cpumask: introduce for_each_cpu_and_from()
Message-Id: <20231207134156.494973b8d8aa7e1aac4891d6@linux-foundation.org>
In-Reply-To: <20231207203900.859776-2-yury.norov@gmail.com>
References: <20231207203900.859776-1-yury.norov@gmail.com>
        <20231207203900.859776-2-yury.norov@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Dec 2023 12:38:55 -0800 Yury Norov <yury.norov@gmail.com> wrote:

> Similarly to for_each_cpu_and(), introduce a for_each_cpu_and_from(),
> which is handy when it's needed to traverse 2 cpumasks or bitmaps,
> starting from a given position.

A naming question:

> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -332,6 +332,17 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
>  #define for_each_cpu_and(cpu, mask1, mask2)				\
>  	for_each_and_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
>  
> +/**
> + * for_each_cpu_and_from - iterate over every cpu in both masks starting from a given cpu
> + * @cpu: the (optionally unsigned) integer iterator
> + * @mask1: the first cpumask pointer
> + * @mask2: the second cpumask pointer
> + *
> + * After the loop, cpu is >= nr_cpu_ids.
> + */
> +#define for_each_cpu_and_from(cpu, mask1, mask2)				\
> +	for_each_and_bit_from(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)

Shouldn't this be for_each_and_cpu_from()?  That seems more consistent
and makes a little more sense given what the iterator does.


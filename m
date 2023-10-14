Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1277C96FD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjJNWMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjJNWMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:12:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F08C9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:12:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14F9C433C8;
        Sat, 14 Oct 2023 22:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697321547;
        bh=W9HiB33vcbVaedyeYlI+FUVAaV9QCtpHY2zsfWUBXtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eLFhIYoTbp2lD+r2LSkm2pa+69fc8TLcXsIFoJV3LKcN5yNgn6KUrX5uFNb3ChYa2
         lSK0C+wDXnwIImCe5oL5z6GYGk3iyM/qHFcB9GSkoYm092jYVwnTkUDhF9bh4OERI4
         6H4ue2GhPyzdBLxEeGdcgFy5zXDHR79M8r4Q4i1Y=
Date:   Sat, 14 Oct 2023 15:12:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] smp: fix __smp_processor_id() backup macro
Message-Id: <20231014151221.46096b7fc17ccaeb691ff5d0@linux-foundation.org>
In-Reply-To: <b12bdef9-d5c0-49cf-aea2-ff7b56220fdc@p183>
References: <b12bdef9-d5c0-49cf-aea2-ff7b56220fdc@p183>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2023 19:14:15 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Every __smp_processor_id usage doesn't have arguments and
> every raw_smp_processor_id usage doesn't have arguments,
> therefore "#define __smp_processor_id(x)" can not possibly work.
> 
> ...
>
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -261,7 +261,7 @@ static inline int get_boot_cpu_id(void)
>   * regular asm read for the stable.
>   */
>  #ifndef __smp_processor_id
> -#define __smp_processor_id(x) raw_smp_processor_id(x)
> +#define __smp_processor_id() raw_smp_processor_id()
>  #endif
>  

It's been that way for at least 4 years.  Presumably this is never used
and should be removed?

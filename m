Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6FF7B15BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjI1ILj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1ILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:11:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E897
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HJBAf/2tlktIge5AEzXgw/+mSyskSdPUC0WawI/LAgM=; b=XRAo0QO7/gPqB03yWNULVfXLUz
        fseU0stD+wjBZvsBFJvQ5JbfRKp6yoPoD10IhKmNewljAK5Jz17xrZQrPOzi5AGT21Q1vrd/h8S3I
        UyGUIS+4odO6+uDNHDDZ0JOYXzy3NqzupHTSZtRYOog51uvVPAMDHSJPnL37o2nwDgLAlxKXNx/CV
        8muMlXs8k8rhilxSe3RKu4yQZPgzKfSGQ94yAw3YLbdXlgVguU9Qh0S8lzQ7Fyy0zJfDo3AvLPN26
        Yr9OfRaX8Ru7xTUhB3o3ojF6KqA0Bi+VQgchRTC6Nu2ZFhd8zxojyMMVLp1yOe3PcxBg/99idpsC8
        vLRuP5lw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlm6n-001MRH-2v; Thu, 28 Sep 2023 08:10:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF4263002E3; Thu, 28 Sep 2023 10:10:52 +0200 (CEST)
Date:   Thu, 28 Sep 2023 10:10:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Raymond <raymod2@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH v2] arch/x86: port I/O tracing on x86
Message-ID: <20230928081052.GG9829@noisy.programming.kicks-ass.net>
References: <e08a3073-574c-c9fa-fc63-df33920165b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08a3073-574c-c9fa-fc63-df33920165b9@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:52:11AM -0600, Dan Raymond wrote:

>  #define BUILDIO(bwl, bw, type)						\
>  static inline void __out##bwl(type value, u16 port)			\
>  {									\
>  	asm volatile("out" #bwl " %" #bw "0, %w1"			\
>  		     : : "a"(value), "Nd"(port));			\
> +	if (_tracepoint_enabled(portio_write))				\
> +		do_trace_portio_write(value, port, #bwl[0]);		\
>  }									\
>  									\
>  static inline type __in##bwl(u16 port)					\
> @@ -16,6 +39,8 @@ static inline type __in##bwl(u16 port)					\
>  	type value;							\
>  	asm volatile("in" #bwl " %w1, %" #bw "0"			\
>  		     : "=a"(value) : "Nd"(port));			\
> +	if (_tracepoint_enabled(portio_read))				\
> +		do_trace_portio_read(value, port, #bwl[0]);		\
>  	return value;							\
>  }

NACK

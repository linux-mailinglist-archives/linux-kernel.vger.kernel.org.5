Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211D3785EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbjHWRq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjHWRqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:46:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1D1E77
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:46:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692812781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aU2D7jbideOp97vjvEV2z6mKGgd/9fgVz30O+oxfYkg=;
        b=GJy6azlxZy+GjdxGEDuyXIRcjbKtxboZQjTs4evf24D3yzlZt97Jl7RPNHMLG7fxeyKsiG
        UP9RvbuwngtAn2EPDmyYmzdRi13GEKi3K3gbFbxoqgyXYARqaNpw1wek1sl83xLqIY/i7r
        ske+rkgO3Gzhst1Kye4GBcVh2iH4hpM+tysx1tXKo/DMZ8XHN8k8Ua4kzj3NjMDyHkU8NW
        dSWwU00JOzWn16KLiO5H7ijnT85zr2tt8vhj84QY91wh2aFRbpt4wsbU9CoW3ttAdjEjrY
        UBu3gRMc74XhqsYtomXkPdfakipEgV3s9Z7vQV7WpQAuy9tzcoZdofYl59DXGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692812781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aU2D7jbideOp97vjvEV2z6mKGgd/9fgVz30O+oxfYkg=;
        b=d/zXDkcwbju5llS11wekBTznQPs7OdzaRqrG7yQtVtruhGLeUfgOjc7rSG2r09K+MaLzjW
        h4nGyVUGWnLykiDQ==
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     arjan@linux.intel.com, ashok.raj@intel.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, nik.borisov@suse.com, x86@kernel.org,
        qiuxu.zhuo@intel.com
Subject: Re: [patch V2 03/37] x86/microcode/intel: Move microcode functions
 out of cpu/intel.c
In-Reply-To: <20230823125144.27587-1-qiuxu.zhuo@intel.com>
References: <20230812195727.719202319@linutronix.de>
 <20230823125144.27587-1-qiuxu.zhuo@intel.com>
Date:   Wed, 23 Aug 2023 19:46:20 +0200
Message-ID: <878ra1ejo3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23 2023 at 20:51, Qiuxu Zhuo wrote:
>> -#define get_totalsize(mc) \
>> -	(((struct microcode_intel *)mc)->hdr.datasize ? \
>> -	 ((struct microcode_intel *)mc)->hdr.totalsize : \
>> -	 DEFAULT_UCODE_TOTALSIZE)
>> +#define DEFAULT_UCODE_DATASIZE		(2000)
>>  
>> ...
>> +
>> +static inline unsigned int get_totalsize(struct microcode_header_intel *hdr)
>> +{
>> +	return hdr->datasize ? : DEFAULT_UCODE_TOTALSIZE;
>
> I tested this patch series and observed that the inline code above failed
> the late microcode loading with the error message:
>
>     [  117.100299] microcode: Error: bad microcode data file size.
>
> According to the original get_totalsize() macro, seems like it should be:
>
>     return hdr->datasize ? hdr->totalsize : DEFAULT_UCODE_TOTALSIZE;
>
> With this minor change, the late microcode loading was successful, and the
> expected message was displayed:

Yes. I messed that up. Borislav already fixed it up when applying the
first 9 patches.


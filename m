Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB0A78713B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbjHXONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbjHXONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:13:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D83810C3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:13:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4051A1007;
        Thu, 24 Aug 2023 07:14:11 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00CEC3F762;
        Thu, 24 Aug 2023 07:13:29 -0700 (PDT)
Message-ID: <ecf738a3-e8e5-85ac-c435-d4aa0e320b17@arm.com>
Date:   Thu, 24 Aug 2023 15:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2] dma-debug: don't call __dma_entry_alloc_check_leak()
 under free_entries_lock
Content-Language: en-GB
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Clark <robdclark@chromium.org>, Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20230816023235.3798264-1-senozhatsky@chromium.org>
 <20230824031542.GB610023@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230824031542.GB610023@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 4:15 am, Sergey Senozhatsky wrote:
> On (23/08/16 11:32), Sergey Senozhatsky wrote:
>> __dma_entry_alloc_check_leak() calls into printk -> serial console
>> output (qcom geni) and grabs port->lock under free_entries_lock
>> spin lock, which is a reverse locking dependency chain as qcom_geni
>> IRQ handler can call into dma-debug code and grab free_entries_lock
>> under port->lock.
>>
>> Move __dma_entry_alloc_check_leak() call out of free_entries_lock
>> scope so that we don't acquire serial console's port->lock under it.
> 
> Hello folks,
> 
> Have you got a chance to take a look at the patch?

[ For some reason Microsoft seem convinced all your emails are spam, so 
I have to keep digging them out of quarantine :( ]

The patch itself looks reasonable enough to me, thanks for respinning.

Acked-by: Robin Murphy <robin.murphy@arm.com>

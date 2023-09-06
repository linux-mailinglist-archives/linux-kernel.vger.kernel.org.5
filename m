Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539297935D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbjIFHCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242222AbjIFHC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:02:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C4CFA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:02:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AEBC433C8;
        Wed,  6 Sep 2023 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693983146;
        bh=0NziAyuGDsV9zXfsHJVohBzLH3NbghzsK2C3zeEmOlU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gIHMpLZ2j2JcyfddgSOW5mPefsoYHmmBV43KCrjcOWquBPojSBHPQee3eeGAPahP9
         gqKT9O7KVc+VEScR9cfZ+wWoDiXyD9jn/ROjG42hfdIsU1JqWHBUyaqsZ6Xgt1ZJ8H
         ph/HRjSm34hOC8X5JdCWj/fEUkD6XKayu+278+/d3af931gfuR0BWBw+yYc+FqJBWc
         6Gx37ZeZmwHRZLGmyIbekyy37tnTddyoonhAzAiwaTdFWh0jqFh63nATiSeqjg0GjM
         brSt+mWDh5KDR1Pcvvt63i8SFbEtwX7QnuEwWku8dtVz8YcIjSRpQti9cAH6k6a+Y9
         gfWf7jvR0pYFQ==
MIME-Version: 1.0
Date:   Wed, 06 Sep 2023 08:52:22 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 10/41] mtd: spi-nor: make sector_size optional
In-Reply-To: <21cd9421-52e6-432a-b612-a8bb9c48f98b@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-10-291a0f39f8d8@kernel.org>
 <21cd9421-52e6-432a-b612-a8bb9c48f98b@linaro.org>
Message-ID: <8ce4677710a5a19677ab86aaa41a70ab@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  #define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
>>  	.size = (_sector_size) * (_n_sectors),				\
>> -	.sector_size = (_sector_size),					\
>> +	.sector_size = (_sector_size == SZ_64K) ? 0 : (_sector_size),	\
> 
> why do you clear the sector_size?

Because that is also a preparation for the large conversion, where the
default value of 64k is dropped. And to be able to verify (because you
can't really review these conversion patches) the ro segments are the
same, this patch already set it to zero if the INFO entry has the
default size.

I'll amend the commit message.

-michael

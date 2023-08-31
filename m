Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0881678F00A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjHaPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjHaPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:16:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE0E53;
        Thu, 31 Aug 2023 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dZ+CYy+NiImbraQzZFb/jEDAIlzMlTzLoJNY/bcsZII=; b=MAtcvuir2tPTWB75BVsumuwLNf
        3SooZiTyRkl4NwwpAYGOymwio5PIxPeO7goMfZuC6v6azsGwn6ZG6xFHPdq1rjRfhDhmDfcYaHQRW
        9zJs0RzRqdtAUyxGgrxmSHXaBy4/NKQWQUCDlJrcrBRMd3MLEtFzpb5MbH5zYrKmSQOwmHnSKTLm9
        VGga4lf1vf4k8gDv7/BffS+yWM9S7qd+lUcP0n0V9+Oiik8gm6t1+0bvEhmNQldVY04Mx4j5HwxyJ
        XkVeUjYjkHOqa4DpkWTitDU5CzYOhznQLNyuCQXxOw8TOm+d3Ep4S8sFi4ECuBwjIBvqXp6APdICj
        ikW0w1ag==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbjOg-00FUAa-1n;
        Thu, 31 Aug 2023 15:15:50 +0000
Message-ID: <478ac7ec-a89c-32ae-6b0b-e6f5c3f8e151@infradead.org>
Date:   Thu, 31 Aug 2023 08:15:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] macintosh: Explicitly include correct DT includes
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
Cc:     Colin Leroy <colin@colino.net>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230714174654.4058898-1-robh@kernel.org>
 <6df12112-0849-4d7b-8f99-d2a7a3560a97@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6df12112-0849-4d7b-8f99-d2a7a3560a97@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/23 07:04, Guenter Roeck wrote:
> On Fri, Jul 14, 2023 at 11:46:54AM -0600, Rob Herring wrote:
>> The DT of_device.h and of_platform.h date back to the separate
>> of_platform_bus_type before it as merged into the regular platform bus.
>> As part of that merge prepping Arm DT support 13 years ago, they
>> "temporarily" include each other. They also include platform_device.h
>> and of.h. As a result, there's a pretty much random mix of those include
>> files used throughout the tree. In order to detangle these headers and
>> replace the implicit includes with struct declarations, users need to
>> explicitly include the correct includes.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> This patch results in the following build error.
> 
> Building powerpc:ppc32_allmodconfig ... failed
> --------------
> Error log:
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_enable':
> drivers/macintosh/ams/ams-input.c:68:45: error: invalid use of undefined type 'struct platform_device'
>    68 |         input->dev.parent = &ams_info.of_dev->dev;
>       |                                             ^~
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_init':
> drivers/macintosh/ams/ams-input.c:146:51: error: invalid use of undefined type 'struct platform_device'
>   146 |         return device_create_file(&ams_info.of_dev->dev, &dev_attr_joystick);
>       |                                                   ^~
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_exit':
> drivers/macintosh/ams/ams-input.c:151:44: error: invalid use of undefined type 'struct platform_device'
>   151 |         device_remove_file(&ams_info.of_dev->dev, &dev_attr_joystick);
>       |                                            ^~
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_init':
> drivers/macintosh/ams/ams-input.c:147:1: error: control reaches end of non-void function 
> 
> Bisect log attached.

Hi Guenter,
I posted a patch for this 2 days ago and Michael Ellerman just did a pull request
to Linus with the fix.

-- 
~Randy

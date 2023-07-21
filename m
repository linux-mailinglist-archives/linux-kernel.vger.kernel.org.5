Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ECD75C7C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGUNZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGUNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:25:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B34930F1;
        Fri, 21 Jul 2023 06:25:17 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F2C2B373D;
        Fri, 21 Jul 2023 15:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689945782;
        bh=VbVEf/xlEK/hCNC8ckZfFvkPXoJPi+08Ql7C4Xf6HXA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lpNCbI0rHaRM9tnYkFhcUZ+VEmU7iyd0uREap0iTT27iTeytpUNQdQKPJ9Sk1wsbm
         nmmBucngpwAFEvOHthu6QiQQMaIACPwbA+zOJQ/aIuFz6++4YjOc3Pxlpg0l1f9Lz0
         Pi8zPWgHFjw5s1sYniENMWQVMq1Q1yYuzWtw251E=
Message-ID: <2e2417fb-97a1-7153-6ba9-88a6d50f962a@ideasonboard.com>
Date:   Fri, 21 Jul 2023 16:23:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/8] media: i2c: ds90ub953: Restructure clkout
 management
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
 <20230720-fpdlink-additions-v2-6-b91b1eca2ad3@ideasonboard.com>
 <ZLpeHG9/99YjdKtW@smile.fi.intel.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <ZLpeHG9/99YjdKtW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 13:29, Andy Shevchenko wrote:
> On Thu, Jul 20, 2023 at 01:30:37PM +0300, Tomi Valkeinen wrote:
>> Separate clkout calculations and register writes into two functions:
>> ub953_calc_clkout_params and ub953_write_clkout_regs, and add a struct
>> ub953_clkout_data that is used to store the clkout parameters.
>>
>> This simplifies the clkout management.
> 
> ...
> 
>> +struct ub953_clkout_data {
>> +	u32 hs_div;
>> +	u32 m;
>> +	u32 n;
> 
> I don't think it makes driver worse. The V4L2 UAPI has similar struct which is
> used widely, hence I see no issues in using u32_fract here.

I think it makes sense to use u32_fract in common code. My argument for 
not using it here is:

- There is no actual functionality that u32_fract brings, so it's really 
only about field naming
- m and n matches the terms in the HW documentation, making it easier to 
compare the code and the docs
- This is private to the driver
- I'm (currently) the most likely person to edit the driver, and I would 
have to check which one that numerator/denominator was again when 
looking at this part of the code (but maybe I would learn eventually)

So, in my view, the change doesn't really have any pros but does have cons.

That said, it's not a biggie. If others chime in and say it's a good 
idea to use u32_fract, I'm fine doing that change.

  Tomi


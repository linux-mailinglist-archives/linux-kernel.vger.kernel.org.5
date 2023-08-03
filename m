Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A476E78E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjHCL7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjHCL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:59:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A09426BA;
        Thu,  3 Aug 2023 04:59:34 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A8065A4;
        Thu,  3 Aug 2023 13:58:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691063908;
        bh=RT7rKebX3umkthzwSncQznVIc6lMU58Y2I9IpWZTk/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tq+ScKaZYYq+H6B6wdd5zeVOtNtUgExQY5hP+bgvKqV06m0VK1FC7Yg33ZCAaCbrs
         fHIuXquq/ne8ECWvSmU+QkKZPukMbRqp5QMa0kCn+veLRCEZoI/zeV1QarKlCyqPHF
         tpU26fubATYc8Vy8rbG76j5+itcnONCGI2AuQBrk=
Message-ID: <fe67a748-e358-71ca-d828-1ff24eb54efa@ideasonboard.com>
Date:   Thu, 3 Aug 2023 14:59:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] media: i2c: ds90ub9x3: Fix use of uninitialized
 variables
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com>
 <20230803-ub9xx-uninit-vars-v1-1-284a5455260f@ideasonboard.com>
 <ZMuWF71x0thq/aTs@smile.fi.intel.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <ZMuWF71x0thq/aTs@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 14:57, Andy Shevchenko wrote:
> On Thu, Aug 03, 2023 at 11:41:38AM +0300, Tomi Valkeinen wrote:
>> smatch reports some uninitialized variables:
>>
>> drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v1'.
>> drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v2'.
>> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_local_data'.
>> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_input_ctrl'.
>> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_pin_sts'.
>>
>> These are used only for printing debug information, and the use of an
>> uninitialized variable only happens if an i2c transaction has failed,
>> which will print an error. Thus, fix the errors just by initializing the
>> variables to 0.
>>
>> Fixes: 6363db1c9d45 ("media: i2c: add DS90UB953 driver")
>> Fixes: c158d0d4ff15 ("media: i2c: add DS90UB913 driver")
> 
> I would prefer two separate changes on per driver basis. This is a good
> practice to make backporting easier (generally speaking).

Yes, I almost did that, but then somehow got hit by acute laziness... 
I'll send a v2 with split patches.

  Tomi


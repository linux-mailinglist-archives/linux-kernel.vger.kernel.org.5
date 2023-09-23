Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD7A7ABF63
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjIWJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjIWJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:39:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF60196;
        Sat, 23 Sep 2023 02:39:40 -0700 (PDT)
Received: from [IPV6:2001:818:e7d2:8300:2412:6733:7e63:fb46] (unknown [IPv6:2001:818:e7d2:8300:2412:6733:7e63:fb46])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5EDF1DE2;
        Sat, 23 Sep 2023 11:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695461879;
        bh=5rwlDgb18LMeY6PGIIJDEvGpiQq5OlIONr+fS/lgUek=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CAVJ32rItefld/CVJeWF3kknOncqbkl/dVP+UY1mUPtkblGiMPQ7X7k7EmDFeEjeb
         wpm7IlcB+e0NQRHZsjp9zdLHdGULQ1VYJKNmp5XLlJdnayesIRnhbind0sH+Bm7uNv
         V1XkfDVEafukNtLhIgk1GP5YkReXKQenpDdTdYgM=
Message-ID: <3f040e44-3bdc-b09c-58b3-ea3b0ac6d5dd@ideasonboard.com>
Date:   Sat, 23 Sep 2023 15:09:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 0/4] staging: vc04: Drop custom logging
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>
References: <20230913185528.770634-1-umang.jain@ideasonboard.com>
 <1d54715d-25f9-4937-bdff-de0136c95fe8@kadam.mountain>
 <d8395455-44eb-6762-d978-e912bf2cfe73@i2se.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <d8395455-44eb-6762-d978-e912bf2cfe73@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 9/17/23 9:06 PM, Stefan Wahren wrote:
> Hi,
>
> Am 14.09.23 um 08:35 schrieb Dan Carpenter:
>> On Thu, Sep 14, 2023 at 12:25:24AM +0530, Umang Jain wrote:
>>> Hello,
>>>
>>> This series attempts to restart the discussion on custom logging used
>>> in VC04. In the last feedback gathered in [1] it seems that the logging
>>> would rather be moved to use dynamic debug. The series tries to move
>>> in that direction.
>>>
>>> The elephant in the room is the ability of turning on/off log levels,
>>> which this series just drops. Compensated by a crude strings
>>> ("error", "warning", "info"... etc) for easier grepping.
>>>
>>> The log category are also just strings (which probably can be 
>>> transformed
>>> to dynamic debug class names moving forwards?).
>>>
>>> To move forwards, I would like feedback on the broader direction.
>>> There are couple of TODOs in each of the patch (summarised in commit
>>> messages) which require case-by-case discussion.
>>>
>>> Additional high-level questions to move forwards:
>>> 1. Is loss of log levels by moving to dynamic debug, is actually a
>>>     concern? Is dynamic debug a valid replacement?
>>
>> Dynamic debug is honestly going to be an improvement.  I guess, Greg and
>> I said this back in Jan.

+1
>>
>>> 2. Whether debugfs should be dropped as well, found vestigial in [2]
>>
>> Yes. The "vchiq/log" should be removed.  Ideally as part of this
>> patchset so it's easier to understand.
>
> Yes, but please do not remote vchiq_debugfs entirely. I'm working on a 
> patch to move the state dump (debug feature) from the character device 
> /dev/vchiq to debugfs /sys/kernel/debug/vchiq/dump_state.

Can't the state dump be printed to dev_dbg() ? Will it pollute the 
kernel log?  Having debugfs for a single dump doesn't seem worthwhile if 
the state dump can be incorporated to dev_dbg() too.
>
>>
>>> 3. whether vchiq_log_trace() should actually be tracing support for 
>>> VC04
>>
>> That can be done later if people want.  No need to discuss it now.

Thanks Dan.
>>
>> regards,
>> dan carpenter
>>


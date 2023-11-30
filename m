Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ADD7FF02A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbjK3Na5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbjK3Nax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:30:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C8610F0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:31:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D8AC433C7;
        Thu, 30 Nov 2023 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701351059;
        bh=GGplx6KpuPLw09bMktqftv7giakn9VmpBAD9cWeP0fc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jtW0lJYRSL7dznQ7fezXH+buD8jYnkyUoT+HbKbWKbxCAi3sst+qXhzIVNiL6c7Uz
         lvZJyolOYkJz35OkUIAzCVzb+nCibFIrfj2qpe8l1oKuF6ruc+GGttu89pSFf/I0xo
         873vChbi5Uqk3YqnGmk3U6S4/0OCgexyUbV7JstzO8o5MxJbeTBFksjnP7hCQL+LMY
         a18ka/HuHx1xp6MAKwZPzTOJFOQwRE9eFA9pfX0yRIAt9fdOlrI4DwQFuSyq19Hsc5
         oLulGoS2LS3QzpMc+0/3ao8X1THpu5N3FpwUZgcthjb+NgNU6yH82WaGEHj5b9+fmq
         XuWTLEuS2gSVA==
Message-ID: <292f5d48-8567-4b60-ad03-6cf70f71bacc@kernel.org>
Date:   Thu, 30 Nov 2023 15:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: typec: tps6598x: use device 'type' field to identify
 devices
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Alexandru Ardelean <alex@shruggie.ro>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        a-govindraju@ti.com, trix@redhat.com, abdelalkuor@geotab.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20231123210021.463122-1-alex@shruggie.ro>
 <ZWdKI9UOZ6INP0Tu@kuha.fi.intel.com>
 <47ffbb30-34a7-4f5b-b262-3e068e574c8a@kernel.org>
 <ZWhp9M8165DiTNTd@kuha.fi.intel.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ZWhp9M8165DiTNTd@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On 30/11/2023 12:54, Heikki Krogerus wrote:
> Hi Roger,
> 
>>> Why not just match against the structures themselves?
>>>
>>>         if (tps->data == &tps25750_data)
>>>                 ...
>>
>> Then you need to declare tps25750_data and friends at the top of the file?
>>
>> A better approach might be to have type agnostic quirk flags for the special
>> behavior required for different types. This way, multiple devices can share
>> the same quirk if needed.
>>
>> e.g.
>> NEEDS_POWER_UP instead of TIPD_TYPE_APPLE_CD321X
>> SKIP_VID_READ instead of TIPD_TYPE_TI_TPS25750X
>> INIT_ON_RESUME instead of TIPD_TYPE_TI_TPS25750X
>>
>> Also rename cd321x_switch_power_state() to tps6598x_switch_power_state().
> 
> No. Functions like that isolate cd321x specific functionality into an
> actual "function" just like they should.
> 
> Quirk flags mean that if something breaks, it will almost always break
> for everybody (there is no real isolation with quirk flags), and when
> things are fixed and when features are added, we are forced to always
> "dance" around those quirk flags - you always have to consider them.
> 
> Platform/device type checks are just as bad IMO, but in one way they
> are better than quirk flags. There is no question about what a
> platform check is checking, but quirk flags can so easily become
> incomprehensible (just what exactly does it mean when you say
> NEEDS_POWER_UP, SKIP_VID_READ and so on (you would need to document
> those quirks, which is waste of effort, and in reality nobody will do).
> 
> In case of tipd/code.c, it should be converted into a library that
> only has the common/shared functionality. CD321, TPS2579x, TPS6598x
> and what ever there is, then will have a glue driver that handles
> everything that specific for their controller type.

Do you mean that you want to treat the 3 devices as different incompatible devices
so each one has a separate driver which warrants for a different DT binding
for each and also Kconfig symbol?

> 
> Before this driver is reorganised like that (any volunteers?), we'll
> have the PD controller type checks, but quirk flags we will not have.
> 
> In general, you should only use quirk flags if there is no other
> way to move forward - they are the last resort. They are dangerous,
> and even in the best case they reduce the maintenability of the code.
> 
> thanks,
> 

-- 
cheers,
-roger

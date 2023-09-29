Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6F7B2E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjI2ImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjI2ImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:42:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B4F41AB;
        Fri, 29 Sep 2023 01:42:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63FC41FB;
        Fri, 29 Sep 2023 01:42:46 -0700 (PDT)
Received: from [10.57.93.169] (unknown [10.57.93.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1C313F5A1;
        Fri, 29 Sep 2023 01:42:05 -0700 (PDT)
Message-ID: <6942961b-a5f6-983a-e5c5-10fa097a907d@arm.com>
Date:   Fri, 29 Sep 2023 09:42:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 06/18] PM: EM: Check if the get_cost() callback is
 present in em_compute_costs()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-7-lukasz.luba@arm.com>
 <CAJZ5v0g9hX6S1jnSD3=uatnPmF3vDPEF3ARru5ORst-CNc=5dQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g9hX6S1jnSD3=uatnPmF3vDPEF3ARru5ORst-CNc=5dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 19:46, Rafael J. Wysocki wrote:
> On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The em_compute_cost() is going to be re-used in runtime modified EM
>> code path. Thus, make sure that this common code is safe and won't
>> try to use the NULL pointer. The former em_compute_cost() didn't have to
>> care about runtime modification code path. The upcoming changes introduce
>> such option, but with different callback. Those two paths which use
>> get_cost() (during first EM registration) or update_power() (during
>> runtime modification) need to be safely handled in em_compute_costs().
> 
> I would just say something like this:
> 
> "Subsequent changes will introduce a case in which cb->get_cost may
> not be set in em_compute_costs(), so add a check to ensure that it is
> not NULL before attempting to dereference it."
> 
> The rest of the changelog is just redundant IMO.
> 

Make sense, thanks, I'll change that.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9A7D48F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjJXHtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjJXHtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:49:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D7A4E8;
        Tue, 24 Oct 2023 00:49:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B3402F4;
        Tue, 24 Oct 2023 00:50:09 -0700 (PDT)
Received: from [10.57.83.179] (unknown [10.57.83.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60BCF3F738;
        Tue, 24 Oct 2023 00:49:26 -0700 (PDT)
Message-ID: <749c927a-119a-41ea-adfd-9e778d640d16@arm.com>
Date:   Tue, 24 Oct 2023 08:50:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/18] PM: EM: Find first CPU online while updating OPP
 efficiency
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-4-lukasz.luba@arm.com>
 <59ea8714-2ed8-f64b-e8d4-93cd6bf4ff92@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <59ea8714-2ed8-f64b-e8d4-93cd6bf4ff92@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thanks for looking at the patches!

On 10/23/23 18:06, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 25/09/2023 10:11, Lukasz Luba wrote:
>> The Energy Model might be updated at runtime and the energy efficiency
>> for each OPP may change. Thus, there is a need to update also the
>> cpufreq framework and make it aligned to the new values. In order to
>> do that, use a first online CPU from the Performance Domain.
> 
> I'm failing to do the connection with the description and the change.
> 
> Perhaps, the changelog shall explain why 'cpu' must be replaced with the 
> first active cpu ?

It's not a big problem now for EM, since during the boot the first CPU
in the 'policy' is actually registering the EM. Although, this is an
assumption and for the new runtime update of EM, we cannot assume
that first is online. That's the motivation of the change. In a corner
case all CPUs might be put offline, but the EM is still there because
we never unregister EM for CPUs (to not race with task scheduler).

I will add that description to the patch header.

Thanks,
Lukasz

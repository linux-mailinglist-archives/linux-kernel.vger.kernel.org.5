Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647F5813239
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573295AbjLNNxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573224AbjLNNxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:53:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F0911B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:53:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462A0C433C8;
        Thu, 14 Dec 2023 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702561989;
        bh=ndDApgMv3pICtu5pbie5/BjN4F0Jmr+sMJasLI/mjZc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WSKwAdCm8j2HYsavwwRM8lrXYWX8I8GD0anvlbmKmBR9PkfZyopysMhxDGLGFIDR4
         zMBUvrRLiKc8sZcrJ1eTKtgtgzdMkzYh4PLQUEV9IPZYJrUkkoZI0Gu87hAvZ0ZwmU
         N04VdcOb4DmOLgtYXUELrgjp1CjjVKX/goZ6dVV5SdafKLHMKvYcFWVljA4lOZjEDT
         /jhG9nisPI7oUmkA1ftdfNenSQjhN218hlmGeIAoIk66J3Aa5Sm5DxJ4LXUW9MCn2v
         gZ6lcSZBkizaWsi8w8Icu7csNzRT+Wm/3StH2q5UIjZPeqWtOr20wXrOYn9hz1gbLu
         Invtiqeoj1F+w==
Message-ID: <6a8bde60-1a76-4951-b20e-dd38d93b1918@kernel.org>
Date:   Thu, 14 Dec 2023 15:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 05/11] net: ethernet: am65-cpsw: cleanup
 TAPRIO handling
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-6-rogerq@kernel.org>
 <20231214112352.iaomw3apleewkdfz@skbuf>
 <0b437b72-d9ee-478c-a838-ff8c27ec05d5@kernel.org>
 <20231214134131.ecww24rt7socuplt@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231214134131.ecww24rt7socuplt@skbuf>
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



On 14/12/2023 15:41, Vladimir Oltean wrote:
> On Thu, Dec 14, 2023 at 03:36:57PM +0200, Roger Quadros wrote:
>> Actually, this code is already present upstream. I'm only moving it around
>> in this patch.
>>
>> Based on the error message and looking at am65_cpsw_est_check_scheds() and
>> am65_cpsw_est_set_sched_list() which is called later in am65_cpsw_taprio_replace(),
>> both of which eventually call am65_est_cmd_ns_to_cnt() which expects valid link_speed,
>> my understanding is that the author intended to have a valid link_speed before
>> proceeding further.
>>
>> Although it seems netif_running() check isn't enough to have valid link_speed
>> as the link could still be down even if the netif is brought up.
>>
>> Another gap is that in am65_cpsw_est_link_up(), if link was down for more than 1 second
>> it just abruptly calls am65_cpsw_taprio_destroy().
>>
>> So I think we need to do the following to improve taprio support in this driver:
>> 1) accept taprio schedule irrespective of netif/link_speed status
>> 2) call pm_runtime_get()/put() before any device access regardless of netif/link_speed state
>> 3) on link_up when if have valid link_speed and taprio_schedule, apply it.
>> 4) on link_down, destroy the taprio schedule form the controller.
>>
>> But my concern is, this is a decent amount of work and I don't want to delay this series.
>> My original subject of this patch series was mpqrio/frame-preemption/coalescing. ;)
>>
>> Can we please defer taprio enhancement to a separate series? Thanks!
> 
> Ok, sounds fair to have some further taprio clean-up scheduled for later.
> I would also add taprio_offload_get() to the list of improvements that
> could be made.

Noted. Thanks!

-- 
cheers,
-roger

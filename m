Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C89804886
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 05:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbjLEEZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 23:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEEZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 23:25:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2349C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 20:25:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A695BC433C7;
        Tue,  5 Dec 2023 04:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701750311;
        bh=Jsp797QrY43cmAXZZXSoXO4WVJz03OTlJ4dLJhsYhJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQ4stgLpuvhbi+r5OKcn/+9iC63lI8H9UbpuHugQ/JarTchazINrKbpvg3ZEnJjRe
         CRxaSRlRZql2gN9RAgSZ8xrL7Ob3hIMtMfUnifXPWyfFZc1jZMvtuMl27v5MvonY3Y
         R1VCOFC32toDb6UM17K6774opzmDbvpMDNSMrdBeXHzxO0SeGVxcfcEWTilkbqA5N9
         0a9bjS3CY+ubwQodOpG/aFv47I8bHBFq2ebX91gIu8f3AQqgbdAZzpe6IJv1pPCZbz
         JGhRIKovbAZ9pnmn5QmUG4BXIIwuDCNI8dRLGzaIJkhR61K5u+ed0ChFW2KMvyyahN
         2eL9WmvzTIrdw==
Date:   Mon, 4 Dec 2023 23:25:08 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL 6.6 15/32] debugfs: annotate debugfs handlers vs.
 removal with lockdep
Message-ID: <ZW6mJFCFIvEdrnoW@sashalap>
References: <20231204203317.2092321-1-sashal@kernel.org>
 <20231204203317.2092321-15-sashal@kernel.org>
 <1a7a8caa3fe9b4e3271239b86ebd24a41464b79f.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1a7a8caa3fe9b4e3271239b86ebd24a41464b79f.camel@sipsolutions.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 09:45:55PM +0100, Johannes Berg wrote:
>On Mon, 2023-12-04 at 20:32 +0000, Sasha Levin wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> [ Upstream commit f4acfcd4deb158b96595250cc332901b282d15b0 ]
>>
>> When you take a lock in a debugfs handler but also try
>> to remove the debugfs file under that lock, things can
>> deadlock since the removal has to wait for all users
>> to finish.
>>
>> Add lockdep annotations in debugfs_file_get()/_put()
>> to catch such issues.
>>
>
>This (and the previous patch) probably got picked up as dependencies for
>the locking things, but ... we reverted this.
>
>For 6.6, _maybe_ it's worth backporting this including the revert, but
>then I'd do that only when the revert landed to have them together. But
>then you should apply all the six patches listed below _and_ the revert,
>the set as here doesn't do anything useful.
>
>However ... given that debugfs is root-only, and you have to be
>reading/writing a file _while_ disconnecting and the file is removed,
>perhaps the whole thing isn't worth backporting at all.
>
>
>
>For 6.1 and earlier, I believe it's not needed at all, so please drop
>from there all of these:
>
> - debugfs: fix automount d_fsdata usage
> - debugfs: annotate debugfs handlers vs. removal with lockdep
> - debugfs: add API to allow debugfs operations cancellation
> - wifi: cfg80211: add locked debugfs wrappers
> - wifi: mac80211: use wiphy locked debugfs helpers for agg_status
> - wifi: mac80211: use wiphy locked debugfs for sdata/link
>
>
>I'd kind of think just dropping all of these completely makes more
>sense.

Will do, thanks!

-- 
Thanks,
Sasha

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974887B8CAB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbjJDTEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344652AbjJDTD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:03:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E78618D;
        Wed,  4 Oct 2023 11:58:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C37C433C9;
        Wed,  4 Oct 2023 18:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445915;
        bh=tq7NZFlnZHqJn3BR7loczaVqdjig92RJVIObjwVIOys=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jHIH1Tyn86fi7HJ9R68SYq3FokwFMukaSVyE6JHrGJt/2Zw6AbBcl/kvKVEkjwIUz
         PhPPGd/6diC/Z1PZuK89LdT8P4Q5P8X7zfUGxGUs5bRKwgkjpLFh/MxdrVBZETgnaW
         IYjoeBHoulD3NmJQhnRMnyiPVC/F8Tufgn1BC07yrpFR830JiC4mG4TH4qxM8abQAr
         MZ9/0NDyuvF0N+qSDtgqtg6I6Ec+cLaf+pIYcO55Zw0077wbLXWsLfvS6hMQ6mFMLa
         Ov6l5L7uj2JQbNMF7kBWdqteIAJh+f9uinwmPhzsekZyN0esobhjjMC52ZuKr4rCRC
         3kYcDXI+coQGg==
Date:   Wed, 4 Oct 2023 20:58:31 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] HID: nvidia-shield: Fix the error handling path
 of shield_probe()
In-Reply-To: <20230918115432.30076-1-rrameshbabu@nvidia.com>
Message-ID: <nycvar.YFH.7.76.2310042058000.3534@cbobk.fhfr.pm>
References: <20230918115432.30076-1-rrameshbabu@nvidia.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023, Rahul Rameshbabu wrote:

> This series fixes some missing clean-up function calls in the error handling of
> the probe.
> 
> Patch 1 and 2 fix some similar issues introduced in 2 different commits (hence 2
> patches)
> 
> Patch 3 is an enhancement that creates a common function for cleaning up
> thunderstrike instances.
> 
> Changes:
> 
>   v1->v2:
>     - Add the LED_RETAIN_AT_SHUTDOWN flag to prevent
>       led_classdev_unregister from trying to set the LED to off before a
>       successful call to hid_hw_start.
>     - Rename err_haptics label to err_ts_create to make the label name more
>       accurate.
>     - Re-order operations in thunderstrike_destroy to be in LIFO order with
>       regards to the operations in thunderstrike_create.
>   v2->v3:
>     - Refactor thunderstrike_destroy to take a thunderstrike instance
>       pointer as a parameter and prevent a variable from being unused
>       in shield_probe.
> 
> Link: https://lore.kernel.org/linux-input/cover.1693070958.git.christophe.jaillet@wanadoo.fr/
> Link: https://lore.kernel.org/linux-input/20230918041345.59859-1-rrameshbabu@nvidia.com/
> 
> Notes from Rahul:
>   - Thank you so much Christophe for these patches.
>   - Sent v2 without accounting for the fact that thunderstrike_destroy in v1
>     makes the thunderstrike instance in shield_probe unused. Tested v3 with W=1.
> 
> Christophe JAILLET (3):
>   HID: nvidia-shield: Fix a missing led_classdev_unregister() in the
>     probe error handling path
>   HID: nvidia-shield: Fix some missing function calls() in the probe
>     error handling path
>   HID: nvidia-shield: Introduce thunderstrike_destroy()

I have applied 1/3 and 2/3 to for-6.6/upstream-fixes and 3/3 to 
for-6.7/nvidia-shield.

Thanks,

-- 
Jiri Kosina
SUSE Labs


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CE87B81EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbjJDOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbjJDOOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:14:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D033EBD;
        Wed,  4 Oct 2023 07:14:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF02C433C8;
        Wed,  4 Oct 2023 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696428858;
        bh=L/Mr44New+pyfxS07F3RFMAGC4EBy3Vu3NpvP3/raio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yeKec6tpX2O10Q2faEGUUVXpPIS7VBXxsaSMPd9dM2AHTpCbniY8X/ZO/2nCl6K8o
         gIwIvz9svx/TQtj6YeuixfSu3AXSAX0GHvfvjZq/Ff2ulrK5lPQTpQ5MDZ6Hpwt11G
         l5/Ba3ymRkys0LBP20mSjXOUoYi9q0HfwG8pva3g=
Date:   Wed, 4 Oct 2023 16:13:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] soundwire: fix initializing sysfs for same devices on
 different buses
Message-ID: <2023100452-craziness-unpopular-7d97@gregkh>
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
 <6628a5f6-ed22-4039-b5c2-2301c05c7e3e@linux.intel.com>
 <2023100453-perfected-palm-3503@gregkh>
 <624b044a-1f0f-4961-8b57-cb5346e7b0d3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624b044a-1f0f-4961-8b57-cb5346e7b0d3@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 09:57:49AM -0400, Pierre-Louis Bossart wrote:
> 
> 
> On 10/4/23 09:38, Greg Kroah-Hartman wrote:
> > On Wed, Oct 04, 2023 at 09:16:47AM -0400, Pierre-Louis Bossart wrote:
> >>
> >>
> >> On 10/4/23 09:02, Krzysztof Kozlowski wrote:
> >>> If same devices with same device IDs are present on different soundwire
> >>> buses, the probe fails due to conflicting device names and sysfs
> >>> entries:
> >>>
> >>>   sysfs: cannot create duplicate filename '/bus/soundwire/devices/sdw:0:0217:0204:00:0'
> >>>
> >>> The link ID is 0 for both devices, so they should be differentiated by
> >>> bus ID.  Add the bus ID so, the device names and sysfs entries look
> >>> like:
> >>
> >> I am pretty sure this will break Intel platforms by changing the device
> >> names.
> >>
> >> sof_sdw.c:      else if (is_unique_device(adr_link, sdw_version, mfg_id,
> >> part_id,
> >> sof_sdw.c:
> >> "sdw:%01x:%04x:%04x:%02x", link_id,
> >> sof_sdw.c:
> >> "sdw:%01x:%04x:%04x:%02x:%01x", link_id,
> > 
> > device id name changes shouldn't break things, what is requring them to
> > look a specific way?
> 
> it's the ASoC dailink creation that relies on strings, we have similar
> cases for I2C.
> 
> There's no requirement that the name follows any specific convention,
> just that when you want to rely on a specific device for an ASoC card
> you need to use the string that matches its device name.

matching the name is fine (if you are matching it against an existing
name) but expecting the name to be anything specific is not going to
work as the name is dynamic and can/will change each boot.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59D97C5112
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjJKKIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjJKKIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:36 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F009F1732;
        Wed, 11 Oct 2023 03:07:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 606E680E1;
        Wed, 11 Oct 2023 10:07:28 +0000 (UTC)
Date:   Wed, 11 Oct 2023 13:07:26 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     dmitry.torokhov@gmail.com, Jonathan.Cameron@huawei.com,
        robh@kernel.org, frank.li@vivo.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [RFC PATCH] Input: omap4-keypad: react on keypresses if device
 is runtime-suspended
Message-ID: <20231011100726.GD34982@atomide.com>
References: <20230929200046.2300333-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929200046.2300333-1-andreas@kemnade.info>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Andreas Kemnade <andreas@kemnade.info> [230929 23:01]:
> According to SWPU235AB, table 26-6, fclk is required to generate events
> at least on OMAP4460, so keep fclk enabled all the time the device
> is opened.

Sorry for the delay, the patch looks good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>

> Open questions:
> - Should we rather (or also use) padconf irqs?

The keypad is in the wakeup domain and has SYSC_OMAP2_ENAWAKEUP set in
the dts, so padconf irqs should not be needed as long as the device is
clocked. As the source clock is sys_32k_ck, not sure if gating it would
save any power, so padconf interrupts are probably not needed.

> - It seems not to be required everywhere. Does it harm somewhere?

Sounds like on 4430 the gate bit does not do anything while on 4460 it
does. The source clock seems to be sys_32k_ck so it's enabled anyways
and should not affect power management.

Regards,

Tony

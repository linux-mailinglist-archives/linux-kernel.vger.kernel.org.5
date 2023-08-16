Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106EE77E622
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbjHPQPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbjHPQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:14:39 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF203C1;
        Wed, 16 Aug 2023 09:14:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7B23E0003;
        Wed, 16 Aug 2023 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692202476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wxb2+0NuQXqPTqCzWBM9tyO1GBBf/uc5NPp8bPde8qw=;
        b=b/pMTa51xIYRnwpKkFCTWY5zYauco1/597mwff19OnJLg/C9V3AE8TkzFacRAkKQcZniss
        F9jOrrwK5GVWDYpXAdKysdfGCx3ryK9tLSW8GJycJUyE3zajYCqfL5TYLMWPb2A6XjVUpj
        df+oWtZRpmrkMIaWn7e2SjVjavUNkgltwtEc6aibrbuCPqgpAQRInWtoRMr3cKuiRpfWR3
        kPD8MT/DbK1OhgvPIzx0HuUikLUoIWriB6YQiFfCXPU1JFhReVJxXQWXZ7zUT2I98B8PXs
        OENAhj6fZtc48C5uFBypqC2zw4eJEzaK8eh1RUyxczB3h9Z+lF1fT8HtcXGDWg==
Date:   Wed, 16 Aug 2023 18:14:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/7] rtc: Add support for limited alarm timer offsets
Message-ID: <20230816161435bd2bbd4a@mail.local>
References: <20230816133936.2150294-1-linux@roeck-us.net>
 <20230816150353137debc5@mail.local>
 <8079bdf4-f790-451b-a2c2-be4e23c0c3a1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8079bdf4-f790-451b-a2c2-be4e23c0c3a1@roeck-us.net>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 08:50:12-0700, Guenter Roeck wrote:
> > I'm fine with the series, however, this doesn't solve the issue for RTCs
> > that have an absolute limit on the alarm (as opposed to an offset to the
> > current time/date).
> > 
> 
> I thought that is checked by rtc_valid_range() in rtc_set_alarm().
> Am I missing something ? Of course that assumes that the absolute
> maximum alarm timeout matches range_max, but I didn't find any
> drivers where that would not be the case.
> 

There are RTCs where this is not the case. When this is far away in the
future enough, the usual solution is to clip range_max which works but
is not really great intellectually.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

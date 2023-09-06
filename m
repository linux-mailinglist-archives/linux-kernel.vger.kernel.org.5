Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEF7793E46
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbjIFOBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjIFOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:01:32 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C410C6;
        Wed,  6 Sep 2023 07:01:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64C85E0014;
        Wed,  6 Sep 2023 14:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694008886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Cc3GDyhTJkNnRyDhyOHbwZd++EIJkpgVHFot9WD1+s=;
        b=R+wgsfOVdpCFKot7c1YUEADgmYoIQ5/WhpjKIOe4kdT91hMjPded5ljT30TGF1L07Lv016
        yYGyZlJt8zlfWFWju4AA5RuLB2RR0riAlJMGtB00OOUgr4lB6xpjxcmRY0R9k+wVb9wuvS
        4o8MBGd9hdZra+NgmUC3ThYFm7L80D4E8fogwPbAHC5wtKdlGfvU/DKJklONQFx2EsN99s
        mGDeeh/nDAlZxfNVAgne3rtD55H1l4hv0S1bwx/5ZcCrEc45LJadW2DMJSguM6giJ6Vxot
        AyFJZXCIzVFCzvFKJNgoQwFICvDSffmtNGSnsbi2tFRwnr48NosQxI9qBskj5Q==
Date:   Wed, 6 Sep 2023 16:01:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mining Lin <mimi05633@gmail.com>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, openbmc@lists.ozlabs.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and
 NCT3018Y-R
Message-ID: <20230906140123dd8ffac4@mail.local>
References: <202309050635059ecd17a2@mail.local>
 <D6734DA5-839E-40A6-9085-F25BB8D70022@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6734DA5-839E-40A6-9085-F25BB8D70022@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 09:19:29+0800, Mining Lin wrote:
> >> static int nct3018y_set_alarm_mode(struct i2c_client *client, bool on)
> >> {
> >>    int err, flags;
> >> @@ -55,7 +59,7 @@ static int nct3018y_set_alarm_mode(struct i2c_client *client, bool on)
> >>    flags =  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
> >>    if (flags < 0) {
> >>        dev_dbg(&client->dev,
> >> -            "Failed to read NCT3018Y_REG_CTRL\n");
> >> +            "%s: Failed to read ctrl reg.\n", __func__);
> > 
> > If you really insist on this change, what about:
> > 
> > #define pr_fmt(fmt) "%s: " fmt, __func__
> [Mia] Do you mean to replace dev_dbg with pr_debug? If yes, for consistency, I'm going to refine all messages via pr_debug. Thank you for your suggestion.

No, I mean that instead of adding __func__ to all the messages just
define pr_fmt, this should achieve what you want.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

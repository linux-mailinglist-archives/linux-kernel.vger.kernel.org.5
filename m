Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21948089EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443029AbjLGOK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442975AbjLGOK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:10:27 -0500
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A469710E9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:10:32 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1701958229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GiNAy2Hgm4il6Eg6UIzDiq34mDKxYnVzU21DMZvQkiY=;
        b=LhpCpjC5vmNJlHpagut9DSMEp7fZMKX5K+L+Ii+geqVN4pgmaHB4UNxcmUnA1Fn22twNhZ
        wGOXbrUOuniiEhDXNEt8/YLeWmWHpUuqfR8e0dFRG5t/6Sp8GPaGxGloICafx/QiUopN1O
        ASl05ipLEvscQTis82wNW1612SPQA6sIsELqmIWCo7Qu9I2BEyykYxT8/DmlseQIgPLQN4
        Sp9Rxa89tkvxbLveCrRLRf8e0+ppf4cc3xusNAbecq4wABnXcZk6w/oThvgVJfiaqjSyr8
        koo3jjuqIgHB/fMDE/vnF/sxv9SXR/W/6DJIipJiju/Bf42chPY/o/FTZPaBUg==
Date:   Thu, 07 Dec 2023 15:10:29 +0100
From:   Dragan Simic <dsimic@manjaro.org>
To:     Jensen Huang <jensenhuang@friendlyarm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Benjamin Bara <bbara93@gmail.com>
Subject: Re: [PATCH v2] i2c: rk3x: fix potential spinlock recursion on poll
In-Reply-To: <CAMpZ1qHUnTDQ78gdrQF9Sx_-XfLM-B+H-0bL1-+twKsno+JOvg@mail.gmail.com>
References: <20231207082200.16388-1-jensenhuang@friendlyarm.com>
 <ebf6cf8ec3b5befd673d295061fa2738@manjaro.org>
 <CAMpZ1qHUnTDQ78gdrQF9Sx_-XfLM-B+H-0bL1-+twKsno+JOvg@mail.gmail.com>
Message-ID: <5e11553952c02ad20591992be4284bbd@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-07 10:25, Jensen Huang wrote:
> On Thu, Dec 7, 2023 at 4:37 PM Dragan Simic <dsimic@manjaro.org> wrote:
>> 
>> On 2023-12-07 09:21, Jensen Huang wrote:
>> > Possible deadlock scenario (on reboot):
>> > rk3x_i2c_xfer_common(polling)
>> >     -> rk3x_i2c_wait_xfer_poll()
>> >         -> rk3x_i2c_irq(0, i2c);
>> >             --> spin_lock(&i2c->lock);
>> >             ...
>> >         <rk3x i2c interrupt>
>> >         -> rk3x_i2c_irq(0, i2c);
>> >             --> spin_lock(&i2c->lock); (deadlock here)
>> >
>> > Store the IRQ number and disable/enable it around the polling transfer.
>> > This patch has been tested on NanoPC-T4.
>> 
>> In case you haven't already seen the related discussion linked below,
>> please have a look.  I also added more people to the list of 
>> recipients,
>> in an attempt to make everyone aware of the different approaches to
>> solving this issue.
>> 
>> https://lore.kernel.org/all/655177f4.050a0220.d85c9.3ba0@mx.google.com/T/#m6fc9c214452fec6681843e7f455978c35c6f6c8b
> 
> Thank you for providing the information. I hadn't seen this link 
> before.
> After carefully looking into the related discussion, it appears that
> Dmitry Osipenko is already working on a suitable patch. To avoid 
> duplication
> or conflicts, my patch can be discarded.

Thank you for responding so quickly.  Perhaps it would be best to hear 
from Dmitry as well, before discarding anything.  It's been a while 
since Dmitry wrote about working on the patch, so he might have 
abandoned it.

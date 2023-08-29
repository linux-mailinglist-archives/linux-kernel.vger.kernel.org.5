Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4B78C76E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjH2OW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbjH2OWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:22:18 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD553AB;
        Tue, 29 Aug 2023 07:22:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 397AA240004;
        Tue, 29 Aug 2023 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693318933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wnpy155cIYydMW3e208J8yS/ifVt33seKo++vJG/Yb8=;
        b=WVHGlBqaQr3iM9bpFVzT7ECtuevQ4EM7/8GvfCAsDoRcc2YrnYJKiPQF+EGLXAvKG6yTqV
        eEiKsSjtKHpjvbzTn49BzcufPBi49ob1W+Nn5QbesNR0tPp5GIu3dPoav75T/3sm9YGFAJ
        P2cpooTotzTNVyZkqaL5JOYfzV4nQHp5pPM5q6Ar93vYeNBbeqJIDuIq6F3wCZOhIijktB
        +H9eRhxTy9OoeAZvn266ZtojADLBm0KdjWLzKJcflre+LNPx98hOL5VPmM6xiplUYoUWe9
        nOUQCm/jALS5JhpG01ysoBgBdLX14/YPfN/8ciHdRepkUrGmxMtQtxkco6x8+Q==
Date:   Tue, 29 Aug 2023 16:22:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Minying Lin <mimi05633@gmail.com>
Cc:     "avifishman70@gmail.com" <avifishman70@gmail.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "tali.perry1@gmail.com" <tali.perry1@gmail.com>,
        "venture@google.com" <venture@google.com>,
        "yuenn@google.com" <yuenn@google.com>,
        "benjaminfair@google.com" <benjaminfair@google.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>,
        "JJLIU0@nuvoton.com" <JJLIU0@nuvoton.com>,
        "KFLIN@nuvoton.com" <KFLIN@nuvoton.com>,
        "mylin1@nuvoton.com" <mylin1@nuvoton.com>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and
 NCT3018Y-R
Message-ID: <2023082914221048e46085@mail.local>
References: <20230816012540.18464-1-mimi05633@gmail.com>
 <20230816012540.18464-2-mimi05633@gmail.com>
 <2023082322124382cfd168@mail.local>
 <CAL3ZnpxEuOQtpaqA7KLBr285JvTDJrcT+ZGYyjy7Bi-sVs5yVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3ZnpxEuOQtpaqA7KLBr285JvTDJrcT+ZGYyjy7Bi-sVs5yVA@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 21:35:36+0800, Minying Lin wrote:
> > Do you really have to check the part number every time you set the time?
> > I don't expect it to change once read in probe.
> >
> [Mia] Due to the 3018Y's topology, we need to set the TWO bit first to
> obtain the write time capability, but the 3015Y does not have this problem.
> Therefore, we use part number & TWO bit to determine whether we need to set
> the TWO bit first before set time.
> 

Sure but why don't you store the info somewhere instead of reading it
from the RTC every time?

> >
> > > +     if (part_num < 0) {
> > > +             dev_dbg(&client->dev, "%s: Failed to read part info
> > reg.\n", __func__);
> > > +             return part_num;
> > > +     }
> > > +
> >
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> >

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

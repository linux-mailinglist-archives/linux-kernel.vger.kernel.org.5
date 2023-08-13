Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6855A77A67A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjHMNO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:14:26 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F321710;
        Sun, 13 Aug 2023 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=32c6Mm00cywxiQeEBwm2QcUwjGNrZK2x4F4KY6NgXho=; b=E7FGsiYTH3wPJ7Tmf2adP5WNyD
        Cvv102lMqPh9YoKqH5L2ogeYt3RCS2/hUkkZmskEj/JhuCoRmRcYpUFYybYargIzOnUfDWxaKr7/6
        BYnAc/XGL+tHscgWuishetwlPG+GvANno729NutZ85R/sTfZdPkcIW0gYb6oPtmjWi1MXvTcU3Bwj
        BTG1b3+mCaL4yvhQa3qasMCnEzFKCYDaR2jatUnmC5o7dABQ/yvuTOqFuqJG1cSLJ5+9DoJWrvW9F
        VtM/QAkcsu1UHGbFxCJY+K9U2GojcUcSxiuU5Kr2Q5VX+tW4s/oBZhhS9vTjAJS3o/M3w40N5OeY5
        eeYHjumQ==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qVAvC-006cZ6-8i; Sun, 13 Aug 2023 13:14:18 +0000
Date:   Sun, 13 Aug 2023 13:14:18 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Regression: v4l/bttv vbi vs iommu
Message-ID: <ZNjXKjCx3lH0s1m3@gallifrey>
References: <Y9qSwkLxeMpffZK/@gallifrey>
 <d363902d-e465-8411-0c1e-58411b3a19b0@xs4all.nl>
 <20230203063500.GA23520@lst.de>
 <3a59ffba-a7fe-97b0-af76-7194f7b3896a@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3a59ffba-a7fe-97b0-af76-7194f7b3896a@xs4all.nl>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 13:14:01 up 37 days, 22:45,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hans Verkuil (hverkuil@xs4all.nl) wrote:
> On 03/02/2023 07:35, Christoph Hellwig wrote:
> > On Wed, Feb 01, 2023 at 09:48:46PM +0100, Hans Verkuil wrote:
> >> In fact, the plan is to replace the old and deprecated videobuf framework by the vb2
> >> framework in the bttv driver in the next 2-3 months or so. That will also automatically
> >> solve this problem.
> > 
> > It would be great to expedite removal of the old videbuf code given
> > how many problems it has.
> 
> We're working on it. A lot of old drivers in drivers/staging/media/deprecated will
> be removed in 6.3, and that leaves the cx18, bttv and saa7146 drivers that still use
> vb1.
> 
> This week I posted patches converting cx18 to vb2 and someone else will work on the
> bttv conversion. We thought we could remove saa7146 as well, but it turns out that
> that is still very much in use (somewhat unexpectedly), so I plan to convert that
> one this month (I hope).
> 
> I aim for removing vb1 in kernel 6.4 or 6.5.

Did this go in, I'm happy to give it a go if this is a world to test.

Dave

> Regards,
> 
> 	Hans
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

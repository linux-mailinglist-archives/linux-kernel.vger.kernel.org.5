Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AF17BA19F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbjJEOor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbjJEOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EECA8A72;
        Thu,  5 Oct 2023 07:12:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B39C32791;
        Thu,  5 Oct 2023 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696506396;
        bh=Tt+QrhONT0CY32fce+X9EftOLASSwx+FczEn3l1wk4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWNpYviykgd6R6JWJ3j+9Sa+pAU0UCV+UT3CuLYSd8QZE2IaGCwdOmvAa3sKii4HC
         5soH5hDtPgTMYfDXKt8G54tCAVnePTNjkPTfbk4sa8R4xlJO4LoQ2DyEBkmxTRDbXv
         xdUo08u7NuPUWqMKwkRDc59z4kWWkTjSdwpOid311FCZXs1PT158s8QVN1Lv1yNmY4
         6wIyegEtEqyrvJZheC20hMDiGnlefy7vzZ+T2kPbZcPqDOzWm0w4iApXe0wCO3Mj+j
         JhRFJ1y3MJEhu0BpuKbBn+zzfhaXR/+efknvAZmBnYoA4na3HpRgZrIJYSJtw9NwHN
         VxP4WHrgBgibQ==
Date:   Thu, 5 Oct 2023 12:46:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com" 
        <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <20231005114632.GA681678@google.com>
References: <2023100421-negotiate-stammer-1b35@gregkh>
 <20231004085720.GA9374@google.com>
 <2023100448-cotton-safehouse-aca2@gregkh>
 <20231004125704.GA83257@google.com>
 <2023100435-xerox-idiocy-5cf0@gregkh>
 <20231005090311.GD83257@google.com>
 <2023100528-directory-arrogant-2ca9@gregkh>
 <20231005104311.GG83257@google.com>
 <2023100512-charger-cherisher-9a3d@gregkh>
 <DB9PR10MB5881E8D3903C19EBAD9AF895E0CAA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR10MB5881E8D3903C19EBAD9AF895E0CAA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023, Starke, Daniel wrote:

> > > Would something like this tick that box?
> > > 
> > > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c index 
> > > 1f3aba607cd51..5c1d2fcd5d9e2 100644
> > > --- a/drivers/tty/n_gsm.c
> > > +++ b/drivers/tty/n_gsm.c
> > > @@ -3716,6 +3716,10 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
> > >         if (!gsm)
> > >                 return -ENODEV;
> > >  
> > > +       /* The GSM line discipline does not support binding to console */
> > > +       if (strncmp(tty->name, "tty", 3))
> > > +               return -EINVAL;
> > 
> > No, that's not going to work, some consoles do not start with "tty" :(

Ah, you mean there are others that we need to consider?

I was just covering off con_write() from drivers/tty/vt/vt.c.

Does anyone have a counter proposal?

> Also, I would recommend exiting as early as possible. E.g. in gsmld_open().

Good suggestion.

> And please retain support for real serial devices (e.g. ttyS, ttyUSB,
> ttyACM, ...).

Okay, so it's "tty{0-9}*$" that should be excluded?

Plus others that Greg alluded to?

Is there a definitive accept / reject list?

-- 
Lee Jones [李琼斯]

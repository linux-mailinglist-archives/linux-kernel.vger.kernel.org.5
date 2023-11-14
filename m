Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F497EA785
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKNAbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 19:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjKNAbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 19:31:32 -0500
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092E1189;
        Mon, 13 Nov 2023 16:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=v9xA0beM+7Vnglcj1EKkfFapEd9IXYa0r9WQGN04kh4=; b=EONGZhzADUnkb9WzcyjZVvtRXg
        i2yFyZph7cwMu4m/+bmW1fTAiq3bPtOPR8UiFxMsXiMKgX7f6prGn10MX52L1FBz6ox7gsXqhMFz9
        YPyD2jQLANBL0pNp79228qpF25zR0+x4Pyh+dyA36EvfkQzqUmiMimI7EVF+8m6zMfZeHz2uhPcna
        CmLfsLtUcLHlqz26IVexwd1gr5OOYyawSRgoeUaqLTP5glwHPOvZOYlQBhS5/3OUVvJRXS9TpBfeA
        Nd6droK47JabU35uOTrvpJzFmgg5mIgJ+uWZHxvIzcHosOiAbvEomED8XeBiX1pfDKmVTO0R++Plc
        xkr+P6hw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
        (envelope-from <dg@treblig.org>)
        id 1r2hKv-008zNI-1c;
        Tue, 14 Nov 2023 00:31:25 +0000
Date:   Tue, 14 Nov 2023 00:31:25 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     a.j.buxton@gmail.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression: v4l/bttv vbi vs iommu
Message-ID: <ZVK_3UmvmOaCv1tc@gallifrey>
References: <Y9qSwkLxeMpffZK/@gallifrey>
 <d363902d-e465-8411-0c1e-58411b3a19b0@xs4all.nl>
 <20230203063500.GA23520@lst.de>
 <3a59ffba-a7fe-97b0-af76-7194f7b3896a@xs4all.nl>
 <ZNjXKjCx3lH0s1m3@gallifrey>
 <8a667bd9-6a2d-301c-ee11-23e9466b193a@xs4all.nl>
 <ZU_cuavAminaVhuw@gallifrey>
 <a1f8a9fa-50c6-44e2-9be8-2c0cc60c9906@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a1f8a9fa-50c6-44e2-9be8-2c0cc60c9906@xs4all.nl>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-12-amd64 (x86_64)
X-Uptime: 00:13:48 up 59 days,  3:12,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hans Verkuil (hverkuil@xs4all.nl) wrote:
> Hi Dave,

Hi Hans,
  I've trimmed the iommu list off now, since we've got past them.

> On 11/11/2023 20:57, Dr. David Alan Gilbert wrote:
> > * Hans Verkuil (hverkuil@xs4all.nl) wrote:
> >> On 13/08/2023 15:14, Dr. David Alan Gilbert wrote:
> >>> * Hans Verkuil (hverkuil@xs4all.nl) wrote:
> >>>> On 03/02/2023 07:35, Christoph Hellwig wrote:
> >>>>> On Wed, Feb 01, 2023 at 09:48:46PM +0100, Hans Verkuil wrote:
> >>>>>> In fact, the plan is to replace the old and deprecated videobuf framework by the vb2
> >>>>>> framework in the bttv driver in the next 2-3 months or so. That will also automatically
> >>>>>> solve this problem.
> >>>>>
> >>>>> It would be great to expedite removal of the old videbuf code given
> >>>>> how many problems it has.
> >>>>
> >>>> We're working on it. A lot of old drivers in drivers/staging/media/deprecated will
> >>>> be removed in 6.3, and that leaves the cx18, bttv and saa7146 drivers that still use
> >>>> vb1.
> >>>>
> >>>> This week I posted patches converting cx18 to vb2 and someone else will work on the
> >>>> bttv conversion. We thought we could remove saa7146 as well, but it turns out that
> >>>> that is still very much in use (somewhat unexpectedly), so I plan to convert that
> >>>> one this month (I hope).
> >>>>
> >>>> I aim for removing vb1 in kernel 6.4 or 6.5.
> >>>
> >>> Did this go in, I'm happy to give it a go if this is a world to test.
> >>
> >> I just merged it for 6.6.
> > 
> > Hi Hans,
> >   Apologies in the delay, I've just got around to looking at 6.6
> > for this.
> >   I'd say it's looking pretty good, oops free so far.
> > There are a couple of oddities, which I'm not sure are an issue or not:
> > 
> > a) Loss of 'seq' field.
> >   The bttv used to include a sequence number in each vbi line;
> > That now seems to be 0; I don't think it's a big loss, but it was
> > used by some tools to see if they dropped frames, and it's confusing
> > it into moaning about it.
> 
> Hmm, I knew about this, but I thought it was something that the driver did.
> Instead, it turns out it was a videobuf 'feature' in videobuf_read_stream().
> 
> This would affect saa7146 and bttv, since both enabled that. None of the
> other driver with VBI capabilities ever used that, AFAICT.

Yeh I can believe it; the code I'm using from Alistair (cc'd) checks it
to see if you're losing any if on a bttv.

> > b) Frame vs fields
> > 
> > I tend to run xawtv at the same time as dumping vbi; with xawtv grabbing
> > frames, the vbi is showing it grabbing 50fps, if I drop xawtv to
> > no-capture, the vbi is showing it at 25fps; I've not figured out yet if
> > that's actually losing data or just reorganising it.
> > (The reason for running xawtv is that it was found that the AGC on the
> > bttv goes out if you've not got it running sometimes).
> 
> Odd.

Alistair has a neat little test setup generating an image stream;
what that seems to be showing for me is that if I run:

   a) xawtv with 'capture' off in parallel with the VBI read, all is
   good

   b) xawtv with 'capture' to 'grab display' in parallel with the VBI
   read, then the VBI read is getting 'extra' frames in it, where they
   start out as being blank extra frames in between valid ones, but then
   seem to contain an old frame at some point.

   So there's something going on.

> For both items it will have to wait until I have access again to my test
> equipment in 2 weeks.

No rush.

Dave

> Regards,
> 
> 	Hans
> 
> > 
> > Anyway, thanks for fixing the rework that fixed the crash!
> > 
> > Dave
> > 
> > 
> >>
> >> Regards,
> >>
> >> 	Hans
> >>
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

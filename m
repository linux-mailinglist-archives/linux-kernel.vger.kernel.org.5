Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B135F763AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjGZPTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjGZPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:18:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD642119;
        Wed, 26 Jul 2023 08:18:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 627A45AA;
        Wed, 26 Jul 2023 17:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690384677;
        bh=GIqgHaGWTByEn2OukYlLQnJXOi98nXe3hgeZY5YqPuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKryUUjgfXC53xnjOT54/bZfQLXyPkx3c/gdRfvyAM2nYuj44JzhI2ZrFnoYpdae/
         qKLjVfST6BL0m9gT4INH8fEGGAH6q7vFrClTYHQKuRBcAag6uwfOB0tvNmrCKoCiZs
         qMTDgUeQtkETQxl9bHCimOCyy+RYPjeveA0QWqg8=
Date:   Wed, 26 Jul 2023 18:19:03 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        stable@kernel.org, Zubin Mithra <zsm@chromium.org>,
        Kai =?utf-8?Q?Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>
Subject: Re: [PATCH v2] media: uvcvideo: Fix OOB read
Message-ID: <20230726151903.GD5148@pendragon.ideasonboard.com>
References: <20230717-uvc-oob-v2-1-c7745a8d5847@chromium.org>
 <20230725213451.GU31069@pendragon.ideasonboard.com>
 <CANiDSCttkqows7PZS823Jpk-CqK9Gz2rujF_R4SPDi=wcPJ2LA@mail.gmail.com>
 <20230726080753.GX31069@pendragon.ideasonboard.com>
 <952fb983-d1e0-2c4b-a7e8-81c33473c727@leemhuis.info>
 <CANiDSCvVag+sW5JDTKAPuML_-+6xHWgF+NeKoBKSd5MMr1Yiag@mail.gmail.com>
 <ab557ae6-7550-189a-81dd-6e3346d84620@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab557ae6-7550-189a-81dd-6e3346d84620@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:47:46AM +0200, Thorsten Leemhuis wrote:
> On 26.07.23 10:38, Ricardo Ribalda wrote:
> > On Wed, 26 Jul 2023 at 10:33, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >> On 26.07.23 10:07, Laurent Pinchart wrote:
> >>> (CC'ing Kai and Thorsten who have added the check to checkpatch)
> >>>
> >>> On Wed, Jul 26, 2023 at 08:24:50AM +0200, Ricardo Ribalda wrote:
> >>>> On Tue, 25 Jul 2023 at 23:34, Laurent Pinchart wrote:
> >>>>> On Thu, Jul 20, 2023 at 05:46:54PM +0000, Ricardo Ribalda wrote:
> >>>>>> If the index provided by the user is bigger than the mask size, we might do an
> >>>>>> out of bound read.
> >>>>>>
> >>>>>> CC: stable@kernel.org
> >>>>>> Fixes: 40140eda661e ("media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU")
> >>>>>> Reported-by: Zubin Mithra <zsm@chromium.org>
> >>>>>
> >>>>> checkpatch now requests a Reported-by tag to be immediately followed by
> >>>>> a Closes
> >>
> >> Not that it matters, the changes I performed only required a Link: tag,
> >> which is how things should have been done for many years already. It
> >> later became Closes: due to patches from Matthieu. But whatever. :-D
> > 
> > I prefer to leave the Reported-by and remove the Closes, that way we
> > credit the reporter (assuming they approved to be referred).
> > 
> > But if that is not possible, just remove the reported-by. A private
> > link is pretty much noise on the tree.
> 
> Yeah, of course that's the right strategy (Linus made it pretty clear
> that he doesn't want any private links) in case the reporter okay with
> the Reported-by. Sorry, forgot to cover that case in my reply.

I'll keep the Reported-by and omit the Link/Closes tags.

-- 
Regards,

Laurent Pinchart

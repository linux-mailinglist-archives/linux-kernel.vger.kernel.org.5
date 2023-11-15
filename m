Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AADA7ECC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjKOTbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjKOTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:31:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD2CA1;
        Wed, 15 Nov 2023 11:31:05 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7BF1929A;
        Wed, 15 Nov 2023 20:30:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700076636;
        bh=VG1aMvjuyEjHJfeeciYccDaZR4VmWCZdcztVpSsBQws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DAOdraz76XQD0sbIC3knIYtUGx5E+j6Jv8+x8BDAOyZy9+/XccbKVNgc8o2fyn0kT
         VJwVjUEi3AQvh5UUDbCoo24qXhx/ti2gRaUpPLmyoyCPt4ozjzmX1KB2KOW1oN9FR3
         FEeMVeEB1CUz75/SuM+6/BC6maXz3BqjBYXVbjoQ=
Date:   Wed, 15 Nov 2023 21:31:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
Subject: Re: [PATCH v2 03/15] media: videobuf2: Allow exporting of a struct
 dmabuf
Message-ID: <20231115193107.GB29486@pendragon.ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-4-umang.jain@ideasonboard.com>
 <72f83177-cd34-480a-afcc-a79f85219751@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72f83177-cd34-480a-afcc-a79f85219751@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 08:41:11PM +0100, Stefan Wahren wrote:
> Am 09.11.23 um 22:02 schrieb Umang Jain:
> > From: Dave Stevenson <dave.stevenson@raspberrypi.org>
> >
> > videobuf2 only allowed exporting a dmabuf as a file descriptor,
> > but there are instances where having the struct dma_buf is
> > useful within the kernel.
> >
> > Split the current implementation into two, one step which
> > exports a struct dma_buf, and the second which converts that
> > into an fd.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > ---
> 
> ...
> 
> > diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> > index 4b6a9d2ea372..cba4e495f6a2 100644
> > --- a/include/media/videobuf2-core.h
> > +++ b/include/media/videobuf2-core.h
> > @@ -925,6 +925,21 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type);
> >    */
> >   int vb2_core_streamoff(struct vb2_queue *q, unsigned int type);
> >
> > +/**
> > + * vb2_core_expbuf_dmabuf() - Export a buffer as a dma_buf structure
> > + * @q:         videobuf2 queue
> > + * @type:      buffer type
> > + * @index:     id number of the buffer
> > + * @plane:     index of the plane to be exported, 0 for single plane queues
> > + * @flags:     flags for newly created file, currently only O_CLOEXEC is
> > + *             supported, refer to manual of open syscall for more details
> 
> i think "newly created file" could be confusing here

Would "newly created dmabuf file handle" be clearer and work for
everybody ?

> > + *
> > + * Return: Returns the dmabuf pointer
> > + */
> > +struct dma_buf *vb2_core_expbuf_dmabuf(struct vb2_queue *q, unsigned int type,
> > +				       unsigned int index, unsigned int plane,
> > +				       unsigned int flags);
> > +
> >   /**
> >    * vb2_core_expbuf() - Export a buffer as a file descriptor.
> >    * @q:		pointer to &struct vb2_queue with videobuf2 queue.

-- 
Regards,

Laurent Pinchart

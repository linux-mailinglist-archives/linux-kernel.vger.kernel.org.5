Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459F67AB216
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjIVM1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIVM07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F5F99
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695385567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uHDbDGcnezPT4bKowgq6lQs64vPnJa0qQhHe7lIWSKs=;
        b=gbZRAIh9gxlYz7J70eUzfOUEQJqPaU6/I8WBdTVohgPvxZlYPYrskhEM90FPmKmRIIkPK4
        FT619WNrCELmhmVmH52U8t+ar7XHYIxwhD+klDc6MLGV74JQCQoa4+i6A00FoP5FwYSLxw
        n4Q/so0WX/JUrzCbrXdDsR2aRsGtOw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-ruUtV3wVOKWDAIjl1KTNjA-1; Fri, 22 Sep 2023 08:26:01 -0400
X-MC-Unique: ruUtV3wVOKWDAIjl1KTNjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC9C38039CB;
        Fri, 22 Sep 2023 12:26:00 +0000 (UTC)
Received: from localhost (unknown [10.39.193.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0376140E950;
        Fri, 22 Sep 2023 12:25:59 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/cio: Fix a memleak in css_alloc_subchannel
In-Reply-To: <20230922141700.10895474.pasic@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20230921071412.13806-1-dinghao.liu@zju.edu.cn>
 <20230922141700.10895474.pasic@linux.ibm.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date:   Fri, 22 Sep 2023 14:25:58 +0200
Message-ID: <87sf76z961.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22 2023, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 21 Sep 2023 15:14:12 +0800
> Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
>> When dma_set_coherent_mask() fails, sch->lock has not been
>> freed, which is allocated in css_sch_create_locks(), leading
>> to a memleak.
>> 
>> Fixes: 4520a91a976e ("s390/cio: use dma helpers for setting masks")
>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>
> @Vineeth: Do you know why is the spinlock "*sch->lock" allocated
> dynamically and referenced via a pointer instead of making the
> spinlock simply a member of struct subchannel and getting rid
> of the extra allocation?
>
> I did some archaeology together with Peter. The
> lock used to be a member but then commit 2ec2298412e1 ("[S390]
> subchannel lock conversion.") switched to (mostly) allocating
> the lock separately. Mostly because of this hunk:
>
> @@ -520,9 +530,15 @@ cio_validate_subchannel (struct subchannel *sch, struct subchannel_id schid)
>         /* Nuke all fields. */
>         memset(sch, 0, sizeof(struct subchannel));
>  
> -       spin_lock_init(&sch->lock);
> +       sch->schid = schid;
> +       if (cio_is_console(schid)) {
> +               sch->lock = cio_get_console_lock();
> +       } else {
> +               err = cio_create_sch_lock(sch);
> +               if (err)
> +                       goto out;
> +       }
>
> I did not spend a huge amount of time looking at this but this
> is the only reason I found for sch->lock being made a pointer. There may
> be others, I'm just saying that is all I've found.

Author of 2ec2298412e1 here. If I don't completely misremember things,
this was for the orphanage stuff (i.e. ccw devices that were still kept
as disconnected, like dasd still in use, that had to be moved from their
old subchannel object because a different device appeared on that
subchannel.) That orphanage used a single dummy subchannel for all ccw
devices moved there.

I have no idea how the current common I/O layer works, but that might
give you a hint about what to look for :)

>
> Since 863fc8492734 ("s390/cio: get rid of static console subchannel")
> that reason with the console_lock is no more. And that brings me back to
> the question: "Why?"
>
> Regards,
> Halil
>
> [..]


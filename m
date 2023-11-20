Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BEC7F1E04
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjKTUeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjKTUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:34:00 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A57CC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:33:56 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so3839351b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1700512435; x=1701117235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=evAEpm60eEP3dXV5IIqup+kGHQJCYdmk5kN5UrPqUqI=;
        b=XWaspkYYw44E33EzKaGnJUsIVM+Ss5R+yYkkZi0c9hwh1WD0cLRFNTtHoIbN9iv1Em
         6XBfwne5kehR8C8byBlNCobcSlPrqAmgG3OGf628BLtRoDNubaDRu7NyVC87/JFxVkOe
         sdxy8YKauDLBnAe1+J2REJsCWB1gNQJrRVieIX0RICJrEDA1tHgwBgHa+czTDzSz0lpE
         405jzexLvDQq7cwBVKzqRRr42f6mQzxeOij9p7nwS2sjxsh8dD2MjwMscWqK+2mcEcTn
         O3e3PjIDi6KdIS5gALCZ/YT3FsWhfv8mCu7NSAs3rnMAWuRp0KQggidp/k61xS0aWezK
         csTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700512435; x=1701117235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evAEpm60eEP3dXV5IIqup+kGHQJCYdmk5kN5UrPqUqI=;
        b=DLOWo5EGOTPdYGmhk0lX62m+tV4hZ3EA3G/JADu7L3QhN98mF4ukiApNpyFvjshyVr
         0vUVqQeX1s91TtWuzlHDMadvA1SGEuGNGud6qy4RcXa4U5/I9hwcFohl8OwH/uKL2Zi/
         ED1s21F2s40dO0pXJZDR6e8f4hS7wQFBVcynpjcXint8BwutAci1nszF/iaK3wnnxNpg
         HHTQElur5shXlqHVzpyjUTXK9Tk5+joq2DgCZdL3gXFKIvZgvGignX6PgnO/YpwGj0DM
         TZNwxhUSb4WG9EQocpklTAGFMsgvL6LLblB8wJOBBvJreoRSUIMMGTxUEQhxVi99iSO8
         A76g==
X-Gm-Message-State: AOJu0Yx5NzvekGUsKl4eqkfvBcujRXTGh9AEuS/VZhKbQFf1Rx6ljkVK
        5kinbiZQP1Cv7O/eXi5XdnTZDw==
X-Google-Smtp-Source: AGHT+IEUIW0UoDRHG7vGbEKmmcfumQAR5wXy6IpLvsSKoDwysXkoX+X9La6bv+9CGvmyGf8BTbi2pQ==
X-Received: by 2002:a05:6a20:c188:b0:187:9392:cfdd with SMTP id bg8-20020a056a20c18800b001879392cfddmr7866906pzb.24.1700512435511;
        Mon, 20 Nov 2023 12:33:55 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id k81-20020a628454000000b00688965c5227sm6783104pfd.120.2023.11.20.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:33:54 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1r5Axs-00FH1P-0e;
        Tue, 21 Nov 2023 07:33:52 +1100
Date:   Tue, 21 Nov 2023 07:33:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v9 0/3] [PATCH v9 0/3] Introduce provisioning primitives
Message-ID: <ZVvCsPelezZesshx@dread.disaster.area>
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
 <ZU7RVKJIzm8ExGGH@dread.disaster.area>
 <CAG9=OMPFEV9He+ggq2mcLULnUZ2jm8fGU=4ca8kBoWtvqYcGVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMPFEV9He+ggq2mcLULnUZ2jm8fGU=4ca8kBoWtvqYcGVg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:26:51PM -0800, Sarthak Kukreti wrote:
> On Fri, Nov 10, 2023 at 4:56 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Nov 09, 2023 at 05:01:35PM -0800, Sarthak Kukreti wrote:
> > > Hi,
> > >
> > > This patch series is version 9 of the patch series to introduce
> > > block-level provisioning mechanism (original [1]), which is useful for
> > > provisioning space across thinly provisioned storage architectures (loop
> > > devices backed by sparse files, dm-thin devices, virtio-blk). This
> > > series has minimal changes over v8[2], with a couple of patches dropped
> > > (suggested by Dave).
> > >
> > > This patch series is rebased from the linux-dm/dm-6.5-provision-support
> > > [3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The final
> > > patch in the series is a blktest (suggested by Dave in 4) which was used
> > > to test out the provisioning flow for loop devices on sparse files on an
> > > ext4 filesystem.
> >
> > What happened to the XFS patch I sent to support provisioning for
> > fallocate() operations through XFS?
> >
> Apologies, I missed out on mentioning that the XFS patches work well
> with loop devices.
> 
> I might have misunderstood: were those patches only for sanity testing
> or would you prefer that I send those out as a part of this series? I
> can whip up a quick v10 if so!

I was implying that if you are going to be adding support to random
block devices for people to actually test out, then you should be
adding support to filesystems and writing new -fstests- to ensure
that loop devices are actually provisioning blocks at exactly the
locations that correspond to the physical file extents the
filesystem provisioned, too.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

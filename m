Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABA77D7349
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjJYSc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJYSc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:32:26 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11485116
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:32:23 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 5614622812f47-3b52360cdf0so483623b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698258742; x=1698863542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ITofy++IV5vAJ6Tm+pHoA0acLIWPFQv5Ue2A3iNM5o=;
        b=GFNwcaXmYI71s0FO/FywHOz58uGioJbFy32RCR6eoeRaVcBV3zAyuJqwgyS+Uh6/09
         JzMY2Dj9bKZ4tWb0C/RxOJ9en6TxRKVq98M/vczziX+YcT8IpXRqwYtzRxbyBMNY36ka
         rxwIpIqGg0MVVE5P8Gyy9XZcaqrjti0G+1ISpkuht7Guu6e8HIE3yedGajvf53OqkAcS
         nImiL+tuvY81F85MdlXpn9X0DA/LLveAh9Pml51Fd+RJ6wtgQ1SsF450+hGwuS71hAUr
         LiF4yDtO+g9yniX6FDKnOVPVcYHxj758/ypK16jVqh5RIL1QeGeNwbX/uJmnfPnoBSpb
         +JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258742; x=1698863542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ITofy++IV5vAJ6Tm+pHoA0acLIWPFQv5Ue2A3iNM5o=;
        b=TkYtiaYxanBt8fMN6jFteFWDf47WMhofxh+la32+baAtcAadqlokQegqGyYTureA0l
         mWwQO55x8X3SfNOfCKyN6ceu2ecB4pDlz1eLvGz7euwiqshAo985p5OqIlW/VxzCPt67
         Crn4xymc1IgbY1EZOWhs7A8crMUSRxFLDYeEiCdjTAPC7gHKP69e5u1X1ywjZvuvprpP
         pyyEFBeSlYCrAvMIv0Z+B8kEGpiVCkOQs1mm9BmMsYgnpX9+j/5djhWeryM4IrjuZZNa
         ZCGyB5uDlEHgWmDmqLlwlJZl4SBFE0y2XbDiHVK4EkrB/lKr9DF6MaF9A4ydAzJ3OBXb
         e94Q==
X-Gm-Message-State: AOJu0Yz+8o/aJzTzNmQE8sYaTAH6vIx8SOaSzNjRcvSYbKQYRQjAyiJF
        WRKdBCT26lBfFw0S5jmQN+/vuA==
X-Google-Smtp-Source: AGHT+IF3zGyOio/TyOgUPNVF8bSfN9eycyQP3oHU1zL2/yr7Aw+jM1elK8/PMy/0y8tVVtoMH4HvQQ==
X-Received: by 2002:a05:6808:b29:b0:3ab:8956:ada4 with SMTP id t9-20020a0568080b2900b003ab8956ada4mr13619518oij.10.1698258742362;
        Wed, 25 Oct 2023 11:32:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id bl29-20020a056808309d00b003b2e4511f22sm2468353oib.17.2023.10.25.11.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 11:32:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qvig0-004vSE-Mf;
        Wed, 25 Oct 2023 15:32:20 -0300
Date:   Wed, 25 Oct 2023 15:32:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com>
Cc:     iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in
 iommufd_ioas_iova_ranges
Message-ID: <20231025183220.GQ691768@ziepe.ca>
References: <000000000000d621b406088a2f55@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d621b406088a2f55@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 06:11:01AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c3200081020d Merge tag 'block-6.6-2023-10-20' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15013471680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
> dashboard link: https://syzkaller.appspot.com/bug?extid=45f6cae2ca8c1f71e529
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/caa5c1eed3ec/disk-c3200081.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7990a3a9f71e/vmlinux-c3200081.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/015551ac9acc/bzImage-c3200081.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in __up_read+0xb3/0x690 kernel/locking/rwsem.c:1342
> Read of size 8 at addr ffff8880283c9068 by task syz-executor.2/30372

Oh *ugh* I knew about this limitation once and forgot about it
apparently.

  CPU 0         CPU1
 down_read()
 up_read()
                down_write()
                up_write()
		kfree()
 [..]
  tail portion of up_read()

I suppose the rwsem should be turned into a refcount and completion

Jason

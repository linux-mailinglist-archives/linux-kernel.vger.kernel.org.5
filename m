Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78D79089E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbjIBP7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIBP7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:59:53 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBD9E7E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:59:50 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b9a2416b1cso79890a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693670389; x=1694275189; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnEkQcajTlSloQfs6AhM0nt/JC6HaPWBmgZ2b8nds0w=;
        b=cIJW5ueKkmPmKs4QZr8oxj37x6qJYXYZ6qtYMj2EZkMoxfGYcl/v0L1EDg8oULU6Jv
         WfaU+4LyRJGL3sx6rfS2yW0xB+hZQ8pcR4yu63k4FoBsdrW/rrca28IXKqC06bUyViha
         iTL71ISGplrt3FEF0E0jN/NU682ZaJD/0quSf+kiL+mMNrJsCTI7df19zkHJftgdEFwr
         +QGLjqqImI0NqslAgI6XhMZ53LuhsRgItzYMvRIcdM14RG9YQwz7/18xaxtWqu+uMhLf
         PeqB7Ga3kC8N4exQHXXpTHTSPbOQ4ioWkXwi9jWWLCUhraa5yo/JwLk7DHiha5RGgu0d
         YTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693670389; x=1694275189;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnEkQcajTlSloQfs6AhM0nt/JC6HaPWBmgZ2b8nds0w=;
        b=UECbMBWAQvTqJwF6M2KXv6Au3ZW785z0YB64ubTdH5yl0Zn5ieZwseaYFhmCSY6AB2
         vX8bekszez20NXb36YuGJRVaiyVwQ7VLN86owakuf33CPEq3qlD1ow4s2ut4PRmB0Rgk
         dRa20g4Axw1a6OcjQICWKX+kZtiqlSQBTi9T+C2HnfyMugjscQN2rlTIeeLwX6L/cMBz
         gVzA/hzXeV052N7M8Mf3Q+XxgYyd36X4N/Xz3Va5nHDHlwC5O6NBZL9IUl1WbEaybc3j
         c1ygoW8Y4UagUAAX8ywzSDwi6JbqxxwFCW1Knur8+OaTJU4mvn/hzugshcaraNfNLxYb
         SsSQ==
X-Gm-Message-State: AOJu0YxkT/2Wn+tHQpZU0oUGeNgTHOfeBCX2q8lCvmzjll1jioNQtv/e
        FfXNqPW1hitnKlYXOItBk/d8YQ==
X-Google-Smtp-Source: AGHT+IHNbQyj6+mHCs/scBX7rqIDKtIjCI5Qe+jbvEVFWGZhIBJKzoOvDyF7NvyL7m3U/GHewnPAGA==
X-Received: by 2002:a9d:739a:0:b0:6bc:f276:717f with SMTP id j26-20020a9d739a000000b006bcf276717fmr5539891otk.13.1693670389356;
        Sat, 02 Sep 2023 08:59:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p1-20020a25d801000000b00d7baaf6094asm1465838ybg.13.2023.09.02.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 08:59:48 -0700 (PDT)
Date:   Sat, 2 Sep 2023 08:59:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Ben Greear <greearb@candelatech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>
Subject: Re: Fwd: RCU indicates stalls with iwlwifi, causing boot failures
In-Reply-To: <f0f6a6ec-e968-a91c-dc46-357566d8811@google.com>
Message-ID: <35f03286-eb1-b7a4-8649-a43945223fe4@google.com>
References: <c1caa7c1-b2c6-aac5-54ab-8bcc6e139ca8@gmail.com> <c3f9b35c-087d-0e34-c251-e249f2c058d3@candelatech.com> <f0f6a6ec-e968-a91c-dc46-357566d8811@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023, Hugh Dickins wrote:

> Hi Dave,
> 
> On Fri, 1 Sep 2023, Ben Greear wrote:
> > On 9/1/23 5:29 PM, Bagas Sanjaya wrote:
> > > Hi,
> > > 
> > > I notice a bug report on Bugzilla [1]. Quoting from it:
> > 
> > Try booting with pcie=noaer ?
> > 
> > That fixes only known iwlwifi bug we have found in 6.5, but we are also using
> > mostly
> > backports iwlwifi driver...
> > 
> > Thanks,
> > Ben
> > 
> > > 
> > >> I'm seeing RCU warnings in Linus's current tree (like
> > >> 87dfd85c38923acd9517e8df4afc908565df0961) that come from RCU:
> > >>
> > >> WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_exp.h:787
> > >> rcu_exp_handler+0x35/0xe0
> > >>
> > >> But they *ONLY* occur on a system with a newer iwlwifi device:
> > >>
> > >> aa:00.0 Network controller: Intel Corporation Wi-Fi 6 AX210/AX211/AX411
> > >> 160MHz (rev 1a)
> > >>
> > >> and never in a VM or on an older device (like an 8260).  During a bisect
> > >> the only seem to occur with the "83" version of the firmware.
> > >>
> > >> iwlwifi 0000:aa:00.0: loaded firmware version 83.e8f84e98.0
> > >> ty-a0-gf-a0-83.ucode op_mode iwlmvm
> > >>
> > >> The first warning gets spit out within a millisecond of the last printk()
> > >> from the iwlwifi driver.  They eventually result in a big spew of RCU
> > >> messages like this:
> > >>
> > >> [   27.124796] rcu: INFO: rcu_preempt detected expedited stalls on
> > >> CPUs/tasks: { 0-...D } 125 jiffies s: 193 root: 0x1/.
> > >> [   27.126466] rcu: blocking rcu_node structures (internal RCU debug):
> > >> [   27.128114] Sending NMI from CPU 3 to CPUs 0:
> > >> [   27.128122] NMI backtrace for cpu 0 skipped: idling at
> > >> intel_idle+0x5f/0xb0
> > >> [   27.159757] loop30: detected capacity change from 0 to 8
> > >> [   27.204967] rcu: INFO: rcu_preempt detected expedited stalls on
> > >> CPUs/tasks: { 0-...D } 145 jiffies s: 193 root: 0x1/.
> > >> [   27.206353] rcu: blocking rcu_node structures (internal RCU debug):
> > >> [   27.207751] Sending NMI from CPU 3 to CPUs 0:
> > >> [   27.207825] NMI backtrace for cpu 0 skipped: idling at
> > >> intel_idle+0x5f/0xb0
> > >>
> > >> I usually see them at boot.  In that case, they usually hang the system and
> > >> keep it from booting.  I've also encountered them at reboots and also seen
> > >> them *not* be fatal at boot.  I suspect it has to do with which CPU gets
> > >> wedged.
> > > 
> > > See Bugzilla for the full thread and attached full dmesg output.
> > > 
> > > Thanks.
> > > 
> > > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217856
> 
> I just took a look at your dmesg in bugzilla: I see lots of page tables
> dumped, including "ESPfix Area", and think you're hitting my screwup: see
> 
> https://lore.kernel.org/linux-mm/CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com/
> 
> Please give the patch from the end of that thread a try:

Mikhail confirmed it for his case, and Linus already took it into his tree:
ee40d543e97d mm/pagewalk: fix bootstopping regression from extra pte_unmap()

But I couldn't see the WARN_ON_ONCE I was expecting from __rcu_read_unlock()
in your dmesg - ah, but it is only when CONFIG_PROVE_LOCKING is enabled.

Hugh

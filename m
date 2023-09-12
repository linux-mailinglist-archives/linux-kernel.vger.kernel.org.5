Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD32D79C70E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjILGiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjILGiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:38:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D1BE77
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:37:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C476216DC;
        Tue, 12 Sep 2023 06:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694500676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/iMs+ptgawKOXViIHlc/IyZEiOIVhHG2kbWyDW4Das4=;
        b=IcAbjPwb8dQXTD0bcfZaxuSMIOarHcVwj+AvuFG5XGoZ89zcF1M1yIgt62DdHT284tI0f6
        5MlmXf0MSjhVl5ZctSLsU13/ZkJRobup3xpRCDfJfwwLxAN1vZ6iBp6o68SSciv0/chYwu
        cIaMD/y5cldwQCK50piyfkWHXn7GD3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694500676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/iMs+ptgawKOXViIHlc/IyZEiOIVhHG2kbWyDW4Das4=;
        b=ZRQZheB1CxZqrQKIreGZ/tG12kTOnyw5Gb124em9HWjoN0m6n4TtCOnxb+T4+fxrqFMvAu
        mP6ABwZvuVfae/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E100139DB;
        Tue, 12 Sep 2023 06:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I+cTD0QHAGWHZQAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 12 Sep 2023 06:37:56 +0000
Date:   Tue, 12 Sep 2023 08:38:32 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>, g@flourine.lan
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <pzgeaisqmqz5up5fiorl46lmb6xglpdu4hp5lxotclnzvpfjrj@mgyfvcrvpl4x>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
 <20230905065032.GC19701@lst.de>
 <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to>
 <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw>
 <pti3xai6zkvitsqaw54sxut4lpb4qupo4c2n5alesb35ndhxv4@ni7ritoqopfe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pti3xai6zkvitsqaw54sxut4lpb4qupo4c2n5alesb35ndhxv4@ni7ritoqopfe>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > We have 3 association:
> > 
> >  assoc 0: systemd/udev triggered 'nvme connect-all' discovery controller
> >  assoc 1: discovery controller from nvme/005
> >  assoc 2: i/o controller from nvme/005
> 
> Actually, assoc 1 is also a i/o controller for the same hostnqn as assoc
> 2. This looks more like it assoc 0 and 1 are both from systemd/udev
> trigger. But why the heck is the hostnqn for assoc 1 the same as the
> hostnqn we use in blktests? Something is really off here.
> 
> The rest of my analysis is still valid.

I figured it out. I still used an older version nvme-cli which didn't
apply the hostnqn correctly. We fixed this in the meantime. With the
latest git version of nvme-cli the second I/O controller is not setup
anymore and the crash is gone. Though we still don't cleanup all
resources as the kernel module complains with

[41707.083039] nvmet_fc: nvmet_fc_exit_module: targetport list not empty

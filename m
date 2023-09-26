Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C817B7AE6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjIZH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjIZH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:26:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFED6FF;
        Tue, 26 Sep 2023 00:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BhD2k4kv2weMcWpVegjmwrLeUitKOOavmT6dEROSgKg=; b=sVFT0MJcIgXzs1t914uS8ZgrG1
        ZKVz5rYu2XpPkRgaSrZVw6J1Ssio9elzSxEegENXqhC9MgXmnx1U3zDgdsiFetWDwrZ+JvaLreNHm
        ikVjQkbdeEoD/ltBtrrdUWzQA4pffO6VcGXGHLZzRzopxjYtcpL7TB5DX6QMd6GUwIus85nPWjxfO
        c+G8vYNn2pAiTO0SJaDOIWyEuLCCfgUovb7xfY48dUMiK6AOXiqp7G09cucspXrhGk4Mic9Dr4Mhd
        qawZFAtFeHH4SkP0kfqF4JIu7418hwx4TPY3k9PWA3S43M9evo1YOIlIc0i50LxT9jvpW7wxnZ5Km
        VftH76vA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ql2Sg-00FnEn-1s;
        Tue, 26 Sep 2023 07:26:26 +0000
Date:   Tue, 26 Sep 2023 00:26:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        linux-kernel@vger.kernel.org, louhongxiang@huawei.com,
        lixiaokeng@huawei.com
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error
 handle mechanism
Message-ID: <ZRKHokGtOE/AgAFY@infradead.org>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <ZRGfc73BSW0yyUtI@infradead.org>
 <47bed3cb-f307-ec55-5c28-051687dab1ea@huawei.com>
 <a92f5e0c-1976-4fc6-ba48-7ff49546318a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a92f5e0c-1976-4fc6-ba48-7ff49546318a@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 12:54:48PM -0500, Mike Christie wrote:
> I think we want to figure out Hannes's patches first.

Yes.

> For a new EH design we will want to be able to do multiple TMFs in parallel
> on the same host/target right? 
> 
> The problem is that we need to be able to make forward progress in the EH
> path and not fail just because we can't allocate memory for a TMF related
> struct. To accomplish this now, drivers will use mempools, preallocate TMF
> related structs/mem/tags with their scsi_cmnd related structs, preallocate
> per host/target/device related structs or ignore what I wrote above and just
> fail.
> 
> Hannes's patches fix up the eh callouts so they don't pass in a scsi_cmnd
> when it's not needed. That seems nice because after that, then for your new
> EH we can begin to standardize on how to handle preallocation of drivers
> resources needed to perform TMFs for your new EH. It could be a per
> device/target/host callout to allow drivers to preallocate, then scsi-ml calls
> into the drivers with that data. It doesn't have to be exactly like that or
> anything close. It would be nice for drivers to not have to think about this
> type of thing and scsi-ml just to handle the resource management for us when
> there are multiple TMFs in progress.

Exactly!

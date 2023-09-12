Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE37C79CA1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjILIg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjILIgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:36:08 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9581171A;
        Tue, 12 Sep 2023 01:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694507721; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Gw0d+h526N2Vmbzt/Aevz1FfJ7C3rxN928egdaG/R8oMfGmB3dwxZbpz0ptziIHKM5p/xlAAGKQi9RzHhSnQvLNG8FNggV7pVrz/+ay9+EnIn1xUk5yqc+ltOcf9f5Dr80n86dgprm8kGsAPtevh6QXXr4LxU51i8NR0jTGMnD0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1694507721; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=z/F34U9ZK96H06nJ6P8/A58VT4YUuwixWK6ET3bTanc=; 
        b=UWvpEjy+ArW343wGZNrpMzg36ku7ZeuHZM8CUa3FyIX/U5s1KDrrWtSXaw5pr5vlPmTqyy1RfFkvpHrPuoGPlFgSlenuOTUmBsGRlWa5k2WaxOj+I17W6Fq3dNzlXJb5arLPE9H+r5y/p8ggo4CjOa+bv9sOUPffkF+AUz7Q7xI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1694507721;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=z/F34U9ZK96H06nJ6P8/A58VT4YUuwixWK6ET3bTanc=;
        b=NlBcJHtLU0c51jWi5tKfoAOb6RGQlCePvzm5rpIa4fFOHAB7RkfrKuzJNpRxP6q2
        DZ+Fn62v/ih2y5NSKZMXLTKtNY8EXflaSQntLtlBeT/Kb89z7pd/bxCG+3hrOjkCzMV
        J5UCn69RtM4MMhDkp24p7LcXwyWbvRRa/5EJu4XI=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1694507718909697.22466945198; Tue, 12 Sep 2023 01:35:18 -0700 (PDT)
Date:   Tue, 12 Sep 2023 05:35:19 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     syzbot <syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, dan.j.williams@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [block?] WARNING in blk_rq_map_user_iov
Message-ID: <20230912083519.e2yveio72emi7rd4@debian.org>
References: <0000000000009b92c10604d7a5e9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009b92c10604d7a5e9@google.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flag iter as the data source if dxfer_direction is set to
SG_DXFER_TO_DEV or SG_DXFER_TO_FROM_DEV.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 0d8afffd1683..991c6554bef4 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1737,8 +1737,13 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
        Sg_scatter_hold *rsv_schp = &sfp->reserve;
        struct request_queue *q = sfp->parentdp->device->request_queue;
        struct rq_map_data *md, map_data;
-       int rw = hp->dxfer_direction == SG_DXFER_TO_DEV ? ITER_SOURCE : ITER_DEST;
        struct scsi_cmnd *scmd;
+       int rw;
+       if (hp->dxfer_direction == SG_DXFER_TO_DEV ||
+           hp->dxfer_direction == SG_DXFER_TO_FROM_DEV)
+               rw = ITER_SOURCE;
+       else
+               rw = ITER_DEST;

        SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
                                      "sg_start_req: dxfer_len=%d\n",


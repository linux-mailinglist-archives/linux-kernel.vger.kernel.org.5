Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2467BC38F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 03:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjJGBSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 21:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjJGBSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:18:15 -0400
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F65B6;
        Fri,  6 Oct 2023 18:18:10 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4S2S6F6pBQz9xg1l;
        Sat,  7 Oct 2023 09:15:49 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 7 Oct
 2023 09:17:59 +0800
Date:   Sat, 7 Oct 2023 09:17:59 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
CC:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [RFC/REFACT] Refactoring and significantly reducing code
 complexity
Message-ID: <ZSCxxxMKoby6XWsg@fedora>
References: <ZRU/EjubEH/5QLlG@fedora>
 <ZRZk6tC6j1FtW3uY@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRZk6tC6j1FtW3uY@gauss3.secunet.de>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00603.xfusion.com (10.32.134.231) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 07:47:22AM +0200, Steffen Klassert wrote:
> On Thu, Sep 28, 2023 at 04:53:38PM +0800, Wang Jinchao wrote:
> > This is a refactored version with the following main changes:
> > 
> > - The parallel workqueue no longer uses the WQ_UNBOUND attribute
> > - Removal of CPU-related logic, sysfs-related interfaces
> > - removal of structures like padata_cpumask, and deletion of parallel_data
> > - Using completion to maintain sequencing
> > - no longer using lists
> > - removing structures like padata_list and padata_serial_queue
> > - Removal of padata_do_serial()
> 
> This removes all the logic that is needed to ensure that
> the parallelized objects return in the same order as
> they were before the parallelization. This change makes
> padata unusable for networking.

The RFC use the following three to ensure serial timing sequence:

1.  Use alloc_ordered_workqueue() to create a serial worker queue where 
    serial() function runs. This ensures that serial() function executes
    as serial work was enqueued using queue_work().
2.  Queue the serial work before enqueueing parallel work in padata_do_parallel().
    This ensures the serial work follows the same order as the padata_do_parallel().
3.  The serial work wait for completion of parallel_done, which will be 
    complete()ed after the parallel() function within the parallel work.

This is just a design idea, because I am not familiar with IPsec, I haven't 
tested it in a real network environment yet. 
Could you give me some clues on how to use pcrypt in an IPsec scenario?

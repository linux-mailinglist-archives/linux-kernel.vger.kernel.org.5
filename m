Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6497C6289
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjJLCGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjJLCGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:06:50 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C441F98;
        Wed, 11 Oct 2023 19:06:46 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4S5Xxw36Vvz9y7xl;
        Thu, 12 Oct 2023 10:04:20 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 12 Oct
 2023 10:06:40 +0800
Date:   Thu, 12 Oct 2023 10:06:40 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <stone.xulei@xfusion.com>
Subject: [RFC v2] padata: Simplify sysfs cpumask and sequencing logic
Message-ID: <202310121006-wangjinchao@xfusion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
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

Hi, 

I've identified several potential optimizations for padata.
I'd appreciate it if you could take a look at my ideas to
see if they are feasible.

Utilizing the WQ_SYSFS from workqueue to support sysfs
======================================================

Padata relies on workqueue, and since workqueue has already implemented
support for cpumask through WQ_SYSFS, we can reuse this functionality
and avoid redundant implementation.
Link: https://docs.kernel.org/core-api/workqueue.html#affinity-scopes

Using completion to ensure the sequencing of the 'serial()'
===========================================================

In the current implementation, to ensure the sequencing of 'serial()',
we've used seq_nr, reorder_list, padata_serial_queue, reorder_work...
which has made the logic quite complex. These operations can be
simplified by using 'completion'. Specifically:
    1. in padata_do_parallel()
       1. init_completion(parallel_done) **before** queue_work
       2. queue_work(serial_work)
    2. in padata_parallel_worker
       1. complete(parallel_done) **after** parallel(padata)
    3. in padata_serial_worker
       1. wait_for_completion(parallel_done) **before** serial(padata)

Here's a simplified code snippet:

```c
struct padata_priv {
	struct completion parallel_done;
	struct work_struct	parallel_work;
	struct work_struct	serial_work;
	void   (*parallel)(struct padata_priv *padata);
	void   (*serial)(struct padata_priv *padata);
}

void padata_do_parallel(struct padata_priv *padata)
{
    ...
    init_completion(&padata->parallel_done);
	queue_work(pinst->serial_wq, &padata->serial_work);
	queue_work(pinst->parallel_wq, &padata->parallel_work);
    ...
}

static void padata_parallel_worker(struct work_struct *parallel_work)
{
	struct padata_priv *padata =
		container_of(parallel_work, struct padata_priv, parallel_work);
	padata->parallel(padata);
	// notify serial_worker to do serial()
	complete(&padata->parallel_done);
}

static void padata_serial_worker(struct work_struct *serial_work)
{
	struct padata_priv *padata =
		container_of(serial_work, struct padata_priv, serial_work);
	wait_for_completion(&padata->parallel_done);
	padata->serial(padata);
}
```


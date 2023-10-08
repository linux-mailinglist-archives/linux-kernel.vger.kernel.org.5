Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72D37BCD1F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 09:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbjJHH6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 03:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjJHH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 03:58:37 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31727B9;
        Sun,  8 Oct 2023 00:58:32 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4S3Dxl1nCfz9xmcj;
        Sun,  8 Oct 2023 15:56:11 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 8 Oct
 2023 15:58:27 +0800
Date:   Sun, 8 Oct 2023 15:58:26 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
CC:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [RFC/REFACT] Refactoring and significantly reducing code
 complexity
Message-ID: <ZSJhIpRUPrT6Sag6@fedora>
References: <ZRU/EjubEH/5QLlG@fedora>
 <ZRZk6tC6j1FtW3uY@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRZk6tC6j1FtW3uY@gauss3.secunet.de>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00601.xfusion.com (10.32.135.241) To
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

Hello Steffen, 
I have constructed a scenario where parallel() time cost 
is forced to be reversed , and then ensured the order using serial(). 
The tests have passed on a 32-core machine. 
Can you please explain if my refactored approach guarantees the serial ordering?

Here is the code:

padata_test.c
--------------
```c
#include <linux/delay.h>
#include <linux/module.h>
#include <linux/padata.h>

struct request {
  struct padata_priv padata;
  int seq;
  struct completion done;
};

#define TEST_ARRAY_SIZE 200

#define PARALLEL_BASE_TIME 10

static int serial_cnt;
static int shuffled;
struct request requests[TEST_ARRAY_SIZE];
void parallel(struct padata_priv *padata) {
  struct request *req = container_of(padata, struct request, padata);

  // The smaller the req->seq number, the longer the delay time
  // creating a reverse order.
  mdelay((TEST_ARRAY_SIZE - req->seq) * PARALLEL_BASE_TIME);
  msleep((TEST_ARRAY_SIZE - req->seq) * PARALLEL_BASE_TIME);
}

void serial(struct padata_priv *padata) {
  struct request *req = container_of(padata, struct request, padata);
  if (req->seq != serial_cnt)
    shuffled = 1;
  serial_cnt++;
  complete(&req->done);
}

struct padata_instance *pinst;
struct padata_shell *ps;
static int __init padata_test_init(void) {
  serial_cnt = 0;
  shuffled = 0;
  pinst = padata_alloc("padata_test");
  if (!pinst)
    return -ENOMEM;

  ps = padata_alloc_shell(pinst);

  for (int i = 0; i < TEST_ARRAY_SIZE; i++) {
    requests[i].padata.parallel = parallel;
    requests[i].padata.serial = serial;
    requests[i].seq = i;
    init_completion(&requests[i].done);
  }

  for (int i = 0; i < TEST_ARRAY_SIZE; i++) {
    padata_do_parallel(ps, &requests[i].padata);
  }

  // only wait for the last one 
  // if they were not done serially
  // the serial_cnt will not be TEST_ARRAY_SIZE
  // there was a shuffering
  int last = TEST_ARRAY_SIZE - 1;
  wait_for_completion(&requests[last].done);
  if (serial_cnt != TEST_ARRAY_SIZE)
	shuffled = 1;
  
  printk(KERN_INFO "padata_test: shuffled %d serial_cnt %d\n", shuffled,
         serial_cnt);
  return 0;
}

static void __exit padata_test_exit(void) {
  padata_free_shell(ps);
  padata_free(pinst);
}

module_init(padata_test_init);
module_exit(padata_test_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("wangjinchao");
MODULE_DESCRIPTION("padata Test Module");
```

Makefile
---------
```makefile
obj-m += padata_test.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
```

run.sh
--------
```bash
make
dmesg -C
insmod padata_test.ko
rmmod padata_test
dmesg|grep serial_cnt
```

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639437CA557
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjJPK2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjJPK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:28:13 -0400
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D2AC;
        Mon, 16 Oct 2023 03:28:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id AA723207B0;
        Mon, 16 Oct 2023 12:28:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KMRYe7fo4lTH; Mon, 16 Oct 2023 12:28:08 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id DA4F8205DD;
        Mon, 16 Oct 2023 12:28:08 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
        by mailout2.secunet.com (Postfix) with ESMTP id D658480004A;
        Mon, 16 Oct 2023 12:28:08 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 12:28:08 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 16 Oct
 2023 12:28:08 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id CCD7F3182C75; Mon, 16 Oct 2023 12:28:07 +0200 (CEST)
Date:   Mon, 16 Oct 2023 12:28:07 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
CC:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [RFC/REFACT] Refactoring and significantly reducing code
 complexity
Message-ID: <ZS0QNxbtXPgPH1j2@gauss3.secunet.de>
References: <ZRU/EjubEH/5QLlG@fedora>
 <ZRZk6tC6j1FtW3uY@gauss3.secunet.de>
 <ZSCxxxMKoby6XWsg@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZSCxxxMKoby6XWsg@fedora>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:17:59AM +0800, Wang Jinchao wrote:
> On Fri, Sep 29, 2023 at 07:47:22AM +0200, Steffen Klassert wrote:
> > On Thu, Sep 28, 2023 at 04:53:38PM +0800, Wang Jinchao wrote:
> > > This is a refactored version with the following main changes:
> > > 
> > > - The parallel workqueue no longer uses the WQ_UNBOUND attribute
> > > - Removal of CPU-related logic, sysfs-related interfaces
> > > - removal of structures like padata_cpumask, and deletion of parallel_data
> > > - Using completion to maintain sequencing
> > > - no longer using lists
> > > - removing structures like padata_list and padata_serial_queue
> > > - Removal of padata_do_serial()
> > 
> > This removes all the logic that is needed to ensure that
> > the parallelized objects return in the same order as
> > they were before the parallelization. This change makes
> > padata unusable for networking.
> 
> The RFC use the following three to ensure serial timing sequence:
> 
> 1.  Use alloc_ordered_workqueue() to create a serial worker queue where 
>     serial() function runs. This ensures that serial() function executes
>     as serial work was enqueued using queue_work().
> 2.  Queue the serial work before enqueueing parallel work in padata_do_parallel().
>     This ensures the serial work follows the same order as the padata_do_parallel().
> 3.  The serial work wait for completion of parallel_done, which will be 
>     complete()ed after the parallel() function within the parallel work.

I had a closer look to the padata codebase now. The logic to
parallelize/serialize changed quite a bit since I wrote padata
initially. I don't understand the new logic completely,
so we need to rely on Daniels review for this.

> This is just a design idea, because I am not familiar with IPsec, I haven't 
> tested it in a real network environment yet. 
> Could you give me some clues on how to use pcrypt in an IPsec scenario?

pcrypt has performance gains if the cost of the crypto
oreration is higher than the cost of moving the crypto
request to another cpu. That was the case back in the
days, but the situation changed since then. We now have
hardware support for crypto, like aes-ni etc.
So for hardware supported algorithms, pcrypt will not
help much. But it is still interesting for crypto
algorithms that are implemented in software only.

Here is how you can instantiate a pcrypted
algorithm:

----------------------------------------------------
You need to instantiate pcrypt before you can use it.

You need either crconf or the tcrypt module to instantiate pcrypt.

With crconf:

You can get crconf from https://sourceforge.net/projects/crconf/
After installing crconf do e.g.

crconf add driver "pcrypt(authenc(hmac(sha1-generic),cbc(aes-asm)))" type 3


With tcrypt:

modprobe tcrypt alg="pcrypt(authenc(hmac(sha1-generic),cbc(aes-asm)))" type=3

The modprobe will return with an error, don't worry about it, that's ok.



Once you've did one of the above, your /proc/crypto should show
something like:

name         : authenc(hmac(sha1),cbc(aes))
driver       : pcrypt(authenc(hmac(sha1-generic),cbc(aes-asm)))
module       : pcrypt
priority     : 2100
refcnt       : 1
selftest     : passed
type         : aead
async        : yes
blocksize    : 16
ivsize       : 16
maxauthsize  : 20
geniv        : <built-in>


Now pcrypt is instantiated, e.g. all new IPsec states (that do
hmac-sha1, cbc-aes) will use it.


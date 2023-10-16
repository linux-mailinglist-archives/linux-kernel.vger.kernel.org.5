Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86E47CA601
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjJPKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjJPKrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:47:35 -0400
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CDEB4;
        Mon, 16 Oct 2023 03:47:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 712DF207BB;
        Mon, 16 Oct 2023 12:47:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XuE_aQheVAQ2; Mon, 16 Oct 2023 12:47:30 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id E660620728;
        Mon, 16 Oct 2023 12:47:30 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
        by mailout1.secunet.com (Postfix) with ESMTP id DF4DB80004A;
        Mon, 16 Oct 2023 12:47:30 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 12:47:30 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 16 Oct
 2023 12:47:30 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id D28A23182C75; Mon, 16 Oct 2023 12:47:29 +0200 (CEST)
Date:   Mon, 16 Oct 2023 12:47:29 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
CC:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [RFC/REFACT] Refactoring and significantly reducing code
 complexity
Message-ID: <ZS0UwakMZpKLbsbZ@gauss3.secunet.de>
References: <ZRU/EjubEH/5QLlG@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRU/EjubEH/5QLlG@fedora>
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

Hi,

On Thu, Sep 28, 2023 at 04:53:38PM +0800, Wang Jinchao wrote:
> This is a refactored version with the following main changes:
> 
> - The parallel workqueue no longer uses the WQ_UNBOUND attribute
> - Removal of CPU-related logic, sysfs-related interfaces
> - removal of structures like padata_cpumask, and deletion of parallel_data
> - Using completion to maintain sequencing
> - no longer using lists
> - removing structures like padata_list and padata_serial_queue
> - Removal of padata_do_serial()
> - padata automatically ensures the calling sequence.
> 
> Testing was conducted using ltp's pcrypt_aead01, and the execution time
> comparison between the old and new versions is as follows:
> 
> Old Version:
> real 0m27.451s
> user 0m0.031s
> sys 0m0.260s
> 
> New Version:
> real 0m21.351s
> user 0m0.023s
> sys 0m0.260s
> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
>  crypto/pcrypt.c        |  34 +-
>  include/linux/padata.h |  95 +----
>  kernel/padata.c        | 815 ++---------------------------------------
>  3 files changed, 43 insertions(+), 901 deletions(-)

...

>  
> -static int pcrypt_sysfs_add(struct padata_instance *pinst, const char *name)
> -{
> -	int ret;
> -
> -	pinst->kobj.kset = pcrypt_kset;
> -	ret = kobject_add(&pinst->kobj, NULL, "%s", name);
> -	if (!ret)
> -		kobject_uevent(&pinst->kobj, KOBJ_ADD);
> -
> -	return ret;
> -}

Users might rely on the existence of that sysfs files,
so removing this might be dangerous.

>  static void padata_serial_worker(struct work_struct *serial_work)
>  {
> -	struct padata_serial_queue *squeue;
> -	struct parallel_data *pd;
> -	LIST_HEAD(local_list);
> -	int cnt;
> -
> -	local_bh_disable();

Note that the networking RX path must run with BHs off.
The call to padata_do_parallel might come with BHs off
and the serialization callback should also called with
BHs off.

Please make sure that the networking usecase continues
to work with that refactorization.

Thanks!

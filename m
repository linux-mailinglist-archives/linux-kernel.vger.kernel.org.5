Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372827ED5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjKOVSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344707AbjKOVSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:18:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01259196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700083088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+AAJRoNFb+NoS3KMWG2rvbhxYwWgV66EeFRyHv0H4g=;
        b=ftgLBid28JQRPq1c4ji0Md/PI2GqDHKn0yJ0c669IPw1vaC61YWoAyVYkyAP3k8qF3MSwW
        L53cxIkjBxubpykmwHa2mBDYKob4ICvLScoxjbPyXF6UN4mZHu0TkwC9VF2JBr2/GgiccQ
        o2gXbuKnxkOjhPCy560eo2nTjHtMLwE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-8rha03oRNsqcXim3L5cd9Q-1; Wed, 15 Nov 2023 16:18:03 -0500
X-MC-Unique: 8rha03oRNsqcXim3L5cd9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB46085CBE1;
        Wed, 15 Nov 2023 21:18:01 +0000 (UTC)
Received: from [10.22.9.184] (unknown [10.22.9.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24A9B40C6EB9;
        Wed, 15 Nov 2023 21:18:01 +0000 (UTC)
Message-ID: <6c4ac1fb-f53a-496b-bab6-07e70c2197c7@redhat.com>
Date:   Wed, 15 Nov 2023 16:18:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] workqueue: Make workqueue_set_unbound_cpumask()
 static
To:     kernel test robot <lkp@intel.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Peter Hunt <pehunt@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20231115170359.163299-2-longman@redhat.com>
 <202311160353.FAdfQwO3-lkp@intel.com>
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <202311160353.FAdfQwO3-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/23 14:12, kernel test robot wrote:
> Hi Waiman,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on shuah-kselftest/next]
> [also build test WARNING on shuah-kselftest/fixes linus/master v6.7-rc1]
> [cannot apply to tj-cgroup/for-next tj-wq/for-next next-20231115]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/workqueue-Make-workqueue_set_unbound_cpumask-static/20231116-010940
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
> patch link:    https://lore.kernel.org/r/20231115170359.163299-2-longman%40redhat.com
> patch subject: [PATCH v3 1/5] workqueue: Make workqueue_set_unbound_cpumask() static
> config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20231116/202311160353.FAdfQwO3-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160353.FAdfQwO3-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311160353.FAdfQwO3-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> kernel/workqueue.c:4421:13: warning: 'apply_wqattrs_unlock' defined but not used [-Wunused-function]
>      4421 | static void apply_wqattrs_unlock(void)
>           |             ^~~~~~~~~~~~~~~~~~~~
>>> kernel/workqueue.c:4414:13: warning: 'apply_wqattrs_lock' defined but not used [-Wunused-function]
>      4414 | static void apply_wqattrs_lock(void)
>           |             ^~~~~~~~~~~~~~~~~~
>
>
> vim +/apply_wqattrs_unlock +4421 kernel/workqueue.c
>
> 8864b4e59f7945 Tejun Heo                 2013-03-12  4413
> a0111cf6710bd1 Lai Jiangshan             2015-05-19 @4414  static void apply_wqattrs_lock(void)
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4415  {
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4416  	/* CPUs should stay stable across pwq creations and installations */
> ffd8bea81fbb5a Sebastian Andrzej Siewior 2021-08-03  4417  	cpus_read_lock();
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4418  	mutex_lock(&wq_pool_mutex);
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4419  }
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4420
> a0111cf6710bd1 Lai Jiangshan             2015-05-19 @4421  static void apply_wqattrs_unlock(void)
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4422  {
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4423  	mutex_unlock(&wq_pool_mutex);
> ffd8bea81fbb5a Sebastian Andrzej Siewior 2021-08-03  4424  	cpus_read_unlock();
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4425  }
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4426
>
OK, there are more functions that are CONFIG_SYSFS specific and need to 
be moved as well.

Will post another version to fix that :-(

Regards,
Longman


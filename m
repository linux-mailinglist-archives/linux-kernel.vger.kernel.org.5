Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6A777F8DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351873AbjHQO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351871AbjHQO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B433E2701
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692282352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YU1kedm3s1a6B75XQIpxvCnkzuYPmtz40YLYh/uOwp8=;
        b=F7UVjKTPH5vwRiTxxVv5IhQY4q/1Tcod7ap72RJGc5Ruirf6xwk0XzAFULKAD78goyileP
        U0n9HtfsZ6/bYJ3IIQV7eXfZh6qvhpyjvAzsnIgxowTUsdbabREMVk8QsFyLnWr8ARC3jB
        dJTYoqCdMZZyoQnngqg8fNZcx2Y3y/8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-mm_4aXBWMsOBdnAGOrWyqg-1; Thu, 17 Aug 2023 10:25:50 -0400
X-MC-Unique: mm_4aXBWMsOBdnAGOrWyqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A1B029AA3B0;
        Thu, 17 Aug 2023 14:25:46 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EBEC1121314;
        Thu, 17 Aug 2023 14:25:46 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
Subject: Re: [PATCH] drivers: nvdimm: fix dereference after free
References: <20230817114103.754977-1-konstantin.meskhidze@huawei.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 17 Aug 2023 10:31:33 -0400
In-Reply-To: <20230817114103.754977-1-konstantin.meskhidze@huawei.com>
        (Konstantin Meskhidze's message of "Thu, 17 Aug 2023 19:41:03 +0800")
Message-ID: <x49jzttu4e2.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Meskhidze <konstantin.meskhidze@huawei.com> writes:

> 'nd_pmu->pmu.attr_groups' is dereferenced in function
> 'nvdimm_pmu_free_hotplug_memory' call after it has been freed. Because in
> function 'nvdimm_pmu_free_hotplug_memory' memory pointed by the fields of
> 'nd_pmu->pmu.attr_groups' is deallocated it is necessary to call 'kfree'
> after 'nvdimm_pmu_free_hotplug_memory'.
>
> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
>  drivers/nvdimm/nd_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
> index 14881c4e0..2b6dc80d8 100644
> --- a/drivers/nvdimm/nd_perf.c
> +++ b/drivers/nvdimm/nd_perf.c
> @@ -307,10 +307,10 @@ int register_nvdimm_pmu(struct nvdimm_pmu *nd_pmu, struct platform_device *pdev)
>  	}
>  
>  	rc = perf_pmu_register(&nd_pmu->pmu, nd_pmu->pmu.name, -1);
>  	if (rc) {
> -		kfree(nd_pmu->pmu.attr_groups);
>  		nvdimm_pmu_free_hotplug_memory(nd_pmu);
> +		kfree(nd_pmu->pmu.attr_groups);
>  		return rc;
>  	}
>  
>  	pr_info("%s NVDIMM performance monitor support registered\n",

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9577F8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351887AbjHQO15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351896AbjHQO1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BAF2D76
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692282398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xSwgi5nYOBKBG7F7dJg6g/1QY293MG0NVMQDEeBbj4I=;
        b=J9LaFo3X8xEMZudJ7XLtG5uandQ0s4gWYGQJisNyBHgT03LSkRYshkQ7bfjm9Z4P2IS2eW
        0KgRjbZChg7RKG/gL7vKh+OB0DbriCI5/RFqirHx19c7VZWW1eN0/TlNptHGZ4uRVhU7gx
        /xnZM731rO274KIix6n/Q9maewK40Rs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-zvqiTbbjOpm7aV8XX542Tw-1; Thu, 17 Aug 2023 10:26:32 -0400
X-MC-Unique: zvqiTbbjOpm7aV8XX542Tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 366491C07842;
        Thu, 17 Aug 2023 14:26:32 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F27140E950;
        Thu, 17 Aug 2023 14:26:31 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
Subject: Re: [PATCH] drivers: nvdimm: fix memleak
References: <20230817115945.771826-1-konstantin.meskhidze@huawei.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 17 Aug 2023 10:32:19 -0400
In-Reply-To: <20230817115945.771826-1-konstantin.meskhidze@huawei.com>
        (Konstantin Meskhidze's message of "Thu, 17 Aug 2023 19:59:45 +0800")
Message-ID: <x49fs4hu4cs.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> Memory pointed by 'nd_pmu->pmu.attr_groups' is allocated in function
> 'register_nvdimm_pmu' and is lost after 'kfree(nd_pmu)' call in function
> 'unregister_nvdimm_pmu'.
>
> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
>  drivers/nvdimm/nd_perf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
> index 433bbb68a..14881c4e0 100644
> --- a/drivers/nvdimm/nd_perf.c
> +++ b/drivers/nvdimm/nd_perf.c
> @@ -323,7 +323,8 @@ EXPORT_SYMBOL_GPL(register_nvdimm_pmu);
>  void unregister_nvdimm_pmu(struct nvdimm_pmu *nd_pmu)
>  {
>  	perf_pmu_unregister(&nd_pmu->pmu);
>  	nvdimm_pmu_free_hotplug_memory(nd_pmu);
> +	kfree(nd_pmu->pmu.attr_groups);
>  	kfree(nd_pmu);
>  }
>  EXPORT_SYMBOL_GPL(unregister_nvdimm_pmu);

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54447D5043
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjJXMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjJXMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF590
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698151776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVRePymm5LlGxEOZU5dUiW35O7/1kIgQIOIIucxo4g8=;
        b=YpJQScyOjO40HPEN+Rit4n0M2Gi72tk9I1FrlYpb6F6fg7mReeTwIkGo2Tkr9QpKlmQa5g
        mj4L8oOKmIaq0iW8ajHNvsTXDWCFnUMH9cTKlAY23qN1KNO1cxcsY8VoNtHIqdYkynOznF
        SRr5x5FWRlJC+BNOYo/w5YLz7qftYTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-vJLQkFovPimUQaMJtn9_zQ-1; Tue, 24 Oct 2023 08:49:22 -0400
X-MC-Unique: vJLQkFovPimUQaMJtn9_zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23920185A790;
        Tue, 24 Oct 2023 12:49:22 +0000 (UTC)
Received: from [10.43.2.183] (unknown [10.43.2.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6D9B2166B26;
        Tue, 24 Oct 2023 12:49:20 +0000 (UTC)
Message-ID: <349d8eb5-b499-45ea-8de5-2c3658d4c446@redhat.com>
Date:   Tue, 24 Oct 2023 14:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i40e: Do not call devlink_port_type_clear()
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
References: <20231024124245.837908-1-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20231024124245.837908-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24. 10. 23 14:42, Ivan Vecera wrote:
> Do not call devlink_port_type_clear() prior devlink port unregister
> and let devlink core to take care about it.
> 
> Reproducer:
> [root@host ~]# rmmod i40e
> [ 4539.964699] i40e 0000:02:00.0: devlink port type for port 0 cleared without a software interface reference, device type not supported by the kernel?
> [ 4540.319811] i40e 0000:02:00.1: devlink port type for port 1 cleared without a software interface reference, device type not supported by the kernel?
> 
> Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_devlink.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> index 74bc111b4849..cc4e9e2addb7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> @@ -231,6 +231,5 @@ int i40e_devlink_create_port(struct i40e_pf *pf)
>    **/
>   void i40e_devlink_destroy_port(struct i40e_pf *pf)
>   {
> -	devlink_port_type_clear(&pf->devlink_port);
>   	devlink_port_unregister(&pf->devlink_port);
>   }

Please drop... there is missing net-next target.
Will post v2.

Ivan


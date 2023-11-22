Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EBC7F4301
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbjKVJ7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjKVJ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:59:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D934649E6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700647142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZCjzWXii4u28sN5GkNkdatJx6cXmhKIdL34C9BKN+9E=;
        b=irmIYQvZJoEP3caUUf7WJXk4Hj8oEQhydDHvTJ33uZcM6V9MOBFvMc9k/LYi+1DDod4JOA
        Mtng72DI7t78J3HpSFWEf44vWCucbz5EGsfb4bBpCYxJ4UoqefnypXscGxU+sBtfGv2bg5
        +qXWeTeDcUcMp8bhgMy5SwwAqwl1xBU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-QhcexgQrPJyp37D1Ovkadw-1; Wed,
 22 Nov 2023 04:58:56 -0500
X-MC-Unique: QhcexgQrPJyp37D1Ovkadw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 322863810B1A;
        Wed, 22 Nov 2023 09:58:56 +0000 (UTC)
Received: from [10.45.226.4] (unknown [10.45.226.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11EE82026D4C;
        Wed, 22 Nov 2023 09:58:53 +0000 (UTC)
Message-ID: <48330ace-2b5f-4919-b5cb-7ac4372120bf@redhat.com>
Date:   Wed, 22 Nov 2023 10:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 3/5] i40e: Add helpers to find VSI and VEB by
 SEID and use them
To:     Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Simon Horman <horms@kernel.org>, mschmidt@redhat.com,
        netdev@vger.kernel.org
References: <20231116152114.88515-1-ivecera@redhat.com>
 <20231116152114.88515-4-ivecera@redhat.com>
 <f90bc4fc-d9e3-468c-8b94-73bea4b2d764@intel.com>
Content-Language: en-US
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <f90bc4fc-d9e3-468c-8b94-73bea4b2d764@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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



On 22. 11. 23 0:05, Tony Nguyen wrote:
> 
> 
> On 11/16/2023 7:21 AM, Ivan Vecera wrote:
> 
>> @@ -13197,17 +13193,14 @@ static int i40e_ndo_bridge_getlink(struct 
>> sk_buff *skb, u32 pid, u32 seq,
>>       struct i40e_vsi *vsi = np->vsi;
>>       struct i40e_pf *pf = vsi->back;
>>       struct i40e_veb *veb = NULL;
>> -    int i;
>>       /* Only for PF VSI for now */
>>       if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
>>           return -EOPNOTSUPP;
>>       /* Find the HW bridge for the PF VSI */
>> -    i40e_pf_for_each_veb(pf, i, veb)
>> -        if (veb->seid == vsi->uplink_seid)
>> -            break;
>> -    if (i == I40E_MAX_VEB)
>> +    veb = i40e_pf_get_veb_by_seid(pf, vsi->uplink_seid);
>> +    if (!vsi)
>>           return 0;
> 
> In addition to the kdoc stuff that Simon pointed out. Should this null 
> check be against veb?
> 
Oops, the check should be against veb here not aganst vsi...
Good eyes, Tony. Thanks, I will fix this.

Ivan


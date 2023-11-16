Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E633F7EE334
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbjKPOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344290AbjKPOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6350ED4D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700145976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTqorEhdT7DMAGJHmu4VBxw/55IAIeOOpj+g7xYY/4M=;
        b=KYsQLL0gLErIukqGFtWdjITckMilUnvKWq4cRw45yApgrBBt/wy2Wt55H5NtVOKxRXQcLy
        y3P4PVKZm/uIrEhzgDnpVheJBuIsnXlV+hwSraql7R0U+/AnXXxoZyq9zu3jP8AkmIRD76
        YpvX22Halkdwy8gcs1xbzU54/jE1Vrg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-yg6dT8FlPhCvECEC6khXCA-1; Thu, 16 Nov 2023 09:46:11 -0500
X-MC-Unique: yg6dT8FlPhCvECEC6khXCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34E38185A784;
        Thu, 16 Nov 2023 14:46:10 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 899882166B28;
        Thu, 16 Nov 2023 14:46:08 +0000 (UTC)
Message-ID: <2332ea8b-16d9-402f-8be6-683e52c6758e@redhat.com>
Date:   Thu, 16 Nov 2023 15:46:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 3/5] i40e: Add helpers to find VSI and VEB by
 SEID and use them
Content-Language: en-US
To:     Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>, mschmidt@redhat.com
References: <20231113125856.346047-1-ivecera@redhat.com>
 <20231113125856.346047-4-ivecera@redhat.com>
 <3c640be7-8f1e-4f9e-8556-3aac92644dec@intel.com>
 <36889885-71c7-46f7-8c21-e5791986ad5a@redhat.com>
 <72250942-17af-4f8d-b11f-ba902fbe2b58@intel.com>
 <483acf53-fe96-4ef3-933a-c5fd446042f6@redhat.com>
 <f307b4f1-4dff-4925-829f-20459d25bdcf@intel.com>
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <f307b4f1-4dff-4925-829f-20459d25bdcf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16. 11. 23 15:21, Wojciech Drewek wrote:
>>> Sounds good, my point was that I prefer to have "get" before "{veb|vsi}"
>> OK, got it... Will repost v2 with this change + "too many also..." issue 😉
> Thanks
> 
>> Btw. what about the last patch?
> Reviewed 🙂

Thanks, Wojciech! But I already submitted v2 of the series...but without 
your 'Reviewed-by:' tag in patch 5. Could you please "review" the v2 of 
patch 5 again?

Thanks,
Ivan


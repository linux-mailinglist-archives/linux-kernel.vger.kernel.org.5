Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46E7AFBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjI0HJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjI0HJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3698DD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695798499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kaLfJmtB6MqdF1sxC45vDWpKHYD0ArvO2N0519Wf3c=;
        b=KosUzUhHwJAOdYxTMf5qAJZNs9nM7CCReNDb6P1a7CPYun5N0wbXEGqzxpEd6NyTmI0wYQ
        TM7FR6H6C0/44e+ng2I5+D4W1/WsBe9EFidN2ax8sFVVRkPNptBOgAp6LXUszBriB54WiL
        sLv82i50aDizNQfBzXDSN82Qmp5df00=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-polHlrETPIugM8oCdkdXCA-1; Wed, 27 Sep 2023 03:08:16 -0400
X-MC-Unique: polHlrETPIugM8oCdkdXCA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0605F3C0C4A0;
        Wed, 27 Sep 2023 07:08:16 +0000 (UTC)
Received: from [10.45.225.119] (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D90D492B16;
        Wed, 27 Sep 2023 07:08:14 +0000 (UTC)
Message-ID: <16cc3132-9d2c-04de-51b6-88e4476b4d26@redhat.com>
Date:   Wed, 27 Sep 2023 09:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 7/9] i40e: Move memory allocation structures to
 i40e_alloc.h
Content-Language: en-US
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20230926182710.2517901-1-ivecera@redhat.com>
 <20230926182710.2517901-8-ivecera@redhat.com>
 <f17ed43b-7329-5566-a75e-befebd20d032@intel.com>
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <f17ed43b-7329-5566-a75e-befebd20d032@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26. 09. 23 21:57, Przemek Kitszel wrote:
> On 9/26/23 20:27, Ivan Vecera wrote:
>> Structures i40e_dma_mem & i40e_virt_mem are defined i40e_osdep.h while
>> memory allocation functions that use them are declared in i40e_alloc.h
>> Move them to i40e_alloc.h and remove this header file dependency on
>> i40e_osdep.h header.
>>
>> Due to removal of this dependency we have to include i40e_osdep.h in 
>> files
>> that requires it.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_adminq.c |  1 +
>>   drivers/net/ethernet/intel/i40e/i40e_adminq.h |  2 +-
>>   drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 21 ++++++++++++++++++-
>>   drivers/net/ethernet/intel/i40e/i40e_common.c |  1 +
>>   drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  1 +
>>   drivers/net/ethernet/intel/i40e/i40e_diag.c   |  1 +
>>   drivers/net/ethernet/intel/i40e/i40e_hmc.c    |  1 +
>>   drivers/net/ethernet/intel/i40e/i40e_hmc.h    |  2 +-
>>   .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  1 +
>>   drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  1 +
>>   drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 19 -----------------
>>   11 files changed, 29 insertions(+), 22 deletions(-)
> 
> I very much like this series, but extending i40e_osdep.h usage asks for 
> comment 😉 - please try to reorder patches to have less dependency on it 
> first, and afterwards do split
> (IOW first remove&reduce, then split what's left)
> 
> (disclaimer: I have not double checked if that's possible)

I will move the patch 5 after i40e_osdep split and memory allocation 
clean-up patches. This should simplify the changes.

Thanks for comment...

Ivan


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266D47EE3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbjKPPCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbjKPPCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6206AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700146927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6L7tI+K8yZDrsftYj6Ia4FnBkfs6t8tIYhpG29gA3U=;
        b=cGTx3eyIPvh9Ze8zxRW+NlcKuVbRYBhOBMMZhXA/ksI2Nx4ZOq2ebAnAbH06UVfnqpxPCU
        Fphfe7fp0RgCr8+D+D4KtSsC28Nx8HmsXf6W5szR8ZSJ95/FLA/EOAGFrBniAekpAGFVCU
        M+TnQOiviSgqAEgSChKjDRR/kjwSEZo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-3hkXgPN0PXqpqicqpF-54g-1; Thu,
 16 Nov 2023 10:02:01 -0500
X-MC-Unique: 3hkXgPN0PXqpqicqpF-54g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 737161C0651B;
        Thu, 16 Nov 2023 15:01:56 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C14265028;
        Thu, 16 Nov 2023 15:01:54 +0000 (UTC)
Message-ID: <c14fc17e-95a7-47be-86c5-e1c889ea627e@redhat.com>
Date:   Thu, 16 Nov 2023 16:01:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/5] i40e: Simplify VSI and VEB handling
Content-Language: en-US
From:   Ivan Vecera <ivecera@redhat.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Simon Horman <horms@kernel.org>, mschmidt@redhat.com,
        netdev@vger.kernel.org
References: <20231116144119.78769-1-ivecera@redhat.com>
In-Reply-To: <20231116144119.78769-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

On 16. 11. 23 15:41, Ivan Vecera wrote:
> The series simplifies handling of VSIs and VEBs by introducing for-each
> iterating macros, 'find' helper functions. Also removes the VEB
> recursion because the VEBs cannot have sub-VEBs according datasheet and
> fixes the support for floating VEBs.
> 
> The series content:
> Patch 1 - Uses existing helper function for find FDIR VSI instead of loop
> Patch 2 - Adds and uses macros to iterate VSI and VEB arrays
> Patch 3 - Adds 2 helper functions to find VSIs and VEBs by their SEID
> Patch 4 - Fixes broken support for floating VEBs
> Patch 5 - Removes VEB recursion and simplifies VEB handling
> 
> Changelog:
> v1->v2 - small correction in patch 4 description
>         - changed helper names in patch 3
> 
> Ivan Vecera (5):
>    i40e: Use existing helper to find flow director VSI
>    i40e: Introduce and use macros for iterating VSIs and VEBs
>    i40e: Add helpers to find VSI and VEB by SEID and use them
>    i40e: Fix broken support for floating VEBs
>    i40e: Remove VEB recursion
> 
>   drivers/net/ethernet/intel/i40e/i40e.h        |  91 ++-
>   drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
>   .../net/ethernet/intel/i40e/i40e_debugfs.c    |  97 ++-
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 563 ++++++++----------
>   4 files changed, 371 insertions(+), 390 deletions(-)
> 

Oops, wrong files submitted... Apologies, please forget about this (v2) 
series.

Ivan


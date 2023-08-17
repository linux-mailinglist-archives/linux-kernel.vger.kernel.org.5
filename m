Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C2677F9B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352318AbjHQOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352295AbjHQOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:52:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA12FBF;
        Thu, 17 Aug 2023 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wYEcyK46K6KN9IIi0RnZeATO9I6pLm4XjX5dQ7B0Nws=; b=3D1BJw0TbO+uh99t4IPtzRJYVV
        PkVR5R8XjKuFSvfoUrZxbUfdehUeELlZHQOG6lN1uJMfLngnfLswZ0n144vNIWwCfppUd6Bn1wBna
        ufjHuFM3vU/FkHA/3skCuXnzUFNjXpZsPJvN+V75G1k3fAkMIQvjm/Rc5HGiEcidZkrOSrPRYm1ke
        crOexaePXayA81TG+qVn4g+ocK4vqGp5Pr3OBkyz1YZniI0Ajuyo5KsQk9Awrt5g0fJV5pQyjCUqj
        ErKBzSV6W15nnIPEL6YPA/ieDeTp41UmOEiRfP2CRTioeWXO6sbhpS3yy27cX+OZo5NhA5k66zmuj
        a1bicnfA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWeLs-006bSc-2I;
        Thu, 17 Aug 2023 14:51:56 +0000
Message-ID: <79ac6ee9-247a-c3da-c0f7-8c26bd0b1ad0@infradead.org>
Date:   Thu, 17 Aug 2023 07:51:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] scsi: sli4: Remove the buggy code
Content-Language: en-US
To:     Dmitry Bogdanov <d.bogdanov@yadro.com>, coolrrsh@gmail.com
Cc:     james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230817103751.16350-1-coolrrsh@gmail.com>
 <20230817105252.GA14370@yadro.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230817105252.GA14370@yadro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 03:52, Dmitry Bogdanov wrote:
> On Thu, Aug 17, 2023 at 04:07:51PM +0530, coolrrsh@gmail.com wrote:
>>
>> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
>>
>> In the function sli_xmit_bls_rsp64_wqe, the 'if' and 'else' conditions
>> evaluates the same expression and gives same output. Also the variable
>> bls->local_n_port_id_dword is not used anywhere. Therefore removing the
>> redundant code.
>>
>> This fixes coccinelle warning such as:
>> drivers/scsi/elx/libefc_sli/sli4.c:2320:2-4: WARNING: possible
>> condition with no effect (if == else)
>>
>> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
>> ---
>> v1->v2
>> Modified patch and verified with checkpatch.pl.
>>
>> ---
>>  drivers/scsi/elx/libefc_sli/sli4.c | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
>> index 8f96049f62dd..af661b769464 100644
>> --- a/drivers/scsi/elx/libefc_sli/sli4.c
>> +++ b/drivers/scsi/elx/libefc_sli/sli4.c
>> @@ -2317,13 +2317,6 @@ sli_xmit_bls_rsp64_wqe(struct sli4 *sli, void *buf,
>>                 SLI4_GENERIC_CONTEXT_VPI << SLI4_BLS_RSP_WQE_CT_SHFT;
>>                 bls->context_tag = cpu_to_le16(params->vpi);
>>
>> -               if (params->s_id != U32_MAX)
>> -                       bls->local_n_port_id_dword |=
>> -                               cpu_to_le32(params->s_id & 0x00ffffff);
>> -               else
>> -                       bls->local_n_port_id_dword |=
>> -                               cpu_to_le32(params->s_id & 0x00ffffff);
>> -
> 
> omg, it is not an unused variable. Whole bls is a HW descriptor, all of
> its variables are used by HW. You should keep v1 version of the patch.
> According to the comment at the beginning of the funciton s_id here shall
> be != U32_MAX. That is an explanation for your v1 patch.
> 

Thanks for your comments.

>>                 dw_ridflags = (dw_ridflags & ~SLI4_BLS_RSP_RID) |
>>                                (params->d_id & SLI4_BLS_RSP_RID);
>>
>> --
>> 2.25.1
>>

-- 
~Randy

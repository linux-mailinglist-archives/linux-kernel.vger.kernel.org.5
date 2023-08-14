Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE97177C25A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjHNVZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjHNVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:24:56 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A241B3;
        Mon, 14 Aug 2023 14:24:55 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bc0d39b52cso29271565ad.2;
        Mon, 14 Aug 2023 14:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692048294; x=1692653094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BGNJ1wYN6ojM0i0zFLZLRwlrzp2MOiM8IvepgrLINg=;
        b=VDCf23GHRKzHLBG/Jbq5jPExyy/7KOwWN2rm3Dn8/iiLjjQJxsfy8uIWMLJ0Z9GE7j
         dcZ+wyzb2Us21AYBDy/jVT9yrJddr6LEXgqzI8jyUKPY0NV5JsHaCHeBYiEzf+VguDhF
         u7i+ISIy8QRmazme4pp5Rqs+IWG4xe8lBRG7nMlARxin2w0hYLTNxPFMVvR6wC4O5BnK
         SPL5KSCSZmTbn/HXJ8+1cKQNvYy7DaNSd0ZlA0U81HebOs9uP6qb+12bQAOyRJIrKYHJ
         QeTs4EhmwB5bN+PUgWrJyfhKAcpgqgVq40qW/lMCtwY7onIBqsleABdoU4QDNQ0EFgQV
         DGGA==
X-Gm-Message-State: AOJu0YySYAUfx0DZcRGvy1aBZ1sLNATdSUK8aj3UH6DbB9RNmOQGKJeY
        OIKtySIBncmpZXBWeRFsp24=
X-Google-Smtp-Source: AGHT+IEbzwaHmvHzzBlM2jybPbxPnFQkomq8qIUdYgOEXj4mOtEMerBdpAcwRwoTlfyX4sp76ib3Mg==
X-Received: by 2002:a17:902:d203:b0:1bd:c956:2798 with SMTP id t3-20020a170902d20300b001bdc9562798mr6384670ply.46.1692048293490;
        Mon, 14 Aug 2023 14:24:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e105:59a6:229c:65de? ([2620:15c:211:201:e105:59a6:229c:65de])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b001b03f208323sm9884124pls.64.2023.08.14.14.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 14:24:52 -0700 (PDT)
Message-ID: <a00b0138-19e4-dfb9-ecc4-3b4e7ae562dc@acm.org>
Date:   Mon, 14 Aug 2023 14:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 1/2] scsi: ufs: core: convert to dev_err_probe() in
 hba_init
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com, quic_nguyenb@quicinc.com
References: <20230814184352.200531-1-bmasney@redhat.com>
 <20230814184352.200531-2-bmasney@redhat.com>
 <f01040be-dfa5-fe60-fba5-410fccc1d50e@acm.org> <ZNqaN5+Ft5PAE43x@brian-x1>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZNqaN5+Ft5PAE43x@brian-x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 14:18, Brian Masney wrote:
> On Mon, Aug 14, 2023 at 12:31:31PM -0700, Bart Van Assche wrote:
>> On 8/14/23 11:43, Brian Masney wrote:
>>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>>> index 129446775796..409d176542e1 100644
>>> --- a/drivers/ufs/core/ufshcd.c
>>> +++ b/drivers/ufs/core/ufshcd.c
>>> @@ -9235,8 +9235,9 @@ static int ufshcd_variant_hba_init(struct ufs_hba *hba)
>>>    	err = ufshcd_vops_init(hba);
>>>    	if (err)
>>> -		dev_err(hba->dev, "%s: variant %s init failed err %d\n",
>>> -			__func__, ufshcd_get_var_name(hba), err);
>>> +		dev_err_probe(hba->dev, err,
>>> +			      "%s: variant %s init failed err %d\n",
>>> +			      __func__, ufshcd_get_var_name(hba), err);
>>>    out:
>>>    	return err;
>>>    }
>>
>> This opportunity could have been used to improve the grammar of the reported
>> error message. Anyway:
> 
> That's what I originally did in v1, however I was asked to split out the
> cleanup into a different patch. Split out, I think the cleanup on it's
> own isn't worth it's own patch, so that's why I dropped it.
> 
> https://lore.kernel.org/lkml/20230808142650.1713432-2-bmasney@redhat.com/

Changing an error message and introducing dev_err_probe() at the same time is
fine. I don't think that is what the reviewer complained about. The complaint
probably was about renaming 'err' into 'ret' and about changing 'goto out'
into 'return 0'?

Thanks,

Bart.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99937CCC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbjJQTeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343507AbjJQTdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:33:51 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EADA98;
        Tue, 17 Oct 2023 12:33:50 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c5c91bec75so40838025ad.3;
        Tue, 17 Oct 2023 12:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697571230; x=1698176030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtuiyt/r+HBuK0UWbhcYtY7fy++2EasB4f2A0MuSK5o=;
        b=hoXI7QAvWnlCGsbOcnaeAJQUUoIAfJBDnMHJnH2D6N9zXS/sw2j3KfwfOEO5hUf+94
         4kB6vC9j3UKQFXMclnpxXYQ5+4lV5r6rt7xT25Fvby2TJPrK2toDEXj2GYAOb0pOCU/L
         kwkAYLB/wFfRTy7WYGya16oLDnXMLGX9skcnEuZgi7spxtaVMqkJLKCuQc130syDWWLg
         IVdwY/iCOi0y2uQAJCAS8hgX0asxp5Zx+y/eNH944XOl5rohcCYF7k2zlgjgS0nMaj6i
         ZYUcaSLnlgM7PyCGSRmFO1RtnCioGjmyi76y4O363wxD7HuzUOzjelG9pD2Ic8Bj/WO8
         ldUA==
X-Gm-Message-State: AOJu0Yz0QDVHwtmwpUSDOKMeRkhig5sDTbCwJeDyWpKbcT9QDgnLjR1z
        tLJfR4cwkIrLWPwUI2LC6mI=
X-Google-Smtp-Source: AGHT+IHg+Kj3iXs7JU5UcYutvTJWG6AXQU21isfFYfYtFe6BvkFH544IiAxG1UzNnEOQtqZsa3ugzw==
X-Received: by 2002:a17:902:f683:b0:1c3:eb95:2d27 with SMTP id l3-20020a170902f68300b001c3eb952d27mr3564646plg.48.1697571229870;
        Tue, 17 Oct 2023 12:33:49 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f02:2919:9600:ac09? ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id iy18-20020a170903131200b001bc6e6069a6sm1971007plb.122.2023.10.17.12.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 12:33:49 -0700 (PDT)
Message-ID: <52a248fc-465e-4050-8692-5105b6aaa764@acm.org>
Date:   Tue, 17 Oct 2023 12:33:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: Leave space for '\0' in utf8 desc string
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        Daniel Mentz <danielmentz@google.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mars Cheng <marscheng@google.com>,
        Yen-lin Lai <yenlinlai@google.com>
References: <20231017182026.2141163-1-danielmentz@google.com>
 <DM6PR04MB6575C45CF299649DF41FD963FCD6A@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB6575C45CF299649DF41FD963FCD6A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 12:20, Avri Altman wrote:
>> Fixes: 4b828fe156a6 ("scsi: ufs: revamp string descriptor reading")
> I think this code goes back to commit b573d484e4ff (scsi: ufs: add support to read device and string descriptors)

Hmm ... it seems to me that there was no buffer overflow in commit 
b573d484e4ff but that the buffer overflow was introduced by commit 
4b828fe156a6?

Thanks,

Bart.

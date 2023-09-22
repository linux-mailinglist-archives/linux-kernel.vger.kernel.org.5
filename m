Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9290F7AB4B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjIVPX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjIVPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:23:24 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B865A1;
        Fri, 22 Sep 2023 08:23:18 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-692a9bc32bcso705343b3a.2;
        Fri, 22 Sep 2023 08:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695396198; x=1696000998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZ743c23h82eWXrVp5Ju6MBdvRvF0AFD87bTIsRHhaE=;
        b=QVUFMDEDRu5qJ44up4LdUP+Yd70b3Uwqhn7jv3yqQ3BSE8LBVu0b0M42I4rcKWsCgF
         IIAu5Ingg4HxpRklNEykEl2klYF0BLbrlbNs4pHcvRhfzJXGqplxqtAxtFdhDlcnrl+6
         1zOWy5nJPqUuOCIth24WSz+E+xg9pmbtGDoclfVNas8g0gQgDCWE5ROrEHfzW2F8mkGb
         AR+QiZtx6HKB6JpSJZafGPqUyAYjCp1oX6IdXggW0RWML7uhfa5+F+SRXHHzKkl8nm5/
         /RLL+cCBqPUPFTloWPmQ6dv7upuuxvWWw58xDJxAezsZTajb/BE2kkCU9sbQrCWgiNbs
         gj5g==
X-Gm-Message-State: AOJu0Yy6LUiFEGUB0lWOBcdKGFRUEiWdfjA8nOQjU9LtUCZTEOC08/Iq
        5MzkpEoi9bHDT4QAC+NggW149uJ+d0g=
X-Google-Smtp-Source: AGHT+IGv7VDAGfsVGtsA/+e+0gy37/34XU0WQXSHLpppFsXFrxJgkCC1DNxIUOTjLT8c5r5o+C5yNQ==
X-Received: by 2002:a05:6a20:12c9:b0:157:7568:6796 with SMTP id v9-20020a056a2012c900b0015775686796mr8773128pzg.60.1695396197651;
        Fri, 22 Sep 2023 08:23:17 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:70e9:c86f:4352:fcc? ([2620:15c:211:201:70e9:c86f:4352:fcc])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090a8c0d00b002633fa95ac2sm5081544pjo.13.2023.09.22.08.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 08:23:17 -0700 (PDT)
Message-ID: <50b20a3e-e264-4788-8e52-f7b57cf944f0@acm.org>
Date:   Fri, 22 Sep 2023 08:23:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: core: scsi_device_online() return false if
 state is SDEV_CANCEL
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20230922093636.2645961-1-haowenchao2@huawei.com>
 <20230922093636.2645961-2-haowenchao2@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230922093636.2645961-2-haowenchao2@huawei.com>
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

On 9/22/23 02:36, Wenchao Hao wrote:
> SDEV_CANCEL is set when removing device and scsi_device_online() should
> return false if sdev_state is SDEV_CANCEL.
> 
> IO hang would be caused if return true when state is SDEV_CANCEL with
> following order:
> 
> T1:					    T2:scsi_error_handler
> __scsi_remove_device()
>    scsi_device_set_state(sdev, SDEV_CANCEL)
>    					    scsi_eh_flush_done_q()
> 					    if (scsi_device_online(sdev))
> 					      scsi_queue_insert(scmd,...)
> 
> The command added by scsi_queue_insert() would never be handled any
> more.

Why not? I think the blk_mq_destroy_queue() call in 
__scsi_remove_device() will cause it to fail.

Thanks,

Bart.

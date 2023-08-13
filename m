Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582A277A796
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjHMPqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHMPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:46:19 -0400
Received: from out-73.mta1.migadu.com (out-73.mta1.migadu.com [95.215.58.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4FBE6C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:46:21 -0700 (PDT)
Message-ID: <2cfe0472-7580-cee4-e9cf-a1d25b86b2f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691941580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUtzDP/RkG22ESFllcA6KnDiLID53HUx5i8IZA2OApc=;
        b=QOG0GY48otbYlfPswtawDFBGpYP3uJFIqsPV1IGftM1Et9+LCNUDf10rbW1vj0I5DfBDIx
        /3YMe56WCFxqlK8Kqi05XmxHKDBpDCF2ZaOYZiPxI7V7ulTcro1TIwU96fMu+ko+/eqMUh
        dZXjVvCdZmZKZZcpKlMzG6Gc/TXU4eI=
Date:   Sun, 13 Aug 2023 23:45:53 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, hch@lst.de, chuck.lever@oracle.com
Cc:     bvanassche@acm.org, cel@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230813152325.3017343-1-chengming.zhou@linux.dev>
 <61b9abff-091e-4aae-a9bd-3f1be1593661@kernel.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <61b9abff-091e-4aae-a9bd-3f1be1593661@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/13 23:34, Jens Axboe wrote:
> On 8/13/23 9:23 AM, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Chuck reported [1] a IO hang problem on NFS exports that reside on SATA
>> devices and bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
>> submission path for post-flush requests").
>>
>> We analysed the IO hang problem, found there are two postflush requests
>> are waiting for each other.
>>
>> The first postflush request completed the REQ_FSEQ_DATA sequence, so go to
>> the REQ_FSEQ_POSTFLUSH sequence and added in the flush pending list, but
>> failed to blk_kick_flush() because of the second postflush request which
>> is inflight waiting in scheduler queue.
>>
>> The second postflush waiting in scheduler queue can't be dispatched because
>> the first postflush hasn't released scheduler resource even though it has
>> completed by itself.
>>
>> Fix it by releasing scheduler resource when the first postflush request
>> completed, so the second postflush can be dispatched and completed, then
>> make blk_kick_flush() succeed.
> 
> Thanks, applied with a bit of commit message massaging and adding a
> comment for the newly added WARN_ON_ONCE().
> 

Ok, thanks!

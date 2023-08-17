Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1247E77F9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjHQOvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352345AbjHQOum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:50:42 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB82D78;
        Thu, 17 Aug 2023 07:50:40 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-26b41112708so3864194a91.3;
        Thu, 17 Aug 2023 07:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283840; x=1692888640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Swe7qS1gWsrm3LERSWVriC7BNsYVaHQ/NWIJOtLygzE=;
        b=KtvecZiMk6GEkGLxqwesZDEZQ546MvLIVdT7ogRmePd84+OsCtJ+Jl/m6qPm0Uyt+O
         VvsazR9CCYwFJODTQ+uTfh2cKCjFaPSVg/VT+TDMR5O0W6eGnv6s40rDc2xb0Pc7is/6
         lWJOjXkY6SRzuuRF3Pau67gDMREawEMe32nOwFdItktk9xUsoxEwMUSPXGANuDBa4RF5
         /ivI4va44PeMmGQqpt2/+IFIfjTZEF3UERTU7sWfmhu0kuxYk1vc8rFVum1E5hb3gWWG
         k28+9d+2mxZPfhgTMKnAEYXXsnoOF5mdrll/tWGBdL12Byg/29GyD3rNXfIkmxSblLvJ
         mbmQ==
X-Gm-Message-State: AOJu0Yw/GAkdoLkwapvgCRAitxPPXMve5CMHqAD3FS3GTM3cWNHS82Pe
        ZbivfGPhswFZykstyalVHfc=
X-Google-Smtp-Source: AGHT+IFixLVVwRoS+ebQdkKmKGR5+zSOuE1vDbyNm+1B3b/hEgjshhzCxdl3EVfg+K86FX4nwiVxtQ==
X-Received: by 2002:a17:90a:fc95:b0:268:52a6:103d with SMTP id ci21-20020a17090afc9500b0026852a6103dmr4656895pjb.9.1692283839903;
        Thu, 17 Aug 2023 07:50:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:dfd:6f25:f7be:a9ca? ([2620:15c:211:201:dfd:6f25:f7be:a9ca])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0025645ce761dsm1663238pjb.35.2023.08.17.07.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 07:50:39 -0700 (PDT)
Message-ID: <af61c72c-b3ec-ce7a-4f41-bce9a9844baf@acm.org>
Date:   Thu, 17 Aug 2023 07:50:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Content-Language: en-US
To:     chengming.zhou@linux.dev
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        cel@kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com,
        kernel test robot <oliver.sang@intel.com>
References: <202308172100.8ce4b853-oliver.sang@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <202308172100.8ce4b853-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/23 07:41, kernel test robot wrote:
> [  222.622837][ T2216] statistics for priority 1: i 276 m 0 d 276 c 278
> [ 222.629307][ T2216] WARNING: CPU: 0 PID: 2216 at block/mq-deadline.c:680 dd_exit_sched (block/mq-deadline.c:680 (discriminator 3))

The above information shows that dd_inserted_request() has been called
276 times and also that dd_finish_request() has been called 278 times.
Calling dd_finish_request() more than once per request breaks the code
for priority handling since that code checks how many requests are
pending per priority level by subtracting the number of completion calls
from the number of insertion calls (see also dd_queued()). I think the
above output indicates that this patch introduced a regression.

Bart.


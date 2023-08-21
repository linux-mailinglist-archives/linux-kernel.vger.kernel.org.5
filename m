Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1A7782866
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjHUL6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjHUL63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76267C7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E8B3632C6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91230C433C8;
        Mon, 21 Aug 2023 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692619105;
        bh=T4xgCx5Z7Da6zvQfuv9RvMhCD7j3XXVo0DgN+vZ0gKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJIHohZYinbcN8n8Y1M/EzZR6AsYhe/nWTtkSgUSlur4uewOJrrG2ChhvPwPImXXO
         0KjpEnfGmyyoFGrMo0HHL7uRNga4vC0bLUzA1IC79UhcUVe8qt3uf12SKq5u8BMq5H
         ZyrzaAi+OyLV/erqtY7PJ1edsnyhErk8HNBkpqFMxCZyX5avgNT+76DUZgmElINV7p
         pqpD/sDIWS1aBaKlsbHLe4vr6GoLlfmvobE2C/MmZ3nD2BOmUFTPj2PhwKcaSolmZL
         CvYgjz+OoJH8mGNex+jkfEPGMXmB+Tu8x7P48Z3/rwVwH/wS8lQAqbAG2+tBuQ2c+J
         f4RwImtk5PLrg==
Date:   Mon, 21 Aug 2023 12:58:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     jonathan.cameron@huawei.com, mark.rutland@arm.com,
        chenhao418@huawei.com, shenjian15@huawei.com,
        wangjie125@huawei.com, liuyonglong@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH drivers/perf: hisi: 1/2] drivers/perf: hisi: hns3:
 default use hardware event 0 as group leader event.
Message-ID: <20230821115820.GA19617@willie-the-truck>
References: <20230816094619.3563784-1-shaojijie@huawei.com>
 <20230816094619.3563784-2-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816094619.3563784-2-shaojijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 05:46:18PM +0800, Jijie Shao wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> For hns3 pmu events, we use command as below before:
> perf stat -g -e hns3_pmu_sicl_0/config=0x00105,global=1/
> -e hns3_pmu_sicl_0/config=0x10105,global=1/ -I 1000
> 
> We want to use -g parameter to make 0x00105 event and 0x10105 event
> share a hardware event, but for kernel 6.2, 'commit 5f8f95673f68
> ("perf evlist: Remove group option.")' remove -g parameter.
> 
> So add this patch to set default related event idx as 0 to share
> the first hardware event.

Hmm, but the change cited above is a userspace change so I don't think
we should be making driver-side changes for that. Furthermore, the commit
message there suggests that you should be using a different syntax,
introduced by 89efb029502d ("perf tools: Add support to parse event
group syntax") (which describes the grammer and has some examples too).

Will

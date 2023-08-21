Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36079782895
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjHUMIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjHUMIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF7BC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D360C632CD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECEEC433C7;
        Mon, 21 Aug 2023 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692619698;
        bh=PVrW88G27NaeeJAhpiG0fUdgU3T6lmCSgLklwhQPUcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdtBgc1Zdzz9XycBCO0HvY8k0JMEZI7SSV2GV49arWbVvzA56OVGAQ/K7B9/WRqAw
         iuO8kq4u503GRmKDkMS7jTQT7hOSibslO/INQJEjgA8LcauNsOmLXBKVT27z1VmOyw
         MlmbSHYmh0kn9BmwZeVB87uuBrHMMaSrjz2z05Em7/diTEUEcvf8UGCmxzH+wVGVNY
         4ZgV+bLOo+CuthiWTRni0MYkQEQo2OXJXjV7fdgirMOVyChF8DvKLnoPW/hZ0msQsB
         pYi9Zcz27RTyLIHzclotFjDbbCvqWx+XGFLekHm2dchA7c5yKZpA/H8+aFdhR3WvjZ
         oI9VbJWTm+IIQ==
Date:   Mon, 21 Aug 2023 13:08:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     jonathan.cameron@huawei.com, mark.rutland@arm.com,
        chenhao418@huawei.com, shenjian15@huawei.com,
        wangjie125@huawei.com, liuyonglong@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        huangguangbin2@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [PATCH drivers/perf: hisi: 2/2] drivers/perf: hisi: fix set
 wrong filter mode for running events issue
Message-ID: <20230821120812.GC19617@willie-the-truck>
References: <20230816094619.3563784-1-shaojijie@huawei.com>
 <20230816094619.3563784-3-shaojijie@huawei.com>
 <20230821120440.GB19617@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821120440.GB19617@willie-the-truck>
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

On Mon, Aug 21, 2023 at 01:04:40PM +0100, Will Deacon wrote:
> [+Guangbin Huang and Shaokun Zhang]

                   The mail system

<zhangshaokun@hisilicon.com>: host mx5.hisilicon.com[124.71.93.234] said: 551
    5.1.1 <zhangshaokun@hisilicon.com>: Recipient address rejected: Failed
    recipient validation check.: host 127.0.0.1[127.0.0.1] said: 554 5.7.1
    recipient verify from ldap failed (in reply to RCPT TO command) (in reply
    to RCPT TO command)

<huangguangbin2@huawei.com>: host mx5.huawei.com[124.71.93.234] said: 551 5.1.1
    <huangguangbin2@huawei.com>: Recipient address rejected: Failed recipient
    validation check.: host 127.0.0.1[127.0.0.1] said: 554 5.7.1 recipient
    verify from ldap failed (in reply to RCPT TO command) (in reply to RCPT TO
    command)


So it's only Jonathan left in MAINTAINERS for "HISILICON HNS3 PMU DRIVER".
Lucky him!

Please can you update MAINTAINERS?

Will

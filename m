Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4B3762921
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGZDLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGZDLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:11:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCA71BF8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9EC4601D6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9968CC433C7;
        Wed, 26 Jul 2023 03:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690341104;
        bh=9Upzi3S02vKTUvKJdNd22YEHdE2llnbz3XXAiMSuNQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OOjHtuoBNOKGC4Cyl5+apIy5ejwGjm9BJ7VcnFMgxtPGfvvNZJe/ZX/G/1B8Z4O2x
         eQOAs2Kp/LYfxkavQsjHHjqeqmQMFBWaOSHZyF3g58ifceVEphQL0CWIbMJg5yix7O
         sV3Nakdf8ebHoYjkgZL3xmQFkb0EYnxcj1xjjUKTsK+MdgcRbL7/iR+GDM6/maUP+N
         uhqmu0yaUEv2hQEPKz5yM2akmGRqPFuGwwlrWCB2g4VUSNJ1CKrv237SPUKq2mLR5f
         pdS2eVt5vTQGqGiuDApscRr5VzxEIat80QMf97lEdTGdpWeA/5zsZz9uLNlld8yhsa
         t/+5LIi+hmeRw==
Date:   Tue, 25 Jul 2023 20:11:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        ast@kernel.org, martin.lau@kernel.org, yhs@fb.com,
        void@manifault.com, andrii@kernel.org, houtao1@huawei.com,
        inwardvessel@gmail.com, kuniyu@amazon.com, songliubraving@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Message-ID: <20230725201142.593ae606@kernel.org>
In-Reply-To: <20230725023330.422856-1-linma@zju.edu.cn>
References: <20230725023330.422856-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 10:33:30 +0800 Lin Ma wrote:
> The nla_for_each_nested parsing in function bpf_sk_storage_diag_alloc
> does not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as a 4 byte integer.
> 
> This patch adds an additional check when the nlattr is getting counted.
> This makes sure the latter nla_get_u32 can access the attributes with
> the correct length.
> 
> Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Those who parse manually must do checks manually. It is what it is.

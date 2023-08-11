Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE796778CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjHKLDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbjHKLDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBCA1736
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BB8964392
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0CFC433C8;
        Fri, 11 Aug 2023 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691751797;
        bh=PjX3Kj30CvssUoUzKqXeYgWsx+H2hFXKVoFi6QaOBNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCQN3lGyQBoZwxoioLWZpfDejCNEPdCkuNsAASUmFiChXFzmqJILdpvvrPNubwaX4
         FxBfL2iYPzGKq4I1zsAtGCdPUd0g2sdGStehBifmE4WRZVA0bZDN/OtNmvWZAurG8v
         p4rXVhE2NnPjqKLqHqZW7f+vYUjE9Pv12H6LXDATo7cRNWejmAC9UdR5et2+dtqdsu
         LPHtaXtqj7afNFie1RBS1gaL/02zicmkKqVW20CspQ84mt/Gzi3VOs/7uY5U2zxmu3
         ma8MS5oGac+G/joxsXTXIAGEfoXJI59rOZScOpcP3cLxA500jJk7owqkd36AYol7a6
         num+iIFe31AaA==
Date:   Fri, 11 Aug 2023 12:03:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.co, pasha.tatashin@soleen.com,
        muchun.song@linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH] arm64: mm: use ptep_clear() instead of pte_clear() in
 clear_flush()
Message-ID: <20230811110311.GB6993@willie-the-truck>
References: <20230810093241.1181142-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810093241.1181142-1-qi.zheng@linux.dev>
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

On Thu, Aug 10, 2023 at 09:32:41AM +0000, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In clear_flush(), the original pte may be a present entry, so we should
> use ptep_clear() to let page_table_check track the pte clearing operation,
> otherwise it may cause false positive in subsequent set_pte_at().

Isn't this true for most users of pte_clear()? There are some in the core
code, so could they trigger the false positive as well?

Will

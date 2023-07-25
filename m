Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0338761FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjGYQyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGYQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6F526B9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA87061821
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B8FC433C8;
        Tue, 25 Jul 2023 16:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690304009;
        bh=IxAEg/zFNLeaSOZ2+I4D9yyaJpFMEaswtXPaBzxnKgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SxH+OGq4T9EJ5mb76lXK+oW2BxdhHd7R3WW97C3AISLcrhGM+/cY0HhzoDLq99fnR
         pqWDGfjsnv8PloQmggBJAcbzdordfUmLHnkgmXKBBfRAP/elOmTlMf17KHF5uCZlSk
         YN7ACW+2ggKI5Cvv4kxqEMhIqelM6jJYzC0EaBxvdZly6Xd52r1ZqFeBTiC+l351ao
         9Tbt+epizrET4rBKIrKL29eZed29GvBaq2ZXiJyrxO7RpTDFpkzd+ztPU+zJksn2lE
         baNiQvt2HO1/JIJ9gLCDCMDZarJRm6gFWd0/JCCPwT8oDbt+6LDYn5kY0mLce97t88
         rrm+EMRUjvb1A==
Date:   Tue, 25 Jul 2023 09:53:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i40e: Add length check for IFLA_AF_SPEC parsing
Message-ID: <20230725095327.385616f1@kernel.org>
In-Reply-To: <20230725054046.GK11388@unreal>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
        <20230724174435.GA11388@unreal>
        <20230724142155.13c83625@kernel.org>
        <20230725054046.GK11388@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 08:40:46 +0300 Leon Romanovsky wrote:
> > Empty attributes are valid, we can't do that.  
> 
> Maybe Lin can add special version of nla_for_each_nested() which will
> skip these empty NLAs, for code which don't allow empty attributes.

It's way too arbitrary. Empty attrs are 100% legit, they are called
NLA_FLAG in policy parlance. They are basically a boolean.

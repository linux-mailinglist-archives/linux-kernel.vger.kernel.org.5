Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8960F762182
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGYShB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGYSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27E11985
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:36:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7149E61870
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3088BC433C9;
        Tue, 25 Jul 2023 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690310216;
        bh=bjmPK5i8hRDzGjUnFu1I3rEttWK5DLd8NhrusoG1LHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SdcIkVwfwM8nNchwnyAIYUyNEQfIrLNu4VzEIYuK/6yR399E7HquUzR/dEqLDwynl
         cs+FB8L8PqQoFeknYUPYeowW+xWD6OekN6l/qDJixjEoe/qvUSv000ZEbMnilgzoFK
         iWFmJyTNaRFJ9FXuDqJfTWqKLFHGv72a3Hf8BSbDFjglnjwciYyPG5YtvrCxnfokXZ
         f7VYTKBs5OGzYR725ZwuO+mGVGSSvWMD8y5bmlBdzNoKOPRJvrrWkOT7WUzs3fh+fk
         uvEePo1Adzoa0h0Eqnn0xXtyVmeLUJdR3LA+GNYvxiM94trezxoCn99BSE8nB7PLMY
         2jvafCCIQiVjA==
Date:   Tue, 25 Jul 2023 21:36:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i40e: Add length check for IFLA_AF_SPEC parsing
Message-ID: <20230725183652.GR11388@unreal>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
 <20230724174435.GA11388@unreal>
 <20230724142155.13c83625@kernel.org>
 <20230725054046.GK11388@unreal>
 <20230725095327.385616f1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725095327.385616f1@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 09:53:27AM -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 08:40:46 +0300 Leon Romanovsky wrote:
> > > Empty attributes are valid, we can't do that.  
> > 
> > Maybe Lin can add special version of nla_for_each_nested() which will
> > skip these empty NLAs, for code which don't allow empty attributes.
> 
> It's way too arbitrary. Empty attrs are 100% legit, they are called
> NLA_FLAG in policy parlance. They are basically a boolean.

I afraid that these nla_length() checks will be copied all other the
kernel without any understanding and netlink API doesn't really provide
any hint when length checks are needed and when they don't.

Thank

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64DD7D8496
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbjJZOYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjJZOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:24:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80C0D7A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:24:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182A7C433C9;
        Thu, 26 Oct 2023 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698330265;
        bh=JvktxjVfkL+L338qM5yYJHIrOtY6B+d/w/XgfHIyqJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T1+gpBbuxN3eqF4QCYpT83BIEg0rFmZapScZQJ7whB+Hy4Y/GiypWgWapxytG+HJC
         L7rExCB0EvByr/Vt+KvKSm76qzkqsOkFDfe/wAMJIdo6IL1dtgF+73RmWPjkdgyJ9x
         VpBFQsqP5eZGpg2gIfQb3IgEFrlXXaIt2mSR29CCMBO2qAOr8IWz0OVqsuOiLiiYNf
         ngP7MiDMktJlqG64ShxT7abpgW2RH1nBTjet9kL9keKfzE2EQfxKhCHyzSeB87Xo7k
         7LHSK8Vmz4IyxE7sGkdZx2bmn14F3rM646El/iJmEqiHCVYgP3zttjDHjxIlY/pBcM
         wkbdWdLe9uXQw==
Date:   Thu, 26 Oct 2023 07:24:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        <GR-Linux-NIC-Dev@marvell.com>,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "Tony Nguyen" <anthony.l.nguyen@intel.com>,
        Louis Peens <louis.peens@corigine.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>, <drivers@pensando.io>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        "Dwaipayan Ray" <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <intel-wired-lan@lists.osuosl.org>, <oss-drivers@corigine.com>,
        <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 2/3] treewide: Convert some ethtool_sprintf() to
 ethtool_puts()
Message-ID: <20231026072423.2ebd4619@kernel.org>
In-Reply-To: <f4b69b9d-2294-e0bf-a12a-9622eb70bd99@intel.com>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
        <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
        <f4b69b9d-2294-e0bf-a12a-9622eb70bd99@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 11:23:37 +0200 Przemek Kitszel wrote:
> this would now fit into one line
> (perhaps it's the same in other cases, I just checked this one manually)

I think cocci would fold lines automatically? Could be worth trying
spatch to do the conversion for that reason, if you aren't already.

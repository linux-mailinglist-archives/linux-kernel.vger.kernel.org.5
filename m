Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98D277EF41
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbjHQC7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347714AbjHQC64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:58:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9D210E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 19:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F6963EF7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEDEC433C7;
        Thu, 17 Aug 2023 02:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692241135;
        bh=59wvIo/jbNZ1NEkMzIFE8KXmJTTM9lHColO0mupz8/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tl+H3n1XaCFaGkNitVc5mElUg0G+/g5ttGguNk/2EYe3VDTIE7DNThYxt6Yhmh2Z5
         EQO/fLwR+0OPV0JlsJWTtDLeu3XrQ5d56H3CvIG6M678+DxvCD0o8A0IYL/CIRwMtA
         Cr6CRljC0qhuJCf6tvVtuimjjAH4A4mpPY9JepQqjMyZvlTqD/le5zMVQLBinhczIs
         kgqXL0ciZePKUCJWvhjN7GUblxvdlbzI8kDAntHRQTW22GthOPjeSHMowWptv40Ov8
         yq0vnvESoB2MGiuDyDXuLqrxBNbH2D8ahYp1VBhJzZ1B3Poubd6wnNC1Xjqj0tLTm6
         /E7CIzH5/naTw==
Date:   Wed, 16 Aug 2023 19:58:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Victor Nogueira <victor@mojatatu.com>,
        syzbot <syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        edumazet@google.com, jiri@nvidia.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in unix_release
Message-ID: <20230816195853.7c2475d7@kernel.org>
In-Reply-To: <20230816225759.g25x76kmgzya2gei@skbuf>
References: <0000000000008a1fbb0602d4088a@google.com>
        <20230814160303.41b383b0@kernel.org>
        <20230815112821.vs7nvsgmncv6zfbw@skbuf>
        <20230816225759.g25x76kmgzya2gei@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 01:57:59 +0300 Vladimir Oltean wrote:
> There are multiple workarounds that can be done in taprio (and mqprio)
> depending on what is considered as being sane API. Though I don't want
> to get ahead of myself. Maybe there is a way to fast-forward the
> qdisc_destroy() of the previous taprio so it doesn't overlap with the
> new one's qdisc_create().

Thanks for the details. I'm going to let others comment, but sounds 
a bit similar to the recent problem with the ingress qdisc. The qdisc
expects to own the netdev which explodes when its lifetime rules are
fully exercised :(

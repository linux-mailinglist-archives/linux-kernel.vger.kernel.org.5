Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1547C91AD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjJNAHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjJNAHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:07:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888DEAD;
        Fri, 13 Oct 2023 17:07:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744BCC433C7;
        Sat, 14 Oct 2023 00:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697242054;
        bh=6kpMwlfSNasU9AQMtLitDygCjCpDKwjI+adsPbqa9OA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UdBr2wcD9YbkjCo7SyrOU7C2P7cOL79UAKLiM1BqeppHoumCz76G9EbxX7WR2a7v0
         Y60I+lH6kFJnJziGqDlxqaLZNQaM/awAaSidgcGYR+9q83BJ2QxSZEZjTjIuk348Pi
         ffyBwFqzUhY++R8GyWNdABQ2xssKv/CC5BMpYdyuVHIv/3fh2UddcuGDzzePUzM0Zj
         ZFZNP9zKbvbYP8evuVMaLBq3Uhtdj7X0PFkWqqfqRdG+UIQQ5Ycc52CB8UiFnpBAQL
         Xh9FykSlCiuWrvhF9vOqoSKQIaFP4aVwTfh1v/CEpEBtX9JaFGG1pCzHzRUPMxahBz
         kL3fZdQ9ejoyw==
Date:   Fri, 13 Oct 2023 17:07:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Johannes Berg" <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     "Arnd Bergmann" <arnd@arndb.de>, "Jiri Pirko" <jiri@resnulli.us>,
        "Arnd Bergmann" <arnd@kernel.org>, Netdev <netdev@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org,
        "Michael Hennerich" <michael.hennerich@analog.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Rodolfo Zitellini" <rwz@xhero.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] appletalk: make localtalk and ppp support
 conditional
Message-ID: <20231013170732.587afd86@kernel.org>
In-Reply-To: <82527b7f-4509-4a59-a9cf-2df47e6e1a7c@app.fastmail.com>
References: <20231011140225.253106-1-arnd@kernel.org>
        <ZSa5bIcISlvW3zo5@nanopsycho>
        <82527b7f-4509-4a59-a9cf-2df47e6e1a7c@app.fastmail.com>
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

On Wed, 11 Oct 2023 17:57:38 +0200 Arnd Bergmann wrote:
> The .ndo_do_ioctl() netdev operation used to be how one communicates
> with a network driver from userspace, but since my previous cleanup [1],
> it is purely internal to the kernel.
> 
> Removing the cops appletalk/localtalk driver made me revisit the
> missing pieces from that older series, removing all the unused
> implementations in wireless drivers as well as the two kernel-internal
> callers in the ieee802154 and appletalk stacks.
> 
> One ethernet driver was already merged in the meantime that should
> have used .ndo_eth_ioctl instead of .ndo_do_ioctl, so fix that as well.
> With the complete removal, any future drivers making this mistake
> cause build failures that are easier to spot.
> 
> [1] https://lore.kernel.org/netdev/20201106221743.3271965-1-arnd@kernel.org/

Kalle, Johannes, do these apply for you?
I'm getting a small conflict on patch 8 and bigger one on patch 9.
If this applies for you maybe you can take it and flush out
wireless-next soon after?

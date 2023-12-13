Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721ED810938
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378502AbjLMEp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378466AbjLMEp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:45:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F397D98
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:45:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123CCC433C7;
        Wed, 13 Dec 2023 04:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702442732;
        bh=wAzQ6gyscE8Ihq0a6Mek/OCHIV4GQLIER2F9aDitQMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ww5bIRBNnQPaVkYZpHJbY3dLSrm1sJu0HfgxfCcmCVuVcLZlNg3DlKYcLr4zT5HWd
         bciMBhudAYariFLueoHcmNOxu1AJ3r27mg5g+83h7vov2MlGllZ3VLKWTPyqIwziPp
         S03U2B1N04P3proWizqvxMTgA3Rfg63LxOWp/xWTNoPXb36A3OfZiqnABhQL9rv5pQ
         K0qivv6JNIPVaGkqYzK5tEYKPUPiwloKm4OLKDrdWX13KeL23RPL43fnru0At7eFkG
         bvHC4cFiru9qamWa2ag8WVd9W6coWQgQ/76g2DuVec6DqkW9d/QRJ7qEMDDfn2sihY
         fME+JquNsk/ag==
Date:   Tue, 12 Dec 2023 20:45:30 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
        yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
        linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Fix I/O priority lost in device-mapper
Message-ID: <20231213044530.GB1127@sol.localdomain>
References: <ZXeJ9jAKEQ31OXLP@redhat.com>
 <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:11:45PM +0800, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> A high-priority task obtains data from the dm-verity device using the
> RT IO priority, during the verification, the IO reading FEC and hash
> by kworker loses the RT priority and is blocked by the low-priority IO.
> dm-crypt has the same problem in the process of writing data.
> 
> This is because io_context and blkcg are missing.
> 
> Move bio_set_ioprio() into submit_bio():
> 1. Only call bio_set_ioprio() once to set the priority of original bio,
>    the bio that cloned and splited from original bio will auto inherit
>    the priority of original bio in clone process.
> 
> 2. Make the IO priority of the original bio to be passed to dm,
>    and the dm target inherits the IO priority as needed.
> 

What commit does this patch series apply to?

- Eric

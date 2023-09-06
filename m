Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4B793A86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjIFLAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIFLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:00:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4C5E59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:00:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A59D022437;
        Wed,  6 Sep 2023 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693998020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1wz3JXlD6sKijh39GZRuuCJLqyL+5GqqYL19oPvalk=;
        b=FP/CXZxw3KtnKEAJFzd5mRdgsDir0lcOL+5avoyNZQca9nQMLfw19GGTfKh+KbOV0eUefk
        9wlI1VCs55pJ7zFXFTkDDfiQWLVzvbTy1DQMMxgRzfJe+2M4DJNlAP0QW9V6MU7qsE5Xry
        Q9q9pQvFTqnI1+bmo8dQ+ep1d4wCqto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693998020;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1wz3JXlD6sKijh39GZRuuCJLqyL+5GqqYL19oPvalk=;
        b=XDEtTln1kiJff3zIsGnj4cqeuw2qsX76p4UKDrlTrJaxzS5hezkXGPwpc/kqATNuOLYZDx
        KtTod8Nkwa40qgDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D098B1333E;
        Wed,  6 Sep 2023 11:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4D2fLsNb+GSOQgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 06 Sep 2023 11:00:19 +0000
Message-ID: <ff7b76d3-2983-44d1-8db7-20629bfbf89c@suse.de>
Date:   Wed, 6 Sep 2023 13:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 1/4] nvmet-trace: avoid dereferencing pointer too early
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-2-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230829091350.16156-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 11:13, Daniel Wagner wrote:
> The first command issued from the host to the target is the fabrics
> connect command. At this point, neither the target queue nor the
> controller have been allocated. But we already try to trace this command
> in nvmet_req_init.
> 
> Reported by KASAN.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> ---
>   drivers/nvme/target/trace.c |  6 +++---
>   drivers/nvme/target/trace.h | 24 +++++++++++++-----------
>   2 files changed, 16 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



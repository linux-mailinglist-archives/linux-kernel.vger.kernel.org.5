Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B52793A77
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjIFK7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjIFK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:59:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A997171D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:59:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6CE7A20293;
        Wed,  6 Sep 2023 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693997944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWV0t6uN1AOE/hJpf9gaVn09F0ED8FlupPXBaNmwf28=;
        b=Bf/NURxpZkENwhVWbbLF/IvnYlqaioYMYTU5xzidWumF7/8M2mnVnT2DUr+G4+GaKyuE6m
        E2SoFETWoEfFR6IcxAtVxxw8heboS4iEqefk6K42M0aB/zzSlpZ47lTzblg4NRDMd2Yu33
        YekyVWL88KmJhQBDqaJlffmXXC4ca8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693997944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWV0t6uN1AOE/hJpf9gaVn09F0ED8FlupPXBaNmwf28=;
        b=udZfH2iUNnEWNIyX+hQPs48VqGvIheWe7Z1HQiP2XsN6R7X9KUdCV2b2R9d5qPA5AAmCd9
        4P7SgfjY1AkeOhDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 444D41333E;
        Wed,  6 Sep 2023 10:59:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AcJFDXhb+GSOQgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 06 Sep 2023 10:59:04 +0000
Message-ID: <47ea3835-2494-4601-9da9-02831a1b4a4b@suse.de>
Date:   Wed, 6 Sep 2023 12:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: auth success1 msg always includes resp
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org
References: <20230828212033.3244512-1-shiftee@posteo.net>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230828212033.3244512-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 23:20, Mark O'Donovan wrote:
> In cases where RVALID is false, the response is still transmitted,
> but is cleared to zero.
> 
> Relevant extract from the spec:
> Response R2, if valid (i.e., if the RVALID field is set to 01h),
> cleared to 0h otherwise
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
>   drivers/nvme/host/auth.c | 5 +----
>   include/linux/nvme.h     | 2 +-
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63E8808DF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjLGQbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjLGQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:31:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F06132
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:31:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCB0C433C7;
        Thu,  7 Dec 2023 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701966679;
        bh=IrVhkRIlzQL6MWkn22aaJtQC7k1uTCUev4gRx7OjJno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cx2IFLhX+un9669VMBlyXxDLw8nn4RuA47dRz9UwBAkGQQmY4+2Q++xkvNajfKqnD
         u1i/gkoY8wT5Lg4CKA1uVN36ykeV1MoRdU9XNmoMUZZyaiDww3f9ID3gHf8Lq0ihmF
         DI/4ra2H6MlJVElYU9IkapNq0co45hVT5tBcJejp+4doCk99opvgge8ViW9PCspTX+
         ZVw0IC5GhQ8C3dzsE1XIYWuDxito9RQzngCV8qBea0S0e/5RvQ+rwAmBMlDCDDAdxH
         QggEAjradx/yx0g4nAiw1AEw528VYIrAd1cbFpxjeF7LJIcrqAKXaG6LWFDHIcRacH
         OMCRcR0UdTNKg==
Date:   Thu, 7 Dec 2023 09:31:16 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 1/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <ZXHzVN3jmIIsGyeq@kbusch-mbp>
References: <20231207123624.29959-1-dwagner@suse.de>
 <20231207123624.29959-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123624.29959-2-dwagner@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:36:21PM +0100, Daniel Wagner wrote:
> @@ -1906,7 +1908,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	 * or smaller than a sector size yet, so catch this early and don't
>  	 * allow block I/O.
>  	 */
> -	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
> +	if (ns->head->lba_shift > PAGE_SHIFT ||
> +	    ns->head->lba_shift < SECTOR_SHIFT) {
>  		capacity = 0;
>  		bs = (1 << 9);
>  	}

A minor conflict here: this series would target nvme-6.8, but the block
tree we're based on doesn't have this code. I'll patch it up for the
current 6.8 tree and make a note of the conflict for the next merge
window.

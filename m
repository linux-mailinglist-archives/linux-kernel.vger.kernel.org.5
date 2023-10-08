Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9930F7BCCCC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344480AbjJHGpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344474AbjJHGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5229EED;
        Sat,  7 Oct 2023 23:45:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F4EC433C8;
        Sun,  8 Oct 2023 06:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696747526;
        bh=aGUrIGhMjQ4lqqxxo4ZUqNOeGyCyNisynIIZPZFYgLg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cLKAoUegqoILOOVFAy4Fm8sIscMh4Phx/priQWRS0inF0tJ8CvJCF9MJIDYkp12ie
         fvO/CvWaiWJCsSw1ferm2K3Kxiq6uSRffgLjzV/L9EYqsc4XCRemfE4K2gx1eA7vLY
         WtAjyQXcQNRdpChjECLBwnUegaPh/c6c3c5HDvC8yidzJorNQESI5Q13A8cOfPOsca
         rOLWMhVLtPVlT3K8fC7yJOJlHUoG1vrYucZr7/6dMOEviTUZghWYo2k0VDBiLNkIVh
         PlyHx4nEKOcKdfqr3Pr2qRfWdjX/Btsieg6m0EGQUanahHQ9JzKSQd7lglW/vv4Qc9
         pex8RwOnHzpdQ==
Message-ID: <88b26dc7-93c6-5c96-1bf8-2c2c320f3247@kernel.org>
Date:   Sun, 8 Oct 2023 14:45:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] f2fs: avoid format-overflow warning
Content-Language: en-US
To:     Su Hui <suhui@nfschina.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20231008063929.538425-1-suhui@nfschina.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231008063929.538425-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/8 14:39, Su Hui wrote:
> With gcc and W=1 option, there's a warning like this:
> 
> fs/f2fs/compress.c: In function ‘f2fs_init_page_array_cache’:
> fs/f2fs/compress.c:1984:47: error: ‘%u’ directive writing between
> 1 and 7 bytes into a region of size between 5 and 8
> [-Werror=format-overflow=]
>   1984 |  sprintf(slab_name, "f2fs_page_array_entry-%u:%u", MAJOR(dev),
> 		MINOR(dev));
>        |                                               ^~
> 
> String "f2fs_page_array_entry-%u:%u" can up to 35. The first "%u" can up
> to 4 and the second "%u" can up to 7, so total size is "24 + 4 + 7 = 35".
> slab_name's size should be 35 rather than 32.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Looks good to me, thanks for the patch.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

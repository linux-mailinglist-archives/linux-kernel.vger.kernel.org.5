Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EF17EBAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjKOBFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjKOBFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:05:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B7ED9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 17:05:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6FFC433C7;
        Wed, 15 Nov 2023 01:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700010326;
        bh=zjoq9C6XZilV4BPnYqnlBuYtqaLJtUzuKWFZVWPEsOY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=tIWbEb/SVmPlKXgK4eUJq+lyP9LHSwWSDWBGONHCyMnAhfm1b89tLzTjmqVIyMIMX
         Ro+QET8x1DPNI0gRwUkjYHQqLZFuANKXujfUmzO1XIPR5E3T7Hmiypp4YlOcooWGGu
         7I1VzMLmgN4RIyzwllJUzA/NQ8jxh2z2qCCn1DdLcLpLy23qTucbsClRY5blJqej5N
         sRDO52l2GUvqcZ3pCHwFPuxOgDrckCjOKSfKLkvhreE/r3NUTtcLwygIlFI/3Z4hKw
         Ah27BT/tdqQHL7xb60djfbrd4BP8xwbrI4MocUDRap9WppOLdryuHh7AnDtigHPRBP
         sAm0rCovLMBeA==
Message-ID: <4a0e1c6f-12c4-f3dd-bb26-4bf0aee6be4b@kernel.org>
Date:   Wed, 15 Nov 2023 09:05:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip adding a discard command if exists
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20231114212414.3498074-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231114212414.3498074-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/15 5:24, Jaegeuk Kim wrote:
> When recovering zoned UFS, sometimes we add the same zone to discard multiple
> times. Simple workaround is to bypass adding it.

What about skipping f2fs_bug_on() just for zoned UFS case? so that the check
condition can still be used for non-zoned UFS case.

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/segment.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 727d016318f9..f4ffd64b44b2 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1380,7 +1380,8 @@ static void __insert_discard_cmd(struct f2fs_sb_info *sbi,
>   			p = &(*p)->rb_right;
>   			leftmost = false;
>   		} else {
> -			f2fs_bug_on(sbi, 1);
> +			/* Let's skip to add, if exists */
> +			return;
>   		}
>   	}
>   

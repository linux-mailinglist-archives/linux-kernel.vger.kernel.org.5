Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A07B2409
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjI1Rgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1RgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:36:24 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CB0DD;
        Thu, 28 Sep 2023 10:36:22 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.39.103.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 530B43F6F0;
        Thu, 28 Sep 2023 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695922579;
        bh=3kPt+GLVzFA2Nc8cQvnXGoUtkXszzFUbN4Qmy30ynpk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Amu7sCu4fDx0a0QrPkBDDPtp9zcbhb+pRIr2Hio/qqeIosDLaOcQbjNp7CH8ahGFU
         kGxxt+EWGdbCbrrKT1579pEsY1//DK+MK6sYZXQoPDm4Crnkky7ADUfwZGzBm0QHYX
         UNvCp0FTGHo6v5eWqfw8kD8pA19KvDYQqZT/yYyEMSa3sY2oBhAmTEWmSKybxImNcD
         VCG34JD9Cq/C2Be+mJunp36IDzYraEPSvZJ5Z8gvJdzhXWuEVk74DyVhkghwSOHPEn
         /I0akdKFbhpBjYpbwZFvOZKLF96VY4w2objICAYSqJU2v915uPanX/22RXtJ2FUKUW
         WNWt7K1g+xibA==
Message-ID: <056095ad-ecf4-b93e-252a-7e3c48e94f11@canonical.com>
Date:   Thu, 28 Sep 2023 10:36:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] apparmor/file: Removing unnecessary initial values for
 variable pointers
Content-Language: en-US
To:     Li kunyu <kunyu@nfschina.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230919015608.8390-1-kunyu@nfschina.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230919015608.8390-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 18:56, Li kunyu wrote:
> These variable pointers are assigned during use and do not need to be
> initialized for assignment.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>   v2: Fix timestamp issues
> 
>   security/apparmor/file.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index 698b124e649f..12eafdf18fc0 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -264,7 +264,7 @@ int aa_path_perm(const char *op, struct aa_label *label,
>   {
>   	struct aa_perms perms = {};
>   	struct aa_profile *profile;
> -	char *buffer = NULL;
> +	char *buffer;

this is okay

>   	int error;
>   
>   	flags |= PATH_DELEGATE_DELETED | (S_ISDIR(cond->mode) ? PATH_IS_DIR :
> @@ -412,7 +412,7 @@ int aa_path_link(struct aa_label *label, struct dentry *old_dentry,
>   		d_backing_inode(old_dentry)->i_uid,
>   		d_backing_inode(old_dentry)->i_mode
>   	};
> -	char *buffer = NULL, *buffer2 = NULL;
> +	char *buffer, *buffer2;

this can cause an oops if buffer2 allocation fails. There are a couple of ways I can
see to fix this, do you want to take a crack at it.


>   	struct aa_profile *profile;
>   	int error;
>   


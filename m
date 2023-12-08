Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5380A54E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573940AbjLHOU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573924AbjLHOU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:20:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE025171E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:21:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2CAC433C8;
        Fri,  8 Dec 2023 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702045261;
        bh=JOtD1DOhXlfVvnrx+f1+DddFHaCUh51yjl0aSXnPpNw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=un/wZTpM6pSmFo3OZlrs+LL1GzClYj1GO/pdatQS2WgtOatGpPPindQtRwFdxaqCJ
         MDiNsQwwcV5r9O0stHddLa4yqxX0oi/fqDM/I8OhXdYeeJEyOGwv4voM8foUW/X1SF
         ao+i7f97U1I82D4P6pSaGRZXh16K0y7mFUpXjyf0ljc6Xfj6Mt/LtJY8Z5CjuHPPYn
         SZn8d/yKl6s3MUtQ8yufbp3+pZ1qfclRHgymqSlWz7nzF5zflhGA2shqtuMf8rxImr
         KMx5YQKIyiZI1mr30lDE7Nga61hTqJ9fkaTsoWSMTDLFXRFZnomHHqVQi32DHV82jD
         scjatOFlGedCw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58ceab7daddso927306eaf.3;
        Fri, 08 Dec 2023 06:21:01 -0800 (PST)
X-Gm-Message-State: AOJu0Yzol8UEc2nYj0C5jmNYW3Wl0LHOW72tbfr1RHVSHV5rqeGDeNMm
        GR9lm3Y0PIr/2XY+KAyRIv2COjsGEKpD7/uXfjA=
X-Google-Smtp-Source: AGHT+IED6wRybN3tBltD6Fig4oscaFf6bVQWuGCEEo/BkOdZILnE6MYcWJ6+EutoYFi/q45V2rPOFwPGLKIwdDQqVf0=
X-Received: by 2002:a05:6820:2293:b0:58d:6e28:853f with SMTP id
 ck19-20020a056820229300b0058d6e28853fmr184045oob.9.1702045260395; Fri, 08 Dec
 2023 06:21:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:5dc6:0:b0:507:5de0:116e with HTTP; Fri, 8 Dec 2023
 06:20:59 -0800 (PST)
In-Reply-To: <20231208065647.745640-1-linan666@huaweicloud.com>
References: <20231208065647.745640-1-linan666@huaweicloud.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 8 Dec 2023 23:20:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9t-J+BV72u_JdYD=MrOyat1Nx1=Jo8rBa59qtsrNviDg@mail.gmail.com>
Message-ID: <CAKYAXd9t-J+BV72u_JdYD=MrOyat1Nx1=Jo8rBa59qtsrNviDg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: validate the zero field of packet header
To:     linan666@huaweicloud.com
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-12-08 15:56 GMT+09:00, linan666@huaweicloud.com <linan666@huaweicloud.com>:
> From: Li Nan <linan122@huawei.com>
>
> The SMB2 Protocol requires that "The first byte of the Direct TCP
> transport packet header MUST be zero (0x00)"[1]. Commit 1c1bcf2d3ea0
> ("ksmbd: validate smb request protocol id") removed the validation of
> this 1-byte zero. Add the validation back now.
>
> [1]: [MS-SMB2] - v20230227, page 30.
> https://winprotocoldoc.blob.core.windows.net/productionwindowsarchives/MS-SMB2/%5bMS-SMB2%5d-230227.pdf
>
> Fixes: 1c1bcf2d3ea0 ("ksmbd: validate smb request protocol id")
> Signed-off-by: Li Nan <linan122@huawei.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #ksmbd-for-next-next.
Thanks for your patch!

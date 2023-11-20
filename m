Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634587F0A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 02:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjKTBiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 20:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTBiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 20:38:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FB128
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 17:38:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C454C433CB;
        Mon, 20 Nov 2023 01:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700444289;
        bh=AYOn7zw4Rj8x7zKsQ6SSA46WYucJCnvwD8FyUizIfyU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jJ0xF7gngT/5Helf9+d38ELFm8uTUDM5uHgUjV4BuJVJdzvbvbGoXHjpGWoL1+GVp
         CWFOUTbMh0PTjgLPiliivoJDHuMUtt/eougjtI7Tp5VCYStKv1Ywv2b2rUmnFMovfF
         Fqk6tb7xw0fDG9iLM7I+5UK6WRusvh1c+xf3W3rZ1PIOC226iy6H+qpo0AW4v4bR0K
         Sb59BV2cU55BiNKjeTTchFECevZwOn5WR2m6K0Gi7cYOQcmnt9LV+ZfPT0J3xNFWMN
         qK5juf5gE8fkYHnsMpdwUqFRRDVHSgNclZ4QFYIzlmNB9YNWrN1yogdOtNygJFC59M
         l5FMZxcxz5tcw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5872b8323faso2272590eaf.1;
        Sun, 19 Nov 2023 17:38:09 -0800 (PST)
X-Gm-Message-State: AOJu0YwfMntQOllBLPWzBZYzKO3AAW4a98QKoslRlfl87v/PrF3dmriM
        nkBKYgw2b+4DId/ZcxuBwRos2TipIeRHzGKt/80=
X-Google-Smtp-Source: AGHT+IFFy8xKP2w05jJE4B/6DjTdXUZcG3k+/Agv8H7RLynC5UnOV+rQcjAmCcWl6V+7kG6eTJvEs31XdreN6GhVf2M=
X-Received: by 2002:a05:6820:220d:b0:58a:703e:fbf5 with SMTP id
 cj13-20020a056820220d00b0058a703efbf5mr6524430oob.5.1700444288743; Sun, 19
 Nov 2023 17:38:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:5847:0:b0:507:5de0:116e with HTTP; Sun, 19 Nov 2023
 17:38:06 -0800 (PST)
In-Reply-To: <313c7290-1f8c-4944-a420-be23d28e59fa@kylinos.cn>
References: <CAKYAXd8qZTiSBR3aSUk4YRSo+LG-Z20FRJfGgV1Awf+Lep4kpg@mail.gmail.com>
 <20231109011725.1798784-1-min_halo@163.com> <b503d929-ff3a-4dc3-9de8-aa0eb00d181a@gmail.com>
 <CAKYAXd-2vR7KF=gwKWmA+a3XkAOG78ntPq__u4P5Kqo35N1D5Q@mail.gmail.com> <313c7290-1f8c-4944-a420-be23d28e59fa@kylinos.cn>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 20 Nov 2023 10:38:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9L7TY+PtN1c-cNtz-NL+ksZDqAMNN11LRNW-3SdET5kA@mail.gmail.com>
Message-ID: <CAKYAXd9L7TY+PtN1c-cNtz-NL+ksZDqAMNN11LRNW-3SdET5kA@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: prevent memory leak on error return
To:     Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc:     Pierre Mariani <pierre.mariani@gmail.com>,
        Zongmin Zhou <min_halo@163.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
        sfrench@samba.org, tom@talpey.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-11-20 10:33 GMT+09:00, Zongmin Zhou <zhouzongmin@kylinos.cn>:
>
> On 2023/11/19 22:17, Namjae Jeon wrote:
>> 2023-11-19 18:14 GMT+09:00, Pierre Mariani <pierre.mariani@gmail.com>:
>>> On 11/8/2023 5:17 PM, Zongmin Zhou wrote:
>>>> When allocated memory for 'new' failed,just return
>>>> will cause memory leak of 'ar'.
>>>>
>>>> v2: rollback iov_alloc_cnt when allocate memory failed.
>>>>
>>>> Fixes: 1819a9042999 ("ksmbd: reorganize ksmbd_iov_pin_rsp()")
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Reported-by: Dan Carpenter <error27@gmail.com>
>>>> Closes: https://lore.kernel.org/r/202311031837.H3yo7JVl-lkp@intel.com/
>>>> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
>>>> ---
>>>>   fs/smb/server/ksmbd_work.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
>>>> index a2ed441e837a..44bce4c56daf 100644
>>>> --- a/fs/smb/server/ksmbd_work.c
>>>> +++ b/fs/smb/server/ksmbd_work.c
>>>> @@ -123,8 +123,11 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work
>>>> *work, void *ib, int len,
>>>>   		new = krealloc(work->iov,
>>>>   			       sizeof(struct kvec) * work->iov_alloc_cnt,
>>>>   			       GFP_KERNEL | __GFP_ZERO);
>>>> -		if (!new)
>>>> +		if (!new) {
>>>> +			kfree(ar);
>>>> +			work->iov_alloc_cnt -= 4;
>>>>   			return -ENOMEM;
>>>> +		}
>>>>   		work->iov = new;
>>>>   	}
>>>>
>>> A few lines above, ar is allocated inside the 'if (aux_size)' block.
>>> If aux_size is falsy, isn't it possible that ar will be NULL hence
>>> we should have 'if (ar) kfree(ar);'?
>> We need to initialize ar to NULL on that case. And Passing a NULL
>> pointer to kfree is safe, So NULL check before kfree() is not needed.
> Yes, ar should be initialized to NULL to avoid the case of  aux_size
> will be false.
> Since kfree(NULL) is safe.
> Should I  send another patch for this?
I would appreciate it if you could do that.

>
> Best regards!
>> Thanks.
>
>

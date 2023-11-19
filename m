Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C607D7F06CF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjKSORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKSOR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:17:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E30BF9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 06:17:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED30C433CB;
        Sun, 19 Nov 2023 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700403446;
        bh=7NqbVgFEGfY4te5OX45ttPp1nJ/CKMXIyvt1H9KH6XM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=OqQHuhfzdyb6alWAFOV5H3faOpoQHYdT998Wq+pFrr7JM8W6HZ6XJYaaLeS3Ds7o6
         XoJr4j68XyEWX83lYInR0azbEn6Sj74Aw2iLtuAyGy8iu+8BoV7kjnX47gdIu+UNLJ
         icgTpJgpjuiheenr96VXszcfJtXN8jQuwZfLwNRsudrU0sw0Y1AekIyg+najkuB6LV
         uDzU2VMoMOXGZuAh+YaFUxg3TKkZ2tLAj0BeV3LDwYopWPfxmvpahAXlmG5i/R/sOY
         B/pyidSg0y7ladp+YkzLFCOsHDW8lJQp6bRWkKKgEH4kLE5/AgJgc7NAkrnfFW06ZI
         jpVVld/r3ebaA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-589d4033e84so1889536eaf.1;
        Sun, 19 Nov 2023 06:17:26 -0800 (PST)
X-Gm-Message-State: AOJu0YwDCb/ByLkj4MmF1M8Bd5WRYpV9r8MxjB6NXlWz4LW08+s3RSFG
        Toz61Q6+DKKn5Sycryf/8+PX+XKnqLWB1CTLtj0=
X-Google-Smtp-Source: AGHT+IHnTekgrbUxyqPF0IFPLtTVu0RUZzffYNzvpiICZRXMOqwhkSq7GmUVSqIpqZqw3Bo6UPlp/YyksWua1+u2JA0=
X-Received: by 2002:a05:6820:1623:b0:58a:1595:c645 with SMTP id
 bb35-20020a056820162300b0058a1595c645mr4943277oob.4.1700403445255; Sun, 19
 Nov 2023 06:17:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:5847:0:b0:507:5de0:116e with HTTP; Sun, 19 Nov 2023
 06:17:24 -0800 (PST)
In-Reply-To: <b503d929-ff3a-4dc3-9de8-aa0eb00d181a@gmail.com>
References: <CAKYAXd8qZTiSBR3aSUk4YRSo+LG-Z20FRJfGgV1Awf+Lep4kpg@mail.gmail.com>
 <20231109011725.1798784-1-min_halo@163.com> <b503d929-ff3a-4dc3-9de8-aa0eb00d181a@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 19 Nov 2023 23:17:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-2vR7KF=gwKWmA+a3XkAOG78ntPq__u4P5Kqo35N1D5Q@mail.gmail.com>
Message-ID: <CAKYAXd-2vR7KF=gwKWmA+a3XkAOG78ntPq__u4P5Kqo35N1D5Q@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: prevent memory leak on error return
To:     Pierre Mariani <pierre.mariani@gmail.com>
Cc:     Zongmin Zhou <min_halo@163.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
        sfrench@samba.org, tom@talpey.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Zongmin Zhou <zhouzongmin@kylinos.cn>
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

2023-11-19 18:14 GMT+09:00, Pierre Mariani <pierre.mariani@gmail.com>:
> On 11/8/2023 5:17 PM, Zongmin Zhou wrote:
>> When allocated memory for 'new' failed,just return
>> will cause memory leak of 'ar'.
>>
>> v2: rollback iov_alloc_cnt when allocate memory failed.
>>
>> Fixes: 1819a9042999 ("ksmbd: reorganize ksmbd_iov_pin_rsp()")
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Closes: https://lore.kernel.org/r/202311031837.H3yo7JVl-lkp@intel.com/
>> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
>> ---
>>  fs/smb/server/ksmbd_work.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
>> index a2ed441e837a..44bce4c56daf 100644
>> --- a/fs/smb/server/ksmbd_work.c
>> +++ b/fs/smb/server/ksmbd_work.c
>> @@ -123,8 +123,11 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work
>> *work, void *ib, int len,
>>  		new = krealloc(work->iov,
>>  			       sizeof(struct kvec) * work->iov_alloc_cnt,
>>  			       GFP_KERNEL | __GFP_ZERO);
>> -		if (!new)
>> +		if (!new) {
>> +			kfree(ar);
>> +			work->iov_alloc_cnt -= 4;
>>  			return -ENOMEM;
>> +		}
>>  		work->iov = new;
>>  	}
>>
>
> A few lines above, ar is allocated inside the 'if (aux_size)' block.
> If aux_size is falsy, isn't it possible that ar will be NULL hence
> we should have 'if (ar) kfree(ar);'?
We need to initialize ar to NULL on that case. And Passing a NULL
pointer to kfree is safe, So NULL check before kfree() is not needed.

Thanks.
>

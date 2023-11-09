Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4EB7E6B29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjKINVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKINVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:21:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F530C1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:21:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A101C43391;
        Thu,  9 Nov 2023 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699536102;
        bh=W4AZvq3c+e+zUfNPx/HqmVF8sPcfZIynKF5fy4rArXs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=TDznUS3WDtmh/RfJBMNwVdUUBWTT1K9qvmoZwKgxVkFf1Ky+6VbO03NtVWPF5nj3Y
         ioxdp2yHzWHocLlwjKilWzZD/4Dz+uZVQ3aO8Nrj43LZftApVsmh1ZZxC7xYylehOG
         +GVVHHkc3hBW2GHwn5uobcLYtb2DJlwdruMQiPfwqeZ8j1PfdWIkSpCwrILkRZAxkw
         baw5lsOwFH08rwuJjFP3wEyVnosY0yLh4VkZKs2PShqGE0beu4PnqLgsVb4wDlCEUS
         bCepFbYyOYdm1TNeEFkdiT7A/g83rGNNFcF2Xd/QiR/nzc7TLgkAT2qoOL3Gpn8w1d
         0zY5F7WrUPGOQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-589d6647c6cso419410eaf.2;
        Thu, 09 Nov 2023 05:21:42 -0800 (PST)
X-Gm-Message-State: AOJu0YzQ21FwELnaCzjJQ/v3eNIBaVP8KUIYXFxsTBDxBpUwDDkH4OIM
        18mhkDgvDVNC7ILIt9n3VCMcg+7mgBZa/0IK5Ks=
X-Google-Smtp-Source: AGHT+IH7IG2CokYLHaRCu9OeenBcpj7mfEXQDcnGjQjBfVBGI6VogVSVMciok3px8IofZ8eCtByfYDPc7LJsJcvhHGE=
X-Received: by 2002:a05:6820:50b:b0:581:9066:49 with SMTP id
 m11-20020a056820050b00b0058190660049mr6867673ooj.0.1699536101275; Thu, 09 Nov
 2023 05:21:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:67d1:0:b0:506:a3fc:1021 with HTTP; Thu, 9 Nov 2023
 05:21:40 -0800 (PST)
In-Reply-To: <20231109011725.1798784-1-min_halo@163.com>
References: <CAKYAXd8qZTiSBR3aSUk4YRSo+LG-Z20FRJfGgV1Awf+Lep4kpg@mail.gmail.com>
 <20231109011725.1798784-1-min_halo@163.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 9 Nov 2023 22:21:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_A-3kfK40hi9rkoKr=AVKG=_kK3_3ABbsuC0c-S6zk+g@mail.gmail.com>
Message-ID: <CAKYAXd_A-3kfK40hi9rkoKr=AVKG=_kK3_3ABbsuC0c-S6zk+g@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: prevent memory leak on error return
To:     Zongmin Zhou <min_halo@163.com>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        senozhatsky@chromium.org, sfrench@samba.org, tom@talpey.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Zongmin Zhou <zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-11-09 10:17 GMT+09:00, Zongmin Zhou <min_halo@163.com>:
> When allocated memory for 'new' failed,just return
> will cause memory leak of 'ar'.
>
> v2: rollback iov_alloc_cnt when allocate memory failed.
>
> Fixes: 1819a9042999 ("ksmbd: reorganize ksmbd_iov_pin_rsp()")
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202311031837.H3yo7JVl-lkp@intel.com/
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Applied it #ksmbd-for-next-next.
Thanks for your patch.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35BF797F8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjIHAPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjIHAPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F411BCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694132067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOvFvGw8/FO1vijWbaQPmIwVXI3UM+LlUm25ms7BiiM=;
        b=GTqVWwBAPnqSow64iRkdJ5CfpKSaqSR80RmddlOCHfh3Tt6Cdn1RaKe4nAZSsPNA6IxrKG
        ws3xEspPHZODbNscemL8gxyfzl/EtRY7pruDUi8BTv9zds24NtwEKTmcV6rInKPy5udG6E
        N3uEEy34vbPEnvkLY1BnlB3syoCemnQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-fLPRtGHSOqyXlexLLX1OzA-1; Thu, 07 Sep 2023 20:14:26 -0400
X-MC-Unique: fLPRtGHSOqyXlexLLX1OzA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5709b5ba7c9so1900616a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 17:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694132065; x=1694736865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOvFvGw8/FO1vijWbaQPmIwVXI3UM+LlUm25ms7BiiM=;
        b=nenaEjfBhpug7LXHwMgpBaDNShK+3s8UeQIQBIckbUfm1xs2BtvlAItjN/RdQYy+WB
         viwsBsxNOrGKnnjBwjoPCVs0XNP30cXVbKCv1i6G1ny9pu+00y6wseyjt2Y+nHGzQbg7
         BU/AUI7LFThSwinT78T9+NSP/ts5xL2Jx21Yj7sLuw4UiR1WGkVq5VtiLHGJ1Bik2nD7
         Yjcm5KhxlwhTR2wuCOLzpA0Y/yMSzWKnwg0IiYws9fTLNfQ9j+Co41sz1zKl6xztNzly
         QN7ecHo9dunJ9VyGBodq5wLVWhI1EuA6ZgPWfPflPx0eMlBGjYNTDXYVAU2F9IoKk4yP
         lBNg==
X-Gm-Message-State: AOJu0Yy+hYY3CheNwVr2VRZvaDIS3oYfbVlh36fjKw/hbdWr9tTJDYzx
        iXCl+gGLbhPMOKodb5AObt+DiKcEtGdetEzBunl33clpDM7teMAbJ2pWplgTBthEFNk8Y8XYUTv
        31TWsiADcmXErh5vPnmsG/uz/czHHQgxnA50=
X-Received: by 2002:a17:902:c101:b0:1ac:8be5:8787 with SMTP id 1-20020a170902c10100b001ac8be58787mr960967pli.21.1694132065011;
        Thu, 07 Sep 2023 17:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7hj58QBIaA3AcV/ZYuNyWDejDsQB3Z1u0X6g24a+1v8RI22bXHLTYF80O9ymB9xcuuxCkrw==
X-Received: by 2002:a17:902:c101:b0:1ac:8be5:8787 with SMTP id 1-20020a170902c10100b001ac8be58787mr960953pli.21.1694132064697;
        Thu, 07 Sep 2023 17:14:24 -0700 (PDT)
Received: from [10.72.112.114] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709026b8400b001bba3650448sm294284plk.258.2023.09.07.17.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 17:14:24 -0700 (PDT)
Message-ID: <3493bd1b-4982-e851-a2bc-c806889af01e@redhat.com>
Date:   Fri, 8 Sep 2023 08:14:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: remove unnecessary check for NULL in
 parse_longname()
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Milind Changire <mchangir@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20230907133928.11126-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230907133928.11126-1-lhenriques@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/23 21:39, Luís Henriques wrote:
> Function ceph_get_inode() never returns NULL; instead it returns an
> ERR_PTR() if something fails.  Thus, the check for NULL in
> parse_longname() useless and can be dropped.
>
> Fixes: dd66df0053ef ("ceph: add support for encrypted snapshot names")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/crypto.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index e4d5cd56a80b..7d0b9b5ccfc6 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -249,8 +249,6 @@ static struct inode *parse_longname(const struct inode *parent,
>   	if (!dir) {
>   		/* This can happen if we're not mounting cephfs on the root */
>   		dir = ceph_get_inode(parent->i_sb, vino, NULL);
> -		if (!dir)
> -			dir = ERR_PTR(-ENOENT);
>   	}
>   	if (IS_ERR(dir))
>   		dout("Can't find inode %s (%s)\n", inode_number, name);
>
Luis,

How about moving the error check into the  'if (!dir) {}' ? Because from 
'ceph_find_inode()' the return value shouldn't be true here. This err 
check should for 'ceph_get_inode()' only.

Thanks

- Xiubo



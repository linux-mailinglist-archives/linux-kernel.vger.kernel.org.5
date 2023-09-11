Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0989D79A0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 03:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjIKBPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 21:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjIKBPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 21:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E44F1A5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 18:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694394890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bb97qPsIUkdRhz5c90nGmBfc2QK0i/938+ljUni5KW8=;
        b=Z+5q+R6k/LP79Zym93AJQ2C2mhQJYGT88d0rvnl0HFKACTzRueuL0NC6tsyr3Plj3xcyA4
        VarXguslVfEgClQ0cyeNcNPEZT8M8afuUdERGj9T4q+kvCWEkXjEIRwsdvuwLqxf7/PX+z
        pSbXjonY2F7hfVPk82GRoKPQe4LlzMY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-TZpNRn6-MVe2nOxqzEy5Sg-1; Sun, 10 Sep 2023 21:14:48 -0400
X-MC-Unique: TZpNRn6-MVe2nOxqzEy5Sg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c387cca2d3so35571875ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 18:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694394888; x=1694999688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bb97qPsIUkdRhz5c90nGmBfc2QK0i/938+ljUni5KW8=;
        b=vlN7ngH1iYbpn7e5OJMtc0/xMPLInuKGO64+XiazcSbeUfKRIgq6oqaBHCLoKrCMGj
         aJBA9Ua3B4LrwSt89/EK5W+DGHfPedvRz4zk/ZpCnwqSYxq6PxKkCuplfkboRNmrW/TW
         mLc61Jp/+RUSr53Ay2NYWcB0DRqktcrGqwPCWqRkej7ZmWzTJCBkSh0twbuUY6Qbm1Dc
         PY/APAUpqUYcMmm6fp6wlJphpz2XTKu1BbbjlTkdpA0yLBLm+L3Q08pUUGc3LWtmUOCC
         C+XbWd5lGkDo55SKbWj1tJvxIKeo0nQUrR2aSQSMi0ilLdn9GnaJoY4MWIbSnI04KKq0
         0Jtg==
X-Gm-Message-State: AOJu0YxaM7+wFQZCIH0GmEMCavs5v4PwGjWFwCzPbxT6AHEqOjDbSWMv
        MiznTNVAMV/vrd+mblZqglvOeGf9z21PirTQCMRc8C1+l/w2hPyFOkeXFi5nhv22OWeaCMlnu9P
        ZDqepN74HwaDrfPBIa16WybVS
X-Received: by 2002:a17:902:ee84:b0:1c3:a9e5:66ad with SMTP id a4-20020a170902ee8400b001c3a9e566admr2951692pld.3.1694394887722;
        Sun, 10 Sep 2023 18:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGydIsWf6MhGMoHFwUfF9cdAgPQPpU0RJqfMkAW0ANgMvTHIR6o28WZWL8Il/2dHaHCty6STw==
X-Received: by 2002:a17:902:ee84:b0:1c3:a9e5:66ad with SMTP id a4-20020a170902ee8400b001c3a9e566admr2951684pld.3.1694394887394;
        Sun, 10 Sep 2023 18:14:47 -0700 (PDT)
Received: from [10.72.112.122] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001b9c960ffeasm5181183plg.47.2023.09.10.18.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 18:14:46 -0700 (PDT)
Message-ID: <68cb338c-f293-b69a-06f1-fc54b3be1933@redhat.com>
Date:   Mon, 11 Sep 2023 09:14:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ceph: remove unnecessary check for NULL in
 parse_longname()
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Milind Changire <mchangir@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20230908112020.27090-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230908112020.27090-1-lhenriques@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/8/23 19:20, Luís Henriques wrote:
> Function ceph_get_inode() never returns NULL; instead it returns an
> ERR_PTR() if something fails.  Thus, the check for NULL in parse_longname()
> is useless and can be dropped.  Instead, move there the debug code that
> does the error checking so that it's only executed if ceph_get_inode() is
> called.
>
> Fixes: dd66df0053ef ("ceph: add support for encrypted snapshot names")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> Changes since v2:
> As suggested by Xiubo, moved the error checking into the 'if (!dir)'
> block.
>
>   fs/ceph/crypto.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index e4d5cd56a80b..e1f31b86fd48 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -249,11 +249,9 @@ static struct inode *parse_longname(const struct inode *parent,
>   	if (!dir) {
>   		/* This can happen if we're not mounting cephfs on the root */
>   		dir = ceph_get_inode(parent->i_sb, vino, NULL);
> -		if (!dir)
> -			dir = ERR_PTR(-ENOENT);
> +		if (IS_ERR(dir))
> +			dout("Can't find inode %s (%s)\n", inode_number, name);
>   	}
> -	if (IS_ERR(dir))
> -		dout("Can't find inode %s (%s)\n", inode_number, name);
>   
>   out:
>   	kfree(inode_number);
>
LGTM.

Applied to the testing branch and will run the tests.

Thanks Luis.



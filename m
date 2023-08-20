Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6921E781E63
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 16:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjHTO7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjHTO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 10:59:41 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0D10F;
        Sun, 20 Aug 2023 07:58:38 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94ea38c90ccso64914866b.1;
        Sun, 20 Aug 2023 07:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692543517; x=1693148317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbNFg4FMsOEtDpmNGiLWQaiUGQH+kOdMIT+2KSP2jaU=;
        b=eFYz1Yycu2iYaregKMlrJ2FtfZxORKm7vSgEkxu4YMtUK05f77LeLhoSJ8uqrFOKCQ
         NNbyzNe1s0aMXG0GDS5LzC8sTM4x8UCz6wANz9xqXDWJu5IV5blZeqjfNurfZk8bvJ1j
         dTGemqIiLNxN5yCZJtfdWrZisEuk9lQPkkLuZowMZWnri/OtT2C2AfgrPRSF+r0up8bT
         ErWoXnvBN4g4Ea63QvC/OexZF/mF3rVE2O+8c7tu8VGpz/OoLgrvg3TxqYEbx72CyxLT
         NBsv3yA3H7ByEnZdMOPOqS8jh8Mv/4oOHHS9XsbSnts71vlDs1cH15cRzsLh/0mZSKWs
         zPrg==
X-Gm-Message-State: AOJu0YwQ9WkRcE8siIZbGngqufqnqTpvJayB4NSH0e7UxCiC8ZfuQYZz
        C8bqNIv2MaFNaJMsy9Fhd7zvUc1CDKk=
X-Google-Smtp-Source: AGHT+IEs2VbbrzpBE+6vpoyVdVfQITvx7jOeRoIxPgTHfLCA6rCxKbzutCXT8qsW0HasIjlnL8cdZw==
X-Received: by 2002:a17:906:535d:b0:99c:d995:22e6 with SMTP id j29-20020a170906535d00b0099cd99522e6mr3378271ejo.3.1692543517034;
        Sun, 20 Aug 2023 07:58:37 -0700 (PDT)
Received: from [10.100.102.14] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b0099bccb03eadsm4744880ejk.205.2023.08.20.07.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 07:58:36 -0700 (PDT)
Message-ID: <3713297b-a5fb-b027-c34b-d56526155c4c@grimberg.me>
Date:   Sun, 20 Aug 2023 17:58:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v2 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230818141537.22332-1-dwagner@suse.de>
 <20230818141537.22332-4-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230818141537.22332-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/23 17:15, Daniel Wagner wrote:
> Almost all fabric tests have the identically code for
> setting up and cleaning up the target side. Introduce
> two new helpers.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/003 | 14 +++-------
>   tests/nvme/004 | 21 +++------------
>   tests/nvme/005 | 20 ++-------------
>   tests/nvme/006 | 19 ++------------
>   tests/nvme/007 | 14 ++--------
>   tests/nvme/008 | 21 ++-------------
>   tests/nvme/009 | 16 ++----------
>   tests/nvme/010 | 21 ++-------------
>   tests/nvme/011 | 16 ++----------
>   tests/nvme/012 | 21 ++-------------
>   tests/nvme/013 | 16 ++----------
>   tests/nvme/014 | 21 ++-------------
>   tests/nvme/015 | 16 ++----------
>   tests/nvme/018 | 16 ++----------
>   tests/nvme/019 | 21 ++-------------
>   tests/nvme/020 | 16 ++----------
>   tests/nvme/021 | 16 ++----------
>   tests/nvme/022 | 16 ++----------
>   tests/nvme/023 | 21 ++-------------
>   tests/nvme/024 | 16 ++----------
>   tests/nvme/025 | 16 ++----------
>   tests/nvme/026 | 16 ++----------
>   tests/nvme/027 | 17 +++----------
>   tests/nvme/028 | 17 +++----------
>   tests/nvme/029 | 21 ++-------------
>   tests/nvme/040 | 19 ++------------
>   tests/nvme/041 | 18 ++-----------
>   tests/nvme/042 | 17 ++-----------
>   tests/nvme/043 | 17 ++-----------
>   tests/nvme/044 | 19 +++-----------
>   tests/nvme/045 | 18 +++----------
>   tests/nvme/047 | 21 ++-------------
>   tests/nvme/048 | 17 ++-----------
>   tests/nvme/rc  | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   34 files changed, 141 insertions(+), 519 deletions(-)
> 
> diff --git a/tests/nvme/003 b/tests/nvme/003
> index 71b82ce758a3..eed1f549866a 100755
> --- a/tests/nvme/003
> +++ b/tests/nvme/003
> @@ -22,15 +22,8 @@ test() {
>   
>   	_setup_nvmet
>   
> -	local loop_dev
> -	local port
>   
> -	port="$(_create_nvmet_port "${nvme_trtype}")"
> -
> -	loop_dev="$(losetup -f)"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> +	_nvmet_target_setup --blkdev=device

--blkdev=device by default no?

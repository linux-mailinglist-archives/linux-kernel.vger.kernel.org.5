Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA7C77A72F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjHMO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjHMO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:56:00 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023241708;
        Sun, 13 Aug 2023 07:55:53 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-522a9e0e6e9so839706a12.1;
        Sun, 13 Aug 2023 07:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691938551; x=1692543351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad0NVWbLc0DW2zExtiVlyR4ajbzJ+cjn6E663HH2QCg=;
        b=lzfT+aLnG4S/IqnFIxff4FBihzzeH9paD0Gi1CU5sP7DpGOfUUA6qK+yV/pnskK3UL
         0L8ERXphw/wrtpqO3NHAWIq3s5UE/GCvtOWlm+/HTO8+kIaknrE+veKiCHNwtC+/TXIa
         bhgh9zKRoQ2ZTmA3Mg6JFDqiqmh19TRCk9j5uOoFAUQ2Pk3HfLvkBXZx/r0HEwzSuPbc
         3CC47ReZFqqVq9BJlzDs78Pv/tPvsZhWacSjB/snYOVi3XNRg5SC70L3GBigFtBM7ydK
         Kxn9SI9LfDoixFX7+DE9EkIZpEUUn30Ta+AiMUNbWE52ay/z9DFP90npHCCoMCgvrbRO
         EX1w==
X-Gm-Message-State: AOJu0Yxd0O1XxNglro3cqPwQAPhvKCdPggLTITgSRBL4DpPxOkUYclik
        WkI2rYfJ8kN6tHI5H3t1LP8=
X-Google-Smtp-Source: AGHT+IH3JQ0kaSRLJCXCDqYhq/hqML2mvDZq457dPLaKXnmiQQaxMW8oTzpTC0DWWg3H/Y51a7PXIg==
X-Received: by 2002:a05:6402:4314:b0:522:580f:8304 with SMTP id m20-20020a056402431400b00522580f8304mr6185856edc.1.1691938551110;
        Sun, 13 Aug 2023 07:55:51 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id r15-20020a056402034f00b005255991c576sm1032584edw.66.2023.08.13.07.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:55:50 -0700 (PDT)
Message-ID: <58d299c4-84e1-603d-6c99-15d0484f9609@grimberg.me>
Date:   Sun, 13 Aug 2023 17:55:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v3 13/13] nvme: Introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20230811093614.28005-1-dwagner@suse.de>
 <20230811093614.28005-14-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811093614.28005-14-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/23 12:36, Daniel Wagner wrote:
> Almost all fabric tests have the identically code for
> setting up and cleaning up the target side. Introduce
> two new helpers.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/003 | 13 +++-------
>   tests/nvme/004 | 20 +++------------
>   tests/nvme/005 | 19 ++-------------
>   tests/nvme/006 | 18 ++------------
>   tests/nvme/007 | 13 ++--------
>   tests/nvme/008 | 20 ++-------------
>   tests/nvme/009 | 15 ++----------
>   tests/nvme/010 | 20 ++-------------
>   tests/nvme/011 | 15 ++----------
>   tests/nvme/012 | 20 ++-------------
>   tests/nvme/013 | 15 ++----------
>   tests/nvme/014 | 20 ++-------------
>   tests/nvme/015 | 15 ++----------
>   tests/nvme/018 | 15 ++----------
>   tests/nvme/019 | 20 ++-------------
>   tests/nvme/020 | 15 ++----------
>   tests/nvme/021 | 15 ++----------
>   tests/nvme/022 | 15 ++----------
>   tests/nvme/023 | 20 ++-------------
>   tests/nvme/024 | 15 ++----------
>   tests/nvme/025 | 15 ++----------
>   tests/nvme/026 | 15 ++----------
>   tests/nvme/027 | 16 +++---------
>   tests/nvme/028 | 16 +++---------
>   tests/nvme/029 | 20 ++-------------
>   tests/nvme/040 | 18 ++------------
>   tests/nvme/041 | 17 ++-----------
>   tests/nvme/042 | 16 ++----------
>   tests/nvme/043 | 16 ++----------
>   tests/nvme/044 | 18 +++-----------
>   tests/nvme/045 | 17 +++----------
>   tests/nvme/047 | 20 ++-------------
>   tests/nvme/048 | 16 ++----------
>   tests/nvme/rc  | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   34 files changed, 138 insertions(+), 486 deletions(-)
> 
> diff --git a/tests/nvme/003 b/tests/nvme/003
> index 71b82ce758a3..54e5fe651c9a 100755
> --- a/tests/nvme/003
> +++ b/tests/nvme/003
> @@ -22,15 +22,9 @@ test() {
>   
>   	_setup_nvmet
>   
> -	local loop_dev
>   	local port
>   
> -	port="$(_create_nvmet_port "${nvme_trtype}")"
> -
> -	loop_dev="$(losetup -f)"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> +	port="$(_nvmet_target_setup --blkdev=device)"
>   
>   	_nvme_connect_subsys "${nvme_trtype}" nqn.2014-08.org.nvmexpress.discovery
>   
> @@ -46,9 +40,8 @@ test() {
>   	fi
>   
>   	_nvme_disconnect_subsys nqn.2014-08.org.nvmexpress.discovery
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> +
> +	_nvmet_target_cleanup "${port}"

It is very very strange that _setup returns a port
which is passed to _cleanup...

I think that _cleanup should simply remove all
ports, and that setup should not return a port
to begin with.

If someone needs the actual port number, then it
should either not use this _setup helper or
query it somehow.

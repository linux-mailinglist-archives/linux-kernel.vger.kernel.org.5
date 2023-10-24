Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739117D4CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjJXJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjJXJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:51:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553B810C2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:51:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4084f682d31so31488195e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698141089; x=1698745889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dlhk8Z4MNGAJNlAwZKSD8+Gfu1Hv7jMp2quDDwwtBiw=;
        b=QWmAcWMh7lyB1SpYJcoXvFp2ArSXQZm2+sPI/ZE6sadQyBBkUCVGBgeEiivbVQzCZ8
         bpNwNrON6rJKI7kpwD3ZhhE7/+wnO7yDo1DbJaZK4VpBqbP1DpYrd9V3FqaX+C3foA8U
         kTccY4Saos/+LnSgoK1tFk4nbki1//QPaDkIBWi12ccMG+YlwvHCnAGlPQquFe6dNXSw
         ZnOmE1h8bDFsLWLBj0PaWzABy9zFwN2JssZTPIuwrlrh2HIoh8F1cuEgPs/ePTbtfu5Z
         Cq3Sc931mVwPlgA8fjRnKd5m91PLVF0LUuwB05AYCQhfDjx3nQswh3thQkybqVZWqTpG
         qgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141089; x=1698745889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlhk8Z4MNGAJNlAwZKSD8+Gfu1Hv7jMp2quDDwwtBiw=;
        b=O4gLmKsd60KK2A2Tt+bCTajVDETw2v3ezk4ghgtRSkLTNG5Ojg1s7FsQm4Uio+f1FF
         SSfTj4O/tJzNaeXANO7x+ZOxW6RYrd3hzCkrTXUknJ2FtNEG9lH5NJ9u5Gm6s9/f3TH2
         Zdt/7wkJLIwDHJ/FxhNC7FnoOAnIfvo+f+0MgrNzYzOOXHxSXGQgqKUGdXzCJFka4psi
         6x9uh/CA+nMvEt/3Z3WwzchPxcfRNmoE3S9Js+eyCdKhHR88WVLTOpyTSIka5x7pr+Ce
         +ib6iSezloLnyjq/+7dYWKZW+SZP3+FmIgP4/KKlLQneC4IC9twALg4Mxi1DP4DaZz87
         GRsQ==
X-Gm-Message-State: AOJu0YwBGAQAfaK1u1YdCz6Pl65oyNfuAlObMWucIfur+WahmQc0ffTZ
        HOoR5eoMMPONt+ZZGj9Nh3r94Q==
X-Google-Smtp-Source: AGHT+IH9Kj04S7itMREQN6Y5d8cJZTKSFimqEcnJnixpWHPoL9XRQ/FUmKNnXVGhJvgXj2558wkCTQ==
X-Received: by 2002:adf:e34f:0:b0:32d:a781:111 with SMTP id n15-20020adfe34f000000b0032da7810111mr8671201wrj.15.1698141088754;
        Tue, 24 Oct 2023 02:51:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d60d2000000b003248a490e3asm9544652wrt.39.2023.10.24.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:51:28 -0700 (PDT)
Date:   Tue, 24 Oct 2023 12:50:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>, Simon Horman <horms@kernel.org>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 08/11] net/mlx5: devlink health: use retained
 error fmsg API
Message-ID: <8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <20231018202647.44769-9-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018202647.44769-9-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:26:44PM +0200, Przemek Kitszel wrote:
>  	if (rq->icosq) {
>  		struct mlx5e_icosq *icosq = rq->icosq;
>  		u8 icosq_hw_state;
>  
> -		err = mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);
> -		if (err)
> -			return err;
> -
> -		err = mlx5e_reporter_icosq_diagnose(icosq, icosq_hw_state, fmsg);
> -		if (err)
> -			return err;
> +		mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);

When we remove the error checking then Smatch correctly complains that
icosq_hw_state is used uninitialized.

    drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c:268 mlx5e_rx_reporter_build_diagnose_output_rq_common()
    error: uninitialized symbol 'icosq_hw_state'.

> +		mlx5e_reporter_icosq_diagnose(icosq, icosq_hw_state, fmsg);
>  	}
>  
>  	return 0;
>  }

See also:
    drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:229 mlx5e_tx_reporter_build_diagnose_output_sq_common()
    error: uninitialized symbol 'state'.

regards,
dan carpenter

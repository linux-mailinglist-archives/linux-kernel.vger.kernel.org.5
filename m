Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0950C7CC1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbjJQLRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjJQLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:17:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23853B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:17:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so9425480a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697541448; x=1698146248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xoNZj4QGVuc+WTAjqvHZThErSmETA5UdZcMfunvG2xw=;
        b=y++WcQGhv+NzejORDVSg4AJ7pLNm+hM+IukC4gz7MmHloEhVJDPM9u7Ie5cyNclwvu
         n39k1NKWso5+nWg+PuSVWefPV60/rzutIg5CHeHGvg8PbLU+UKeIt3jx0uvan9BHf73j
         AzyR8f3hV5EjBYzZsn/GsfK7JDZ+fhroWphu4FDZdgqYo7nQ4is9ZPcZ6Vj8O/IGvRZg
         I5F4oUR3tJPMyTt2CSNJ43q2wj87LXUvpEggQ7xBkpAWBOLC50n4hPxhLAkbMT86WC9A
         CswC/yMHHb+GodM5O24P2U+1dmTZud+D9YcoWeujQMlNBWEuZeyLI/S3jQOGWI4aDwHm
         uc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697541448; x=1698146248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoNZj4QGVuc+WTAjqvHZThErSmETA5UdZcMfunvG2xw=;
        b=bzdyxJAmbvcgDchukPSU1doGHIGhsPJKB/9lUDPm3wt4BfCZ36E4YpnkcVcxA1KbUz
         4qHJHYXSMJ18DtVtsjtIGqP4sj49dEeKFeXogMQv4fr6u4XRTxwH9ByNBtz8AMHY+gcV
         sc2IKMzWcHyoyKwplAS2CVgFuQ/UfGZjfcBsdF5pwpPnZ/tQlXdQ0QXPabJEezVXMFTk
         qyEtT2l1hW//yGg8m+apTerrmL2e9PJiJLpeAXqZZLRWAIUEu5ppv2RA47CM+J4mHkc0
         O6SN07FU00YLnsB8htBGSOAq9rnXdbLec+1IJBXGQw17106USO0gouIcZzXUmTqstSRX
         yeNA==
X-Gm-Message-State: AOJu0YwrFFcVqJnhmg0Cbb4DDmfD9twrNDpy/SFr1ej5GcZ1mZfxcgOi
        aVmnkKSqyHo/gEDM0p9oAlJMJg==
X-Google-Smtp-Source: AGHT+IG3/KAVejqxiHDYDaU+1mr0h2tuN+RNmnmZBjgu6istFJeg5VFePILcc1tKt7ebGNBy1JPcUg==
X-Received: by 2002:a05:6402:4303:b0:534:78a6:36c4 with SMTP id m3-20020a056402430300b0053478a636c4mr1585706edc.36.1697541448551;
        Tue, 17 Oct 2023 04:17:28 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cq23-20020a056402221700b00533dd4d2947sm1017926edb.74.2023.10.17.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:17:28 -0700 (PDT)
Date:   Tue, 17 Oct 2023 13:17:27 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
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
        Coiby Xu <coiby.xu@gmail.com>,
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
        Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/11] devlink: retain error in struct
 devlink_fmsg
Message-ID: <ZS5tR1z5rHuD8BFD@nanopsycho>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Oct 17, 2023 at 12:53:30PM CEST, przemyslaw.kitszel@intel.com wrote:
>Extend devlink fmsg to retain error (patch 1),
>so drivers could omit error checks after devlink_fmsg_*() (patches 2-10),
>and finally enforce future uses to follow this practice by change to
>return void (patch 11)
>
>Note that it was compile tested only.
>
>bloat-o-meter for whole series:
>add/remove: 8/18 grow/shrink: 23/40 up/down: 2017/-5833 (-3816)
>
>changelog:
>v2: extend series by two more drivers (qed, qlge);
>    add final cleanup patch, since now whole series should be merged in
>    one part (thanks Jiri for encouragement here);
>
>v1:
>https://lore.kernel.org/netdev/20231010104318.3571791-3-przemyslaw.kitszel@intel.com
>
>Przemek Kitszel (11):
>  devlink: retain error in struct devlink_fmsg
>  netdevsim: devlink health: use retained error fmsg API
>  pds_core: devlink health: use retained error fmsg API
>  bnxt_en: devlink health: use retained error fmsg API
>  hinic: devlink health: use retained error fmsg API
>  octeontx2-af: devlink health: use retained error fmsg API
>  mlxsw: core: devlink health: use retained error fmsg API
>  net/mlx5: devlink health: use retained error fmsg API
>  qed: devlink health: use retained error fmsg API
>  staging: qlge: devlink health: use retained error fmsg API
>  devlink: convert most of devlink_fmsg_*() to return void

Looks great.

Thanks!

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

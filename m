Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7507F3150
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjKUOmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjKUOmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:42:49 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184B79E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:42:38 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a9541c9b2aso53914039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700577757; x=1701182557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgSwU2wjmRzA6RzqAcEMU9EpGu84w83u/YmCrCrTRVc=;
        b=MqyXD354+ZkPfKBkUd3tC7UHh1hIMqRNNFnDv05Q6PooI0pA/VMaiRoljmWWOsyJvf
         K0bTcsK+BQ91pwkq0wiWPY75CVq2hRqYhNDZ1yQTKEwayV036/wWuW2fmhAqjz1AfiGK
         Ve+MpJHdbjlcMrDs5BeIsJXeI8RzCtbzPECSPcLpd8gyPFrMGQIaIcWZw76qhLihDaAw
         +6jTq9pyn+OLlTiZn8jq3gtRLJb2rv9b53EsFl+vqSPxquaRtgqPH+ingIPJQg7nwMy8
         zzdjULi3nJZwoBVFYIheQ+qZpHtOgp/uvYx7SxhTvCd3LtGX/x2v1MzWEIx+D+gweh8t
         b+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700577757; x=1701182557;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgSwU2wjmRzA6RzqAcEMU9EpGu84w83u/YmCrCrTRVc=;
        b=VV2RTtLF80cyNsUwUGeoFl9dpsvh11JXx2x/ABZu/7lDAkRbdOBkzelAH2cUC6ZCPy
         vnwxKrx3/SvkAFdJEGxyHetcVXA8V7x7qS8SjoJBxLW19mAXLzsWJIe4acvEXTmB/P+d
         ZQpN/wfr9xcljvz8QDQcxbGM2KJUeg8dMje5wxmkOcLVt49ja3a5cvJBHRanMN+wO34C
         ht70LETJdxTFpby6pYL45z4MOWHzK1L9E4J0E0C3p3pGmiYXxtycxksgOpLYdNJDFmXk
         l7N17k/gqCm3G0t2VpzTVEF00c6j5fYZ9+MPlNN/xTaDq4dsrpPZAN1vjNI2uf7on9k5
         p/1A==
X-Gm-Message-State: AOJu0YzXfOrFIoQRZdrJgGVRUx5hxUidYrVqmCbSdK9MfKfQ8v2u0TPa
        rWFx2D+prcUqK9MeMom3xltoENJEQq2uz4D/1fqz8w==
X-Google-Smtp-Source: AGHT+IEEmIAZAYZgOvVGMKlcTAnQdAbmk+xo/5J9j5adJQMyuSUcAXy3WQ87OhmLmjTMwEB7mBPsrg==
X-Received: by 2002:a5d:9b92:0:b0:7b0:acce:5535 with SMTP id r18-20020a5d9b92000000b007b0acce5535mr7649795iom.1.1700577757029;
        Tue, 21 Nov 2023 06:42:37 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j14-20020a02cb0e000000b004665ad49d39sm1187305jap.74.2023.11.21.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:42:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, linan666@huaweicloud.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
In-Reply-To: <20230911023308.3467802-1-linan666@huaweicloud.com>
References: <20230911023308.3467802-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] nbd: pass nbd_sock to nbd_read_reply() instead of
 index
Message-Id: <170057775563.269185.521615863055260084.b4-ty@kernel.dk>
Date:   Tue, 21 Nov 2023 07:42:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 10:33:08 +0800, linan666@huaweicloud.com wrote:
> If a socket is processing ioctl 'NBD_SET_SOCK', config->socks might be
> krealloc in nbd_add_socket(), and a garbage request is received now, a UAF
> may occurs.
> 
>   T1
>   nbd_ioctl
>    __nbd_ioctl
>     nbd_add_socket
>      blk_mq_freeze_queue
> 				T2
>   				recv_work
>   				 nbd_read_reply
>   				  sock_xmit
>      krealloc config->socks
> 				   def config->socks
> 
> [...]

Applied, thanks!

[1/1] nbd: pass nbd_sock to nbd_read_reply() instead of index
      commit: 98c598afc22d4e43c2ad91860b65996d0c099a5d

Best regards,
-- 
Jens Axboe




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD68279B59B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbjIKVkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbjIKQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:15:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86281B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:15:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52e297c7c39so5821879a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694448919; x=1695053719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYDGjPvAsusOGB7j7DcK3nJZSfXUha+a9/zNHj7uGhU=;
        b=xJsSGmsuTCSkwpIw8i11ri9xXvadW61m8SU2gcX8PO5ZKF4x9ZGtQNPfvhjy8AyKt5
         9d2bwVGm7qa1Zq4p910mCPBROzd5oub/GFarhi4YDLWXpOmz16LvtFUByrNQ3Xp1aHiX
         Fn4j3DtVvW2dKcPlT+tSlBeCnCLzTI4DNw3v1QQ4b/RqC8+GcFDKHSyH9/eKB0md7kPB
         MhdYZdivRX2zrdFvi8S3yGvceECITFr8Ztgi0AAPsTtGsLsmzGl+WZrXnUAWcHoSdFWH
         5E15VmVCMI9QtnJZxzKfAMeE1QYiz34dJ0Rq86B7fUq+OqV8EG3m+olgQQ5MPS/mMSgE
         lsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448919; x=1695053719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYDGjPvAsusOGB7j7DcK3nJZSfXUha+a9/zNHj7uGhU=;
        b=UjTc3F5KJ3OEtB5lCEhzScAoeetrocJiuJxfhxuOtIjI7mvxYEPL8Mo2MM1VXu8vNj
         W4dkvDDTDoXrtHw0iuuHFNSj/TAk+ljzML2nyOGaXWhy3PyIzVRh74O/OdEKR1q1Zt9r
         yV1odZNVC1Zvk1CyQRPAa90doVEIKNOsYmJGey0xl5ENnRcW8iAEUQpKF27zl/aFAsNd
         VjuBLhVKsvb8MzGR8R5pFrc5pzEYclvbeoTQu4KCFyNW7PnxZANBesv69zgKQbnyhfdT
         mWkK1aaaG8A4CffKTasdAH8jJyir9+VFqaiFlPfiaVOGW1dKgxLBNPqwJyDim6tKniS1
         VdMw==
X-Gm-Message-State: AOJu0YxU91SH5T5zEWxWuGomH5v6LNCdM7Yoj4tVrcTrE72dI0Xh1nNK
        p6ljyvk9wO2hq+JT7krGSYdDSQ==
X-Google-Smtp-Source: AGHT+IHIkFPvoSy5xjebQpvv3/QLEOAjuwHInhCr5Yl6PKK9Ai/V/LGaIu1O/SIV1icHU3XfyHHxMw==
X-Received: by 2002:aa7:d5ce:0:b0:523:47cf:5034 with SMTP id d14-20020aa7d5ce000000b0052347cf5034mr8933651eds.34.1694448918910;
        Mon, 11 Sep 2023 09:15:18 -0700 (PDT)
Received: from fedora ([79.140.208.123])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640206cd00b005256771db39sm4816471edy.58.2023.09.11.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:15:18 -0700 (PDT)
Date:   Mon, 11 Sep 2023 09:15:13 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
Message-ID: <20230911091513.4f2f2aed@fedora>
In-Reply-To: <20230911082016.3694700-1-yajun.deng@linux.dev>
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 16:20:16 +0800
Yajun Deng <yajun.deng@linux.dev> wrote:

> Although there is a kfree_skb_reason() helper function that can be
> used to find the reason for dropped packets, but most callers didn't
> increase one of rx_dropped, tx_dropped, rx_nohandler and
> rx_otherhost_dropped.
> 
> For the users, people are more concerned about why the dropped in
> ifconfig is increasing. So we can export
> dev_core_stats_rx_dropped_inc sets, which users would trace them know
> why rx_dropped is increasing.

ifconfig has been frozen for over 10 years, and is deprecated so there
is no point in catering to legacy api's. There are better API's such as
ethtool and netlink that can provide more info.

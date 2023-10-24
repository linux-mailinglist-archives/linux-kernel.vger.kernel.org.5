Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E87D4416
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjJXAfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjJXAfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:35:08 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102D8FD;
        Mon, 23 Oct 2023 17:35:07 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3573e6dd79bso14155485ab.2;
        Mon, 23 Oct 2023 17:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698107706; x=1698712506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe1cBVUYUBVEHWHBgBiCCusgXLHqv806hVr5v8bqXiI=;
        b=UpqdOSegzotdiTm21JQeOCcg0fl0x5WeU+AkXGjzMCx+FoMpxgJSLipy3W2SoZcDQq
         teIx4UbXlS8urzCu4Di1p8TGsprbQI1M40dQlHUsM8doPX3VnrjRRnG2YX5wI/VXheme
         vAt3zOoW91vwIxjfG9qeYjalziF2ZvY5xbx2bHbSGY193YUM/d+XwsziRON3z4SaeVkb
         spt6qsk9hHFUgdzcD5wy+/E4mE2nWpeksdnrOOIkT7Xxvg9+TT7w6tf7sh+xfzMuMGay
         WDFmjs7VPZClZunVk0Sh8zY5uKKdsApwbstvE28BYDhR0jx0Z5X1riiJ5db+PL78W7Gt
         D+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698107706; x=1698712506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe1cBVUYUBVEHWHBgBiCCusgXLHqv806hVr5v8bqXiI=;
        b=GOjSG1zgvmT+ZQnKVI/4wPyMfzn+7wv2+He/TnnDt7JTMSbKKmG6tAZ6vdjc3Exy1G
         EcsdLqkl4MTE5Ll+fptt0tvSRfvx9JSCBqkqZp/5+ri/5Or5djXoOIh9FO/rgwAW3i85
         GC/C8SW/MlJb8VJmGvl/NNWxl6f/0RhshXxAslD/KRUMhceKVvlGeKMlB3OyFZ1a5UIx
         c/L1N6wKxjw5HM+T6QiSnudXGnAi7PQf3ey4WKKzMg7lGIAB696bS+FdsILRNKbLZwfj
         tf468D5pX26wRQ9CuwVXNsU3REqWPlIL917wbuYjr6KkYJheAC21P6hgkgXSC185zmF9
         nvtw==
X-Gm-Message-State: AOJu0Yx3drD6VZ5N+6ixIChAAn6QoZNV+tpRvFHH+pa7JjsFb//rAuNi
        dEo6QY3VAOK/H7GwoRl1Msg=
X-Google-Smtp-Source: AGHT+IE7vZ8YXjfUC7cr3qjF3GFmbjrgf6ZayozQbTesq2aRI53rTKfKOrKkGPFfbIzKWDdhaCwu3A==
X-Received: by 2002:a05:6e02:1c85:b0:350:e9c6:e765 with SMTP id w5-20020a056e021c8500b00350e9c6e765mr13441217ill.11.1698107706384;
        Mon, 23 Oct 2023 17:35:06 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id x12-20020aa79a4c000000b006bf536bcd23sm4744219pfj.161.2023.10.23.17.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:35:05 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     kuba@kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com, richardcochran@gmail.com,
        syzbot+9704e6f099d952508943@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com,
        wojciech.drewek@intel.com
Subject: Re: [PATCH net] ptp: ptp_read should not release queue
Date:   Tue, 24 Oct 2023 08:34:58 +0800
Message-ID: <20231024003457.1096214-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023093334.3d6cda24@kernel.org>
References: <20231023093334.3d6cda24@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 09:33:34 -0700 Jakub Kicinski wrote:
>> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> 
> We need a legal name for the signoff, not initials.
You may have some misunderstandings about my name, AD is not an acronym. 
This is my full and legal name 'Edward AD'.

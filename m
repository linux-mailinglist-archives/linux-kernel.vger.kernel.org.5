Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BAF79E54D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbjIMKwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjIMKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:52:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102C819B3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:51:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c3d6d88231so14244915ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694602299; x=1695207099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAOrPSsOrrtCdgcdNBhBIJ9lMgP52ECzfG7iAGXlHhI=;
        b=PrBxWXQjm37HDiomZUuS/RSeHfoTysiLaA5MC3MqDrO5EL6zDFVeNsgQ3pE8sbxI8+
         FMtOlbvDK47KQkgbaQcD13/lcV0EzbnKv6gqpxUSgh+z//stJ4iy+TeYhjc01HscGlXD
         xdA0RskyqA1pgcdhglDQYMkKJ+0ICbTyYRcGwio50OLjFDaucWjMUJfMxpTZ8+0NxrA1
         bbqlylaRYXGPeFe3xuRGJ2Gv8Zf+/yTETthzfLPWPsmBu+xkUnZbNdavPb5iq3mPvJFR
         WIc0hOTznD25P2n3e3Hcn4R6G3NCn3OSa84zKbLy94L/zPIcOdDS6rssJL9LBbiVl3ga
         +q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602299; x=1695207099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAOrPSsOrrtCdgcdNBhBIJ9lMgP52ECzfG7iAGXlHhI=;
        b=vFwfHvZAfokIRVummxgdtp0a1aPLu2ks0up7aRt5uXK1y75b4dIJJToabZtajqbBOQ
         /YjLk0c+6d4n8J13OUuWWNrvwApOSqUqfJFIz4KB5F7tlbsVwDhYJwl1Y8tl0X9a5VvS
         qAhZJxn7kXZQUOezbWDPgc86k0dDQj+4s06mU7z8BgLsS+TDyxhpPJeHEbLJJgblz1YN
         66N/WOg1VDeBQJU5lNdrQXLkmNC2msMbpzLUoHgkkKH7luP7+5HZnTavN9OAjttpiHoX
         2xa4cpk8Bczp6Yin2DWOf38c0kuMJKf0n6n2CVH7VDXTflccJI+iSFWwUocKJZfq1d59
         eqbA==
X-Gm-Message-State: AOJu0YyUwp0SJ2ancFt2rsr+rzMyWgXLOthQbZ9G0bFxyTQXIAKvvR60
        DT1uQR7xGzaEgolEVuQuvzM13A==
X-Google-Smtp-Source: AGHT+IG5P+8z++2ruiY2+YiHv5iAfClOm5tGRcqgrHkDNSB8yf9zLHGTMaj/HADdjZqYExM3z36hlQ==
X-Received: by 2002:a17:902:d38d:b0:1c3:f4fa:b1a2 with SMTP id e13-20020a170902d38d00b001c3f4fab1a2mr68430pld.8.1694602299532;
        Wed, 13 Sep 2023 03:51:39 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([220.243.131.6])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b001b8b07bc600sm10187493plh.186.2023.09.13.03.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 03:51:39 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     jonathan.cameron@huawei.com
Cc:     catalin.marinas@arm.com, guojinhui.liam@bytedance.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH] arm64: cpufeature: Expose the real mpidr value to EL0
Date:   Wed, 13 Sep 2023 18:51:33 +0800
Message-Id: <20230913105133.2902-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230912115116.000049b0@Huawei.com>
References: <20230912115116.000049b0@Huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As a follow up question, is there some information that is missing from
> current topology description?  (there is lots missing but I'm curious
> as to what might matter for your use case!)

We want to know the infomation about dies to advoid memroy accessing
across dies (some settings like 2 numa per die).

thanks,

Jinhui Guo

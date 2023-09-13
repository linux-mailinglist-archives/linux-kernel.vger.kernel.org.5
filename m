Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC86D79DD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbjIMAXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjIMAX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:23:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892A18D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:23:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-564af0ac494so4511955a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694564601; x=1695169401; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOhmKDFFhYcx1y8tO/VRSWiRCjqVz75pT0zsg6b/Xa4=;
        b=kxDuKDzS2rQfuxEg7YjIUSGkVgueV0ZCx3nd9NBMNRDPe61Z7XPjK9DFOhLNweDMG8
         w7PPW2QdSGxWLZZLCLpfhz312IojnkHuOeYeLfvziL+gOonc6XedMfxP8bBZBhW5OfvN
         DdSeupzq1hGvlupbbf3zaZ0UBXrd0wx5y8X0rve0ISwuVZGeQcxNX7sGy/YoSHuUeKMr
         ApKo18SsdCrkFfIC6Nq0aHoEvkL4WjJxvIEk4rnsLs20Fz+QemDKw38EGyqpqApA1MO3
         D/3PdJcDWlsQnYYVEYWIYnFYfvuecSUZdEpksqusCH7LFtVcnjLKV+F8q4v3uAEYxGPi
         nTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694564601; x=1695169401;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOhmKDFFhYcx1y8tO/VRSWiRCjqVz75pT0zsg6b/Xa4=;
        b=k8X7DgoXfqOOhPz7cyDa4Vt8KQOD+RdRkxF1G/+cRa6vr6Mvqqj4v3B82eTyLeTIE2
         TSXRV5+OHmeVjGHgdfYJDPlkDf0IaL9hYvJZ3WpLY//W7r7DJ1qT5ogJPyQT2BeSBYUZ
         JNKT2acnzGlI2VJpyjT1W2se1LwTR7nrL59QmpRLvzxoyByim04/WLBFAZZyCbHMuKOd
         GN59RX12dmK79esFZPkulae8OVmTHO3ghenh4DFqGQNwdy5w/FwsI4tKSYVqY25ZZ4cI
         F8TLkaRW8ZIlqt3Btvao5h/x/j4njh5nMeNhp2tIWIPMQFup/rHHhKW7GBXLCQ69UxFl
         hiNw==
X-Gm-Message-State: AOJu0Yw+Vb+VM9+fpYv6ExJPdJ30RouyB4o1JvTEhEFu4KJEfhczMuOM
        xmoYKG6+YKu5qkl/hCZgfH+mMQ==
X-Google-Smtp-Source: AGHT+IHtksDvrtXTyIosszVXb6/me1pri1h0SIKokQujnOEaOSA3YgcIcCZk09BGD1oo+8W2bOSiJQ==
X-Received: by 2002:a05:6a20:e122:b0:14c:6a05:dfbf with SMTP id kr34-20020a056a20e12200b0014c6a05dfbfmr1277340pzb.60.1694564601481;
        Tue, 12 Sep 2023 17:23:21 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id j13-20020aa78d0d000000b0068bff979c33sm7866199pfe.188.2023.09.12.17.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 17:23:21 -0700 (PDT)
In-Reply-To: <20230912072410.2481-1-jszhang@kernel.org>
References: <20230912072410.2481-1-jszhang@kernel.org>
Subject: Re: [PATCH v3] riscv: errata: fix T-Head dcache.cva encoding
Message-Id: <169456458177.23158.17807764760843101758.b4-ty@rivosinc.com>
Date:   Tue, 12 Sep 2023 17:23:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 15:24:10 +0800, Jisheng Zhang wrote:
> The dcache.cva encoding shown in the comments are wrong, it's for
> dcache.cval1 (which is restricted to L1) instead.
> 
> Fix this in the comment and in the hardcoded instruction.
> 
> 

Applied, thanks!

[1/1] riscv: errata: fix T-Head dcache.cva encoding
      https://git.kernel.org/palmer/c/8eb8fe67e2c8

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>


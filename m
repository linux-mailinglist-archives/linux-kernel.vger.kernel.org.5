Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7204976EDC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbjHCPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbjHCPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:13:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D0E77
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:13:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so7606225ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691075635; x=1691680435;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXVrhCdWLLKcnhxRquAkFhWRRF3he8a60KQeGx3CPwQ=;
        b=xMOWHjzhIFADI7yI+bdkuIUrM/IveX3fQo2nyRKXgK9FIXFeon8fFR3RBwpf2xJQQo
         CEmugwQXRO7kOib8f9JtuiUYixYu3qPrGAs7y8mjk54HnrQ28GzK9peVfLzRkMDPY8hy
         GY9Z6vxcNi3J8Q8L1LH4ZhQNk+/eVY32xwLCwVsNUK3/x6s13Q2VIX2eIY0uiFX1ANiC
         g/wHAkQR2RLIL48U4u+Y+f3F7zr/NCKZ0y8gkruv5gJ5KirmEN9SvfUYJP3xCbfXkpWB
         AcJKFSd221SCMZbRzA42l7nX1zwjQFreqtUsOvqKX1v5D/OE+rorkr4BOc/6qxoDGCES
         CGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691075635; x=1691680435;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXVrhCdWLLKcnhxRquAkFhWRRF3he8a60KQeGx3CPwQ=;
        b=KpEXdtDePdaCW58hpFE9sSrIdzmUbT9pJiasGOZUTCRAR/5/GsMdA7bnYiV7QbZ8id
         qdDf7l7JD2nITJiebptyBp5RtSd003wQ1Xy6lu0hkAunxlD/4LG68ig4vCC7YPIOYjN5
         hrS4ipMxqsPPr8FdRGMPjNViml7KYk9r8IHpWS9xPVoprxJ+t3Wi8sOuxJggrbotQSA1
         hKHRxPTML3aaW04cM2kcuiHygVP0/l+oQIbSn08QBRTBmxqajtCBFP1KGoKYVVLEeYe2
         4zV7KFlPhleWdd71iYhGrxJBfL7mK8WyCBoMpRjXkazeY0ZYhR/xtOQj3f0wmrIdnna6
         I6rA==
X-Gm-Message-State: ABy/qLYfwbRHJZ2y/xiNzOzsin8C/eV5cfMPBhwtYaucDBp+2IyH+0JC
        cQWRE9vcLQbQt3MNtqHYQZwenQ==
X-Google-Smtp-Source: APBJJlHJCfL3eK3xXZPgRUSQoa7EWdazreYMd8M6jEbaOfDL0ZFs9AZ4gB01lCbcEKywUcJVa8l19g==
X-Received: by 2002:a17:902:e803:b0:1b7:e9e9:1004 with SMTP id u3-20020a170902e80300b001b7e9e91004mr19161935plg.30.1691075634839;
        Thu, 03 Aug 2023 08:13:54 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001bba7aab838sm14478969plg.162.2023.08.03.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:13:54 -0700 (PDT)
In-Reply-To: <20230704121837.248976-1-alexghiti@rivosinc.com>
References: <20230704121837.248976-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH] riscv: Start of DRAM should at least be aligned on PMD
 size for the direct mapping
Message-Id: <169107392510.27633.6639433423515028183.b4-ty@rivosinc.com>
Date:   Thu, 03 Aug 2023 07:45:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Jul 2023 14:18:37 +0200, Alexandre Ghiti wrote:
> So that we do not end up mapping the whole linear mapping using 4K
> pages, which is slow at boot time, and also very likely at runtime.
> 
> So make sure we align the start of DRAM on a PMD boundary.
> 
> 

Applied, thanks!

[1/1] riscv: Start of DRAM should at least be aligned on PMD size for the direct mapping
      https://git.kernel.org/palmer/c/9d3e8e1ff0d8

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>


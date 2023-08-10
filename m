Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322AF777973
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjHJNUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjHJNUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:20:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A41703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:20:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6873f64a290so208465b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691673606; x=1692278406;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kszi551Bnv//ecnL5T0Ia/HMxSS++L9RDvCtNNeu7ho=;
        b=nOU7uTiUZXDq+Z3ZyVKsMnWhXNsV7rj0DtWVjzvCnucVysgaiOQB1iXkjT5of2brT0
         Abw5dOK+Ug5mbraSEKdZs5Y9hOZ0+ySplatRELT0EJv9MjHKkuWzymcumEUEGr+BUFwj
         6SU1+RNHLu2NMLkpwUDgduyL31ynvtYi/hy4U5HXbZZ+Fpn9qoNgU7Yk5jpFiW57QLJA
         L3ZBkyk1F+jLoNSA23kn0NrCgsJJVufUK60qSot2cPAJblcmtrrpMY+YZsGF31rCcoSS
         nXNg04U9UzeKYUH4ZJK+w52N3yoLXJrhvTiQPeVg/IcE+Pi+HcE8HPPq+fX0zjU4+qAQ
         gAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673606; x=1692278406;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kszi551Bnv//ecnL5T0Ia/HMxSS++L9RDvCtNNeu7ho=;
        b=DWyEDwUM29+Prz5jxbKenqmlLI5zWxYrpE8uxYBqgELwJ/BURon7xTPoWqj5KpCfvt
         VoEhfVc3FkAsrpie3YFHdznfUOEQU6WUy2ry1q9/2QKDkaBWXZv8GHEoaQei+8UixDiJ
         jA6qdwcalXBg3Ea78B0+FzAoicN0STSInsbhSul5lq4htkmtC/l11tlSiTIFoKrEr2A2
         EB6JNd0CLOeAAaihoFC2a31lIe4qDVn9Q0uWnNasYFKqosgrqsiGfOt4WyKKaht0tj9f
         1waaDXb7gNwCn98Zhuv45/BO6eGFNlipqI16HSM+U55v66K7Hi5veifmtSDbiXntnKoa
         n9UA==
X-Gm-Message-State: AOJu0YzIcfsFy2rCbfK3xGh0LUYzSdX2bLl3QGjt4+V7+5kuUJpSzefe
        by4KzX1ZPDLBfoKaHGuJoCYbGA==
X-Google-Smtp-Source: AGHT+IGPROZowFQVNsGEjFij+56Go3FTr2SR7uAmpq5j3hKgejVThnnzQofVdZu8WGqQ3qUr3imn4w==
X-Received: by 2002:a05:6a20:4328:b0:13c:bda3:79c3 with SMTP id h40-20020a056a20432800b0013cbda379c3mr3546481pzk.4.1691673606295;
        Thu, 10 Aug 2023 06:20:06 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c24-20020aa781d8000000b00687ce7c6540sm1527065pfn.99.2023.08.10.06.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:20:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>, kbusch@kernel.org,
        chaitanya.kulkarni@wdc.com, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com,
        Jinyoung Choi <j-young.choi@samsung.com>
In-Reply-To: <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
References: <CGME20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
 <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
Subject: Re: [PATCH v3 0/4] multi-page bvec configuration for integrity
 payload
Message-Id: <169167360473.227591.7939702876981053246.b4-ty@kernel.dk>
Date:   Thu, 10 Aug 2023 07:20:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Aug 2023 11:46:56 +0900, Jinyoung Choi wrote:
> In the case of NVMe, it has an integrity payload consisting of one segment.
> So, rather than configuring SG_LIST, it was changed by direct DMA mapping.
> 
> The page-merge is not performed for the struct bio_vec when creating
> a integrity payload in block.
> As a result, when creating an integrity paylaod beyond one page, each
> struct bio_vec is generated, and its bv_len does not exceed the PAGESIZE.
> 
> [...]

Applied, thanks!

[1/4] block: make bvec_try_merge_hw_page() non-static
      commit: 7c8998f75d2d42ddefb172239b0f689392958309
[2/4] bio-integrity: update the payload size in bio_integrity_add_page()
      commit: 80814b8e359f7207595f52702aea432a7bd61200
[3/4] bio-integrity: cleanup adding integrity pages to bip's bvec.
      commit: d1f04c2e23c99258049c6081c3147bae69e5bcb8
[4/4] bio-integrity: create multi-page bvecs in bio_integrity_add_page()
      commit: 0ece1d649b6dd615925a72bc1824d6b9fa5b998a

Best regards,
-- 
Jens Axboe




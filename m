Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B904178B491
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjH1Pf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjH1Pfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:35:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0000DE1;
        Mon, 28 Aug 2023 08:35:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401b5516104so30800265e9.2;
        Mon, 28 Aug 2023 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693236949; x=1693841749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzAX6lqqHTluclgLNh1EUElGR4QXqRqoc9259SBPLU8=;
        b=L8tjr27q6ggRC6qCsj5TJadHQXfL8J+RdwqQn6XM0VlhObtBH2Sya6jLWcLe0R0wR3
         xhmXjkr0kqa3760Oyg/+YD7dLCme27Hh/hZWuIPDpT5cr+Raxo4LjxUz884ZF0Si7XqY
         nwVblkiTpx2IbBPXODPVzgrTYRNNUbyKuci0OQxTCawXtflZmsoj/tRZQ9ZxoLYjD4FF
         P1fh6voXSQyzqhIAFf8VWyj/njtZVXsVB4k/NHM+WUAZJKcAA1bF77AyZf0jWRV5xSkp
         9ub82sSMiS0CLd5gKNpxVu91yCSBPaBmlPlV/3vSaOask252Se3eQFhRvYwFgt2e3rp2
         +nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693236949; x=1693841749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzAX6lqqHTluclgLNh1EUElGR4QXqRqoc9259SBPLU8=;
        b=RJkHTnPLlhcwseXX0cr67iAMp1S9KHOHhnPIcp7PEJFcRQMGGopHJQ2KXtmwi+E+GP
         A2Jr0JEdEcxm02lMlh3cYXzy7xk9HEbr2aV9e57+Y8paFnzPlbw45Ry5sM6xXgV76hIW
         5uAeWKVkMqj/RLkidM2ZVt5YJ//HOgIqXLxfNDR/SI4QuTHjYqmBTJCqMSMxshtEvRv2
         2YcsdZA5Hn8nhCF50ElblUdilOz04lsWVTpiTYk3GCfGMPu6qxWrK5LoX+hz3nFJmSt+
         n8dvsUHmfB7+z5tVIbKC1zLNkhqTZBHTwre/4gv57AQQo00f7IHbVp4ojXlQysJNnuDf
         WrtQ==
X-Gm-Message-State: AOJu0YyQiREAy8gpABayweQDhEDbgj4E9lh1bhGpG6Y210p8rukGRmX/
        rV8Hvrr5akw9XgZZz9Ntle0=
X-Google-Smtp-Source: AGHT+IEfbfIoLSEJ4mhCVMfR2RUI4/euIEv22Sb6Ji7X+ZmdVa3DlIAgd265KR9S9ErkaoL7KbDt4g==
X-Received: by 2002:a1c:7303:0:b0:3fe:3004:1ffd with SMTP id d3-20020a1c7303000000b003fe30041ffdmr19711222wmb.4.1693236949046;
        Mon, 28 Aug 2023 08:35:49 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id c1-20020a056000104100b0031aef72a021sm10680247wrx.86.2023.08.28.08.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:35:48 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bjorn@kernel.org
Cc:     aou@eecs.berkeley.edu, bjorn@rivosinc.com, guoren@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namcaov@gmail.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH v2] riscv: Only consider swbp/ss handlers for correct privileged mode
Date:   Mon, 28 Aug 2023 15:35:35 +0000
Message-Id: <20230828153535.1568230-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230827114003.224958-1-bjorn@kernel.org>
References: <20230827114003.224958-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Puranjay Mohan <puranjay12@gmail.com>

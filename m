Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8E80F57D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjLLS0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjLLS0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:26:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD6CD;
        Tue, 12 Dec 2023 10:26:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c55872d80so4204035e9.1;
        Tue, 12 Dec 2023 10:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702405585; x=1703010385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hkS1sBD/3B08xTp4SHRHL7iiVCHyuQNhFokioYY2los=;
        b=GcYV7cdJPrVxjxzAW0Vopy707Moio+JgJTXHEApHTA0PmrP/C/E4RxPliVCI6xUi3m
         ACQDaZV23joJDlx2EhrIH3MN19f4ZRMHXrjavUdV7KnhJ5SFNJXqbO5mCqLlyBPJzF7l
         fKBjtGCLMZZ3o2CNwSiGo3wDj3H0s3g3OYDcdXh1TJwebCl7kQD7wVKy2iCfoxTSjG39
         etupsBp/w2rFb/SiAAffw/cv/ep95tD4SNgn3MgwlcrImcfuhxv5xaxS43xTxuxxqLH7
         YNKxgQKVGvbs0sAr6gJ48TfEEkEwSmmUdCqO1wr6wNm+BsltefipMvxKW/XUSsZUwUVu
         Udnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405585; x=1703010385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkS1sBD/3B08xTp4SHRHL7iiVCHyuQNhFokioYY2los=;
        b=g0PZRAN1fkrhIz6/xt/FIuXxawYbXiLAo/7VFzCwuhX1zhjcQUD+9KL2jFxRbojMOO
         ycJkkLtDcNqAi2CS1mhuyv6sIxHoGnXGCl57CrgFGdz7s0JRsOZ3CdXrF1jWqDEzgZw4
         qUbaloTXfkxuy5NNiWROMaGBMCJOazi7+fJNV1d6Zvkz1Y5Sc0znWrgq96/Ky+aNySio
         rjsF9L/AvtVKrLyKSzWbPVcVROfGs+0s+TovYnIMgRI1drN3im52YzYIy9W+FRkvpXMm
         UsZsknbhw6WipZqQEdGGIBo7CPccEo58OmZg/a/hOjUl66hMnBNmh0IYBZnBa6abOrO9
         0KhA==
X-Gm-Message-State: AOJu0YyY3G0o/rmM8bNdG2apPvQIbeoh/lt+cMLfMJmVEibVaIyFde8S
        AcLWW9wuWwboSRLON8Roba0ZVogD2VRX9iG4XH8=
X-Google-Smtp-Source: AGHT+IEba4DdBfnMii4Z9zAnc1E9yXjnBPUK4GFfz90NN5jzPgCh/H8iKeVjoSn8lYHWn/TkMYopGm9oF1BQeO8AS6M=
X-Received: by 2002:a05:600c:138e:b0:40c:53c5:ed5e with SMTP id
 u14-20020a05600c138e00b0040c53c5ed5emr694738wmf.131.1702405585098; Tue, 12
 Dec 2023 10:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20231207123437.42669-1-dg573847474@gmail.com> <20231212102304.4f37c828@kernel.org>
In-Reply-To: <20231212102304.4f37c828@kernel.org>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 13 Dec 2023 02:26:13 +0800
Message-ID: <CAAo+4rXcmwMqMFcGqf3nJV+H4UQ_G+yt=2PvoMVSsBGiXsJnvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks much!

Best Regards,
Chengfeng

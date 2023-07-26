Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0557A7628BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjGZCbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGZCbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:31:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1622689
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:31:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-682ae5d4184so1479670b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690338667; x=1690943467;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pE4L/Xm3kLoI9HrD29L7K7aTmuDXrHPhtqkNw6IBbE=;
        b=PP7ylOiR4Y79Htdcg5A3hJw/5wDtFQF+3iOv654e2CF9cX30H4cPrnu5NXn4p4x8NT
         ASYJaTJK1ptUe1p0dPvHCvxaj3nwUg5kjrB5jn2E5Ry5VSz3XuVTwTWt+Dsk6oKjvoRH
         4EiIcHjw3hVjkubi8Naj0v73pdG9eVD5nfxgAVtGT7RnSZXDg0Gee0JGI09b3ZYdCbBP
         Ow3M1LaULfiBu5R9viG8XFf45DlF5SgTPztpbWJ1ng6yN41k15sDs9CXc6dAmPrar+or
         CxXbUFObKJt3HSoANB4Jpy6K/OS55dv55K6OchX7zsbNEXKjr2te6KVk7i/3MzDIstcn
         WtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690338667; x=1690943467;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pE4L/Xm3kLoI9HrD29L7K7aTmuDXrHPhtqkNw6IBbE=;
        b=ZWXn1tZ24W2xaERDKFsRtGh0O01IixV6gTsXvVg4VKv1WuVh2EwNrAydNNvjiiIEY4
         0f6qlLFTyUZa2on2R8WM8FTRz0fd+vXsj7fHmOAdj6EtNNuWreJxlqy16e6NN7zqWI2J
         UV2gUeiFywLumjzRbarc5FHMarTL+Be3W49YdfH/2/yygsaomqUGDB18Mf/p2deDlAdb
         VEH1o2CKZeK8tFMEuOKs0+2OMqmQWPevhJzhZuNG/J7PcZ6djW9KBtPjRjsm+D7eSG7h
         8smF30p8fZlABOJUjFZ89FUx5jguTJ2vOIAXT9hfKOUGDo3mtWVDwlzACW7dBvXbinE3
         FMcg==
X-Gm-Message-State: ABy/qLbPCD+aMKDLBlP3XqNInWbATxAqlgZSC5WKwfVJ0IPQlODbBl/i
        SZTBmEFxlazk5yTLhXvjwiJ2NfriU13tz4xe9bo=
X-Google-Smtp-Source: APBJJlESzRrQMirYjq1n8EmHX8b287gHfS/qwbjZK569Ys7+IMy/+sEP8iskIkH09yqzZ4ELfIPkeA==
X-Received: by 2002:a05:6a21:6da6:b0:137:3eba:b808 with SMTP id wl38-20020a056a216da600b001373ebab808mr964035pzb.5.1690338667623;
        Tue, 25 Jul 2023 19:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p20-20020a637414000000b00563de16d60esm679198pgc.82.2023.07.25.19.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:31:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinyoung Choi <j-young.choi@samsung.com>
Cc:     hch@lst.de, martin.petersen@oracle.com
In-Reply-To: <20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
References: <CGME20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
 <20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
Subject: Re: [PATCH] block: cleanup bio_integrity_prep
Message-Id: <169033866680.863387.15476130342413439533.b4-ty@kernel.dk>
Date:   Tue, 25 Jul 2023 20:31:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Jul 2023 14:18:39 +0900, Jinyoung Choi wrote:
> If a problem occurs in the process of creating an integrity payload, the
> status of bio is always BLK_STS_RESOURCE.
> 
> 

Applied, thanks!

[1/1] block: cleanup bio_integrity_prep
      commit: 51d74ec9b62f5813767a60226acaf943e26e7d7a

Best regards,
-- 
Jens Axboe




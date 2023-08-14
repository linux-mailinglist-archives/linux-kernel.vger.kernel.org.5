Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5C677B5DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjHNKBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjHNKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:01:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C62E65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:01:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bfcf4c814so553700866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692007290; x=1692612090;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P55lE/+nUg97IMXFR8EERj3wyRTcilbDTOxdTZIxbMs=;
        b=EKNHfYNuRv7jHz+NFcUhqL5R8quJk3yauPwnLixIAxnV7iFSNZVidNoWhL22zgInku
         ipm+spui4kvH+B8evNz8OjEFTzNyuKtYOyXbNWiTdkUm3Ng/6vBBvy67y0O0nN8sFJ3V
         iJZhd+P1SJs3SGYLRhZ2BqzKyaEIJstXB9C6CBjBdzyicX+EYR9p5MagTnEleUU9ZK3m
         G10hF7IYgYOohIxMElowATYycYCzhXTMBxrP69LqAbTFBauZdAFwqD/iRgnTlqgWVpOt
         ABMLvc6yjETU36lb48o1f0R3LzYfxgijqjf2GWYAbZvVQ5zafPtYl5n1FFplAFcybB0x
         398g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692007290; x=1692612090;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P55lE/+nUg97IMXFR8EERj3wyRTcilbDTOxdTZIxbMs=;
        b=L35CYDsziUmTP9mdmmT/5YOYpfVVCb0U1plKM2LdiBK0CigxlOW0BXMRm4ITBvlMBn
         FVsxuqfnTnzjd0fs+9UhnnqPp4eASJdYdwOToVX0ktsJDs5HKYSCe+kZdpjJltBBHgrm
         9ookv85aZEGvVJzsW5/Fnm50cBJhVfTxVJTSiABHA/Pz6r36Rn2UBmfq8rDhX6YbxjFG
         H2ZDnFdMJfh8Ebwwfd16bNQ1dhUWp4edYRFJP9gAscf1uocq0pd/kVwZmY9GJAgF7whS
         lCXUQtEB+aLSL4LmUYNK4PONVdjvdaSClTx46b0P46QM8k8EYaR5WhkbGZTcUfrcR/Cg
         2HsA==
X-Gm-Message-State: AOJu0Yxi2To0KnWtZeSXLQAl74fUIAf5+7wNE5ufAbNRaEsQP1BsJt10
        mDH5AVJnHJ66IalH1PnewHmhdBQMMCyYKrc+2dE=
X-Google-Smtp-Source: AGHT+IFR1SQ3nVYCqLm6z0JfPA+i5j37wXEFCrwuifYWnfwXU0aCksiL6geLq4QCYidvjhJB5HZjig==
X-Received: by 2002:a17:906:10da:b0:99b:c985:cf7e with SMTP id v26-20020a17090610da00b0099bc985cf7emr8495426ejv.54.1692007289749;
        Mon, 14 Aug 2023 03:01:29 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906950400b0099bd1a78ef5sm5514090ejx.74.2023.08.14.03.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:01:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20230808062932.150588-1-miquel.raynal@bootlin.com>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
Subject: Re: (subset) [PATCH v9 0/7] NVMEM cells in sysfs
Message-Id: <169200728874.82396.6212330367970101447.b4-ty@linaro.org>
Date:   Mon, 14 Aug 2023 11:01:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 08 Aug 2023 08:29:25 +0200, Miquel Raynal wrote:
> As part of a previous effort, support for dynamic NVMEM layouts was
> brought into mainline, helping a lot in getting information from NVMEM
> devices at non-static locations. One common example of NVMEM cell is the
> MAC address that must be used. Sometimes the cell content is mainly (or
> only) useful to the kernel, and sometimes it is not. Users might also
> want to know the content of cells such as: the manufacturing place and
> date, the hardware version, the unique ID, etc. Two possibilities in
> this case: either the users re-implement their own parser to go through
> the whole device and search for the information they want, or the kernel
> can expose the content of the cells if deemed relevant. This second
> approach sounds way more relevant than the first one to avoid useless
> code duplication, so here is a series bringing NVMEM cells content to
> the user through sysfs.
> 
> [...]

Applied, thanks!

[1/7] nvmem: core: Create all cells before adding the nvmem device
      commit: ad004687dafea0921c2551c7d3e7ad56837984fc
[2/7] nvmem: core: Return NULL when no nvmem layout is found
      commit: a29eacf7e6376a44f37cc80950c92a59ca285992
[3/7] nvmem: core: Do not open-code existing functions
      commit: 95735bc038a828d649fe7f66f9bb67099c18a47a
[4/7] nvmem: core: Notify when a new layout is registered
      commit: 0e4a8e9e49ea29af87f9f308dc3e01fab969102f

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


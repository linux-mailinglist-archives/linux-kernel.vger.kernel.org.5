Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95B4751DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjGMJ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjGMJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:55:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972926A1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:55:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so614191a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689242154; x=1691834154;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKAX3Mi7+gq9axeKYaxCLsvSipU3Ndzeelqq23Pbe0E=;
        b=yqBt8BX1BN6GO93VXB7JJHf9qGeEov0mIB1WAoWPP1L5M3f1WEtt5c8wa4n5Dz37kW
         +YG3q6OHFCYoKlr7Ce2BOlqZWL7oQYohcfN/AZrfsDYYKg2VPVFUOtvIYu4VYqa38A42
         Pa4ih5G7XeuAJ8gVK+k94Eb+Q86weGBxK0u/Docs+OViBTkmo/tyEVMo65+Qsmb5Ba0k
         0i6dGXp5igIKTB3fqJGi74z8D81YKVTa3Y2FQpLNrqGI6N1sll5I0WoXmAT3e5s70k1M
         c2G/RJ4xLJ8ny60HPiszNbomafPa39yrkQuzxstWDukFGWMMzC0vyPvFmibDmNbkPNzc
         wmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242154; x=1691834154;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKAX3Mi7+gq9axeKYaxCLsvSipU3Ndzeelqq23Pbe0E=;
        b=Ap4kYoPpg1BZwfVkZD2Eos25YAEUmeO1PoiK4ild7lKVu7NSquTfayRpHynnapsmdj
         /eeae165pAQivxIlDPGz1kPr6Bn3hmXa7LLRMDVfTKISWJH0uVrwf19CyKuu+pwadS3Z
         5+aI72hU1TR225XbFRJjftV4C26J3PllyaquRIF/kOVRi6gDSLCGx9LRwBWKBOtS4FIY
         6oRL/olUdcXVCHBcdZUqFOmq76cT2Fuz+oiPCijzCs0jyNqzm/FlY2Uao4cKRFzVDAaH
         nOx0heiiK4+WDHIknGjizzfWMtU/h/ngzqNOOnpYHmCs0YbdhEqws97Qj1xZ9AdRJQPu
         vNIg==
X-Gm-Message-State: ABy/qLbBiVy1EoJpsb7l0aMI/4pLY1u5LkzhLMPiycV9fPzxm9+ps7/U
        Nmz7sxpjvhAonFvsihrE7z7c8Q==
X-Google-Smtp-Source: APBJJlGVyFX7IAo95gjarh3L1M1xGknu/m7NUijTcuPffSdc6VNuWYG5GglKgKIfPXyI8xVYlCZFHQ==
X-Received: by 2002:a17:906:3f4f:b0:993:f497:adbe with SMTP id f15-20020a1709063f4f00b00993f497adbemr1421526ejj.19.1689242153806;
        Thu, 13 Jul 2023 02:55:53 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id rk21-20020a170907215500b00993150e5325sm3767936ejb.60.2023.07.13.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:55:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
In-Reply-To: <20230713075508.485072-1-miquel.raynal@bootlin.com>
References: <20230713075508.485072-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH RESEND v5 0/3] NVMEM cells in sysfs
Message-Id: <168924215304.14966.11949014748675344264.b4-ty@linaro.org>
Date:   Thu, 13 Jul 2023 10:55:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jul 2023 09:55:04 +0200, Miquel Raynal wrote:
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

[1/3] ABI: sysfs-nvmem-cells: Expose cells through sysfs
      commit: fbe37a7afce21f33283869f5d79901b25537c385
[2/3] nvmem: core: Create all cells before adding the nvmem device
      commit: 681e18c0a0f200c27ee72e274e572d370e957a70
[3/3] nvmem: core: Expose cells through sysfs
      commit: 757f8b3835c936a44c0f2c3f66bcd03eea96b661

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


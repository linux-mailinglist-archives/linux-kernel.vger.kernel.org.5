Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC698008E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378412AbjLAKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378387AbjLAKsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:48:47 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959291704;
        Fri,  1 Dec 2023 02:48:51 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ShVCz1Y5jz9smg;
        Fri,  1 Dec 2023 11:48:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1701427727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OAm3AWMmCSZoFaeag4UwbvfiESQNmJ9RHnQR9xoyczs=;
        b=PNMZq2X+MZXStSKWZ7VCGPueqh+msF8bViqfNDrjLFTmh/4h0PTONnHUlZK8he5bsZkNP5
        W+kdpVwqcdIcmU7ikYr9UT6hfKcdheLoPoF/E91u5mFmJK8h6BAvQxT13B+RvF/RjXS1UB
        8mOGzVlof/FN0t90tcTypdqpxRqbqUE5/pMhoA8Q1YOZvFY6XS5jQakFvFasQ+PgZTF+d4
        uBgIgEEYgPRYCNpBpBzIfUHy7oaoHYuf4M/NM9qurHnLMSdhUPb5YuZm/7rLLVP+NgsINu
        3mgj2eCCSXhoydWqkHqgVCuvYdioGVUU2CQxk3B2AcIQ7JMJTmevgKClc2LVjg==
Message-ID: <13271b9b-4132-46ef-abf8-2c311967bb46@mailbox.org>
Date:   Fri, 1 Dec 2023 11:48:40 +0100
MIME-Version: 1.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org
From:   Tor Vic <torvic9@mailbox.org>
Subject: [Bug Report] [6.6] i2c: No atomic i2c transfer handler
Cc:     benjamin.bara@skidata.com, dmitry.osipenko@collabora.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3fe66d1d811e49dd83c
X-MBO-RS-META: kc6murww4t5z7k8uojbu6ipuokawx9gi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since Linux 6.6.3, I see some warnings in the late phase of shutdown.
Unfortunately, they are not logged because syslog has already shut down 
at that point.

I used a camera to capture a small part of the warnings:

   No atomic I2C transfer handler for 'i2c-0'
   [trace follows]
   i2c_smbus_xfer
   [...]

After checking the changelog, the culprit was found quickly:

   (3473cf43b) i2c: core: Run atomic i2c xfer when !preemptible

Reverting that commit made the warnings go away.

This is a voluntary preemption kernel running on a Skylake laptop.

Please tell me if you need more info.

Cheers,
Tor

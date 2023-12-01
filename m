Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD94F800A12
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378611AbjLALuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378585AbjLALuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:50:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7291704;
        Fri,  1 Dec 2023 03:50:17 -0800 (PST)
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7099466073A1;
        Fri,  1 Dec 2023 11:50:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701431415;
        bh=1f9V1mRzAe9W9j7LB7eRXgB6WQisl8QVSZINx/Y31rE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VksUSblnvEr/M1i7n52Zg7GvS8HfvVgWV8MP0pvPjF7AMy5En9kcqfHAN6y/VXHUd
         gGPRUxYEf8i0PmIGFGxbHQyYFuTC0QrmDX4zgHuqw8nqWPUI4M0VasElsv2ijnASUG
         FrFzQmdVMxlTCF8rXSVjGaUR8Q0l/25cozP4cxDSS93rNNR2e6ds/A4DTLytx+XplV
         ggat4drxGn5CS6iojKw9KyumfHBuxcp794wFqA+xjdkRSNrOoROzuDvgGx6l3C0BVZ
         5ujyo8oxYS/zUh0Z9dNNZWu9t19b2mmRS/Et6/0rVdz38ne2qqmhKPBfFE+Cdk5rNI
         65A4aoKu745Hg==
Message-ID: <621c7d60-8953-1d7e-b4a1-f4fc510ba9d6@collabora.com>
Date:   Fri, 1 Dec 2023 14:50:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Bug Report] [6.6] i2c: No atomic i2c transfer handler
Content-Language: en-US
To:     Tor Vic <torvic9@mailbox.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org
Cc:     benjamin.bara@skidata.com
References: <13271b9b-4132-46ef-abf8-2c311967bb46@mailbox.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <13271b9b-4132-46ef-abf8-2c311967bb46@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 13:48, Tor Vic wrote:
> Hi,
> 
> Since Linux 6.6.3, I see some warnings in the late phase of shutdown.
> Unfortunately, they are not logged because syslog has already shut down
> at that point.
> 
> I used a camera to capture a small part of the warnings:
> 
>   No atomic I2C transfer handler for 'i2c-0'
>   [trace follows]
>   i2c_smbus_xfer
>   [...]
> 
> After checking the changelog, the culprit was found quickly:
> 
>   (3473cf43b) i2c: core: Run atomic i2c xfer when !preemptible
> 
> Reverting that commit made the warnings go away.
> 
> This is a voluntary preemption kernel running on a Skylake laptop.
> 
> Please tell me if you need more info.

The warning says that I2C bus driver used by your laptop doesn't support
atomic transfers while it should. Which driver it is?

In your case the warning is harmless, still the I2C driver likely needs
to be improved.

-- 
Best regards,
Dmitry


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3925F80E207
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbjLLCkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjLLCkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:40:03 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D521B0;
        Mon, 11 Dec 2023 18:40:09 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c4846847eso15362715e9.1;
        Mon, 11 Dec 2023 18:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1702348808; x=1702953608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zAXD1RodxLCJLaHsUmAJZ2pqAt9clRdJT0+EpmZ3Uto=;
        b=Df9w9eNh9ln//OYAh75cLwnZK37TcwDWM6U1ISnJHs0ziLCRX36EspnRsmvvjHDcL4
         umg1XVdo4i0fexkDTKPiIhBmfD9oDQ0cbhZAWhj7Cjmv0Vjbylq7w+xxdd9G+ykZ3Gpq
         mWm2F0GySqdHZjjxsLlJHOmO5l9DiVpaAAAbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348808; x=1702953608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAXD1RodxLCJLaHsUmAJZ2pqAt9clRdJT0+EpmZ3Uto=;
        b=HYzN92CQ2mpm49TqT3leUevVPZRWvXMXXgCzlt2ZloQX4QTluyz+WO2oJwFHZjeitJ
         P+rIr4mjcMsWOGJ0pVhjrf9gWm7wxjYY2UH2aUQqD3IERVafSrQbZfQd96zV5/lKMO3e
         AQsv5Y42HEBuMlAWSrlxIJL/4UHN01syvyXPExu9PmeFZzf8m9/2nGlUikpRLHmYORML
         +v4lA7/baSS1xqhvxlabyo5vRYsIaXwI0UaygsfuHc4zGi9buqB8xGVOWuxGRy8IdgZI
         1gKjxaxpgNMuKsTeLF22mik2LqOP+O1kpM+9J/DJnE7nxXs9z/Ec9zC+vZ+4OGSjOirz
         jkWQ==
X-Gm-Message-State: AOJu0YwCZYg9rUYXxaXrCzwn0vuVRa4Sj4ZBGeDj1vZAoPiwM+lg03Qa
        gwdf7qvn7GIvHqmmvfzC3o+jgLbViXzf9sApzXY=
X-Google-Smtp-Source: AGHT+IGro7ebzIbDoL45S1IR1W+QmdX6go9COEOECHXrDlJuyCg39Z2Svxx69OR3G5dk255FoNyjGuIcZuMlOJIug34=
X-Received: by 2002:a05:600c:11ce:b0:40c:377c:4b62 with SMTP id
 b14-20020a05600c11ce00b0040c377c4b62mr2683948wmi.50.1702348807434; Mon, 11
 Dec 2023 18:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20231211102217.2436294-1-quan@os.amperecomputing.com>
In-Reply-To: <20231211102217.2436294-1-quan@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 12 Dec 2023 13:09:56 +1030
Message-ID: <CACPK8Xc6-M9fsx3AUPobzvG6sjCrr8Sj5B3Q4Onp5wGvMm_BrA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] i2c: aspeed: Late ack Tx done irqs and handle
 coalesced start with stop conditions
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Wolfram Sang <wsa@kernel.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Cosmo Chou <chou.cosmo@gmail.com>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 at 20:52, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> This series consists of two patches to handle the below issues observed
> when testing with slave mode:
>   + The coalesced stop condition with the start conditions
>   + Early ack'ed of Tx done (ACK and NAK) causing "Unexpected Ack on
>   read request".

Looks good. I've reached out to a few people who use slave mode to ask
for review and testing on hardware. As long as they don't come back
with issues, we should get this merged and backported to stable.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

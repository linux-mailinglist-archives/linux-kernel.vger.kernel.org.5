Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671AE7BD96C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346208AbjJILT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345822AbjJILT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:19:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13FD99
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:19:56 -0700 (PDT)
Received: from [IPV6:2804:1b1:a940:c6b8:18b8:5ce:1f77:c31a] (unknown [IPv6:2804:1b1:a940:c6b8:18b8:5ce:1f77:c31a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F1426605957;
        Mon,  9 Oct 2023 12:19:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696850395;
        bh=se4MQkYBZRlBZRnBE1H+TAMveEHemZnZwrtB2S/ffb4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ct1L0BTrXqTEc9k7qOFzpuOF9mBYePU+TjYBAHXz6sh1udRRDx4fLLNJthRKfLYrE
         3cAnPyuWtbi69xP87j7p12eFFmvCCw3vyIUxIgz8XzYd7pNKSk+WLBYHYmhA1X/xWU
         VGriPXN7CM/m+RHecRLr9VEC693/FD1pM07LO041xcGvBO+5+Q4g2d9RCKJfo4/DY/
         IaJ1Ssd4M5mfXsfl1FmpPsuA/m/visXVuQvNyJxwUMbH4syeio3leR1iaSaEjNvfIp
         g5fEoee3R2UoFU02oPzYnHtHpvXFCz7oJlJpwTxYH+gOfpCYwjNEANdSxhlVx3rrMO
         DKqTjbruW95ww==
Message-ID: <57967900-d00e-4175-8c82-4a91c60022e5@collabora.com>
Date:   Mon, 9 Oct 2023 08:19:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: Default to UART for logging
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Emma Anholt <emma@anholt.net>, Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        Guilherme Alcarde Gallo <guilherme.gallo@collabora.com>
References: <20231006173205.371205-1-robdclark@gmail.com>
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20231006173205.371205-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc +guilherme

On 06/10/2023 14:32, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> ssh logging is the default for mesa, as it is generally more reliable.
> But if there are kernel issues, especially at boot, UART logging is
> infinitely more useful.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/ci/gitlab-ci.yml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index 2c4df53f5dfe..7c55f02f7313 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -27,6 +27,12 @@ variables:
>   
>     LAVA_JOB_PRIORITY: 30
>   
> +  # Default to UART logging.  Mesa uses ssh by default, as that is more
> +  # reliable if you have a stable kernel.  But kernel CI is more likely
> +  # to encounter unstable kernels (and has lower volume of CI jobs so is
> +  # less likely to be troubled by occasional UART flakes)
> +  LAVA_FORCE_UART: 1
> +
>   default:
>     before_script:
>       - export SCRIPTS_DIR=$(mktemp -d)

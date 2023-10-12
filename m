Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5897C7841
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442885AbjJLUzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442892AbjJLUzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:55:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD173DE;
        Thu, 12 Oct 2023 13:55:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405524e6768so15038315e9.2;
        Thu, 12 Oct 2023 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697144142; x=1697748942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up4p0OSIEs+YgRdpllN8xcWKb/R+ewFViQYL/G+J4zA=;
        b=Mm6B4k1ZRg88xDrrJo6cDM6VUmTGBJ18HNpGYGCi/YxZrJ5Ab4grql8REdiXocya35
         yYneNYsgKpxpZoGTzlR0p3dmIxM+W5jWLuf6luf3JGO3hzSiEAPya9nI3HT++Ucohcxi
         RV4jG0AKRlToHJ6u846d4b17ks5jh9ViuE+0kiPL5reS0XdvJ0hsf9hRepjODsbd1QA2
         GAQiG8+bw6qaei38X/i858Lzvlz8MX9GojeRoOOKdYlb8VoHNpn4L5BT9PXrDAHUm1wW
         5Us59944oC6lvFKz2Dya7xq0NzeaZOJWITrwBGJq5aGPDZsIfPXfv3ITxiwlBQQbc67U
         XcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697144142; x=1697748942;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up4p0OSIEs+YgRdpllN8xcWKb/R+ewFViQYL/G+J4zA=;
        b=Ag40A8/DJumW5TfEr1wcoKIzexhpB5hwy0ZaOeufkKM48OrsYRyRSEcpR01SQLsBKB
         kWcvwfj+T+Oge5DqxTKGeUaAbxscCvP/teWUFaiRVYg2dAy90zNIXrZpdit/uej8VITa
         83xumbnAKRDqRe0o3CwHcRBnsSk0YYXdnRVeFlpvtR7XvFoCHy2s4YlmF9o6S95YL0u2
         0Z9ZOCIWnlBQbNXuQjUCFjXnOGYw/74JrvJHrvFEf6UQ6cXiBgvHYIHLU4hVKGMM0rxW
         bymt/Q3amdTQrYQKcTAPMUsd1wpWO6qml8JPF/7GAKUkzO0wdIBJXRX1jNpwRr95Ce28
         aovA==
X-Gm-Message-State: AOJu0YytXjahbQxtBnbRn25T5JYZOLrNrziQBif1gVSPMeRm1ePlpWsz
        OjcvlwcV7eT7cSehcVwERwUQqqAPwik=
X-Google-Smtp-Source: AGHT+IFedDZ2ZG+iCT/dbhR629lDLAkK7LZ2LkVsrqhvg8Jmcq6E8aG2G9I8Hm0kGDOasPzA1XbdHw==
X-Received: by 2002:a5d:6641:0:b0:32d:9755:44e7 with SMTP id f1-20020a5d6641000000b0032d975544e7mr1085664wrw.33.1697144142042;
        Thu, 12 Oct 2023 13:55:42 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id v7-20020adfedc7000000b003197efd1e7bsm19072675wro.114.2023.10.12.13.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 13:55:41 -0700 (PDT)
Subject: Re: [PATCH] sfc: replace deprecated strncpy with strscpy
To:     Justin Stitt <justinstitt@google.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-net-drivers@amd.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <c1b37796-76a2-b868-efd6-c09f41cee372@gmail.com>
Date:   Thu, 12 Oct 2023 21:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 21:38, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `desc` is expected to be NUL-terminated as evident by the manual
> NUL-byte assignment. Moreover, NUL-padding does not seem to be
> necessary.
> 
> The only caller of efx_mcdi_nvram_metadata() is
> efx_devlink_info_nvram_partition() which provides a NULL for `desc`:
> |       rc = efx_mcdi_nvram_metadata(efx, partition_type, NULL, version, NULL, 0);
> 
> Due to this, I am not sure this code is even reached but we should still
> favor something other than strncpy.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>
but ideally we should just rip out the dead code instead.  If this
 patch gets taken as-is into net-next then I can probably do that
 in a follow-up.

-ed

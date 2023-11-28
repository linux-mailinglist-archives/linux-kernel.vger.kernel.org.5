Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54C07FB6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjK1KNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjK1KNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:13:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28B910E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:13:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b4746ae3bso11533695e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701166425; x=1701771225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/bPqzwcXSoaxZqZzSa+865x33KMqhVaJChFNtyeUsQ=;
        b=fW+Ao+W1ezwTh9RBOLnS4r5Esaf64t1U2W7d0kFUiOOniQ+0FGg2SMxqLjvVgzdRpp
         n1JOUMbR8kvyvt8sq/sbg9DIW9QSBrT+ScralYLGwcy7yWQjeCKGX1V1U1L7MZ6EeW4V
         NHjS43ItqL37voYDEg11iMuHsPL69qFmCoXdibm2Ap8s4Lzm/HcCBXOehac0w4xdp863
         LpaZ1DG+P1yFbkdBhYAmkBjkuwvBRPhO+LPj5QgNRxPmLoDNUh8zvN08N0GssVbwAfQy
         Qb4uKKGSqbuL1ubIrIgtPrkNQAkfu0DDhA3Ynjasx3mjaxiQHMw4ND5+ERnU7RDz4kgG
         chFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166425; x=1701771225;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/bPqzwcXSoaxZqZzSa+865x33KMqhVaJChFNtyeUsQ=;
        b=dO1FO6FbRWI33TlJv4RVQO4g01YshyORJUh9LkSl7cVginx2kWCznkHtphg9h+GBUR
         w6OAOvFkeexzPtkLqLDVKiRB8avXqSQ0fKMQyyByXuPgMWokUH/ZFm5IsP+U+qYlsJV1
         swkI6m+zD49BdxZll5aEcQ9kcqMyqHJvepT0Ltpw2MIi0l/j2pdSXTxZqkP1Hc4uqtTt
         EXQ9/L8/f57oonx4d22zHR3tqmX1c459mWjk84FyJsb+DUOvhQ29WFxoAmzTQmRG4vU+
         ei7uz640m4wDTQ9zTkhAFEWRiv/rXzpyESzcJUyk1dECirtR2pkOTxoj8hX+pOooBSKS
         VxqQ==
X-Gm-Message-State: AOJu0YyT+46/OIJwUddETYdFA86ZqkXZ+Q16y7F3jCy2vSf993EBKU16
        /ulNQY9EuK85b3Bozzkx6sHxxA==
X-Google-Smtp-Source: AGHT+IFReERGOX7oXJ+dIqXvZzDJECETDbU4qHYNGhN6de5X76QTA6m4TBcX09Ww4m6To4duFCSYTA==
X-Received: by 2002:a05:600c:4f16:b0:40b:3633:9380 with SMTP id l22-20020a05600c4f1600b0040b36339380mr10281011wmq.33.1701166425346;
        Tue, 28 Nov 2023 02:13:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003fefaf299b6sm17017275wmq.38.2023.11.28.02.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:13:44 -0800 (PST)
Message-ID: <b6d79cad-a545-48cb-a0e4-e9fdc457bec3@linaro.org>
Date:   Tue, 28 Nov 2023 11:13:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 0/3] Revert panel fixes and original buggy patch
Content-Language: en-US, fr
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
 <170116632194.2250210.1478661000647719120.b4-ty@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <170116632194.2250210.1478661000647719120.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 11:12, Neil Armstrong wrote:
> Hi,
> 
> On Tue, 28 Nov 2023 00:10:18 +0100, Linus Walleij wrote:
>> This series reverts the attempts to fix the bug that went
>> into v6.7-rc1 in commit 199cf07ebd2b
>> "drm/bridge: panel: Add a device link between drm device and panel device"
>> and then it reverts that patch as well.
>>
>>
> 
> Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)
> 
> [3/3] Revert "drm/bridge: panel: Add a device link between drm device and panel device"
>        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9b6a59e5db87c2c6b3ca0391176ed4358623d5e4
> 

b4 got really confused that I picked the patches in the wrong order, but I applied
the 3 patched in the 2, 1, 3 order.

Neil

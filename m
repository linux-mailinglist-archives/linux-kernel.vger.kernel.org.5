Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E283379A4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjIKHgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjIKHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:36:22 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222D1118;
        Mon, 11 Sep 2023 00:36:18 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52eed139ec2so3653755a12.2;
        Mon, 11 Sep 2023 00:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694417776; x=1695022576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E++QcmaSCqRTogZf0py8lxCDiY1aiEIVkjD7gfQ6xAc=;
        b=Vix8Uty22l3e5DfXDB+cTLX9hkZ1niPg5oW8q1M+wea03bw3cjlZECMMz5BewQVYRQ
         X4xaiqfYfL78Wdvt3l53n8p6JvDB53VT7d9bTUzEa7+eMVm2khVU8RB0S6Z3Wx5CHqt0
         S9916vnEvFLY814yP6MR/+oB78mOxwrUrcA0iAS3ogr5xuJMClNfDtuhyHGbhoSdG8fN
         CkF69HINce36Pcg8GkISqpWYVZIGY+jVG6C8UrY5tIcpn+Kgo5ixTHqh6nPEHqkYjXCH
         2q4fNEwTB2KAP6kd0h7wM/dmFDiZRu9RflxzXzPFjepCfkLxhG4cLyNH795evp1Jf4+T
         hWxg==
X-Gm-Message-State: AOJu0Yy0ct5vZS/MVClzt+cvJvO1chXUojjK9281iYaQxqq6W60le4EH
        AuT2sIjrEAly+2Cl9ACJ1zg=
X-Google-Smtp-Source: AGHT+IFjbgI2p7VIOt+A7f05oIS5iZ+7BHD5jL8GSbm3gtDeDn6DEJ4gzH5WlS5acf6oV4/HaPfRgQ==
X-Received: by 2002:a17:906:530c:b0:99d:f056:5d6b with SMTP id h12-20020a170906530c00b0099df0565d6bmr8124022ejo.20.1694417776464;
        Mon, 11 Sep 2023 00:36:16 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id ga17-20020a170906b85100b009a1e0349c4csm4892779ejb.23.2023.09.11.00.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 00:36:15 -0700 (PDT)
Message-ID: <d3a92651-d427-af84-70c2-bc6004e79c80@kernel.org>
Date:   Mon, 11 Sep 2023 09:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] serial: stm32: add support for break control
Content-Language: en-US
To:     Valentin Caron <valentin.caron@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Erwan Le Ray <erwan.leray@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230906151547.840302-1-valentin.caron@foss.st.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230906151547.840302-1-valentin.caron@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 09. 23, 17:15, Valentin Caron wrote:
> From: Erwan Le Ray <erwan.leray@foss.st.com>
> 
> Add support for break control to the stm32 serial driver.
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>

LGTM

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs


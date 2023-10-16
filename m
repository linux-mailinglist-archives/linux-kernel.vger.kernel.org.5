Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9187E7CB115
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjJPRIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbjJPRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:07:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E0D1995;
        Mon, 16 Oct 2023 09:55:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so57886781fa.2;
        Mon, 16 Oct 2023 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697475318; x=1698080118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDMSeVGI1lziENvZtg9gJFiDQXMa4W5b0OFqgA4HwwQ=;
        b=HDRnNerpwc5nZqcWmt63YuY6eWeqvPAzcej/w7FsyGWcUJVgOVWZ15QMaVJx07IbIQ
         aYzUjF1xGaribZ9vhJl9uS8P0cemg97PFqlXspHqGNu+JWJPdRm9FkbqCPynbU+RoMXM
         Gm4bY0QRk8tfwTl5WzK57ukVRbkfsCuaG5tcQalneqUMkoYwtRFqnRAJXokFmpg8QMgH
         QmKfha+l83b9mB2naE05OpCVZKlalQntOMoeOXy3OTeFKhXbP/rSdL+FMZY5aAlkboWz
         x/SyPVnhfJsQuhKzV5Hs+K29gQC/ISxRrPWw5qsHYnOjXzcTHWhGFhQYLbHplgXpaLOy
         sRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475318; x=1698080118;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDMSeVGI1lziENvZtg9gJFiDQXMa4W5b0OFqgA4HwwQ=;
        b=sEQ6odYbvbULzMhmTjBd6yLwfvtVKynDndt8tCqGmIKgu+/oWPzi0dy/8LujUQTjoB
         JRYinkKxL8T0hY1P2+8ZdNgoBv/5WExOanrC4zvyizj/yLhK0PJ79IqVZ3uIWeix3umy
         SQUvs0nQWUXejL3hta7vVZnCgtJ9ug4bN5aZp1yGxcjchhVhj5VWxMbwF7HuUlLy/TG+
         Od+oSXe3/J2vInfX2wLaiKftYG+xPazB5JPN1eOpXhaAPzo1VvSXJ+QKcgmM0SHs4C1A
         YdI+Dj4wlDE2rY2e7k5Ya5HEk/tXIc5ZfkS0wRHKZ3hHpXBG/QUllJ6NA2x+O2IM5vqe
         kU3w==
X-Gm-Message-State: AOJu0YwSxZgV9HhHrgLl/QRMcCW5tQLZKUtJKaOmWEegHfVimx5UA7g8
        V3nH9VUT/byGXRmoaOnpUbw=
X-Google-Smtp-Source: AGHT+IFXVpqtrHmMQjvHOYI8m6+j6fE8DcQswG9JSSSyKp7zf8eEdNH0MrpFoOX0aYmPTvR62QOOcw==
X-Received: by 2002:a05:651c:211c:b0:2c4:fe0a:dc3e with SMTP id a28-20020a05651c211c00b002c4fe0adc3emr10626532ljq.36.1697475317654;
        Mon, 16 Oct 2023 09:55:17 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.83.53])
        by smtp.gmail.com with ESMTPSA id u6-20020a2e8546000000b002c27cd20711sm31675ljj.3.2023.10.16.09.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 09:55:17 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] xhci: dbc: Check for errors first in
 xhci_dbc_stop()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
 <20231016130934.1158504-6-andriy.shevchenko@linux.intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <8b3537e4-db84-7ba7-7c63-0a605631507e@gmail.com>
Date:   Mon, 16 Oct 2023 19:55:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231016130934.1158504-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 4:09 PM, Andy Shevchenko wrote:

> The usual patter is to check for errors and then continue if none.

   Pattern. :-)

> Apply that pattern to xhci_dbc_stop() code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[...]

MBR, Sergey

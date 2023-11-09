Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168CD7E6FED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344319AbjKIRNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjKIRNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:13:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23B130D1;
        Thu,  9 Nov 2023 09:13:36 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4084095722aso7919215e9.1;
        Thu, 09 Nov 2023 09:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699550015; x=1700154815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4AVwkXLIEdl9JfCYU2WPJHWlDPBRi3Q+4jqeNhAXcg4=;
        b=J5JXSI7W2hcPgda7jeCso4BYNJQ8hRcKDr0z46rjoGM6fsvdrzFmjFxt5rek43YX/p
         kIeJmLQ8d6ZWm12m2vH6nQyWtw9vnI6B60a30lp84aqei4O1iPrKh3AwgaBbywNwT4wL
         73RZ+gWjY9aTAUarzT0pTJzAwGbQbAe1JLVnLaW990rPII33LrDwbCbe9cDIFLawrqTX
         v3xBtelTGC2xIsN3bOmEMaChXBc0d4N7bgGJhPcvEXE9weJJyXAKKjrAzDKIArA78vBy
         s//MMkXHyX3++znvqRf15VLfIGyIWmVeqS1O6Gxi+0i7/69Xji16R6iXonZFYhGIyl7o
         wdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550015; x=1700154815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AVwkXLIEdl9JfCYU2WPJHWlDPBRi3Q+4jqeNhAXcg4=;
        b=AzP3JwOCU/7seABUkXosH3c+mOofTOljSXR/e9yv8VQeyxAcoOl5rp9r+cYCl2pcKO
         8GXNGSksxvh8z7Nz8NVvP3OkRwmdThxEoP/lk7jC/U2G7doBkcW94ddfxEd3E8XNMnTd
         thJSqSuPzT07qLZ4en5FqJu1hikIYOitgg15jXD5rW1KgpoZYFB5CniNJhJms5u3eRCb
         mAwZuU5Vgq2hQIPLGadgVTrfT/VGkzDW/x+SjwNRCkJNEj5D8oJzmlIKVYfcual0DizM
         /OFYIP2FeviuQ5FAG+O436cPBZyElYfQARDNcQQvAi/z/ObAg3teS3bgrfyAi8xXJgD+
         UiHg==
X-Gm-Message-State: AOJu0Yzs0JO5EOZn+OH/rrS12eRad1rBC2eMNArje0FinWKsMNmewB76
        ZlE9XbcxHODKCo5k4IJRBkz4BgY162U=
X-Google-Smtp-Source: AGHT+IERbtAL0tYz/VeynBwEXIcTj5xImOUl1HbrgbJHryzZGHNYhFM8yhd55u1aZP2s52PKktSnzA==
X-Received: by 2002:a05:600c:3398:b0:407:8e68:4a5b with SMTP id o24-20020a05600c339800b004078e684a5bmr5433241wmp.38.1699550014820;
        Thu, 09 Nov 2023 09:13:34 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b004064ac107cfsm2713038wmq.39.2023.11.09.09.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:13:34 -0800 (PST)
Date:   Thu, 9 Nov 2023 19:13:32 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] Fix large frames in the Gemini ethernet driver
Message-ID: <20231109171332.kcw5yiac5dv7bheq@skbuf>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
 <20231109105037.zppxrr3bptd7a7i6@skbuf>
 <ad66b532d1702c36adecd944e25f84e4497ef8b3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad66b532d1702c36adecd944e25f84e4497ef8b3.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 01:26:17PM +0100, Paolo Abeni wrote:
> I fear this is a bit too late for today's PR. I hope it should not be a
> big problem, since we are very early in the release cycle.

No problem from my side.

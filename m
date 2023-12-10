Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926A680B95C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjLJGj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:39:57 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C0B8;
        Sat,  9 Dec 2023 22:40:04 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-35d67599613so21568705ab.3;
        Sat, 09 Dec 2023 22:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702190404; x=1702795204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EynoV2PXYriV37OkBd7LflakvlW/dPuJ1KwDl4hKKJs=;
        b=MsHKfa04x0sHn9LIGf5VDdQeDylwIAGsauwUb5Y98E9s0qwtNSyb08xNilK04tDWzU
         A4srGxNuNNlJ9eeOu06aY6jWAfp5EEDsEePp5KE0PQY4CCDhBx9QalH+P6mCqjyHwQsT
         nb77fJHqiexbcOScgSRr5zaqs/C59YmRFKznpXwMCIQHlC2EdTksMoVSjn28r7PE9O6s
         9aGnjcmWh1m8n4mXRZa9BkKvXgX6Gao2oE7LRo8ha3so+WBjFKfaKGX9pfVFGvj+A54y
         j633pIKi9jyVc02tcQCea3K0OOnUCQl/GnaY/XDP+SrVdis+kcn4l7Ss9KmWkkXsG0zp
         C9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702190404; x=1702795204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EynoV2PXYriV37OkBd7LflakvlW/dPuJ1KwDl4hKKJs=;
        b=nzHI7viE15hifVavHE+4o5tZhsKRLOIg8DJZAjRd+/dgt+HGUivRxO6jnXBSP9mFjf
         d2sR1Rc2nVwtEVZVVJzc+KdYBdzyPzhw6oYa87yHYmz2QORrNcVGbpgS8EMd3nQshDaq
         5b4tGXkMpYYCRAENotkKEOcApRJ7kT5UWZFss534T0xkrGOO31LemxhqgdbL1MgBCJpt
         B4mMy6N1UOtRi6ec5gZSivnHnOrcGAKsdWAMlhfaTNLFOIrmUWNdgBzH6F9UL/C8t12P
         bCjd8gZ5HbG/LJOiOmH0c7gXqxOhbwemo88vcTuh1OL07x2er+65X1CT7knd0YChPh0C
         pbNg==
X-Gm-Message-State: AOJu0Yyz3pLMukmalgz5SlDlme6r42Dcb2MF8otNIfnJjPQi5+4QJZfk
        4Ai9c55y2lOVUggCFtNKMFiduB3U+bs=
X-Google-Smtp-Source: AGHT+IFT4rzupqEde5Wa9N8+6c+71cmUf66Ij5te2pqLTWuzZEgxsRpzDX7kAIBFJR0XCHNOTyyHUQ==
X-Received: by 2002:a92:ca48:0:b0:35d:64b5:a963 with SMTP id q8-20020a92ca48000000b0035d64b5a963mr5014094ilo.25.1702190403857;
        Sat, 09 Dec 2023 22:40:03 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9082:8aa4:377c:de99])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709027d9500b001cfed5524easm4287566plm.288.2023.12.09.22.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 22:40:03 -0800 (PST)
Date:   Sat, 9 Dec 2023 22:40:00 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: pxrc - simplify mutex handling with guard macro
Message-ID: <ZXVdQENays5f4l3b@google.com>
References: <20231202-pxrc-guard-v3-1-2ca8bc8cf689@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202-pxrc-guard-v3-1-2ca8bc8cf689@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 05:59:48PM +0100, Marcus Folkesson wrote:
> Use the guard(mutex) macro for handle mutex lock/unlocks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

-- 
Dmitry

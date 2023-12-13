Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8EB8108B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378444AbjLMDS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378437AbjLMDS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:18:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBB5B0;
        Tue, 12 Dec 2023 19:19:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d06d42a58aso60156905ad.0;
        Tue, 12 Dec 2023 19:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702437543; x=1703042343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWmXv83GuFrI7hutYEzdNu0Ku6w8IjctzPX8l+sPwxY=;
        b=hIwwUZVBXfOASQvupPRGUeKucM7vhLVOvlgw2QvseLzpQ//pbj9EFbvVBp5ZlMa5+X
         sFAZLT33nM0x0umQOl3LcCnDwQkvHmlozA+NptY4RMu1rWySaputLrBCVs1X+43pBaub
         qZ+EEj3OMcZPaPnhoxvT/kbu7Do1Br8gBSzGVByKM59/5aZ5MwtvVNaPA5bb6Sdcp6+3
         uN5/cCQpKTWf2rxplpLrY5Hkb53cSZaZ91ncgcHmzP8F/4uRphm2ZFW8Q/2B6NFeqalp
         TP6rR6w1Un4/zaKtEAmP+dPjkuNSYe9w3QL2jpty7GO96wWarHq56Lq9K9ykimk9hM0q
         9Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702437543; x=1703042343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWmXv83GuFrI7hutYEzdNu0Ku6w8IjctzPX8l+sPwxY=;
        b=qFBxWxk20UDWGMyVn9r0CBnwZ6+y5TK+kfXNy5jpYriDRXTnejQjd/EZch1bmmDODO
         rlhqc5qOCwNwtXLQtCBOTsZGF4GOoGMaTMflwL+56d+TXyu+lhqy96xmFiOSM6AKE8Ou
         frYqEn9Nh5/I9enSBFxmOACvDWBn70KFwd4+rRL2nlK/5lKA8gOxAo9QlZ+IBF0waMju
         80IvkeiY6mCWUgcKf3/1bQUroqBhO32l4uU3aR5Tvjkem3+AYzXO2x94lDFXWMy9t1pq
         Op/cI+Sw9feg2UNCOZ79HwOtwKDQLTPw0VQSTWy1Qdfd+ma5VcGnIYn7GjXKgPPVCwhW
         09ZA==
X-Gm-Message-State: AOJu0Yz7bLuQito5e5tjnbIuVSnh7wA9l7gVVCBU8J3awq4PfbpRNBNI
        L4q+0gC4hpoe0iWkyfBFOvE=
X-Google-Smtp-Source: AGHT+IG9OUntF8pX2RuDzb0gW0oJFi17VDtxIf1miCfjKSEDF0NW65CRM1trZRB8noDJCvm/FUnB7A==
X-Received: by 2002:a17:903:11c7:b0:1d0:b9f4:800f with SMTP id q7-20020a17090311c700b001d0b9f4800fmr7918313plh.109.1702437542672;
        Tue, 12 Dec 2023 19:19:02 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:96c1:256f:67e0:c0db])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001cf85115f3asm9369526plf.235.2023.12.12.19.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 19:19:02 -0800 (PST)
Date:   Tue, 12 Dec 2023 19:18:59 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Valek - 2N <jiriv@axis.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v6 2/2] Input: cap11xx - add advanced sensitivity settings
Message-ID: <ZXkio6XEUXSUg1V_@google.com>
References: <20231121155250.613242-1-jiriv@axis.com>
 <20231121155250.613242-3-jiriv@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121155250.613242-3-jiriv@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:52:50PM +0100, Jiri Valek - 2N wrote:
> Add support for advanced sensitivity settings that allows more precise
> tunig of touch buttons. Input-treshold allows to set the sensitivity for
> each channel separately. Also add signal guard feature for CAP129x chips.
> 
> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>

Applied, thank you.

-- 
Dmitry

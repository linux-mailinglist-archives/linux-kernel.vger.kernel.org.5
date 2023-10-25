Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F747D6487
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjJYIGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjJYIG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:06:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D805C19F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:06:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so8276658a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698221182; x=1698825982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zC2TSZlkArYjd0Zn+EKaoOOxS7ekpV0bgo5pOESIDM8=;
        b=jzsO0oLrgMuiqSgMpA6ZcyNQxxL5A+2sqEZ5tBvNWr0ybBAvNZ5nMaOFQ4uxWWWpk0
         7za3w56rSF/i4prwsfDC8ILSbk2/r1cuuvRW1dYhFw0yzX++HAHvHc1ZFzN4LjSkn874
         yakuB6Lb7SxtYTyMvf1bwkFDQ+xylTHNB+Zoa03tTW+F969/DBHx4V92goBLjDkP491i
         wEpe40cNXXHf4jDmyyVMUYBZVNZYzV1Uu19QSoRs4Kq+VElklcU0STcirI+WW+YRFk2t
         AtUtJTROafZl66yxJHdzSWzAgFi4Gs7iys9Qmf3WB1WXu3gcDyMQrLCVVDPHshZA85oD
         Myeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698221182; x=1698825982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC2TSZlkArYjd0Zn+EKaoOOxS7ekpV0bgo5pOESIDM8=;
        b=oD5age5qBLbqsxh+RHHEF4qG+hZCcD3qNMhV3dFL8ljvMCnBvr5utQZtn9OytQhj2v
         AMLvZ+9mOEWaJZWzJAgal/vc+Cdmkz3Q4V/f68G2Od8d+7zKjbiNuAVulYq35mnQOgyH
         3aOgzhaHSMIm2XdCtqARFjtTi+d5OT0kYcqzrJQh/nGgkO8EoQT0lSKZydnbt922RoRU
         ZZoI65L4y5xB+7TRW+4Zk999S746NfmNZlXNM0+GFm8gbrKmcKyn4zGYnwJA+Bvfie4v
         kNHUyBcl75Vdk+YcPPi8UJ2NnKTfnjgcrN/FQ5nlSIJpP5fIcPw5S9YKntYG9YsHfLxc
         H07g==
X-Gm-Message-State: AOJu0YzrIYTWTj4wQ22Ahu1ejV0cXi2p5Tmt7FxSqw5uXhubne/eyPXs
        w6VGB12yDhL7HrwT/tGZTmfao19BjcE=
X-Google-Smtp-Source: AGHT+IEf4WCLYxPfAAmfTizaXuHQHMknqgEic4RxkYoJJOyQqr/gYes9Gkps9eaJ2XNwtVPte3Hx4g==
X-Received: by 2002:a50:8712:0:b0:53e:232b:121c with SMTP id i18-20020a508712000000b0053e232b121cmr9369741edb.3.1698221182076;
        Wed, 25 Oct 2023 01:06:22 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id v19-20020a50d093000000b0053e2a64b5f8sm9169912edd.14.2023.10.25.01.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:06:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 25 Oct 2023 10:06:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/common: Fix typo in comments
Message-ID: <ZTjMe3+bjVT23f4L@gmail.com>
References: <20231025055927.1861-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025055927.1861-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Deming Wang <wangdeming@inspur.com> wrote:

> The word "advertize" should be replaced by "advertise".

This patch is wrong, please type "advertise or advertize" into your 
favorite search engine.

Thanks,

	Ingo

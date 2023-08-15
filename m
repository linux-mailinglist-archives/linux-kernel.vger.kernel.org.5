Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8847277D6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbjHOXoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240700AbjHOXoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:44:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E75B199D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:44:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6887b3613e4so269259b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692143061; x=1692747861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG5YLVC3eDKirzY40GTGyFbIQV7NMpfOOW8qjICzL9g=;
        b=oBXtosF0pp2dlR76dRPteSznb7v90y3c6+QKAWDhL0B6LTQLODDst9tl3HBtqXjUA8
         EybyR9mmvR+KQNYPEAvYX8oupycUhhaQu1sCAeF4KwKh7OicB3Mo0FjopdJ0TG+2HhQb
         qyGQY2g3xsuvhVaqH+E/g9x60PXAhkkqYZIEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692143061; x=1692747861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vG5YLVC3eDKirzY40GTGyFbIQV7NMpfOOW8qjICzL9g=;
        b=GM4+Gndk1M3453XSy+bAA2LUTDYz+CIlL2zPCZ1KIYfDSqS+azm4We/OcgLYPOw60W
         9eBMN/mRhPTLG/HRHdUTDmMUajjFsL8Z659BS40Gi3VTvz0HmrnBoPPn286C/d518m4a
         Cq3WtuGwMxe2ZYua0pq7EpmRObhYjH+9WCuH6BczR0LT2Kb7XaXW3cTp78cl1h+Xr8Wg
         F+Hfv/87nF51oHe2AMyPupV2d3wz/ttv9Xf5WO2Q0Cy73iQUJiQZXUpo128xRGvchEM1
         rIFTCHTAWGRMSSdwmjEs7L0hEk6rLmBbRcMnyflhkPZS3J2gqEGXse0c3cObzBdAK/ZQ
         7H/A==
X-Gm-Message-State: AOJu0YzSsreHcGjkF6PPM0MBb4Dq4fFlx4IVFtOaZA2DubsMOH2rRvLB
        gu7OW+kBDgbK4D5Zqla0FIgnMQ==
X-Google-Smtp-Source: AGHT+IG8Qw+6jUTPGs1F8o/6hKdeLl9A+ocEC7eGLPrbZ6ZXpvHBmVQO4M3yBWHEjJZizziKMOuRSA==
X-Received: by 2002:a05:6a21:61a:b0:12b:fe14:907e with SMTP id ll26-20020a056a21061a00b0012bfe14907emr378877pzb.20.1692143061097;
        Tue, 15 Aug 2023 16:44:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s11-20020aa78d4b000000b006878f50d071sm9735097pfe.203.2023.08.15.16.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:44:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alpha: Replace one-element array with flexible-array member
Date:   Tue, 15 Aug 2023 16:44:12 -0700
Message-Id: <169214305098.657491.4672688597029199904.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZMpZZBShlLqyD3ax@work>
References: <ZMpZZBShlLqyD3ax@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023 07:25:56 -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct osf_dirent with flexible-array
> member.
> 
> This results in no differences in binary output.
> [...]

Applied to for-next/hardening, thanks!

[1/1] alpha: Replace one-element array with flexible-array member
      https://git.kernel.org/kees/c/967afdf808cf

Take care,

-- 
Kees Cook


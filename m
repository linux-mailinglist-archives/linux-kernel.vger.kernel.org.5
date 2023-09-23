Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6FD7ABDA3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 05:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjIWDzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 23:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIWDy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 23:54:57 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882AE100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 20:54:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-414e78cdc11so19541501cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 20:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695441290; x=1696046090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXxf1RoiosXQhC+2G8YZWoday3+5yhFzk5HBzXNQsK4=;
        b=VBjUeQwE2wECv8PNFipWLCFqoBNhqLghT1xNTc3LgFbQatJBVQkQLB9W+4Fu8c9528
         A2CX+/pFCZDfEc/FdL/jlrLJRouFcPcWg5ELokwDQ8e7mG2YaB19zWNhVOVIXZjaUAHr
         Tu1El7gpsa6khUXfn0Yry7GPUFfLWcBmCxosw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695441290; x=1696046090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXxf1RoiosXQhC+2G8YZWoday3+5yhFzk5HBzXNQsK4=;
        b=DGjFnMbZm0rYwejar4WieWIo5s352vHZHgz875fe616HBufPNa9MmmUemx+n1gYN6a
         efY67/6vQDC9eOHA3+TSuXvmpznQtvgygCyHhKQdJ9sHc3uk8yQlo/oGNNsY8czbkJkH
         3sMk3EEowIRTbYo5z7iSjOqVA2voIsqRBTPDRdqhkuQT4Wk09+m32V4Iret/6kD0ZdHZ
         OodUJTf5qEdt43Xcv/ggORXIxZehVWffrMI2i5gXCou9ToGi5z8WMLBBFGUR38Z2+ppm
         1UooeBnrg9Xu6iUTIusUHLMhcOOwwY5luus+b2gl66TqGW0brAsJV/d7WJ7/EKsIHHsK
         z4xw==
X-Gm-Message-State: AOJu0YyW+YXtU2y53u3GsPrVzR/wXPTMVyemHE1gA1hTb1QMzYI4KI3q
        kJn/fhDEe4kXdCDX7nebcHBbvw==
X-Google-Smtp-Source: AGHT+IEzt4fgn07srY0tT7RQhPw1lcJSuwyuEmyS8kmvHG7XZR28qzbYstCUhTI7cCyTe4YELv05eQ==
X-Received: by 2002:ac8:7e90:0:b0:417:e0ff:931e with SMTP id w16-20020ac87e90000000b00417e0ff931emr1491182qtj.41.1695441290599;
        Fri, 22 Sep 2023 20:54:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g11-20020a63b14b000000b00577cda166ffsm3901318pgp.35.2023.09.22.20.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 20:54:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>, dianders@chromium.org,
        sumit.garg@linaro.org, swboyd@chromium.org
Subject: Re: [PATCH v2] lkdtm/bugs: add test for panic() with stuck secondary CPUs
Date:   Fri, 22 Sep 2023 20:54:18 -0700
Message-Id: <169544125511.3844201.2326680356367331620.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921161634.4063233-1-mark.rutland@arm.com>
References: <20230921161634.4063233-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 17:16:34 +0100, Mark Rutland wrote:
> Upon a panic() the kernel will use either smp_send_stop() or
> crash_smp_send_stop() to attempt to stop secondary CPUs via an IPI,
> which may or may not be an NMI. Generally it's preferable that this is an
> NMI so that CPUs can be stopped in as many situations as possible, but
> it's not always possible to provide an NMI, and there are cases where
> CPUs may be unable to handle the NMI regardless.
> 
> [...]

I added a line to tests.tst and applied this to for-next/hardening, thanks!

[1/1] lkdtm/bugs: add test for panic() with stuck secondary CPUs
      https://git.kernel.org/kees/c/5fb07db970cf

Take care,

-- 
Kees Cook


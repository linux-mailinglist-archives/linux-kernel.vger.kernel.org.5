Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C887EDEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345041AbjKPKoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbjKPKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:44:08 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ECED41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:43:53 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bd85b1939aso453924a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700131432; x=1700736232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=29fuk3cKvRWSP0UKhodaCerrGAHQ5jx/mJv0HuB+frI=;
        b=LsJ5Y9BR4rCtz4BLCrXJX84s/jIFJLYBRO+zh+Vzm77WefVAfopPS3k98kFEvbnruH
         W1ZEggwgO9pVuSD/hJf5lQCynnSet0gqzFfGhqcCj2leZZyuMJl7JJBklbXaVn1fCUMd
         jzPpnVficzXJWB1U6v1Udo5SzJAPBMziwSFqXSWFCG1JdA1PuXuz5GPMCw9Tzl2K2GTR
         OMz+0D+Hk/MSe1i5iUiAcAsXMcV+56t5Q3TPiaqTf9A3bDqMBOQHLWvEHsbLgeS19ad1
         1ySkp/OQ/B9SzIe4yCyCtOsoC2GqlMXRiR5IMoYv6OvqEx0mbBt6aVFqPmKyxDQjrhaA
         7SXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131432; x=1700736232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29fuk3cKvRWSP0UKhodaCerrGAHQ5jx/mJv0HuB+frI=;
        b=wQ+ACVJaizO56yE3ljxc0nsMlalrAOmr+B/VW/yhwX/WHL4NMWWyOtiaOYHi4My2Bp
         PBhZ5MUYgZ7gHkArwjHk7KnuA+y9COiTEoeE5p8jjm9OjSczUhLnvOvGlTzIT92XgxfQ
         YwEMBLgwzRKXQ8EtygIEOixd+ImSfbXmUl9CJn994wE5gHErVAERcTQZvJlZWY/7QvXr
         GUTleOQTFa1gv8+sI9TyFJC+8utgdxFLfQtElimj47HecAkuaZy5GF2LZgD8vcpdheUL
         51hfqmY0DZFZ15809x2cqg//qKWt4+lUEkHWtOdt+SsiYJycFjT6P4vMiQCSA21/n6dV
         +snw==
X-Gm-Message-State: AOJu0YxgFDmKURNrraO8Sk4EM4Q2bA51SfS1q1b4S2crlSGma33zS+1K
        PsaLZbCHdOG9jMuutsvYC3DV8w==
X-Google-Smtp-Source: AGHT+IEdFlFVFMS/e1l3aghlAjW/tnwrkk8il+GhV6zlJiS+S4u1py6IMECzjKXgLsENKXysW8JYhQ==
X-Received: by 2002:a05:6a20:440d:b0:186:3f74:d60a with SMTP id ce13-20020a056a20440d00b001863f74d60amr13351934pzb.0.1700131432215;
        Thu, 16 Nov 2023 02:43:52 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78196000000b006c4cf21489asm4201825pfi.205.2023.11.16.02.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:43:51 -0800 (PST)
Date:   Thu, 16 Nov 2023 16:13:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] OPP: Simplify required-opp handling
Message-ID: <20231116104349.rtyypzvnwknz5hdu@vireshk-i7>
References: <cover.1698661048.git.viresh.kumar@linaro.org>
 <20231103052854.bc7jqaubc5uj6ncj@vireshk-i7>
 <ZUS8OC6tY4sxS5RA@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUS8OC6tY4sxS5RA@gerhold.net>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-23, 10:24, Stephan Gerhold wrote:
> The warning in _link_required_opps() when using the parent genpd setup
> [1] is still present though. Given that this setup is an existing
> feature in the genpd core I would appreciate if we try to find a
> solution before merging this patch set. It's kind of a regression
> otherwise since the warning isn't present without this patch set.
> Maybe someone else is already actively using such a setup.

Can you please try V3. The warning should be gone now.

-- 
viresh

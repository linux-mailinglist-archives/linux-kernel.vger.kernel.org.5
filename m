Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF05C78EB14
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbjHaKvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbjHaKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:51:05 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2718FE7E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:50:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fa455cd94so543215a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693479022; x=1694083822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxR0j8Kpr/8+VWKozmTx/RUScUjID2WQQTbSpf6tvCU=;
        b=Pq7f0LtDoVNGEP6cprzPC/82mqto1QaVoLhgSft9UT2fEYpxocjcJD+dUw1452OuSi
         cNKjrn8umT4Fg8gOJpJnps9I8TH78kooisJzouWKsrPBUOvBuw16i5xafOvtKqbUWugl
         DZPDhueQInJwz0zqRsRAS6M3LVdTov3LA2+WCzWAkYNKPbre70DMKjPvBgQo5IsRD1aJ
         2+6MWZPaAcPvkBJs1uRvV0Ju5PAhX587eM2tJs7P2McYKedgvM5/PCxtoR82ElnraHTS
         dvBqxhe5geDOoG/2Z7Klo4bRc/0h5pW1QdjAM8irA4X16tK7Smh8JVmeQPYx9weK7uk9
         twnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693479022; x=1694083822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxR0j8Kpr/8+VWKozmTx/RUScUjID2WQQTbSpf6tvCU=;
        b=Vb2ksmv0LkO7FxmLX1RugYMJjYIM28qhqjFdjqb6TzXDFhkGHOvEKer/k/GIjLXl7J
         hYuPPtSlNKlzj6lrj42diUJt73F3JG+WGyupABCAK1TA2DZWeRb9eG4EbMRieVa4MatE
         bWuf9y9OhSmRJLtrBY0zJ05XCnZMFZKkPoQvoeA96ZuUHo5BAC/qL4x/k2DFE2WslRYh
         nRoJz8Lh2v31n89X1MPoTAQtQvOpTEHDJTCyNGmwQaYjLqule/IzMJxpqkUbMnmTOljf
         QPXT7nNuHOzQ6L/jjwshPp6Dh63FHSbZ27O8Zz1+Ivl9k/yAheDlhiVktflcTHwHtusA
         Mopg==
X-Gm-Message-State: AOJu0Yzyy3X6IC3nZm9ZZjVi1ob62+6UrGkKphAepjuvMHDA4Ql20Omj
        2lIbs6HrHzSXtXzdWNpHvhkLmw==
X-Google-Smtp-Source: AGHT+IF/N6kvZqqOlFL6EU1qe3a6zE5IoQRA1yx9c/gcAEiZDkMV1pDAP5Qq+1SEWJGBX9KnigX4pQ==
X-Received: by 2002:a05:6a21:999a:b0:137:3c67:85d7 with SMTP id ve26-20020a056a21999a00b001373c6785d7mr6100214pzb.16.1693479022172;
        Thu, 31 Aug 2023 03:50:22 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id k24-20020aa78218000000b0068bc461b68fsm1064814pfi.204.2023.08.31.03.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 03:50:21 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:20:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhipeng Wang <zhipeng.wang_1@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 2/2] cpufreq: dt-platdev: Support building
 cpufreq platdev driver as module
Message-ID: <20230831105019.tre5hgoad5tpiwwx@vireshk-i7>
References: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
 <20230524153417.2738448-2-zhipeng.wang_1@nxp.com>
 <ZO4yTQAV9EYA4erZ@aurel32.net>
 <PAXPR04MB8304AA1D331B3DA5B548EE3EEBE6A@PAXPR04MB8304.eurprd04.prod.outlook.com>
 <ZO7O056MxAnjvGxu@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO7O056MxAnjvGxu@aurel32.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-23, 07:08, Aurelien Jarno wrote:
> Hi,
> 
> On 2023-08-30 03:09, Zhipeng Wang wrote:
> > Hi Aurelien,
> > 
> > I'm not sure why we need to make cpufreq-dt-platdev autoloading, does it make sense? As I understand it we need to actively modprobe cpufreq-dt-platdev, why not?
> 
> This is needed to recover the old behavior, where if a CPU supports
> cpufreq-dt, it get loaded automatically. Now users has to modprobe
> cpufreq-dt-platdev explicitly to get cpufreq-dt to work. This seems like
> a regression to me.
> 
> Of course one can explicitly make CPUFREQ_DT_PLATDEV=y, but the default
> is to build cpufreq-dt-platdev as module when cpufreq-dt is built as
> module.

Feel free to send me a patch to make this auto-load.

-- 
viresh

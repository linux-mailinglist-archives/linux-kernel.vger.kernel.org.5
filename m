Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EED7521FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjGMMzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjGMMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:55:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4E926AC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p4aoKL/QH4xn1ZA9zsPz4p9Apn8+sEusDQ+4D/YZr+o=; b=My6Go90jmd+B96NXN69vDK80PZ
        W2/PzX8ux0mTB16vr/MccHgA0N95wbM0NyXAAxX0hS/YZXE4zFyra9yXqlCl7ZlPYvCzjCsCMjSQN
        FxK+EtUBDlF5AbYQkPK4Mz+AFhHrj4PdbaPjd5jarYz1NwHfMDF2jBIZjFZ4WMxxd2z0/uMb9FO81
        /UJnhr+d0y5s9V78fvugU5jGjsZEpTCtCJ5XPjKruxKZlXLI44ERW+VTk5V2yK+QnKkfr44r+cJqT
        tVMklk6FDPEqL5iGhgrtsTI7OJ3x0luXgYV/pv2DDYAWIENAl9TUnoSlxiY3mmhFFhNcIAG0JuTOm
        QrFtDrDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJvqy-004i8h-11;
        Thu, 13 Jul 2023 12:55:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FA073004AF;
        Thu, 13 Jul 2023 14:55:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2591D245F4426; Thu, 13 Jul 2023 14:55:26 +0200 (CEST)
Date:   Thu, 13 Jul 2023 14:55:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Henry Wu <triangletrap12@gmail.com>
Cc:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Possible race in rt_mutex_adjust_prio_chain
Message-ID: <20230713125525.GH3139243@hirez.programming.kicks-ass.net>
References: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
 <20230706120103.GJ2833176@hirez.programming.kicks-ass.net>
 <CAG-UpRTQ-ovVO02HRd5z-9oZGCPvZ0vODJse8oyuA9L-3NV_pQ@mail.gmail.com>
 <CAG-UpRRLFTHg64b0hG4=FbuzhhqNQEU8jGt6TygCVAK1BaT2kQ@mail.gmail.com>
 <20230707125942.GB2883469@hirez.programming.kicks-ass.net>
 <f4e839ac5ecb285b8a9d666f1a73e0a39b698864.camel@gmx.de>
 <CAG-UpRTur0PHkWNZ0FqLnz5K85P-HQkuO-PCCxOwJ5XVgwgxyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG-UpRTur0PHkWNZ0FqLnz5K85P-HQkuO-PCCxOwJ5XVgwgxyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 01:28:25AM +0800, Henry Wu wrote:

> I will test final patch if available.

https://lkml.kernel.org/r/20230707161052.GF2883469%40hirez.programming.kicks-ass.net

Does that work for you; could you reply with a tested-by if possible?

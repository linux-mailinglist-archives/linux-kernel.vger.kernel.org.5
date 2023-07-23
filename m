Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B6875E5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjGWWph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:45:35 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B751AA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:45:35 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6b9ed0831bcso2884343a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690152334; x=1690757134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+ooKXUaxz7S7zGhiMiEBGa8/B1a4kT9H2dXrsEtE5M=;
        b=Ug+sTPW/Hr8EOF8df+/z6LxEMtabphua/4aUyUyFjN1MVaj2O0yO9HumkzKkEHmZfj
         KcHa+MGq8mcddfLvM8mIbynwl11Qh2Kwu+QX2lFxSbeBXPcTVMgpSO/hEQ4OjvMRNTAi
         DxBYzpdYU3/FnqC7wK3qdxU0MRi5HHse6FZdHM8Q5LYyrzinaJkgHV7Kf9JZVRxZi0my
         JL+zjXWnlpFyr9V04wAJPeusV4SWbNgA0Mx0e4CZztwlHjfgBWzIPfWVKPxn0IStC8Fu
         kADF4wdx+4kSd25mq5H6AevBU1j9XHBRelpbCCS1GsI2ReJqKdTDIXqhmqGDWMi4ZOjQ
         Ufug==
X-Gm-Message-State: ABy/qLYQD9eAG8GKYVQVInmSGL9pxG/1hsTPO/1C1MBI2GLiHyvKUfId
        MgOFtxmTX9BUZJLBQssBso4=
X-Google-Smtp-Source: APBJJlHXJi/sSucbixQZ2fbJ2iqQ2gCiVMnMjHLqHySR77gqtmD2eVRUo/sITXTo+JrO1T6HsB/LEw==
X-Received: by 2002:a9d:685a:0:b0:6b8:7a79:db37 with SMTP id c26-20020a9d685a000000b006b87a79db37mr6887438oto.22.1690152334350;
        Sun, 23 Jul 2023 15:45:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902bd8600b001b9cf522c07sm7342873pls.57.2023.07.23.15.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 15:45:33 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:45:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 47/58] x86/apic: Remove pointless arguments from
 [native_]eoi_write()
Message-ID: <ZL2tjHz0hvfEyrZc@liuwe-devbox-debian-v2>
References: <20230717223049.327865981@linutronix.de>
 <20230717223225.875917164@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717223225.875917164@linutronix.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:15:47AM +0200, Thomas Gleixner wrote:
> Every callsite hands in the same constants which is a pointless exercise
> and cannot be optimized by the compiler due to the indirect calls.
> 
> Use the constants in the eoi() callbacks and remove the arguments.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/hyperv/hv_apic.c             |    6 +++---

The change looks trivially correct.

In conjunction with the function name change:

Reviewed-by: Wei Liu <wei.liu@kernel.org>


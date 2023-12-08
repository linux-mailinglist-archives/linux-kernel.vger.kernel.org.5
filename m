Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F097E80A533
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573912AbjLHONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573881AbjLHONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:13:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DDF10F1;
        Fri,  8 Dec 2023 06:13:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702044800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ozIt0NpDzyo+Um0CWiKiW7MbyrySc7KdMzm0CGPzvo=;
        b=DlHwMQpaXXu9BhQft/LEkcmfYfndeA0JHHiXh79nshdASb0bAd2Z/klENPH+N4myV1G122
        4B3k4UTw63qVars0Nwp/WQxVw2Wx9blklGJCq9I8Vae6FgrA5hWRwy9l4emdKzWr9pVwhP
        +kYw8UjZIZsWpL5XuWrfwmaPKIT+I2UEtBdLJleL96glP86AHjLkjqjEXz97NISbeUFba5
        RQ6/kaEtsbWwsBIbeTQkZW6iS7154lQtl/u50Y2w3kJOH9UXWf2S32eBzfGfauphyD7ZoZ
        ympLna5q+pczEwnWH1nkk/OtXU+4rt6uXPAW6fYmkZjVM4jMEk4M84altptwwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702044800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ozIt0NpDzyo+Um0CWiKiW7MbyrySc7KdMzm0CGPzvo=;
        b=nNtuGdKFbQkUmGMEp2doPQYFowq/a6IiDjr7VB3UWAe8RUZPqQstA4RYB8U8SC1EroxuSh
        wRykCv5Ci1i0K6Aw==
To:     Haoran Liu <liuhaoran14@163.com>, tsbogend@alpha.franken.de
Cc:     fancer.lancer@gmail.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: Re: [PATCH] [irqchip] mips-cpu: Add error handling in
 mips_cpu_register_ipi_domain
In-Reply-To: <20231130040642.36133-1-liuhaoran14@163.com>
References: <20231130040642.36133-1-liuhaoran14@163.com>
Date:   Fri, 08 Dec 2023 15:13:19 +0100
Message-ID: <87o7f0sry8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29 2023 at 20:06, Haoran Liu wrote:

The subject line:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

> This patch enhances the mips_cpu_register_ipi_domain function in

# git grep 'This patch' Documentation/process/

> drivers/irqchip/irq-mips-cpu.c by adding error handling for the
> kzalloc

The file name is irrelevant. Please read and follow:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> call. Previously, the function lacked proper handling for kzalloc
> failures, which could lead to potential null pointer dereference issues
> under low memory conditions.

The value of this "enhancement" is dubious. if that kzalloc() fails then
any subsequent allocation will fail too and the machine will crash
anyway.


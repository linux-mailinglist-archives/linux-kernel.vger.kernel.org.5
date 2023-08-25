Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3655C788C01
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbjHYO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343856AbjHYO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:58:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A372126
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:58:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692975507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z50Zlf0WBiUUPkv8o6nl7O/SvnFHeiBLX4CM9sRY9c0=;
        b=JSIyzlsnNPkjGa2p1xkZtvE7bAfUb+qfBRuuQB8WO2QUGbwne6AYw7X0EaXuKyyykJEWoL
        hcpt8fgXzq1BrFTKDSOkClB2+2tFUHBeNcetgUcOQUHbp9Hy2zCKUmdXFyz1jH0ZxWzffG
        oxSIywnt9jcCiLxramh4RH26S/MBsNBJmoiwyiXhgaMUrg8lXLA1UmYHOh5nUAtVASy4Zn
        v4IRBmzm8y83/8B8sUxJGZ4rORW3FlRJk3dZ/rJ8FpIsWVYvOAIPUu6cfXKngippibTgeu
        5fGCv8axgfUnx9vV56YIeukTMuzhaRVXXyIGiyWs2Uk9P0QxbMADCvpbyFWNYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692975507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z50Zlf0WBiUUPkv8o6nl7O/SvnFHeiBLX4CM9sRY9c0=;
        b=8gVlLCC4rrTzUBlawMg/1Rgj0PyGxN3V5U8nFSQzsMjfC0DHVkNW1/D5ETPKyzSMwyg5S7
        WWWWBjF/V7iyGwAA==
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
In-Reply-To: <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
References: <20230814093621.23209-1-brgl@bgdev.pl>
 <20230814093621.23209-3-brgl@bgdev.pl> <875y54ci86.ffs@tglx>
 <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx>
 <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
Date:   Fri, 25 Aug 2023 16:58:26 +0200
Message-ID: <87v8d3b23x.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25 2023 at 13:01, Bartosz Golaszewski wrote:
> On Fri, Aug 25, 2023 at 10:11=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> I was under the impression that the whole irqnum-to-irq_desc mapping
> was designed to handle this situation on purpose, hence a check for
> !desc and a silent return in free_irq(). If a missing mapping was a
> bug, then it would warrant at least a warning, right?

The check for !desc has nothing to do with the problem you are trying to
solve. There is obviously a valid interrupt descriptor so desc !=3D NULL,
otherwise there would be no procfs entries and no actions, no?

Thanks,

        tglx

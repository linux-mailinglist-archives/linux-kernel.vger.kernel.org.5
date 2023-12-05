Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26BD8053DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjLEMMQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 07:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjLEMMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:12:16 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6AC3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:12:22 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1fb1620a00eso710839fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701778342; x=1702383142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1huvNNeQ9UeMMl5w2SdOEQfS8q+089rdbok3L8xrR0=;
        b=UTXxrwthkVwsfnbocwFp42bZ3ecSiNZZqcZVPlAJo0Jecor1F2VokNkEIiIPt0bKMM
         5EtwBFN0Tbt780PgdnjqIYx34JJA+UfNXR1wQ0loRLsP6L9Krr+to2t1wy5OC6xbyVsW
         e1SMDi2tU3y2l7fPL2xXNVXM3OGYU9qLwXveksQKY8AncPrZR03PuT+Hqvq8Ohp8PWd2
         abbrS4HqvYGu2rc9D2PI5OAkTXSBZQNow5xJw9b4H/XdYNmEglSVCBXW9ZmcUgdwjUkN
         edjR63KfxY/3RKKTxLgqtGwAyBp0WfdnCpzv3H2fw+sDA999KZMi809LX85V7KZXWb/k
         Qtpw==
X-Gm-Message-State: AOJu0Yzzhq6nu6whIK4g5NN4pEBgVYgQM07XdsaVcm+CgSEhT3vJ4Gd6
        GX4WA4o4NwP7jWdKRm0h3R5SAlB78JfOxrnO0fc=
X-Google-Smtp-Source: AGHT+IEfjIhWLRGwViH71x9Z7/YEug9pRMPSRVxDVnqDzOWTZYKroksfDKA8wBrscRpUy2dktOyw2iDCl8XMXcgdF9M=
X-Received: by 2002:a05:6870:b60c:b0:1fb:5d05:685e with SMTP id
 cm12-20020a056870b60c00b001fb5d05685emr2893332oab.2.1701778342010; Tue, 05
 Dec 2023 04:12:22 -0800 (PST)
MIME-Version: 1.0
References: <53bce76c5c60463eba1372df426a64b9@amazon.co.uk> <1D71D218-5EB6-47DE-A01B-3A66F9F4C74E@infradead.org>
In-Reply-To: <1D71D218-5EB6-47DE-A01B-3A66F9F4C74E@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Dec 2023 13:12:09 +0100
Message-ID: <CAJZ5v0iVvMLK_VcPRJ4sW1eOh0EtfcFvKjH5j1y1GbA0Y6q--Q@mail.gmail.com>
Subject: Re: [PATCH] x86: intel_epb: Add earlyparam option to keep bias at performance
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     pdurrant@amazon.co.uk, bp@alien8.de, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, hdegoede@redhat.com, hpa@zytor.com,
        jalliste@amazon.co.uk, juew@amazon.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, tglx@linutronix.de, usama.arif@bytedance.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:00 PM David Woodhouse <dwmw2@infradead.org> wrote:
>
>
> Paul writes:
> > The problem is that this will take effect even on a kexec and hence it is throttling
> > a system that set ENERGY_PERF_BIAS_PERFORMANCE prior to the kexec.  We use kexec to
> > live update the host kernel of our systems whilst leaving virtual machines running.
> > This resetting of the perf bias is having a very detrimental effect on the downtime
> > of our systems across the live update - about a 7 fold increase.
>
> It isn't just about kexec, is it? Even in a clean boot why wouldn't we want to stay in performance mode until the kernel has *finished* booting?

Because it may overheat during that period.

> It's literally adding seconds to the startup time in some cases.
>
> And yes, we *particularly* care in the kexec case because guests experience it as excessive steal time. But it ain't great in the general case either, surely?

So IMV it would be perfectly fine to add a command line arg to provide
the initial value of energy_perf_bias for the ones who know what they
are doing.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1DB797F10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjIGXIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjIGXIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:08:44 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A53F2105
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 16:08:08 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-49334907238so519275e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 16:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694128084; x=1694732884; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EGrTs9IEoHVg0i1V0nP1EnGrXTJSERh0Kb4udXyvr8=;
        b=Yo7G8osoMXN74dEzdA7tFZruRZ49LlrAQsL+SBbVHSj7edau0p8zcDnuNAbIVXIQwO
         mPpYOlHYwgfuz8fJ8olke6WzixxXutSpzMlAmLptvyW6igvJjxRX13QNiKKavsCDaoey
         TPhYIFcUtN8kn9ZBxmoKbT/oURAiXQKXkpsl5oU5Gb4uatH1c/cGVL7TxQmT6/j4+5jS
         tJLhRtZ/vz7teGpG1rAG7co4/uFTg7xW27qiXgD9gOS7090mqck57zvG3MPhjiYdsRYI
         hsMhlc+4GNsZ/SjN5lSW3oCCeSmcl67ti/JIhtu5wCdbE/PHNSULif8ovyb76DLSOXS2
         R1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694128084; x=1694732884;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EGrTs9IEoHVg0i1V0nP1EnGrXTJSERh0Kb4udXyvr8=;
        b=JZLiIC6vPhB0ufcs4Ijd3dfYo4z3sYVDlGxJqQYmLN24lIodHdn63bcXTXXOzXUZNe
         dxhUkqDMGx7xYz3XPo81ypL0AnASeb7h0jg63IXfPUZCCB4YphI9/enAnn51C2EnGk4e
         Lc1FPJNIdD8nxg6N6xOvPLc3HkxsggDQryMpmfuXB+5oqoH07748ydWImXPSZtuJuTVE
         kXYdNHZLcPPluOMRnCIeV+PosKZNI981R9RKnkO4np4jaETi9OL9Qp3rPh9sPcP6GkXG
         kOVTI7UvFmbutAIJLNlGVit/XZpo8xPv9KM9L6Ho2O0zj6kpmOfM6V4iuQRPh55mOWcv
         Ffvg==
X-Gm-Message-State: AOJu0Yx8weEHJIQ1//QR52YSi6kAwSq76kFHmM5RkU3HEOW6+xnbL086
        ustr/kGmjBZ4s2LtPNxUduc=
X-Google-Smtp-Source: AGHT+IF+P2oV641MbPBzfVdFETip/2bu98aLkTXgK+0LrlYZPtpnaBuAXeWNHNgzWqWtEJpnZ60igA==
X-Received: by 2002:a1f:cac7:0:b0:48d:3983:24b3 with SMTP id a190-20020a1fcac7000000b0048d398324b3mr1105726vkg.8.1694128084118;
        Thu, 07 Sep 2023 16:08:04 -0700 (PDT)
Received: from smtpclient.apple ([2601:189:8480:9a90:e176:8006:767b:ffee])
        by smtp.gmail.com with ESMTPSA id f27-20020ac86edb000000b00403cc36f318sm201061qtv.6.2023.09.07.16.08.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Sep 2023 16:08:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: Memory protection keys: Signal handlers crash if pkey0 is
 write-disabled
From:   Robert Kueffner <r.m.kueffner@gmail.com>
In-Reply-To: <c0159d08-e69d-0329-5ca9-68fd26cab0c8@intel.com>
Date:   Thu, 7 Sep 2023 19:07:52 -0400
Cc:     Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Robert Kueffner <r.m.kueffner@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E821837A-22AD-420C-A290-8511344E7EAF@gmail.com>
References: <FF299375-B46F-46D0-90A9-333959FE9380@gmail.com>
 <c0159d08-e69d-0329-5ca9-68fd26cab0c8@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I assume that *something* is trying to access pkey-0-protected memory.
> Any idea what that is?  Which entity is doing that access and what are
> they accessing?  The page fault tracepoints might come in handy.

If I understand correctly, the kernel (a) pushes the processor state =
onto the stack and (b) resets PKRU=3D0x55555554 some time before =
switching to the signal handler. And may try between (a) and (b) to =
write pkey-0-protected memory.=20

This would be compatible with what I see when my user code causes a FPE, =
upon which there is a SEGV before the kernel switches to my signal =
handler.=20

If the user code causes SEGV my signal handler actually executes and =
only fails later when returning from syscall 14 in sigprocmask(), i.e. =
sigprocmask() =3D> __GI___sigprocmask =3D> __GI___pthread_sigmask =3D> =
syscall 14

I will look into tracepoints - but that would be diagnostic rather

As a farfetched solution, would there be a way, perhaps via a kernel =
hook, to reset PKRU before the kernel actually starts processing the =
signal?=

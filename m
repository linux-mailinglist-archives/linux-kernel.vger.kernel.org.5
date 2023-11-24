Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B757F8625
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjKXW36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXW35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:29:57 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3181701
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:30:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b3e7f2fd9so2089485e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1700865001; x=1701469801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9aMoVAYZDthyr2anGCDJRxJF5mVykGeJEK+2TP+uDA=;
        b=mpKF3jkvLQkZD3AydPUFWQgxTtNJ5BpR+u5CWkZSHj66HKpXkh6NYDf8iI4KTZdHxw
         b+N/rdZcKumT0oDyCJlgLfzSsoqudC6zoVJv10aL4zkrumjviYZLlLWoLZpjfNLqzcQl
         yjIbOA4BOOanvOsw9BU7VF7bA3rNIAWsnEg1xqZqIqbMeeNM3ztwwk/bu5odN4Y4i65C
         ynsbgnk2FD9PDr+80W234Rinv1Ri7c4cKS0HcbF1nd90QuYUDZCVFM7CAOvlElCiMcnT
         fufl7nbPlLZOXq6t4ZrIbze0/j1QyRQ1ZFnka9IVKiH81A8MJnRqzfYXU1ZfjMSQ0cp5
         e/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700865001; x=1701469801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9aMoVAYZDthyr2anGCDJRxJF5mVykGeJEK+2TP+uDA=;
        b=DQ4CjCvz1MaTUM3TEpfC9gAs8BswMBy5P7WrZJF2TGzd67bRBKVX2olLPE9u9gkLP3
         ZBqWZf+qcg4YBN7UL67wqDh/8sl04dzqqF4JLr1ncrAu8PWzMInQbVAWBcvTKPYKirYd
         72XLErsAbs/nnjoMBHn3VHFwA1vqCepEgOWtJEYQwxDPqOZhLKKTIhhkhnAZXRPC+rFJ
         5El+wIz6aph2TT3Ha4I5prm4JINERMOrox+ccqIFpVQDUeGiZ5zId5U7HCQWRQYsZW1S
         fGVNY0S5/27UR0P8ZPy7/Qe9F371NH3InLStPdFkWc6uO5fOR9T+OhTZeaWX4xYm4sZ5
         qPgQ==
X-Gm-Message-State: AOJu0Yz2QKDD7XC7KzaPdSjFdNpVsKzDqtqIq5OVnVH69VUMPt2JDSTd
        ZZEPnFY7+CWdmrWJk8YZpqahQg==
X-Google-Smtp-Source: AGHT+IEriUeR3Amtpl0U1j/IWdPGBWZcNP0dPbDNg/M3cJq/yy5X8cAy7YxhVmrIlfkD8JFMWZQvYg==
X-Received: by 2002:a7b:c857:0:b0:40b:35f2:3b42 with SMTP id c23-20020a7bc857000000b0040b35f23b42mr3286516wml.22.1700865000755;
        Fri, 24 Nov 2023 14:30:00 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d56c5000000b00332cbd59f8bsm5274213wrw.25.2023.11.24.14.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 14:30:00 -0800 (PST)
Date:   Fri, 24 Nov 2023 22:29:58 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH V2] media: stk1160: Fixed high volume of stk1160_dbg
 messages
Message-ID: <ZWEj5sDUs83qn0pc@equinox>
References: <20231122161304.12434-1-ghanshyam1898@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122161304.12434-1-ghanshyam1898@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:43:04PM +0530, Ghanshyam Agrawal wrote:
> The function stk1160_dbg gets called too many times, which causes
> the output to get flooded with messages. Since stk1160_dbg uses
> printk, it is now replaced with dev_warn_ratelimited.
> 
> Suggested-by: Phillip Potter <phil@philpotter.co.uk>
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> ---
> v2:
> Thanks for your suggestions Phillip. I have updated the TODO comment and 
> used dev_warn_ratelimited for inclusion of kernel warning.
> 
>  drivers/media/usb/stk1160/stk1160-video.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c

Hi Ghanshyam,

Thank you for the patch, but it is sadly incorrect.

You have created this V2 against a tree including the V1 version of your
patch. A V2 patch should apply cleanly against the source tree, with no
previous version first needing to be applied.

On another note, why are you using dev_warn_ratelimited here, and if
there's a good reason, why not use it for the other callsites in this
function? (Genuine question here, I've not studied the difference).

Please create a V3, many thanks.

Nacked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil

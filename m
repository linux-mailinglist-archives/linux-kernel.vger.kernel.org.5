Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683EE81347C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573686AbjLNPTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjLNPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:19:00 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB09121;
        Thu, 14 Dec 2023 07:19:07 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ce94f62806so4727308b3a.1;
        Thu, 14 Dec 2023 07:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702567147; x=1703171947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aC0Vwy99mfVjbtuk8/GEuj53wgtxvnchwsBrLMjXyKY=;
        b=cf9E8AhX0zA0azW9BBxszMMFQJGctV/Nqrp065u/TvimU/93s9+yi9aW3L2HVq4yDV
         mDct23K57xBKChp88GsNRWu5Or4gpYV8ilFKokkVv/sTCcA46ll+sSZ80yXzJbdwLi3i
         iX0K2YE3MaP7iyo1JChvMNlFsV97q6RKnt2TV2yxgghxmMmKc0QBOALsoLhE/8nu+2gF
         GLVW0nUfQ2aJMpJ1P5oRrDFmV+fQA+Zx1zPCVCIWCqdTP8dKJdea71iI/t0R7J3Zxkqo
         TxQMn2ZE46FNLEbnXNw5dWYQcDl4YWPNL2+oCO1DzvHeetGyNsvrAs0VEjz1qLkBGekS
         QwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567147; x=1703171947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aC0Vwy99mfVjbtuk8/GEuj53wgtxvnchwsBrLMjXyKY=;
        b=oP5ugUQ6Q6GRbgs00/a7OBdLi1c+X+zKmNtFwcI3beonDWbjmRi85Wl0iQ1aoYTXSK
         hcoOM4ijqYYUFL8ByFgOZf0kbHmONTU6BqPyOiqGyLCScZZEp9PuyAEdUYmOxJOou0KG
         HUlNkJmybAuXqmy0mGsrpLThOfa4/c7SDBkYB8cA3t4hCL2vl62Nhr3xdxBwbfWr/WoD
         /C9w7hjB2y0wv+Y9uzLqy/wSpWvo3j41Dh0d8vHIOROs5SpFgG/FXPsIYXIDy4KLjYCj
         GptP8y+fJTXEr59qF/oeYEwBlH5SnwOC+IZFezVLCrCl2ULYTXI9xi3Qo5TAuNl2vzCe
         ezAA==
X-Gm-Message-State: AOJu0YwyanPCT/BihyTY54DfFKYAVyGavrzUY8PQrfYQzmEQKTfhDKeT
        2n2O8Q5Fk4drCM0uY1x/D98KSkgdLes=
X-Google-Smtp-Source: AGHT+IGxbdiuE29KVCRPGtPOPJ/gAvGyhdrkgxzuDrXqPBjzSNN7iji0W+WboUMVBQ1O3wofqzTSFw==
X-Received: by 2002:a05:6a00:1487:b0:6ce:3584:b634 with SMTP id v7-20020a056a00148700b006ce3584b634mr6366823pfu.48.1702567146683;
        Thu, 14 Dec 2023 07:19:06 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id u10-20020a62d44a000000b006cde1cef719sm12288678pfl.152.2023.12.14.07.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:19:06 -0800 (PST)
Date:   Thu, 14 Dec 2023 23:19:01 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH v2 4/5] gpiolib: cdev: reduce locking in
 gpio_desc_to_lineinfo()
Message-ID: <ZXsc5T1G5Y28lVqw@rigel>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-5-warthog618@gmail.com>
 <ZXsa39xneH6Rh7Gd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsa39xneH6Rh7Gd@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 05:10:23PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 14, 2023 at 05:58:13PM +0800, Kent Gibson wrote:
> > Reduce the time holding the gpio_lock by snapshotting the desc flags,
> > rather than testing them individually while holding the lock.
> >
> > Accept that the calculation of the used field is inherently racy, and
> > only check the availability of the line from pinctrl if other checks
> > pass, so avoiding the check for lines that are otherwise in use.
>
> ...
>
> > -	spin_lock_irqsave(&gpio_lock, flags);
>
> Shouldn't this be covered by patch 1 (I mean conversion to scoped_guard()
> instead of spinlock)?
>

Read the cover letter.
Doing that made the change larger, as flags gets removed then restored.
I had also thought the flag tests would get indented then unindented, but
if we use guard() the indentation should remain unchanged.

Can do it in 1 if you are happy with the flags declaration being
removed in patch 1 and restored in 4.

Cheers,
Kent.



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C147801C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356137AbjHQXki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356142AbjHQXk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:40:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A7B30E9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:40:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf1935f6c2so2570365ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692315626; x=1692920426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VCakgqASg3h9183qTuhRoaN+EGRR2UwJM9N77vDLR8=;
        b=JImyrb2e/StN5NZPwiXTxfSJ8H055CDGNgN8XmqgLAwHdgHkLjLl8nifuytazbaktR
         KVHi6Mjmxj4tA1TCxWnCf+IZFMrYPeX7quUzVyy4S0WUMnz967Gnwbu61lexaYJ4BJnm
         JJQfrx1t/if1DjKRFaShzkrdejZxfqgN7prIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692315626; x=1692920426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VCakgqASg3h9183qTuhRoaN+EGRR2UwJM9N77vDLR8=;
        b=PG0PwZwp5esopRcY3H3+6PMcDGxdFwMWKRiW/Ze5znZv0HFRhDVuOhwB0+t0S3jdn0
         EdSHKRFafF96ek83p1sYaMumky0LSskEjudILN6Uq/LMRo6zBWJufBiuIp6/MFJimXwF
         76+Ur6KgRgn0+5YB9IiElpbbiUuzD/sZWB78cVTJTsfBnz8PVfPQFe9PIePnNnr68XoH
         gXv7SrTA6o3prpvmCqY6iPbSmvyzYTtzXvosO4/fjhLtoVIpolSr83gUghlMe/Wx05mx
         yAqxcuOJfjYorTv4wi9XCAVAEvqF5LB8+JCL8Y7VHSBeBxT+YTgbI6f6Fg/fseetEYzH
         /BvQ==
X-Gm-Message-State: AOJu0YxWST5U7XWkAuKlxQxnwn7/0tu4/xiURx6Kglo3/agddqDhC1uh
        c+DEcW8q2zZrGgFW8HW5FGUhs1rBWVSDQGOSotY=
X-Google-Smtp-Source: AGHT+IFPQt+NcgencYztvbHc+KfKgXvjSMi+thjcbfvjb/04TPsE7lu5R6RUGJ6v3UpZfG1jcgsgYQ==
X-Received: by 2002:a17:902:e807:b0:1ba:fe6a:3845 with SMTP id u7-20020a170902e80700b001bafe6a3845mr966877plg.11.1692315625977;
        Thu, 17 Aug 2023 16:40:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001afd821c057sm336599pli.58.2023.08.17.16.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:40:25 -0700 (PDT)
Date:   Thu, 17 Aug 2023 16:40:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yuxiao Zhang <yuxiaozhang@google.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation
Message-ID: <202308171639.B97420B5@keescook>
References: <20230630205358.3601280-1-yuxiaozhang@google.com>
 <20230718202347.3320812-1-yuxiaozhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718202347.3320812-1-yuxiaozhang@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:23:47PM -0700, Yuxiao Zhang wrote:
> Friendly ping, any update on this?

Hi! I finally got a chance to look this over. I added a few more
kvzalloc() uses to generalize this for all records (not just pmsg), and
it's testing well. Here's the resulting commit:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/pstore&id=104fd0b5e948157f8e8ac88a20b46ba8641d4e95

-- 
Kees Cook

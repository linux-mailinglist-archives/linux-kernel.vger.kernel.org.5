Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53B67EA48E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjKMUNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKMUNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:13:33 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0032210DA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:13:29 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6705379b835so29805946d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699906409; x=1700511209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9BzWP9zAYgAo/2P/mFdqyA5ofprRh4egbTK7XzLY14=;
        b=EpB1rzFE6+NBhjholRR/vr/5h/yoMCMk3e/sCfPwX0ZsfyR3UDVX1QqRdDv192w/Hk
         YZzPscF5h5xqna91FigFjT25vwuCW015q6WD/fUREcXzgK7WAALfdUJhvKR7VHKcdP37
         yQo+Blv+Cv2UoOWN45roPKtfsUooDdUhpr0rycnjx+lr69j7IiQpnQQusCqnpkDDyWKC
         bRPkLP5Q9xKw0oLVIzaLSwkFUQT7lppKR5+g+qQrxnd7LAiWCCVfjMY7wosaCPloAfh8
         SStaxopbueijJyJ4IbYZHgCJVlhXN2Oy76oAx8RipqPmpkakzZ6+/XphZAsqaqklCJ6Q
         S2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906409; x=1700511209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9BzWP9zAYgAo/2P/mFdqyA5ofprRh4egbTK7XzLY14=;
        b=aHdnEqlg8HlhXV9pCdvG1kWsO8xY9adOCToamcQMve+d1g8FB8q4sH0SpeQGo+2QKx
         HajwRHGpsiUO8FIqqjhVqP7fKKShOWvsEl/T0/CxRfGOY4108p6pZxHr5RALw4p+RCYO
         aILrqZ7jJzegba11Sg/df5dxRAmUweZzpAFteSMYGM6QRZ0OS2Lv6If/TsSBIehT6f1H
         0WaI8qW8lzUNRtFgUzSEV4Cra5ADRQUgbjqtLnnfZsWJcO0hkl9YmppvsQDuC0cvP3xi
         zXsN5o7IWpIGcTaW2EVSdD7xC4GHmjs/KpBYNKLOeGSPWD5M5EN60QSrJuOg1pik+i1W
         ecRw==
X-Gm-Message-State: AOJu0YwDEJheEN26qcMZM4Nh+8pDSB5586ltI0eK+WH3kIrd/IXS9W1E
        3dMPna9d4cFUAGUGTnIjuYoFd8Jvh9w=
X-Google-Smtp-Source: AGHT+IGhNOU3ZFHI2oSnNjvo0tbFQeaj9sfaqUWQpkEG+xRERrgEWdhQVBWkF3yA5lON4cwa/Ts6eQ==
X-Received: by 2002:a0c:ed34:0:b0:66f:bc3f:bd7 with SMTP id u20-20020a0ced34000000b0066fbc3f0bd7mr292469qvq.27.1699906409118;
        Mon, 13 Nov 2023 12:13:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x15-20020a0ce78f000000b00668eb252523sm2297295qvn.63.2023.11.13.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:13:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Nov 2023 12:13:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.7-rc1
Message-ID: <a00ad0e9-8ce2-4704-bbdc-6b0237e27aa3@roeck-us.net>
References: <CAHk-=whuO0zmuxp_yorYFWdcrALpqjRPhWkmEy+7wcCnnDcPNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whuO0zmuxp_yorYFWdcrALpqjRPhWkmEy+7wcCnnDcPNA@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 04:47:03PM -0800, Linus Torvalds wrote:
> So here we are, two weeks after the merge window opened, and 6.7-rc1
> is out, and the merge window is closed.
> 
> In number of commits, this is the biggest merge window we've ever had,
> with 15.4k non-merge commits. That is quite a bit bigger than the
> previous biggest releases (4.9, 5.8 and 5.13) that all weighted in at
> about 14.2k non-merge commits.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

I don't recall ever getting zero failures (or warning backtraces)
from m tests in any -rc1.

Guenter

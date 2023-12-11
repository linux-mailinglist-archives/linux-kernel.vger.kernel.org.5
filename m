Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F175980BEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 02:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjLKBTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 20:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKBTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 20:19:09 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F324E4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:19:15 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-59064bca27dso2334607eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1702257554; x=1702862354; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGvU7asxA57g0O1jsmUyh3UcuObNds20nZHjcCxr4vQ=;
        b=jCSJEg2ohbVCdgLBWHTXyUU7Jp88la2jwY91060hUMacZbo9GUxVEjDFFKNu8tVAS8
         Gp6HvI+/83Op8FuK6nhpKUslcz++RTr3Qx3hP2MSZgCKCyPYyqvwUuWeDEm+80tQl+Qg
         Vi/iuQD0xwrmRMA3MlzLzkb0l0GVuZIXJV2lZyVzVoSaSM4H/q1Q76OBblchFfWbHtj6
         MH6yRuoLzUcTWef26qQedDZGC067F+iOKenCboS0ertJQLMEtvmPudAkSRU4kaXtP9xZ
         +OMg/9HoCxgTrW+UzIPKrc65P5+Tf6saI1jEztZ0Yp4YkY5nRdM8/aBRbgD1nl0yktwB
         h4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702257554; x=1702862354;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hGvU7asxA57g0O1jsmUyh3UcuObNds20nZHjcCxr4vQ=;
        b=C2OLCbMxoIAmC4k0ax5LEggva77Mv6J1vG+4TURwVwgrMVF4L8hTnm0paLoS7b54+a
         kUqygYqi1jo5kF5I+IOP5C6zc8+eRWavKu7sAmNBG6q0gFDwCHhW1Cpq1G3sk0xNsGgR
         M56/8sTZEjbDPxBkcBWvyjWGcLQzA/YuymQBlbmBAt4NUXO2VGiIgbVoNo1hOQx7sH93
         Bkh02WpI0IWWRmAzKOuhQEpFdpqHEyM2GTROiHeaXB2jGqGDjXNl7F0EhlYyqrI9gx0d
         345Vyo42fNJESZs+TaCg6LKYKwCbBsm9IL2pNiGqZgJyXdBWFbjoAx6y8laoGZBKfhJw
         37Ew==
X-Gm-Message-State: AOJu0YxJrYmRSVYLH0e4NX+YfXf9IViz5pAaDp7yGqmz9iG8IDGKUHrt
        A0enqiJPYCCFbjgBCKYpzJP5ow==
X-Google-Smtp-Source: AGHT+IECW4R6/zUParI62agJ8IEpAm/jjxRxbg6dABbkClG5rlTe4O6+HgK65GXlYKDAr+2RsBFcTw==
X-Received: by 2002:a05:6820:1503:b0:590:92bd:d3e9 with SMTP id ay3-20020a056820150300b0059092bdd3e9mr4013791oob.14.1702257554164;
        Sun, 10 Dec 2023 17:19:14 -0800 (PST)
Received: from ?IPV6:2603:8080:2300:de:29b1:e1a0:8d3c:63c7? (2603-8080-2300-00de-29b1-e1a0-8d3c-63c7.res6.spectrum.com. [2603:8080:2300:de:29b1:e1a0:8d3c:63c7])
        by smtp.gmail.com with ESMTPSA id e196-20020a4a55cd000000b0058d8b0c4bbdsm1668225oob.32.2023.12.10.17.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 17:19:13 -0800 (PST)
Message-ID: <58e78693-82d1-451d-a546-51fb64ef6eb5@vt.edu>
Date:   Sun, 10 Dec 2023 19:19:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
        a.hindborg@samsung.com, aliceryhl@google.com,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bilbao@vt.edu
From:   Carlos Bilbao <bilbao@vt.edu>
Subject: [PATCH 0/1 RESEND] docs: Include simplified link titles in main
 page's index
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: I'm resending because this patch set ended up labeled as Junk/Spam for
me and I suspect it will happen to others.

The general consensus is that the documentation's website main entry point
and its sidebar leave room for improvement.

Something we can easily fix is that there's too much duplicated text.

To that point, consider the titles "The Linux kernel user's and
administrator's guide" and "The Linux kernel user-space API guide." We get
it, it's the Linux kernel. It's assumed that everything listed pertains to
the Linux kernel, given the overarching title, "The Linux Kernel
documentation." Constant repetition of "Linux" and "kernel" (45 times
each), "documentation" (21 times), and "guide" (18 times) are excessive and
affect UX.

I propose simplifying without altering actual document titles, the text
linking to these documents on the main page ("link titles"). For example,
"The Linux kernel user's and administrator's guide" could become "User's
and Administrator's Guide," and "A guide to the Kernel Development Process"
could be "Development Process". This is what my patch does.

I've uploaded screenshots of the website's main entry before and after [1]
and I personally find the simplified version cleaner and more user-friendly.

At some point, we could discuss an automated way to collect and display all
link titles, IMO manually doing it on the main page is a step in the
right direction for now.

Thanks,
Carlos

[1] https://github.com/Zildj1an/linux-kernel-docs-compare/blob/main/comparison.png

Carlos Bilbao (1):
    docs: Include simplified link titles in main page's index

Documentation/index.rst | 50 ++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

